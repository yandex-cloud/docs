---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/SPLIT.md
---

# SPLIT



#### Синтаксис {#syntax}


```
SPLIT( orig_string [ , delimiter [ , part_index ] ] )
```

#### Описание {#description}
Возвращает подстроку из `orig_string`, используя символ разделителя `delimiter` для разделения строки на последовательность частей `part_index`. Разделитель по умолчанию – запятая. Если не передан `part_index`, то возвращается массив (только для источников `ClickHouse`, `PostgreSQL`).

**Типы аргументов:**
- `orig_string` — `Строка`
- `delimiter` — `Строка`
- `part_index` — `Целое число`


**Возвращаемый тип**: Зависит от типов аргументов

{% note info %}

Значения аргументов (`delimiter`) должны быть константами.

{% endnote %}


#### Примеры {#examples}

```
SPLIT("192.168.0.1", ".", 1) = "192"
```

```
SPLIT("192.168.0.1", ".", -1) = "1"
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `MySQL 5.6`, `PostgreSQL 9.3`, `YDB`.
