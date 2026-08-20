---
title: Setting up a backend for data sources
description: Follow this guide to set up a backend for metadata sources in {{ data-catalog-full-name }}.
---

# Setting up a backend for data sources

{{ data-catalog-name }} uses [source](../../concepts/data-catalog-sources.md) connections to read technical metadata, such as definitions of tables, views, materialized views, procedures, indexes, as well as information from the system tables of the source. For advanced statistical estimates, {{ data-catalog-name }} may also execute data read or data slice queries.

For complete and accurate metadata reads, you should configure the {{ data-catalog-name }} source backend, i.e., parameters and access permissions at the level of the database or another service you are going to source metadata from.

{% note info %}

Please note that source ingestion does not copy user data into the metadata catalog.

{% endnote %}


## General configuration recommendations {#common-recommendations}

For {{ data-catalog-name }} to export the most complete metadata possible, configure additional permissions, accesses, and database settings:

1. To connect to the source, create a dedicated technical user with read-only permissions. Do not grant permissions for data modification, DDL operations, object deletion, or user management.

1. Grant this user access to all objects you need to catalog. If the technical user lacks access to a schema, table, view, or index, {{ data-catalog-name }} may skip it entirely or export incomplete metadata for that object.

   What we recommend:

   * Grant permissions for all schemas and databases you want to see in the catalog.
   * Do not grant permissions for temporary, system, and internal schemas unless they need to be visible to users.
   * Use ingestion filters to explicitly exclude technical objects.

1. For a full metadata export, grant access not just to tables but other objects as well:

   * Views.
   * Materialized views.
   * Stored procedures and functions (if the source supports their export).
   * Field comments and descriptions.
   * System catalogs.
   * Query statistics and logs.

1. Enable profiling separately after you estimate the source load and verify ingestion stability.

   When profiling is enabled, ingestion collects table and column-level statistics and may run additional data read or data slice queries to generate advanced statistical estimates. This results in increased load on the source.

   For production sources, it is best to start in light mode, which is controlled by the size of the sample and the scope of statistical estimates.


## Configuring different backend types


### {{ PG }}

