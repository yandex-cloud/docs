---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/REGEXP_EXTRACT.md
---

# REGEXP_EXTRACT



#### Syntax {#syntax}


```
REGEXP_EXTRACT( string, pattern )
```

#### Description {#description}
Returns the substring `string` that matches the regular expression pattern `pattern`.

**Argument types:**
- `string` — `String`
- `pattern` — `String`


**Return type**: `String`

{% note info %}

Only constant values are accepted for the arguments (`pattern`).

{% endnote %}

{% note info %}

See the documentation of the data source to clarify the regular expression syntax.

{% endnote %}


#### Example {#examples}

```
REGEXP_EXTRACT("RU 912873", "[A-Z]+\s+(\d+)") = "912873"
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `MySQL 8.0.12`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
