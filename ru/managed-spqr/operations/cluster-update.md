---
title: Изменение кластера {{ SPQR }}
description: После создания кластера {{ SPQR }} вы можете изменить его основные и дополнительные настройки.
keywords:
  - keyword: изменение кластера {{ SPQR }}
  - keyword: кластер {{ SPQR }}
  - keyword: '{{ SPQR }}'
---

# Изменение кластера {{ SPQR }}

После создания кластера вы можете изменить его основные и дополнительные настройки.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно изменить кластер {{ SPQR }}.
    1. [Перейдите]({{ link-console-main }}/link/managed-spqr) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        * Измените имя и описание кластера.
        * Удалите или добавьте новые [метки](../../resource-manager/concepts/labels.md).

    
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network }}** выберите [группы безопасности](../../vpc/concepts/security-groups.md) для кластера.

        {% include [note-sg](../../_includes/managed-spqr/note-sg.md) %}
    

    1. Измените конфигурацию вычислительных ресурсов:

        * Для стандартного шардирования измените в блоке **{{ ui-key.yacloud.spqr.section_infra }}** конфигурацию инфраструктурных хостов.
        * Для расширенного шардирования измените в блоке **{{ ui-key.yacloud.spqr.section_router }}** конфигурацию хостов-роутеров и конфигурацию хостов-координаторов в блоке **{{ ui-key.yacloud.spqr.section_coordinator }}**.

        Чтобы изменить конфигурацию вычислительных ресурсов:

        1. В поле **{{ ui-key.yacloud.mdb.forms.resource_presets_field-generation }}** измените платформу.
        1. Измените **{{ ui-key.yacloud.mdb.forms.resource_presets_field-type }}** виртуальной машины, на которой развернуты хосты.
        1. Измените **{{ ui-key.yacloud.mdb.forms.section_resource }}**.
        1. В блоке **{{ ui-key.yacloud.mdb.forms.section_storage }}** измените размер хранилища.

    1. Измените дополнительные настройки кластера:

        {% include [extra-settings](../../_includes/mdb/mspqr/console/extra-settings.md) %}

    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}** нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}** и измените [настройки СУБД уровня кластера](../concepts/settings-list.md).

    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить параметры кластера и хостов:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        yc managed-sharded-postgresql cluster update --help
        ```

    1. Укажите новые параметры кластера в команде изменения (в примере приведены не все параметры):

       * Для кластера со стандартным шардированием:

         
         
         ```bash
         yc managed-sharded-postgresql cluster update <имя_или_идентификатор_кластера>  \
          --new-name <имя_кластера> \
          --security-group-ids <идентификаторы_групп_безопасности> \      
          --infra-resource-preset <класс_хоста> \
          --infra-disk-size <размер_хранилища_ГБ> \
          --deletion-protection \
          --maintenance-window type=<тип_технического_обслуживания>,`
                               `day=<день_недели>,`
                               `hour=<порядковый_номер_часового_интервала> \
          --websql-access=<true_или_false> \
          --backup-window-start <время_начала_резервного_копирования> \
          --backup-retain-period-days <срок_хранения_автоматических_резервных_копий>
         ```



       * Для кластера с расширенным шардированием:

         
         
         ```bash
         yc managed-sharded-postgresql cluster update <имя_или_идентификатор_кластера>  \
           --new-name <имя_кластера> \
           --security-group-ids <идентификаторы_групп_безопасности> \      
           --router-resource-preset <класс_хоста> \
           --router-disk-size <размер_хранилища_ГБ> \
           --coordinator-resource-preset <класс_хоста> \
           --coordinator-disk-size <размер_хранилища_ГБ> \
           --deletion-protection \
           --maintenance-window type=<тип_технического_обслуживания>,`
                                  `day=<день_недели>,`
                                  `hour=<порядковый_номер_часового_интервала> \
           --websql-access=<true_или_false> \
           --backup-window-start <время_начала_резервного_копирования> \
           --backup-retain-period-days <срок_хранения_автоматических_резервных_копий>
         ```



         Где:

         * `<имя_или_идентификатор_кластера>` — имя или идентификатор кластера, которые можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
         * `--new-name` — новое имя кластера.

         
         * `--security-group-ids` — список идентификаторов групп безопасности.

            {% include [note-sg](../../_includes/managed-spqr/note-sg.md) %}


         * `--infra-resource-preset`, `--router-resource-preset`, `--coordinator-resource-preset` — классы хостов `INFRA`, `ROUTER`, `COORDINATOR` соответственно.
         * `--infra-disk-size`, `--router-disk-size`, `--coordinator-disk-size` — размеры хранилища хостов `INFRA`, `ROUTER`, `COORDINATOR` соответственно.
         * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

           {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-data.md) %}

         * `--maintenance-window` — настройки времени технического обслуживания (в т. ч. для выключенных кластеров), где `type` — тип технического обслуживания:

           {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

         * `--backup-retain-period` — срок хранения автоматических резервных копий (в днях).

         {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}

    Чтобы изменить конфигурацию сервисов кластера:

    1. Посмотрите описание команды CLI для изменения конфигурации:

        ```bash
        yc managed-sharded-postgresql cluster update-config --help
        ```

    1. Укажите новые параметры конфигурации в команде изменения (в примере приведены не все параметры):

        ```bash
        yc managed-sharded-postgresql cluster update-config <имя_или_идентификатор_кластера>  \
          --set router.show_notice_messages=<показывать_информационные_уведомления>,`
                router.prefer_same_availability_zone=<приоритет_маршрутизации_в_зону_доступности_роутера>,`
                router.default_route_behavior=<разрешать_мультишардовые_запросы>,`
                router.time_quantiles="<список_квантилей_времени_для_отображения_статистики>"
        ```

        Где:

        * `<имя_или_идентификатор_кластера>` — имя или идентификатор кластера, которые можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
        * `--set` — новая конфигурация роутера:
          * `router.show_notice_messages` — показывать информационные уведомления: `true` или `false`.
          * `router.prefer_same_availability_zone` — включить приоритет маршрутизации запросов на чтение в зону доступности роутера: `true` или `false`.
          * `router.default_route_behavior` — политика выполнения мультишардовых запросов роутером. Возможные значения: `BLOCK` — блокировать, `ALLOW` — разрешать.
          * `router.time_quantiles` — список временных квантилей для отображения статистики. По умолчанию используется значение `"0.5,0.75,0.9,0.95,0.99,0.999,0.9999"`.

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        Как создать такой файл, описано в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера {{ mspqr-name }} вы найдете в [документации провайдера {{ TF }}](https://yandex.cloud/ru/docs/terraform/resources/mdb_sharded_postgresql_cluster).

    1. Измените описание ресурсов:

       * Для кластера со стандартным шардированием:

         
         ```hcl
         resource "yandex_mdb_sharded_postgresql_cluster" "<имя_кластера>" {
           ...
           security_group_ids = [ "<список_идентификаторов_групп_безопасности>" ]
           config = {
             sharded_postgresql_config = {
               infra = {
                 resources = {
                   resource_preset_id = "<класс_хоста>"
                   disk_size          = <размер_хранилища_ГБ>
                 }
                 router = {
                   show_notice_messages = <показывать_информационные_уведомления>
                   prefer_same_availability_zone = <приоритет_маршрутизации_в_зону_доступности_роутера>
                   default_route_behavior = <разрешать_мультишардовые_запросы>
                   time_quantiles = [ <список_квантилей_времени_для_отображения_статистики> ]
                 }
               }
             }
             deletion_protection = <защитить_кластер_от_удаления>
             maintenance_window = {
               type = "<тип_технического_обслуживания>"
               day  = "<день_недели>"
               hour = <порядковый_номер_часового_интервала>
             }
             backup_retain_period_days = <количество_дней>
             backup_window_start = {
               hours   = <час_начала_резервного_копирования>
               minutes = <минута_начала_резервного_копирования>
             }
           }
         }
         ```


       * Для кластера с расширенным шардированием:

         
         ```hcl
         resource "yandex_mdb_sharded_postgresql_cluster" "<имя_кластера>" {
           ...
           security_group_ids = [ "<список_идентификаторов_групп_безопасности>" ]
           config = {
             sharded_postgresql_config = {
               router = {
                 resources = {
                   resource_preset_id = "<класс_хоста>"
                   disk_size          = <размер_хранилища_ГБ>
                 }
                 config = {
                   show_notice_messages = <показывать_информационные_уведомления>
                   prefer_same_availability_zone = <приоритет_маршрутизации_в_зону_доступности_роутера>
                   default_route_behavior = <разрешать_мультишардовые_запросы>
                   time_quantiles = [ <список_квантилей_времени_для_отображения_статистики> ]
                 }
               }
               coordinator = {
                 resources = {
                   resource_preset_id = "<класс_хоста>"
                   disk_size          = <размер_хранилища_ГБ>
                 }
               }
             }
             deletion_protection = <защитить_кластер_от_удаления>
             maintenance_window = {
               type = "<тип_технического_обслуживания>"
               day  = "<день_недели>"
               hour = <порядковый_номер_часового_интервала>
             }
             backup_retain_period_days = <количество_дней>
             backup_window_start = {
               hours   = <час_начала_резервного_копирования>
               minutes = <минута_начала_резервного_копирования>
             }
           }
         }
         ```


       Где:

       
       * `security_group_ids` — идентификаторы [групп безопасности](../../vpc/concepts/security-groups.md).

         {% include [note-sg](../../_includes/managed-spqr/note-sg.md) %}


       * `deletion_protection` — защита кластера от удаления: `true` или `false`.

          {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-data.md) %}

       * `config` — настройки кластера:

         * `sharded_postgresql_config` — настройки сервиса {{ SPQR }}:

           * `router` — настройки роутера:

             * `config` — конфигурация роутера:

                * `show_notice_messages` — показывать информационные уведомления: `true` или `false`.
                * `time_quantiles` — массив строк временных квантилей для отображения статистики. По умолчанию используются значения `"0.5"`, `"0.75"`, `"0.9"`, `"0.95"`, `"0.99"`, `"0.999"`, `"0.9999"`.
                * `default_route_behavior` — политика выполнения мультишардовых запросов роутером. Возможные значения: `BLOCK` — блокировать, `ALLOW` — разрешать.
                * `prefer_same_availability_zone` — включить приоритет маршрутизации запросов на чтение в зону доступности роутера: `true` или `false`.

             * `resources` — параметры ресурсов хостов `ROUTER`:
                * `resource_preset_id` — [класс хостов](../concepts/instance-types.md);
                * `disk_size` — размер диска в ГБ.

           * `coordinator` – настройки координатора:
             * `resources` — параметры ресурсов:
               * `resource_preset_id` — класс хостов;
               * `disk_size` — размер диска в ГБ.

           * `infra` – настройки хостов `INFRA`:

             * `resources` — параметры ресурсов:
               * `resource_preset_id` — класс хостов;
               * `disk_size` — размер диска в ГБ.

             * `router` — конфигурация роутера:

               * `show_notice_messages` — показывать информационные уведомления: `true` или `false`.
               * `time_quantiles` — массив строк временных квантилей для отображения статистики. По умолчанию используются значения `"0.5"`, `"0.75"`, `"0.9"`, `"0.95"`, `"0.99"`, `"0.999"`, `"0.9999"`.
               * `default_route_behavior` — политика выполнения мультишардовых запросов роутером. Возможные значения: `BLOCK` — блокировать, `ALLOW` — разрешать.
               * `prefer_same_availability_zone` — включить приоритет маршрутизации запросов на чтение в зону доступности роутера: `true` или `false`.

       * `backup_window_start` — настройки окна резервного копирования.

         В параметре укажите время, когда начинать резервное копирование. Возможные значения параметров:

         * `hours` — от `0` до `23` часов;
         * `minutes` — от `0` до `59` минут;

       * `backup_retain_period_days` — сколько дней хранить резервную копию кластера. Возможные значения: от `7` до `60` дней.

       * `maintenance_window` — настройки расписания окна технического обслуживания:

         * `type` — тип технического обслуживания. Принимает значения:
             * `ANYTIME` — в любое время.
             * `WEEKLY` — по расписанию.
         * `day` — день недели для типа `WEEKLY`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`        или `SUN`.
         * `hour` — порядковый номер часового интервала по UTC для типа `WEEKLY`: от `1` до `24`.

           > Например, `1` соответствует интервалу с `00:00` до `01:00`, `5` — с `04:00` до `05:00`.

    1. Проверьте корректность настроек.

       {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

       {% include [Terraform timeouts](../../_includes/mdb/mspqr/terraform/timeouts.md) %}

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
               "diskSize": "<размер_хранилища_в_байтах>"
             }
           },
           "coordinator": {
             "resources": {
               "resourcePresetId": "<класс_хостов_координатора>",
               "diskSize": "<размер_хранилища_в_байтах>"
             }
           },
           "infra": {
             "resources": {
               "resourcePresetId": "класс_хостов_INFRA",
               "diskSize": "<размер_хранилища_в_байтах>"
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

     * `name` — новое имя кластера.

     
     * `securityGroupIds` — идентификаторы [групп безопасности](../../vpc/concepts/security-groups.md).
        
        {% include [note-sg](../../_includes/managed-spqr/note-sg.md) %}


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
             * `diskSize` — размер диска в байтах.

           * `coordinator` – при расширенном шардировании задайте настройки координатора:
             * `resources` — параметры ресурсов:
               * `resourcePresetId` — класс хостов;
               * `diskSize` — размер диска в байтах.

           * `infra` – при стандартном шардировании задайте настройки хостов `INFRA`:

             * `resources` — параметры ресурсов:
               * `resourcePresetId` — класс хостов;
               * `diskSize` — размер диска в байтах.

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

     {% include [cluster-id-standard](../../_includes/managed-spqr/cluster-id-standard.md) %}

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

     
     ```json
     {
       "cluster_id": "<идентификатор_кластера>",
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
               "disk_size": "<размер_хранилища_в_байтах>"
             }
           },
           "coordinator": {
             "resources": {
               "resource_preset_id": "<класс_хостов_координатора>",
               "disk_size": "<размер_хранилища_в_байтах>"
             }
           },
           "infra": {
             "resources": {
               "resource_preset_id": "класс_хостов_INFRA",
               "disk_size": "<размер_хранилища_в_байтах>"
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

     * {% include [cluster-id-cluster](../../_includes/managed-spqr/cluster-id-cluster.md) %}
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

     * `name` — новое имя кластера.

     
     * `security_group_ids` — идентификаторы [групп безопасности](../../vpc/concepts/security-groups.md).

        {% include [note-sg](../../_includes/managed-spqr/note-sg.md) %}


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
             * `disk_size` — размер диска в байтах.

           * `coordinator` – при расширенном шардировании задайте настройки координатора:
             * `resources` — параметры ресурсов:
               * `resource_preset_id` — класс хостов;
               * `disk_size` — размер диска в байтах.

           * `infra` – при стандартном шардировании задайте настройки хостов `INFRA`:

             * `resources` — параметры ресурсов:
               * `resource_preset_id` — класс хостов;
               * `disk_size` — размер диска в байтах.

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
