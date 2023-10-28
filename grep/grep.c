#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <regex.h>
#include "../common/common_module.h"
#include "grep.h"


// Функция для поиска совпадений с регулярным выражением
void search_and_print(const char *filename, const char *pattern, int case_insensitive, int invert_match, int count_lines, int list_files) {
    FILE *file;
    if (filename == NULL) {
        file = stdin;
    } else {
        file = open_file(filename, "r");
    }

    regex_t regex;
    int regex_flags = REG_EXTENDED;
    if (case_insensitive) {
        regex_flags |= REG_ICASE;
    }

    if (regcomp(&regex, pattern, regex_flags) != 0) {
        report_error("Error compiling regular expression");
    }

    char *line = NULL;
    size_t len = 0;
    int line_number = 0;
    int match_count = 0;

    while (getline(&line, &len, file) != -1) {
        line_number++;

        int match = regexec(&regex, line, 0, NULL, 0) == 0;

        if (invert_match) {
            match = !match;
        }

        if (match) {
            if (list_files) {
                printf("%s\n", filename);
                break;
            }

            if (count_lines) {
                match_count++;
            } else {
                printf("%s:%d:%s", filename, line_number, line);
            }
        }
    }

    if (count_lines && match_count > 0) {
        printf("%s:%d\n", filename, match_count);
    }

    regfree(&regex);
    free(line);

    if (filename != NULL) {
        close_file(file);
    }
}

int main(int argc, char *argv[]) {
    if (argc < 3) {
        fprintf(stderr, "Usage: %s [-i] [-v] [-c] [-l] [-n] pattern [file1] [file2] ...\n", argv[0]);
        return 1;
    }

    int case_insensitive = 0;
    int invert_match = 0;
    int count_lines = 0;
    int list_files = 0;
    int arg_start = 1;

    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "-i") == 0) {
            case_insensitive = 1;
        } else if (strcmp(argv[i], "-v") == 0) {
            invert_match = 1;
        } else if (strcmp(argv[i], "-c") == 0) {
            count_lines = 1;
        } else if (strcmp(argv[i], "-l") == 0) {
            list_files = 1;
        } else if (strcmp(argv[i], "-n") == 0) {
            count_lines = 1;
        } else {
            arg_start = i;
            break;
        }
    }

    const char *pattern = argv[arg_start];

    if (arg_start < argc - 1) {
        for (int i = arg_start + 1; i < argc; i++) {
            search_and_print(argv[i], pattern, case_insensitive, invert_match, count_lines, list_files);
        }
    } else {
        search_and_print(NULL, pattern, case_insensitive, invert_match, count_lines, list_files);
    }

    return 0;
}
