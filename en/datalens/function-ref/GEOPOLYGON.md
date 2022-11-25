---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/GEOPOLYGON.md
---

# GEOPOLYGON



#### Syntax {#syntax}


```
GEOPOLYGON( value )
```

#### Description {#description}
Converts the `value` expression to geopolygon format.

**Argument types:**
- `value` — `Geopolygon | String`


**Return type**: `Geopolygon`

#### Examples {#examples}

```
GEOPOLYGON("[[[55.79421,37.65046],[55.79594,37.6513],[55.79642,37.65133],[55.7969, 37.65114],[55.79783, 37.65098],[55.78871,37.75101]]]")
```

```
GEOPOLYGON("[[[55.75,37.52],[55.75,37.68],[55.65,37.60]],[[55.79,37.60],[55.76,37.57],[55.76,37.63]]]")
```


#### Data source support {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
