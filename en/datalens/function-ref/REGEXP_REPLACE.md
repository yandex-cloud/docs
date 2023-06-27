---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/REGEXP_REPLACE.md
---

# REGEXP_REPLACE



#### Syntax {#syntax}


```
REGEXP_REPLACE( string, pattern, replace_with )
```

#### Description {#description}
Searches for a substring in the string `string` using the regular expression pattern `pattern` and replaces it with the string `replace_with`.

If the substring is not found, the string is not changed.

**Argument types:**
- `string` — `String`
- `pattern` — `String`
- `replace_with` — `String`


**Return type**: `String`

{% note info %}

See the documentation of the data source to clarify the regular expression syntax.

{% endnote %}

Use the [ClickHouse](https://github.com/google/re2/wiki/Syntax) syntax to create regular expressions in materialized datasets.



#### Example {#examples}

```
REGEXP_REPLACE("RU 912873", "\s", "-") = "RU-912873"
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `MySQL 8.0.12`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
