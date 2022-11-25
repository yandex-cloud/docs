---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/ARR_AVG.md
---

# ARR_AVG



#### Syntax {#syntax}


```
ARR_AVG( array )
```

#### Description {#description}
Returns the average of elements in the `array`.

**Argument types:**
- `array` — `Array of fractional numbers | Array of integers`


**Return type**: `Fractional number`

{% note info %}

This function cannot work with arrays with `Nullable` items. To remove `NULL` items from the array, use [ARR_REMOVE](ARR_REMOVE.md) or [REPLACE](REPLACE_ARRAY.md).

{% endnote %}


#### Example {#examples}



| **[int_array]**   | **[float_array]**   | **ARR_AVG([int_array])**   | **ARR_AVG([float_array])**   |
|:------------------|:--------------------|:---------------------------|:-----------------------------|
| `'[21,12,0]'`     | `'[14.3,0.42,15]'`  | `11.00`                    | `9.91`                       |
| `'[-4,12,0]'`     | `'[0,-3,12]'`       | `2.67`                     | `3.00`                       |
| `'[5,7,9]'`       | `'[3.2,2.3,3.2]'`   | `7.00`                     | `2.90`                       |




#### Data source support {#data-source-support}

`ClickHouse 21.8`.
