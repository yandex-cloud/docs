---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/UNNEST.md
---

# UNNEST



#### Syntax {#syntax}


```
UNNEST( array )
```

#### Description {#description}
Expands the `array` array expression to a set of rows.

**Argument types:**
- `array` — `Array of fractional numbers | Array of integers | Array of strings`


**Return type**: Depends on argument types

{% note info %}

`PostgreSQL` doesn't allow filtering fields containing the UNNEST function. If the data source is `PostgreSQL`, do not use such fields in selectors.

{% endnote %}


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

`ClickHouse 19.13`, `PostgreSQL 9.3`.
