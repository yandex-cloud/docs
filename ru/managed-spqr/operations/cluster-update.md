---
title: Изменение кластера {{ SPQR }}
description: После создания кластера {{ SPQR }} вы можете изменить его основные и дополнительные настройки.
keywords:
  - keyword: изменение кластера {{ SPQR }}
  - keyword: кластер {{ SPQR }}
  - keyword: '{{ SPQR }}'
---

# Изменение кластера {{ SPQR }}

{% include notitle [preview](../../_includes/note-preview.md) %}

После создания кластера вы можете изменить его основные и дополнительные настройки.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        * Измените имя и описание кластера.
        * Удалите или добавьте новые [метки](../../resource-manager/concepts/labels.md).

    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network }}** выберите группы безопасности для кластера.

    1. Измените конфигурацию вычислительных ресурсов:

        * Для стандартного шардирования измените в блоке **{{ ui-key.yacloud.spqr.section_infra }}** конфигурацию инфраструктурных хостов.
        * Для расширенного шардирования измените в блоке **{{ ui-key.yacloud.spqr.section_router }}** конфигурацию хостов-роутеров. Если используется координатор, в блоке **{{ ui-key.yacloud.spqr.section_coordinator }}** измените конфигурацию хостов-координаторов.

        Чтобы изменить конфигурацию вычислительных ресурсов:

        1. В поле **{{ ui-key.yacloud.mdb.forms.resource_presets_field-generation }}** измените платформу.
        1. Измените **{{ ui-key.yacloud.mdb.forms.resource_presets_field-type }}** виртуальной машины, на которой развернуты хосты.
        1. Измените **{{ ui-key.yacloud.mdb.forms.section_resource }}**.
        1. В блоке **{{ ui-key.yacloud.mdb.forms.section_storage }}** измените тип диска и размер хранилища.

    1. Измените дополнительные настройки кластера:

        {% include [extra-settings](../../_includes/mdb/mspqr/console/extra-settings.md) %}

    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}** нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}** и измените [настройки СУБД уровня кластера](../concepts/settings-list.md).

    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

     
     ```json
     {
       "updateMask": "<список_изменяемых_параметров>",
       "name": "<имя_кластера>",
       "description": "<описание>",
       "environment": "<окружение>",
       "securityGroupIds": [
         "<идентификатор_группы_безопасности_1>",
         "<идентификатор_группы_безопасности_2>",
         ...
         "<идентификатор_группы_безопасности_N>"
       ],
       "deletionProtection": <защитить_кластер_от_удаления>,
       "configSpec": {
         "spqrSpec": {
           "router": {
             "config": {
               "showNoticeMessages": <показывать_информационные_уведомления>,
               "timeQuantiles": [
                 <список_квантилей_времени_для_отображения_статистики>
               ],
               "defaultRouteBehavior": "<разрешать_мультишардовые_запросы>",
               "preferSameAvailabilityZone": <приоритет_маршрутизации_в_зону_доступности_роутера>
             },
             "resources": {
               "resourcePresetId": "<класс_хостов_роутера>",
               "diskSize": "<размер_хранилища_в_байтах>",
               "diskTypeId": "<тип_диска>"
             }
           },
           "coordinator": {
             "resources": {
               "resourcePresetId": "<класс_хостов_координатора>",
               "diskSize": "<размер_хранилища_в_байтах>",
               "diskTypeId": "<тип_диска>"
             }
           },
           "infra": {
             "resources": {
               "resourcePresetId": "класс_хостов_INFRA",
               "diskSize": "<размер_хранилища_в_байтах>",
               "diskTypeId": "<тип_диска>"
             },
             "router": {
               "showNoticeMessages": <показывать_информационные_уведомления>,
               "timeQuantiles": [
                 <список_квантилей_времени_для_отображения_статистики>
               ],
               "defaultRouteBehavior": "<разрешать_мультишардовые_запросы>",
               "preferSameAvailabilityZone": <приоритет_маршрутизации_в_зону_доступности_роутера>
             }
           },
           "consolePassword": "<пароль_консоли_Sharded_PostgreSQL>",
           "logLevel": "<уровень_логирования>"
         },
         "backupWindowStart": {
           "hours": "<часы>",
           "minutes": "<минуты>",
           "seconds": "<секунды>",
           "nanos": "<наносекунды>"
         },
         "backupRetainPeriodDays": "<количество_дней>",
         "maintenanceWindow": {
           "weeklyMaintenanceWindow": {
             "day": "<день_недели>",
             "hour": "<час_дня>"
           }
         }
       }
     }
     ```


     Где:

     * `updateMask` — перечень изменяемых параметров в строку через запятую.

        {% note warning %}

        При изменении кластера все параметры изменяемого объекта, которые не были явно переданы в запросе, будут переопределены на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask`.

        {% endnote %}

     * `name` — имя кластера.

     
     * `securityGroupIds` — идентификаторы [групп безопасности](../../vpc/concepts/security-groups.md).


     * `deletionProtection` — защита кластера от удаления: `true` или `false`.

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-data.md) %}

     * `configSpec` — настройки кластера:

       * `spqrSpec` — настройки сервиса {{ SPQR }}:

         * `router` — при [расширенном шардировании](../concepts/index.md#router) задайте настройки роутера:

           * `config` — конфигурация роутера:

             * `showNoticeMessages` — показывать информационные уведомления: `true` или `false`.
             * `timeQuantiles` — массив строк временных квантилей для отображения статистики. По умолчанию используются значения `"0.5"`, `"0.75"`, `"0.9"`, `"0.95"`, `"0.99"`, `"0.999"`, `"0.9999"`.
             * `defaultRouteBehavior` — политика выполнения мультишардовых запросов роутером. Возможные значения: `BLOCK` — блокировать, `ALLOW` — разрешать.
             * `preferSameAvailabilityZone` — включить приоритет маршрутизации запросов на чтение в зону доступности роутера: `true` или `false`.

           * `resources` — параметры ресурсов хостов `ROUTER`:
             * `resourcePresetId` — [класс хостов](../concepts/instance-types.md);
             * `diskSize` — размер диска в байтах;
             * `diskTypeId` — [тип диска](../concepts/storage.md).

           * `coordinator` – при расширенном шардировании задайте настройки координатора:
             * `resources` — параметры ресурсов:
               * `resourcePresetId` — класс хостов;
               * `diskSize` — размер диска в байтах;
               * `diskTypeId` — тип диска.

           * `infra` – при стандартном шардировании задайте настройки хостов `INFRA`:

             * `resources` — параметры ресурсов:
               * `resourcePresetId` — класс хостов;
               * `diskSize` — размер диска в байтах;
               * `diskTypeId` — тип диска.

             * `router` — конфигурация роутера:

               * `showNoticeMessages` — показывать информационные уведомления: `true` или `false`.
               * `timeQuantiles` — массив строк временных квантилей для отображения статистики. По умолчанию используются значения `"0.5"`, `"0.75"`, `"0.9"`, `"0.95"`, `"0.99"`, `"0.999"`, `"0.9999"`.
               * `defaultRouteBehavior` — политика выполнения мультишардовых запросов роутером. Возможные значения: `BLOCK` — блокировать, `ALLOW` — разрешать.
               * `preferSameAvailabilityZone` — включить приоритет маршрутизации запросов на чтение в зону доступности роутера: `true` или `false`.

           * `consolePassword` — пароль консоли {{ SPQR }}.
           * `logLevel` — уровень логирования запросов: `DEBUG`, `INFO`, `WARNING`, `ERROR`, `FATAL`, `PANIC`.


       * `backupWindowStart` — настройки окна резервного копирования.

         В параметре укажите время, когда начинать резервное копирование. Возможные значения параметров:

         * `hours` — от `0` до `23` часов;
         * `minutes` — от `0` до `59` минут;
         * `seconds` — от `0` до `59` секунд;
         * `nanos` — от `0` до `999999999` наносекунд.

       * `backupRetainPeriodDays` — сколько дней хранить резервную копию кластера. Возможные значения: от `7` до `60` дней.

     * `maintenanceWindow` — настройки расписания окна технического обслуживания:

        * `day` — день недели в формате `DDD`, когда должно проходить обслуживание.
        * `hour` — час дня в формате `HH`, когда должно проходить обслуживание. Допустимые значения: от `1` до `24`.

  1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<идентификатор_кластера>' \
       --data "@body.json"
     ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

     
     ```json
     {
       "update_mask": {
         "paths": [
           <список_изменяемых_параметров>
         ]
       },
       "name": "<имя_кластера>",
       "description": "<описание>",
       "security_group_ids": [
         "<идентификатор_группы_безопасности_1>",
         "<идентификатор_группы_безопасности_2>",
         ...
         "<идентификатор_группы_безопасности_N>"
       ],
       "deletion_protection": <защитить_кластер_от_удаления>,
       "config_spec": {
         "spqr_spec": {
           "router": {
             "config": {
               "show_notice_messages": {
                 "value": <показывать_информационные_уведомления>
               },
               "time_quantiles": [
                 <список_квантилей_времени_для_отображения_статистики>
               ],
               "default_route_behavior": "<разрешать_мультишардовые_запросы>",
               "prefer_same_availability_zone": {
                 "value": <приоритет_маршрутизации_в_зону_доступности_роутера>
               }
             },
             "resources": {
               "resource_preset_id": "<класс_хостов_роутера>",
               "disk_size": "<размер_хранилища_в_байтах>",
               "disk_type_id": "<тип_диска>"
             }
           },
           "coordinator": {
             "resources": {
               "resource_preset_id": "<класс_хостов_координатора>",
               "disk_size": "<размер_хранилища_в_байтах>",
               "disk_type_id": "<тип_диска>"
             }
           },
           "infra": {
             "resources": {
               "resource_preset_id": "класс_хостов_INFRA",
               "disk_size": "<размер_хранилища_в_байтах>",
               "disk_type_id": "<тип_диска>"
             },
             "router": {
               "show_notice_messages": {
                 "value": <показывать_информационные_уведомления>
               },
               "time_quantiles": [
                 <список_квантилей_времени_для_отображения_статистики>
               ],
               "default_route_behavior": "<разрешать_мультишардовые_запросы>",
               "prefer_same_availability_zone": {
                 "value": <приоритет_маршрутизации_в_зону_доступности_роутера>
               }
             }
           },
           "console_password": "<пароль_консоли_Sharded_PostgreSQL>",
           "log_level": "<уровень_логирования>"
         },
         "backup_window_start": {
           "hours": "<часы>",
           "minutes": "<минуты>",
           "seconds": "<секунды>",
           "nanos": "<наносекунды>"
         },
         "backup_retain_period_days": "<количество_дней>"
       },
       "maintenance_window": {
         "weekly_maintenance_window": {
           "day": "<день_недели>",
           "hour": "<час_дня>"
         }
       }
     }
     ```


     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

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

        {% note warning %}

        При изменении кластера все параметры изменяемого объекта, которые не были явно переданы в запросе, будут переопределены на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask`.

        {% endnote %}

     * `name` — имя кластера.

     
     * `security_group_ids` — идентификаторы [групп безопасности](../../vpc/concepts/security-groups.md).


     * `deletion_protection` — защита кластера от удаления: `true` или `false`.

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-data.md) %}

     * `config_spec` — настройки кластера:

       * `spqr_spec` — настройки сервиса {{ SPQR }}:

         * `router` — при [расширенном шардировании](../concepts/index.md#router) задайте настройки роутера:

           * `config` — конфигурация роутера:

             * `show_notice_messages` — показывать информационные уведомления: `true` или `false`.
             * `time_quantiles` — массив временных квантилей для отображения статистики. По умолчанию используются значения `0.5`, `0.75`, `0.9`, `0.95`, `0.99`, `0.999`, `0.9999`.
             * `default_route_behavior` — политика выполнения мультишардовых запросов роутером. Возможные значения: `BLOCK` — блокировать, `ALLOW` — разрешать.
             * `prefer_same_availability_zone` — включить приоритет маршрутизации запросов на чтение в зону доступности роутера: `true` или `false`.

           * `resources` — параметры ресурсов хостов `ROUTER`:
             * `resource_preset_id` — [класс хостов](../concepts/instance-types.md);
             * `disk_size` — размер диска в байтах;
             * `disk_type_id` — [тип диска](../concepts/storage.md).

           * `coordinator` – при расширенном шардировании задайте настройки координатора:
             * `resources` — параметры ресурсов:
               * `resource_preset_id` — класс хостов;
               * `disk_size` — размер диска в байтах;
               * `disk_type_id` — тип диска.

           * `infra` – при стандартном шардировании задайте настройки хостов `INFRA`:

             * `resources` — параметры ресурсов:
               * `resource_preset_id` — класс хостов;
               * `disk_size` — размер диска в байтах;
               * `disk_type_id` — тип диска.

             * `router` — конфигурация роутера:

               * `show_notice_messages` — показывать информационные уведомления: `true` или `false`.
               * `time_quantiles` — массив временных квантилей для отображения статистики. По умолчанию используются значения `0.5`, `0.75`, `0.9`, `0.95`, `0.99`, `0.999`, `0.9999`.
               * `default_route_behavior` — политика выполнения мультишардовых запросов роутером. Возможные значения: `BLOCK` — блокировать, `ALLOW` — разрешать.
               * `prefer_same_availability_zone` — включить приоритет маршрутизации запросов на чтение в зону доступности роутера: `true` или `false`.

           * `console_password` — пароль консоли {{ SPQR }}.
           * `log_level` — уровень логирования запросов: `DEBUG`, `INFO`, `WARNING`, `ERROR`, `FATAL`, `PANIC`.


       * `backup_window_start` — настройки окна резервного копирования.

         В параметре укажите время, когда начинать резервное копирование. Возможные значения параметров:

         * `hours` — от `0` до `23` часов;
         * `minutes` — от `0` до `59` минут;
         * `seconds` — от `0` до `59` секунд;
         * `nanos` — от `0` до `999999999` наносекунд.

       * `backup_retain_period_days` — сколько дней хранить резервную копию кластера. Возможные значения: от `7` до `60` дней.

     * `maintenance_window` — настройки расписания окна технического обслуживания:

       * `day` — день недели в формате `DDD`, когда должно проходить обслуживание.
       * `hour` — час дня в формате `HH`, когда должно проходить обслуживание. Допустимые значения: от `1` до `24`.

  1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d @ \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.ClusterService.Update \
       < body.json
     ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}
