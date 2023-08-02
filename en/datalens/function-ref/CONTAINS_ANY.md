---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/CONTAINS_ANY.md
---

# CONTAINS_ANY



#### Syntax {#syntax}


```
CONTAINS_ANY( array_1, array_2 )
```

#### Description {#description}
Returns `TRUE` if `array_1` contains any elements of `array_2`.

**Argument types:**
- `array_1` — `Array of fractional numbers | Array of integers | Array of strings`
- `array_2` — `Array of fractional numbers | Array of integers | Array of strings`


**Return type**: `Boolean`

#### Example {#examples}



| **[array1]**   | **[array2]**   | **CONTAINS_ANY([array1], [array2])**   |
|:---------------|:---------------|:---------------------------------------|
| `'[1,2,3]'`    | `'[1,5]'`      | `True`                                 |
| `'[1,2,3]'`    | `'[4,5]'`      | `False`                                |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `PostgreSQL 9.3`.
