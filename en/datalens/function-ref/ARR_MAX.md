---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/ARR_MAX.md
---

# ARR_MAX



#### Syntax {#syntax}


```
ARR_MAX( array )
```

#### Description {#description}
Returns the greatest of elements in the `array`.

**Argument types:**
- `array` — `Array of fractional numbers | Array of integers`


**Return type**: Depends on argument types

{% note info %}

This function cannot work with arrays with `Nullable` items. To remove `NULL` items from the array, use [ARR_REMOVE](ARR_REMOVE.md) or [REPLACE](REPLACE_ARRAY.md).

{% endnote %}


#### Example {#examples}



| **[int_array]**   | **[float_array]**   | **ARR_MAX([int_array])**   | **ARR_MAX([float_array])**   |
|:------------------|:--------------------|:---------------------------|:-----------------------------|
| `'[21,12,0]'`     | `'[14.3,0.42,15]'`  | `21`                       | `15.00`                      |
| `'[-4,12,0]'`     | `'[0,-3,12]'`       | `12`                       | `12.00`                      |
| `'[5,7,9]'`       | `'[3.2,2.3,3.2]'`   | `9`                        | `3.20`                       |




#### Data source support {#data-source-support}

`ClickHouse 21.8`.
