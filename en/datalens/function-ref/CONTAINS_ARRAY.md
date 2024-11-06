---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/CONTAINS_ARRAY.md
---

# CONTAINS (array)

_Function `CONTAINS` is also found in the following categories: [String functions](CONTAINS.md)._

#### Syntax {#syntax}


```
CONTAINS( array, value )
```

#### Description {#description}
Returns `TRUE` if `array` contains `value`.

**Argument types:**
- `array` — `Array of fractional numbers | Array of integers | Array of strings`
- `value` — `Fractional number | Integer | String`


**Return type**: `Boolean`

#### Example {#examples}



| **[array]**   | **[value]**   | **CONTAINS([array], [value])**   |
|:--------------|:--------------|:---------------------------------|
| `'[1,2,3]'`   | `2`           | `True`                           |
| `'[1,2,3]'`   | `4`           | `False`                          |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `PostgreSQL 9.3`, `Yandex Documents`.
