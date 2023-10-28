#ifndef COMMON_MODULE_H
#define COMMON_MODULE_H

#include <stdio.h>

void report_error(const char *error_message);
FILE *open_file(const char *filename, const char *mode);
void close_file(FILE *file);

#endif
