---
editable: false
---

# FIND



#### Syntax {#syntax}


```
FIND( string, substring [ , start_index ] )
```

#### Description {#description}
Returns the index of the position of the first character of the substring `substring` in the string `string`.

If the `start_index` option is specified, the search starts from the specified position.

**Argument types:**
- `string` — `String`
- `substring` — `String`
- `start_index` — `Number (whole)`


**Return type**: `Number (whole)`

#### Examples {#examples}

```
FIND("Lorem ipsum dolor sit amet", "abc") = 0
```

```
FIND("Lorem ipsum dolor sit amet", "or") = 2
```

```
FIND("Lorem ipsum dolor sit amet", "or", 7) = 16
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
