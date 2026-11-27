---
editable: false
alternate:
  - href: en/datalens/function-ref/LEN_ARRAY.md
    type: text/markdown
    title: Markdown version
---

# LEN (array)

_Function `LEN` is also found in the following categories: [String functions](LEN.md)._

#### Syntax {#syntax}


```
LEN( value )
```

#### Description {#description}
Returns the number of the `value` items.

**Argument types:**
- `value` — `Array of fractional numbers | Array of integers | Array of strings`


**Return type**: `Integer`

#### Examples {#examples}

```
LEN(ARRAY(1, 2, 3)) = 3
```

```
LEN(ARRAY('a', 'b', NULL, 'c')) = 4
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `PostgreSQL 9.3`, `Trino`, `Yandex Documents`.
