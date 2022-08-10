# Managing {{ GP }} extensions

{{ mgp-short-name }} supports some {{ GP }} extensions. See [a full list of available extensions and their versions](#greenplum).

## Retrieving a list of installed extensions {#list-extensions}

Connect to the selected database and run:

```sql
SELECT * FROM pg_available_extensions();
```

A list of extensions installed in the DB is displayed:

```text
name                    | default_version | comment                            
------------------------+-----------------+------------------------------
 diskquota              | 1.0             | Disk Quota Main Program
...
```

## Editing a list of installed extensions {#update-extensions}

Connect to the selected database and run:

```sql
CREATE EXTENSION <extension name>;
```

For more information, see the [{{ GP }} documentation](https://greenplum.docs.pivotal.io/6latest/ref_guide/sql_commands/CREATE_EXTENSION.html).

## Supported {{ GP }} extensions {#greenplum}

#|
|| **Extension** | **Version** ||
|| [citext](https://gpdb.docs.pivotal.io/latest/ref_guide/modules/citext.html)
Adds a data type to compare strings, case-insensitive.
| 1.0 ||
|| [dblink](https://gpdb.docs.pivotal.io/latest/ref_guide/modules/dblink.html)
Enables support for connections to other {{ GP }} databases within a session.
| 1.1 ||
|| [diskquota](https://gpdb.docs.pivotal.io/latest/ref_guide/modules/diskquota.html)
Allows limiting the size of disk space for schemas and roles in the database.
| 1.0 ||
|| [fuzzystrmatch](https://gpdb.docs.pivotal.io/latest/ref_guide/modules/fuzzystrmatch.html)
Contains functions for identifying the similarity and distance between any two strings.
| 1.0 ||
|| [gp_internal_tools](https://github.com/greenplum-db/gpdb/blob/master/gpcontrib/gp_internal_tools)
Contains different internal utilities for {{ GP }}.
| 1.0.0 ||
|| [hstore](https://gpdb.docs.pivotal.io/latest/ref_guide/modules/hstore.html)
Adds a data type for storing <q>key-value</q> pairs in a single field.
| 1.3 ||
|| [pgcrypto](https://gpdb.docs.pivotal.io/latest/ref_guide/modules/pgcrypto.html)
Adds data encryption functions.
| 1.1 ||
|| [plperl](https://docs.vmware.com/en/VMware-Tanzu-Greenplum/5/greenplum-database/GUID-ref_guide-extensions-pl_perl.html)
Enables support for the PL/Perl procedural language.
| 1.0 ||
|| [plpgsql](https://docs.vmware.com/en/VMware-Tanzu-Greenplum/5/greenplum-database/GUID-ref_guide-extensions-pl_sql.html)
Enables support for the PL/pgSQL procedural language.
| 1.0 ||
|| [postgres_fdw](https://gpdb.docs.pivotal.io/latest/ref_guide/modules/postgres_fdw.html)
Adds a wrapper that lets you access remote {{ PG }} databases.
| 1.0 ||
|| [pxf](https://gpdb.docs.pivotal.io/pxf/latest/using/overview_pxf.html)
Lets you work with heterogeneous data sources.
| 2.0 ||
|#

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
