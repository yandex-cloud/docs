---
editable: false
---

# GENERICDATETIME_PARSE



#### Syntax {#syntax}


```
GENERICDATETIME_PARSE( value )
```

#### Description {#description}
Converts the `value` expression to date and time format. Unlike [GENERICDATETIME](GENERICDATETIME.md), it supports multiple formats.

**Argument types:**
- `value` — `String`


**Return type**: `Datetime`

#### Examples {#examples}

```
GENERICDATETIME_PARSE("2019-01-02 03:04:05") = ##2019-01-02 03:04:05##
```

```
GENERICDATETIME_PARSE("20190102030405") = ##2019-01-02 03:04:05##
```

```
GENERICDATETIME_PARSE("20190102 030405") = ##2019-01-02 03:04:05##
```

```
GENERICDATETIME_PARSE("2019.01.02 03:04:05") = ##2019-01-02 03:04:05##
```

```
GENERICDATETIME_PARSE("02/01/2019 03:04:05") = ##2019-01-02 03:04:05##
```

```
GENERICDATETIME_PARSE("2019-01-02 03:04") = ##2019-01-02 03:04:00##
```

```
GENERICDATETIME_PARSE("2019-01-02 030405") = ##2019-01-02 03:04:05##
```

```
GENERICDATETIME_PARSE("2019 Jan 02 03:04:05") = ##2019-01-02 03:04:05##
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`.
