# Компилятор и флаги компиляции
CC = gcc
CFLAGS = -std=c11 -Wall -Wextra -Werror -pedantic -g -I. -D_POSIX_C_SOURCE=200809L

# Имена исполняемых файлов
CAT_EXECUTABLE = s21_cat
GREP_EXECUTABLE = s21_grep

# Исходные файлы
CAT_SOURCE = ./cat/cat.c ./common/common_module.c
GREP_SOURCE = ./grep/grep.c ./common/common_module.c

# Правило по умолчанию: собрать оба исполняемых файла
all: $(CAT_EXECUTABLE) $(GREP_EXECUTABLE)

# Правило для сборки s21_cat
$(CAT_EXECUTABLE): $(CAT_SOURCE)
	$(CC) $(CFLAGS) -o $(CAT_EXECUTABLE) $(CAT_SOURCE)

# Правило для сборки s21_grep
$(GREP_EXECUTABLE): $(GREP_SOURCE)
	$(CC) $(CFLAGS) -o $(GREP_EXECUTABLE) $(GREP_SOURCE)

# Интеграционное тестирование s21_cat
test_cat:
	bash src/integration_tests/test_cat.sh

# Интеграционное тестирование s21_grep
test_grep:
	bash src/integration_tests/test_grep.sh

# Общее интеграционное тестирование
test: test_cat test_grep

# Очистка сгенерированных файлов
clean:
	rm -f $(CAT_EXECUTABLE) $(GREP_EXECUTABLE)

.PHONY: all test_cat test_grep test clean
