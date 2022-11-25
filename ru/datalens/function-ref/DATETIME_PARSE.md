---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/DATETIME_PARSE.md
---

# DATETIME_PARSE



#### Синтаксис {#syntax}


```
DATETIME_PARSE( value )
```

#### Описание {#description}
Переводит выражение `value` в формат даты и времени. В отличие от [DATETIME](DATETIME.md), поддерживает множество форматов.

**Типы аргументов:**
- `value` — `Строка`


**Возвращаемый тип**: `Дата и время`

#### Примеры {#examples}

```
DATETIME_PARSE("2019-01-02 03:04:05") = #2019-01-02 03:04:05#
```

```
DATETIME_PARSE("20190102030405") = #2019-01-02 03:04:05#
```

```
DATETIME_PARSE("20190102 030405") = #2019-01-02 03:04:05#
```

```
DATETIME_PARSE("2019.01.02 03:04:05") = #2019-01-02 03:04:05#
```

```
DATETIME_PARSE("02/01/2019 03:04:05") = #2019-01-02 03:04:05#
```

```
DATETIME_PARSE("2019-01-02 03:04") = #2019-01-02 03:04:00#
```

```
DATETIME_PARSE("2019-01-02 030405") = #2019-01-02 03:04:05#
```

```
DATETIME_PARSE("2019 Jan 02 03:04:05") = #2019-01-02 03:04:05#
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`.
