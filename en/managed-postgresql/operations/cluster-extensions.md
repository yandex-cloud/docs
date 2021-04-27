# Managing {{ PG }} extensions

{{ mpg-short-name }} supports many standard and some non-standard {{ PG }} extensions. A full list of available extensions is [given below](#postgresql).

{% note warning %}

You can't manage {{ PG }} extensions using SQL commands.

{% endnote %}

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

  ```
  $ {{ yc-mdb-pg }} database get <database name> \
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

  To change extensions for a database, pass their list in the `--extensions` argument of a CLI command. In this case, extensions that are not included in the list will be disabled.

  ```
  $ {{ yc-mdb-pg }} database update <database name> \
       --cluster-name <cluster name>
       --extensions <extension name>=<version>,<extension name>=<version>...
  ```

  {% note info %}

  The extension version is not considered when handling the command: you can pass any non-empty string as a version.

  {% endnote %}

- API

  To pass a new list of DB extensions, use the [update](../api-ref/Database/update.md) method.

{% endlist %}

## Supported {{ PG }} extensions {#postgresql}

All supported extensions are listed here:

- [address_standardizer](https://postgis.net/docs/Address_Standardizer.html)
- [address_standardizer_data_us](https://postgis.net/docs/Address_Standardizer.html#Address_Standardizer_Tables)
- [amcheck](https://www.postgresql.org/docs/current/amcheck.html) (requires the [mdb_admin](../concepts/roles.md#mdb-admin) role)
- [autoinc](https://www.postgresql.org/docs/current/contrib-spi.html#id-1.11.7.45.6)
- [bloom](https://www.postgresql.org/docs/current/static/bloom.html)
- [btree_gin](https://www.postgresql.org/docs/current/static/btree-gin.html)
- [btree_gist](https://www.postgresql.org/docs/current/static/btree-gist.html)
- [citext](https://www.postgresql.org/docs/current/static/citext.html)
- [cube](https://www.postgresql.org/docs/current/static/cube.html)
- [dblink](https://www.postgresql.org/docs/current/static/dblink.html) (requires the [mdb_admin](../concepts/roles.md#mdb-admin) role)
- [dict_int](https://www.postgresql.org/docs/current/static/dict-int.html)
- [dict_xsyn](https://www.postgresql.org/docs/current/static/dict-xsyn.html)
- [earthdistance](https://www.postgresql.org/docs/current/static/earthdistance.html)
- [fuzzystrmatch](https://www.postgresql.org/docs/current/static/fuzzystrmatch.html)
- [hstore](https://www.postgresql.org/docs/current/static/hstore.html)
- [intarray](https://www.postgresql.org/docs/current/static/intarray.html)
- [isn](https://www.postgresql.org/docs/current/static/isn.html)
- [jsquery](https://github.com/postgrespro/jsquery)
- [lo](https://www.postgresql.org/docs/current/static/lo.html)
- [ltree](https://www.postgresql.org/docs/current/static/ltree.html)
- [moddatetime](https://www.postgresql.org/docs/current/static/contrib-spi.html#id-1.11.7.45.8)
- [pg_buffercache](https://www.postgresql.org/docs/current/pgbuffercache.html) (requires the [mdb_admin](../concepts/roles.md#mdb-admin) role)
- [pg_hint_plan](http://pghintplan.osdn.jp/)
- [pg_partman](https://github.com/pgpartman/pg_partman)
- [pg_repack](http://reorg.github.io/pg_repack/) (requires the [mdb_admin](../concepts/roles.md#mdb-admin) role)
- [pg_stat_kcache](https://github.com/powa-team/pg_stat_kcache) (some functions require the [mdb_admin](../concepts/roles.md#mdb-admin) role)
- [pg_stat_statements](https://www.postgresql.org/docs/current/pgstatstatements.html)
- [pg_trgm](https://www.postgresql.org/docs/current/static/pgtrgm.html)
- [pgcrypto](https://www.postgresql.org/docs/current/static/pgcrypto.html)
- [pgrouting](http://pgrouting.org/)
- [pgrowlocks](https://www.postgresql.org/docs/current/static/pgrowlocks.html)
- [pgstattuple](https://www.postgresql.org/docs/current/pgstattuple.html) (requires the [mdb_admin](../concepts/roles.md#mdb-admin) role)
- [postgis](https://postgis.net/docs/)
- [postgis_tiger_geocoder](https://postgis.net/docs/postgis_installation.html#loading_extras_tiger_geocoder)
- [postgis_topology](https://postgis.net/docs/Topology.html)
- [postgres_fdw](https://www.postgresql.org/docs/current/static/postgres-fdw.html) (requires the [mdb_admin](../concepts/roles.md#mdb-admin) role)
- [seg](https://www.postgresql.org/docs/current/static/seg.html)
- [smlar](http://sigaev.ru/git/gitweb.cgi?p=smlar.git;a=blob;hb=HEAD;f=README)
- [tablefunc](https://www.postgresql.org/docs/current/static/tablefunc.html)
- [unaccent](https://www.postgresql.org/docs/current/static/unaccent.html)
- [uuid-ossp](https://www.postgresql.org/docs/current/static/uuid-ossp.html)
- [xml2](https://www.postgresql.org/docs/current/static/xml2.html)

