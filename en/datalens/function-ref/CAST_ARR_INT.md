---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/CAST_ARR_INT.md
---

# CAST_ARR_INT



#### Syntax {#syntax}


```
CAST_ARR_INT( array )
```

#### Description {#description}
Converts `array` to an array of integers. The conversion rules are the same as for [INT](INT.md).

**Argument types:**
- `array` — `Array of fractional numbers | Array of integers | Array of strings`


**Return type**: `Array of integers`

#### Example {#examples}



| **[string_array]**          | **[float_array]**   | **CAST_ARR_INT([string_array])**   | **CAST_ARR_INT([float_array])**   |
|:----------------------------|:--------------------|:-----------------------------------|:----------------------------------|
| `"['100','300','200']"`     | `'[12.3,0.43,42]'`  | `'[100,300,200]'`                  | `'[12,0,42]'`                     |
| `"['100','300',NULL,NULL]"` | `'[0,NULL,12]'`     | `'[100,300,NULL,NULL]'`            | `'[0,NULL,12]'`                   |
| `"['150',NULL,'192']"`      | `'[3.2,2.3,3.5]'`   | `'[150,NULL,192]'`                 | `'[3,2,3]'`                       |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `PostgreSQL 9.3`.
