[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for ClickHouse®](../index.md) > [Пошаговые инструкции](index.md) > Кластеры > Изменение настроек ClickHouse® > На уровне сервера

# Изменение настроек ClickHouse® на уровне сервера

Вы можете задать [настройки ClickHouse® на уровне сервера](https://clickhouse.com/docs/ru/operations/server-configuration-parameters/settings), чтобы настроить поведение баз данных или отдельных таблиц в кластере Managed Service for ClickHouse®. Указать настройки можно несколькими способами:

  * С помощью [интерфейсов Yandex Cloud](#yandex-cloud-interfaces). Так можно задать только настройки ClickHouse®, доступные в Yandex Cloud.
  * С помощью [SQL-запросов](#sql-queries). Так задаются настройки для таблиц MergeTree. Вы можете:

    * задать настройки при [создании таблицы](#set-settings-for-new-table);
    * [задать настройки](#change-settings-of-existing-table) существующей таблицы;
    * [вернуть значения по умолчанию](#reset-table-settings) для настроек существующей таблицы.

## Задать настройки ClickHouse® через интерфейсы Yandex Cloud {#yandex-cloud-interfaces}

Изменение некоторых [настроек сервера](../concepts/settings-list.md#server-level-settings) приводит к перезапуску серверов ClickHouse® на хостах кластера.

{% note info %}

Значение настройки [Max server memory usage](https://clickhouse.com/docs/ru/operations/server-configuration-parameters/settings#max_server_memory_usage) нельзя изменять напрямую. Managed Service for ClickHouse® выставляет для нее значение автоматически в зависимости от объема оперативной памяти хостов ClickHouse®. Чтобы изменить значение настройки, [измените класс хостов ClickHouse®](#change-resource-preset). Подробнее в разделе [Управление памятью](../concepts/memory-management.md).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы задать настройки ClickHouse®:

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
   1. Перейдите в сервис **Managed Service for&nbsp;ClickHouse**.
   1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
   1. В блоке **Настройки СУБД** нажмите кнопку **Настроить**.
   1. Задайте [настройки ClickHouse®](../concepts/settings-list.md#server-level-settings).
   1. Нажмите кнопку **Сохранить изменения**.

- CLI {#cli}

   Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

   Чтобы задать настройки ClickHouse®:

   1. Посмотрите полный список настроек, установленных для кластера:

      ```bash
      yc managed-clickhouse cluster get <имя_или_идентификатор_кластера> --full
      ```

   1. Посмотрите описание команды CLI для изменения конфигурации кластера:

      ```bash
      yc managed-clickhouse cluster update-config --help
      ```

   1. Установите нужные значения параметров:

      ```bash
      yc managed-clickhouse cluster update-config <имя_или_идентификатор_кластера> \
         --set <имя_параметра_1>=<значение_1>,...
      ```


- Terraform {#tf}

   Чтобы задать настройки ClickHouse®:

   1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

      Как создать такой файл, описано в разделе [Создание кластера](cluster-create.md).

   1. В описании кластера Managed Service for ClickHouse®, в блоке `clickhouse.config`, измените значения параметров:

      ```hcl
      resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
        ...
        clickhouse = {
          ...

          config = {
            # Общие настройки СУБД
            ...

            merge_tree = {
              # Настройки движка MergeTree
              ...
            }

            kafka = {
              # Общие настройки получения данных из Apache Kafka
              ...
            }

            rabbit_mq = {
              # Настройки получения данных из RabbitMQ
              username = "<имя_пользователя>"
              password = "<пароль>"
            }

            compression = [
              {
                # Настройки сжатия данных
                method              = "<метод_сжатия>"
                min_part_size       = <размер_куска_данных>
                min_part_size_ratio = <отношение_размеров>
              }
            ]

            graphite_rollup = [
              {
                # Настройки движка GraphiteMergeTree для прореживания, агрегирования и усреднения (rollup) данных Graphite.
                ...
              }
            ]
          }
          ...
        }
        ...
      }
      ```

      Где:

      * `method` — метод сжатия: `LZ4` или `ZSTD`.
      * `min_part_size` — минимальный размер куска данных таблицы в байтах.
      * `min_part_size_ratio` — отношение размера наименьшего куска данных в таблице к полному размеру таблицы.

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

   Подробнее в [документации провайдера Terraform](../../terraform/resources/mdb_clickhouse_cluster.md).

   {% note warning "Ограничения по времени" %}
   
   Провайдер Terraform ограничивает время на выполнение операций с кластером Managed Service for ClickHouse®:
   
   * создание, в т. ч. путем восстановления из резервной копии, — 60 минут;
   * изменение — 90 минут;
   * удаление — 30 минут.
   
   Операции, длящиеся дольше указанного времени, прерываются.
   
   {% cut "Как изменить эти ограничения?" %}
   
   Добавьте к описанию кластера блок `timeouts`, например:
   
   ```hcl
   resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
     ...
     timeouts = {
       create = "1h30m" # Полтора часа
       update = "2h"    # 2 часа
       delete = "30m"   # 30 минут
     }
   }
   ```
   
   {% endcut %}
   
   {% endnote %}


- REST API {#api}

   1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

   1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

      {% note warning %}
      
      Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
      
      {% endnote %}

      ```bash
      curl \
         --request PATCH \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --header "Content-Type: application/json" \
         --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>' \
         --data '{
                    "updateMask": "configSpec.clickhouse.config.<настройка_1>,...,configSpec.clickhouse.config.<настройка_N>",
                    "configSpec": {
                       "clickhouse": {
                          "config": {
                             "<настройка_1>": "<значение_1>",
                             "<настройка_2>": "<значение_2>",
                             ...
                             "<настройка_N>": "<значение_N>"
                          }
                       }
                    }
                 }'
      ```

      Где:

      * `updateMask` — перечень изменяемых параметров в одну строку через запятую.
      * `configSpec.clickhouse.config` — настройки ClickHouse® на уровне сервера. Возможные параметры и их значения в [описании метода](../api-ref/Cluster/update.md#yandex.cloud.mdb.clickhouse.v1.UpdateClusterRequest).

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

   1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

   1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

   1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
      
      ```bash
      cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
      ```
      
      Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
   1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
         -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
         -rpc-header "Authorization: Bearer $IAM_TOKEN" \
         -d '{
                "cluster_id": "<идентификатор_кластера>",
                "update_mask": {
                   "paths": [
                      "configSpec.clickhouse.config.<настройка_1>",
                      "configSpec.clickhouse.config.<настройка_2>",
                      ...
                      "configSpec.clickhouse.config.<настройка_N>"
                   ]
                },
                "config_spec": {
                   "clickhouse": {
                      "config": {
                         "<настройка_1>": "<значение_1>",
                         "<настройка_2>": "<значение_2>",
                         ...
                         "<настройка_N>": "<значение_N>"
                      }
                   }
                }
             }' \
         mdb.api.cloud.yandex.net:443 \
         yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
      ```

      Где:

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.
      * `config_spec.clickhouse.config` — настройки ClickHouse® на уровне сервера. Возможные параметры и их значения в [описании метода](../api-ref/grpc/Cluster/update.md#yandex.cloud.mdb.clickhouse.v1.UpdateClusterRequest).

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

   1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Проверить настройки таблицы MergeTree {#check-current-settings}

   {% list tabs group=instructions %}

   - SQL {#sql}

      1. [Подключитесь](connect/clients.md) к базе данных в кластере.
      1. Чтобы посмотреть все настройки, заданные на уровне таблицы, выполните запрос:

         ```sql
         SHOW CREATE TABLE <название_таблицы>;
         ```

         {% note warning %}

         Выдача `SHOW CREATE TABLE` содержит только переопределенные пользователем настройки. Если заданное пользователем значение настройки совпадает со значением по умолчанию, эта настройка тоже отображается в выдаче.

         {% endnote %}

   {% endlist %}

## Задать настройки таблиц MergeTree с помощью SQL-запросов {#sql-queries}

### Изменить настройки при создании таблицы MergeTree {#set-settings-for-new-table}

   {% list tabs group=instructions %}

   - SQL {#sql}

      1. [Подключитесь](connect/clients.md) к базе данных в кластере.
      1. Создайте таблицу. Чтобы задать ее настройки, перечислите их через запятую в параметре `SETTINGS`:

         ```sql
         CREATE TABLE <название_таблицы>
            (
            <описание_колонок_таблицы>
            )
            ENGINE = MergeTree
            PRIMARY KEY (<столбец_или_группа_столбцов>)
            SETTINGS
            <название_настройки> = <значение_настройки>,
            <название_настройки> = <значение_настройки>;
         ```

         Пример запроса для настроек [merge_with_ttl_timeout](https://clickhouse.com/docs/ru/operations/settings/merge-tree-settings#merge_with_ttl_timeout) и [merge_with_recompression_ttl_timeout](https://clickhouse.com/docs/ru/operations/settings/merge-tree-settings#merge_with_recompression_ttl_timeout):

         ```sql
         CREATE TABLE <имя_таблицы>
            (
            user_id UInt32,
            message String,
            )
            ENGINE = MergeTree
            PRIMARY KEY (user_id)
            SETTINGS merge_with_ttl_timeout = 15000,
            merge_with_recompression_ttl_timeout = 15000;
         ```

      Подробнее о создании таблиц MergeTree в [документации ClickHouse®](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/mergetree#table_engine-mergetree-creating-a-table).

   {% endlist %}

### Изменить настройки существующей таблицы MergeTree {#change-settings-of-existing-table}

   {% list tabs group=instructions %}

   - SQL {#sql}

      1. [Подключитесь](connect/clients.md) к базе данных в кластере.
      1. Чтобы изменить настройки для существующей таблицы, выполните запрос:

         ```sql
         ALTER TABLE <имя_таблицы> MODIFY SETTING <название_настройки> = <новое_значение_настройки>;
         ```
         Вы можете изменить несколько настроек в одном запросе. Для этого перечислите пары `<название_настройки> = <новое_значение_настройки>` через запятую.

   {% endlist %}

### Вернуть настройку таблицы MergeTree к значению по умолчанию {#reset-table-settings}

   {% list tabs group=instructions %}

   - SQL {#sql}

      1. [Подключитесь](connect/clients.md) к базе данных в кластере.
      1. Чтобы вернуть настройку существующей таблицы к значению по умолчанию, выполните запрос:

         ```sql
         ALTER TABLE <имя_таблицы> RESET SETTING <название_настройки>;
         ```
         Вы можете вернуть к значениям по умолчанию несколько настроек в одном запросе. Для этого перечислите названия настроек через запятую.

   {% endlist %}

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._