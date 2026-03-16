---
title: Справочник KQL в {{ ycdr-full-name }}
description: Справочник функций и операторов KQL в {{ ycdr-name }}.
---

# Справочник KQL

{% include [preview-by-request](../_includes/note-preview-by-request.md) %}

В этом разделе представлен справочник по подмножеству [KQL (Kusto Query Language)](https://learn.microsoft.com/en-us/kusto/), используемому в {{ ycdr-full-name }}.

## Системные таблицы {#system-tables}

В {{ ycdr-name }} доступны следующие системные таблицы:

* **Events** — нормализованные события в базе или потоке.
* **EVENT_CLASS** — названия классов событий, указанные в классификаторе, с соответствующей фильтрацией полей.

## Операторы выражений в запросе {#expression-operators}

### Set {#set-operator}

Оператор `set` позволяет задать параметры запроса.

```sql
set rule_name = "SomeRuleName";
set window_step = 35m;
set runtime = "database";
```

**Поддерживаемые параметры:**

#|
|| Параметр | Тип | Описание ||
|| `rule_name` | строка | Название правила, используется при запуске через расследование ||
|| `window_step` | интервал | Временной сдвиг для периодических запусков через расследование ||
|| `runtime` | строка | Тип запуска по базе: `database` ||
|#

### Let {#let-operator}

Оператор `let` позволяет создавать табличные переменные.

```sql
let someTable = ATiamDetectLeakedCredential | limit 10;
```

## Табличные операторы {#pipeline-operators}

### Where {#where-operator}

Оператор `where` фильтрует данные по условию.

```sql
where at_iam_subject_name !contains "test"
where region != "" and 1 != 4 + 2 or x == y
```

### Lookup {#lookup-operator}

Оператор `lookup` выполняет объединение таблиц. Поддерживается только `left outer join`.

```sql
lookup (
    abc.quotas | project lookup_c_group, lookup_srv, limits_list
) on $left.service.service_id == $right.lookup_srv,
   $left.c_group == $right.lookup_c_group
```

**Ограничение:** при обогащении необходимо указывать нужные поля внешней таблицы через `project`.

### Summarize {#summarize-operator}

Оператор `summarize` выполняет агрегацию данных.

```sql
summarize cnt = count(),
            uniq_subjects = dcount(at_iam_subject_id),
            last_event = max(time),
            first_event = min(time),
            sum_logon_type = sum(user_logon_type),
            avg_logon_type = avg(user_logon_type),
            p95_logon_type = percentile(user_logon_type, 95)
by region, bin(time, 1d)
```

**Ограничения:**
* Не поддерживаются названия полей по умолчанию (`count_` и т.д.) — их нужно указывать явно.
* Ограничен список агрегирующих функций.

### Extend {#extend-operator}

Оператор `extend` добавляет вычисляемые столбцы.

```sql
extend use = extract("user=(^ ]+)\s+ip=(?<ip>[0-9.]+)", 1, Message),
          a = 5, b = c
```

### Mv-expand {#mv-expand-operator}

Оператор `mv-expand` раскрывает массивы в отдельные строки.

```sql
mv-expand grant = grants
```

**Ограничение:** поддерживается только `kind = bag` и раскрытие только одной колонки.

### Project {#project-operator}

Оператор `project` выбирает и переименовывает столбцы.

```sql
| project event_class = "Alert", time, foundHostid = hostid
```

### Top и Sort {#top-sort-operators}

Операторы `top` и `sort` сортируют и ограничивают результат.

```sql
sort by field desc
top 5 by anotherField
```

### Limit {#limit-operator}

Оператор `limit` ограничивает количество строк.

```sql
limit 10000
```

## Условия оператора where {#where-conditions}

### Логические операторы {#logical-operators}

#|
|| Оператор | Описание ||
|| `and` | Логическое И ||
|| `or` | Логическое ИЛИ ||
|| `not` | Логическое НЕ ||
|| `()` | Группировка условий ||
|#

```sql
not (ivan >= 1337 or lesha <= 1337)
```

### Операторы сравнения {#comparison-operators}

#|
|| Оператор | Описание ||
|| `==` | Равенство ||
|| `!=` | Неравенство ||
|| `>`, `<` | Сравнение чисел и временных значений ||
|| `>=`, `<=` | Сравнение с включением границ ||
|#

### Операторы вхождения {#inclusion-operators}

#|
|| Оператор | Описание ||
|| `between` / `!between` | Проверка вхождения в интервал ||
|| `in` / `!in` | Проверка вхождения в список ||
|| `has_any` / `!has` | Проверка наличия любого из слов ||
|| `contains` / `!contains` | Проверка наличия подстроки (регистронезависимо) ||
|| `matches regex` | Проверка соответствия регулярному выражению ||
|#

```sql
time between (ago(60m) .. now())
age in (18, 19, 20)
array.obj has_any ('tesla', 'bmw')
field contains "substring"
file_category@object matches regex "app\.compute\..*"
```

## Функции {#functions}

### Функции преобразования типов {#type-conversion-functions}

#|
|| Функция | Описание ||
|| `tostring()` | Конвертирует в строку ||
|| `toint()` | Конвертирует в целочисленное значение ||
|| `todouble()` / `toreal()` | Конвертирует в нецелочисленное значение ||
|| `todatetime()` | Конвертирует строку в дату и время ||
|| `parse_json()` | Парсит строку в JSON ||
|#

### Функции извлечения {#extraction-functions}

#|
|| Функция | Описание ||
|| `extract()` | Извлекает группу регулярного выражения из строки ||
|| `external_table()` | Позволяет обращаться к внешней таблице ||
|#

### Функции времени {#time-functions}

#|
|| Функция | Описание ||
|| `now()` | Возвращает текущее время ||
|| `ago(1h)` | Возвращает время в прошлом ||
|#

### Прочие функции {#other-functions}

#|
|| Функция | Описание ||
|| `isnull()` / `isnotnull()` | Проверка на null ||
|| `bag_pack_columns()` | Создает dynamic (JSON) с полями из указанных колонок ||
|| `case()` | Выбор значения в зависимости от условия ||
|#

```sql
case([predicate, valueIfTrue]+, defaultValue)
```

## Агрегатные функции для summarize {#aggregate-functions}

#|
|| Функция | Описание ||
|| `count()` | Подсчитывает общее количество строк ||
|| `count_distinct()` | Подсчитывает количество уникальных значений ||
|| `avg()` | Вычисляет среднее значение ||
|| `max()` | Возвращает максимальное значение ||
|| `min()` | Возвращает минимальное значение ||
|| `percentile()` | Возвращает значение на заданном процентиле ||
|| `sum()` | Суммирует значения ||
|| `dcount()` | Подсчитывает количество уникальных значений ||
|| `bin()` | Группирует по временным окнам ||
|#
