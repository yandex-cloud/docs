# Migrating {{ PG }} clusters

To migrate your database to {{ mpg-full-name }}, you need to directly transfer the data, acquire a write lock for the old database, and switch over the load to the database cluster in {{ yandex-cloud }}.

Performing migration with {{ data-transfer-name }} lets you:

* Go without creating an intermediate VM or granting online access to your {{ mpg-name }} target cluster.
* Minimize the DB downtime when migrating data.
* Migrate from older {{ PG }} versions to newer versions.

For more information, see [{#T}](../concepts/use-cases.md).

To use this migration method, allow connecting to the source cluster from the internet.

## Transferring data {#data-transfer}

{% include notitle [MPG moving data with Data Transfer](../../_tutorials/datatransfer/managed-postgresql.md) %}

## Transferring tables with data types from {{ PG }} extensions

{{ data-transfer-name }} allows you to copy tables, the columns of which contain data types defined in {{ PG }} and tables with derived types, i.e. arrays of these types and composite types with fields of these types. Currently, there is a limitation: the data type must implement __binary I/O functions__. This means that, for the type of data in the [pg_type](https://www.postgresql.org/docs/current/catalog-pg-type.html) system view, the `typsend` and `typreceive` column values must not be zero.

For example, for the [PostGIS](https://postgis.net/) extension, columns of the [`GEOMETRY`](https://postgis.net/docs/geometry.html), [`GEOMETRY_DUMP`](https://postgis.net/docs/geometry_dump.html), and [`GEOGRAPHY`](https://postgis.net/docs/geography.html) types can be transferred, while those of the [`BOX2D`](https://postgis.net/docs/box2d_type.html) and [`BOX3D`](https://postgis.net/docs/box3d_type.html) types cannot.

## See also {#see-also}

For other migration methods, see the [{{ mpg-full-name }} documentation](../../managed-postgresql/tutorials/data-migration.md).
