---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/QUANTILE.md
---


# QUANTILE



#### Syntax {#syntax}


```
QUANTILE( value, quant )
```

#### Description {#description}
Returns the precise `quant`-level quantile (`quant` should be in range from 0 to 1).

**Argument types:**
- `value` — `Date | Datetime | Fractional number | Integer`
- `quant` — `Fractional number | Integer`


**Return type**: Same type as (`value`)

#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.4`, `YDB`.
