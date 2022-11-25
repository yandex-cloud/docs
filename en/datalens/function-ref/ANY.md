---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/ANY.md
---

# ANY



#### Syntax {#syntax}

{% list tabs %}

- Standard

  ```
  ANY( value )
  ```

- Extended

  ```
  ANY( value
       [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
       [ BEFORE FILTER BY ... ]
     )
  ```

  More info:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Description {#description}
Returns one of the values of `value` from the group. This is a nondeterministic aggregation — the result may vary for the same data over multiple queries.

**Argument types:**
- `value` — `Any`


**Return type**: Same type as (`value`)

#### Example {#examples}

```
ANY([Profit])
```


#### Data source support {#data-source-support}

`ClickHouse 19.13`, `MySQL 5.7`, `YDB`.
