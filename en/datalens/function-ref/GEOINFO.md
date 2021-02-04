---
editable: false
---

# GEOINFO



#### Syntax {#syntax}


```
GEOINFO( address, scale )
```

#### Description {#description}
Converts `address` to geographical name corresponding to the specified `scale`.

Possible values for `scale` parameter:
- `"country"`;
- `"country_code"`;
- `"region"`;
- `"locality"`.

**Argument types:**
- `address` — `String`
- `scale` — `String`


**Return type**: `String`

{% note info %}

Only constant values are accepted for arguments (`scale`).

{% endnote %}

{% note warning %}

- The geocoding quota is no more than 25 000 unique entries per day. Records in excess of the quota will be processed the next day.
- Function is available only with the Standard billing plan.

{% endnote %}


#### Examples {#examples}

```
GEOINFO("посёлок Свободный Серп", "country") = "Россия"
```


#### Data source support {#data-source-support}

`Materialized Dataset`.
