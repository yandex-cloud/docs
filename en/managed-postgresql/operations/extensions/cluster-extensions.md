# Managing extensions

{{ mpg-short-name }} supports many standard and some non-standard {{ PG }} extensions. A complete list of available extensions and versions based on the {{ PG }} version [is provided below](#postgresql).

{% note warning %}

In {{ mpg-short-name }} clusters, you can't manage {{ PG }} extensions using SQL commands.

{% endnote %}

## Enabling libraries for extensions {#libraries-connection}

For some extensions, you need to enable shared libraries. To link a library when [creating](../cluster-create.md) or [editing](../update.md#change-postgresql-config) a cluster, specify its name in the [Shared preload libraries parameter](../concepts/settings-list#setting-shared-libraries).

You can install the following libraries in {{ mpg-short-name }}:

* `auto_explain`: Required for the [auto_explain extension]({{ pg-docs }}/auto-explain.html) to function.
* `pg_cron`: Required for the [pg_cron extension](https://github.com/citusdata/pg_cron) to function.
* `pg_hint_plan`: Required for the [pg_hint_plan extension](https://pghintplan.osdn.jp/pg_hint_plan.html) to function.
* `pg_qualstats`: Required for the [pg_qualstats extension](https://github.com/powa-team/pg_qualstats) to function.
* `timescaledb`: Required to be able to use the [TimescaleDB extension](https://github.com/timescale/timescaledb).

{% note warning %}

Enabling a shared library will cause {{ PG }} to restart on the master host.

{% endnote %}

## Retrieving a list of installed extensions {#list-extensions}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Click on the name of the cluster you need and select the **Databases** section.
   1. In the **PostgreSQL extensions** column, you'll see a list of extensions enabled for each database.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To get a list of extensions for a database, run the command:

   ```bash
   {{ yc-mdb-pg }} database get <database name> \
      --cluster-name <cluster name>
   ```

   The enabled extensions will be listed in the `extensions` list.

- API

   To get a list of extensions for the cluster database, use the [get](../../api-ref/Database/get.md) method.

{% endlist %}

## Editing a list of installed extensions {#update-extensions}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Click on the name of the cluster you need and select the **Databases** tab.
   1. In the row with the desired database, click ![options](../../../_assets/horizontal-ellipsis.svg) and select **Configure PostgreSQL extensions**.
   1. Select the extensions you need and click **Edit**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To change extensions for a database, pass their list in the `--extensions` argument of a CLI command. In this case, extensions that are not included in the list will be disabled.

   ```bash
   {{ yc-mdb-pg }} database update <database name> \
      --cluster-name <cluster name>
      --extensions <extension name>=<version>,<extension name>=<version>...
   ```

   {% note info %}

   The extension version is not considered when handling the command: you can pass any non-empty string as a version.

   {% endnote %}

- Terraform

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](../cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

   1. Add one or more `extension` blocks (one for each extension) to the relevant `database` section of the {{ mpg-name }} cluster description:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster name>" {
        ...
        database {
          ...
          extension {
            name    = "<extension name>"
            version = "<extension version>"
          }
          ...
        }
        ...
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../../_includes/mdb/mpg/terraform/timeouts.md) %}

- API

   To pass a new list of DB extensions, use the [update](../../api-ref/Database/update.md) method.

{% endlist %}

## Supported {{ PG }} extensions and utilities {#postgresql}

#|
|| **Extension** \ **{{ PG }} version** | **10** | **11** | **12** | **13** | **14** ||
|| [address_standardizer](https://postgis.net/docs/manual-3.1/postgis_installation.html#installing_pagc_address_standardizer)
Provides functions that normalize postal addresses sent as a line.
| 2.5.2 | 2.5.2 | 3.0.0 | 3.1.4 | 3.1.4 ||
|| [address_standardizer_data_us](https://postgis.net/docs/manual-3.1/postgis_installation.html#make_install_postgis_extensions)
Provides rules for normalizing US and Canadian postal addresses for the `address_standardizer` extension.
| 2.5.2 | 2.5.2 | 3.0.0 | 3.1.4 | 3.1.4 |||
|| [amcheck]({{ pg-docs }}/amcheck.html)
Provides functions that let you verify the logical consistency of the structure of relations.
To use the extension, you need the [`mdb_admin` role](../../concepts/roles.md#mdb-admin).
| 1.0 | 1.1 | 1.2 | 1.2 | 1.3 ||
|| [autoinc]({{ pg-docs }}/contrib-spi.html#id-1.11.7.47.6)
Provides the `autoinc()` function. It stores the next value of a sequence into an integer field. Unlike built-in types that control sequences, `autoinc()`:
* Overrides attempts to insert a different field value from a query.
* Allows modifying field values during updates.
| 1.0 | 1.0 | 1.0 | 1.0 | 1.0 ||
|| [bloom]({{ pg-docs }}/static/bloom.html)
Adds access to database indexes based on [Bloom filters]({% if lang == "ru" %}https://ru.wikipedia.org/wiki/Фильтр_Блума{% endif %}{% if lang == "en" %}https://en.wikipedia.org/wiki/Bloom_filter{% endif %}). These probabilistic data structures require significantly less storage space than hash tables. However, false positives are possible.
| 1.0 | 1.0 | 1.0 | 1.0 | 1.0 ||
|| [btree_gin]({{ pg-docs }}/static/btree-gin.html)
Provides sample GIN (Generalized Inverted Index) operator classes used for inverted searches.
| 1.2 | 1.3 | 1.3 | 1.3 | 1.3 ||
|| [btree_gist]({{ pg-docs }}/static/btree-gist.html)
Provides GiST (Generalized Search Tree) operator classes. Unlike a B-tree index, GiST supports operators such as `<>` (<q>not equal to</q>) and `<->` (<q>distance</q>). However, it doesn't ensure the uniqueness of values it returns.
| 1.5 | 1.5 | 1.5 | 1.5 | 1.6 ||
|| [citext]({{ pg-docs }}/static/citext.html)
Provides the `citext` case-insensitive character string type.
| 1.4 | 1.5 | 1.6 | 1.6 | 1.6 ||
|| [clickhouse_fdw](https://github.com/adjust/clickhouse_fdw)
Supports a [Foreign Data Wrapper](https://wiki.postgresql.org/wiki/Foreign_data_wrappers) for accessing {{ CH }} databases. Supports `SELECT FROM` and `INSERT INTO` transactions.
| - | 1.3 | 1.3 | 1.3 | - ||
|| [cube]({{ pg-docs }}/static/cube.html)
Provides the `cube` data type for representing multidimensional cubes.
| 1.2 | 1.4 | 1.4 | 1.4 | 1.5 ||
|| [dblink]({{ pg-docs }}/static/dblink.html)
Supports connections to other {{ PG }} databases from within a database session.
To use the extension, you need the [`mdb_admin` role](../../concepts/roles.md#mdb-admin).
| 1.2 | 1.2 | 1.2 | 1.2 | 1.2 ||
|| [dict_int]({{ pg-docs }}/static/dict-int.html)
Provides an example of an add-on dictionary template for full-text search. It allows preventing excessive growth of a list of unique words and speeding up search.
| 1.0 | 1.0 | 1.0 | 1.0 | 1.0 ||
|| [dict_xsyn]({{ pg-docs }}/static/dict-xsyn.html)
(Extended Synonym Dictionary) An example of an add-on dictionary template for full-text search. It allows searching for a word using any of its synonyms.
| 1.0 | 1.0 | 1.0 | 1.0 | 1.0 ||
|| [earthdistance]({{ pg-docs }}/static/earthdistance.html)
Provides a module for calculating great circle distances between points on the surface of the Earth. There are two ways to calculate them:
* Via the `cube` data type (requires the `cube` extension to be enabled).
* Via the built-in `point` data type.
| 1.1 | 1.1 | 1.1 | 1.1 | 1.1 ||
|| [fuzzystrmatch]({{ pg-docs }}/fuzzystrmatch.html)
Provides several functions to determine similarities and distance between strings.
| 1.1 | 1.1 | 1.1 | 1.1 | 1.1 ||
|| [hstore]({{ pg-docs }}/static/hstore.html)
Implements the `hstore` data type for storing <q>key:value</q> pairs within a single table field and efficiently processing them.
| 1.4 | 1.5 | 1.6 | 1.7 | 1.8 ||
|| [hypopg](https://hypopg.readthedocs.io/en/rel1_stable/)
Adds support for virtual, or hypothetical, indexes. They are useful to discover if {{ PG }} will use real indexes to handle [problematic queries](../../tutorials/profiling.md#solving-inefficient-queries) without having to spend resources to create them.
| 1.3.1 | 1.3.1 | 1.3.1 | 1.3.1 | 1.3.1 ||
|| [intarray]({{ pg-docs }}/static/intarray.html)
Provides a number of functions and operators for manipulating `NULL`-free arrays of integers.
| 1.2 | 1.2 | 1.2 | 1.3 | 1.5 ||
|| [isn]({{ pg-docs }}/static/isn.html)
Provides data types for the EAN13, UPC, ISBN, ISMN, and ISSN international product numbering standards. Numbers are validated on input according to a hard-coded list of prefixes.
| 1.1 | 1.2 | 1.2 | 1.2 | 1.2 ||
|| [jsquery](https://github.com/postgrespro/jsquery)
Supports the JsQuery language for working with the `jsonb` data type. JsQuery provides a simple and effective way to search in nested objects and more comparison operators with index support.
| 1.0 | 1.1 | 1.1 | 1.1 | 1.1 ||
|| [lo]({{ pg-docs }}/static/lo.html)
Provides the `lo` (Large Object) data type and `lo_manage()` function. They are used for managing Binary Large Objects (BLOBs) based on the JDBC and ODBC driver specifications (standard {{ PG }} behavior does not conform to them).
| 1.1 | 1.1 | 1.1 | 1.1 | 1.1 ||
|| [ltree]({{ pg-docs }}/static/ltree.html)
Implements the `ltree` data type for representing labels of data stored in a hierarchical tree-like structure.
| 1.1 | 1.1 | 1.1 | 1.2 | 1.2 ||
|| [moddatetime]({{ pg-docs }}/static/contrib-spi.html#id-1.11.7.47.8)
Provides the `moddatetime()` function for tracking the last modification time of a particular row within a table.
| 1.0 | 1.0 | 1.0 | 1.0 | 1.0 ||
|| [oracle_fdw](https://github.com/laurenz/oracle_fdw)
Supports a [Foreign Data Wrapper](https://wiki.postgresql.org/wiki/Foreign_data_wrappers) for accessing Oracle databases.
To use the extension, you need the [`mdb_admin` role](../../concepts/roles.md#mdb-admin).
| 1.2 | 1.2 | 1.2 | 1.2 | 1.2 ||
|| [orafce](https://github.com/orafce/orafce)
Adds functions and operators to emulate Oracle database functions and packages.
| 3.18 | 3.18 | 3.18 | 3.18 | 3.18 ||
|| [pg_buffercache]({{ pg-docs }}/pgbuffercache.html)
Adds functions for monitoring the shared buffer cache.
To use the extension, you need the [`mdb_admin` role](../../concepts/roles.md#mdb-admin).
| 1.3 | 1.3 | 1.3 | 1.3 | 1.3 ||
|| [pg_cron](https://github.com/citusdata/pg_cron)
Enables you to add scheduled tasks to a database and execute SQL queries directly from a task. Requires the `pg_cron` [shared library to be enabled](#libraries-connection). To use the extension, you need the [`mdb_admin` role](../../concepts/roles.md#mdb-admin). Enabling the extension causes all hosts to restart. For more information, see [{#T}](./pg_cron.md).
| 1.4.1 | 1.4.1 | 1.4.1 | 1.4.1 | 1.4.1 ||
|| [pg_hint_plan](http://pghintplan.osdn.jp/)
Provides functions to manage a {{ PG }} planner.
Requires the `pg_hint_plan` [shared library to be enabled](#libraries-connection).
| 1.3.3 | 1.3.4 | 1.3.5 | 1.3.7 | 1.4 ||
|| [pg_partman](https://github.com/pgpartman/pg_partman)
Adds advanced features for creating and managing time-based and serial-based table partition sets.
| 4.0.0 | 4.0.0 | 4.2.0 | 4.4.0 | 4.6.0 ||
|| [pg_qualstats](https://github.com/powa-team/pg_qualstats)
Adds the ability to keep statistics on predicates found in `WHERE` statements and `JOIN` clauses.
Requires the `pg_qualstats` [shared library to be enabled](#libraries-connection).
| 2.0.3 | 2.0.3 | 2.0.3 | 2.0.3 | 2.0.3 ||
|| [pg_repack](http://reorg.github.io/pg_repack/)
Provides functions for removing bloat from tables and indexes. Unlike `CLUSTER` and `VACUUM FULL`, it doesn't require holding an exclusive lock on the processed tables.
To use the extension, you need the [`mdb_admin` role](../../concepts/roles.md#mdb-admin).
| 1.4.6 | 1.4.6 | 1.4.6 | 1.4.6 | 1.4.7 ||
|| [pg_stat_kcache](https://github.com/powa-team/pg_stat_kcache)
Adds the ability to gather statistics about real reads and writes done by the filesystem layer.
Requires the `pg_stat_statements` extension to be enabled.
To use the extension, you need the [`mdb_admin` role](../../concepts/roles.md#mdb-admin).
| 2.1.1 | 2.1.1 | 2.1.1 | 2.1.3 | 2.2.0 ||
|| [pg_stat_statements]({{ pg-docs }}/pgstatstatements.html)
Adds the ability to track planning and gather statistics of all SQL statements executed in a cluster.
To use the extension, you need the [`mdb_monitor` role](../../concepts/roles.md#mdb_monitor).
| 1.6 | 1.6 | 1.7 | 1.8 | 1.9 ||
|| [pg_tm_aux](https://github.com/x4m/pg_tm_aux)
Adds the ability to create a logical replication slot in the past
| 1.0 | 1.0 | 1.0 | 1.0 | 1.0 ||
|| [pg_trgm]({{ pg-docs }}/static/pgtrgm.html)
Provides tools for quickly searching for similar strings based on trigram matching.
| 1.3 | 1.4 | 1.4 | 1.5 | 1.6 ||
|| [pgcrypto]({{ pg-docs }}/static/pgcrypto.html)
Provides cryptographic functions for PostgreSQL.
| 1.3 | 1.3 | 1.3 | 1.3 | 1.3 ||
|| [pgrouting](http://pgrouting.org/)
Provides functions for geospatial routing of a [PostGIS](https://www.postgis.net/) database.
| 2.6.2 | 2.6.2 | 2.6.2 | 3.0.2 | 3.3.0 ||
|| [pgrowlocks]({{ pg-docs }}/static/pgrowlocks.html)
Provides the `pgrowlocks()` function, which shows row locking information for a specified table.
| 1.2 | 1.2 | 1.2 | 1.2 | 1.2 ||
|| [pgstattuple]({{ pg-docs }}/pgstattuple.html)
Provides functions to obtain tuple-level statistics.
To use the extension, you need the [`mdb_admin` role](../../concepts/roles.md#mdb-admin).
| 1.5 | 1.5 | 1.5 | 1.5 | 1.5 ||
|| [pgvector](https://github.com/pgvector/pgvector)
Adds a vector similarity search.
| 0.2.5 | 0.2.5 | 0.2.5 | 0.2.5 | 0.2.5 ||
|| [plv8](https://plv8.github.io/)
Supports a procedural language powered by the V8 JavaScript engine.
| 3.0.0 | 3.0.0 | 3.0.0 | 3.0.0 | 3.0.0 ||
|| [postgis](https://postgis.net/docs/)
Adds the ability to save and process geographic information system (GIS) objects in {{ PG }} databases.
| 2.5.2 | 2.5.2 | 3.0.0 | 3.1.4 | 3.1.4 ||
|| [postgis_tiger_geocoder](https://postgis.net/docs/postgis_installation.html#loading_extras_tiger_geocoder)
Provides functions for geocoding based on data in [TIGER](https://wiki.openstreetmap.org/wiki/TIGER) format.
| 2.5.2 | 2.5.2 | 3.0.0 | 3.1.4 | 3.1.4 ||
|| [postgis_topology](https://postgis.net/docs/Topology.html)
Provides data types and functions for the `postgis` extension to manage topological objects.
| 2.5.2 | 2.5.2 | 3.0.0 | 3.1.4 | 3.1.4 ||
|| [postgres_fdw]({{ pg-docs }}/static/postgres-fdw.html)
Supports [Foreign Data Wrapper](https://wiki.postgresql.org/wiki/Foreign_data_wrappers) for accessing external {{ PG }} servers.
To use the extension, you need the [`mdb_admin` role](../../concepts/roles.md#mdb-admin).
| 1.0 | 1.0 | 1.0 | 1.0 | 1.1 ||
|| [rum](https://github.com/postgrespro/rum)
Provides an access method to work with `RUM` indexes.
| 1.3 | 1.3 | 1.3 | 1.3 | 1.3 ||
|| [seg]({{ pg-docs }}/static/seg.html)
Implements the `seg` data type for representing line segments or floating point intervals.
| 1.1 | 1.3 | 1.3 | 1.3 | 1.4 ||
|| [smlar](http://sigaev.ru/git/gitweb.cgi?p=smlar.git;a=blob;hb=HEAD;f=README)
Contains a set of functions for computing the similarity between arrays.
| 1.0 | 1.0 | 1.0 | 1.0 | 1.0 ||
|| [tablefunc](https://www.postgresql.org/docs/current/static/tablefunc.html)
Contains a set of functions that return tables (multiple rows).
| 1.0 | 1.0 | 1.0 | 1.0 | 1.0 ||
|| [timescaledb](https://github.com/timescale/timescaledb)
Adds the ability to automatically partition tables across time and space (partitioning key), retaining the standard {{ PG }} interface for working with data. This makes {{ PG }} scalable for time-series.
Requires the `timescaledb` [shared library to be enabled](#libraries-connection).
| - | 2.3.1 | 2.4.2 | 2.5.2 | 2.6.1 ||
|| [unaccent]({{ pg-docs }}/static/unaccent.html)
Contains a text search dictionary that removes diacritic signs.
| 1.1 | 1.1 | 1.1 | 1.1 | 1.1 ||
|| [uuid-ossp]({{ pg-docs }}/static/uuid-ossp.html)
Contains functions to generate universally unique identifiers (UUIDs) using standard algorithms.
| 1.1 | 1.1 | 1.1 | 1.1 | 1.1 ||
|| [xml2]({{ pg-docs }}/static/xml2.html)
Provides XPath querying and XSLT functionality.
| 1.1 | 1.1 | 1.1 | 1.1 | 1.1 ||
|#

[pgcompacttable](https://github.com/dataegret/pgcompacttable) is designed to reorganize data in tables in order to revert back disk space without database performance impact.

Command syntax:

```bash
./bin/pgcompacttable -h c-<cluster ID>.rw.{{ dns-zone }} -p 6432 -U <usename> -W <password> -d <DB name> -n <schema name> -t <table name>
```

Requires the `pgstattuple` extension to be enabled.

To use the extension, you need the [`mdb_admin` role](../../concepts/roles.md#mdb-admin).
