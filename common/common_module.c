#include "common_module.h"
#include <stdlib.h>
#include <stdio.h>

// Функция вывода ошибки и завершения программы
void report_error(const char *error_message) {
    perror(error_message);
    exit(1);
}

// Функция открытия файла и возврата указателя на файл
FILE *open_file(const char *filename, const char *mode) {
    FILE *file = fopen(filename, mode);
    if (file == NULL) {
        report_error("Error opening file");
    }
    return file;
}

// Функция закрытия файла
void close_file(FILE *file) {
    if (fclose(file) != 0) {
        report_error("Error closing file");
    }
}
