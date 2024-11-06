---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/REGEXP_EXTRACT_ALL.md
---

# REGEXP_EXTRACT_ALL



#### Syntax {#syntax}


```
REGEXP_EXTRACT_ALL( string, pattern )
```

#### Description {#description}
Returns all `string` substrings matching the `pattern` regex. For regexes with subgroups, it only works for the first subgroup.

**Argument types:**
- `string` — `String`
- `pattern` — `String`


**Return type**: `Array of strings`

{% note info %}

Only constant values are accepted for the arguments (`pattern`).

{% endnote %}

{% note info %}

See the documentation of the data source to clarify the regular expression syntax. For example, `ClickHouse` uses the [RE2 syntax](https://github.com/google/re2/wiki/Syntax) to compose regular expressions.

{% endnote %}


#### Example {#examples}

```
REGEXP_EXTRACT_ALL("100-200, 300-400", "(\d+)-(\d+)") = ["100","300"]
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `PostgreSQL 9.3`, `Yandex Documents`.
