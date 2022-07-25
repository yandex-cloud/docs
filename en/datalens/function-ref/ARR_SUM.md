---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/ARR_SUM.md
---

# ARR_SUM



#### Syntax {#syntax}


```
ARR_SUM( array )
```

#### Description {#description}
Returns the sum of elements in the `array`.

**Argument types:**
- `array` — `Array of fractional numbers | Array of integers`


**Return type**: Depends on argument types

{% note info %}

This function cannot work with arrays with `Nullable` items. To remove `NULL` items from the array, use [REPLACE](REPLACE_ARRAY.md).

{% endnote %}


#### Example {#examples}



| **[int_array]**   | **[float_array]**   | **ARR_SUM([int_array])**   | **ARR_SUM([float_array])**   |
|:------------------|:--------------------|:---------------------------|:-----------------------------|
| `'[21,12,0]'`     | `'[14.3,0.42,15]'`  | `33`                       | `29.72`                      |
| `'[-4,12,0]'`     | `'[0,-3,12]'`       | `8`                        | `9.00`                       |
| `'[5,7,9]'`       | `'[3.2,2.3,3.2]'`   | `21`                       | `8.70`                       |




#### Data source support {#data-source-support}

`ClickHouse 21.8`.
