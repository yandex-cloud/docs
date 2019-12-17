---
editable: false
---

# SPLIT

_Строковые функции_

#### Синтаксис


```
SPLIT( orig_string, delimiter, part_index )
```

#### Описание
Возвращает подстроку из `orig_string`, используя символ разделителя `delimiter` для разделения строки на последовательность частей `part_index`.

**Типы аргументов:**
- `orig_string` — `Строка`
- `delimiter` — `Строка`
- `part_index` — `Целое число`


**Возвращаемый тип**: `Строка`

{% note info %}

Значения аргументов (delimiter) должны быть константами.

{% endnote %}


#### Примеры

```
SPLIT("RU-MOW-SVO", "-", 1) = "RU"
```

```
SPLIT("RU-MOW-SVO", "-", -1) = "SVO"
```


#### Поддержка источников данных

`Материализованный датасет`, `ClickHouse 1.1`, `MySQL 5.6`, `PostgreSQL 9.3`.
