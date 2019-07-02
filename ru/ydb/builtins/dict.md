# Функции для работы со словарями

## DictItems

Получения содержимого словаря в виде списка кортежей с парами ключ-значение.

**Примеры:**
``` yql
SELECT DictItems(dict_column)
FROM my_table;
```

## DictKeys

Получения списка ключей словаря.

**Примеры:**
``` yql
SELECT DictKeys(dict_column)
FROM my_table;
```

## DictPayloads

Получения списка значений словаря.

**Примеры:**
``` yql
SELECT DictPayloads(dict_column)
FROM my_table;
```

## DictLookup

Получение элемента словаря по ключу.

**Примеры:**
``` yql
SELECT DictLookup(dict_column, "foo")
FROM my_table;
```

## DictContains

Проверка наличия элемента в словаре по ключу. Возвращает true или false.

**Примеры:**
``` yql
SELECT DictContains(dict_column, "foo")
FROM my_table;
```