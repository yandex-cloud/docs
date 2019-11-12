---
editable: false
---

# QUANTILE

_Aggregate functions_

#### Syntax


```
QUANTILE( value, quant )
```

#### Description
Returns the precise `value`-level quantile (`value` should be in range from 0 to 1).

**Argument types:**
- `value` — `Number`
- `quant` — `Any`


**Return type**: Same type as (`value`, `quant`)

{% note info %}

Arguments (`value`, `quant`) must be of the same type.

{% endnote %}


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`
