#!/bin/bash

# Функция для проверки вывода s21_grep
assert_output() {
    expected="$1"
    input="$2"
    output="$(./s21_grep $input)"
    if [ "$output" = "$expected" ]; then
        echo "PASSED: $input"
    else
        echo "FAILED: $input"
        echo "Expected: $expected"
        echo "Actual: $output"
    fi
}

# Тест 1: Поиск совпадений в файле
assert_output "Hello, World!" "Hello, World! test_files/grep_test.txt"

# Тест 2: Инвертированный поиск
assert_output "This is a line without a match." "-v Hello test_files/grep_test.txt"

# Тест 3: Подсчет числа совпадений
assert_output "3:test_files/grep_test.txt" "-c World test_files/grep_test.txt"

# Тест 4: Вывод только имен файлов
assert_output "test_files/grep_test.txt" "-l World test_files/grep_test.txt"

# Тест 5: Поиск с регистронезависимостью
assert_output "hello, world!" "-i Hello test_files/grep_test.txt"

# Дополнительные тесты могут быть добавлены по аналогии с вышеприведенными

echo "Testing complete"
