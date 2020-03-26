**Syntax:**`GEOCODE( address )`

Converts `address` to its geographical coordinates.

{{ datalens-short-name }} caches the function result. When the function is invoked again, {{ datalens-short-name }} doesn't perform geocoding. The cache lifetime is 30 days.After 30 days, {{ datalens-short-name }} automatically invokes `GEOCODE` to convert addresses in the dataset.