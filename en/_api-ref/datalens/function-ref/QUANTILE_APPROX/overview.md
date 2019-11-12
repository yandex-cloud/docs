---
editable: false
---

# QUANTILE_APPROX

_Aggregate functions_

#### Syntax


```
QUANTILE_APPROX( value, quant )
```

#### Description
Returns the approximate `value`-level quantile (`value` should be in range from 0 to 1).

**Argument types:**
- `value` — `Number`
- `quant` — `Any`


**Return type**: Same type as (`value`, `quant`)

{% note info %}

Arguments (`value`, `quant`) must be of the same type.

{% endnote %}


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`
