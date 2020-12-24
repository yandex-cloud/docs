---
editable: false
---

# REGEXP_EXTRACT_NTH



#### Syntax {#syntax}


```
REGEXP_EXTRACT_NTH( string, pattern, match_index )
```

#### Description {#description}
Returns a substring `string` that matches the regular expression pattern `pattern` starting from the specified index.

**Argument types:**
- `string` — `String`
- `pattern` — `String`
- `match_index` — `Number (whole)`


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
REGEXP_EXTRACT_NTH("RU 912 EN 873", "[A-Z]+\s+(\d+)", 2) = "873"
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `MySQL 8.0.12`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
