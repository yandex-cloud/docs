---
title: Инструкция по изменению настроек кластера {{ PG }} в {{ mpg-full-name }}
description: Из статьи вы узнаете, как изменить настройки кластера {{ PG }}.
---

# Изменение настроек кластера {{ PG }}

После создания кластера вы можете:

* [Изменить класс хостов](#change-resource-preset).

* [Настроить серверы](#change-postgresql-config) согласно [документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config.html).

* [Изменить дополнительные настройки кластера](#change-additional-settings).

* [Вручную переключить хост-мастер](#start-manual-failover).

* [Переместить кластер](#move-cluster) в другой каталог.


* [Изменить группы безопасности кластера](#change-sg-set).


Подробнее о других изменениях кластера:

* [Обновление версии {{ PG }}](cluster-version-update.md).

* [Управление дисковым пространством](storage-space.md).

* [Миграция хостов кластера в другую зону доступности](host-migration.md).

## Изменить класс хостов {#change-resource-preset}

{% note info %}

Некоторые настройки {{ PG }} [зависят от выбранного класса хостов](../concepts/settings-list.md#settings-instance-dependent).

{% endnote %}

При смене класса хостов:

* Кластер из одного хоста будет недоступен несколько минут, соединения с БД будут прерваны.
* В кластере из нескольких хостов сменится мастер. Каждый хост по очереди будет остановлен и обновлен, остановленный хост будет недоступен несколько минут.
* Подключение по [особому FQDN](./connect.md#special-fqdns) не гарантирует стабильность соединения с БД: пользовательские сессии могут быть прерваны.

Рекомендуется изменять класс хостов только во время отсутствия рабочей нагрузки на кластер.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Выберите кластер и нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_resource }}** выберите нужный класс для хостов {{ PG }}.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить [класс хостов](../concepts/instance-types.md) для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```bash
      {{ yc-mdb-pg }} cluster update --help
      ```

  1. Запросите список доступных классов хостов (в колонке `ZONE IDS` указаны зоны доступности, в которых можно выбрать соответствующий класс):


     ```bash
     {{ yc-mdb-pg }} resource-preset list
     ```

     ```text
     +-----------+--------------------------------+-------+----------+
     |    ID     |            ZONE IDS            | CORES |  MEMORY  |
     +-----------+--------------------------------+-------+----------+
     | s1.micro  | {{ region-id }}-a, {{ region-id }}-b,  |     2 | 8.0 GB   |
     |           | {{ region-id }}-d                  |       |          |
     | ...                                                           |
     +-----------+--------------------------------+-------+----------+
     ```


  1. Укажите нужный класс в команде изменения кластера:

      ```bash
      {{ yc-mdb-pg }} cluster update <имя_или_идентификатор_кластера> \
          --resource-preset <идентификатор_класса_хостов>
      ```

      {{ mpg-short-name }} запустит операцию изменения класса хостов для кластера.

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

      Полный список доступных для изменения полей конфигурации кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).

  1. Измените в описании кластера {{ mpg-name }} значение атрибута `resource_preset_id` в блоке `config.resources`:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
        ...
        config {
          resources {
            resource_preset_id = "<класс_хоста>"
            ...
          }
        }
      }
      ```

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

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
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>' \
       --data '{
                 "updateMask": "configSpec.resources.resourcePresetId",
                 "configSpec": {
                   "resources": {
                     "resourcePresetId": "<класс_хостов>"
                   }
                 }
               }'
     ```

     Где:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

       В данном случае передается только один параметр.

     * `configSpec.resources.resourcePresetId` — новый [класс хостов](../concepts/instance-types.md).

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
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "update_mask": {
               "paths": [
                 "config_spec.resources.resource_preset_id"
               ]
             },
             "config_spec": {
               "resources": {
                 "resource_preset_id": "<класс_хостов>"
               }
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Update
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

       В данном случае передается только один параметр.

     * `config_spec.resources.resource_preset_id` — новый [класс хостов](../concepts/instance-types.md).

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.Cluster).

{% endlist %}

## Изменить настройки {{ PG }} {#change-postgresql-config}

Вы можете изменить настройки СУБД для хостов вашего кластера.

{% note warning %}

* Вы не можете менять настройки {{ PG }} с помощью команд SQL.
* Некоторые настройки {{ PG }} [зависят от выбранного класса хостов или размера хранилища](../concepts/settings-list.md#settings-instance-dependent).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Выберите кластер и нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
  1. Измените [настройки {{ PG }}](../concepts/settings-list.md), нажав кнопку **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}** в блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.component.mdb.settings.popup_settings-submit }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить [настройки {{ PG }}](../concepts/settings-list.md):

  1. Посмотрите полный список настроек, установленных для кластера:

     ```bash
     {{ yc-mdb-pg }} cluster get <имя_или_идентификатор_кластера> --full
     ```

  1. Посмотрите описание команды CLI для изменения конфигурации кластера:

      ```bash
      {{ yc-mdb-pg }} cluster update-config --help
      ```

  1. Установите нужные значения параметров:

      Все поддерживаемые параметры перечислены в [формате запроса для метода update](../api-ref/Cluster/update.md), в поле `postgresqlConfig_<версия_{{ PG }}>`. Чтобы указать имя параметра в вызове CLI, преобразуйте его имя из вида <q>lowerCamelCase</q> в <q>snake_case</q>, например, параметр `maxPreparedTransactions` из запроса к API преобразуется в `max_prepared_transactions` для команды CLI:

      ```bash
      {{ yc-mdb-pg }} cluster update-config <имя_или_идентификатор_кластера> \
         --set <имя_параметра_1>=<значение_1>,<имя_параметра_2>=<значение_2>,...
      ```

      {{ mpg-short-name }} запустит операцию по изменению настроек кластера.

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).

    1. Измените в описании кластера {{ mpg-short-name }} значения параметров в блоке `config.postgresql_config`. Если такого блока нет — создайте его.

        ```hcl
        resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
          ...
          config {
            ...
            postgresql_config = {
              max_connections                   = <максимальное_количество_соединений>
              enable_parallel_hash              = <true_или_false>
              vacuum_cleanup_index_scale_factor = <число_от_0_до_1>
              ...
            }
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

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
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>' \
       --data '{
                 "updateMask": "configSpec.postgresqlConfig_<версия_{{ PG }}>.<настройка_1>,...,configSpec.postgresqlConfig_<версия_{{ PG }}>.<настройка_N>",
                 "configSpec": {
                   "postgresqlConfig_<версия_{{ PG }}>": {
                     "<настройка_1>": "<значение_1>",
                     "<настройка_2>": "<значение_2>",
                     ...
                     "<настройка_N>": "<значение_N>"
                   }
                 }
               }'
     ```

     Где:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

       В данном случае перечислите все изменяемые настройки {{ PG }}.

     * `configSpec.postgresqlConfig_<версия_{{ PG }}>` — набор настроек {{ PG }}. Укажите каждую настройку на отдельной строке через запятую.

       Список версий {{ PG }}, доступных для параметра, см. в [описании метода](../api-ref/Cluster/update.md#yandex.cloud.mdb.postgresql.v1.UpdateClusterRequest). Описание и возможные значения настроек см. в разделе [{#T}](../concepts/settings-list.md#dbms-cluster-settings).

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
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "update_mask": {
               "paths": [
                 "config_spec.postgresql_config_<версия_{{ PG }}>.<настройка_1>",
                 "config_spec.postgresql_config_<версия_{{ PG }}>.<настройка_2>",
                 ...,
                 "config_spec.postgresql_config_<версия_{{ PG }}>.<настройка_N>"
               ]
             },
             "config_spec": {
               "postgresql_config_<версия_{{ PG }}>": {
                 "<настройка_1>": "<значение_1>",
                 "<настройка_2>": "<значение_2>",
                 ...
                 "<настройка_N>": "<значение_N>"
               }
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Update
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

       В данном случае перечислите все изменяемые настройки {{ PG }}.

     * `config_spec.postgresql_config_<версия_{{ PG }}>` — набор настроек {{ PG }}. Укажите каждую настройку на отдельной строке через запятую.

       Список версий {{ PG }}, доступных для параметра, см. в [описании метода](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.ConfigSpec). Описание и возможные значения настроек см. в разделе [{#T}](../concepts/settings-list.md#dbms-cluster-settings).

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.Cluster).

{% endlist %}

## Изменить дополнительные настройки кластера {#change-additional-settings}

{% note warning %}

Изменение дополнительных настроек приведет к перезапуску кластера. Исключением являются настройки окна обслуживания и защиты от удаления.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Выберите кластер и нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
  1. Измените дополнительные настройки кластера:

     {% include [mpg-extra-settings](../../_includes/mdb/mpg/extra-settings-web-console.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить дополнительные настройки кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-pg }} cluster update --help
        ```

    1. Выполните команду, передав список настроек, которые хотите изменить:


        ```bash
        {{ yc-mdb-pg }} cluster update <имя_или_идентификатор_кластера> \
            --backup-window-start <время_начала_резервного_копирования> \
            --backup-retain-period-days=<срок_хранения_автоматических_резервных_копий_в_днях> \
            --datalens-access=<true_или_false> \
            --maintenance-window type=<тип_технического_обслуживания>,`
                                `day=<день_недели>,`
                                `hour=<час_дня> \
            --websql-access=<true_или_false> \
            --deletion-protection \
            --connection-pooling-mode=<режим_работы_менеджера_подключений> \
            --serverless-access=<true_или_false> \
            --yandexquery-access=<доступ_через_{{ yq-name }}> \
            --performance-diagnostics enabled=<true_или_false>,`
                                     `sessions-sampling-interval=<интервал_сбора_сессий>,`
                                     `statements-sampling-interval=<интервал_сбора_запросов>
        ```



    Вы можете изменить следующие настройки:

    {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}

    * `--backup-retain-period-days` – срок хранения автоматических резервных копий (в днях).

    * `--datalens-access` — разрешает доступ из DataLens. Значение по умолчанию — `false`. Подробнее о настройке подключения см. в разделе [Подключение к кластеру из {{ datalens-name }}](datalens-connect.md).

    * `--maintenance-window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), где `type` — тип технического обслуживания:

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

    * `--websql-access` — разрешает [выполнять SQL-запросы](web-sql-query.md) к базам данных кластера из консоли управления {{ yandex-cloud }} с помощью сервиса {{ websql-full-name }}. Значение по умолчанию — `false`.
    

    * `--serverless-access` — разрешает доступ к кластеру из сервиса [{{ sf-full-name }}](../../functions/concepts/index.md). Значение по умолчанию — `false`. Подробнее о настройке доступа см. в документации [{{ sf-name }}](../../functions/operations/database-connection.md).

    * `--yandexquery-access` — разрешает доступ к кластеру из сервиса [{{ yq-full-name }}](../../query/concepts/index.md). Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md) и предоставляется по запросу.


    * `--autofailover` – управляет настройкой автоматической смены мастера. Подробнее см. в разделе [Репликация](../concepts/replication.md#replication-auto). Значение по умолчанию — `true`.

    * `--connection-pooling-mode` — указывает [режим работы менеджера подключений](../concepts/pooling.md): `SESSION`, `TRANSACTION` или `STATEMENT`.

    * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

        По умолчанию при создании пользователей и БД значение параметра наследуется от кластера. Значение также можно задать вручную, подробнее см. в разделах [Управление пользователями](cluster-users.md) и [Управление БД](databases.md).

        Если параметр изменен на работающем кластере, новое значение унаследуют только пользователи и БД с защитой **Как у кластера**.

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-db.md) %}


    * `--performance-diagnostics` — настройки [сбора статистики](./performance-diagnostics.md#activate-stats-collector):

        * `enabled` — значение `true` активирует сбор статистики. Значение по умолчанию — `false`.
        * `sessions-sampling-interval` — интервал сбора сессий, в секундах. Допустимые значения — от `1` до `86400`.
        * `statements-sampling-interval` — интервал сбора запросов, в секундах. Допустимые значения — от `60` до `86400`.


    Имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

      Полный список доступных для изменения полей конфигурации кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).

  1. Чтобы изменить время начала резервного копирования, добавьте к описанию кластера {{ mpg-name }} блок `config.backup_window_start`.

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
        ...
        config {
          backup_window_start {
            hours   = <час_начала_резервного_копирования>
            minutes = <минута_начала_резервного_копирования>
          }
          ...
        }
      }
      ```

  1. Чтобы разрешить доступ из {{ datalens-full-name }} и [выполнение SQL-запросов из консоли управления](web-sql-query.md) с помощью {{ websql-full-name }}, измените значения соответствующих полей в блоке `config.access`:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
        ...
        config {
          access {
            data_lens = <доступ_из_{{ datalens-name }}>
            web_sql   = <выполнение_SQL-запросов_из_консоли_управления>
            ...
        }
        ...
      }
      ```

      Где:

      * `data_lens` — доступ из {{ datalens-name }}: `true` или `false`.
      * `web_sql` — выполнение SQL-запросов из консоли управления с помощью {{ websql-full-name }}: `true` или `false`.

  1. Чтобы изменить [режим работы менеджера подключений](../concepts/pooling.md), добавьте к описанию кластера {{ mpg-name }} блок `config.pooler_config`:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
        ...
        config {
          pooler_config {
            pool_discard = <параметр_Odyssey>
            pooling_mode = "<режим_работы>"
          }
          ...
        }
      }
      ```

      Где:

      * `pool_discard`  — параметр Odyssey `pool_discard`: `true` или `false`.
      * `pooling_mode` — режим работы: `SESSION`, `TRANSACTION` или `STATEMENT`.

  1. {% include [Maintenance window](../../_includes/mdb/mpg/terraform/maintenance-window.md) %}


  1. {% include [Performance diagnostics](../../_includes/mdb/mpg/terraform/performance-diagnostics.md) %}


  1. Чтобы включить защиту кластера, его баз данных и пользователей от непреднамеренного удаления, добавьте к описанию кластера поле `deletion_protection` со значением `true`:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
        ...
        deletion_protection = <защита_от_удаления>
      }
      ```

      Где `deletion_protection` — защита от удаления кластера, его баз данных и пользователей: `true` или `false`.

      По умолчанию при создании пользователей и БД значение параметра наследуется от кластера. Значение также можно задать вручную, подробнее см. в разделах [Управление пользователями](cluster-users.md) и [Управление БД](databases.md).

      Если параметр изменен на работающем кластере, новое значение унаследуют только пользователи и БД с защитой **Как у кластера**.

      {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}


     ```json
     {
       "updateMask": "configSpec.poolerConfig,configSpec.backupWindowStart,configSpec.backupRetainPeriodDays,configSpec.access,configSpec.performanceDiagnostics.sessionsSamplingInterval,configSpec.performanceDiagnostics.statementsSamplingInterval,maintenanceWindow,deletionProtection",
       "configSpec": {
         "poolerConfig": {
           "poolingMode": "<режим_управления_соединениями>",
           "poolDiscard": <сброс_состояния_клиентов_после_каждой_транзакции:_true_или_false>
         },
         "backupWindowStart": {
           "hours": "<часы>",
           "minutes": "<минуты>",
           "seconds": "<секунды>",
           "nanos": "<наносекунды>"
         },
         "backupRetainPeriodDays": "<количество_дней>",
         "access": {
           "dataLens": <доступ_к_{{ datalens-name }}:_true_или_false>,
           "webSql": <доступ_к_{{ websql-name }}:_true_или_false>,
           "serverless": <доступ_к_Cloud_Functions:_true_или_false>,
           "dataTransfer": <доступ_к_Data_Transfer:_true_или_false>,
           "yandexQuery": <доступ_к_{{ yq-name }}:_true_или_false>
         },
         "performanceDiagnostics": {
           "enabled": <активация_сбора_статистики:_true_или_false>,
           "sessionsSamplingInterval": "<интервал_сбора_сессий>",
           "statementsSamplingInterval": "<интервал_сбора_запросов>"
         }
       },
       "maintenanceWindow": {
         "weeklyMaintenanceWindow": {
           "day": "<день_недели>",
           "hour": "<час>"
         }
       },
       "deletionProtection": <защита_от_удаления:_true_или_false>
     }
     ```


     Где:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.
     * `configSpec` — настройки кластера:

       * `poolerConfig` — настройки менеджера подключений:

         * `poolingMode` — режим работы менеджера подключений. Возможные значения: `SESSION`, `TRANSACTION` и `STATEMENT`. Подробнее о каждом режиме читайте в разделе [{#T}](../concepts/pooling.md).
         * `poolDiscard` — должны ли клиенты терять свое состояние после каждой транзакции. Соответствует параметру [server_reset_query_always](https://www.pgbouncer.org/config.html) для менеджера подключений [PgBouncer](https://www.pgbouncer.org/usage).

       * `backupWindowStart` — настройки окна [резервного копирования](../concepts/backup.md).

         В параметре укажите время, когда начинать резервное копирование. Возможные значения параметров:

         * `hours` — от `0` до `23` часов;
         * `minutes` — от `0` до `59` минут;
         * `seconds` — от `0` до `59` секунд;
         * `nanos` — от `0` до `999999999` наносекунд.

       * `backupRetainPeriodDays` — сколько дней хранить резервную копию кластера. Возможные значения: от `7` до `60` дней.


       * `access` — настройки доступа кластера к следующим сервисам {{ yandex-cloud }}:

         * `dataLens` — [{{ datalens-full-name }}](../../datalens/index.yaml);
         * `webSql` — [{{ websql-full-name }}](../../websql/index.yaml);
         * `serverless` — [{{ sf-full-name }}](../../functions/index.yaml);
         * `dataTransfer` — [{{ data-transfer-full-name }}](../../data-transfer/index.yaml);
         * `yandexQuery` — [{{ yq-full-name }}](../../query/index.yaml).



       * `performanceDiagnostics` — настройки для [сбора статистики](performance-diagnostics.md#activate-stats-collector):

         * `enabled` — активация сбора статистики.
         * `sessionsSamplingInterval` — интервал сбора сессий. Возможные значения: от `1` до `86400` секунд.
         * `statementsSamplingInterval` — интервал сбора запросов. Возможные значения: от `60` до `86400` секунд.


     * `maintenanceWindow` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). В `maintenanceWindow` передайте один из двух параметров:

       * `anytime` — техническое обслуживание происходит в любое время.
       * `weeklyMaintenanceWindow` — техническое обслуживание происходит раз в неделю, в указанное время:

         * `day` — день недели в формате `DDD`;
         * `hour` — час в формате `HH`. Возможные значения: от `1` до `24` часов.

     * `deletionProtection` — защита от удаления кластера, его баз данных и пользователей.

       По умолчанию при создании пользователей и БД значение параметра наследуется от кластера. Значение также можно задать вручную, подробнее см. в разделах [Управление пользователями](cluster-users.md) и [Управление БД](databases.md).

        Если параметр изменен на работающем кластере, новое значение унаследуют только пользователи и БД с защитой **Как у кластера**.

        {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>' \
       --data "@body.json"
     ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}


     ```json
     {
       "cluster_id": "<идентификатор_кластера>",
       "update_mask": {
         "paths": [
           "config_spec.pooler_config",
           "config_spec.backup_window_start",
           "config_spec.backup_retain_period_days",
           "config_spec.access",
           "config_spec.performance_diagnostics.sessions_sampling_interval",
           "config_spec.performance_diagnostics.statements_sampling_interval",
           "maintenance_window",
           "deletion_protection"
         ]
       },
       "config_spec": {
         "pooler_config": {
           "pooling_mode": "<режим_управления_соединениями>",
           "pool_discard": <сброс_состояния_клиентов_после_каждой_транзакции:_true_или_false>
         },
         "backup_window_start": {
           "hours": "<часы>",
           "minutes": "<минуты>",
           "seconds": "<секунды>",
           "nanos": "<наносекунды>"
         },
         "backup_retain_period_days": "<количество_дней>",
         "access": {
           "data_lens": <доступ_к_{{ datalens-name }}:_true_или_false>,
           "web_sql": <доступ_к_{{ websql-name }}:_true_или_false>,
           "serverless": <доступ_к_Cloud_Functions:_true_или_false>,
           "data_transfer": <доступ_к_Data_Transfer:_true_или_false>,
           "yandex_query": <доступ_к_{{ yq-name }}:_true_или_false>
         },
         "performance_diagnostics": {
           "enabled": <активация_сбора_статистики:_true_или_false>,
           "sessions_sampling_interval": "<интервал_сбора_сессий>",
           "statements_sampling_interval": "<интервал_сбора_запросов>"
         }
       },
       "maintenance_window": {
         "weekly_maintenance_window": {
           "day": "<день_недели>",
           "hour": "<час>"
         }
       },
       "deletion_protection": <защита_от_удаления:_true_или_false>
     }
     ```


     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.
     * `config_spec` — настройки кластера:

       * `pooler_config` — настройки менеджера подключений:

         * `pooling_mode` — режим работы менеджера подключений. Возможные значения: `SESSION`, `TRANSACTION` и `STATEMENT`. Подробнее о каждом режиме читайте в разделе [{#T}](../concepts/pooling.md).
         * `pool_discard` — должны ли клиенты терять свое состояние после каждой транзакции. Соответствует параметру [server_reset_query_always](https://www.pgbouncer.org/config.html) для менеджера подключений [PgBouncer](https://www.pgbouncer.org/usage).

       * `backup_window_start` — настройки окна [резервного копирования](../concepts/backup.md).

         В параметре укажите время, когда начинать резервное копирование. Возможные значения параметров:

         * `hours` — от `0` до `23` часов;
         * `minutes` — от `0` до `59` минут;
         * `seconds` — от `0` до `59` секунд;
         * `nanos` — от `0` до `999999999` наносекунд.

       * `backup_retain_period_days` — сколько дней хранить резервную копию кластера. Возможные значения: от `7` до `60` дней.


       * `access` — настройки доступа кластера к следующим сервисам {{ yandex-cloud }}:

         * `data_lens` — [{{ datalens-full-name }}](../../datalens/index.yaml);
         * `web_sql` — [{{ websql-full-name }}](../../websql/index.yaml);
         * `serverless` — [{{ sf-full-name }}](../../functions/index.yaml);
         * `data_transfer` — [{{ data-transfer-full-name }}](../../data-transfer/index.yaml);
         * `yandex_query` — [{{ yq-full-name }}](../../query/index.yaml).



       * `performance_diagnostics` — настройки для [сбора статистики](performance-diagnostics.md#activate-stats-collector):

         * `enabled` — активация сбора статистики.
         * `sessions_sampling_interval` — интервал сбора сессий. Возможные значения: от `1` до `86400` секунд.
         * `statements_sampling_interval` — интервал сбора запросов. Возможные значения: от `60` до `86400` секунд.


     * `maintenance_window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). В `maintenance_window` передайте один из двух параметров:

       * `anytime` — техническое обслуживание происходит в любое время.
       * `weekly_maintenance_window` — техническое обслуживание происходит раз в неделю, в указанное время:

         * `day` — день недели в формате `DDD`;
         * `hour` — час в формате `HH`. Возможные значения: от `1` до `24` часов.

     * `deletion_protection` — защита от удаления кластера, его баз данных и пользователей.

       По умолчанию при создании пользователей и БД значение параметра наследуется от кластера. Значение также можно задать вручную, подробнее см. в разделах [Управление пользователями](cluster-users.md) и [Управление БД](databases.md).

        Если параметр изменен на работающем кластере, новое значение унаследуют только пользователи и БД с защитой **Как у кластера**.

        {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d @ \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Update \
       < body.json
     ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.Cluster).

{% endlist %}

## Вручную переключить хост-мастер {#start-manual-failover}

В отказоустойчивом кластере {{ mpg-name }} из нескольких хостов вы можете переключить роль мастера с текущего хоста-мастера на одну из реплик. После этой операции текущий хост-мастер станет хостом-репликой для нового мастера.

Особенности переключения мастера в {{ mpg-name }}:

* Нельзя сделать мастером реплику, для которой явно указан источник потока репликации.
* Если явно не указать имя хоста-реплики, мастер переключится на одну из кворумных реплик.

Подробнее см. в разделе [Репликация](../concepts/replication.md).

Чтобы переключить мастер:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![icon-hosts.svg](../../_assets/console-icons/cube.svg) **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}**.
  1. Нажмите кнопку ![icon-autofailover.svg](../../_assets/console-icons/shuffle.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.button_manual-failover }}**.
      * Чтобы переключить мастер на одну из кворумных реплик, оставьте опцию **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-switch-master_auto }}** включенной.
      * Чтобы переключить мастер на конкретную реплику, выключите опцию **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-switch-master_auto }}** и затем выберите нужную реплику из выпадающего списка.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-switch-master_button }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Выполните команду:

  ```bash
  {{ yc-mdb-pg }} cluster start-failover <имя_или_идентификатор_кластера> \
      --host <имя_хоста-реплики>
  ```

  Имя хоста-реплики можно запросить со [списком хостов в кластере](hosts.md#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).

    1. Укажите имя хоста-реплики, на которую нужно переключиться, в параметре `host_master_name`.

        ```hcl
        resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
          ...
          host_master_name = "<имя_хоста-реплики>"
        }
        ```

        Где `host_master_name` — имя хоста-реплики: атрибут `name` соответствующего блока `host`.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.StartFailover](../api-ref/Cluster/startFailover.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>:startFailover' \
       --data '{
                 "hostName": "<FQDN_хоста>"
               }'
     ```

     Где `hostName` — [FQDN реплики](connect.md#fqdn), которая становится мастером.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/startFailover.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService.StartFailover](../api-ref/grpc/Cluster/startFailover.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "host_name": "<FQDN_хоста>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.StartFailover
     ```

     Где `host_name` — [FQDN реплики](connect.md#fqdn), которая становится мастером.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.Cluster).

{% endlist %}

## Переместить кластер {#move-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) справа в строке кластера, который вы хотите переместить.
    1. Выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-move }}**.
    1. Выберите каталог, в который вы хотите переместить кластер.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup_button_move-cluster }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы переместить кластер:

    1. Посмотрите описание команды CLI для перемещения кластера:

        ```bash
        {{ yc-mdb-pg }} cluster move --help
        ```

    1. Укажите каталог назначения в команде перемещения кластера:

        ```bash
        {{ yc-mdb-pg }} cluster move <идентификатор_кластера> \
           --destination-folder-name=<имя_каталога_назначения>
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.Move](../api-ref/Cluster/move.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>:move' \
       --data '{
                 "destinationFolderId": "<идентификатор_каталога>"
               }'
     ```

     Где `destinationFolderId` — идентификатор каталога, куда перемещается кластер. Идентификатор можно получить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/move.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService.Move](../api-ref/grpc/Cluster/move.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "destination_folder_id": "<идентификатор_каталога>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Move
     ```

     Где `destination_folder_id` — идентификатор каталога, куда перемещается кластер. Идентификатор можно получить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}

После перемещения кластер продолжит использовать облачную сеть из исходного каталога. Если вы хотите разместить кластер в другой облачной сети, воспользуйтесь функцией [восстановления из резервной копии](./cluster-backups.md) и укажите необходимую сеть для копии кластера.

Если вы хотите переместить кластер в другую зону доступности, обратитесь к [инструкции](host-migration.md). В результате вы перенесете хосты кластера.


## Изменить группы безопасности {#change-sg-set}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Выберите кластер и нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network }}** выберите группы безопасности для сетевого трафика кластера.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить список [групп безопасности](../concepts/network.md#security-groups) для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```bash
      {{ yc-mdb-pg }} cluster update --help
      ```

  1. Укажите нужные группы безопасности в команде изменения кластера:

      ```bash
      {{ yc-mdb-pg }} cluster update <имя_или_идентификатор_кластера> \
          --security-group-ids <список_идентификаторов_групп_безопасности>
      ```

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

      Полный список доступных для изменения полей конфигурации кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).

  1. Измените значение параметра `security_group_ids` в описании кластера:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
        ...
        security_group_ids = [ <список_идентификаторов_групп_безопасности> ]
      }
      ```

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

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
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>' \
       --data '{
                 "updateMask": "securityGroupIds",
                 "securityGroupIds": [
                   "<идентификатор_группы_безопасности_1>",
                   "<идентификатор_группы_безопасности_2>",
                   ...
                   "<идентификатор_группы_безопасности_N>"
                 ]
               }'
     ```

     Где:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

       В данном случае передается только один параметр.

     * `securityGroupIds` — новый список [групп безопасности](../concepts/network.md#security-groups), представленный в виде элементов массива.

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
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "update_mask": {
               "paths": [
                 "security_group_ids"
               ]
             },
             "security_group_ids": [
               "<идентификатор_группы_безопасности_1>",
               "<идентификатор_группы_безопасности_2>",
               ...
               "<идентификатор_группы_безопасности_N>"
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Update
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

       В данном случае передается только один параметр.

     * `security_group_ids` — новый список [групп безопасности](../concepts/network.md#security-groups), представленный в виде элементов массива.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.Cluster).

{% endlist %}

{% note warning %}

Может потребоваться дополнительная [настройка групп безопасности](connect.md#configuring-security-groups) для подключения к кластеру.

{% endnote %}

