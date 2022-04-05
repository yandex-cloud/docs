---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/ARG_MAX.md
---

# ARG_MAX



#### Syntax {#syntax}


```
ARG_MAX( value, comp )
```

#### Description {#description}
Returns `value` for the maximum value of `comp` in the group. If multiple values of `value` match the maximum value of `comp`, then the first one encountered is returned. This makes the function non-deterministic.

**Argument types:**
- `value` — `Any`
- `comp` — `Any`


**Return type**: Same type as (`value`)

#### Example {#examples}

```
ARG_MAX([Sales], [Profit])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `YDB`.
