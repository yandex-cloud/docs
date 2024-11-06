---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/REGEXP_MATCH.md
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

See the documentation of the data source to clarify the regular expression syntax. For example, `ClickHouse` uses the [RE2 syntax](https://github.com/google/re2/wiki/Syntax) to compose regular expressions.

{% endnote %}


#### Example {#examples}

```
REGEXP_MATCH("RU 912873","\w\s\d") = TRUE
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Yandex Documents`.
