---
editable: false
---

# ARG_MAX

_Aggregate functions_

#### Syntax {#syntax}


```
ARG_MAX( value, comp )
```

#### Description {#description}
Returns `value` for the maximum value of `comp` in the group.

**Argument types:**
- `value` — `Any`
- `comp` — `Any`


**Return type**: Same type as (`value`)

#### Examples {#examples}

```
ARG_MAX([Sales], [Profit])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`.
