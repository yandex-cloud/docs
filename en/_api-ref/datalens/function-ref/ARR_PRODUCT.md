---
editable: false
---

# ARR_PRODUCT



#### Syntax {#syntax}


```
ARR_PRODUCT( array )
```

#### Description {#description}
Returns the product of elements in the `array`.

**Argument types:**
- `array` — `Array of fractional numbers | Array of integers`


**Return type**: `Fractional number`

{% note info %}

This function cannot work with arrays with `Nullable` items. To remove `NULL` items from the array, use [ARR_REMOVE](ARR_REMOVE.md) or [REPLACE](REPLACE_ARRAY.md).

{% endnote %}


#### Example {#examples}



| **[int_array]**   | **[float_array]**   | **ARR_PRODUCT([int_array])**   | **ARR_PRODUCT([float_array])**   |
|:------------------|:--------------------|:-------------------------------|:---------------------------------|
| `'[21,12,0]'`     | `'[14.3,0.42,15]'`  | `0.00`                         | `90.09`                          |
| `'[-4,12,0]'`     | `'[0,-3,12]'`       | `0.00`                         | `-0.00`                          |
| `'[5,7,9]'`       | `'[3.2,2.3,3.2]'`   | `315.00`                       | `23.55`                          |




#### Data source support {#data-source-support}

`ClickHouse 21.8`.
