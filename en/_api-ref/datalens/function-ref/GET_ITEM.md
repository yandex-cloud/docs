---
editable: false
---

# GET_ITEM



#### Syntax {#syntax}


```
GET_ITEM( array, index )
```

#### Description {#description}
Returns the element with the index `index` from the array `array`. Index must be any integer. Indexes in an array begin with one.

**Argument types:**
- `array` — `Array of fractional numbers | Array of integer numbers | Array of strings`
- `index` — `Integer`


**Return type**: Depends on argument types

#### Example {#examples}

```
GET_ITEM([array_field], 2)
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `PostgreSQL 9.3`.