Set up a backend for ingestion of [{{ PG }} source metadata](../../concepts/data-catalog-sources.md#source-pg):

1. Create a dedicated technical user for the ingestion:

    ```sql
    CREATE USER data_catalog_reader WITH PASSWORD '<password>';
    ```

   Specify this user in the source connection settings.

1. Grant the user access to relevant databases:

   ```sql
   GRANT CONNECT ON DATABASE <DB_name> TO data_catalog_reader;
   ```

1. Grant the user access to schemas:

   ```sql
   GRANT USAGE ON SCHEMA <schema_name> TO data_catalog_reader;
   ```

1. Grant the user access to tables and views:

   ```sql
   GRANT SELECT ON ALL TABLES IN SCHEMA <schema_name> TO data_catalog_reader;
   ```

1. Grant the following read permissions for the newly created tables to be ingestible as well:

   ```sql
   ALTER DEFAULT PRIVILEGES IN SCHEMA <schema_name>
   GRANT SELECT ON TABLES TO data_catalog_reader;
   ```

1. In each database subject to data profiling:

   1. Install the statistics collection extension:

       ```sql
       CREATE EXTENSION IF NOT EXISTS pg_stat_statements;
       ```

   1. Grant the user permissions to read statistics:

       ```sql
       GRANT pg_read_all_stats TO data_catalog_reader;
       ```

   1. Check that your query history retention period is at least one week long.
   1. Apply the {{ PG }} settings:

      * `shared_preload_libraries = 'pg_stat_statements'`: Restart {{ PG }} after the change.
      * `pg_stat_statements.max = 10000`: Allows you to increase the number of saved unique queries to collect statistics on rare queries.
      * `pg_stat_statements.track = all`: Allows tracking nested statements in functions and procedures.


### {{ MY }}

Set up a backend for ingestion of [{{ MY }} source metadata](../../concepts/data-catalog-sources.md#source-my):

1. Create a dedicated technical user for the ingestion:

   ```sql
   CREATE USER 'data_catalog_reader'@'%' IDENTIFIED BY '<password>';
   ```

   Specify this user in the source connection settings.

1. Grant the user access to relevant databases:

   ```sql
   GRANT SELECT ON <DB_name>.* TO 'data_catalog_reader'@'%';
   GRANT SHOW VIEW ON <DB_name>.* TO 'data_catalog_reader'@'%';
   ```

You need the `SELECT` privilege for metadata collection and profiling, and `SHOW VIEW` to read view definitions. Without `SHOW VIEW`, the ingestion will see the view as an object but will not be able to properly read its definition and build links with other objects.

To display info on procedures stored in the catalog, the user needs access to procedure metadata. Database-level access is usually enough; however, {{ mmy-full-name }} may limit permissions by its service-level policies. Check that the user can see the procedures:

```sql
SHOW PROCEDURE STATUS WHERE Db = '<DB_name>';
```


### {{ CH }}

Set up a backend for ingestion of [{{ CH }} source metadata](../../concepts/data-catalog-sources.md#source-ch):

1. Create a dedicated technical user for the ingestion:

   ```sql
   CREATE USER data_catalog_reader IDENTIFIED BY '<password>';
   ```

   Specify this user in the source connection settings.

1. Grant the user access to relevant databases:

   ```sql
   GRANT SELECT ON <DB_name>.* TO data_catalog_reader;
   ```

1. For metadata reads, grant access to system tables:

   ```sql
   GRANT SELECT ON system.databases TO data_catalog_reader;
   GRANT SELECT ON system.tables TO data_catalog_reader;
   GRANT SELECT ON system.columns TO data_catalog_reader;
   ```

1. If {{ CH }} system dictionaries are used, grant access to them as well:

   ```sql
   GRANT SELECT ON system.dictionaries TO data_catalog_reader;
   ```

If RBAC and {{ CH }} profiles are used, you can further restrict the user to read-only mode. This mode allows read commands, including `SELECT`, `SHOW`, `DESCRIBE`, and `EXISTS`, which are considered to be equivalent to reading from system tables.


### {{ OS }}

Set up a backend for ingestion of [{{ OS }} source metadata](../../concepts/data-catalog-sources.md#source-os):

1. Create a role with metadata read permissions. Recommended index-level permissions:

   ```json
   PUT /_plugins/_security/api/roles/read_indices_data_catalog

   {
      "index_permissions": [
         {
           "index_patterns": ["*"],
           "allowed_actions": ["read", "view_index_metadata"]
         }
      ]
   }
   ```

   For a stricter setup, we recommend limiting `names` to specific index templates, for example:

   ```json
   PUT /_plugins/_security/api/roles/read_indices_data_catalog

   {
      "index_permissions": [
         {
           "index_patterns": ["prod-*", "analytics-*"],
           "allowed_actions": ["read", "view_index_metadata"]
         }
      ]
   }
   ```

1. Create a dedicated technical user for ingestions and assign the newly created role to this user:

   ```json
   PUT /_plugins/_security/api/internalusers/data_catalog_reader

   {
     "password": "<password>",
     "opendistro_security_roles": ["read_indices_data_catalog"]
   }
   ```

   Specify this user in the source connection settings.


### {{ GP }}

Set up a backend for ingestion of [{{ GP }} source metadata](../../concepts/data-catalog-sources.md#source-gp):

1. Create a dedicated technical user:

   ```sql
   CREATE USER datacatalog_ingest WITH PASSWORD '<password>';
   ```

   Specify this user in the source connection settings.

1. Grant database access:

   ```sql
   GRANT CONNECT ON DATABASE <DB_name> TO datacatalog_ingest;
   ```

1. Grant access to relevant schemas:

   ```sql
   GRANT USAGE ON SCHEMA <schema_name> TO datacatalog_ingest;
   ```

1. Grant read access to tables:

   ```sql
   GRANT SELECT ON ALL TABLES IN SCHEMA <schema_name> TO datacatalog_ingest;
   ```

   If you need only the structure without profiling or object availability checks, the `SELECT` privilege for all tables is optional.

1. Grant the following read permissions for the newly created tables to be ingestible as well:

   ```sql
   ALTER DEFAULT PRIVILEGES IN SCHEMA <schema_name>
   GRANT SELECT ON TABLES TO datacatalog_ingest;
   ```

1. Additional permissions may be required to analyze the most frequent queries. Here is an example:

   ```sql
   GRANT pg_read_all_stats TO datacatalog_ingest;
   ```

   The `pg_stat_statements` extension may also be required.

   ```sql
   CREATE EXTENSION IF NOT EXISTS pg_stat_statements;
   ```

   {% note warning %}

   The availability of `pg_stat_statements` and the `pg_read_all_stats` role depends on your {{ GP }} version and cluster settings.

   {% endnote %}

1. For {{ data-catalog-name }} to automatically display business descriptions, add comments to tables and columns. Here is an example:

   ```sql
   COMMENT ON TABLE mart.orders_daily IS 'Daily aggregated order metrics';
   COMMENT ON COLUMN mart.orders_daily.orders_count IS 'Number of orders per day';
   ```


### {{ SD }}/{{ MG }}

Set up a backend for ingestion of [{{ SD }}/{{ MG }} source metadata](../../concepts/data-catalog-sources.md#source-mg):

1. Create a dedicated technical user:

   ```text
   db.createUser({ user:"datacatalog_ingest", pwd:"<password>", roles:[]});
   ```

   Specify this user in the source connection settings.

1. For a standard export, grant the minimum necessary permissions to the technical user:

   * Read access to a limited list of databases (if exporting their metadata only):

      ```text
      db.grantRolesToUser("datacatalog_ingest", [
      { role: "read", db: "<DB_name>" }
      ]);
      ```

   * The `readAnyDatabase` role (if exporting the metadata of all accessible databases):

      ```text
      db.grantRolesToUser("datacatalog_ingest", [
      { role: "readAnyDatabase", db: "admin" }
      ]);
      ```


## Overview of ingestion requirements {#summary-user-privileges}

#|
|| **Source** | **Minimum permissions** | **For views / object links** | **For query execution statistics** | **For profiling** ||
|| {{ PG }}, {{ GP }} | `CONNECT`, `USAGE`, and `SELECT` for schemas and tables | Access to view definitions
|
* `pg_stat_statements` extension.
* `pg_read_all_stats` role.
* {{ PG }} version: 13 or higher | `SELECT` for tables ||
|| {{ MY }} | `SELECT` for databases | `SHOW VIEW` | Not supported | `SELECT` for tables ||
|| {{ CH }} | `SELECT` for databases and system tables
|
* Access to `system.tables`.
* Access to table, view, and materialized view definitions.
| Not supported | `SELECT` for tables ||
|| {{ OS }} | Reading indexes and metadata | N/A | Not supported | Index read access ||
|| {{ SD }}/{{ MG }} | Reading databases | Configuration not required | Not supported | Not supported ||
|| {{ data-transfer-full-name }}, {{ websql-name }} | Configuration not required | Not supported | Not supported | Not supported ||
|| {{ datalens-name }} | The data source's service account needs access to relevant dashboards, datasets, charts, and reports | Not supported | Not supported | Not supported ||
|#

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
