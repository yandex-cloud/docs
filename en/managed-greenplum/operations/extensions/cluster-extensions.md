# Managing {{ GP }} extensions

{{ mgp-short-name }} supports the following {{ GP }} and {{ PG }} extensions:

#|
|| **Extension** | **Version** ||
|| [btree_gin]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-modules-btree_gin.html)
Adds the ability to create GIN indexes for columns suitable for B-tree indexing.
| 1.0 ||
|| [citext]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-citext.html)
Adds a data type for case-insensitive string comparison.
| 1.0 ||
|| [dblink]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-dblink.html)
Enables support for connections to other {{ GP }} databases within a session.
| 1.1  ||
|| [dict_int]({{ pg.docs.org }}/current/dict-int.html)
Adds a dictionary template for full-text search for integers.
| 1.0 ||
|| [dict_xsyn]({{ pg.docs.org }}/current/dict-xsyn.html)
Adds a dictionary template for full-text search with advanced synonym processing.
| 1.0 ||
|| [diskquota]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-diskquota.html)
Allows limiting the of disk space for schemas and roles in a database.
| 1.0 ||
|| [fuzzystrmatch]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-fuzzystrmatch.html)
Contains functions used to establish the degree of similarity and distance between any two strings.
| 1.0 ||
|| [gp_array_agg]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-modules-gp_array_agg.html)
Adds a parallel implementation of the `array_agg` aggregate function for {{ GP }}.
| 1.0.0 ||
|| [gp_internal_tools]({{ gp.docs.broadcom }}/7/greenplum-database/admin_guide-managing-monitor.html#creating-the-session_level_memory_consumption-view)
Contains various internal utilities for {{ GP }}.
| 1.0.0 ||
|| [gp_legacy_string_agg]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-gp_legacy_string_agg.html)
Adds the single-argument `string_agg` function that was present in {{ GP }} version `5`.
| 1.0.0 ||
|| [gp_percentile_agg]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-modules-gp_percentile_agg.html)
Adds an aggregate function for calculation of percentiles.
| 1.0.0 ||
|| [gp_relaccess_stats](https://github.com/open-gpdb/gp_relaccess_stats). {{ yandex-cloud }} extension.

Collects the access statistics for tables and views. For more information, see [Using gp_relaccess_stats](gp_relaccess_stats.md).
| 1.1 ||
|| [gp_relsizes_stats](https://github.com/open-gpdb/gp_relsizes_stats). {{ yandex-cloud }} extension.

Collects file and table size statistics. For more information, see [Using gp_relsizes_stats](./gp-relsizes-stats.md).
| 1.0 ||
|| [gp_sparse_vector]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-gp_sparse_vector.html)
Adds sparse vectors and related functions.
| 1.0.1 ||
|| [gp_url_tools](https://github.com/open-gpdb/gp_url_tools). {{ yandex-cloud }} extension.

Contains functions for working with URLs. For more information, see [Using `gp_url_tools`](./gp-url-tools.md).
| 1.0 ||
|| [hstore]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-hstore.html)
Adds a data type to store key-value pairs in the same field.
| 1.3 ||
|| [intarray]({{ pg.docs.org }}/current/intarray.html)
Adds functions, operators, and index support for one-dimensional arrays of integers.
| 1.0 ||
|| [isn]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-isn.html)
Adds a data type for working with international product identification standards.
| 1.0 ||
|| [ltree]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-ltree.html)
Adds a data type to represent data labels in a tree hierarchy.
| 1.0 ||
|| [orafce](https://github.com/orafce/orafce)
Adds functions and operators that emulate Oracle functions and packages.
| 3.7 ||
|| [pgaudit](https://github.com/open-gpdb/gpdb/tree/OPENGPDB_STABLE/gpcontrib/pgaudit). {{ yandex-cloud }} extension.

Adds the ability to maintain audit logs of sessions and objects using the standard {{ PG }} logging system.
| 1.0.9 ||
|| [pgcrypto]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-pgcrypto.html)
Adds data encryption features. For more information, see [Using `pgcrypto`](./pgcrypto.md).
| 1.1 ||
|| [pg_trgm]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-pg_trgm.html)
Adds functions and operators for text similarity detection and indexing operators to search for similar strings.
| 1.1 ||
|| [plperl]({{ gp.docs.broadcom }}/5/greenplum-database/ref_guide-extensions-pl_perl.html)
Enables support for the PL/Perl procedural language.
| 1.0 ||
|| [plpgsql]({{ gp.docs.broadcom }}/5/greenplum-database/ref_guide-extensions-pl_sql.html)
Enables support for the PL/pgSQL procedural language.
| 1.0 ||
|| [postgis]({{ gp.docs.broadcom }}/5/greenplum-database/ref_guide-extensions-postGIS.html)
Enables storing and processing GIS (geographic information system) objects in {{ PG }} databases.
| 2.1.5 ||
|| [postgres_fdw]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-postgres_fdw.html)
Adds a wrapper for queries against remote {{ PG }} databases.
| 1.0 ||
|| [pxf]({{ gp.docs.broadcom }}-platform-extension-framework/6-11/gp-pxf/intro_pxf.html)
Allows operating with heterogeneous data sources.
| 2.0 ||
|| [sslinfo]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-sslinfo.html)
Obtains information about the connection's SSL certificate.
| 1.0 ||
|| [tablefunc]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-tablefunc.html)
Adds table functions that return sets of rows.
| 1.0 ||
|| [try_convert](https://github.com/open-gpdb/gp_relaccess_stats). {{ yandex-cloud }} extension.

Adds a function to convert data from one type to another. For more information, see [Using try_convert](try_convert.md).
| 1.0 ||
|| [tsearch2]({{ pg.docs.org }}/9.6/tsearch2.html)
Adds features compatible with the full-text search features {{ PG }} had prior to version `8.3`.
| 1.0 ||
|| [unaccent]({{ pg.docs.org }}/current/unaccent.html)
Adds a full-text search dictionary that removes diacritics.
| 1.0 ||
|| uuid-cb. {{ yandex-cloud }} extension.

Enables the generation and validation of unique IDs in compliance with the Russian Central Bank requirements. For more information, see [Using `uuid-cb`](./uuid-cb.md).
| 1.0 ||
|| [{{ YZ }}](./yezzey.md). {{ yandex-cloud }} extension.

Enables moving [AO and AOCO tables](../../concepts/tables.md) from cluster storage to cold storage and vice versa. To use this extension, enable [hybrid storage](../../concepts/hybrid-storage.md) in your {{ GP }} cluster.
| 1.8 ||
|| [xml2]({{ pg.docs.org }}/current/xml2.html)
Adds functions for XPath queries and XSLT transformations.
| 1.0 ||
|#

## Retrieving a list of extensions available for installation {#available-extensions}

Connect to the selected database and run this command:

```sql
SELECT * FROM pg_available_extensions();
```

This will display a list of DB extensions available for installation:

```text
name                    | default_version | comment                            
------------------------+-----------------+------------------------------
 diskquota              | 1.0             | Disk Quota Main Program
...
```

## Retrieving a list of installed extensions {#list-extensions}

Connect to the selected database and run this command:

```sql
SELECT extname FROM pg_extension;
```

This will display a list of extensions installed in the DB:

```text
      extname
-------------------
 plpgsql
...
```

## Editing a list of installed extensions {#update-extensions}

Connect to the selected database and run this command:

```sql
CREATE EXTENSION <extension_name>;
```

For more information, see [this {{ GP }} article]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-sql_commands-CREATE_EXTENSION.html).

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
