---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/DATETIME_PARSE.md
---

# DATETIME_PARSE



#### Syntax {#syntax}


```
DATETIME_PARSE( value )
```

#### Description {#description}
Converts the `value` expression to date and time format. Unlike [DATETIME](DATETIME.md), it supports multiple formats.

**Argument types:**
- `value` — `String`


**Return type**: `Datetime`

#### Examples {#examples}

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


#### Data source support {#data-source-support}

`ClickHouse 19.13`.
