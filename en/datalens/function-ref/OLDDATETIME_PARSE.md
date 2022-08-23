---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/OLDDATETIME_PARSE.md
---

# OLDDATETIME_PARSE



#### Syntax {#syntax}


```
OLDDATETIME_PARSE( value )
```

#### Description {#description}
Converts the `value` expression to deprecated date and time format. Unlike [OLDDATETIME](OLDDATETIME.md), it supports multiple formats.

**Argument types:**
- `value` — `String`


**Return type**: `Datetime (deprecated)`

#### Examples {#examples}

```
OLDDATETIME_PARSE("2019-01-02 03:04:05") = #2019-01-02 03:04:05#
```

```
OLDDATETIME_PARSE("20190102030405") = #2019-01-02 03:04:05#
```

```
OLDDATETIME_PARSE("20190102 030405") = #2019-01-02 03:04:05#
```

```
OLDDATETIME_PARSE("2019.01.02 03:04:05") = #2019-01-02 03:04:05#
```

```
OLDDATETIME_PARSE("02/01/2019 03:04:05") = #2019-01-02 03:04:05#
```

```
OLDDATETIME_PARSE("2019-01-02 03:04") = #2019-01-02 03:04:00#
```

```
OLDDATETIME_PARSE("2019-01-02 030405") = #2019-01-02 03:04:05#
```

```
OLDDATETIME_PARSE("2019 Jan 02 03:04:05") = #2019-01-02 03:04:05#
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`.
