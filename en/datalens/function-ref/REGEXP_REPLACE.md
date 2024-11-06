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

See the documentation of the data source to clarify the regular expression syntax. For example, `ClickHouse` uses the [RE2 syntax](https://github.com/google/re2/wiki/Syntax) to compose regular expressions.

{% endnote %}


#### Example {#examples}

```
REGEXP_REPLACE("123 456", "\s", "-") = "123-456"
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `MySQL 8.0.12`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Yandex Documents`.
