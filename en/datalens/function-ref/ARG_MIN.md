---
editable: false
---

# ARG_MIN



#### Syntax {#syntax}


```
ARG_MIN( value, comp )
```

#### Description {#description}
Returns `value` for the minimum value of `comp` in the group. If multiple values of `value` match the minimum value of `comp`, then the first one encountered is returned. This makes the function non-deterministic.

**Argument types:**
- `value` — `Any`
- `comp` — `Any`


**Return type**: Same type as (`value`)

#### Examples {#examples}

```
ARG_MIN([Sales], [Profit])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`.
