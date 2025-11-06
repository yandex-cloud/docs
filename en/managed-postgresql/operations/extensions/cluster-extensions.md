# Managing extensions

{{ mpg-short-name }} supports multiple standard {{ PG }} extensions, along with several custom ones. A complete list of available extensions and their versions for each {{ PG }} release [is provided below](#postgresql).

{% note warning %}

{{ mpg-short-name }} clusters do not support managing {{ PG }} extensions via SQL commands.

{% endnote %}

## Loading libraries for extensions {#libraries-connection}

Some extensions require shared libraries to be loaded. To load a library, specify its name in the [Shared preload libraries setting](../../concepts/settings-list.md#setting-shared-libraries) when you [create](../cluster-create.md) or [modify](../update.md#change-postgresql-config) a cluster.

{{ mpg-short-name }} supports the following libraries:

* `age`: Required for the [age](https://age.apache.org) extension.
* `anon`: Required for the [postgresql_anonymizer](https://postgresql-anonymizer.readthedocs.io/en/stable/) extension.
* `auto_explain`: Required for the [auto_explain]({{ pg-docs }}/auto-explain.html) extension.
* `pg_cron`: Required for the [pg_cron](https://github.com/citusdata/pg_cron) extension.
* `pg_hint_plan`: Required for the [pg_hint_plan](https://github.com/ossc-db/pg_hint_plan) extension.
* `pg_qualstats`: Required for the [pg_qualstats](https://github.com/powa-team/pg_qualstats) extension.
* `pg_stat_query_plans`: Required for the [pg_stat_query_plans](https://github.com/postgredients/pg_stat_query_plans) extension.
* `pgaudit`: Required for the [pgaudit](https://www.pgaudit.org/) extension.
* `pglogical`: Required for the [pglogical](https://github.com/2ndQuadrant/pglogical) extension.
* `timescaledb`: Required for [TimescaleDB](https://github.com/timescale/timescaledb) to function.

{% note warning %}

Loading a shared library will cause {{ PG }} the master host to restart.

{% endnote %}

## Getting a list of loaded extensions {#list-extensions}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.postgresql.cluster.switch_databases }}** section.
  1. The **{{ ui-key.yacloud.mdb.cluster.databases.column_extensions }}** column will show the list of extensions loaded for each database.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To get a list of database extensions, run this command:

  ```bash
  {{ yc-mdb-pg }} database get <DB_name> \
     --cluster-name <cluster_name>
  ```

  The `extensions` list will show the loaded extensions.

- REST API {#api}

  1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Database.Get](../../api-ref/Database/get.md) method to execute the following request via {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/databases/<DB_name>'
     ```

     You can get the cluster ID from the [folder’s cluster list](../cluster-list.md#list-clusters), and the database name from the [cluster’s database list](../databases.md#list-db).

  1. Check the [server response](../../api-ref/Database/get.md#responses) to make sure your request was successful.

     You can find the list of loaded extensions in the `extensions` field of the command output.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [DatabaseService.Get](../../api-ref/grpc/Database/get.md) call to execute the following request, e.g., via {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/database_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "database_name": "<DB_name>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.DatabaseService.Get
     ```

     You can get the cluster ID from the [folder’s cluster list](../cluster-list.md#list-clusters), and the database name from the [cluster’s database list](../databases.md#list-db).

  1. Check the [server response](../../api-ref/grpc/Database/get.md#yandex.cloud.mdb.postgresql.v1.Database) to make sure your request was successful.

     You can find the list of loaded extensions in the `extensions` field of the command output.

{% endlist %}

## Updating a list of loaded extensions {#update-extensions}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.postgresql.cluster.switch_databases }}** tab.
  1. Find the database you need in the list, click ![options](../../../_assets/console-icons/ellipsis.svg) in its row, then select **{{ ui-key.yacloud.mdb.cluster.databases.button_action-manage }}**.
  1. Select the extensions you need and click **{{ ui-key.yacloud.postgresql.databases.dialog.button_submit }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To update extensions for a database, provide their list in the `--extensions` argument of the CLI command. Any extensions not included in the list will be disabled.

  ```bash
  {{ yc-mdb-pg }} database update <DB_name> \
     --cluster-name <cluster_name> \
     --extensions <extension_name>,<extension_name>...
  ```

  You may get errors when installing multiple extensions. Learn more about possible causes of errors and how to troubleshoot them in [FAQ](../../qa/errors.md#cli-extensions-error).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

     For more information about creating this file, see [this guide](../cluster-create.md).

     For a complete list of configurable {{ mpg-name }} cluster database settings, refer to the [{{ TF }} provider guides]({{ tf-provider-resources-link }}/mdb_postgresql_database).

  1. Add one or more `extension` sections to the relevant cluster database configuration, with one section per extension:

      ```hcl
      resource "yandex_mdb_postgresql_database" "<DB_name>" {
        ...
        extension {
          name    = "<extension_name>"
        }
        ...
      }
      ```

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Database.Update](../../api-ref/Database/update.md) method to execute the following request via {{ api-examples.rest.tool }}:

     {% include [note-updatemask](../../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/databases/<DB_name>' \
       --data '{
                 "updateMask": "extensions",
                 "extensions": [
                   {
                     "name": "<extension_name>"
                   },
                   { <similar_configuration_for_extension_2> },
                   { ... },
                   { <similar_configuration_for_extension_N> }
                 ]
               }'
     ```

     Where:

     * `updateMask`: Comma-separated list of settings you want to update.

       Here, we provide only one setting.

     * `extensions`: Array of database extensions. Each object represents a single extension and has the following structure:

       * `name`: Extension name.

       Use a name from the [list of supported {{ PG }}](#postgresql) extensions and utilities.

     You can get the cluster ID from the [folder’s cluster list](../cluster-list.md#list-clusters), and the database name from the [cluster’s database list](../databases.md#list-db).

  1. Check the [server response](../../api-ref/Database/update.md#responses) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [DatabaseService.Update](../../api-ref/grpc/Database/update.md) call to execute the following request, e.g., via {{ api-examples.grpc.tool }}:

     {% include [note-grpc-updatemask](../../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/database_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "database_name": "<DB_name>",
             "update_mask": {
               "paths": [
                 "extensions"
               ]
             },
             "extensions": [
               {
                 "name": "<extension_name>"
               },
               { <similar_configuration_for_extension_2> },
               { ... },
               { <similar_configuration_for_extension_N> }
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.DatabaseService.Update
     ```

     Where:

     * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

       Here, we provide only one setting.

     * `extensions`: Array of database extensions. Each array element contains the configuration for a single extension and has the following structure:

       * `name`: Extension name.

       Use a name from the [list of supported {{ PG }}](#postgresql) extensions and utilities.

     You can get the cluster ID from the [folder’s cluster list](../cluster-list.md#list-clusters), and the database name from the [cluster’s database list](../databases.md#list-db).

  1. Check the [server response](../../api-ref/grpc/Database/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Supported {{ PG }} extensions and utilities {#postgresql}

#|
|| **Extension** \ **{{ PG }} version** | **11** | **12** | **13** | **14** | **15** | **16** | **17** ||
|| <p>[address_standardizer](https://postgis.net/docs/manual-3.1/postgis_installation.html#installing_pagc_address_standardizer)</p><p>Provides functions to normalize postal addresses from string inputs.</p> | 2.5.2 | 3.0.0 | 3.1.4 | 3.1.4 | 3.3.2 | 3.4.0 | 3.4.3 ||
|| <p>[address_standardizer_data_us](https://postgis.net/docs/manual-3.1/postgis_installation.html#make_install_postgis_extensions)</p><p>Contains normalization rules for the US and Canadian postal addresses to be used with the `address_standardizer` extension.</p> | 2.5.2 | 3.0.0 | 3.1.4 | 3.1.4 | 3.3.2 | 3.4.0 | 3.4.3 ||
|| <p>[age](https://age.apache.org)</p><p>Adds support for [graph databases](https://en.wikipedia.org/wiki/Graph_database), including:
* Graph DB storage
* Graph DB management  
* Operations on graphs</p>

Using this extension requires you to [enable the `age` shared library](#libraries-connection). | - | - | - | - | - | 1.5.0 | 1.5.0 ||
|| <p>[amcheck]({{ pg-docs }}/amcheck.html)</p><p>Provides functions for validating the logical integrity of a database’s relational schema.</p><p>To use this extension, you need the [`mdb_admin`](../../concepts/roles.md#mdb-admin) or the [`mdb_superuser`](../../concepts/roles.md#mdb-superuser) role.</p> | 1.1 | 1.2 | 1.2 | 1.3 | 1.3 | 1.3 | 1.4 ||
|| <p>[autoinc]({{ pg-docs }}/contrib-spi.html#id-1.11.7.47.6)</p><p>Contains the `autoinc()` function, which returns the next value of a sequence stored in an integer-type field. Unlike the built-in sequence types, `autoinc()` does the following:
* Blocks attempts to insert a query-provided value into the field.
* Allows the field value to be changed when updating a record.</p> | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 ||
|| <p>[bloom]({{ pg-docs }}/static/bloom.html)</p><p>Enables access to database indexes based on [Bloom filters](https://en.wikipedia.org/wiki/Bloom_filter). These probabilistic data structures require significantly less memory than hash tables but can return false-positive matches.</p> | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 ||
|| <p>[btree_gin]({{ pg-docs }}/static/btree-gin.html)</p><p>Contains examples of GIN (Generalized Inverted Index) operator classes used for inverted index searches.</p> | 1.3 | 1.3 | 1.3 | 1.3 | 1.3 | 1.3 | 1.3 ||
|| <p>[btree_gist]({{ pg-docs }}/static/btree-gist.html)</p><p>Contains GiST (Generalized Search Tree) operator classes. Unlike a B-tree index, GiST supports the `<>` (<q>not equal to</q>) and `<->` (<q>distance</q>) operators, but does not guarantee result uniqueness.</p> | 1.5 | 1.5 | 1.5 | 1.6 | 1.7 | 1.7 | 1.7 ||
|| <p>[citext]({{ pg-docs }}/static/citext.html)</p><p>Contains the `citext` data type for case-insensitive string operations.</p> | 1.5 | 1.6 | 1.6 | 1.6 | 1.6 | 1.6 | 1.6 ||
|| <p>[clickhouse_fdw](https://github.com/adjust/clickhouse_fdw)</p><p>Adds a [Foreign Data Wrapper](https://wiki.postgresql.org/wiki/Foreign_data_wrappers) for accessing {{ CH }} databases, with support for `SELECT FROM` and `INSERT INTO` operations.</p><p>The extension is not supported in {{ PG }} version 16 and above. Use [{{ data-transfer-full-name }}](../../../data-transfer/tutorials/rdbms-to-clickhouse.md) to import data into a {{ CH }} database.</p> | 1.3 | 1.3 | 1.3 | 1.4 | 1.4 | - | - ||
|| <p>[cube]({{ pg-docs }}/static/cube.html)</p><p>Contains the `cube` data type for representing multidimensional cubes.</p> | 1.4 | 1.4 | 1.4 | 1.5 | 1.5 | 1.5 | 1.5 ||
|| <p>[dblink]({{ pg-docs }}/static/dblink.html)</p><p>Enables connections to other {{ PG }} databases from within the current session.</p><p>To use this extension, you need the [`mdb_admin`](../../concepts/roles.md#mdb-admin) or [`mdb_superuser`](../../concepts/roles.md#mdb-superuser) role.</p> | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 ||
|| <p>[dict_int]({{ pg-docs }}/static/dict-int.html)</p><p>Contains an example of an additional dictionary template for full-text search. This template helps to control the size of the unique word list, which improves search performance.</p><p>For full-text search, you can also use [Hunspell dictionaries](hunspell.md) alongside the extension.</p> | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 ||
|| <p>[dict_xsyn]({{ pg-docs }}/static/dict-xsyn.html)</p><p>(Extended Synonym Dictionary) contains an example of an add-on dictionary template for full-text search. It allows searching for a word using any of its synonyms.</p><p>For full-text search, you can also use [Hunspell dictionaries](hunspell.md) alongside the extension.</p> | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | - ||
|| <p>[earthdistance]({{ pg-docs }}/static/earthdistance.html)</p><p>Provides a module for calculating distances between geographical points. Distance calculation is performed using two methods:
* Using the `cube` data type, which requires you to enable the `cube` extension.
* Using the built-in `point` data type.</p> | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 ||
|| <p>[fuzzystrmatch]({{ pg-docs }}/fuzzystrmatch.html)</p><p>Provides functions for calculating string similarity and distance.</p> | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 1.2 | 1.2 ||
|| <p>[hstore]({{ pg-docs }}/static/hstore.html)</p><p>Contains the `hstore` data type for storing and efficient use of <q>key:value</q> pairs within a single table field.</p> | 1.5 | 1.6 | 1.7 | 1.8 | 1.8 | 1.8 | 1.8 ||
|| <p>[hypopg](https://hypopg.readthedocs.io/en/rel1_stable/)</p><p>Contains virtual indexes. Virtual indexes provide a low-cost way to determine whether {{ PG }} will use real indexes for [problematic queries](../../tutorials/profiling.md#solving-inefficient-queries).</p> | 1.3.1 | 1.3.1 | 1.3.1 | 1.3.1 | 1.3.1 | 1.4.0 | 1.4.1 ||
|| <p>[intarray]({{ pg-docs }}/static/intarray.html)</p><p>Provides functions and operators for handling integer arrays containing no `NULL` values.</p> | 1.2 | 1.2 | 1.3 | 1.5 | 1.5 | 1.5 | 1.5 ||
|| <p>[isn]({{ pg-docs }}/static/isn.html)</p><p>Provides data types for international product numbering standards: EAN13, UPC, ISBN, ISMN, and ISSN. Numbers are validated and generated based on a predetermined list of prefixes.</p> | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 ||
|| <p>[jsquery](https://github.com/postgrespro/jsquery)</p><p>Adds JsQuery language support for the `jsonb` data type. JsQuery enables efficient search in nested objects and provides additional index-supported comparison operators.</p> | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 ||
|| <p>[lo]({{ pg-docs }}/static/lo.html)</p><p>Contains the `lo` data type and the `lo_manage()` function. They are used to manage BLOBs (Binary Large Objects) in compliance with the JDBC and ODBC driver specifications, as the standard {{ PG }} behavior is non-compliant.</p> | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 ||
|| <p>[logerrors](https://github.com/munakoiso/logerrors)</p><p>Enables the collection of message statistics from log files.</p> | - | - | - | - | - | - | 2.0 ||
|| <p>[ltree]({{ pg-docs }}/static/ltree.html)</p><p>Contains the `ltree` data type to represent data labels stored in a tree-structured hierarchy.</p> | 1.1 | 1.1 | 1.2 | 1.2 | 1.2 | 1.2 | 1.3 ||
|| <p>[lwaldump](https://github.com/g0djan/lwaldump/tree/REL_13_STABLE)</p><p>Enables you to retrieve the last LSN (log sequence number) written to the replica’s disk.</p> | - | - | - | - | - | - | 1.0 ||
|| <p>[moddatetime]({{ pg-docs }}/static/contrib-spi.html#id-1.11.7.47.8)</p><p>Provides the `moddatetime()` function for tracking the last modification time of a table row.</p> | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 ||
|| <p>[oracle_fdw](https://github.com/laurenz/oracle_fdw)</p><p>Adds a [Foreign Data Wrapper](https://wiki.postgresql.org/wiki/Foreign_data_wrappers) for accessing Oracle databases.</p><p>To use this extension, you need the [`mdb_admin`](../../concepts/roles.md#mdb-admin) or [`mdb_superuser`](../../concepts/roles.md#mdb-superuser) role.</p> | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 ||
|| <p>[orafce](https://github.com/orafce/orafce)</p><p>Provides functions and operators emulating Oracle database functions and packages.</p> | 3.18 | 3.18 | 3.18 | 3.18 | 3.25 | 4.6 | 4.13 ||
|| <p>[pg_buffercache]({{ pg-docs }}/pgbuffercache.html)</p><p>Provides functions for shared buffer cache monitoring.</p><p>To use this extension, you need the [`mdb_admin`](../../concepts/roles.md#mdb-admin) or [`mdb_superuser`](../../concepts/roles.md#mdb-superuser) role.</p> | 1.3 | 1.3 | 1.3 | 1.3 | 1.3 | 1.4 | 1.5 ||
|| <p>[pg_cron](https://github.com/citusdata/pg_cron)</p><p>Enables you to schedule database jobs and execute SQL queries directly within them.</p><p>Using this extension requires you to [enable the `pg_cron` shared library](#libraries-connection).</p><p>To use this extension, you need the [`mdb_admin`](../../concepts/roles.md#mdb-admin) or [`mdb_superuser`](../../concepts/roles.md#mdb-superuser) role.</p><p>Loading this extension will cause all hosts to restart. For more information, see [Using pg_cron](./pg_cron.md).</p> | 1.4.1 | 1.4.1 | 1.4.1 | 1.4.1 | 1.4.1 | 1.5 | 1.6 ||
|| <p>[pg_hint_plan](http://pghintplan.osdn.jp/)</p><p>Provides functions for managing the {{ PG }} planner.</p><p>Using this extension requires you to [enable the `pg_hint_plan` shared library](#libraries-connection).</p> | 1.3.4 | 1.3.5 | 1.3.7 | 1.4 | 1.5 | 1.6.0 | 1.7.0 ||
|| <p>[pg_partman](https://github.com/pgpartman/pg_partman)</p><p>Adds advanced table partitioning options, including time-based and sequence-based partitioning.</p>  | 4.0.0 | 4.2.0 | 4.4.0 | 4.6.0 | 4.7.0 | 4.7.4 | 5.1.0 ||
|| <p>[pg_prewarm]({{ pg-docs }}/pgprewarm.html)</p><p>Enables loading relation data into the OS cache or the {{ PG }} buffer cache.</p> | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 ||
|| <p>[pg_qualstats](https://github.com/powa-team/pg_qualstats)</p><p>Enables collection of predicate statistics from `WHERE` and `JOIN` clauses.</p><p>Using this extension requires you to [enable the `pg_qualstats` shared library](#libraries-connection).</p> | 2.0.3 | 2.0.3 | 2.0.3 | 2.0.3 | 2.0.4 | 2.1.0 | 2.1.1 ||
|| <p>[pg_repack](http://reorg.github.io/pg_repack/)</p><p>Provides functions for removing bloat from tables and indexes. Unlike `CLUSTER` and `VACUUM FULL`, these functions do not require exclusive table locks.</p><p>To use this extension, you need the [`mdb_admin`](../../concepts/roles.md#mdb-admin) or [`mdb_superuser`](../../concepts/roles.md#mdb-superuser) role.</p> | 1.4.6 | 1.4.6 | 1.4.6 | 1.4.7 | 1.4.8 | 1.4.8 | 1.4.8 ||
|| <p>[pg_stat_kcache](https://github.com/powa-team/pg_stat_kcache)</p><p>Enables collection of read and write operation statistics at the file system level.</p><p>Using this extension requires you to enable the `pg_stat_statements` extension.</p><p>To use this extension, you need the [`mdb_admin`](../../concepts/roles.md#mdb-admin) or [`mdb_superuser`](../../concepts/roles.md#mdb-superuser) role.</p> | 2.1.1 | 2.1.1 | 2.1.3 | 2.2.0 | 2.2.1 | 2.2.1 | 2.3.0 ||
|| <p>[pg_stat_query_plans](https://github.com/postgredients/pg_stat_query_plans)</p><p>Enables you to track SQL query execution statistics and query plans.</p><p>Using this extension requires you to [enable the `pg_stat_query_plans` shared library](#libraries-connection).</p> | - | - | - | - | - | - | 1.0 ||
|| <p>[pg_stat_statements]({{ pg-docs }}/pgstatstatements.html)</p><p>Enables you to track the scheduling and collect execution statistics of all SQL queries running in a cluster.</p><p>To use this extension, you need the [`mdb_monitor`](../../concepts/roles.md#mdb_monitor) role.</p> | 1.6 | 1.7 | 1.8 | 1.9 | 1.10 | 1.10 | 1.11 ||
|| <p>[pg_tm_aux](https://github.com/x4m/pg_tm_aux)</p><p>Enables you to create a logical replication slot in the past.</p> | 1.0 | 1.0 | 1.0 | 1.0 | 1.1 | 1.1.1 | 1.1.1 ||
|| <p>[pg_trgm]({{ pg-docs }}/static/pgtrgm.html)</p><p>Provides tools for fast similarity search across strings using trigram matching.</p> | 1.4 | 1.4 | 1.5 | 1.6 | 1.6 | 1.6 | 1.6 ||
|| <p>[pgaudit](https://www.pgaudit.org/)</p><p>Provides additional logging tools and enhanced auditing capabilities.</p><p>Using this extension requires you to [enable the `pgaudit` shared library](#libraries-connection).</p><p>For more information, see [Using pgaudit](./pgaudit.md).</p>  | 1.0.0 | 1.0.0 | 1.0.0 | 1.0.0 | 1.7 | 16.0 | 17.0 ||
|| <p>[pgcrypto]({{ pg-docs }}/static/pgcrypto.html)</p><p>Provides cryptographic functions for {{ PG }}. For more information, see [Using pgcrypto](./pgcrypto.md).</p> | 1.3 | 1.3 | 1.3 | 1.3 | 1.3 | 1.3 | 1.3 ||
|| <p>[pglogical](https://github.com/2ndQuadrant/pglogical)</p><p>Adds support for streaming logical replication based on the publish/subscribe model.</p><p>Using this extension requires you to [enable the `pglogical` shared library](#libraries-connection).</p> | 2.4.1 | 2.4.1 | 2.4.1 | 2.4.1 | 2.4.4 | 2.4.4 | 2.4.5 ||
|| <p>[pgrouting](http://pgrouting.org/)</p><p>Provides geospatial routing functions for the [PostGIS](https://www.postgis.net/) database.</p> | 2.6.2 | 2.6.2 | 3.0.2 | 3.3.0 | 3.4.1 | 3.5.0 | 3.6.2 ||
|| <p>[pgrowlocks]({{ pg-docs }}/static/pgrowlocks.html)</p><p>Contains the `pgrowlocks()` function returning row locking details for a specified table.</p> | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 ||
|| <p>[pgstattuple]({{ pg-docs }}/pgstattuple.html)</p><p>Provides functions for retrieving tuple-level statistics.</p><p>To use this extension, you need the [`mdb_admin`](../../concepts/roles.md#mdb-admin) or [`mdb_superuser`](../../concepts/roles.md#mdb-superuser) role.</p> | 1.5 | 1.5 | 1.5 | 1.5 | 1.5 | 1.5 | 1.5 ||
|| <p>[pgvector](https://github.com/pgvector/pgvector)</p><p>Provides vector similarity search functionality.</p> | 0.2.5 | 0.2.5 | 0.2.5 | 0.2.5 | 0.3.2 | 0.8.0 | 0.8.0 ||
|| <p>[plpgsql](https://www.timescale.com/learn/postgresql-extensions-plpgsql)</p><p>Adds support for the PL/pgSQL procedural language.</p> | - | - | - | - | - | - | 1.0 ||
|| <p>[plv8](https://plv8.github.io/)</p><p>Adds support for the plv8 JavaScript-based procedural language powered by the V8 engine.</p> | 3.0.0 | 3.0.0 | 3.0.0 | 3.0.0 | - | 3.2.3 | 3.2.3 ||
|| <p>[postgis](https://postgis.net/docs/)</p><p>Adds capabilities for storing and processing GIS (Geographic Information System) objects in {{ PG }} databases.</p> | 2.5.2 | 3.0.0 | 3.1.4 | 3.1.4 | 3.3.2 | 3.4.0 | 3.4.3 ||
|| <p>[postgis_tiger_geocoder](https://postgis.net/docs/postgis_installation.html#loading_extras_tiger_geocoder)</p><p>Provides functions for geocoding using data in the [TIGER](https://wiki.openstreetmap.org/wiki/TIGER) format.</p> | 2.5.2 | 3.0.0 | 3.1.4 | 3.1.4 | 3.3.2 | 3.4.0 | 3.4.3 ||
|| <p>[postgis_topology](https://postgis.net/docs/Topology.html)</p><p>Contains data types and functions of the `postgis` extension for managing topological objects.</p> | 2.5.2 | 3.0.0 | 3.1.4 | 3.1.4 | 3.3.2 | 3.4.0 | 3.4.3 ||
|| <p>[postgres_fdw]({{ pg-docs }}/static/postgres-fdw.html)</p><p>Adds a [Foreign Data Wrapper](https://wiki.postgresql.org/wiki/Foreign_data_wrappers) for accessing external {{ PG }} servers.</p><p>To use this extension, you need the [`mdb_admin`](../../concepts/roles.md#mdb-admin) or [`mdb_superuser`](../../concepts/roles.md#mdb-superuser) role.</p> | 1.0 | 1.0 | 1.0 | 1.1 | 1.1 | 1.1 | 1.1 ||
|| <p>[postgresql_anonymizer](https://postgresql-anonymizer.readthedocs.io/en/stable/)</p><p>Enables you to mask or substitute data in a {{ PG }} database.</p><p>Using this extension requires you to [enable the `anon` shared library](#libraries-connection).</p><p>For more information, see [Using postgresql_anonymizer](./pg_anon.md).</p><p>To use this extension, you need the [`mdb_admin`](../../concepts/roles.md#mdb-admin) or [`mdb_superuser`](../../concepts/roles.md#mdb-superuser) role.</p> | - | - | - | - | 1.3.2 | 1.3.2 | 1.3.2 ||
|| <p>[rum](https://github.com/postgrespro/rum)</p><p>Provides an access method for `RUM` index operations.</p> | 1.3 | 1.3 | 1.3 | 1.3 | 1.3 | 1.3 | 1.3 ||
|| <p>[seg]({{ pg-docs }}/static/seg.html)</p><p>Contains the `seg` data type to represent line segments or floating-point intervals.</p> | 1.3 | 1.3 | 1.3 | 1.4 | 1.4 | 1.4 | 1.4 ||
|| <p>[smlar](http://sigaev.ru/git/gitweb.cgi?p=smlar.git;a=blob;hb=HEAD;f=README)</p><p>Provides functions for calculating array similarity.</p> | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 ||
|| <p>[tablefunc](https://www.postgresql.org/docs/current/static/tablefunc.html)</p><p>Provides functions returning row sets.</p> | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 ||
|| <p>[timescaledb](https://github.com/timescale/timescaledb)</p><p>Enables automatic table partitioning by time and partition key, while preserving the standard {{ PG }} data interface. This provides the scalability needed to process time-series in {{ PG }}.</p><p>Using this extension requires you to [enable the `timescaledb` shared library](#libraries-connection).</p><p>The service includes TimescaleDB Apache 2 Edition, which offers reduced functionality compared to TimescaleDB Community Edition. You cannot change the edition. For more details on limitations, see the [TimescaleDB guides](https://docs.timescale.com/about/latest/timescaledb-editions/).</p> | 2.3.1 | 2.4.2 | 2.5.2 | 2.6.1 | 2.9.0 | 2.20.3 | 2.20.3 ||
|| <p>[unaccent]({{ pg-docs }}/static/unaccent.html)</p><p>Provides a dictionary for diacritic-insensitive text search.</p> | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 ||
|| <p>[uuid-ossp]({{ pg-docs }}/static/uuid-ossp.html)</p><p>Provides functions for generating UUIDs according to standard algorithms.</p> | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 ||
|| <p>[xml2]({{ pg-docs }}/static/xml2.html)</p><p>Adds support for Xpath and XSLT.</p> | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 ||
|#

The [pgcompacttable](https://github.com/dataegret/pgcompacttable) utility reorganizes table data to reduce its footprint without impacting cluster performance.

Command syntax:

```bash
./bin/pgcompacttable \
  -h c-<cluster_ID>.rw.{{ dns-zone }} \
  -p 6432 \
  -U <username> \
  -W <password> \
  -d <DB_name> \
  -n <schema_name> \
  -t <table_name>
```

Using this utility requires you to enable the `pgstattuple` extension.

To use it, you need the [`mdb_admin`](../../concepts/roles.md#mdb-admin) role or the [`mdb_superuser`](../../concepts/roles.md#mdb-superuser) role.

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
