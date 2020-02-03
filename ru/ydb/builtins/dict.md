# Функции для работы со словарями

## DictItems {#dictitems}

Получения содержимого словаря в виде списка кортежей с парами ключ-значение.

**Примеры:**
```sql
SELECT DictItems(dict_column)
FROM my_table;
```

## DictKeys {#dictkeys}

Получения списка ключей словаря.

**Примеры:**
```sql
SELECT DictKeys(dict_column)
FROM my_table;
```

## DictPayloads {#dictpayloads}

Получения списка значений словаря.

**Примеры:**
```sql
SELECT DictPayloads(dict_column)
FROM my_table;
```

## DictLookup {#dictlookup}

Получение элемента словаря по ключу.

**Примеры:**
```sql
SELECT DictLookup(dict_column, "foo")
FROM my_table;
```

## DictContains {#dictcontains}

Проверка наличия элемента в словаре по ключу. Возвращает true или false.

**Примеры:**
```sql
SELECT DictContains(dict_column, "foo")
FROM my_table;
```