#!/bin/bash

# Функция для проверки вывода s21_cat
assert_output() {
    expected="$1"
    input="$2"
    output="$(./s21_cat $input)"
    if [ "$output" = "$expected" ]; then
        echo "PASSED: $input"
    else
        echo "FAILED: $input"
        echo "Expected: $expected"
        echo "Actual: $output"
    fi
}

# Тест 1: Проверка вывода одного файла
assert_output "Hello, World!" "test_files/file1.txt"

# Тест 2: Проверка вывода нескольких файлов
assert_output "Hello, " "test_files/file1.txt test_files/file2.txt"

# Тест 3: Проверка вывода пустого файла
assert_output "" "test_files/empty.txt"

# Тест 4: Проверка вывода несуществующего файла
assert_output "s21_cat: Error opening file\n" "nonexistent_file.txt"

# Дополнительные тесты могут быть добавлены по аналогии с вышеприведенными

echo "Testing complete"
