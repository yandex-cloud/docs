---
editable: false

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# GEOCODE



#### Syntax {#syntax}


```
GEOCODE( address )
```

#### Description {#description}

{% note warning %}

- The geocoding quota is no more than 25 000 unique entries per day. Records in excess of the quota will be processed the next day.
- Function is available only with the Standard billing plan.

{% endnote %}

Converts `address` to its geographical coordinates.

{{ datalens-short-name }} caches the function result. When the function is invoked again, {{ datalens-short-name }} doesn't perform geocoding. The cache lifetime is 30 days.After 30 days, {{ datalens-short-name }} automatically invokes `GEOCODE` to convert addresses in the dataset.

**Argument types:**
- `address` — `String`


**Return type**: `Geopoint`

#### Examples {#examples}

```
GEOCODE("посёлок Свободный Серп") = [53.650704, 37.224461]
```


#### Data source support {#data-source-support}

`Materialized Dataset`.
