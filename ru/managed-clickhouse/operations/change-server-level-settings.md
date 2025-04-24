# Изменение настроек {{ CH }} на уровне сервера

Вы можете задать [настройки {{ CH }} на уровне сервера](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings), чтобы настроить поведение баз данных или отдельных таблиц в кластере {{ mch-name }}. Указать настройки можно несколькими способами:

  * С помощью [интерфейсов {{ yandex-cloud }}](#yandex-cloud-interfaces). Так можно задать только настройки {{ CH }}, доступные в {{ yandex-cloud }}.
  * С помощью [SQL-запросов](#sql-queries). Так задаются настройки для таблиц MergeTree. Вы можете:

    * задать настройки при [создании таблицы](#set-settings-for-new-table);
    * [задать настройки](#change-settings-of-existing-table) существующей таблицы;
    * [вернуть значения по умолчанию](#reset-table-settings) для настроек существующей таблицы.

## Задать настройки {{ CH }} через интерфейсы {{ yandex-cloud }} {#yandex-cloud-interfaces}

Изменение некоторых [настроек сервера](../concepts/settings-list.md#server-level-settings) приводит к перезапуску серверов {{ CH }} на хостах кластера.

{% note info %}

Значение настройки [Max server memory usage]({{ ch.docs }}/operations/server-configuration-parameters/settings/#max_server_memory_usage) нельзя изменять напрямую. {{ mch-name }} выставляет для нее значение автоматически в зависимости от объема оперативной памяти хостов {{ CH }}. Чтобы изменить значение настройки, [измените класс хостов {{ CH }}](#change-resource-preset). Подробнее см. в разделе [Управление памятью](../concepts/memory-management.md).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы задать настройки {{ CH }}:

   1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
   1. В блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}** нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}**.
   1. Задайте [настройки {{ CH }}](../concepts/settings-list.md#server-level-settings).
   1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Чтобы задать настройки {{ CH }}:

   1. Посмотрите полный список настроек, установленных для кластера:

      ```bash
      {{ yc-mdb-ch }} cluster get <имя_или_идентификатор_кластера> --full
      ```

   1. Посмотрите описание команды CLI для изменения конфигурации кластера:

      ```bash
      {{ yc-mdb-ch }} cluster update-config --help
      ```

   1. Установите нужные значения параметров:

      ```bash
      {{ yc-mdb-ch }} cluster update-config <имя_или_идентификатор_кластера> \
         --set <имя_параметра_1>=<значение_1>,...
      ```

- {{ TF }} {#tf}

   Чтобы задать настройки {{ CH }}:

   1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

   1. В описании кластера {{ mch-name }}, в блоке `clickhouse.config`, измените значения параметров:

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
        ...
        clickhouse {
          ...

          config {
            # Общие настройки СУБД
            ...

            merge_tree {
              # Настройки движка MergeTree
              ...
            }

            kafka {
              # Общие настройки получения данных из Apache Kafka
              ...
            }

            kafka_topic {
              # Настройки отдельного топика Apache Kafka
              ...
            }

            rabbit_mq {
              # Настройки получения данных из {{ RMQ }}
              username = "<имя_пользователя>"
              password = "<пароль>"
            }

            compression {
              # Настройки сжатия данных
              method              = "<метод_сжатия>"
              min_part_size       = <размер_куска_данных>
              min_part_size_ratio = <отношение_размеров>
            }

            graphite_rollup {
              # Настройки движка GraphiteMergeTree для прореживания, агрегирования и усреднения (rollup) данных Graphite.
              ...
            }
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

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

   1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

   1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

      {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

      ```bash
      curl \
         --request PATCH \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --header "Content-Type: application/json" \
         --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>' \
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
      * `configSpec.clickhouse.config` — настройки {{ CH }} на уровне сервера. Возможные параметры и их значения см. в [описании метода](../api-ref/Cluster/update.md#yandex.cloud.mdb.clickhouse.v1.UpdateClusterRequest).

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

   1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

   1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

   1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
   1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

      {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

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
         {{ api-host-mdb }}:{{ port-https }} \
         yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
      ```

      Где:

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.
      * `config_spec.clickhouse.config` — настройки {{ CH }} на уровне сервера. Возможные параметры и их значения см. в [описании метода](../api-ref/grpc/Cluster/update.md#yandex.cloud.mdb.clickhouse.v1.UpdateClusterRequest).

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

         Пример запроса для настроек [merge_with_ttl_timeout](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#merge_with_ttl_timeout) и [merge_with_recompression_ttl_timeout](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#merge_with_recompression_ttl_timeout):

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

      Подробнее о создании таблиц MergeTree см. в [документации {{ CH }}](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree#table_engine-mergetree-creating-a-table).

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

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
