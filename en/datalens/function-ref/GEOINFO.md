---
editable: false
---

# GEOINFO

_Geographical functions_

#### Syntax


```
GEOINFO( address, scale )
```

#### Description
Converts `address` to geographical name corresponding to the specified `scale`.

Possible values for `scale` parameter:
- `"country"`,
- `"country_code"`,
- `"region"`,
- `"locality"`.

**Argument types:**
- `address` — `String`
- `scale` — `String`


**Return type**: `String`

{% note info %}

Only constant values are accepted for arguments (scale).

{% endnote %}

{% note warning %}

Function is available only with the Standard billing plan.

{% endnote %}


#### Examples

```
GEOINFO("посёлок Свободный Серп", "country") = "Россия"
```


#### Data source support

`Materialized Dataset`.
