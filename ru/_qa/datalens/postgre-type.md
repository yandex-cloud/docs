### Поддерживаете ли тип GEO из {{ PG }}? {#postgre-type}

{{ datalens-short-name }} не поддерживает типы данных расширения [PostGIS](https://postgis.net/docs/), которое используется в {{ PG }} для работы с геоданными. [`Геоточка`](../../datalens/dataset/data-types.md#geopoint) и [`Геополигон`](../../datalens/dataset/data-types.md#geopolygon) — это строковые типы определенного формата.
