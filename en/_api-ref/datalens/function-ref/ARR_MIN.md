---
editable: false
---

# ARR_MIN



#### Syntax {#syntax}


```
ARR_MIN( array )
```

#### Description {#description}
Returns the least of elements in the `array`.

**Argument types:**
- `array` — `Array of fractional numbers | Array of integers`


**Return type**: Depends on argument types

{% note info %}

This function cannot work with arrays with `Nullable` items. To remove `NULL` items from the array, use [REPLACE](REPLACE_ARRAY.md).

{% endnote %}


#### Example {#examples}



| **[int_array]**   | **[float_array]**   | **ARR_MIN([int_array])**   | **ARR_MIN([float_array])**   |
|:------------------|:--------------------|:---------------------------|:-----------------------------|
| `'[21,12,0]'`     | `'[14.3,0.42,15]'`  | `0`                        | `0.42`                       |
| `'[-4,12,0]'`     | `'[0,-3,12]'`       | `-4`                       | `-3.00`                      |
| `'[5,7,9]'`       | `'[3.2,2.3,3.2]'`   | `5`                        | `2.30`                       |




#### Data source support {#data-source-support}

`ClickHouse 21.8`.
