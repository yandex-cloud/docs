---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/ALL_CONCAT.md
---


# ALL_CONCAT



#### Syntax {#syntax}


```
ALL_CONCAT( expression [ , separator ] )
```

#### Description {#description}
Returns a string that contains all grouped values of `expression` delimited by `separator` (if `separator` is not specified, a comma is used).

**Argument types:**
- `expression` — `Array of fractional numbers | Array of integers | Array of strings | Boolean | Date | Datetime | Fractional number | Geopoint | Geopolygon | Integer | String | UUID`
- `separator` — `String`


**Return type**: `String`

{% note info %}

Only constant values are accepted for arguments (`separator`).

{% endnote %}


#### Examples {#examples}

```
ALL_CONCAT([Profit])
```

```
ALL_CONCAT([Profit], '; ')
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `PostgreSQL 9.3`, `YDB`.
