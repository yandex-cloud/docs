---
title: Создание кластера {{ SPQR }}
description: Следуя данной инструкции, вы сможете создать кластер {{ SPQR }} со стандартным или расширенным шардированием.
keywords:
  - keyword: создание кластера {{ SPQR }}
  - keyword: кластер {{ SPQR }}
  - keyword: '{{ SPQR }}'
---

# Создание кластера {{ SPQR }}

{% include notitle [preview](../../_includes/note-preview.md) %}

## Создать кластер {#create-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер {{ SPQR }}.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        1. Задайте имя кластера. Имя должно быть уникальным в рамках каталога.
        1. (Опционально) Введите описание кластера.
        1. (Опционально) Создайте [метки](../../resource-manager/concepts/labels.md):

            1. Нажмите кнопку **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Введите метку в формате `ключ: значение`.
            1. Нажмите **Enter**.

        1. Выберите окружение, в котором нужно создать кластер (после создания кластера окружение изменить невозможно):

            * `PRODUCTION` — для стабильных версий ваших приложений.
            * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению, и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.

        1. Выберите тип шардирования:

            * `{{ ui-key.yacloud.spqr.section_sharding-type-standard }}` — кластер будет состоять только из инфраструктурных хостов.
            * `{{ ui-key.yacloud.spqr.section_sharding-type-advanced }}` — кластер будет состоять только из хостов-роутеров и (опционально) хостов-координаторов.

    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network }}** выберите [сеть](../../vpc/operations/network-create.md) и [группы безопасности](../../vpc/concepts/security-groups.md) для кластера.

    1. Задайте конфигурацию вычислительных ресурсов:

        * Для стандартного шардирования задайте в блоке **{{ ui-key.yacloud.spqr.section_infra }}** конфигурацию инфраструктурных хостов.
        * Для расширенного шардирования задайте в блоке **{{ ui-key.yacloud.spqr.section_router }}** конфигурацию хостов-роутеров.

            (Опционально) В блоке **{{ ui-key.yacloud.spqr.section_coordinator }}** включите опцию **{{ ui-key.yacloud.spqr.field_coordinator }}** и задайте конфигурацию хостов-координаторов.

        Чтобы задать конфигурацию вычислительных ресурсов:

        1. В поле **{{ ui-key.yacloud.mdb.forms.resource_presets_field-generation }}** выберите платформу.
        1. Укажите **{{ ui-key.yacloud.mdb.forms.resource_presets_field-type }}** виртуальной машины, на которой будут развернуты хосты.
        1. Выберите **{{ ui-key.yacloud.mdb.forms.section_resource }}**.
        1. В блоке **{{ ui-key.yacloud.mdb.forms.section_storage }}** выберите тип диска и укажите размер [хранилища](../concepts/storage.md).
        1. В блоке **{{ ui-key.yacloud.spqr.section_hosts }}**:

            1. Нажмите кнопку **{{ ui-key.yacloud.mdb.hosts.dialog.label_title }}**, чтобы добавить нужное количество хостов, создаваемых вместе с кластером {{ SPQR }}.
            
            
            1. Нажмите на значок ![image](../../_assets/console-icons/pencil.svg) и укажите для каждого хоста:
                * [Зону доступности](../../overview/concepts/geo-scope.md).
                * [Подсеть](../../vpc/concepts/network.md#subnet) — по умолчанию каждый хост создается в отдельной подсети.
                * Опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**, если хост должен быть доступен извне {{ yandex-cloud }}.


            После создания кластера {{ SPQR }} в него можно добавить дополнительные хосты, если для этого достаточно [ресурсов каталога](../concepts/limits.md).

    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_database }}** укажите параметры БД:

        * Имя БД. Допустимая длина — от 1 до 63 символов. Может содержать строчные и прописные буквы латинского алфавита, цифры, нижние подчеркивания и дефисы.

        * Имя пользователя. Допустимая длина — от 1 до 63 символов. Может содержать строчные и прописные буквы латинского алфавита, цифры, нижние подчеркивания и дефисы, но не может начинаться с дефиса.

        * Пароль пользователя. Допустимая длина — от 8 до 128 символов.

    1. При необходимости задайте дополнительные настройки кластера:

        {% include [extra-settings](../../_includes/mdb/mspqr/console/extra-settings.md) %}

    1. Чтобы задать [настройки СУБД уровня кластера](../concepts/settings-list.md), в блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}** нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}**.

    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

     
     ```json
     {
       "folderId": "<идентификатор_каталога>",
       "name": "<имя_кластера>",
       "description": "<описание>",
       "environment": "<окружение>",
       "securityGroupIds": [
         "<идентификатор_группы_безопасности_1>",
         "<идентификатор_группы_безопасности_2>",
         ...
         "<идентификатор_группы_безопасности_N>"
       ],
       "networkId": "<идентификатор_сети>",
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
             "router": {
               "showNoticeMessages": <показывать_информационные_уведомления>,
               "time_quantiles": [
                 <список_квантилей_времени_для_отображения_статистики>
               ],
               "defaultRouteBehavior": "<разрешать_мультишардовые_запросы>",
               "preferSameAvailabilityZone": <приоритет_маршрутизации_в_зону_доступности_роутера>
             },
             "resources": {
               "resourcePresetId": "<класс_хостов_INFRA>",
               "diskSize": "<размер_хранилища_в_байтах>",
               "diskTypeId": "<тип_диска>"
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
       },
       "databaseSpecs": [
         {
           "name": "<имя_БД>"
         },
         { <аналогичный_набор_настроек_для_БД_2> },
         { ... },
         { <аналогичный_набор_настроек_для_БД_N> }
       ],
       "userSpecs": [
         {
           "name": "<имя_пользователя>",
           "password": "<пароль_пользователя>",
           "permissions": [
             {
               "databaseName": "<имя_БД>"
             },
             { <имя_БД_2> },
             { ... },
             { <имя_БД_N> }
           ],
           "settings": {
             "connectionLimit": "<количество_пользовательских_соединений>",
             "connectionRetries": "<количество_повторов_при_подключении>"
           },
           "grants": [
             "привилегия_1",
             ...,
             "привилегия_N"
           ]
         },
         { <аналогичный_набор_настроек_для_пользователя_2> },
         { ... },
         { <аналогичный_набор_настроек_для_пользователя_N> }
       ],
       "hostSpecs": [
         {
           "zoneId": "<зона_доступности>",
           "subnetId": "<идентификатор_подсети>",
           "assignPublicIp": <разрешить_публичный_доступ_к_хосту>,
           "type": "<тип_хоста>"
         },
         { <аналогичный_набор_настроек_для_хоста_2> },
         { ... },
         { <аналогичный_набор_настроек_для_хоста_N> }
       ],
       "shardSpecs": [
         {
           "shardName": "<имя_шарда>",
           "mdbPostgresql": {
             "clusterId": "<идентификатор_кластера>"
           }
         },
         { <аналогичный_набор_настроек_для_шарда_2> },
         { ... },
         { <аналогичный_набор_настроек_для_шарда_N> }
       ],
       "maintenanceWindow": {
         "weeklyMaintenanceWindow": {
           "day": "<день_недели>",
           "hour": "<час_дня>"
         }
       }
     }
     ```


     Где:

     * `folderId` — идентификатор каталога.  Его можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
     * `name` — имя кластера.
     * `environment` — окружение кластера: `PRODUCTION` или `PRESTABLE`.
     * `networkId` — идентификатор [сети](../../vpc/concepts/network.md#network), в которой будет размещен кластер.

       {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}

     
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

         * `coordinator` – при расширенном шардировании задайте параметры ресурсов координатора:
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
             * `timeQuantiles` — массив временных квантилей для отображения статистики. По умолчанию используются значения `0.5`, `0.75`, `0.9`, `0.95`, `0.99`, `0.999`, `0.9999`.
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

     * `databaseSpecs` — настройки баз данных в виде массива элементов. Каждый элемент соответствует отдельной БД и имеет следующую структуру:

       * `name` — имя БД.

     * `userSpecs` — настройки пользователей в виде массива элементов. Каждый элемент соответствует отдельному пользователю и имеет следующую структуру:

       * `name` — имя пользователя.
       * `password` — пароль пользователя. Длина пароля — от 8 до 128 символов.
       * `permissions.databaseName` — имя базы данных, к которой пользователь получает доступ.
       * `settings` — параметры пользовательских подключений к БД:

         * `connectionLimit` — лимит подключений.
         * `connectionRetries` — количество повторных попыток подключения.

       * `grants` – привилегии пользователя в виде массива строк. Возможные значения: `reader`, `writer`, `admin`, `transfer`.

     * `hostSpecs` — настройки хостов кластера в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

       * `zoneId` — [зона доступности](../../overview/concepts/geo-scope.md);

       
       * `subnetId` — идентификатор [подсети](../../vpc/concepts/network.md#subnet);
       * `assignPublicIp` — разрешение на [подключение](connect.md) к хосту из интернета: `true` или `false`;


       * `type` — тип хоста. Возможные значения:
         * `ROUTER` — роутер в кластере с расширенным шардированием;
         * `COORDINATOR` — координатор в кластере с расширенным шардированием;
         * `INFRA` — хост `INFRA` в кластере со стандартным шардированием.

     * `shardSpecs` — настройки шардов в виде массива элементов. Каждый элемент соответствует отдельному шарду и имеет следующую структуру:

       * `shardName` — имя шарда.
       * `mdbPostgresql.clusterId` — идентификатор кластера {{ mpg-name }} в составе шарда.

     * `maintenanceWindow` — настройки расписания окна технического обслуживания:

       * `day` — день недели в формате `DDD`, когда должно проходить обслуживание.
       * `hour` — час дня в формате `HH`, когда должно проходить обслуживание. Допустимые значения: от `1` до `24`.

  1. Воспользуйтесь методом [Cluster.Create](../api-ref/Cluster/create.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters' \
       --data "@body.json"
     ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

     
     ```json
     {
       "folder_id": "<идентификатор_каталога>",
       "name": "<имя_кластера>",
       "description": "<описание>",
       "environment": "<окружение>",
       "security_group_ids": [
         "<идентификатор_группы_безопасности_1>",
         "<идентификатор_группы_безопасности_2>",
         ...
         "<идентификатор_группы_безопасности_N>"
       ],
       "network_id": "<идентификатор_сети>",
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
               "disk_type_id": "<тип_диска>" }
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
             },
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
       "database_specs": [
         {
           "name": "<имя_БД>"
         },
         { <аналогичный_набор_настроек_для_БД_2> },
         { ... },
         { <аналогичный_набор_настроек_для_БД_N> }
       ],
       "user_specs": [
         {
           "name": "<имя_пользователя>",
           "password": "<пароль_пользователя>",
           "permissions": [
             {
               "database_name": "<имя_БД>"
             },
             { <имя_БД_2> },
             { ... },
             { <имя_БД_N> }
           ],
           "settings": {
             "connection_limit": {
               "value": <количество_пользовательских_соединений>
             },
             "connection_retries": {
               "value": <количество_повторов_при_подключении>
             }
           },
           "grants": [
             "привилегия_1",
             ...,
             "привилегия_N"
           ]
         },
         { <аналогичный_набор_настроек_для_пользователя_2> },
         { ... },
         { <аналогичный_набор_настроек_для_пользователя_N> }
       ],
       "host_specs": [
         {
           "zone_id": "<зона_доступности>",
           "subnet_id": "<идентификатор_подсети>",
           "assign_public_ip": <разрешить_публичный_доступ_к_хосту>,
           "type": "<тип_хоста>"
         },
         { <аналогичный_набор_настроек_для_хоста_2> },
         { ... },
         { <аналогичный_набор_настроек_для_хоста_N> }
       ],
       "shard_specs": [
         {
           "shard_name": "<имя_шарда>",
           "mdb_postgresql": {
             "cluster_id": "<идентификатор_кластера>"
           }
         },
         { <аналогичный_набор_настроек_для_шарда_2> },
         { ... },
         { <аналогичный_набор_настроек_для_шарда_N> }
       ],
       "maintenance_window": {
         "weekly_maintenance_window": {
           "day": "<день_недели>",
           "hour": "<час_дня>"
         }
       }
     }
     ```


     Где:

     * `folder_id` — идентификатор каталога.  Его можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md)..
     * `name` — имя кластера.
     * `environment` — окружение кластера: `PRODUCTION` или `PRESTABLE`.
     * `network_id` — идентификатор [сети](../../vpc/concepts/network.md#network), в которой будет размещен кластер.

       {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}

     
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

         * `coordinator` – при расширенном шардировании задайте параметры ресурсов координатора:
             * `resource_preset_id` — класс хостов;
             * `disk_size` — размер диска в байтах;
             * `disk_type_id` — тип диска.

         * `infra` – при стандартном шардировании задайте настройки хостов `INFRA`:

           * `resources` — параметры ресурсов:
              * `resource_preset_id` — класс хостов;
              * `disk_size` — размер диска в байтах;
              * `disk_type_id` — тип диска.

           * `router` — конфигурация роутера:
               * `default_route_behavior` — поведение роутера по умолчанию. Возможные значения: `BLOCK` — блокировать запрос, `ALLOW` — разрешать.
               * `prefer_same_availability_zone` — включить приоритет маршрутизации в зону доступности роутера: `true` или `false`.

           * `console_password` — пароль консоли {{ SPQR }}.
           * `log_level` — уровень логирования запросов: `DEBUG`, `INFO`, `WARNING`, `ERROR`, `FATAL`, `PANIC`.


       * `backup_window_start` — настройки окна резервного копирования.

         В параметре укажите время, когда начинать резервное копирование. Возможные значения параметров:

         * `hours` — от `0` до `23` часов;
         * `minutes` — от `0` до `59` минут;
         * `seconds` — от `0` до `59` секунд;
         * `nanos` — от `0` до `999999999` наносекунд.

       * `backup_retain_period_days` — сколько дней хранить резервную копию кластера. Возможные значения: от `7` до `60` дней.

     * `database_specs` — настройки баз данных в виде массива элементов. Каждый элемент соответствует отдельной БД и имеет следующую структуру:

       * `name` — имя БД.

     * `user_specs` — настройки пользователей в виде массива элементов. Каждый элемент соответствует отдельному пользователю и имеет следующую структуру:

       * `name` — имя пользователя.
       * `password` — пароль пользователя. Длина пароля — от 8 до 128 символов.
       * `permissions.database_name` — имя базы данных, к которой пользователь получает доступ.
       * `settings` — параметры пользовательских подключений к БД:

         * `connection_limit` — лимит подключений.
         * `connection_retries` — количество повторных попыток подключения.

       * `grants` – привилегии пользователя в виде массива строк. Возможные значения: `reader`, `writer`, `admin`, `transfer`.

     * `host_specs` — настройки хостов кластера в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

       * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md);

       
       * `subnet_id` — идентификатор [подсети](../../vpc/concepts/network.md#subnet);
       * `assign_public_ip` — разрешение на [подключение](connect.md) к хосту из интернета: `true` или `false`;


       * `type` — тип хоста. Возможные значения:
         * `ROUTER` — роутер в кластере с расширенным шардированием;
         * `COORDINATOR` — координатор в кластере с расширенным шардированием;
         * `INFRA` — хост `INFRA` в кластере со стандартным шардированием.

     * `shard_specs` — настройки шардов в виде массива элементов. Каждый элемент соответствует отдельному шарду и имеет следующую структуру:

       * `shard_name` — имя шарда.
       * `mdb_postgresql.cluster_id` — идентификатор кластера {{ mpg-name }} в составе шарда.

     * `maintenance_window` — настройки расписания окна технического обслуживания:

       * `day` — день недели в формате `DDD`, когда должно проходить обслуживание.
       * `hour` — час дня в формате `HH`, когда должно проходить обслуживание. Допустимые значения: от `1` до `24`.

  1. Воспользуйтесь вызовом [ClusterService.Create](../api-ref/grpc/Cluster/create.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d @ \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.ClusterService.Create \
       < body.json
     ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}
