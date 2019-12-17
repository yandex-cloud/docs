---
editable: false
---

# COUNTD_APPROX

_Aggregate functions_

#### Syntax


```
COUNTD_APPROX( value )
```

#### Description
Returns the approximate number of unique values in the group. Faster than [COUNTD](../COUNTD/overview.md), but doesn't guarantee accuracy.

**Argument types:**
- `value` — `Any`


**Return type**: `Number (whole)`

#### Examples

```
COUNTD_APPROX([ClienID])
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`.
