---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/TOP_CONCAT.md
---


# TOP_CONCAT



#### Syntax {#syntax}


```
TOP_CONCAT( expression, amount [ , separator ] )
```

#### Description {#description}
Returns a string that contains top `amount` grouped values of `expression` delimited by `separator` (if `separator` is not specified, a comma is used).

**Argument types:**
- `expression` — `Array of fractional numbers | Array of integer numbers | Array of strings | Boolean | Date | Datetime | Fractional number | Geopoint | Geopolygon | Integer | String | UUID`
- `amount` — `Integer`
- `separator` — `String`


**Return type**: `String`

{% note info %}

Only constant values are accepted for arguments (`amount`, `separator`).

{% endnote %}


#### Examples {#examples}

```
TOP_CONCAT([Profit], 3)
```

```
TOP_CONCAT([Profit], 3, '; ')
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `YDB`.
