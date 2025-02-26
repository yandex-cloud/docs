---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/ARR_INTERSECT.md
---

# ARR_INTERSECT



#### Syntax {#syntax}


```
ARR_INTERSECT( array_1, array_2, array_3 [ , ... ] )
```

#### Description {#description}
Returns an array of elements that occur in every array provided as an argument. The function does not put such elements in any particular order. Duplicate elements are only added once.

**Argument types:**
- `array_1` — `Array of fractional numbers | Array of integers | Array of strings`
- `array_2` — `Array of fractional numbers | Array of integers | Array of strings`
- `array_3` — `Array of fractional numbers | Array of integers | Array of strings`


**Return type**: Same type as (`array_1`)

#### Example {#examples}



| **[array1]**        | **[array2]**        | **ARR_INTERSECT([array1], [array2])**   |
|:--------------------|:--------------------|:----------------------------------------|
| `'[1,2,3]'`         | `'[2,3,4]'`         | `'[2,3]'`                               |
| `'[1,2,2]'`         | `'[2,2,3]'`         | `'[2]'`                                 |
| `'[1,2,3]'`         | `'[4,5,6]'`         | `'[]'`                                  |
| `'[NULL,1,1,NULL]'` | `'[1,NULL,2,NULL]'` | `'[NULL,1]'`                            |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `PostgreSQL 9.3`, `Yandex Documents`.
