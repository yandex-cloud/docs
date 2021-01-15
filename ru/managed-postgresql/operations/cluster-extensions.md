# Управление {{ PG }}-расширениями

{{ mpg-short-name }} поддерживает многие стандартные расширения {{ PG }} и некоторые нестандартные. Полный список доступных расширений [приведен ниже](#postgresql).

## Получить список расширений {#list-extensions}

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mpg-name }}**.
  1. Нажмите на имя нужного кластера и выберите блок **Базы данных**.
  1. В колонке **Расширения PostgreSQL** будет отображаться список расширений, подключенных к каждой базе данных.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список расширений для определенной базы данных, выполните команду:

  ```
  $ {{ yc-mdb-pg }} database get <имя базы данных> \
       --cluster-name <имя кластера>
  ```

  Включенные расширения будут перечислены в списке `extensions`.

- API

  Получить список расширений для базы данных кластера можно с помощью метода [get](../api-ref/Database/get.md).

{% endlist %}

## Изменить набор расширений {#update-extensions}

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mpg-name }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Базы данных**.
  1. В строке с нужной базой данных нажмите значок ![options](../../_assets/horizontal-ellipsis.svg) и выберите пункт **Настроить расширения PostgreSQL**.
  1. Выберите необходимые расширения и нажмите кнопку **Изменить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы включить или выключить {{ PG }}-расширения для базы данных, передайте полный список нужных расширений командой CLI. Включенные расширения, которых не будет в списке, будут отключены.

  ```
  $ {{ yc-mdb-pg }} database update <имя базы данных> \
       --cluster-name <имя кластера>
       --extensions <имя расширения>=<версия>,<имя расширения>=<версия>...
  ```

  {% note info %}

  Версия расширения не учитывается при обработке команды — в качестве версии можно передать любую непустую строку.

  {% endnote %}

- API

  Передать новый список расширений для базы данных можно с помощью метода [update](../api-ref/Database/update.md).

{% endlist %}

## Поддерживаемые расширения {{ PG }} {#postgresql}

Полный список поддерживаемых расширений:

- [address_standardizer](https://postgis.net/docs/Address_Standardizer.html)
- [address_standardizer_data_us](https://postgis.net/docs/Address_Standardizer.html)
- [autoinc](https://www.postgresql.org/docs/current/static/contrib-spi.html#id-1.11.7.46.7)
- [bloom](https://www.postgresql.org/docs/current/static/bloom.html)
- [btree_gin](https://www.postgresql.org/docs/current/static/btree-gin.html)
- [btree_gist](https://www.postgresql.org/docs/current/static/btree-gist.html)
- [chkpass](https://www.postgresql.org/docs/current/static/chkpass.html)
- [citext](https://www.postgresql.org/docs/current/static/citext.html)
- [cube](https://www.postgresql.org/docs/current/static/cube.html)
- [dblink](https://www.postgresql.org/docs/current/static/dblink.html) (требует роли `owner` или [mdb_admin](../concepts/roles.md#mdb-admin)).
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
- [moddatetime](https://www.postgresql.org/docs/current/static/contrib-spi.html#id-1.11.7.46.9)
- [pg_partman](https://github.com/pgpartman/pg_partman)
- [pg_repack](http://reorg.github.io/pg_repack/) (требует роли `owner` или [mdb_admin](../concepts/roles.md#mdb-admin)).
- [pg_stat_kcache](https://github.com/powa-team/pg_stat_kcache) (некоторые функции требуют роли `owner` или [mdb_admin](../concepts/roles.md#mdb-admin)).
- [pg_stat_statements](https://www.postgresql.org/docs/current/pgstatstatements.html)
- [pg_trgm](https://www.postgresql.org/docs/current/static/pgtrgm.html)
- [pgcrypto](https://www.postgresql.org/docs/current/static/pgcrypto.html)
- [pgrouting](http://pgrouting.org/)
- [pgrowlocks](https://www.postgresql.org/docs/current/static/pgrowlocks.html)
- [postgis](https://postgis.net/docs/)
- [postgis_tiger_geocoder](https://postgis.net/docs/postgis_installation.html#loading_extras_tiger_geocoder)
- [postgis_topology](https://postgis.net/docs/Topology.html)
- [postgres_fdw](https://www.postgresql.org/docs/current/static/postgres-fdw.html) (требует роли `owner` или [mdb_admin](../concepts/roles.md#mdb-admin)).
- [seg](https://www.postgresql.org/docs/current/static/seg.html)
- [tablefunc](https://www.postgresql.org/docs/current/static/tablefunc.html)
- [unaccent](https://www.postgresql.org/docs/current/static/unaccent.html)
- [uuid-ossp](https://www.postgresql.org/docs/current/static/uuid-ossp.html)
- [xml2](https://www.postgresql.org/docs/current/static/xml2.html)
