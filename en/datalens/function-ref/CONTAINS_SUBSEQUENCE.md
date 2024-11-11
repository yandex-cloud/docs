---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/CONTAINS_SUBSEQUENCE.md
---

# CONTAINS_SUBSEQUENCE



#### Syntax {#syntax}


```
CONTAINS_SUBSEQUENCE( array_1, array_2 )
```

#### Description {#description}
Returns `TRUE` if `array_2` is a continuous subsequence of `array_1`. In other words, returns `TRUE` if and only if `array1 = prefix + array2 + suffix`.

**Argument types:**
- `array_1` — `Array of fractional numbers | Array of integers | Array of strings`
- `array_2` — `Array of fractional numbers | Array of integers | Array of strings`


**Return type**: `Boolean`

#### Example {#examples}



| **[array1]**   | **[array2]**   | **CONTAINS_SUBSEQUENCE([array1], [array2])**   |
|:---------------|:---------------|:-----------------------------------------------|
| `'[1,2,3]'`    | `'[1,2]'`      | `True`                                         |
| `'[1,2,3]'`    | `'[2,1]'`      | `False`                                        |
| `'[1,2,3]'`    | `'[1,3]'`      | `False`                                        |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `Yandex Documents`.
