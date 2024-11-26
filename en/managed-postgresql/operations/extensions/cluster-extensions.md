# Managing extensions

{{ mpg-short-name }} supports many standard and some non-standard {{ PG }} extensions. A complete list of available extensions and versions based on the {{ PG }} version [is provided below](#postgresql).

{% note warning %}

In {{ mpg-short-name }} clusters, you cannot manage {{ PG }} extensions using SQL commands.

{% endnote %}

## Enabling libraries for extensions {#libraries-connection}

For some extensions, you need to enable shared libraries. To link a library when [creating](../cluster-create.md) or [editing](../update.md#change-postgresql-config) a cluster, specify its name in the [Shared preload libraries parameter](../../concepts/settings-list#setting-shared-libraries).

You can install the following libraries in {{ mpg-short-name }}:

* `auto_explain`: Required for the [auto_explain extension]({{ pg-docs }}/auto-explain.html) to function.
* `pgaudit`: Required for the [pgaudit extension](https://www.pgaudit.org/) to function.
* `pg_cron`: Required for the [pg_cron extension](https://github.com/citusdata/pg_cron) to function.
* `pg_hint_plan`: Required for the [pg_hint_plan extension](https://pghintplan.osdn.jp/pg_hint_plan.html) to function.
* `pg_qualstats`: Required for the [pg_qualstats extension](https://github.com/powa-team/pg_qualstats) to function.
* `timescaledb`: Required to use the [TimescaleDB extension](https://github.com/timescale/timescaledb).
* `anon`: Required to use the [postgresql_anonymizer extension](https://postgresql-anonymizer.readthedocs.io/en/stable/).

{% note warning %}

Enabling a shared library will cause {{ PG }} to restart on the master host.

{% endnote %}

## Retrieving a list of installed extensions {#list-extensions}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.postgresql.cluster.switch_databases }}** section.
  1. In the **{{ ui-key.yacloud.mdb.cluster.databases.column_extensions }}** column, you will see a list of extensions enabled for each database.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To get a list of extensions for a database, run the command:

  ```bash
  {{ yc-mdb-pg }} database get <DB_name> \
     --cluster-name <cluster_name>
  ```

  The `extensions` list will show the enabled extensions.

- REST API {#api}

  1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Database.get](../../api-ref/Database/get.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/databases/<DB_name>'
     ```

     You can get the cluster ID with the [list of clusters in your folder](../cluster-list.md#list-clusters) and the DB name, with the [list of databases in your cluster](../databases.md#list-db).

  1. View the [server response](../../api-ref/Database/get.md#responses) to make sure the request was successful.

     You can see the list of installed extensions in the `extensions` parameter of the command output.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [DatabaseService/Get](../../api-ref/grpc/Database/get.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

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

     You can get the cluster ID with the [list of clusters in your folder](../cluster-list.md#list-clusters) and the DB name, with the [list of databases in your cluster](../databases.md#list-db).

  1. View the [server response](../../api-ref/grpc/Database/get.md#yandex.cloud.mdb.postgresql.v1.Database) to make sure the request was successful.

     You can see the list of installed extensions in the `extensions` parameter of the command output.

{% endlist %}

## Editing a list of installed extensions {#update-extensions}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.postgresql.cluster.switch_databases }}** tab.
  1. In the row with the DB you need, click ![options](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.databases.button_action-manage }}**.
  1. Select the extensions you need and click **{{ ui-key.yacloud.postgresql.databases.dialog.button_submit }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To update extensions for a database, provide their list in the `--extensions` argument of the CLI command. The extensions that are not on the list will be disabled.

  ```bash
  {{ yc-mdb-pg }} database update <DB_name> \
     --cluster-name <cluster_name>
     --extensions <extension_name>=<version>,<extension_name>=<version>...
  ```

  {% note info %}

  The extension version is not considered when handling the command: you can pass any non-empty string as a version.

  {% endnote %}

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

     For more information about creating this file, see [Creating clusters](../cluster-create.md).

     For a complete list of editable {{ mpg-name }} cluster database configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_postgresql_database).

  1. Add one or more `extension` sections (one section for each extension) to the description of the appropriate cluster database:

      ```hcl
      resource "yandex_mdb_postgresql_database" "<DB_name>" {
        ...
        extension {
          name    = "<extension_name>"
          version = "<extension_version>"
        }
        ...
      }
      ```

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Database.update](../../api-ref/Database/update.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

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
                     "name": "<extension_name>",
                     "version": "<extension_version>"
                   },
                   { <similar_configuration_for_extension_2> },
                   { ... },
                   { <similar_configuration_for_extension_N> }
                 ]
               }'
     ```

     Where:

     * `updateMask`: List of parameters to update as a single string, separated by commas.

       In this case, only one parameter is provided.

     * `extensions`: Array of DB extensions. Each object represents one extension and has the following structure:

       * `name`: Extension name.
       * `version`: Extension version.

       Specify the name and version from the [list of supported {{ PG }} extensions and utilities](#postgresql).

     You can get the cluster ID with the [list of clusters in your folder](../cluster-list.md#list-clusters), and the DB name with the [list of databases in your cluster](../databases.md#list-db).

  1. View the [server response](../../api-ref/Database/update.md#responses) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [DatabaseService/Update](../../api-ref/grpc/Database/update.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

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
                 "name": "<extension_name>",
                 "version": "<extension_version>"
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

     * `update_mask`: List of parameters to update as an array of `paths[]` strings.

       In this case, only one parameter is provided.

     * `extensions`: Array of DB extensions. One array element contains settings for a single extension and has the following structure:

       * `name`: Extension name.
       * `version`: Extension version.

       Specify the name and version from the [list of supported {{ PG }} extensions and utilities](#postgresql).

     You can get the cluster ID with the [list of clusters in your folder](../cluster-list.md#list-clusters) and the DB name, with the [list of databases in your cluster](../databases.md#list-db).

  1. View the [server response](../../api-ref/grpc/Database/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Supported {{ PG }} extensions and utilities {#postgresql}

#|
|| **Extension** \ **{{ PG }} version** | **11** | **12** | **13** | **14** | **15** | **16** ||
|| <p>[address_standardizer](https://postgis.net/docs/manual-3.1/postgis_installation.html#installing_pagc_address_standardizer)</p><p>Provides normalization functions for postal addresses provided as a string.</p> | 2.5.2 | 3.0.0 | 3.1.4 | 3.1.4 | 3.3.2 | 3.4.0 ||
|| <p>[address_standardizer_data_us](https://postgis.net/docs/manual-3.1/postgis_installation.html#make_install_postgis_extensions)</p><p>Contains normalization rules for the US and Canadian mailing addresses for the `address_standardizer` extension.</p> | 2.5.2 | 3.0.0 | 3.1.4 | 3.1.4 | 3.3.2 | 3.4.0 ||
|| <p>[amcheck]({{ pg-docs }}/amcheck.html)</p><p>Provides functions that allow you to verify the logical consistency of the relation structure.</p><p>You need the [`mdb_admin`](../../concepts/roles.md#mdb-admin) role to use this extension.</p> | 1.1 | 1.2 | 1.2 | 1.3 | 1.3 | 1.3 ||
|| <p>[autoinc]({{ pg-docs }}/contrib-spi.html#id-1.11.7.47.6)</p><p>Contains the `autoinc()` function. It stores the next value of a sequence into an integer field. Unlike the built-in types that control sequences, `autoinc()`:
* Overrides attempts to insert a different field value from a query.
* Allows modifying field values during updates.</p> | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 ||
|| <p>[bloom]({{ pg-docs }}/static/bloom.html)</p><p>Enables access to database indexes based on [Bloom filters](https://en.wikipedia.org/wiki/Bloom_filter). These probabilistic data structures require significantly less storage space than hash tables. However, false positives are possible.</p> | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 ||
|| <p>[btree_gin]({{ pg-docs }}/static/btree-gin.html)</p><p>Contains examples of GIN (Generalized Inverted Index) operator classes used for inverted searches.</p> | 1.3 | 1.3 | 1.3 | 1.3 | 1.3 | 1.3 ||
|| <p>[btree_gist]({{ pg-docs }}/static/btree-gist.html)</p><p>Contains GiST (Generalized Search Tree) operator classes. Unlike B-tree indexes, GiST supports the `<>` (<q>not equal to</q>) and `<->` (<q>distance</q>) operators. However, it does not ensure uniqueness of the values it returns.</p> | 1.5 | 1.5 | 1.5 | 1.6 | 1.7 | 1.7 ||
|| <p>[citext]({{ pg-docs }}/static/citext.html)</p><p>Contains the `citext` data type that allows using case-insensitive strings.</p> | 1.5 | 1.6 | 1.6 | 1.6 | 1.6 | 1.6 ||
|| <p>[clickhouse_fdw](https://github.com/adjust/clickhouse_fdw)</p><p>Adds support for [Foreign Data Wrapper](https://wiki.postgresql.org/wiki/Foreign_data_wrappers) for accessing {{ CH }} database, supports `SELECT FROM` and `INSERT INTO` transactions.</p> | 1.3 | 1.3 | 1.3 | - | 1.4 | - ||
|| <p>[cube]({{ pg-docs }}/static/cube.html)</p><p>Contains the `cube` data type used for representing multidimensional cubes.</p> | 1.4 | 1.4 | 1.4 | 1.5 | 1.5 | 1.5 ||
|| <p>[dblink]({{ pg-docs }}/static/dblink.html)</p><p>Allows connecting to other {{ PG }} databases from the current session.</p><p>You need the [`mdb_admin`](../../concepts/roles.md#mdb-admin) role to use this extension.</p> | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 ||
|| <p>[dict_int]({{ pg-docs }}/static/dict-int.html)</p><p>Contains an example of an add-on dictionary template for full-text search. It allows preventing excessive growth of a list of unique words and speeding up search.</p><p>In addition to extensions, you can also use [Hunspell dictionaries](hunspell.md) for full-text search.</p> | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 ||
|| <p>[dict_xsyn]({{ pg-docs }}/static/dict-xsyn.html)</p><p>(Extended Synonym Dictionary) contains an example of an add-on dictionary template for full-text search. It allows searching for a word using any of its synonyms.</p><p>In addition to extensions, you can also use [Hunspell dictionaries](hunspell.md) for full-text search.</p> | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 ||
|| <p>[earthdistance]({{ pg-docs }}/static/earthdistance.html)</p><p>Provides a module for calculating distances between geographical points. There are two ways to calculate them:
* Using the `cube` data type (you need to enable the `cube` extension).
* Using the built-in `point` data type.</p> | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 ||
|| <p>[fuzzystrmatch]({{ pg-docs }}/fuzzystrmatch.html)</p><p>Provides functions to determine similarities and distance between strings.</p> | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 1.2 ||
|| <p>[hstore]({{ pg-docs }}/static/hstore.html)</p><p>Implements the `hstore` data type for storing and efficient use of <q>key:value</q> pairs within a single table field.</p> | 1.5 | 1.6 | 1.7 | 1.8 | 1.8 | 1.8 ||
|| <p>[hypopg](https://hypopg.readthedocs.io/en/rel1_stable/)</p><p>Adds support for virtual, or hypothetical, indexes. They are useful to discover if {{ PG }} will use real indexes to handle [problematic queries](../../tutorials/profiling.md#solving-inefficient-queries) without having to spend resources to create them.</p> | 1.3.1 | 1.3.1 | 1.3.1 | 1.3.1 | 1.3.1 | 1.4.0 ||
|| <p>[intarray]({{ pg-docs }}/static/intarray.html)</p><p>Provides functions and operators to work with arrays of integers containing no `NULL` values.</p> | 1.2 | 1.2 | 1.3 | 1.5 | 1.5 | 1.5 ||
|| <p>[isn]({{ pg-docs }}/static/isn.html)</p><p>Provides data types for international product numbering standards such as EAN13, UPC, ISBN, ISMN, and ISSN. Numbers are validated on input according to a hard-coded list of prefixes.</p> | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 ||
|| <p>[jsquery](https://github.com/postgrespro/jsquery)</p><p>Adds support for the JsQuery language to work with the `jsonb` data type. JsQuery provides a simple and effective way to search in nested objects and more comparison operators with index support.</p> | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 ||
|| <p>[lo]({{ pg-docs }}/static/lo.html)</p><p>Contains the `lo` data type and `lo_manage()` function. They are used for managing Binary Large Objects (BLOBs) based on the JDBC and ODBC driver specifications (standard {{ PG }} behavior does not conform to them).</p> | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 ||
|| <p>[ltree]({{ pg-docs }}/static/ltree.html)</p><p>Contains the `ltree` data type for representing labels of data stored in a hierarchical tree-like structure.</p> | 1.1 | 1.1 | 1.2 | 1.2 | 1.2 | 1.2 ||
|| <p>[moddatetime]({{ pg-docs }}/static/contrib-spi.html#id-1.11.7.47.8)</p><p>Contains the `moddatetime()` function that allows tracking the table row's last modification time.</p> | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 ||
|| <p>[oracle_fdw](https://github.com/laurenz/oracle_fdw)</p><p>Adds support for [Foreign Data Wrapper](https://wiki.postgresql.org/wiki/Foreign_data_wrappers) for Oracle database access.</p><p>You need the [`mdb_admin`](../../concepts/roles.md#mdb-admin) role to use this extension.</p> | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 ||
|| <p>[orafce](https://github.com/orafce/orafce)</p><p>Adds functions and operators that emulate Oracle functionality and packages.</p> | 3.18 | 3.18 | 3.18 | 3.18 | 3.25 | 4.6 ||
|| <p>[pg_buffercache]({{ pg-docs }}/pgbuffercache.html)</p><p>Provides functions for monitoring the shared buffer cache.</p><p>You need the [`mdb_admin`](../../concepts/roles.md#mdb-admin) role to use this extension.</p> | 1.3 | 1.3 | 1.3 | 1.3 | 1.3 | 1.4 ||
|| <p>[pg_cron](https://github.com/citusdata/pg_cron)</p><p>Enables you to add scheduled jobs to a database and execute SQL commands directly from a job.</p><p>Requires enabling the `pg_cron` [shared library](#libraries-connection).</p><p>You need the [`mdb_admin`](../../concepts/roles.md#mdb-admin) role to use this extension.</p><p>Enabling the extension causes all hosts to restart. For more information, see [Using pg_cron](./pg_cron.md).</p>  | 1.4.1 | 1.4.1 | 1.4.1 | 1.4.1 | 1.4.1 | 1.5 ||
|| <p>[pg_hint_plan](http://pghintplan.osdn.jp/)</p><p>Provides functions for managing the {{ PG }} planner.</p><p>Requires enabling the `pg_hint_plan` [shared library](#libraries-connection).</p> | 1.3.4 | 1.3.5 | 1.3.7 | 1.4 | - | 1.6.0 ||
|| <p>[pg_partman](https://github.com/pgpartman/pg_partman)</p><p>Extends support for table partitioning, including time-based and serial-based.</p>  | 4.0.0 | 4.2.0 | 4.4.0 | 4.6.0 | 4.7.0 | 4.7.4 ||
|| <p>[pg_qualstats](https://github.com/powa-team/pg_qualstats)</p><p>Allows collecting statistics on predicates found in `WHERE` statements and `JOIN` clauses.</p><p>Requires enabling the `pg_qualstats` [shared library](#libraries-connection).</p> | 2.0.3 | 2.0.3 | 2.0.3 | 2.0.3 | 2.0.4 | 2.1.0 ||
|| <p>[pg_prewarm]({{ pg-docs }}/pgprewarm.html)</p><p>Allows loading relation data into either the operating system buffer cache or the {{ PG }} buffer cache.</p> | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 ||
|| <p>[pg_repack](http://reorg.github.io/pg_repack/)</p><p>Contains functions to remove bloat from tables and indexes. Unlike `CLUSTER` and `VACUUM FULL`, it does not require an exclusive lock on the tables.</p><p>You need the [`mdb_admin`](../../concepts/roles.md#mdb-admin) role to use this extension.</p> | 1.4.6 | 1.4.6 | 1.4.6 | 1.4.7 | 1.4.8 | 1.4.8 ||
|| <p>[pg_stat_kcache](https://github.com/powa-team/pg_stat_kcache)</p><p>Allows gathering statistics about reads and writes performed at the file system level.</p><p>Requires enabling the `pg_stat_statements` extension.</p><p>You need the [`mdb_admin`](../../concepts/roles.md#mdb-admin) role to use this extension.</p> | 2.1.1 | 2.1.1 | 2.1.3 | 2.2.0 | 2.2.1 | 2.2.1 ||
|| <p>[pg_stat_statements]({{ pg-docs }}/pgstatstatements.html)</p><p>Tracks planning and execution statistics of all SQL queries run in a cluster.</p><p>You need the [`mdb_monitor` role](../../concepts/roles.md#mdb_monitor) to use this extension.</p> | 1.6 | 1.7 | 1.8 | 1.9 | 1.10 | 1.10 ||
|| <p>[pg_tm_aux](https://github.com/x4m/pg_tm_aux)</p><p>Enables you to create a logical replication slot in the past.</p> | 1.0 | 1.0 | 1.0 | 1.0 | 1.1 | 1.1.1 ||
|| <p>[pg_trgm]({{ pg-docs }}/static/pgtrgm.html)</p><p>Provides tools for fast searching for similar strings based on trigram matching.</p> | 1.4 | 1.4 | 1.5 | 1.6 | 1.6 | 1.6 ||
|| <p>[pgaudit](https://www.pgaudit.org/)</p><p>The extension provides additional logging tools and enhances the audit features.</p><p>Requires enabling the `pgaudit` [shared library](#libraries-connection).</p><p>For more information, see [Using pgaudit](./pgaudit.md).</p>  | 1.0.0 | 1.0.0 | 1.0.0 | 1.0.0 | 1.7 | 16.0 ||
|| <p>[pgcrypto]({{ pg-docs }}/static/pgcrypto.html)</p><p>Provides cryptographic functions for {{ PG }}. For more information, see [Using pgcrypto](./pgcrypto.md).</p> | 1.3 | 1.3 | 1.3 | 1.3 | 1.3 | 1.3 ||
|| <p>[pglogical](https://github.com/2ndQuadrant/pglogical)</p><p>Adds support for logical streaming replication using the publish-subscribe mechanism.</p> | 2.4.1 | 2.4.1 | 2.4.1 | 2.4.1 | - | 2.4.3 ||
|| <p>[pgrouting](http://pgrouting.org/)</p><p>Extends the [PostGIS](https://www.postgis.net/) database to provide geospatial routing functionality.</p> | 2.6.2 | 2.6.2 | 3.0.2 | 3.3.0 | 3.4.1 | 3.5.0 ||
|| <p>[pgrowlocks]({{ pg-docs }}/static/pgrowlocks.html)</p><p>Contains the `pgrowlocks()` function to return row locking information for the specified table.</p> | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 ||
|| <p>[pgstattuple]({{ pg-docs }}/pgstattuple.html)</p><p>Provides functions to obtain tuple-level statistics.</p><p>You need the [`mdb_admin`](../../concepts/roles.md#mdb-admin) role to use this extension.</p> | 1.5 | 1.5 | 1.5 | 1.5 | 1.5 | 1.5 ||
|| <p>[pgvector](https://github.com/pgvector/pgvector)</p><p>Adds a vector similarity search.</p> | 0.2.5 | 0.2.5 | 0.2.5 | 0.2.5 | 0.3.2 | 0.5.1 ||
|| <p>[plv8](https://plv8.github.io/)</p><p>Adds support for PLV8, a V8 JavaScript-based procedural language.</p> | 3.0.0 | 3.0.0 | 3.0.0 | 3.0.0 | - | 3.2.0 ||
|| <p>[postgis](https://postgis.net/docs/)</p><p>Allows GIS (Geographic Information Systems) objects to be stored and handled in {{ PG }} databases.</p> | 2.5.2 | 3.0.0 | 3.1.4 | 3.1.4 | 3.3.2 | 3.4.0 ||
|| <p>[postgis_tiger_geocoder](https://postgis.net/docs/postgis_installation.html#loading_extras_tiger_geocoder)</p><p>Provides functions for geocoding based on [TIGER](https://wiki.openstreetmap.org/wiki/TIGER) data.</p> | 2.5.2 | 3.0.0 | 3.1.4 | 3.1.4 | 3.3.2 | 3.4.0 ||
|| <p>[postgis_topology](https://postgis.net/docs/Topology.html)</p><p>Contains `postgis` extension data types and functions to manage topology objects.</p> | 2.5.2 | 3.0.0 | 3.1.4 | 3.1.4 | 3.3.2 | 3.4.0 ||
|| <p>[postgres_fdw]({{ pg-docs }}/static/postgres-fdw.html)</p><p>Adds support for [Foreign Data Wrapper](https://wiki.postgresql.org/wiki/Foreign_data_wrappers) for access to external {{ PG }} servers.</p><p>You need the [`mdb_admin`](../../concepts/roles.md#mdb-admin) role to use this extension.</p> | 1.0 | 1.0 | 1.0 | 1.1 | 1.1 | 1.1 ||
|| <p>[postgresql_anonymizer](https://postgresql-anonymizer.readthedocs.io/en/stable/)</p><p>Masks or replaces data in a {{ PG }} database.</p><p>Requires enabling the `anon` [shared library](#libraries-connection).</p><p>You need the [`mdb_admin`](../../concepts/roles.md#mdb-admin) role to use this extension.</p> | - | - | - | - | 1.3.2 | 1.3.2 ||
|| <p>[rum](https://github.com/postgrespro/rum)</p><p>Provides an access method to work with `RUM` indexes.</p> | 1.3 | 1.3 | 1.3 | 1.3 | 1.3 | 1.3 ||
|| <p>[seg]({{ pg-docs }}/static/seg.html)</p><p>Contains the `seg` data type for representing line segments or floating point intervals.</p> | 1.3 | 1.3 | 1.3 | 1.4 | 1.4 | 1.4 ||
|| <p>[smlar](http://sigaev.ru/git/gitweb.cgi?p=smlar.git;a=blob;hb=HEAD;f=README)</p><p>Provides a set of functions for computing similarity of two arrays.</p> | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 ||
|| <p>[tablefunc](https://www.postgresql.org/docs/current/static/tablefunc.html)</p><p>Provides a set of functions that return tables, i.e., multiple rows.</p> | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 ||
|| <p>[timescaledb](https://github.com/timescale/timescaledb)</p><p>Supports automatic partitioning across time and space (partitioning key), yet retains the standard {{ PG }} interface for data. This makes {{ PG }} scalable for time-series.</p><p>Requires enabling the `timescaledb` [shared library](#libraries-connection).</p><p>The TimescaleDB edition installed for the service is TimescaleDB Apache 2 Edition. It has limited functionality compared to TimescaleDB Community Edition. You cannot change the edition. For more information about the limitations, see the [TimescaleDB documentation](https://docs.timescale.com/about/latest/timescaledb-editions/).</p> | 2.3.1 | 2.4.2 | 2.5.2 | 2.6.1 | 2.9.0 | 2.13.0-dev ||
|| <p>[unaccent]({{ pg-docs }}/static/unaccent.html)</p><p>Provides a text search dictionary that removes diacritic signs.</p> | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 ||
|| <p>[uuid-ossp]({{ pg-docs }}/static/uuid-ossp.html)</p><p>Provides functions to generate universally unique identifiers (UUIDs) using standard algorithms.</p> | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 ||
|| <p>[xml2]({{ pg-docs }}/static/xml2.html)</p><p>Provides XPath querying and XSLT (Extensible Stylesheet Language Transformations) functionality.</p> | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 ||
|#

[pgcompacttable](https://github.com/dataegret/pgcompacttable) is designed to reorganize data in tables in order to revert back disk space without database performance impact.

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

Requires enabling the `pgstattuple` extension.

To use it, you need the [`mdb_admin`](../../concepts/roles.md#mdb-admin) role.

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
