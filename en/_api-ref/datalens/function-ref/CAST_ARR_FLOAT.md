---
editable: false
---

# CAST_ARR_FLOAT



#### Syntax {#syntax}


```
CAST_ARR_FLOAT( array )
```

#### Description {#description}
Converts `array` to an array of fractional numbers. The conversion rules are the same as for [FLOAT](FLOAT.md).

**Argument types:**
- `array` — `Array of fractional numbers | Array of integers | Array of strings`


**Return type**: `Array of fractional numbers`

#### Example {#examples}



| **[string_array]**          | **[int_array]**    | **CAST_ARR_FLOAT([string_array])**   | **CAST_ARR_FLOAT([int_array])**   |
|:----------------------------|:-------------------|:-------------------------------------|:----------------------------------|
| `"['100','300','200']"`     | `'[12,0,42]'`      | `'[100,300,200]'`                    | `'[12,0,42]'`                     |
| `"['100','300',NULL,NULL]"` | `'[-3,NULL,0]'`    | `'[100,300,NULL,NULL]'`              | `'[-3,NULL,0]'`                   |
| `"['150',NULL,'192']"`      | `'[132,637,NULL]'` | `'[150,NULL,192]'`                   | `'[132,637,NULL]'`                |




#### Data source support {#data-source-support}

`ClickHouse 19.13`, `PostgreSQL 9.3`.
