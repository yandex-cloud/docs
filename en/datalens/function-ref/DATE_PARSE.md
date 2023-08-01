---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/DATE_PARSE.md
---

# DATE_PARSE



#### Синтаксис {#syntax}


```
DATE_PARSE( value )
```

#### Описание {#description}
Переводит выражение `value` в формат даты. В отличие от [DATE](DATE.md), поддерживает множество форматов.

**Типы аргументов:**
- `value` — `Строка`


**Возвращаемый тип**: `Дата`

#### Примеры {#examples}

```
DATE_PARSE("2019-01-02 03:04:05") = #2019-01-02#
```

```
DATE_PARSE("2019-01-02") = #2019-01-02#
```

```
DATE_PARSE("20190102") = #2019-01-02#
```

```
DATE_PARSE("2019.01.02") = #2019-01-02#
```

```
DATE_PARSE("02/01/2019") = #2019-01-02#
```

```
DATE_PARSE("02/01/19") = #2019-01-02#
```

```
DATE_PARSE("2019 Jan 02") = #2019-01-02#
```

```
DATE_PARSE("2019 Jan") = #2019-01-01#
```

```
DATE_PARSE("201901") = #2019-01-01#
```

```
DATE_PARSE("2019") = #2019-01-01#
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`.
