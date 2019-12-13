//========================================================================
//
// CairoFontEngine.h
//
// Copyright 2003 Glyph & Cog, LLC
// Copyright 2004 Red Hat, Inc
//
//========================================================================

//========================================================================
//
// Modified under the Poppler project - http://poppler.freedesktop.org
//
// All changes made under the Poppler project to this file are licensed
// under GPL version 2 or later
//
// Copyright (C) 2005, 2006 Kristian Høgsberg <krh@redhat.com>
// Copyright (C) 2005, 2018, 2019 Albert Astals Cid <aacid@kde.org>
// Copyright (C) 2006, 2007 Jeff Muizelaar <jeff@infidigm.net>
// Copyright (C) 2006, 2010 Carlos Garcia Campos <carlosgc@gnome.org>
// Copyright (C) 2008, 2017 Adrian Johnson <ajohnson@redneon.com>
// Copyright (C) 2013 Thomas Freitag <Thomas.Freitag@alfa.de>
// Copyright (C) 2018 Adam Reichold <adam.reichold@t-online.de>
//
// To see a description of the changes please see the Changelog file that
// came with your tarball or type make ChangeLog if you are building from git
//
//========================================================================

#ifndef CAIROFONTENGINE_H
#define CAIROFONTENGINE_H

#include <mutex>

#include "poppler-config.h"
#include <cairo-ft.h>

#include "GfxFont.h"
#include "PDFDoc.h"

class CairoFontEngine;

class CairoFont {
public:
  CairoFont(Ref ref,
	    cairo_font_face_t *face,
	    int *codeToGID,
	    unsigned int codeToGIDLen,
	    bool substitute,
	    bool printing);
  virtual ~CairoFont();
  CairoFont(const CairoFont &) = delete;
  CairoFont& operator=(const CairoFont &other) = delete;

  virtual bool matches(Ref &other, bool printing);
  cairo_font_face_t *getFontFace(void);
  unsigned long getGlyph(CharCode code, const Unicode *u, int uLen);
  double getSubstitutionCorrection(GfxFont *gfxFont);

  bool isSubstitute() { return substitute; }
protected:
  Ref ref;
  cairo_font_face_t *cairo_font_face;

  int *codeToGID;
  unsigned int codeToGIDLen;

  bool substitute;
  bool printing;
};

//------------------------------------------------------------------------

class CairoFreeTypeFont : public CairoFont {
public:
  static CairoFreeTypeFont *create(GfxFont *gfxFont, XRef *xref, FT_Library lib, bool useCIDs);
  ~CairoFreeTypeFont();

private:
  CairoFreeTypeFont(Ref ref, cairo_font_face_t *cairo_font_face,
	    int *codeToGID, unsigned int codeToGIDLen, bool substitute);
};

//------------------------------------------------------------------------

class CairoType3Font : public CairoFont {
public:
  static CairoType3Font *create(GfxFont *gfxFont, PDFDoc *doc,
				CairoFontEngine *fontEngine,
				bool printing, XRef *xref);
  ~CairoType3Font();

  bool matches(Ref &other, bool printing) override;

private:
  CairoType3Font(Ref ref,
		 cairo_font_face_t *cairo_font_face,
		 int *codeToGID, unsigned int codeToGIDLen,
		 bool printing, XRef *xref);
};

//------------------------------------------------------------------------

#define cairoFontCacheSize 64

//------------------------------------------------------------------------
// CairoFontEngine
//------------------------------------------------------------------------

class CairoFontEngine {
public:

  // Create a font engine.
  CairoFontEngine(FT_Library libA);
  ~CairoFontEngine();
  CairoFontEngine(const CairoFontEngine &) = delete;
  CairoFontEngine& operator=(const CairoFontEngine &other) = delete;

  CairoFont *getFont(GfxFont *gfxFont, PDFDoc *doc, bool printing, XRef *xref);

private:
  CairoFont *fontCache[cairoFontCacheSize];
  FT_Library lib;
  bool useCIDs;
  mutable std::recursive_mutex mutex;
};

#endif
