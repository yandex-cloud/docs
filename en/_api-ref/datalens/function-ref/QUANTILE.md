---
editable: false
---

# QUANTILE

_Aggregate functions_

#### Syntax {#syntax}


```
QUANTILE( value, quant )
```

#### Description {#description}
Returns the precise `quant`-level quantile (`quant` should be in range from 0 to 1).

**Argument types:**
- `value` — `Number`
- `quant` — `Number`


**Return type**: Same type as (`value`)

#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`.
