---
editable: false
---

# GEOPOINT

_Type conversion functions_

#### Syntax


```
GEOPOINT( value_1 [ , value_2 ] )
```

#### Description
Generates a Geopoint type value. For the input, it accepts a string, a "geopoint" type value, or coordinates — latitude `value_1` and longitude `value_2`. If a single string is input, it must contain a list of two numbers (latitude and longitude) in JSON syntax.

**Argument types:**
- `value_1` — `Geopoint | Number | String`
- `value_2` — `Number | String`


**Return type**: `Geopoint`

#### Examples

```
GEOPOINT("[55.75222,37.61556]") = "[55.75222,37.61556]"
```

```
GEOPOINT(55.75222, 37.61556) = "[55.75222,37.61556]"
```


#### Data source support

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`
