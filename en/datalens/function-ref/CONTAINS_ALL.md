---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/CONTAINS_ALL.md
---

# CONTAINS_ALL



#### Syntax {#syntax}


```
CONTAINS_ALL( array_1, array_2 )
```

#### Description {#description}
Returns `TRUE` if `array_1` contains all elements of `array_2`.

**Argument types:**
- `array_1` — `Array of fractional numbers | Array of integers | Array of strings`
- `array_2` — `Array of fractional numbers | Array of integers | Array of strings`


**Return type**: `Boolean`

#### Example {#examples}



| **[array1]**   | **[array2]**   | **CONTAINS_ALL([array1], [array2])**   |
|:---------------|:---------------|:---------------------------------------|
| `'[1,2,3]'`    | `'[1,2]'`      | `True`                                 |
| `'[1,2,3]'`    | `'[1,4]'`      | `False`                                |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `PostgreSQL 9.3`, `Yandex Documents`.
