/*
 * SignalHandler.cc
 *
 *  Created on: 2019-Nov-14
 *      Author: Stephen Gaito
 */

/**********

This collection of basic ANSI-C functions implement a crude SIG-SEGV
handler for when things go horribly wrong ;-(

We implement them in as simple a maner as possible so that it will be as
portable as possible and less likely to fall into a reentrant deadlock.

At the moment the most critical SIG-SEGVs are happening inside the
FontForge library. So we start by focusing upon adding more helpful
messages when FontForge can't save a file for us.

**********/


#include <stdio.h>
#include <string.h>
#include <string>
#include <unistd.h>
#include <signal.h>

#include "pdf2htmlEX-config.h"
#include "util/ffw.h"
#include <cairo/cairo.h>
#include <poppler/poppler-config.h>

const char* oopsMessage  =
  "\n"
  "\n"
  "Oops! Something went horribly wrong.... sorry!\n"
  "\n";

const char* ffwMessage_1 =
  "I was in the middle of asking FontForge to ";

const char* ffwMessage_2 =
  " a font.\n"
  "\n"
  "I suspect that the problem is that FontForge is having trouble\n"
  "working with one of the fonts embedded in your pdf file.\n"
  "\n"
  "The best way to verify this is to install FontForge and to try\n"
  "loading and then (re)generating each font in the\n"
  "\n"
  "    ";

const char* ffwMessage_3 =
  "\n"
  "\n"
  "directory. See:\n"
  "\n"
  "    https://github.com/pdf2htmlEX/pdf2htmlEX/wiki/Troubleshooting-Crashes\n"
  "\n"
  "for details.\n"
  "\n"
  "If one of these fonts crashes FontForge, then it is certainly not a\n"
  "pdf2htmlEX problem.... sorry.\n"
  "\n"
  "IF it *is* a FontForge problem then you have the following options:\n"
  "\n"
  "  1) You can send a copy of the font you found which crashed FontForge to\n"
  "     the FontForge developers and see if they can find the problem.\n"
  "     (Be warned FontForge is a complex application, so it might be\n"
  "      very hard for the developers to isolate your problem.... )\n"
  "\n"
  "  2) You can try re-creating your PDF with a different font.\n"
  "\n"
  "  3) Or you can do both of these things...\n"
  "\n"
  "IF you were not able to crash FontForge using the fonts in the above\n"
  "directory... then and only then please raise an issue with the pdf2htmlEX\n"
  "team... make sure you provide them with your pdf, as well as the following\n"
  "details:\n";

const char* noFfwMessage =
  "Please raise an issue with the pdf2hmtlEX team so they can fix this...\n"
  "\n"
  "Please make sure you provide them with your pdf as well as the following\n"
  "details:\n";

const char* detailsHeader =
  "\n"
  "--------------------------------------------------------------------------\n"
  "\n";

const char* detailsBody = "no details recorded\n";

const char* pdf2htmlEXTmpDir = NULL;
const char* ffwAction        = NULL;

struct sigaction act;

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-result" 
void signalHandler(int sigInt) {
  write(STDERR_FILENO, oopsMessage,        strlen(oopsMessage) );

  if (ffwAction) {
    write(STDERR_FILENO, ffwMessage_1,     strlen(ffwMessage_1) );
    write(STDERR_FILENO, ffwAction,        strlen(ffwAction) );
    write(STDERR_FILENO, ffwMessage_2,     strlen(ffwMessage_2) );
    write(STDERR_FILENO, pdf2htmlEXTmpDir, strlen(pdf2htmlEXTmpDir) );
    write(STDERR_FILENO, ffwMessage_3,     strlen(ffwMessage_3) );
  } else {
    write(STDERR_FILENO, noFfwMessage,     strlen(noFfwMessage) );
  }

  write(STDERR_FILENO, detailsHeader,      strlen(detailsHeader) );
  write(STDERR_FILENO, detailsBody,        strlen(detailsBody) );
  exit(-1);

}
#pragma GCC diagnostic pop

#ifdef __cplusplus
extern "C" {
#endif

void ffwSetAction(const char* anAction) {    ffwAction = anAction; }
void ffwClearAction(const char* anAction) {  ffwAction = NULL; }

#ifdef __cplusplus
}
#endif

void setupSignalHandler(
  int argc, const char* argv[],
  const char* data_dir,
  const char* poppler_data_dir,
  const char* tmp_dir) {
  // THIS MUST BE CALLED AFTER ARGUMENT PARSING

  // Start by setting up the messages
  //
  // Construct the command line information
  std::string detailInfo;
  detailInfo = "Command line:\n";
  for (int i = 0 ; i < argc ; i++ ){
    detailInfo = detailInfo + "  " + std::to_string(i) + ": [" + argv[i] + "]\n" ;
  }
  detailInfo = detailInfo + "\n";

  // Construct the version information
  const pdf2htmlEX::FFWVersionInfo* ffwVersionInfo =
    pdf2htmlEX::ffw_get_version_info();

  detailInfo = detailInfo + "Version information:\n";
  detailInfo = detailInfo + "  pdf2htmlEX version " + pdf2htmlEX::PDF2HTMLEX_VERSION + "\n";
  detailInfo = detailInfo + "  Copyright 2012-2015 Lu Wang <coolwanglu@gmail.com> and other contributors\n";
  detailInfo = detailInfo + "\n";
  detailInfo = detailInfo + "Libraries:\n" ;
  detailInfo = detailInfo + "  poppler " + POPPLER_VERSION + "\n";
  detailInfo = detailInfo + "  libfontforge (date) " + ffwVersionInfo->versionDate + "\n";
#if ENABLE_SVG
  detailInfo = detailInfo + "  cairo " + cairo_version_string() + "\n";
#endif
  detailInfo = detailInfo + "\n";
  detailInfo = detailInfo + "Default data-dir: " + data_dir + "\n";
  detailInfo = detailInfo + "Default poppler-data-dir: " + poppler_data_dir + "\n";
  detailInfo = detailInfo + "Default tmp-dir: " + tmp_dir + "\n";
  detailInfo = detailInfo + "\n";
  detailInfo = detailInfo + "Supported image formats:";
#ifdef ENABLE_LIBPNG
  detailInfo = detailInfo + " png";
#endif
#ifdef ENABLE_LIBJPEG
  detailInfo = detailInfo + " jpg";
#endif
#if ENABLE_SVG
  detailInfo = detailInfo + " svg";
#endif
  detailInfo = detailInfo + "\n\n";

  detailsBody = strdup(detailInfo.c_str());

  pdf2htmlEXTmpDir = strdup(tmp_dir);

  // Now setup the signal handler
  //
  memset(&act, 0, sizeof(act));
  act.sa_handler = signalHandler;
  //
  sigaction(SIGILL,  &act, NULL);  // Illegal Instruction
  sigaction(SIGFPE,  &act, NULL);  // Floating-point exception
  sigaction(SIGSEGV, &act, NULL);  // Invalid memory reference
  sigaction(SIGBUS,  &act, NULL);  // Bus error (bad memory access)
  sigaction(SIGSYS,  &act, NULL);  // Bad system call (SVr4)

  // All done
}


/***
int main(int argc, const char* argv[]) {

  setupSignalHandler(argc, argv, "aTmpDir");

  ffwSetAction("save");

  for (int i = 0; i < 5; i++) {
    printf("sleeping.... \n");
    sleep(1);
  }

  int *foo = NULL;

  *foo = 1;

  printf("We should not reach here!\n");

}
***/
