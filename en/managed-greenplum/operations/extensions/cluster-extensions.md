# Managing extensions in {{ mgp-name}}

{{ mgp-name }} supports the following {{ GP }} and {{ PG }} extensions:

#|
|| **Extension** | **Version for {{ GP }}** | **Version for {{ CB }}** ||
|| [bool_plperl]({{ pg.docs.org }}/14/plperl-funcs.html)
Provides transformation for the `bool` type for the PL/Perl procedural language.
| — | 1.0 ||
|| [btree_gist]({{ pg.docs.org }}/14/btree-gist.html)
Provides GiST operator classes with behavior similar to B-tree.
| — | 1.6 ||
|| [btree_gin]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-modules-btree_gin.html)
Adds the ability to create GIN indexes for columns suitable for B-tree indexing.
| 1.0 | 1.3 ||
|| [citext]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-modules-citext.html)
Adds a data type for case-insensitive string comparison.
| 1.0 | 1.6 ||
|| [dblink]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-modules-dblink.html)
Enables support for connections to other {{ GP }} databases within a session.
| 1.1  | 1.2 ||
|| [dict_int]({{ pg.docs.org }}/current/dict-int.html)
Adds a dictionary template for full-text search for integers.
| 1.0 | 1.0 ||
|| [diskquota]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-modules-diskquota.html)
Allows limiting the of disk space for schemas and roles in a database.
| 1.0 | 2.3 ||
|| [fuzzystrmatch]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-modules-fuzzystrmatch.html)
Contains functions used to establish the degree of similarity and distance between any two strings.
| 1.0 | 1.1 ||
|| [gp_distribution_policy]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-system_catalogs-gp_distribution_policy.html)
Contains information about the table data distribution policy across cluster segments.
| 1.0 | 1.0 ||
|| [gp_exttable_fdw]({{ gp.docs.broadcom }}/7/greenplum-database/admin_guide-external-map_ext_to_foreign.html)
Provides an external data wrapper for working with external tables.
| — | 1.0 ||
|| [gp_internal_tools]({{ gp.docs.broadcom }}/6/greenplum-database/admin_guide-managing-monitor.html#creating-the-session_level_memory_consumption-view)
Contains various internal utilities.
| 1.0.0 | 1.0.0 ||
|| [gp_relaccess_stats](https://github.com/open-gpdb/gp_relaccess_stats). {{ yandex-cloud }} extension

Collects the access statistics for tables and views. For more information, see [Using gp_relaccess_stats](gp_relaccess_stats.md).
| 1.1 | — ||
|| [gp_relsizes_stats](https://github.com/open-gpdb/gp_relsizes_stats). {{ yandex-cloud }} extension

Collects file and table size statistics. For more information, see [Using gp_relsizes_stats](./gp-relsizes-stats.md).
| 1.0 | — ||
|| [gp_toolkit](https://cloudberry.apache.org/docs/sys-catalogs/gp_toolkit)
Provides a number of administrative views and functions.
| — | 1.6 ||
|| [gp_url_tools](https://github.com/open-gpdb/gp_url_tools). {{ yandex-cloud }} extension

Contains functions for working with URLs. For more information, see [Using gp_url_tools](./gp-url-tools.md).
| 1.0 | — ||
|| [hstore]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-modules-hstore.html)
Adds a data type to store key-value pairs in the same field.
| 1.3 | 1.8 ||
|| [intarray]({{ pg.docs.org }}/current/intarray.html)
Adds functions, operators, and index support for one-dimensional arrays of integers.
| 1.0 | 1.5 ||
|| [isn]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-modules-isn.html)
Adds a data type for working with international product identification standards.
| 1.0 | 1.2 ||
|| [jsonb_plperl]({{ gp.docs.broadcom }}/7/greenplum-database/admin_guide-query-topics-json-data.html#topic_transforms)
Provides transformation for the `jsonb` type for the PL/Perl procedural language.
| — | 1.0 ||
|| [logerrors](https://github.com/munakoiso/logerrors)
Adds a function for collecting statistics about log messages.
| 2.1 | 2.1 ||
|| [ltree]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-modules-ltree.html)
Adds a data type to represent data labels in a tree hierarchy.
| 1.0 | 1.2 ||
|| [orafce](https://github.com/orafce/orafce)
Adds functions and operators that emulate Oracle functions and packages.
| 3.7 | 4.9 ||
|| [pgcrypto]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-modules-pgcrypto.html)
Adds data encryption features. For more information, see [Using pgcrypto](./pgcrypto.md).
| 1.1 | 1.3 ||
|| [pg_trgm]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-modules-pg_trgm.html)
Adds functions and operators for text similarity detection and indexing operators to search for similar strings.
| 1.1 | 1.6 ||
|| [plperl]({{ gp.docs.broadcom }}/6/greenplum-database/analytics-pl_perl.html)
Enables support for the PL/Perl procedural language.
| 1.0 | 1.0 ||
|| [plpgsql]({{ gp.docs.broadcom }}/6/greenplum-database/analytics-pl_sql.html)
Enables support for the PL/pgSQL procedural language.
| 1.0 | 1.0 ||
|| [postgres_fdw]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-modules-postgres_fdw.html)
Adds a wrapper for queries against remote {{ PG }} databases.
| 1.0 | 1.1 ||
|| [pxf]({{ gp.docs.broadcom }}-platform-extension-framework/6-11/gp-pxf/intro_pxf.html)
Allows operating with heterogeneous data sources.
| 2.0 | 2.1 ||
|| [pxf_fdw]({{ gp.docs.broadcom }}-platform-extension-framework/6-11/gp-pxf/intro_pxf.html)
Adds an external data wrapper for accessing heterogeneous data sources.
| — | 2.0 ||
|| [seg]({{ pg.docs.org }}/current/seg.html)
Adds a data type for representing intervals or ranges with floating points.
| 1.0 | 1.4 ||
|| [tablefunc]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-modules-tablefunc.html)
Adds table functions that return sets of rows.
| 1.0 | 1.0 ||
|| [tcn]({{ pg.docs.org }}/current/tcn.html)
Adds a trigger function to notify subscribers about changes in tables.
| 1.0 | 1.0 ||
|| [try_convert](https://github.com/open-gpdb/gpdb/tree/OPENGPDB_STABLE/contrib/try_convert). {{ yandex-cloud }} extension.

Adds a function to convert data from one type to another. For more information, see [Using try_convert](try_convert.md).
| 1.0 | — ||
|| [tsm_system_rows]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-tsm_system_rows.html)
Provides the `SYSTEM_ROWS` table sampling method.
| — | 1.0 ||
|| [tsm_system_time]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-tsm_system_time.html)
Provides the `SYSTEM_TIME` table sampling method.
| — | 1.0 ||
|| [unaccent]({{ pg.docs.org }}/current/unaccent.html)
Adds a full-text search dictionary that removes diacritics.
| 1.0 | 1.1 ||
|| uuid-cb. {{ yandex-cloud }} extension.

Enables the generation and validation of unique IDs in compliance with the Russian Central Bank requirements. For more information, see [Using uuid-cb](./uuid-cb.md).
| 1.0 | — ||
|| [uuid-ossp]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-uuid-ossp.html)
Provides functions for generating universally unique identifiers (UUIDs).
| — | 1.1 ||
|| [yezzey](./yezzey.md). {{ yandex-cloud }} extension.

Enables moving [AO and AOCO tables](../../concepts/tables.md) from cluster storage to cold storage and vice versa. To use this extension, enable [hybrid storage](../../concepts/hybrid-storage.md) in your {{ mgp-name }} cluster.
| 1.8 | 1.8.8 ||
|| [xml2]({{ pg.docs.org }}/current/xml2.html)
Adds functions for XPath queries and XSLT transformations.
| 1.0 | 1.1 ||
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

For more details, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-sql_commands-CREATE_EXTENSION.html).

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}

{% include [cloudberry-trademark](../../../_includes/mdb/mgp/trademark-cloudberry.md) %}
