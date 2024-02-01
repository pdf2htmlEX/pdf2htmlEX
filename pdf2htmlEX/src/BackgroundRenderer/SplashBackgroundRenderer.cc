/*
 * SplashBackgroundRenderer.cc
 *
 * Copyright (C) 2012,2013 Lu Wang <coolwanglu@gmail.com>
 */

#include <fstream>

#include <poppler-config.h>
#include <splash/SplashErrorCodes.h>

#include "Base64Stream.h"
#include "SplashBackgroundRenderer.h"

namespace pdf2htmlEX {

using std::string;
using std::ifstream;

const SplashColor SplashBackgroundRenderer::white = {255,255,255};

SplashBackgroundRenderer::SplashBackgroundRenderer(const string & imgFormat, HTMLRenderer * html_renderer, const Param & param)
    : SplashOutputDev(splashModeRGB8, 4, false, (SplashColorPtr)(&white), true, splashThinLineSolid) // DCRH: Make thin line mode = solid
    , html_renderer(html_renderer)
    , param(param)
    , format(imgFormat)
{
    bool supported = false;
// ENABLE_LIBPNG and ENABLE_LIBJPEG are defines coming in from poppler-config.h
#ifdef ENABLE_LIBPNG
    if (format.empty())
        format = "png";
    supported = supported || format == "png";
#endif
#ifdef ENABLE_LIBJPEG
    if (format.empty())
        format = "jpg";
    supported = supported || format == "jpg";
#endif
    if (!supported)
    {
        throw string("Image format not supported by Poppler: ") + format;
    }
}

/*
 * SplashOutputDev::startPage would paint the whole page with the background color
 * And thus have modified region set to the whole page area
 * We do not want that.
 */
void SplashBackgroundRenderer::startPage(int pageNum, GfxState *state, XRef *xrefA)
{
    SplashOutputDev::startPage(pageNum, state, xrefA);
}

void SplashBackgroundRenderer::drawChar(GfxState *state, double x, double y,
  double dx, double dy,
  double originX, double originY,
  CharCode code, int nBytes, const Unicode *u, int uLen)
{
    if (param.proof || html_renderer->is_char_covered(drawn_char_count)) {
        SplashOutputDev::drawChar(state,x,y,dx,dy,originX,originY,code,nBytes,u,uLen);
    }
    drawn_char_count++;
}

void SplashBackgroundRenderer::beginTextObject(GfxState *state)
{
    if (param.proof == 2)
        proof_begin_text_object(state, this);
    SplashOutputDev::beginTextObject(state);
}

void SplashBackgroundRenderer::beginString(GfxState *state, const GooString * str)
{
    if (param.proof == 2)
        proof_begin_string(state, this);
    SplashOutputDev::beginString(state, str);
}

void SplashBackgroundRenderer::endTextObject(GfxState *state)
{
    if (param.proof == 2)
        proof_end_text_object(state, this);
    SplashOutputDev::endTextObject(state);
}

void SplashBackgroundRenderer::updateRender(GfxState *state)
{
    if (param.proof == 2)
        proof_update_render(state, this);
    SplashOutputDev::updateRender(state);
}

void SplashBackgroundRenderer::init(PDFDoc * doc)
{
    startDoc(doc);
}

static bool annot_cb(Annot *, void * pflag) {
    return (*((bool*)pflag)) ? true : false;
};

bool SplashBackgroundRenderer::render_page(PDFDoc * doc, int pageno)
{
    drawn_char_count = 0;
    bool process_annotation = param.process_annotation;

    doc->displayPage(this, pageno, param.actual_dpi, param.actual_dpi,
            0, 
            (!(param.use_cropbox)),
            false, false,
            nullptr, nullptr, &annot_cb, &process_annotation);
    return true;
}

void SplashBackgroundRenderer::embed_image(int pageno)
{
	auto * bitmap = getBitmap();
    // dump the background image only when it is not empty
    if(bitmap->getWidth() >= 0 && bitmap->getHeight() >= 0)
    {
        {
            auto fn = html_renderer->str_fmt("%s/bg%x.%s", (param.embed_image ? param.tmp_dir : param.dest_dir).c_str(), pageno, format.c_str());
            if(param.embed_image)
                html_renderer->tmp_files.add((const char *)fn);

            SplashImageFileFormat splashImageFileFormat;
            if(format == "png")
                splashImageFileFormat = splashFormatPng;
            else if(format == "jpg")
                splashImageFileFormat = splashFormatJpeg;
            else
                throw string("Image format not supported: ") + format;

            SplashError e = bitmap->writeImgFile(splashImageFileFormat, (const char *)fn, param.actual_dpi, param.actual_dpi);
            if (e != splashOk)
                throw string("Cannot write background image. SplashErrorCode: ") + std::to_string(e);
        }

        double h_scale = html_renderer->text_zoom_factor() * DEFAULT_DPI / param.actual_dpi;
        double v_scale = html_renderer->text_zoom_factor() * DEFAULT_DPI / param.actual_dpi;

        auto & f_page = *(html_renderer->f_curpage);
        auto & all_manager = html_renderer->all_manager;
        
        f_page << "<img class=\"" << CSS::BACKGROUND_IMAGE_CN 
            << " " << CSS::LEFT_CN      << all_manager.left.install(0.0L)
            << " " << CSS::BOTTOM_CN    << all_manager.bottom.install(0.0L)
            << " " << CSS::WIDTH_CN     << all_manager.width.install(h_scale * bitmap->getWidth())
            << " " << CSS::HEIGHT_CN    << all_manager.height.install(v_scale * bitmap->getHeight())
            << "\" alt=\"\" src=\"";

        if(param.embed_image)
        {
            auto path = html_renderer->str_fmt("%s/bg%x.%s", param.tmp_dir.c_str(), pageno, format.c_str());
            ifstream fin((char*)path, ifstream::binary);
            if(!fin)
                throw string("Cannot read background image ") + (char*)path;

            auto iter = FORMAT_MIME_TYPE_MAP.find(format);
            if(iter == FORMAT_MIME_TYPE_MAP.end())
                throw string("Image format not supported: ") + format;

            string mime_type = iter->second;
            f_page << "data:" << mime_type << ";base64," << Base64Stream(fin);
        }
        else
        {
            f_page << (char*)html_renderer->str_fmt("bg%x.%s", pageno, format.c_str());
        }
        f_page << "\"/>";
    }
}

} // namespace pdf2htmlEX
