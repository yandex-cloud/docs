# Управление расширениями

{{ mpg-short-name }} поддерживает многие стандартные расширения {{ PG }} и некоторые нестандартные. Полный список доступных расширений и их версий в зависимости от версии {{ PG }} [приведен ниже](#postgresql).

{% note warning %}

В кластерах {{ mpg-short-name }} нельзя управлять расширениями {{ PG }} с помощью команд SQL.

{% endnote %}

## Подключение библиотек для расширений {#libraries-connection}

Некоторые расширения требуют подключения библиотек общего пользования (shared libraries). Чтобы подключить библиотеку, при [создании](../cluster-create.md) или [изменении](../update.md#change-postgresql-config) кластера укажите ее имя в [параметре Shared preload libraries](../../concepts/settings-list#setting-shared-libraries).

{{ mpg-short-name }} поддерживает подключение библиотек:

* `auto_explain` — необходима для работы [расширения auto_explain]({{ pg-docs }}/auto-explain.html);
* `pgaudit` — необходима для работы [расширения pgaudit](https://www.pgaudit.org/);
* `pg_cron` — необходима для работы [расширения pg_cron](https://github.com/citusdata/pg_cron);
* `pg_hint_plan` — необходима для работы [расширения pg_hint_plan](https://github.com/ossc-db/pg_hint_plan);
* `pg_qualstats` — необходима для работы [расширения pg_qualstats](https://github.com/powa-team/pg_qualstats);
* `pg_stat_query_plans` — необходима для работы [расширения pg_stat_query_plans](https://github.com/postgredients/pg_stat_query_plans);
* `timescaledb` — необходима для использования [расширения TimescaleDB](https://github.com/timescale/timescaledb);
* `anon` — необходима для использования [расширения postgresql_anonymizer](https://postgresql-anonymizer.readthedocs.io/en/stable/).

{% note warning %}

Подключение библиотеки общего пользования приведет к перезагрузке {{ PG }} на хосте-мастере.

{% endnote %}

## Получить список установленных расширений {#list-extensions}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите блок **{{ ui-key.yacloud.postgresql.cluster.switch_databases }}**.
  1. В колонке **{{ ui-key.yacloud.mdb.cluster.databases.column_extensions }}** будет отображаться список расширений, подключенных к каждой базе данных.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Чтобы получить список расширений для базы данных, выполните команду:

  ```bash
  {{ yc-mdb-pg }} database get <имя_БД> \
     --cluster-name <имя_кластера>
  ```

  Включенные расширения будут перечислены в списке `extensions`.

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Database.Get](../../api-ref/Database/get.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>/databases/<имя_БД>'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](../cluster-list.md#list-clusters), а имя БД — со [списком БД в кластере](../databases.md#list-db).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/Database/get.md#responses).

     Список установленных расширений приведен в параметре `extensions` в выводе команды.

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [DatabaseService.Get](../../api-ref/grpc/Database/get.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/database_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "database_name": "<имя_БД>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.DatabaseService.Get
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](../cluster-list.md#list-clusters), а имя БД — со [списком БД в кластере](../databases.md#list-db).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/grpc/Database/get.md#yandex.cloud.mdb.postgresql.v1.Database).

     Список установленных расширений приведен в параметре `extensions` в выводе команды.

{% endlist %}

## Изменить список установленных расширений {#update-extensions}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_databases }}**.
  1. В строке с нужной базой данных нажмите значок ![options](../../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.cluster.databases.button_action-manage }}**.
  1. Выберите необходимые расширения и нажмите кнопку **{{ ui-key.yacloud.postgresql.databases.dialog.button_submit }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Чтобы изменить расширения для базы данных, передайте их список в аргументе `--extensions` команды CLI. При этом расширения, не упомянутые в списке, будут выключены.

  ```bash
  {{ yc-mdb-pg }} database update <имя_БД> \
     --cluster-name <имя_кластера>
     --extensions <имя_расширения>=<версия>,<имя_расширения>=<версия>...
  ```

  {% note info %}

  Версия расширения не учитывается при обработке команды — в качестве версии можно передать любую непустую строку.

  {% endnote %}

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](../cluster-create.md).

     Полный список доступных для изменения полей конфигурации базы данных кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_postgresql_database).

  1. Добавьте к описанию соответствующей базы данных кластера один или несколько блоков `extension` (по одному блоку на каждое расширение):

      ```hcl
      resource "yandex_mdb_postgresql_database" "<имя_БД>" {
        ...
        extension {
          name    = "<имя_расширения>"
          version = "<версия_расширения>"
        }
        ...
      }
      ```

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Database.Update](../../api-ref/Database/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     {% include [note-updatemask](../../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>/databases/<имя_БД>' \
       --data '{
                 "updateMask": "extensions",
                 "extensions": [
                   {
                     "name": "<имя_расширения>",
                     "version": "<версия_расширения>"
                   },
                   { <аналогичный_набор_настроек_для_расширения_2> },
                   { ... },
                   { <аналогичный_набор_настроек_для_расширения_N> }
                 ]
               }'
     ```

     Где:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

       В данном случае передается только один параметр.

     * `extensions` — массив расширений БД. Каждый объект соответствует отдельному расширению и имеет следующую структуру:

       * `name` — имя расширения;
       * `version` — версия расширения.

       Указывайте имя и версию в соответствии со [списком поддерживаемых расширений и утилит {{ PG }}](#postgresql).

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](../cluster-list.md#list-clusters), а имя БД — со [списком БД в кластере](../databases.md#list-db).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/Database/update.md#responses).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [DatabaseService.Update](../../api-ref/grpc/Database/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     {% include [note-grpc-updatemask](../../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/database_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "database_name": "<имя_БД>",
             "update_mask": {
               "paths": [
                 "extensions"
               ]
             },
             "extensions": [
               {
                 "name": "<имя_расширения>",
                 "version": "<версия_расширения>"
               },
               { <аналогичный_набор_настроек_для_расширения_2> },
               { ... },
               { <аналогичный_набор_настроек_для_расширения_N> }
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.DatabaseService.Update
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

       В данном случае передается только один параметр.

     * `extensions` — массив расширений БД. Один элемент массива содержит настройки для одного расширения и имеет следующую структуру:

       * `name` — имя расширения;
       * `version` — версия расширения.

       Указывайте имя и версию в соответствии со [списком поддерживаемых расширений и утилит {{ PG }}](#postgresql).

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](../cluster-list.md#list-clusters), а имя БД — со [списком БД в кластере](../databases.md#list-db).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/grpc/Database/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Поддерживаемые расширения и утилиты {{ PG }} {#postgresql}

#|
|| **Расширение** \ **Версия {{ PG }}** | **11** | **12** | **13** | **14** | **15** | **16** | **17** ||
|| <p>[address_standardizer](https://postgis.net/docs/manual-3.1/postgis_installation.html#installing_pagc_address_standardizer)</p><p>Содержит функции для нормализации почтовых адресов, переданных в виде строки.</p> | 2.5.2 | 3.0.0 | 3.1.4 | 3.1.4 | 3.3.2 | 3.4.0 | 3.4.3 ||
|| <p>[address_standardizer_data_us](https://postgis.net/docs/manual-3.1/postgis_installation.html#make_install_postgis_extensions)</p><p>Содержит правила нормализации почтовых адресов США и Канады для расширения `address_standardizer`.</p> | 2.5.2 | 3.0.0 | 3.1.4 | 3.1.4 | 3.3.2 | 3.4.0 | 3.4.3 ||
|| <p>[amcheck]({{ pg-docs }}/amcheck.html)</p><p>Содержит функции проверки логической согласованности реляционной структуры баз данных.</p><p>Для использования расширения необходима [роль `mdb_admin`](../../concepts/roles.md#mdb-admin) или [роль `mdb_superuser`](../../concepts/roles.md#mdb-superuser).</p> | 1.1 | 1.2 | 1.2 | 1.3 | 1.3 | 1.3 | 1.4 ||
|| <p>[autoinc]({{ pg-docs }}/contrib-spi.html#id-1.11.7.47.6)</p><p>Содержит функцию `autoinc()`. Она возвращает следующее значение для последовательности, хранящейся в поле целочисленного типа. В отличие от встроенных типов, управляющих последовательностями, `autoinc()`:
* блокирует попытки вставить в поле значение из запроса;
* позволяет изменять значение в поле при обновлении записи.</p> | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 ||
|| <p>[bloom]({{ pg-docs }}/static/bloom.html)</p><p>Добавляет доступ к индексам баз данных на основе [фильтров Блума](https://ru.wikipedia.org/wiki/Фильтр_Блума). Эти вероятностные структуры данных требуют значительно меньше памяти, чем хеш-таблицы, но допускают ложноположительные срабатывания.</p> | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 ||
|| <p>[btree_gin]({{ pg-docs }}/static/btree-gin.html)</p><p>Содержит примеры классов оператора GIN (Generalized Inverted Index, обобщенный инвертированный индекс), используемого для обратного поиска.</p> | 1.3 | 1.3 | 1.3 | 1.3 | 1.3 | 1.3 | 1.3 ||
|| <p>[btree_gist]({{ pg-docs }}/static/btree-gist.html)</p><p>Содержит классы оператора GiST (Generalized Search Tree, обобщенное дерево поиска). В отличие от индексов B-tree, GiST поддерживает операторы `<>` (<q>не равно</q>) и `<->` (<q>дистанция</q>), хотя и не обеспечивает уникальности возвращаемых значений.</p> | 1.5 | 1.5 | 1.5 | 1.6 | 1.7 | 1.7 | 1.7 ||
|| <p>[citext]({{ pg-docs }}/static/citext.html)</p><p>Содержит тип данных `citext`, используемый для регистронезависимой работы со строками.</p> | 1.5 | 1.6 | 1.6 | 1.6 | 1.6 | 1.6 | 1.6 ||
|| <p>[clickhouse_fdw](https://github.com/adjust/clickhouse_fdw)</p><p>Добавляет поддержку [Foreign Data Wrapper](https://wiki.postgresql.org/wiki/Foreign_data_wrappers) для доступа к базам данных {{ CH }}, поддерживает операции `SELECT FROM` и `INSERT INTO`.</p><p>Расширение не поддерживается в версиях {{ PG }} 16 и выше. Для загрузки данных в БД {{ CH }} используйте сервис [{{ data-transfer-full-name }}](../../../data-transfer/tutorials/rdbms-to-clickhouse.md).</p> | 1.3 | 1.3 | 1.3 | - | 1.4 | - | - ||
|| <p>[cube]({{ pg-docs }}/static/cube.html)</p><p>Содержит тип данных `cube`, используемый для представления многомерных кубов.</p> | 1.4 | 1.4 | 1.4 | 1.5 | 1.5 | 1.5 | 1.5 ||
|| <p>[dblink]({{ pg-docs }}/static/dblink.html)</p><p>Добавляет поддержку подключения к другим базам данных {{ PG }} из текущей сессии.</p><p>Для использования расширения необходима [роль `mdb_admin`](../../concepts/roles.md#mdb-admin) или [роль `mdb_superuser`](../../concepts/roles.md#mdb-superuser).</p> | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 ||
|| <p>[dict_int]({{ pg-docs }}/static/dict-int.html)</p><p>Содержит пример дополнительного шаблона словаря для полнотекстового поиска. Использование шаблона позволяет избежать разрастания списка уникальных слов и увеличивает скорость поиска.</p><p>Для полнотекстового поиска помимо расширения также доступны [словари от Hunspell](hunspell.md).</p> | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 ||
|| <p>[dict_xsyn]({{ pg-docs }}/static/dict-xsyn.html)</p><p>Содержит пример дополнительного шаблона словаря синонимов (Extended Synonym Dictionary) для полнотекстового поиска: при поиске слова будут найдены также все его синонимы.</p><p>Для полнотекстового поиска помимо расширения также доступны [словари от Hunspell](hunspell.md).</p> | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | - ||
|| <p>[earthdistance]({{ pg-docs }}/static/earthdistance.html)</p><p>Содержит модуль для вычисления расстояний между точками на поверхности Земли. Вычисление расстояния производится двумя способами:
* через тип данных `cube` (требует включения расширения `cube`);
* через встроенный тип данных `point`.</p> | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 ||
|| <p>[fuzzystrmatch]({{ pg-docs }}/fuzzystrmatch.html)</p><p>Содержит функции, используемые для определения сходства и различия строк.</p> | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 1.2 | 1.2 ||
|| <p>[hstore]({{ pg-docs }}/static/hstore.html)</p><p>Содержит тип `hstore`, позволяющий хранить пары <q>ключ:значение</q> в одном поле таблицы и эффективно работать с ними.</p> | 1.5 | 1.6 | 1.7 | 1.8 | 1.8 | 1.8 | 1.8 ||
|| <p>[hypopg](https://hypopg.readthedocs.io/en/rel1_stable/)</p><p>Содержит виртуальные индексы. Они позволяют с минимальными затратами ресурсов выяснить, будет ли {{ PG }} использовать реальные индексы при обработке [проблемных запросов](../../tutorials/profiling.md#solving-inefficient-queries).</p> | 1.3.1 | 1.3.1 | 1.3.1 | 1.3.1 | 1.3.1 | 1.4.0 | 1.4.1 ||
|| <p>[intarray]({{ pg-docs }}/static/intarray.html)</p><p>Содержит функции и операторы для работы с массивами целых чисел, в которых нет пустых (`NULL`) значений.</p> | 1.2 | 1.2 | 1.3 | 1.5 | 1.5 | 1.5 | 1.5 ||
|| <p>[isn]({{ pg-docs }}/static/isn.html)</p><p>Содержит типы данных для международных стандартов нумерации продукции EAN13, UPC, ISBN, ISMN и ISSN. Проверка и формирование номеров осуществляется по заданному списку префиксов.</p> | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 ||
|| <p>[jsquery](https://github.com/postgrespro/jsquery)</p><p>Добавляет поддержку языка JsQuery, используемого для работы с данными типа `jsonb`. JsQuery позволяет организовать эффективный поиск во вложенных объектах и содержит дополнительные операторы сравнения с поддержкой индексов.</p> | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 ||
|| <p>[lo]({{ pg-docs }}/static/lo.html)</p><p>Содержит тип данных `lo` и функцию `lo_manage()`. Они используются для управления большими бинарными объектами (Binary Large Object, BLOB) в соответствии с требованиями спецификаций драйверов JDBC и ODBC (стандартное поведение {{ PG }} им не соответствует).</p> | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 ||
|| <p>[logerrors](https://github.com/munakoiso/logerrors)</p><p>Добавляет возможность сбора статистики о сообщениях в логах.</p> | - | - | - | - | - | - | 2.0 ||
|| <p>[ltree]({{ pg-docs }}/static/ltree.html)</p><p>Содержит тип данных `ltree` для представления меток данных, хранящихся в древовидной иерархической структуре.</p> | 1.1 | 1.1 | 1.2 | 1.2 | 1.2 | 1.2 | 1.3 ||
|| <p>[lwaldump](https://github.com/g0djan/lwaldump/tree/REL_13_STABLE)</p><p>Добавляет возможность получения последнего порядкового номера журнала (LSN), записанного на диск реплики.</p> | - | - | - | - | - | - | 1.0 ||
|| <p>[moddatetime]({{ pg-docs }}/static/contrib-spi.html#id-1.11.7.47.8)</p><p>Содержит функцию `moddatetime()`, позволяющую отслеживать время последней модификации строки таблицы.</p> | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 ||
|| <p>[oracle_fdw](https://github.com/laurenz/oracle_fdw)</p><p>Добавляет поддержку [Foreign Data Wrapper](https://wiki.postgresql.org/wiki/Foreign_data_wrappers) для доступа к базам данных Oracle.</p><p>Для использования расширения необходима [роль `mdb_admin`](../../concepts/roles.md#mdb-admin) или [роль `mdb_superuser`](../../concepts/roles.md#mdb-superuser).</p> | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 ||
|| <p>[orafce](https://github.com/orafce/orafce)</p><p>Добавляет функции и операторы, которые эмулируют набор функций и пакетов БД Oracle.</p> | 3.18 | 3.18 | 3.18 | 3.18 | 3.25 | 4.6 | 4.13 ||
|| <p>[pg_buffercache]({{ pg-docs }}/pgbuffercache.html)</p><p>Добавляет функции мониторинга общего буферного кеша.</p><p>Для использования расширения необходима [роль `mdb_admin`](../../concepts/roles.md#mdb-admin) или [роль `mdb_superuser`](../../concepts/roles.md#mdb-superuser).</p> | 1.3 | 1.3 | 1.3 | 1.3 | 1.3 | 1.4 | 1.5 ||
|| <p>[pg_cron](https://github.com/citusdata/pg_cron)</p><p>Позволяет добавлять в базу данных задачи по расписанию и выполнять SQL-запросы непосредственно из задачи.</p><p>Требует [подключения библиотеки общего пользования](#libraries-connection) `pg_cron`.</p><p>Для использования расширения необходима [роль `mdb_admin`](../../concepts/roles.md#mdb-admin) или [роль `mdb_superuser`](../../concepts/roles.md#mdb-superuser).</p><p>Подключение расширения приводит к перезагрузке всех хостов. Подробнее см. в разделе [Использование pg_cron](./pg_cron.md).</p>  | 1.4.1 | 1.4.1 | 1.4.1 | 1.4.1 | 1.4.1 | 1.5 | 1.6 ||
|| <p>[pg_hint_plan](http://pghintplan.osdn.jp/)</p><p>Содержит функции для управления планировщиком {{ PG }}.</p><p>Требует [подключения библиотеки общего пользования](#libraries-connection) `pg_hint_plan`.</p> | 1.3.4 | 1.3.5 | 1.3.7 | 1.4 | - | 1.6.0 | 1.7.0 ||
|| <p>[pg_partman](https://github.com/pgpartman/pg_partman)</p><p>Добавляет расширенные возможности по партицированию таблиц, в том числе на основе времени или последовательности.</p>  | 4.0.0 | 4.2.0 | 4.4.0 | 4.6.0 | 4.7.0 | 4.7.4 | 5.1.0 ||
|| <p>[pg_qualstats](https://github.com/powa-team/pg_qualstats)</p><p>Добавляет возможность сбора статистики по предикатам в выражениях `WHERE` и предложениях `JOIN`.</p><p>Требует [подключения библиотеки общего пользования](#libraries-connection) `pg_qualstats`.</p> | 2.0.3 | 2.0.3 | 2.0.3 | 2.0.3 | 2.0.4 | 2.1.0 | 2.1.1 ||
|| <p>[pg_prewarm]({{ pg-docs }}/pgprewarm.html)</p><p>Позволяет загружать данные отношений в кеш операционной системы или в кеш буферов {{ PG }}.</p> | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 ||
|| <p>[pg_repack](http://reorg.github.io/pg_repack/)</p><p>Содержит функции для удаления раздувания (bloat) из таблиц и индексов. В отличие от `CLUSTER` и `VACUUM FULL`, не требует эксклюзивной блокировки таблиц.</p><p>Для использования расширения необходима [роль `mdb_admin`](../../concepts/roles.md#mdb-admin) или [роль `mdb_superuser`](../../concepts/roles.md#mdb-superuser).</p> | 1.4.6 | 1.4.6 | 1.4.6 | 1.4.7 | 1.4.8 | 1.4.8 | 1.4.8 ||
|| <p>[pg_stat_kcache](https://github.com/powa-team/pg_stat_kcache)</p><p>Добавляет возможность сбора статистики по операциям чтения и записи, выполненным на уровне файловой системы.</p><p>Требует включения расширения `pg_stat_statements`.</p><p>Для использования расширения необходима [роль `mdb_admin`](../../concepts/roles.md#mdb-admin) или [роль `mdb_superuser`](../../concepts/roles.md#mdb-superuser).</p> | 2.1.1 | 2.1.1 | 2.1.3 | 2.2.0 | 2.2.1 | 2.2.1 | 2.3.0 ||
|| <p>[pg_stat_query_plans](https://github.com/postgredients/pg_stat_query_plans)</p><p>Добавляет возможности отслеживания статистики выполнения SQL-запросов и их планов.</p><p>Требует [подключения библиотеки общего пользования](#libraries-connection) `pg_stat_query_plans`.</p> | - | - | - | - | - | - | 1.0 ||
|| <p>[pg_stat_statements]({{ pg-docs }}/pgstatstatements.html)</p><p>Добавляет возможности отслеживания планирования и сбора статистики выполнения всех SQL-запросов, запущенных в кластере.</p><p>Для использования расширения необходима [роль `mdb_monitor`](../../concepts/roles.md#mdb_monitor).</p> | 1.6 | 1.7 | 1.8 | 1.9 | 1.10 | 1.10 | 1.11 ||
|| <p>[pg_tm_aux](https://github.com/x4m/pg_tm_aux)</p><p>Позволяет создавать логический слот репликации в прошлом.</p> | 1.0 | 1.0 | 1.0 | 1.0 | 1.1 | 1.1.1 | 1.1.1 ||
|| <p>[pg_trgm]({{ pg-docs }}/static/pgtrgm.html)</p><p>Содержит инструменты для быстрого поиска похожих строк на основе сопоставления триграмм.</p> | 1.4 | 1.4 | 1.5 | 1.6 | 1.6 | 1.6 | 1.6 ||
|| <p>[pgaudit](https://www.pgaudit.org/)</p><p>Предоставляет дополнительные инструменты для логирования и повышает возможности аудита.</p><p>Требует [подключения библиотеки общего пользования](#libraries-connection) `pgaudit`.</p><p>Подробнее см. в разделе [Использование pgaudit](./pgaudit.md).</p>  | 1.0.0 | 1.0.0 | 1.0.0 | 1.0.0 | 1.7 | 16.0 | 17.0 ||
|| <p>[pgcrypto]({{ pg-docs }}/static/pgcrypto.html)</p><p>Предоставляет криптографические функции для {{ PG }}. Подробнее см. в разделе [Использование pgcrypto](./pgcrypto.md).</p> | 1.3 | 1.3 | 1.3 | 1.3 | 1.3 | 1.3 | 1.3 ||
|| <p>[pglogical](https://github.com/2ndQuadrant/pglogical)</p><p>Добавляет поддержку потоковой логической репликации с использованием механизма публикации/подписки.</p> | 2.4.1 | 2.4.1 | 2.4.1 | 2.4.1 | - | 2.4.3 | 2.4.5 ||
|| <p>[pgrouting](http://pgrouting.org/)</p><p>Содержит функции для геопространственной маршрутизации базы данных [PostGIS](https://www.postgis.net/).</p> | 2.6.2 | 2.6.2 | 3.0.2 | 3.3.0 | 3.4.1 | 3.5.0 | 3.6.2 ||
|| <p>[pgrowlocks]({{ pg-docs }}/static/pgrowlocks.html)</p><p>Содержит функцию `pgrowlocks()`, которая возвращает сведения о блокировке строк в указанной таблице.</p> | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 | 1.2 ||
|| <p>[pgstattuple]({{ pg-docs }}/pgstattuple.html)</p><p>Содержит функции для получения статистики на уровне кортежей.</p><p>Для использования расширения необходима [роль `mdb_admin`](../../concepts/roles.md#mdb-admin) или [роль `mdb_superuser`](../../concepts/roles.md#mdb-superuser).</p> | 1.5 | 1.5 | 1.5 | 1.5 | 1.5 | 1.5 | 1.5 ||
|| <p>[pgvector](https://github.com/pgvector/pgvector)</p><p>Добавляет поиск векторного подобия.</p> | 0.2.5 | 0.2.5 | 0.2.5 | 0.2.5 | 0.3.2 | 0.5.1 | 0.5.1 ||
|| <p>[plpgsql](https://www.timescale.com/learn/postgresql-extensions-plpgsql)</p><p>Добавляет поддержку процедурного языка PL/pgSQL.</p> | - | - | - | - | - | - | 1.0 ||
|| <p>[plv8](https://plv8.github.io/)</p><p>Добавляет поддержку процедурного языка на основе JavaScript и движка V8.</p> | 3.0.0 | 3.0.0 | 3.0.0 | 3.0.0 | - | 3.2.0 | - ||
|| <p>[postgis](https://postgis.net/docs/)</p><p>Добавляет возможности хранения и обработки объектов геоинформационных систем (ГИС) в базах данных {{ PG }}.</p> | 2.5.2 | 3.0.0 | 3.1.4 | 3.1.4 | 3.3.2 | 3.4.0 | 3.4.3 ||
|| <p>[postgis_tiger_geocoder](https://postgis.net/docs/postgis_installation.html#loading_extras_tiger_geocoder)</p><p>Содержит функции для геокодирования на основе данных в формате [TIGER](https://wiki.openstreetmap.org/wiki/TIGER).</p> | 2.5.2 | 3.0.0 | 3.1.4 | 3.1.4 | 3.3.2 | 3.4.0 | 3.4.3 ||
|| <p>[postgis_topology](https://postgis.net/docs/Topology.html)</p><p>Содержит типы данных и функции расширения `postgis` для управления топологическими объектами.</p> | 2.5.2 | 3.0.0 | 3.1.4 | 3.1.4 | 3.3.2 | 3.4.0 | 3.4.3 ||
|| <p>[postgres_fdw]({{ pg-docs }}/static/postgres-fdw.html)</p><p>Добавляет поддержку [Foreign Data Wrapper](https://wiki.postgresql.org/wiki/Foreign_data_wrappers) для доступа к внешним серверам {{ PG }}.</p><p>Для использования расширения необходима [роль `mdb_admin`](../../concepts/roles.md#mdb-admin) или [роль `mdb_superuser`](../../concepts/roles.md#mdb-superuser).</p> | 1.0 | 1.0 | 1.0 | 1.1 | 1.1 | 1.1 | 1.1 ||
|| <p>[postgresql_anonymizer](https://postgresql-anonymizer.readthedocs.io/en/stable/)</p><p>Позволяет замаскировать или заменить данные в базе данных {{ PG }}.</p><p>Требует [подключения библиотеки общего пользования](#libraries-connection) `anon`.</p><p>Для использования расширения необходима [роль `mdb_admin`](../../concepts/roles.md#mdb-admin) или [роль `mdb_superuser`](../../concepts/roles.md#mdb-superuser).</p> | - | - | - | - | 1.3.2 | 1.3.2 | - ||
|| <p>[rum](https://github.com/postgrespro/rum)</p><p>Добавляет метод доступа для работы с индексами `RUM`.</p> | 1.3 | 1.3 | 1.3 | 1.3 | 1.3 | 1.3 | 1.3 ||
|| <p>[seg]({{ pg-docs }}/static/seg.html)</p><p>Содержит тип данных `seg` для представления отрезков линий или интервалов с плавающей запятой.</p> | 1.3 | 1.3 | 1.3 | 1.4 | 1.4 | 1.4 | 1.4 ||
|| <p>[smlar](http://sigaev.ru/git/gitweb.cgi?p=smlar.git;a=blob;hb=HEAD;f=README)</p><p>Содержит набор функций для определения сходства массивов.</p> | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | - ||
|| <p>[tablefunc](https://www.postgresql.org/docs/current/static/tablefunc.html)</p><p>Содержит набор функций, возвращающих таблицы (наборы строк).</p> | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 | 1.0 ||
|| <p>[timescaledb](https://github.com/timescale/timescaledb)</p><p>Добавляет возможности автоматического партицирования таблиц по времени и пространству (ключу партицирования), сохраняя при этом стандартный интерфейс {{ PG }} для работы с данными. Это позволяет масштабировать {{ PG }} для обработки временных рядов.</p><p>Требует [подключения библиотеки общего пользования](#libraries-connection) `timescaledb`.</p><p>В сервис устанавливается издание TimescaleDB Apache 2 Edition. Оно имеет ограниченную функциональность по сравнению с TimescaleDB Community Edition. Изменить издание нельзя. Подробнее об ограничениях см. в [документации TimescaleDB](https://docs.timescale.com/about/latest/timescaledb-editions/).</p> | 2.3.1 | 2.4.2 | 2.5.2 | 2.6.1 | 2.9.0 | 2.13.0-dev | 2.16.1 ||
|| <p>[unaccent]({{ pg-docs }}/static/unaccent.html)</p><p>Содержит словарь для поиска текста без учета диакритических знаков.</p> | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 ||
|| <p>[uuid-ossp]({{ pg-docs }}/static/uuid-ossp.html)</p><p>Содержит функции для генерации UUID по стандартным алгоритмам.</p> | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 ||
|| <p>[xml2]({{ pg-docs }}/static/xml2.html)</p><p>Добавляет поддержку запросов XPath и языка XSLT.</p> | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 | 1.1 ||
|#

Утилита [pgcompacttable](https://github.com/dataegret/pgcompacttable) позволяет реорганизовать данные в таблицах, чтобы уменьшить занимаемый ими объем, без влияния на производительность кластера.

Синтаксис использования:

```bash
./bin/pgcompacttable \
  -h c-<идентификатор_кластера>.rw.{{ dns-zone }} \
  -p 6432 \
  -U <имя_пользователя> \
  -W <пароль> \
  -d <имя_БД> \
  -n <имя_схемы> \
  -t <имя_таблицы>
```

Требует включения расширения `pgstattuple`.

Для использования утилиты необходима [роль `mdb_admin`](../../concepts/roles.md#mdb-admin) или [роль `mdb_superuser`](../../concepts/roles.md#mdb-superuser).

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
