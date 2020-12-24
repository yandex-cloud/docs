---
editable: false
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

Only constant values are accepted for arguments (`pattern`).

{% endnote %}

{% note info %}

See the documentation of the data source to clarify the regular expression syntax.

{% endnote %}

Use the [ClickHouse](https://github.com/google/re2/wiki/Syntax) syntax to create regular expressions in materialized datasets.



#### Examples {#examples}

```
REGEXP_EXTRACT("RU 912873", "[A-Z]+\s+(\d+)") = "912873"
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `MySQL 8.0.12`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
