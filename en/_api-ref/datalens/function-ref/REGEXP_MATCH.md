---
editable: false
---

# REGEXP_MATCH



#### Syntax {#syntax}


```
REGEXP_MATCH( string, pattern )
```

#### Description {#description}
Returns 'TRUE' if the string `string` has a substring that matches the regular expression pattern `pattern`.

**Argument types:**
- `string` — `String`
- `pattern` — `String`


**Return type**: `Boolean`

{% note info %}

See the documentation of the data source to clarify the regular expression syntax.

{% endnote %}

Use the [ClickHouse](https://github.com/google/re2/wiki/Syntax) syntax to create regular expressions in materialized datasets.



#### Example {#examples}

```
REGEXP_MATCH("RU 912873","\w\s\d") = TRUE
```


#### Data source support {#data-source-support}

`ClickHouse 19.13`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
