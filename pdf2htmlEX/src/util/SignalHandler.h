#ifndef SIGNAL_HANDLER_H
#define SIGNAL_HANDLER_H

#ifdef __cplusplus
extern "C" {
#endif

void ffwSetAction(const char* anAction);
void ffwClearAction(void);

#ifdef __cplusplus
}
#endif

void setupSignalHandler(
  int argc, const char* argv[],
  const char* data_dir,
  const char* poppler_data_dir,
  const char* tmp_dir);

#endif
