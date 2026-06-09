# Управление расширениями

Managed Service for PostgreSQL поддерживает многие стандартные расширения PostgreSQL и некоторые нестандартные. Полный список доступных расширений и их версий в зависимости от версии PostgreSQL [приведен ниже](#postgresql).

{% note warning %}

В кластерах Managed Service for PostgreSQL нельзя управлять расширениями PostgreSQL с помощью команд SQL.

{% endnote %}

## Подключение библиотек для расширений {#libraries-connection}

Некоторые расширения требуют подключения библиотек общего пользования (shared libraries). Чтобы подключить библиотеку, при [создании](../cluster-create.md) или [изменении](../update.md#change-postgresql-config) кластера укажите ее имя в [параметре Shared preload libraries](../../concepts/settings-list.md#setting-shared-libraries).

Managed Service for PostgreSQL поддерживает подключение библиотек:

* `age` — необходима для работы [расширения age](https://age.apache.org);
* `anon` — необходима для работы [расширения postgresql_anonymizer](https://postgresql-anonymizer.readthedocs.io/en/stable/);
* `auto_explain` — необходима для работы [расширения auto_explain](https://www.postgresql.org/docs/current/auto-explain.html);
* `pg_cron` — необходима для работы [расширения pg_cron](https://github.com/citusdata/pg_cron);
* `pg_hint_plan` — необходима для работы [расширения pg_hint_plan](https://github.com/ossc-db/pg_hint_plan);
* `pg_qualstats` — необходима для работы [расширения pg_qualstats](https://github.com/powa-team/pg_qualstats);
* `pgaudit` — необходима для работы [расширения pgaudit](https://www.pgaudit.org/);
* `pglogical` — необходима для работы [расширения pglogical](https://github.com/2ndQuadrant/pglogical);
* `timescaledb` — необходима для работы [расширения TimescaleDB](https://github.com/timescale/timescaledb).

Чтобы объявить библиотеку в Terraform-манифесте, укажите ее название в формате `SHARED_PRELOAD_LIBRARIES_<название_библиотеки>`. Например, `SHARED_PRELOAD_LIBRARIES_TIMESCALEDB`.

{% note warning %}

Подключение библиотеки общего пользования приведет к перезагрузке PostgreSQL на хосте-мастере.

{% endnote %}

## Получить список установленных расширений {#list-extensions}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера и выберите блок **Базы данных**.
  1. В колонке **Расширения PostgreSQL** будет отображаться список расширений, подключенных к каждой базе данных.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить список расширений для базы данных, выполните команду:

  ```bash
  yc managed-postgresql database get <имя_БД> \
     --cluster-name <имя_кластера>
  ```

  Включенные расширения будут перечислены в списке `extensions`.

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Воспользуйтесь методом [Database.Get](../../api-ref/Database/get.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/<идентификатор_кластера>/databases/<имя_БД>'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](../cluster-list.md#list-clusters), а имя БД — со [списком БД в кластере](../databases.md#list-db).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/Database/get.md#responses).

     Список установленных расширений приведен в параметре `extensions` в выводе команды.

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
  1. Воспользуйтесь вызовом [DatabaseService.Get](../../api-ref/grpc/Database/get.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.postgresql.v1.DatabaseService.Get
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](../cluster-list.md#list-clusters), а имя БД — со [списком БД в кластере](../databases.md#list-db).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/grpc/Database/get.md#yandex.cloud.mdb.postgresql.v1.Database).

     Список установленных расширений приведен в параметре `extensions` в выводе команды.

{% endlist %}

## Изменить список установленных расширений {#update-extensions}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Базы данных**.
  1. В строке с нужной базой данных нажмите значок ![options](../../../_assets/console-icons/ellipsis.svg) и выберите пункт **Настроить**.
  1. Выберите необходимые расширения и нажмите кнопку **Изменить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить расширения для базы данных, передайте их список в аргументе `--extensions` команды CLI. При этом расширения, не упомянутые в списке, будут выключены.

  ```bash
  yc managed-postgresql database update <имя_БД> \
     --cluster-name <имя_кластера> \
     --extensions <имя_расширения>,<имя_расширения>...
  ```

  При установке нескольких расширений могут возникнуть ошибки. Подробнее о возможных причинах и способах устранения ошибок см. в разделе [Вопросы и ответы](../../qa/errors.md#cli-extensions-error).

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](../cluster-create.md).

     Полный список доступных для изменения полей конфигурации базы данных кластера Managed Service for PostgreSQL см. в [документации провайдера Terraform](../../../terraform/resources/mdb_postgresql_database.md).

  1. Добавьте к описанию соответствующей базы данных кластера один или несколько блоков `extension` (по одному блоку на каждое расширение):

      ```hcl
      resource "yandex_mdb_postgresql_database" "<имя_БД>" {
        ...
        extension {
          name    = "<имя_расширения>"
        }
        ...
      }
      ```

  1. Проверьте корректность настроек.

     1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
     1. Выполните команду:
     
        ```bash
        terraform validate
        ```
     
        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Подтвердите изменение ресурсов.

     1. Выполните команду для просмотра планируемых изменений:
     
        ```bash
        terraform plan
        ```
     
        Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
     
     1. Если вас устраивают планируемые изменения, внесите их:
        1. Выполните команду:
     
           ```bash
           terraform apply
           ```
     
        1. Подтвердите изменение ресурсов.
        1. Дождитесь завершения операции.

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Воспользуйтесь методом [Database.Update](../../api-ref/Database/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

     {% note warning %}
     
     Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
     
     {% endnote %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/<идентификатор_кластера>/databases/<имя_БД>' \
       --data '{
                 "updateMask": "extensions",
                 "extensions": [
                   {
                     "name": "<имя_расширения>"
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

       * `name` — имя расширения.

       Указывайте имя в соответствии со [списком поддерживаемых расширений и утилит PostgreSQL](#postgresql).

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](../cluster-list.md#list-clusters), а имя БД — со [списком БД в кластере](../databases.md#list-db).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/Database/update.md#responses).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
  1. Воспользуйтесь вызовом [DatabaseService.Update](../../api-ref/grpc/Database/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

     {% note warning %}
     
     Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask` (в виде массива строк `paths[]`).
     
     {% cut "Формат перечисления настроек" %}
     
     ```yaml
     "update_mask": {
         "paths": [
             "<настройка_1>",
             "<настройка_2>",
             ...
             "<настройка_N>"
         ]
     }
     ```
     
     {% endcut %}
     
     {% endnote %}

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
                 "name": "<имя_расширения>"
               },
               { <аналогичный_набор_настроек_для_расширения_2> },
               { ... },
               { <аналогичный_набор_настроек_для_расширения_N> }
             ]
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.postgresql.v1.DatabaseService.Update
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

       В данном случае передается только один параметр.

     * `extensions` — массив расширений БД. Один элемент массива содержит настройки для одного расширения и имеет следующую структуру:

       * `name` — имя расширения.

       Указывайте имя в соответствии со [списком поддерживаемых расширений и утилит PostgreSQL](#postgresql).

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](../cluster-list.md#list-clusters), а имя БД — со [списком БД в кластере](../databases.md#list-db).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/grpc/Database/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Поддерживаемые расширения и утилиты PostgreSQL {#postgresql}

#|
|| **Расширение** \ **Версия PostgreSQL** | **14** | **15** | **16** | **17** | **18** ||
|| <p>[address_standardizer](https://postgis.net/docs/manual-3.1/postgis_installation.html#installing_pagc_address_standardizer)</p><p>Содержит функции для нормализации почтовых адресов, переданных в виде строки.</p> | 3.1.4 | 3.3.2 | 3.4.0 | 3.4.3 | - ||
|| <p>[address_standardizer_data_us](https://postgis.net/docs/manual-3.1/postgis_installation.html#make_install_postgis_extensions)</p><p>Содержит правила нормализации почтовых адресов США и Канады для расширения `address_standardizer`.</p> | 3.1.4 | 3.3.2 | 3.4.0 | 3.4.3 | - ||
|| <p>[age](https://age.apache.org)</p><p>Добавляет поддержку [графовых баз данных](https://en.wikipedia.org/wiki/Graph_database), в том числе:
* хранение графовых БД;
* управление графовыми БД;
* операции над графами.</p>

Требует [подключения библиотеки общего пользования](#libraries-connection) `age`. | - | - | 1.5.0 | 1.5.0 | - ||
|| <p>[amcheck](https://www.postgresql.org/docs/current/amcheck.html)</p><p>Содержит функции проверки логической согласованности реляционной структуры баз данных.</p><p>Для использования расширения необходима [роль `mdb_admin`](../../concepts/roles.md#mdb-admin).</p> | 1.3 | 1.3 | 1.3 | 1.4 | - ||
|| <p>[autoinc](https://www.postgresql.org/docs/current/contrib-spi.html#id-1.11.7.47.6)</p><p>Содержит функцию `autoinc()`. Она возвращает следующее значение для последовательности, хранящейся в поле целочисленного типа. В отличие от встроенных типов, управляющих последовательностями, `autoinc()`:
* блокирует попытки вставить в поле значение из запроса;
* позволяет изменять значение в поле при обновлении записи.</p> | 1.0 | 1.0 | 1.0 | 1.0 | - ||
|| <p>[bloom](https://www.postgresql.org/docs/current/static/bloom.html)</p><p>Добавляет доступ к индексам баз данных на основе [фильтров Блума](https://ru.wikipedia.org/wiki/Фильтр_Блума). Эти вероятностные структуры данных требуют значительно меньше памяти, чем хеш-таблицы, но допускают ложноположительные срабатывания.</p> | 1.0 | 1.0 | 1.0 | 1.0 | - ||
|| <p>[btree_gin](https://www.postgresql.org/docs/current/static/btree-gin.html)</p><p>Содержит примеры классов оператора GIN (Generalized Inverted Index, обобщенный инвертированный индекс), используемого для обратного поиска.</p> | 1.3 | 1.3 | 1.3 | 1.3 | - ||
|| <p>[btree_gist](https://www.postgresql.org/docs/current/static/btree-gist.html)</p><p>Содержит классы оператора GiST (Generalized Search Tree, обобщенное дерево поиска). В отличие от индексов B-tree, GiST поддерживает операторы `<>` (<q>не равно</q>) и `<->` (<q>дистанция</q>), хотя и не обеспечивает уникальности возвращаемых значений.</p> | 1.6 | 1.7 | 1.7 | 1.7 | - ||
|| <p>[citext](https://www.postgresql.org/docs/current/static/citext.html)</p><p>Содержит тип данных `citext`, используемый для регистронезависимой работы со строками.</p> | 1.6 | 1.6 | 1.6 | 1.6 | - ||
|| <p>[clickhouse_fdw](https://github.com/adjust/clickhouse_fdw)</p><p>Добавляет поддержку [Foreign Data Wrapper](https://wiki.postgresql.org/wiki/Foreign_data_wrappers) для доступа к базам данных ClickHouse®, поддерживает операции `SELECT FROM` и `INSERT INTO`.</p><p>Расширение не поддерживается в версиях PostgreSQL 16 и выше. Для загрузки данных в БД ClickHouse® используйте сервис [Yandex Data Transfer](../../../data-transfer/tutorials/rdbms-to-clickhouse.md).</p> | 1.4 | 1.4 | - | - | - ||
|| <p>[cube](https://www.postgresql.org/docs/current/static/cube.html)</p><p>Содержит тип данных `cube`, используемый для представления многомерных кубов.</p> | 1.5 | 1.5 | 1.5 | 1.5 | - ||
|| <p>[dblink](https://www.postgresql.org/docs/current/static/dblink.html)</p><p>Добавляет поддержку подключения к другим базам данных PostgreSQL из текущей сессии.</p><p>Для использования расширения необходима [роль `mdb_admin`](../../concepts/roles.md#mdb-admin).</p> | 1.2 | 1.2 | 1.2 | 1.2 | - ||
|| <p>[dict_int](https://www.postgresql.org/docs/current/static/dict-int.html)</p><p>Содержит пример дополнительного шаблона словаря для полнотекстового поиска. Использование шаблона позволяет избежать разрастания списка уникальных слов и увеличивает скорость поиска.</p><p>Для полнотекстового поиска помимо расширения также доступны [словари от Hunspell](hunspell.md).</p> | 1.0 | 1.0 | 1.0 | 1.0 | - ||
|| <p>[dict_xsyn](https://www.postgresql.org/docs/current/static/dict-xsyn.html)</p><p>Содержит пример дополнительного шаблона словаря синонимов (Extended Synonym Dictionary) для полнотекстового поиска: при поиске слова будут найдены также все его синонимы.</p><p>Для полнотекстового поиска помимо расширения также доступны [словари от Hunspell](hunspell.md).</p> | 1.0 | 1.0 | 1.0 | - | - ||
|| <p>[earthdistance](https://www.postgresql.org/docs/current/static/earthdistance.html)</p><p>Содержит модуль для вычисления расстояний между точками на поверхности Земли. Вычисление расстояния производится двумя способами:
* через тип данных `cube` (требует включения расширения `cube`);
* через встроенный тип данных `point`.</p> | 1.1 | 1.1 | 1.1 | 1.1 | - ||
|| <p>[fuzzystrmatch](https://www.postgresql.org/docs/current/fuzzystrmatch.html)</p><p>Содержит функции, используемые для определения сходства и различия строк.</p> | 1.1 | 1.1 | 1.2 | 1.2 | - ||
|| <p>[h3](https://github.com/zachasme/h3-pg)</p><p>Добавляет поддержку структур данных [библиотеки H3](https://h3geo.org/docs/) для геопространственного иерархического разбиения на гексагональные ячейки и построения сетки таких ячеек на поверхности Земли.</p> | - | - | 4.1.3 | 4.1.3 | 4.2.3 ||
|| <p>[h3_postgis](https://github.com/libreearth/h3_postgis)</p><p>Добавляет поддержку структур данных [библиотеки H3](https://h3geo.org/docs/) при работе с объектами геоинформационных систем (ГИС).</p> | - | - | 4.1.3 | 4.1.3 | - ||
|| <p>[hstore](https://www.postgresql.org/docs/current/static/hstore.html)</p><p>Содержит тип `hstore`, позволяющий хранить пары <q>ключ:значение</q> в одном поле таблицы и эффективно работать с ними.</p> | 1.8 | 1.8 | 1.8 | 1.8 | - ||
|| <p>[hypopg](https://hypopg.readthedocs.io/en/rel1_stable/)</p><p>Содержит виртуальные индексы. Они позволяют с минимальными затратами ресурсов выяснить, будет ли PostgreSQL использовать реальные индексы при обработке [проблемных запросов](../../tutorials/profiling.md#solving-inefficient-queries).</p> | 1.3.1 | 1.3.1 | 1.4.0 | 1.4.1 | 1.4.2 ||
|| <p>[intarray](https://www.postgresql.org/docs/current/static/intarray.html)</p><p>Содержит функции и операторы для работы с массивами целых чисел, в которых нет пустых (`NULL`) значений.</p> | 1.5 | 1.5 | 1.5 | 1.5 | - ||
|| <p>[isn](https://www.postgresql.org/docs/current/static/isn.html)</p><p>Содержит типы данных для международных стандартов нумерации продукции EAN13, UPC, ISBN, ISMN и ISSN. Проверка и формирование номеров осуществляется по заданному списку префиксов.</p> | 1.2 | 1.2 | 1.2 | 1.2 | - ||
|| <p>[jsquery](https://github.com/postgrespro/jsquery)</p><p>Добавляет поддержку языка JsQuery, используемого для работы с данными типа `jsonb`. JsQuery позволяет организовать эффективный поиск во вложенных объектах и содержит дополнительные операторы сравнения с поддержкой индексов.</p> | 1.1 | 1.1 | 1.1 | 1.1 | 1.2 ||
|| <p>[lo](https://www.postgresql.org/docs/current/static/lo.html)</p><p>Содержит тип данных `lo` и функцию `lo_manage()`. Они используются для управления большими бинарными объектами (Binary Large Object, BLOB) в соответствии с требованиями спецификаций драйверов JDBC и ODBC (стандартное поведение PostgreSQL им не соответствует).</p> | 1.1 | 1.1 | 1.1 | 1.1 | - ||
|| <p>[logerrors](https://github.com/munakoiso/logerrors)</p><p>Добавляет возможность сбора статистики о сообщениях в логах.</p> | - | - | - | 2.0 | 2.1.2 ||
|| <p>[ltree](https://www.postgresql.org/docs/current/static/ltree.html)</p><p>Содержит тип данных `ltree` для представления меток данных, хранящихся в древовидной иерархической структуре.</p> | 1.2 | 1.2 | 1.2 | 1.3 | - ||
|| <p>[lwaldump](https://github.com/g0djan/lwaldump/tree/REL_13_STABLE)</p><p>Добавляет возможность получения последнего порядкового номера журнала (LSN), записанного на диск реплики.</p> | - | - | - | 1.0 | - ||
|| <p>[moddatetime](https://www.postgresql.org/docs/current/static/contrib-spi.html#id-1.11.7.47.8)</p><p>Содержит функцию `moddatetime()`, позволяющую отслеживать время последней модификации строки таблицы.</p> | 1.0 | 1.0 | 1.0 | 1.0 | - ||
|| <p>[oracle_fdw](https://github.com/laurenz/oracle_fdw)</p><p>Добавляет поддержку [Foreign Data Wrapper](https://wiki.postgresql.org/wiki/Foreign_data_wrappers) для доступа к базам данных Oracle.</p><p>Для использования расширения необходима [роль `mdb_admin`](../../concepts/roles.md#mdb-admin).</p> | 1.2 | 1.2 | 1.2 | 1.2 | 2.8.0 ||
|| <p>[orafce](https://github.com/orafce/orafce)</p><p>Добавляет функции и операторы, которые эмулируют набор функций и пакетов БД Oracle.</p> | 3.18 | 3.25 | 4.6 | - | - ||
|| <p>[pg_buffercache](https://www.postgresql.org/docs/current/pgbuffercache.html)</p><p>Добавляет функции мониторинга общего буферного кеша.</p><p>Для использования расширения необходима [роль `mdb_admin`](../../concepts/roles.md#mdb-admin).</p> | 1.3 | 1.3 | 1.4 | 1.5 | - ||
|| <p>[pg_cron](https://github.com/citusdata/pg_cron)</p><p>Позволяет добавлять в базу данных задачи по расписанию и выполнять SQL-запросы непосредственно из задачи.</p><p>Требует [подключения библиотеки общего пользования](#libraries-connection) `pg_cron`.</p><p>Для использования расширения необходима [роль `mdb_admin`](../../concepts/roles.md#mdb-admin).</p><p>Подключение расширения приводит к перезагрузке всех хостов. Подробнее см. в разделе [Использование pg_cron](pg_cron.md).</p>  | 1.4.1 | 1.4.1 | 1.5 | 1.6 | 1.6.7 ||
|| <p>[pg_hint_plan](http://pghintplan.osdn.jp/)</p><p>Содержит функции для управления планировщиком PostgreSQL.</p><p>Требует [подключения библиотеки общего пользования](#libraries-connection) `pg_hint_plan`.</p> | 1.4 | 1.5 | 1.6.0 | 1.7.0 | 1.8.0 ||
|| <p>[pg_partman](https://github.com/pgpartman/pg_partman)</p><p>Добавляет расширенные возможности по партицированию таблиц, в том числе на основе времени или последовательности.</p>  | 4.6.0 | 4.7.0 | 4.7.4 | 5.1.0 | 5.3.0 ||
|| <p>[pg_prewarm](https://www.postgresql.org/docs/current/pgprewarm.html)</p><p>Позволяет загружать данные отношений в кеш операционной системы или в кеш буферов PostgreSQL.</p> | 1.2 | 1.2 | 1.2 | 1.2 | - ||
|| <p>[pg_qualstats](https://github.com/powa-team/pg_qualstats)</p><p>Добавляет возможность сбора статистики по предикатам в выражениях `WHERE` и предложениях `JOIN`.</p><p>Требует [подключения библиотеки общего пользования](#libraries-connection) `pg_qualstats`.</p> | 2.0.3 | 2.0.4 | 2.1.0 | 2.1.1 | 2.1.2 ||
|| <p>[pg_repack](http://reorg.github.io/pg_repack/)</p><p>Содержит функции для удаления раздувания (bloat) из таблиц и индексов. В отличие от `CLUSTER` и `VACUUM FULL`, не требует эксклюзивной блокировки таблиц.</p><p>Для использования расширения необходима [роль `mdb_admin`](../../concepts/roles.md#mdb-admin).</p> | 1.4.7 | 1.5.2^1^  | 1.5.2^1^  | 1.5.2^1^ | 1.5.2^1^ ||
|| <p>[pg_stat_kcache](https://github.com/powa-team/pg_stat_kcache)</p><p>Добавляет возможность сбора статистики по операциям чтения и записи, выполненным на уровне файловой системы.</p><p>Требует включения расширения `pg_stat_statements`.</p><p>Для использования расширения необходима [роль `mdb_admin`](../../concepts/roles.md#mdb-admin).</p> | 2.2.0 | 2.2.1 | 2.2.1 | 2.3.0 | - ||
|| <p>[pg_stat_statements](https://www.postgresql.org/docs/current/pgstatstatements.html)</p><p>Добавляет возможности отслеживания планирования и сбора статистики выполнения всех SQL-запросов, запущенных в кластере.</p><p>Для использования расширения необходима [роль `mdb_monitor`](../../concepts/roles.md#mdb_monitor).</p> | 1.9 | 1.10 | 1.10 | 1.11 | - ||
|| <p>[pg_tm_aux](https://github.com/x4m/pg_tm_aux)</p><p>Позволяет создавать логический слот репликации в прошлом.</p> | 1.0 | 1.1 | 1.1.1 | 1.1.1 | 57 ||
|| <p>[pg_trgm](https://www.postgresql.org/docs/current/static/pgtrgm.html)</p><p>Содержит инструменты для быстрого поиска похожих строк на основе сопоставления триграмм.</p> | 1.6 | 1.6 | 1.6 | 1.6 | - ||
|| <p>[pg_uuidv7](https://github.com/fboulnois/pg_uuidv7)</p><p>Добавляет поддержку генерации [идентификаторов UUIDv7](https://www.rfc-editor.org/rfc/rfc9562.html#name-uuid-version-7) и управления ими.</p> | - | 1.5 | 1.5 | 1.5 | 1.5.0 ||
|| <p>[pgaudit](https://www.pgaudit.org/)</p><p>Предоставляет дополнительные инструменты для логирования и повышает возможности аудита.</p><p>Требует [подключения библиотеки общего пользования](#libraries-connection) `pgaudit`.</p><p>Подробнее см. в разделе [Использование pgaudit](pgaudit.md).</p>  | 1.0.0 | 1.7 | 16.0 | 17.0 | 18.0 ||
|| <p>[pgcrypto](https://www.postgresql.org/docs/current/static/pgcrypto.html)</p><p>Предоставляет криптографические функции для PostgreSQL. Подробнее см. в разделе [Использование pgcrypto](pgcrypto.md).</p> | 1.3 | 1.3 | 1.3 | 1.3 | - ||
|| <p>[pglogical](https://github.com/2ndQuadrant/pglogical)</p><p>Добавляет поддержку потоковой логической репликации с использованием механизма публикации/подписки.</p><p>Требует [подключения библиотеки общего пользования](#libraries-connection) `pglogical`.</p> | 2.4.1 | 2.4.4 | 2.4.4 | 2.4.5 | 2.4.6 ||
|| <p>[pgrouting](http://pgrouting.org/)</p><p>Содержит функции для геопространственной маршрутизации базы данных [PostGIS](https://www.postgis.net/).</p> | 3.3.0 | 3.4.1 | 3.5.0 | 3.6.2 | 3.8.0 ||
|| <p>[pgrowlocks](https://www.postgresql.org/docs/current/static/pgrowlocks.html)</p><p>Содержит функцию `pgrowlocks()`, которая возвращает сведения о блокировке строк в указанной таблице.</p> | 1.2 | 1.2 | 1.2 | 1.2 | - ||
|| <p>[pgstattuple](https://www.postgresql.org/docs/current/pgstattuple.html)</p><p>Содержит функции для получения статистики на уровне кортежей.</p><p>Для использования расширения необходима [роль `mdb_admin`](../../concepts/roles.md#mdb-admin) или [роль `mdb_superuser`](../../concepts/roles.md#mdb-superuser).</p> | 1.5 | 1.5 | 1.5 | 1.5 | - ||
|| <p>[pgvector](https://github.com/pgvector/pgvector)</p><p>Добавляет поиск векторного подобия.</p><p>Под именем `pgvector` [доступно расширение vector](../../qa/errors.md#vector-error).</p> | 0.2.5 | 0.3.2 | 0.8.0 | 0.8.0 | 0.8.0 ||
|| <p>[plpgsql](https://www.timescale.com/learn/postgresql-extensions-plpgsql)</p><p>Добавляет поддержку процедурного языка PL/pgSQL.</p> | - | - | - | 1.0 | - ||
|| <p>[plv8](https://plv8.github.io/)</p><p>Добавляет поддержку процедурного языка на основе JavaScript и движка V8.</p> | 3.0.0 | - | 3.2.3 | 3.2.3 | 3.2.4 ||
|| <p>[postgis](https://postgis.net/docs/)</p><p>Добавляет возможности хранения и обработки объектов геоинформационных систем (ГИС) в базах данных PostgreSQL.</p> | 3.1.4 | 3.3.2 | 3.4.0 | 3.4.3 | 3.6.0 ||
|| <p>[postgis_raster](https://postgis.net/docs/RT_reference.html)</p><p>Добавляет возможность хранения и обработки растровых геопространственных данных геоинформационных систем (ГИС) в базах данных PostgreSQL.</p> | 3.1.4 | 3.3.2 | 3.4.0 | 3.4.3 | - ||
|| <p>[postgis_tiger_geocoder](https://postgis.net/docs/postgis_installation.html#loading_extras_tiger_geocoder)</p><p>Содержит функции для геокодирования на основе данных в формате [TIGER](https://wiki.openstreetmap.org/wiki/TIGER).</p> | 3.1.4 | 3.3.2 | 3.4.0 | 3.4.3 | - ||
|| <p>[postgis_topology](https://postgis.net/docs/Topology.html)</p><p>Содержит типы данных и функции расширения `postgis` для управления топологическими объектами.</p> | 3.1.4 | 3.3.2 | 3.4.0 | 3.4.3 | - ||
|| <p>[postgres_fdw](https://www.postgresql.org/docs/current/static/postgres-fdw.html)</p><p>Добавляет поддержку [Foreign Data Wrapper](https://wiki.postgresql.org/wiki/Foreign_data_wrappers) для доступа к внешним серверам PostgreSQL.</p><p>Для использования расширения необходима [роль `mdb_admin`](../../concepts/roles.md#mdb-admin).</p> | 1.1 | 1.1 | 1.1 | 1.1 | - ||
|| <p>[postgresql_anonymizer](https://postgresql-anonymizer.readthedocs.io/en/stable/)</p><p>Позволяет замаскировать или заменить данные в базе данных PostgreSQL.</p><p>Требует [подключения библиотеки общего пользования](#libraries-connection) `anon`.</p><p>Подробнее см. в разделе [Использование postgresql_anonymizer](pg_anon.md).</p><p>Для использования расширения необходима [роль `mdb_admin`](../../concepts/roles.md#mdb-admin).</p> | - | 1.3.2 | 1.3.2 | 1.3.2 | 1.3.2 ||
|| <p>[rum](https://github.com/postgrespro/rum)</p><p>Добавляет метод доступа для работы с индексами `RUM`.</p> | 1.3 | 1.3 | 1.3 | 1.3 | 1.3.15 ||
|| <p>[seg](https://www.postgresql.org/docs/current/static/seg.html)</p><p>Содержит тип данных `seg` для представления отрезков линий или интервалов с плавающей запятой.</p> | 1.4 | 1.4 | 1.4 | 1.4 | - ||
|| <p>[smlar](http://sigaev.ru/git/gitweb.cgi?p=smlar.git;a=blob;hb=HEAD;f=README)</p><p>Содержит набор функций для определения сходства массивов.</p> | 1.0 | 1.0 | 1.0 | 1.0 | 18 ||
|| <p>[tablefunc](https://www.postgresql.org/docs/current/static/tablefunc.html)</p><p>Содержит набор функций, возвращающих таблицы (наборы строк).</p> | 1.0 | 1.0 | 1.0 | 1.0 | - ||
|| <p>[timescaledb](https://github.com/timescale/timescaledb)</p><p>Добавляет возможности автоматического партицирования таблиц по времени и пространству (ключу партицирования), сохраняя при этом стандартный интерфейс PostgreSQL для работы с данными. Это позволяет масштабировать PostgreSQL для обработки временных рядов.</p><p>Требует [подключения библиотеки общего пользования](#libraries-connection) `timescaledb`.</p><p>В сервис устанавливается издание TimescaleDB Apache 2 Edition. Оно имеет ограниченную функциональность по сравнению с TimescaleDB Community Edition. Изменить издание нельзя. Подробнее об ограничениях см. в [документации TimescaleDB](https://docs.timescale.com/about/latest/timescaledb-editions/).</p> | 2.6.1 | 2.9.0 | 2.20.3 | 2.20.3 | 2.23.0 ||
|| <p>[unaccent](https://www.postgresql.org/docs/current/static/unaccent.html)</p><p>Содержит словарь для поиска текста без учета диакритических знаков.</p> | 1.1 | 1.1 | 1.1 | 1.1 | - ||
|| <p>[uuid-ossp](https://www.postgresql.org/docs/current/static/uuid-ossp.html)</p><p>Содержит функции для генерации UUID по стандартным алгоритмам.</p> | 1.1 | 1.1 | 1.1 | 1.1 | - ||
|| <p>[xml2](https://www.postgresql.org/docs/current/static/xml2.html)</p><p>Добавляет поддержку запросов XPath и языка XSLT.</p> | 1.1 | 1.1 | 1.1 | 1.1 | - ||
|#

^1^ — эта версия расширения устанавливается в новых кластерах, а также кластерах после обновления версии с 14 и ниже до текущей.

Утилита [pgcompacttable](https://github.com/dataegret/pgcompacttable) позволяет реорганизовать данные в таблицах, чтобы уменьшить занимаемый ими объем, без влияния на производительность кластера.

Синтаксис использования:

```bash
./bin/pgcompacttable \
  -h c-<идентификатор_кластера>.rw.mdb.yandexcloud.net \
  -p 6432 \
  -U <имя_пользователя> \
  -W <пароль> \
  -d <имя_БД> \
  -n <имя_схемы> \
  -t <имя_таблицы>
```

Требует включения расширения `pgstattuple`.

Для использования утилиты необходима [роль `mdb_admin`](../../concepts/roles.md#mdb-admin).

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._