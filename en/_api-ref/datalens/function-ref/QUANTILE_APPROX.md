---
editable: false
---

# QUANTILE_APPROX



#### Syntax {#syntax}


```
QUANTILE_APPROX( value, quant )
```

#### Description {#description}
Returns the approximate `quant`-level quantile (`quant` should be in range from 0 to 1).

**Argument types:**
- `value` — `Date | Datetime | Fractional number | Integer`
- `quant` — `Fractional number | Integer`


**Return type**: Same type as (`value`)

#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`.
