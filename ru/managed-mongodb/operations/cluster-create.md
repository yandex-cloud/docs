---
title: Создание кластера {{ MG }}
description: Следуя данной инструкции, вы сможете создать кластер {{ MG }}.
---

# Создание кластера {{ MG }}

[Кластер](../../glossary/cluster.md) {{ MG }} — это один или несколько хостов базы данных, между которыми можно настроить [репликацию](../concepts/replication.md). Репликация работает по умолчанию в любом кластере из более чем 1 хоста (первичный хост принимает запросы на запись и асинхронно дублирует изменения на вторичных хостах).


{% note info %}

* Количество хостов, которые можно создать вместе с кластером {{ MG }}, зависит от выбранного [типа диска](../concepts/storage.md#storage-type-selection) и [класса хостов](../concepts/instance-types.md#available-flavors).
* Доступные типы диска [зависят](../concepts/storage.md) от выбранного [класса хостов](../concepts/instance-types.md).

{% endnote %}




## Создать кластер {#create-cluster}


Для создания кластера {{ mmg-name }} нужна роль [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) и роль [{{ roles.mmg.editor }} или выше](../security/index.md#roles-list). О том, как назначить роль, см. в [документации {{ iam-name }}](../../iam/operations/roles/grant.md).


{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы создать кластер {{ mmg-name }}:

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер БД.

  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}**:

      * Введите название в поле **{{ ui-key.yacloud.mdb.forms.base_field_name }}**. Имя кластера должно быть уникальным в рамках облака.
      * (Опционально) Введите **{{ ui-key.yacloud.mdb.forms.base_field_description }}** кластера.
      * Выберите окружение, в котором нужно создать кластер (после создания кластера окружение изменить невозможно):

          * `PRODUCTION` — для стабильных версий ваших приложений.
          * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.

      * Укажите версию СУБД.

  1. {% include [mmg-settings-host-class](../../_includes/mdb/mmg/settings-host-class.md) %}

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_disk }}**:

      * Выберите [тип диска](../concepts/storage.md).

        {% include [storages-step-settings](../../_includes/mdb/settings-storages.md) %}

      * Выберите размер хранилища, который будет использоваться для данных и резервных копий. Подробнее о том, как занимают пространство резервные копии, см. в разделе [Резервные копии](../concepts/backup.md).

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_database }}** укажите атрибуты БД:

      * Имя БД.

        {% include [db-name-limits](../../_includes/mdb/mmg/note-info-db-name-limits.md) %}

      * Имя пользователя.
      * Пароль пользователя. Минимум 8 символов.

  
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network }}** выберите:

      * [Облачную сеть](../../vpc/concepts/network.md#network) для размещения кластера.
      * Группы безопасности для сетевого трафика кластера. Может потребоваться дополнительная [настройка групп безопасности](connect/index.md#configuring-security-groups) для того, чтобы можно было подключаться к кластеру.


  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_host }}** добавьте хосты БД, создаваемые вместе с кластером:

     
     * Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_add-host }}**.
     * Выберите [зону доступности](../../overview/concepts/geo-scope.md).
     * Выберите [подсеть](../../vpc/concepts/network.md#subnet) в указанной зоне доступности. Если подсети нет, создайте ее.
     * Если хост должен быть доступен снаружи {{ yandex-cloud }}, включите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.

     
     Чтобы обеспечить отказоустойчивость, для типов диска `local-ssd` и `network-ssd-nonreplicated` необходимо как минимум 3 хоста. Подробнее см. в разделе [Хранилище](../concepts/storage.md).

     По умолчанию хосты создаются в разных зонах доступности. См. подробнее об [управлении хостами](hosts.md).
  
  1. При необходимости задайте дополнительные настройки кластера:

      {% include [mmg-extra-settings](../../_includes/mdb/mmg-extra-settings.md) %}

  1. При необходимости задайте [настройки СУБД](../concepts/settings-list.md#dbms-cluster-settings).

      {% include [mmg-settings-dependence](../../_includes/mdb/mmg/note-info-settings-dependence.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать кластер {{ mmg-name }}:

  
  1. Проверьте, есть ли в каталоге подсети для хостов кластера:

     ```bash
     yc vpc subnet list
     ```

     Если ни одной подсети в каталоге нет, [создайте нужные подсети](../../vpc/operations/subnet-create.md) в сервисе {{ vpc-short-name }}.


  1. Посмотрите описание команды CLI для создания кластера:

      ```bash
      {{ yc-mdb-mg }} cluster create --help
      ```

  1. Укажите параметры кластера в команде создания (в примере приведены не все параметры):

      
      ```bash
      {{ yc-mdb-mg }} cluster create \
        --name <имя_кластера> \
        --environment=<окружение> \
        --network-name <имя_сети> \
        --host zone-id=<зона_доступности>,`
              `subnet-id=<идентификатор_подсети>,`
              `assign-public-ip=<публичный_доступ_к_хосту>,`
              `hidden=<скрытие_хоста>,`
              `secondary-delay-secs=<отставание_реплики_в_секундах>,`
              `priority=<приоритет_хоста> \
        --mongod-resource-preset <класс_хоста> \
        --user name=<имя_пользователя>,password=<пароль_пользователя> \
        --database name=<имя_БД> \
        --mongod-disk-type <network-hdd|network-ssd|network-ssd-nonreplicated|local-ssd> \
        --mongod-disk-size <размер_хранилища_ГБ> \
        --performance-diagnostics=<включить_диагностику> \
        --deletion-protection
      ```

      Идентификатор подсети `subnet-id` необходимо указывать, если в выбранной зоне доступности создано 2 и больше подсетей.


      Где:

      * `--environment` — окружение: `prestable` или `production`.

      
      * `--host` — параметры хоста:
         * `zone-id` — [зона доступности](../../overview/concepts/geo-scope.md).
         * `subnet-id` — [идентификатор подсети](../../vpc/concepts/network.md#subnet). Необходимо указывать, если в выбранной зоне доступности создано две или больше подсетей.
         * `assign-public-ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.
         * `hidden` — скрытие хоста: `true` или `false`. Если хост скрыт, он будет доступен для чтения только для прямых подключений (например, чтобы делать с него резервные копии, не добавляя нагрузки на кластер).
         * `secondary-delay-secs` — отставание реплики от мастера в секундах. Может быть полезно для восстановления данных в случае ошибочных операций.
         * `priority` — [приоритет назначения хоста мастером](../concepts/replication.md#master-failover).

      * `--mongod-disk-type` — тип диска.


      * `--performance-diagnostics` — включить диагностику производительности кластера: `true` или `false`.
      * `--deletion-protection` — защита кластера от непреднамеренного удаления: `true` или `false`. Включенная защита не помешает удалить пользователя или базу данных, а также подключиться вручную и удалить содержимое базы данных.

      {% include [db-name-limits](../../_includes/mdb/mmg/note-info-db-name-limits.md) %}

      {% note info %}

      По умолчанию при создании кластера устанавливается режим [технического обслуживания](../concepts/maintenance.md) `anytime` — в любое время. Вы можете установить конкретное время обслуживания при [изменении настроек кластера](update.md#change-additional-settings).

      {% endnote %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы создать кластер {{ mmg-name }}:

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     * Кластер базы данных — описание кластера и его хостов.

     * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

     * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

     Пример структуры конфигурационного файла:

     
     ```hcl
     resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
       name                = "<имя_кластера>"
       environment         = "<окружение>"
       network_id          = "<идентификатор_сети>"
       security_group_ids  = [ "<список_идентификаторов_групп_безопасности>" ]
       deletion_protection = <защита_кластера_от_удаления>

       cluster_config {
         version = "<версия_{{ MG }}>"
       }

       resources_mongod {
         resource_preset_id = "<класс_хоста>"
         disk_type_id       = "<тип_диска>"
         disk_size          = <размер_хранилища_ГБ>
       }

       host {
         zone_id          = "<зона_доступности>"
         subnet_id        = "<идентификатор_подсети>"
         assign_public_ip = <публичный_доступ>
         host_parameters {
           hidden               = <скрытие_хоста>
           secondary_delay_secs = <отставание_реплики_в_секундах>
           priority             = <приоритет_хоста>
         }
       }
     }

     resource "yandex_mdb_mongodb_database" "<имя_БД>" {
       cluster_id = "<идентификатор_кластера>"
       name       = "<имя_БД>"
     }

     resource "yandex_mdb_mongodb_user" "<имя_пользователя>" {
       cluster_id = <идентификатор_кластера>
       name       = "<имя_пользователя>"
       password   = "<пароль>"
       permission {
         database_name = "<имя_БД>"
         roles         = [ "<список_ролей_пользователя>" ]
       }
       depends_on = [
         yandex_mdb_mongodb_database.<имя_БД>
       ]
     }

     resource "yandex_vpc_network" "<имя_сети>" { name = "<имя_сети>" }

     resource "yandex_vpc_subnet" "<имя_подсети>" {
       name           = "<имя_подсети>"
       zone           = "<зона_доступности>"
       network_id     = "<идентификатор_сети>"
       v4_cidr_blocks = ["<диапазон>"]
     }
     ```


     Где:

     * `environment` — окружение: `PRESTABLE` или `PRODUCTION`.
     * `host` — параметры хоста:
       * `zone_id` — зона доступности.
       * `subnet_id` — идентификатор подсети в выбранной зоне доступности.
       * `assign_public_ip` — публичный доступ к хосту: `true` или `false`.
       * `host_parameters` — дополнительные параметры хоста:
         * `hidden` — скрытие хоста: `true` или `false`. Если хост скрыт, он будет доступен для чтения только для прямых подключений (например, чтобы делать с него резервные копии, не добавляя нагрузки на кластер).
         * `secondary_delay_secs` — отставание реплики от мастера в секундах. Может быть полезно для восстановления данных в случае ошибочных операций.
         * `priority` — [приоритет назначения хоста мастером](../concepts/replication.md#master-failover).
     * `deletion_protection` — защита кластера от непреднамеренного удаления: `true` или `false`. Включенная защита не помешает удалить пользователя или базу данных, а также подключиться вручную и удалить содержимое базы данных.
     * `version` — версия {{ MG }}: {{ versions.tf.str }}.

     {% include [db-name-limits](../../_includes/mdb/mmg/note-info-db-name-limits.md) %}

     {% include [Maintenance window](../../_includes/mdb/mmg/terraform/maintenance-window.md) %}

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-mmg }}).

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Создайте кластер.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      После этого в указанном каталоге будут созданы все требуемые ресурсы, а в терминале отобразятся [FQDN хостов](../concepts/network.md#hostname). Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

      {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        
        ```json
        {
          "folderId": "<идентификатор_каталога>",
          "name": "<имя_кластера>",
          "environment": "<окружение>",
          "networkId": "<идентификатор_сети>",
          "securityGroupIds": [
            "<идентификатор_группы_безопасности_1>",
            "<идентификатор_группы_безопасности_2>",
            ...
            "<идентификатор_группы_безопасности_N>"
          ],
          "deletionProtection": <защита_кластера_от_удаления:_true_или_false>,
          "maintenanceWindow": {
            "weeklyMaintenanceWindow": {
              "day": "<день_недели>",
              "hour": "<час>"
            }
          },
          "configSpec": {
            "version": "<версия_{{ MG }}>",
            "mongodb": {
              "mongod": {
                "resources": {
                  "resourcePresetId": "<класс_хоста>",
                  "diskSize": "<размер_хранилища_в_байтах>",
                  "diskTypeId": "<тип_диска>"
                }
              }
            },
            "backupWindowStart":  {
              "hours": "<часы>",
              "minutes": "<минуты>",
              "seconds": "<секунды>",
              "nanos": "<наносекунды>"
            },  
            "backupRetainPeriodDays": "<время_хранения_резервных_копий_в_днях>",
            "performanceDiagnostics": {
              "profilingEnabled": <включить_профилировщик:_true_или_false>
            }
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
                  "databaseName": "<имя_БД>",
                  "roles": [
                    "<роль_1>", "<роль_2>", ..., "<роль_N>"
                  ]
                }
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
              "assignPublicIp": <публичный_доступ_к_хосту:_true_или_false>,
              "type": "<тип_хоста>",
              "shardName": "<имя_шарда>",
              "hidden": <скрытие_хоста:_true_или_false>,
              "secondaryDelaySecs": "<отставание_реплики_в_секундах>",
              "priority": "<приоритет_хоста>",
              "tags": "<метки_хоста>"
            },
            { <аналогичный_набор_настроек_для_хоста_2> },
            { ... },
            { <аналогичный_набор_настроек_для_хоста_N> }
          ],
        }
        ```


        Где:

        * `folderId` — идентификатор каталога. Его можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
        * `name` — имя кластера.
        * `environment` — окружение кластера: `PRODUCTION` или `PRESTABLE`.
        * `networkId` — идентификатор [сети](../../vpc/concepts/network.md#network), в которой будет размещен кластер.

        
        * `securityGroupIds` — идентификаторы [групп безопасности](../concepts/network.md#security-groups).


        * `deletionProtection` — защита кластера от непреднамеренного удаления: `true` или `false`. Включенная защита не помешает удалить пользователя или базу данных, а также подключиться вручную и удалить содержимое базы данных.

        * `maintenanceWindow` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). В `maintenanceWindow` передайте один из двух параметров:

          * `anytime` — техническое обслуживание происходит в любое время.
          * `weeklyMaintenanceWindow` — техническое обслуживание происходит раз в неделю, в указанное время:

            * `day` — день недели в формате `DDD`.
            * `hour` — час в формате `HH`. Возможные значения: от `1` до `24` часов.

        * `configSpec` — настройки кластера:

            * `version` — версия {{ MG }}: 5.0, 6.0 или 7.0.
            * `mongod` — тип хоста.

              * `resources` — ресурсы кластера:

                * `resourcePresetId` — [класс хостов](../concepts/instance-types.md).
                * `diskSize` — размер диска в байтах.
                * `diskTypeId` — [тип диска](../concepts/storage.md).

            * `backupWindowStart` — настройки окна [резервного копирования](../concepts/backup.md).

              В параметре укажите время, когда начинать резервное копирование:

              * `hours` — от `0` до `23` часов.
              * `minutes` — от `0` до `59` минут.
              * `seconds` — от `0` до `59` секунд.
              * `nanos` — от `0` до `999999999` наносекунд.

            * `backupRetainPeriodDays` — время хранения резервных копий в днях.

            * `performanceDiagnostics` — настройки для [сбора статистики](performance-diagnostics.md#activate-stats-collector):
              * `profilingEnabled` — включение [профилировщика](tools.md#explore-profiler). 

        * `databaseSpecs` — настройки баз данных в виде массива элементов. Каждый элемент соответствует отдельной БД и содержит параметр `name` — имя БД.

            {% include [db-name-limits](../../_includes/mdb/mmg/note-info-db-name-limits.md) %}

        * `userSpecs` — настройки пользователей в виде массива элементов. Каждый элемент соответствует отдельному пользователю и имеет следующую структуру:

          * `name` — имя пользователя.
          * `password` — пароль пользователя.
          * `permissions` — настройки разрешений пользователя:

            * `databaseName` — имя базы данных, к которой пользователь получает доступ.
            * `roles` — массив ролей пользователя. Каждая роль представлена в виде отдельной строки в массиве. Список доступных значений см. в разделе [Пользователи и роли](../concepts/users-and-roles.md).

            Для каждой базы данных добавьте отдельный элемент с настройками разрешений в массив `permissions`.

        * `hostSpecs` — настройки хостов кластера в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

          * `zoneId` — [зона доступности](../../overview/concepts/geo-scope.md).
          * `subnetId` — [идентификатор подсети](../../vpc/concepts/network.md#subnet).
          * `assignPublicIp` — доступность хоста из интернета по публичному IP-адресу.
          * `type`— тип хоста в шардированном кластере: `MONGOD`, `MONGOINFRA`, `MONGOS` или `MONGOCFG`.
          * `shardName` — имя шарда в шардированном кластере.
          * `hidden` — скрытие хоста: `true` или `false`. Если хост скрыт, он будет доступен для чтения только для прямых подключений (например, чтобы делать с него резервные копии, не добавляя нагрузки на кластер).
          * `secondaryDelaySecs` — отставание реплики от мастера в секундах. Может быть полезно для восстановления данных в случае ошибочных операций.
          * `priority` — [приоритет назначения хоста мастером](../concepts/replication.md#master-failover).
          * `tags`— метки хоста.

  1. Воспользуйтесь методом [Cluster.Create](../api-ref/Cluster/create.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters' \
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
          "environment": "<окружение>",
          "network_id": "<идентификатор_сети>",
          "security_group_ids": [
            "<идентификатор_группы_безопасности_1>",
            "<идентификатор_группы_безопасности_2>",
            ...
            "<идентификатор_группы_безопасности_N>"
          ],
          "deletion_protection": <защита_кластера_от_удаления:_true_или_false>,
          "maintenance_window": {
            "weekly_maintenance_window": {
              "day": "<день_недели>",
              "hour": "<час>"
            }
          },
          "config_spec": {
            "version": "<версия_{{ MG }}>",
            "mongodb": {
              "mongod": {
                "resources": {
                  "resource_preset_id": "<класс_хоста>",
                  "disk_size": "<размер_хранилища_в_байтах>",
                  "disk_type_id": "<тип_диска>"
                }
              }
            },
            "backup_window_start": {
              "hours": "<часы>",
              "minutes": "<минуты>",
              "seconds": "<секунды>",
              "nanos": "<наносекунды>"
            },
            "backup_retain_period_days": "<время_хранения_резервных_копий_в_днях>",
            "performance_diagnostics": {
              "profiling_enabled": <включить_профилировщик:_true_или_false>
            }
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
                  "database_name": "<имя_БД>",
                  "roles": [
                    "<роль_1>", "<роль_2>", ..., "<роль_N>"
                  ]
                }
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
              "assign_public_ip": <публичный_доступ_к_хосту:_true_или_false>,
              "type": "<тип_хоста>",
              "shard_name": "<имя_шарда>",
              "hidden": <скрытие_хоста:_true_или_false>,
              "secondary_delay_secs": "<отставание_реплики_в_секундах>",
              "priority": "<приоритет_хоста>",
              "tags": "<метки_хоста>"
            },
            { <аналогичный_набор_настроек_для_хоста_2> },
            { ... },
            { <аналогичный_набор_настроек_для_хоста_N> }
          ]
        }
        ```


        Где:

        * `folder_id` — идентификатор каталога. Его можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
        * `name` — имя кластера.
        * `environment` — окружение кластера: `PRODUCTION` или `PRESTABLE`.
        * `network_id` — идентификатор [сети](../../vpc/concepts/network.md#network), в которой будет размещен кластер.

        
        * `security_group_ids` — идентификаторы [групп безопасности](../concepts/network.md#security-groups).


        * `deletion_protection` — защита кластера от непреднамеренного удаления: `true` или `false`. Включенная защита не помешает удалить пользователя или базу данных, а также подключиться вручную и удалить содержимое базы данных.

        * `maintenance_window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). В `maintenance_window` передайте один из двух параметров:

          * `anytime` — техническое обслуживание происходит в любое время.
          * `weekly_maintenance_window` — техническое обслуживание происходит раз в неделю, в указанное время:

            * `day` — день недели в формате `DDD`.
            * `hour` — час в формате `HH`. Возможные значения: от `1` до `24` часов.

        * `config_spec` — настройки кластера:

          * `version` — версия {{ MG }}: 5.0, 6.0 или 7.0.
            * `mongod` — тип хоста.

              * `resources` — ресурсы кластера:

                * `resource_preset_id` — [класс хостов](../concepts/instance-types.md).
                * `disk_size` — размер диска в байтах.
                * `disk_type_id` — [тип диска](../concepts/storage.md).

            * `backup_window_start` — настройки окна [резервного копирования](../concepts/backup.md).

              В параметре укажите время, когда начинать резервное копирование:

              * `hours` — от `0` до `23` часов.
              * `minutes` — от `0` до `59` минут.
              * `seconds` — от `0` до `59` секунд.
              * `nanos` — от `0` до `999999999` наносекунд.

            * `backup_retain_period_days` — время хранения резервных копий в днях.

            * `performance_diagnostics` — настройки для [сбора статистики](performance-diagnostics.md#activate-stats-collector):
              * `profiling_enabled` — включение [профилировщика](tools.md#explore-profiler).

        * `database_specs` — настройки баз данных в виде массива элементов. Каждый элемент соответствует отдельной БД и содержит параметр `name` — имя БД.

            {% include [db-name-limits](../../_includes/mdb/mmg/note-info-db-name-limits.md) %}

        * `user_specs` — настройки пользователей в виде массива элементов. Каждый элемент соответствует отдельному пользователю и имеет следующую структуру:

          * `name` — имя пользователя.
          * `password` — пароль пользователя.
          * `permissions` — настройки разрешений пользователя:

            * `database_name` — имя базы данных, к которой пользователь получает доступ.
            * `roles` — массив ролей пользователя. Каждая роль представлена в виде отдельной строки в массиве. Список доступных значений см. в разделе [Пользователи и роли](../concepts/users-and-roles.md).

            Для каждой базы данных добавьте отдельный элемент с настройками разрешений в массив `permissions`.

        * `host_specs` — настройки хостов кластера в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

          * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md).
          * `subnet_id` — [идентификатор подсети](../../vpc/concepts/network.md#subnet).
          * `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу.
          * `type`— тип хоста в шардированном кластере: `MONGOD`, `MONGOINFRA`, `MONGOS` или `MONGOCFG`.
          * `shard_name` — имя шарда в шардированном кластере.
          * `hidden` — скрытие хоста: `true` или `false`. Если хост скрыт, он будет доступен для чтения только для прямых подключений (например, чтобы делать с него резервные копии, не добавляя нагрузки на кластер).
          * `secondaryDelaySecs` — отставание реплики от мастера в секундах. Может быть полезно для восстановления данных в случае ошибочных операций.
          * `priority` — [приоритет назначения хоста мастером](../concepts/replication.md#master-failover).
          * `tags`— метки хоста.

  1. Воспользуйтесь вызовом [ClusterService.Create](../api-ref/grpc/Cluster/create.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mongodb.v1.ClusterService.Create \
          < body.json
      ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}


{% note warning %}

Если вы указали идентификаторы групп безопасности при создании кластера, то для подключения к нему может потребоваться дополнительная [настройка групп безопасности](connect/index.md#configuring-security-groups).

{% endnote %}


## Создать копию кластера {#duplicate}

Вы можете создать кластер {{ MG }}, который будет обладать настройками созданного ранее кластера. Для этого конфигурация исходного кластера {{ MG }} импортируется в {{ TF }}. В результате вы можете либо создать идентичную копию, либо взять за основу импортированную конфигурацию и внести в нее изменения. Использовать импорт удобно, если исходный кластер {{ MG }} обладает множеством настроек и нужно создать похожий на него кластер.

Чтобы создать копию кластера {{ MG }}:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. В той же рабочей директории разместите файл с расширением `.tf` и содержимым:

        ```hcl
        resource "yandex_mdb_mongodb_cluster" "old" { }
        ```

    1. Запишите идентификатор первоначального кластера {{ MG }} в переменную окружения:

        ```bash
        export MONGODB_CLUSTER_ID=<идентификатор_кластера>
        ```

        Идентификатор можно запросить вместе со [списком кластеров в каталоге](../../managed-mongodb/operations/cluster-list.md#list-clusters).

    1. Импортируйте настройки первоначального кластера {{ MG }} в конфигурацию {{ TF }}:

        ```bash
        terraform import yandex_mdb_mongodb_cluster.old ${MONGODB_CLUSTER_ID}
        ```

    1. Получите импортированную конфигурацию:

        ```bash
        terraform show
        ```

    1. Скопируйте ее из терминала и вставьте в файл с расширением `.tf`.
    1. Расположите файл в новой директории `imported-cluster`.
    1. Измените скопированную конфигурацию так, чтобы из нее можно было создать новый кластер:

        * Укажите новое имя кластера в строке `resource` и параметре `name`.
        * Удалите параметры `created_at`, `health`, `id`, `sharded` и `status`.
        * В блоках `host` удалите параметры `health` и `name`.
        * Если в блоке `maintenance_window` указано значение параметра `type = "ANYTIME"`, удалите параметр `hour`.
        * Если есть блоки `user`, удалите их. Пользователи БД добавляются с помощью отдельного ресурса `yandex_mdb_mongodb_user`.
        * (Опционально) Внесите дополнительные изменения, если вам нужна не идентичная, а кастомизированная копия.

    1. В директории `imported-cluster` [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials).

    1. В этой же директории [настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).

    1. Поместите конфигурационный файл в директорию `imported-cluster` и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Проверьте корректность файлов конфигурации {{ TF }}:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

    {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

{% endlist %}

## Примеры {#examples}

### Создание кластера с одним хостом {#creating-a-single-host-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы создать кластер с одним хостом, передайте один параметр `--host`.

  Создайте кластер {{ mmg-name }} с тестовыми характеристиками:

  
  * С именем `mymg`.
  * В окружении `production`.
  * В сети `{{ network-name }}`.
  * В группе безопасности с идентификатором `{{ security-group }}`.
  * С одним хостом класса `{{ host-class }}` в подсети `b0rcctk2rvtr********`, в зоне доступности `{{ region-id }}-a`.
  * С хранилищем на сетевых SSD-дисках (`{{ disk-type-example }}`) размером 20 ГБ.
  * С одним пользователем, `user1`, с паролем `user1user1`.
  * С одной базой данных, `db1`.
  * С защитой от непреднамеренного удаления.


  Выполните следующую команду:

  
  ```bash
  {{ yc-mdb-mg }} cluster create \
    --name mymg \
    --environment production \
    --network-name {{ network-name }} \
    --security-group-ids {{ security-group }} \
    --mongod-resource-preset {{ host-class }} \
    --host zone-id={{ region-id }}-a,subnet-id=b0rcctk2rvtr******** \
    --mongod-disk-size 20 \
    --mongod-disk-type {{ disk-type-example }} \
    --user name=user1,password=user1user1 \
    --database name=db1 \
    --deletion-protection
  ```


- {{ TF }} {#tf}

  Создайте кластер {{ mmg-name }} и сеть для него с тестовыми характеристиками:

  * Название — `mymg`.
  * Версия — `{{ versions.tf.latest }}`.
  * Окружение — `PRODUCTION`.
  * Идентификатор облака — `{{ tf-cloud-id }}`.
  * Идентификатор каталога — `{{ tf-folder-id }}`.
  * Сеть — `mynet`.
  * Класс хоста — `{{ host-class }}`.
  * Количество блоков `host` — один.
  * Подсеть — `mysubnet`. Сетевые настройки: 

    * Зона доступности — `{{ region-id }}-a`.
    * Диапазон — `10.5.0.0/24`.

  
  * Группа безопасности — `mymg-sg`. Правила группы разрешают TCP-подключения к кластеру из интернета через порт `{{ port-mmg }}`.


  * Хранилище на сетевых SSD-дисках — `{{ disk-type-example }}`.
  * Размер хранилища — 20 ГБ.
  * Пользователь — `user1`.
  * Пароль — `user1user1`.
  * База данных — `db1`.
  * Защита от непреднамеренного удаления — включена.

  Конфигурационный файл для кластера с одним хостом:

  
  ```hcl
  resource "yandex_mdb_mongodb_cluster" "mymg" {
    name                = "mymg"
    environment         = "PRODUCTION"
    network_id          = yandex_vpc_network.mynet.id
    security_group_ids  = [ yandex_vpc_security_group.mymg-sg.id ]
    deletion_protection = true

    cluster_config {
      version = "{{ versions.tf.latest }}"
    }

    resources_mongod {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 20
    }

    host {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
    }
  }

  resource "yandex_mdb_mongodb_database" "db1" {
    cluster_id = yandex_mdb_mongodb_cluster.mymg.id
    name       = "db1"
  }

  resource "yandex_mdb_mongodb_user" "user1" {
    cluster_id = yandex_mdb_mongodb_cluster.mymg.id
    name       = "user1"
    password   = "user1user1"
    permission {
      database_name = "db1"
    }
    depends_on = [
      yandex_mdb_mongodb_database.db1
    ]
  }

  resource "yandex_vpc_network" "mynet" {
    name = "mynet"
  }

  resource "yandex_vpc_security_group" "mymg-sg" {
    name       = "mymg-sg"
    network_id = yandex_vpc_network.mynet.id

    ingress {
      description    = "MongoDB"
      port           = {{ port-mmg }}
      protocol       = "TCP"
      v4_cidr_blocks = [ "0.0.0.0/0" ]
    }
  }

  resource "yandex_vpc_subnet" "mysubnet" {
    name           = "mysubnet"
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.mynet.id
    v4_cidr_blocks = ["10.5.0.0/24"]
  }
  ```


{% endlist %}

### Создание шардированного кластера {#creating-a-sharded-cluster}

Кластер {{ mmg-name }} можно создать со [стандартным](#std-sharding) или [расширенным](#adv-sharding) шардированием. Подробнее о видах шардирования см. в разделе [Особенности управления шардированием](../concepts/sharding.md#shard-management).

#### Стандартное шардирование {#std-sharding}

Создайте кластер {{ mmg-name }} и сеть для него с несколькими хостами:

* один хост `MONGOD`;
* три хоста `MONGOINFRA`.

Тестовые характеристики кластера:

* Название — `mymg`.
* Окружение — `PRODUCTION`.
* Защита от непреднамеренного удаления — включена.
* Версия — `{{ versions.tf.latest }}`.
* База данных — `db1`.
* Пользователь — `user1`.
* Пароль — `user1user1`.
* Класс хоста `MONGOD` — `{{ host-class }}`.
* Класс хостов `MONGOINFRA` — `c3-c2-m4`.
* Хранилище на сетевых SSD-дисках — `{{ disk-type-example }}`.
* Размер хранилища — 10 ГБ.

Сетевые характеристики:

* Сеть — `mynet`.
* Группа безопасности — `mymg-sg` с идентификатором `{{ security-group }}`. В {{ TF }} группа создается с правилом, которое разрешает TCP-подключения к кластеру из интернета через порт `{{ port-mmg }}`.

* Подсеть — `mysubnet`. 
* Зона доступности — `{{ region-id }}-a`.
* Диапазон — `10.5.0.0/24` (только для {{ TF }}).

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните команду, чтобы создать кластер {{ mmg-name }} со стандартным шардированием:

  ```bash
  {{ yc-mdb-mg }} cluster create \
     --name mymg \
     --environment production \
     --deletion-protection \
     --mongodb-version {{ versions.cli.latest }} \
     --database name=db1 \
     --user name=user1,password=user1user1 \
     --mongod-resource-preset {{ host-class }} \
     --mongod-disk-type {{ disk-type-example }} \
     --mongod-disk-size 10 \
     --host type=mongod,`
       `zone-id={{ region-id }}-a,`
       `subnet-name=mysubnet \
     --mongoinfra-resource-preset c3-c2-m4 \
     --mongoinfra-disk-type {{ disk-type-example }} \
     --mongoinfra-disk-size 10 \
     --host type=mongoinfra,`
       `zone-id={{ region-id }}-a,`
       `subnet-name=mysubnet \
     --host type=mongoinfra,`
       `zone-id={{ region-id }}-a,`
       `subnet-name=mysubnet \
     --host type=mongoinfra,`
       `zone-id={{ region-id }}-a,`
       `subnet-name=mysubnet \
     --network-name mynet \
     --security-group-ids {{ security-group }}
  ```

- {{ TF }} {#tf}

  Конфигурационный файл для кластера со стандартным шардированием:

  ```hcl
  resource "yandex_mdb_mongodb_cluster" "mymg" {
    name                = "mymg"
    environment         = "PRODUCTION"
    network_id          = yandex_vpc_network.mynet.id
    security_group_ids  = [ yandex_vpc_security_group.mymg-sg.id ]
    deletion_protection = true

    cluster_config {
      version = "{{ versions.tf.latest }}"
    }

    resources_mongod {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 10
    }

    resources_mongoinfra {
      resource_preset_id = "c3-c2-m4"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 10
    }

    host {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongod"
    }

    host {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongoinfra"
    }

    host {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongoinfra"
    }

    host {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongoinfra"
    }

  resource "yandex_mdb_mongodb_database" "db1" {
    cluster_id = yandex_mdb_mongodb_cluster.mymg.id
    name       = "db1"
  }

  resource "yandex_mdb_mongodb_user" "user1" {
    cluster_id = yandex_mdb_mongodb_cluster.mymg.id
    name       = "user1"
    password   = "user1user1"
    permission {
      database_name = "db1"
    }
    depends_on = [
      yandex_mdb_mongodb_database.db1
    ]
  }

  resource "yandex_vpc_network" "mynet" {
    name = "mynet"
  }

  resource "yandex_vpc_security_group" "mymg-sg" {
    name       = "mymg-sg"
    network_id = yandex_vpc_network.mynet.id

    ingress {
      description    = "MongoDB"
      port           = {{ port-mmg }}
      protocol       = "TCP"
      v4_cidr_blocks = [ "0.0.0.0/0" ]
    }
  }

  resource "yandex_vpc_subnet" "mysubnet" {
    name           = "mysubnet"
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.mynet.id
    v4_cidr_blocks = ["10.5.0.0/24"]
  }
  ```

{% endlist %}

#### Расширенное шардирование {#adv-sharding}

Создайте кластер {{ mmg-name }} и сеть для него с несколькими хостами:

* один хост `MONGOD`;
* два хоста `MONGOS`;
* три хоста `MONGOCFG`.

Тестовые характеристики кластера:

* Название — `mymg`.
* Окружение — `PRODUCTION`.
* Защита от непреднамеренного удаления — включена.
* Версия — `{{ versions.tf.latest }}`.
* База данных — `db1`.
* Пользователь — `user1`.
* Пароль — `user1user1`.
* Класс хостов — `{{ host-class }}`.
* Хранилище на сетевых SSD-дисках — `{{ disk-type-example }}`.
* Размер хранилища — 10 ГБ.

Сетевые характеристики:

* Сеть — `mynet`.
* Группа безопасности — `mymg-sg` с идентификатором `{{ security-group }}`. В {{ TF }} группа создается с правилом, которое разрешает TCP-подключения к кластеру из интернета через порт `{{ port-mmg }}`.
* Подсеть — `mysubnet`. 
* Зона доступности — `{{ region-id }}-a`.
* Диапазон — `10.5.0.0/24` (только для {{ TF }}).

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните команду, чтобы создать кластер {{ mmg-name }} с расширенным шардированием:

  ```bash
  {{ yc-mdb-mg }} cluster create \
    --name mymg \
    --environment production \
    --deletion-protection \
    --mongodb-version {{ versions.cli.latest }} \
    --database name=db1 \
    --user name=user1,password=user1user1 \
    --mongod-resource-preset {{ host-class }} \
    --mongod-disk-type {{ disk-type-example }} \
    --mongod-disk-size 10 \
    --host type=mongod,`
      `zone-id={{ region-id }}-a,`
      `subnet-name=mysubnet \
    --mongos-resource-preset {{ host-class }} \
    --mongos-disk-type {{ disk-type-example }} \
    --mongos-disk-size 10 \
    --host type=mongos,`
      `zone-id={{ region-id }}-a,`
      `subnet-name=mysubnet \
    --host type=mongos,`
      `zone-id={{ region-id }}-a,`
      `subnet-name=mysubnet \
    --mongocfg-resource-preset {{ host-class }} \
    --mongocfg-disk-type {{ disk-type-example }} \
    --mongocfg-disk-size 10 \
    --host type=mongocfg,`
      `zone-id={{ region-id }}-a,`
      `subnet-name=mysubnet \
    --host type=mongocfg,`
      `zone-id={{ region-id }}-a,`
      `subnet-name=mysubnet \
    --host type=mongocfg,`
      `zone-id={{ region-id }}-a,`
      `subnet-name=mysubnet \
    --network-name mynet \
    --security-group-ids {{ security-group }}
  ```

- {{ TF }} {#tf}

  Конфигурационный файл для кластера с расширенным шардированием:

  ```hcl
  resource "yandex_mdb_mongodb_cluster" "mymg" {
    name                = "mymg"
    environment         = "PRODUCTION"
    network_id          = yandex_vpc_network.mynet.id
    security_group_ids  = [ yandex_vpc_security_group.mymg-sg.id ]
    deletion_protection = true

    cluster_config {
      version = "{{ versions.tf.latest }}"
    }

    resources_mongod {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 10
    }

    resources_mongos {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 10
    }

    resources_mongocfg {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 10
    }

    host {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongod"
    }

    host {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongos"
    }

    host {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongos"
    }

    host {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongocfg"
    }

    host {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongocfg"
    }

    host {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongocfg"
    }
  }

  resource "yandex_mdb_mongodb_database" "db1" {
    cluster_id = yandex_mdb_mongodb_cluster.mymg.id
    name       = "db1"
  }

  resource "yandex_mdb_mongodb_user" "user1" {
    cluster_id = yandex_mdb_mongodb_cluster.mymg.id
    name       = "user1"
    password   = "user1user1"
    permission {
      database_name = "db1"
    }
    depends_on = [
      yandex_mdb_mongodb_database.db1
    ]
  }

  resource "yandex_vpc_network" "mynet" {
    name = "mynet"
  }

  resource "yandex_vpc_security_group" "mymg-sg" {
    name       = "mymg-sg"
    network_id = yandex_vpc_network.mynet.id

    ingress {
      description    = "MongoDB"
      port           = {{ port-mmg }}
      protocol       = "TCP"
      v4_cidr_blocks = [ "0.0.0.0/0" ]
    }
  }

  resource "yandex_vpc_subnet" "mysubnet" {
    name           = "mysubnet"
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.mynet.id
    v4_cidr_blocks = ["10.5.0.0/24"]
  }
  ```

{% endlist %}
