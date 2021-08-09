---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Управление {{ PG }}-расширениями

{{ mpg-short-name }} поддерживает многие стандартные расширения {{ PG }} и некоторые нестандартные. Полный список доступных расширений [приведен ниже](#postgresql).

{% note warning %}

Вы не можете управлять расширениями {{ PG }} с помощью команд SQL.

{% endnote %}

## Получить список расширений {#list-extensions}

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mpg-name }}**.
  1. Нажмите на имя нужного кластера и выберите блок **Базы данных**.
  1. В колонке **Расширения PostgreSQL** будет отображаться список расширений, подключенных к каждой базе данных.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список расширений для базы данных, выполните команду:

  ```
  $ {{ yc-mdb-pg }} database get <имя базы данных> \
       --cluster-name <имя кластера>
  ```

  Включенные расширения будут перечислены в списке `extensions`.

- API

  Получить список расширений для базы данных кластера можно с помощью метода [get](../api-ref/Database/get.md).

{% endlist %}

## Изменить список расширений {#update-extensions}

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mpg-name }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Базы данных**.
  1. В строке с нужной базой данных нажмите значок ![options](../../_assets/horizontal-ellipsis.svg) и выберите пункт **Настроить расширения PostgreSQL**.
  1. Выберите необходимые расширения и нажмите кнопку **Изменить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить расширения для базы данных, передайте их список в аргументе `--extensions` команды CLI. При этом расширения, не упомянутые в списке, будут выключены.

  ```
  $ {{ yc-mdb-pg }} database update <имя базы данных> \
       --cluster-name <имя кластера>
       --extensions <имя расширения>=<версия>,<имя расширения>=<версия>...
  ```

  {% note info %}

  Версия расширения не учитывается при обработке команды — в качестве версии можно передать любую непустую строку.

  {% endnote %}

- Terraform

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
    
     О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

  1. Добавьте к описанию кластера {{ mpg-name }} один или несколько блоков `extension` в секции `database`, соответствующей нужной базе данных (по одному блоку на каждое расширение):
  
      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<имя кластера>" {
        ...
        database {
          ...
          extension {
            name    = "<имя расширения>"
            version = "<версия расширения>"
          }
          ...
        }
        ...
      ```

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).

- API

  Передать новый список расширений для базы данных можно с помощью метода [update](../api-ref/Database/update.md).

{% endlist %}

## Поддерживаемые расширения {{ PG }} {#postgresql}

Полный список поддерживаемых расширений:

- [address_standardizer](https://postgis.net/docs/Address_Standardizer.html);
- [address_standardizer_data_us](https://postgis.net/docs/Address_Standardizer.html#Address_Standardizer_Tables);
- [amcheck](https://www.postgresql.org/docs/current/amcheck.html) (требует роли [mdb_admin](../concepts/roles.md#mdb-admin));
- [autoinc](https://www.postgresql.org/docs/current/contrib-spi.html#id-1.11.7.45.6);
- [bloom](https://www.postgresql.org/docs/current/static/bloom.html);
- [btree_gin](https://www.postgresql.org/docs/current/static/btree-gin.html);
- [btree_gist](https://www.postgresql.org/docs/current/static/btree-gist.html);
- [citext](https://www.postgresql.org/docs/current/static/citext.html);
- [cube](https://www.postgresql.org/docs/current/static/cube.html);
- [dblink](https://www.postgresql.org/docs/current/static/dblink.html) (требует роли [mdb_admin](../concepts/roles.md#mdb-admin));
- [dict_int](https://www.postgresql.org/docs/current/static/dict-int.html);
- [dict_xsyn](https://www.postgresql.org/docs/current/static/dict-xsyn.html);
- [earthdistance](https://www.postgresql.org/docs/current/static/earthdistance.html);
- [fuzzystrmatch](https://www.postgresql.org/docs/current/static/fuzzystrmatch.html);
- [hstore](https://www.postgresql.org/docs/current/static/hstore.html);
- [intarray](https://www.postgresql.org/docs/current/static/intarray.html);
- [isn](https://www.postgresql.org/docs/current/static/isn.html);
- [jsquery](https://github.com/postgrespro/jsquery);
- [lo](https://www.postgresql.org/docs/current/static/lo.html);
- [ltree](https://www.postgresql.org/docs/current/static/ltree.html);
- [moddatetime](https://www.postgresql.org/docs/current/static/contrib-spi.html#id-1.11.7.45.8);
- [pg_buffercache](https://www.postgresql.org/docs/current/pgbuffercache.html) (требует роли [mdb_admin](../concepts/roles.md#mdb-admin));
- [pg_hint_plan](http://pghintplan.osdn.jp/);
- [pg_partman](https://github.com/pgpartman/pg_partman);
- [pg_repack](http://reorg.github.io/pg_repack/) (требует роли [mdb_admin](../concepts/roles.md#mdb-admin));
- [pg_stat_kcache](https://github.com/powa-team/pg_stat_kcache) (некоторые функции требуют роли [mdb_admin](../concepts/roles.md#mdb-admin));
- [pg_stat_statements](https://www.postgresql.org/docs/current/pgstatstatements.html);
- [pg_trgm](https://www.postgresql.org/docs/current/static/pgtrgm.html);
- [pgcrypto](https://www.postgresql.org/docs/current/static/pgcrypto.html);
- [pgrouting](http://pgrouting.org/);
- [pgrowlocks](https://www.postgresql.org/docs/current/static/pgrowlocks.html);
- [pgstattuple](https://www.postgresql.org/docs/current/pgstattuple.html) (требует роли [mdb_admin](../concepts/roles.md#mdb-admin));
- [postgis](https://postgis.net/docs/);
- [postgis_tiger_geocoder](https://postgis.net/docs/postgis_installation.html#loading_extras_tiger_geocoder);
- [postgis_topology](https://postgis.net/docs/Topology.html);
- [postgres_fdw](https://www.postgresql.org/docs/current/static/postgres-fdw.html) (требует роли [mdb_admin](../concepts/roles.md#mdb-admin));
- [seg](https://www.postgresql.org/docs/current/static/seg.html);
- [smlar](http://sigaev.ru/git/gitweb.cgi?p=smlar.git;a=blob;hb=HEAD;f=README);
- [tablefunc](https://www.postgresql.org/docs/current/static/tablefunc.html);
- [unaccent](https://www.postgresql.org/docs/current/static/unaccent.html);
- [uuid-ossp](https://www.postgresql.org/docs/current/static/uuid-ossp.html);
- [xml2](https://www.postgresql.org/docs/current/static/xml2.html).
