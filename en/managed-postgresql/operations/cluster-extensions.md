# Managing {{ PG }} extensions

{{ mpg-short-name }} supports many standard and some non-standard {{ PG }} extensions. A full list of available extensions is [given below](#postgresql).

{% note warning %}

In {{ mpg-short-name }} clusters, you can't manage {{ PG }} extensions using SQL commands.

{% endnote %}

## Enabling libraries for extensions {#libraries-connection}

For some extensions, you need to enable shared libraries. To enable a library, when [creating](cluster-create.md) or [updating](update.md#change-postgresql-config) a cluster, specify its name in the [Shared preload libraries](../concepts/settings-list#setting-shared-libraries) parameter.

You can install the following libraries in {{ mpg-short-name }}:

* `auto_explain`: Enables the [auto_explain extension]({{ pg-docs }}/auto-explain.html).
* `pg_hint_plan`: Required for the [pg_hint_plan extension](https://pghintplan.osdn.jp/pg_hint_plan.html) to work.
* `pg_qualstats`: Required for the [pg_qualstats extension](https://github.com/powa-team/pg_qualstats) to run.
* `timescaledb`: Required to be able to use the [TimescaleDB extension](https://github.com/timescale/timescaledb).

## How to get a list of extensions {#list-extensions}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mpg-name }}**.
  1. Click on the name of the cluster you need and select the **Databases** section.
  1. In the **PostgreSQL extensions** column, you'll see a list of extensions enabled for each database.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of extensions for a database, run the command:

  ```bash
  {{ yc-mdb-pg }} database get <database name> \
     --cluster-name <cluster name>
  ```

  The enabled extensions will be listed in the `extensions` list.

- API

  To get a list of extensions for the cluster database, use the [get](../api-ref/Database/get.md) method.

{% endlist %}

## How to change the list of extensions {#update-extensions}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mpg-name }}**.
  1. Click on the name of the cluster you need and select the **Databases** tab.
  1. In the line with the desired database, click ![options](../../_assets/horizontal-ellipsis.svg) and select **Configure PostgreSQL extensions**.
  1. Select the extensions you need and click **Edit**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change extensions for a database, pass their list in the `--extensions` argument of a CLI command. In this case, plugins that are not included in the list will be disabled.

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

     For information about how to create this file, see [{#T}](cluster-create.md).

  1. Add one or more `extension` blocks to the {{ mpg-name }}cluster description in the `database` section corresponding to the appropriate database (one block per extension):

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
      ```

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm the update of resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

- API

  To pass a new list of DB extensions, use the [update](../api-ref/Database/update.md) method.

{% endlist %}

## Supported {{ PG }} extensions {#postgresql}

All supported extensions are listed here:

* [address_standardizer](https://postgis.net/docs/standardize_address.html) {#ext-address_standardizer}

    Provides functions that normalize postal addresses sent as a line.

* [address_standardizer_data_us](https://postgis.net/docs/standardize_address.html) {#ext-address_standardizer_data_us}

    Provides rules for normalizing US and Canadian postal addresses for the [address_standardizer](#ext-address_standardizer) extension.

* [amcheck]({{ pg-docs }}/amcheck.html) {#ext-amcheck}

    Provides functions that let you verify the logical consistency of the structure of relations.

    To use the extension, you need the [`mdb_admin` role](../concepts/roles.md#mdb-admin).

* [autoinc]({{ pg-docs }}/contrib-spi.html#id-1.11.7.47.6) {#ext-autoinc}

    Provides the `autoinc()` function. It stores the next value of a sequence into an integer field. Unlike built-in types that control sequences, `autoinc()`:
	
    * Overrides attempts to insert a different field value from a query.
    * Allows modifying field values during updates.

* [bloom]({{ pg-docs }}/static/bloom.html) {#ext-bloom}

    Enables access to DB indexes based on [Bloom filter](https://en.wikipedia.org/wiki/Bloom_filter). These probabilistic data structures require significantly less storage space than hash tables. However, false positives are possible.

* [btree_gin]({{ pg-docs }}/static/btree-gin.html) {#ext-btree-gin}

    Contains examples of GIN (Generalized Inverted Index) operator classes used for inverted searches.

* [btree_gist]({{ pg-docs }}/static/btree-gist.html) {#ext-btree-gist}

    Contains GiST (Generalized Search Tree) operator classes. Unlike a B-tree index, GiST supports operators such as `<>` (<q>not equal to</q>) and `<->` (<q>distance</q>). However, it doesn't ensure the uniqueness of values it returns.

* [citext]({{ pg-docs }}/static/citext.html) {#ext-citext}

    Provides the `citext` data type that allows using case-insensitive strings.

* [cube]({{ pg-docs }}/static/cube.html) {#ext-cube}

    Provides the `cube` data type that is used for representing multidimensional cubes.

* [dblink]({{ pg-docs }}/static/dblink.html) {#ext-dblink}

    Allows connecting to other {{ PG }} databases from the current session.

    To use the extension, you need the [`mdb_admin` role](../concepts/roles.md#mdb-admin).

* [dict_int]({{ pg-docs }}/static/dict-int.html) {#ext-dict-int}

    Contains an example of an add-on dictionary template for full-text search. It allows preventing excessive growth of a list of unique words and speeding up search.

* [dict_xsyn]({{ pg-docs }}/static/dict-xsyn.html) {#ext-dict-xsyn}

    (Extended Synonym Dictionary) contains an example of an add-on dictionary template for full-text search. It allows searching for a word using any of its synonyms.

* [earthdistance]({{ pg-docs }}/static/earthdistance.html) {#ext-earthdistance}

    Provides a module for calculating distances between two points on the surface of the Earth. There are two ways to calculate them:
	
    * Via the `cube` data type (requires that the [cube](#ext-cube) extension be enabled).
    * Via the built-in `point` data type.

* [fuzzystrmatch]({{ pg-docs }}/fuzzystrmatch.html) {#ext-fuzzystrmatch}

    Provides functions to determine similarities and distance between strings.

* [hstore]({{ pg-docs }}/static/hstore.html) {#ext-hstore}

    Implements the `hstore` data type for storing sets of <q>key:value</q> pairs within a single table field and using them in an efficient way.

* [hypopg](https://hypopg.readthedocs.io/en/rel1_stable/) {#ext-hypopg}

    Adds support for virtual, or hypothetical, indexes. They are useful to discover if {{ PG }} will use real indexes to handle [problematic queries](../tutorials/profiling.md#solving-inefficient-queries) without having to spend resources to create them.

* [intarray]({{ pg-docs }}/static/intarray.html) {#ext-intarray}

    Provides functions and operators for manipulating arrays of integers that do not contain any `NULL` elements.

* [isn]({{ pg-docs }}/static/isn.html) {#ext-isn}

    Provides data types for international product numbering standards such as EAN13, UPC, ISBN, ISMN, and ISSN. Numbers are validated on input according to a hard-coded list of prefixes.

* [jsquery](https://github.com/postgrespro/jsquery) {#ext-jsquery}

    Adds support for the JsQuery language that is used to query the `jsonb` data type. JsQuery provides a simple and effective way to search in nested objects and more comparison operators with index support.

* [lo]({{ pg-docs }}/static/lo.html) {#ext-lo}

    Provides support for the `lo` data type and `lo_manage()` function. They are used for managing Binary Large Objects (BLOBs) based on the JDBC and ODBC driver specifications (standard {{ PG }} behavior does not conform to them).

* [ltree]({{ pg-docs }}/static/ltree.html) {#ext-ltree}

    Implements the `ltree` data type for representing labels of data stored in a hierarchical tree-like structure.

* [moddatetime]({{ pg-docs }}/static/contrib-spi.html#id-1.11.7.47.8) {#ext-moddatetime}

    Provides the `moddatetime()` function that allows tracking  the last modification time of a particular row within a table.

* [oracle_fdw](https://github.com/laurenz/oracle_fdw) {#ext-oracle_fdw}

    Adds support for a [Foreign Data Wrapper](https://wiki.postgresql.org/wiki/Foreign_data_wrappers) to access Oracle databases.

    To use the extension, you need the [`mdb_admin` role](../concepts/roles.md#mdb-admin).

* [pg_buffercache]({{ pg-docs }}/pgbuffercache.html) {#ext-pg_buffercahce}

    Provides functions for monitoring the shared buffer cache.

    To use the extension, you need the [`mdb_admin` role](../concepts/roles.md#mdb-admin).

* [pg_hint_plan](http://pghintplan.osdn.jp/) {#ext-pg_hint_plan}

    Provides functions for managing the {{ PG }} planner.

    To use it, make sure to [enable the shared library](#libraries-connection) `pg_hint_plan`.

* [pg_partman](https://github.com/pgpartman/pg_partman) {#ext-pg_partman}

    Extends support for table partitioning, including time-based and serial-based.

* [pg_qualstats](https://github.com/powa-team/pg_qualstats) {#ext-pg_qualstats}

    Allows collecting statistics on predicates found in `WHERE` statements and `JOIN` clauses.

    To use it, make sure to [enable the shared library](#libraries-connection) `pg_qualstats`.

* [pg_repack](http://reorg.github.io/pg_repack/) {#ext-pg_repack}

    Provides functions to remove bloat from tables and indexes Unlike `CLUSTER` and `VACUUM FULL`, it doesn't require holding an exclusive lock on the processed tables.

    To use the extension, you need the [`mdb_admin` role](../concepts/roles.md#mdb-admin).

* [pg_stat_kcache](https://github.com/powa-team/pg_stat_kcache) {#ext-pg_stat_kcache}

    Allows gathering statistics about real reads and writes done by the filesystem layer.

    Requires that the [pg_stat_statements](#ext-pg_stat_statements) extension be installed.

    To use the extension, you need the [`mdb_admin` role](../concepts/roles.md#mdb-admin).

* [pg_stat_statements]({{ pg-docs }}/pgstatstatements.html) {#ext-pg_stat_statements}

    Tracks planning and execution statistics of all SQL queries run in a cluster.

* [pg_trgm]({{ pg-docs }}/static/pgtrgm.html) {#ext-pg_trgm}

    Provides tools for fast searching for similar strings based on trigram matching.

* [pgcrypto]({{ pg-docs }}/static/pgcrypto.html) {#ext-pgcrypto}

    Provides cryptographic functions.

* [pgrouting](http://pgrouting.org/) {#ext-pgrouting}

    Extends the [PostGIS](https://www.postgis.net/) database to provide geospatial routing functionality.

* [pgrowlocks]({{ pg-docs }}/static/pgrowlocks.html) {#ext-pgrowlocks}

     Provides the `pgrowlocks()` function to return row locking information for a specified table.

* [pgstattuple]({{ pg-docs }}/pgstattuple.html) {#ext-pgstattuple}

     Provides functions to obtain tuple-level statistics.

    To use the extension, you need the [`mdb_admin` role](../concepts/roles.md#mdb-admin).

* [plv8](https://plv8.github.io/) {#ext-plv8}

    Adds supports for PLV8, a Javascript-based procedural language, and the V8 engine.

* [postgis](https://postgis.net/docs/) {#ext-postgis}

    Allows GIS (Geographic Information Systems) objects to be stored and handled in {{ PG }} databases.

* [postgis_tiger_geocoder](https://postgis.net/docs/postgis_installation.html#loading_extras_tiger_geocoder) {#ext-postgis_tiger_geocoder}

    Provides functions for geocoding based on [TIGER](https://wiki.openstreetmap.org/wiki/TIGER) data.

* [postgis_topology](https://postgis.net/docs/Topology.html) {#ext-postgis_topology}

    Provides [PostGIS](#ext-postgis) data types and functions for managing topological objects.

* [postgres_fdw]({{ pg-docs }}/static/postgres-fdw.html) {#ext-postgres_fdw}

    Adds support for a [Foreign Data Wrapper](https://wiki.postgresql.org/wiki/Foreign_data_wrappers) to access data stored in external {{ PG }} servers.

    To use the extension, you need the [`mdb_admin` role](../concepts/roles.md#mdb-admin).

* [rum](https://github.com/postgrespro/rum) {#ext-rum}

    Provides an access method to work with `RUM` indexes.

* [seg]({{ pg-docs }}/static/seg.html) {#ext-seg}

    Implements the `seg` data type for representing line segments or floating point intervals.

* [smlar](http://sigaev.ru/git/gitweb.cgi?p=smlar.git;a=blob;hb=HEAD;f=README) {#ext-smlar}

    Provides a set of functions for computing similarity of two arrays.

* [tablefunc](https://www.postgresql.org/docs/current/static/tablefunc.html) {#ext-tablefunc}

    Provides a set of functions that return tables (that is, multiple rows).

* [timescaledb](https://github.com/timescale/timescaledb) {#ext-timescaledb}

    Supports automatic partitioning across time and space (partitioning key), yet retains the standard {{ PG }} interface for data. This makes {{ PG }} scalable for time-series.

    To use it, make sure to [enable the shared library](#libraries-connection) `timescaledb`.

* [unaccent]({{ pg-docs }}/static/unaccent.html) {#ext-unaccent}

    Provides a text search dictionary that removes diacritic signs.

* [uuid-ossp]({{ pg-docs }}/static/uuid-ossp.html) {#ext-uuid-ossp}

    Provides functions to generate universally unique identifiers (UUIDs) using standard algorithms.

* [xml2]({{ pg-docs }}/static/xml2.html) {#ext-xml2}

     Provides XPath querying and XSLT (Extensible Stylesheet Language Transformations) functionality.

