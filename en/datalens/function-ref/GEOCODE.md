---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/GEOCODE.md
---

# GEOCODE



#### Syntax {#syntax}


```
GEOCODE( address )
```

#### Description {#description}
 Converts `address` to its geographical coordinates. 
 {{ datalens-short-name }} caches the function result. When the function is 
 invoked again, {{ datalens-short-name }} doesn't perform geocoding. 
 The cache lifetime is 30 days. After 30 days, {{ datalens-short-name }} 
 automatically invokes `GEOCODE` to convert addresses in the dataset. 
 The calculated field using this function must be created at the dataset level. 
 To enable the function, go to the [Service Settings]({{ link-datalens-settings }}) page. 

**Argument types:**
- `address` — `String`


**Return type**: `Geopoint`

#### Example {#examples}



| **[value]**                | **GEOCODE([value])**       |
|:---------------------------|:---------------------------|
| `'Paris, France'`          | `'[48.856663,2.351556]'`   |
| `'New York'`               | `'[40.714606,-74.002800]'` |
| `'посёлок Свободный Серп'` | `'[53.650704,37.224461]'`  |




#### Data source support {#data-source-support}

`Materialized Dataset`.
