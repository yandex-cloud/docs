---
editable: false
---

# UNNEST



#### Syntax {#syntax}


```
UNNEST( array )
```

#### Description {#description}
Expands the `array` array expression to a set of rows.

**Argument types:**
- `array` — `Array of fractional numbers | Array of integer numbers | Array of strings`


**Return type**: Depends on argument types

#### Example {#examples}




Source data

| **City**   | **Category**                       |
|:-----------|:-----------------------------------|
| `'Moscow'` | `['Office Supplies', 'Furniture']` |
| `'London'` | `['Office Supplies']`              |

Result

| **[City]**   | **UNNEST([Category])**   |
|:-------------|:-------------------------|
| `'Moscow'`   | `'Office Supplies'`      |
| `'Moscow'`   | `'Furniture'`            |
| `'London'`   | `'Office Supplies'`      |




#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `PostgreSQL 9.3`.
