# Managing {{ GP }} extensions

{{ mgp-short-name }} supports some {{ GP }} extensions. See the [full list of available extensions and their versions](#greenplum).

## Retrieving a list of extensions available for installation {#available-extensions}

Connect to the selected database and run:

```sql
SELECT * FROM pg_available_extensions();
```

This will display a list of DB extensions available to install:

```text
name                    | default_version | comment                            
------------------------+-----------------+------------------------------
 diskquota              | 1.0             | Disk Quota Main Program
...
```

## Retrieving a list of installed extensions {#list-extensions}

Connect to the selected database and run:

```sql
SELECT extname FROM pg_extension;
```

A list of extensions installed in the DB is displayed:

```text
      extname
-------------------
 plpgsql
...
```

## Editing a list of installed extensions {#update-extensions}

Connect to the selected database and run:

```sql
CREATE EXTENSION <extension_name>;
```

For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-sql_commands-CREATE_EXTENSION.html).

## Supported {{ GP }} extensions {#greenplum}

#|
|| **Extension** | **Version** ||
|| [citext]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-citext.html)
Adds a data type for case-insensitive string comparison.
| 1.0 ||
|| [dblink]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-dblink.html)
Enables support for connections to other {{ GP }} databases within a session.
| 1.1  ||
|| [diskquota]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-diskquota.html)
Allows limiting the size of disk space for schemas and roles in a database.
| 1.0 ||
|| [fuzzystrmatch]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-fuzzystrmatch.html)
Contains functions used to establish the degree of similarity and distance between any two strings.
| 1.0 ||
|| [gp_internal_tools]({{ gp.docs.broadcom }}/7/greenplum-database/admin_guide-managing-monitor.html#creating-the-session_level_memory_consumption-view)
Contains various internal utilities for {{ GP }}.
| 1.0.0 ||
|| [gp_url_tools](https://github.com/open-gpdb/gp_url_tools)
Contains functions for working with URLs. For more information, see [gp_url_tools usage](./gp-url-tools.md).
| 1.0 ||
|| [hstore]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-hstore.html)
Adds a data type for storing <q>key-value</q> pairs in a single field.
| 1.3 ||
|| [pgcrypto]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-pgcrypto.html)
Adds data encryption features. For more information, see [Using pgcrypto](./pgcrypto.md).
| 1.1 ||
|| [plperl]({{ gp.docs.broadcom }}/5/greenplum-database/ref_guide-extensions-pl_perl.html)
Enables support for the PL/Perl procedural language.
| 1.0 ||
|| [plpgsql]({{ gp.docs.broadcom }}/5/greenplum-database/ref_guide-extensions-pl_sql.html)
Enables support for the PL/pgSQL procedural language.
| 1.0 ||
|| [postgis]({{ gp.docs.broadcom }}/5/greenplum-database/ref_guide-extensions-postGIS.html)
Allows GIS (Geographic Information Systems) objects to be stored and processed in {{ PG }} databases.
| 2.1.5 ||
|| [postgres_fdw]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-postgres_fdw.html)
Adds a wrapper for {{ PG }} remote database queries.
| 1.0 ||
|| [pxf]({{ gp.docs.broadcom }}-platform-extension-framework/6-11/gp-pxf/intro_pxf.html)
Allows you to work with heterogeneous data sources.
| 2.0 ||
|| uuid-cb
Enables the generation and validation of unique IDs in compliance with the Russian Central Bank requirements. For more information, see [Using uuid-cb](./uuid-cb.md).
| 1.0 ||
|| [{{ YZ }}](./yezzey.md). {{ yandex-cloud }} extension

Allows you to move [AO and AOCO tables](../../concepts/tables.md) from the cluster storage to a cold storage and vice versa. To use this extension, enable [hybrid storage](../../concepts/hybrid-storage.md) in your {{ mgp-name }} cluster.
| 1.8 ||
|#

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
