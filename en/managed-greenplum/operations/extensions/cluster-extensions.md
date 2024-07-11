# Managing {{ GP }} extensions

{{ mgp-short-name }} supports some {{ GP }} extensions. For more information, refer to [the full list of available extensions and their versions](#greenplum).

## Retrieving a list of extensions available to install {#available-extensions}

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

For more information, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/7/greenplum-database/ref_guide-sql_commands-CREATE_EXTENSION.html).

## Supported {{ GP }} extensions {#greenplum}

#|
|| **Extension** | **Version** ||
|| [citext]({{ gp.docs.vmware }}/7/greenplum-database/ref_guide-modules-citext.html)
Adds a data type to compare strings, case-insensitive.
| 1.0 ||
|| [dblink]({{ gp.docs.vmware }}/7/greenplum-database/ref_guide-modules-dblink.html)
Enables support of connections to other {{ GP }} databases within a session.
| 1.1 ||
|| [diskquota]({{ gp.docs.vmware }}/7/greenplum-database/ref_guide-modules-diskquota.html)
Allows limiting the size of disk space for schemas and roles in the database.
| 1.0 ||
|| [fuzzystrmatch]({{ gp.docs.vmware }}/7/greenplum-database/ref_guide-modules-fuzzystrmatch.html)
Contains functions for identifying the similarity and distance between any two strings.
| 1.0 ||
|| [gp_internal_tools]({{ gp.docs.vmware }}/7/greenplum-database/admin_guide-managing-monitor.html#creating-the-session_level_memory_consumption-view)
Contains various internal utilities for {{ GP }}.
| 1.0.0 ||
|| [hstore]({{ gp.docs.vmware }}/7/greenplum-database/ref_guide-modules-hstore.html)
Adds a data type for storing <q>key-value</q> pairs in a single field.
| 1.3 ||
|| [pgcrypto]({{ gp.docs.vmware }}/7/greenplum-database/ref_guide-modules-pgcrypto.html)
Adds data encryption functions. For more information, see [Using pgcrypto](./pgcrypto.md).
| 1.1 ||
|| [plperl]({{ gp.docs.vmware }}/5/greenplum-database/ref_guide-extensions-pl_perl.html)
Enables support for the PL/Perl procedural language.
| 1.0 ||
|| [plpgsql]({{ gp.docs.vmware }}/5/greenplum-database/ref_guide-extensions-pl_sql.html)
Enables support for the PL/pgSQL procedural language.
| 1.0 ||
|| [postgis]({{ gp.docs.vmware }}/5/greenplum-database/ref_guide-extensions-postGIS.html)
Allows GIS (Geographic Information System) objects to be stored and handled in {{ PG }} databases.
| 2.1.5 ||
|| [postgres_fdw]({{ gp.docs.vmware }}/7/greenplum-database/ref_guide-modules-postgres_fdw.html)
Adds a wrapper that allows you to access remote {{ PG }} databases.
| 1.0 ||
|| [pxf]({{ gp.docs.vmware }}-Platform-Extension-Framework/6.9/greenplum-platform-extension-framework/intro_pxf.html)
Allows you to work with heterogeneous data sources.
| 2.0 ||
|| uuid-cb
Enables the generation and validation of unique IDs in compliance with the Russian Central Bank requirements. For more information, see [Using uuid-cb](./uuid-cb.md).
| 1.0 ||
|| [{{ YZ }}](../../tutorials/yezzey.md). {{ yandex-cloud }} extension
Exports [AO and AOCO tables](../../concepts/tables.md) from disks within the {{ mgp-name }} cluster to a cold storage in {{ objstorage-full-name }}. This way, the data will be stored in a service bucket in a compressed and encrypted form.
| 1.8 ||
|#

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
