---
title: Управление резервными копиями MongoDB
description: Вы можете создавать резервные копии и восстанавливать кластеры из имеющихся резервных копий MongoDB. Технология Point-in-Time Recovery (PITR) позволяет восстановить состояние кластера на любой момент времени, начиная от создания резервной копии.
---

# Управление резервными копиями в {{ mmg-name }}

Вы можете создавать [резервные копии](../concepts/backup.md) и восстанавливать кластеры из имеющихся резервных копий.

Также {{ mmg-name }} ежедневно создает автоматическую резервную копию. Вы можете [задать время начала резервного копирования и срок хранения](update.md#change-additional-settings) для нее.

## Восстановить кластер из резервной копии {#restore}

Технология Point-in-Time Recovery (PITR) позволяет восстановить состояние кластера на любой момент времени в интервале от создания самой старой резервной копии до архивации самой свежей коллекции [oplog](https://www.mongodb.com/docs/manual/core/replica-set-oplog/). Подробнее см. в разделе [Резервные копии](../concepts/backup.md).

Например, если операция создания резервной копии завершилась 10.08.2020 в 12:00:00 UTC, текущая дата — 15.08.2020 19:00:00 UTC, а последняя коллекция oplog была сохранена 15.08.2020 в 18:50:00 UTC, кластер может быть восстановлен в любое свое состояние в промежутке времени с 10.08.2020 12:00:01 UTC до 15.08.2020 18:50:00 UTC включительно.

{% note warning %}

PITR не поддерживается для кластеров с включенным [шардированием](../tutorials/sharding.md). Такие кластеры могут быть восстановлены только на момент создания выбранной резервной копии.

{% endnote %}

Восстанавливая кластер из резервной копии, вы создаете новый кластер с данными из резервной копии. Если в каталоге не хватает [ресурсов](../concepts/limits.md) для создания такого кластера, восстановиться из резервной копии не получится. Средняя скорость восстановления из резервной копии — 10 МБайт/с.

Для нового кластера необходимо задать все параметры, обязательные при создании, кроме типа кластера (резервную копию {{ MG }} не получится восстановить как кластер {{ PG }}).

При восстановлении до состояния на текущий момент времени новый кластер будет отражать состояние:

* существующего кластера на момент восстановления;
* удаленного кластера на момент архивации последней коллекции oplog.


Перед началом работы [назначьте](../../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роль [{{ roles.mmg.editor }}](../../iam/roles-reference.md#managed-mongodb-editor) или выше на каталог размещения резервной копии и каталог, где будет развернут новый кластер.


{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы восстановить из резервной копии существующий кластер:

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.

  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}**.

  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) нужной резервной копии и нажмите **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.

      Чтобы восстановить шардированный кластер, используйте [шардированную резервную копию](../concepts/backup.md#size). Такие копии имеют больший размер.

  1. Задайте настройки нового кластера. В списке **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** можно выбрать каталог для нового кластера.

  1. Чтобы восстановить состояние кластера на требуемый момент времени после создания этой резервной копии, задайте нужное значение настройки **{{ ui-key.yacloud.mdb.forms.field_date }}**. Значение можно ввести вручную или выбрать из выпадающего календаря.

      Если оставить настройку без изменений, кластер будет восстановлен в состояние на момент завершения создания резервной копии.

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

  Чтобы восстановить из резервной копии удаленный ранее кластер:

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.

  1. На панели слева выберите ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}**.

  1. Найдите нужную резервную копию по времени создания и идентификатору кластера. В колонке **{{ ui-key.yacloud.common.id }}** содержатся идентификаторы в формате `<идентификатор_кластера>:<идентификатор_резервной_копии>`.

      Если вы хотите восстановить шардированный кластер, найдите [шардированную резервную копию](../concepts/backup.md#size). Такие копии имеют больший размер.

  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) нужной резервной копии и нажмите **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.

  1. Задайте настройки нового кластера. В списке **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** можно выбрать каталог для нового кластера.

  1. Чтобы восстановить состояние кластера на требуемый момент времени после создания этой резервной копии, задайте нужное значение настройки **{{ ui-key.yacloud.mdb.forms.field_date }}**. Значение можно ввести вручную или выбрать из выпадающего календаря.

      Если оставить настройку без изменений, кластер будет восстановлен в состояние на момент завершения создания резервной копии.

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

  {{ mmg-name }} запустит операцию создания кластера из резервной копии.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы восстановить кластер из резервной копии:

  1. Посмотрите описание команды CLI для восстановления кластера {{ MG }}:

      ```bash
      {{ yc-mdb-mg }} cluster restore --help
      ```

  1. Получите список доступных резервных копий кластеров {{ MG }}:

     ```bash
     {{ yc-mdb-mg }} backup list
     ```

     Результат:

     ```text
     +--------------------------+---------------------+----------------------+---------------------+--------+-----------+
     |            ID            |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      |  SIZE  |   TYPE    |
     +--------------------------+---------------------+----------------------+---------------------+--------+-----------+
     | c9qlk4v13uq7********:... | 2020-08-10 12:00:00 | c9qlk4v13uq7******** | 2020-08-10 11:55:17 | 3.3 KB | AUTOMATED |
     | ...                                                                                         |                    |
     +--------------------------+---------------------+----------------------+---------------------+--------+-----------+
     ```

     Время завершения создания резервной копии указано в столбце `CREATED AT` списка доступных резервных копий в формате `yyyy-mm-dd hh:mm:ss` (`2020-08-10 12:00:00` в примере выше). Вы можете восстановить состояние кластера на любой момент времени, начиная от создания резервной копии.

  1. Выполните команду создания нового кластера из резервной копии (в примерах приведены только некоторые параметры).

      
      Для нешардированного кластера:

      ```bash
      {{ yc-mdb-mg }} cluster restore \
         --backup-id <идентификатор_резервной_копии> \
         --recovery-target-timestamp <момент_времени> \
         --mongodb-version <версия_{{ MG }}> \
         --name <имя_нового_кластера> \
         --environment <окружение> \
         --network-name <имя_сети> \
         --host zone-id=<зона_доступности>,`
               `subnet-id=<идентификатор_подсети> \
         --mongod-resource-preset <класс_хоста> \
         --mongod-disk-size <размер_хранилища_ГБ> \
         --mongod-disk-type <тип_диска> \
         --performance-diagnostics=<включить_диагностику>
      ```

      Для шардированного кластера:

      ```bash
      {{ yc-mdb-mg }} cluster restore \
         --backup-id <идентификатор_резервной_копии> \
         --recovery-target-timestamp <момент_времени> \
         --mongodb-version <версия_{{ MG }}> \
         --name <имя_нового_кластера> \
         --environment <окружение> \
         --network-name <имя_сети> \
         --host zone-id=<зона_доступности>,`
               `subnet-id=<идентификатор_подсети>,`
               `type=mongod,`
               `shard-name=<имя_шарда> \
         --mongod-resource-preset <класс_хоста> \
         --mongod-disk-size <размер_хранилища_ГБ> \
         --mongod-disk-type <тип_диска> \
         --host zone-id=<зона_доступности>,`
               `subnet-id=<идентификатор_подсети>,`
               `type=<тип_хоста> \
         ...
         --host zone-id=<зона_доступности>,`
               `subnet-id=<идентификатор_подсети>,`
               `type=<тип_хоста> \
         --<тип_хоста>-resource-preset <класс_хоста> \
         --<тип_хоста>-disk-size <размер_хранилища_ГБ> \
         --<тип_хоста>-disk-type <тип_диска> \
         --performance-diagnostics=<включить_диагностику>
      ```


      Где:

      * `--backup-id` — идентификатор резервной копии. Чтобы восстановить шардированный кластер, укажите идентификатор [шардированной резервной копии](../concepts/backup.md#size). Такие копии имеют больший размер. Чтобы узнать идентификатор, [получите список резервных копий в каталоге](#list-backups).

      * `--recovery-target-timestamp` — момент времени, на который нужно восстановить состояние кластера {{ MG }}, в формате [UNIX time](https://ru.wikipedia.org/wiki/Unix-время). Если параметр не задан, восстановится состояние кластера на момент завершения создания резервной копии.
      * `--environment` — окружение: `PRESTABLE` или `PRODUCTION`.

      
      * `--mongod-disk-type` — тип диска: `network-hdd`, `network-ssd` или `network-ssd-io-m3`.


      * `--<тип_хоста>-resource-preset`, `--<тип_хоста>-disk-size`, `--<тип_хоста>-disk-type` — параметры хостов, которые управляют шардированием в кластере. `<тип_хоста>` может принимать значения: `mongoinfra`, `mongocfg`, `mongos`.

      * `--performance-diagnostics` — включить диагностику производительности кластера: `true` или `false`.

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "folderId": "<идентификатор_каталога>",
          "backupId": "<идентификатор_резервной_копии>",
          "name": "<имя_нового_кластера>",
          "environment": "<окружение>",
          "networkId": "<идентификатор_сети>",
          "recoveryTargetSpec": {
            "timestamp": "<время>"
          },
          "configSpec": {
            "version": "<версия_{{ MG }}>",
            "mongodb": {
              "<тип_хоста_{{ MG }}>": {
                "resources": {
                  "resourcePresetId": "<класс_хостов>",
                  "diskSize": "<размер_хранилища_в_байтах>",
                  "diskTypeId": "<тип_диска>"
                }
              },
              ...
              "<тип_хоста_{{ MG }}>": {
                "resources": {
                  "resourcePresetId": "<класс_хостов>",
                  "diskSize": "<размер_хранилища_в_байтах>",
                  "diskTypeId": "<тип_диска>"
                }
              }
            }
          },
          "hostSpecs": [
            {
              "zoneId": "<зона_доступности>",
              "subnetId": "<идентификатор_подсети>",
              "assignPublicIp": <разрешить_публичный_доступ_к_хосту>,
              "type": "<тип_хоста>",
              "shardName": "<имя_шарда>",
              "hidden": <скрыть_хост>,
              "secondaryDelaySecs": "<задержка_в_секундах>",
              "priority": "<приоритет_назначения_хоста_мастером>",
              "tags": "<метки_хоста>"
            }
          ]
        }
        ```

        Где:

        * `folderId` — идентификатор каталога. Его можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
        * `backupId` — идентификатор резервной копии. Чтобы восстановить шардированный кластер, укажите идентификатор [шардированной резервной копии](../concepts/backup.md#size). Такие копии имеют больший размер. Чтобы узнать идентификатор, [получите список резервных копий в каталоге](#list-backups).
        * `name` — имя нового кластера.
        * `environment` — окружение кластера: `PRODUCTION` или `PRESTABLE`.
        * `networkId` — идентификатор [сети](../../vpc/concepts/network.md#network), в которой будет размещен кластер.
        * `recoveryTargetSpec.timestamp` — момент времени, на который нужно восстановить состояние кластера {{ MG }}, в формате [UNIX time](https://ru.wikipedia.org/wiki/Unix-время). Если параметр не задан, восстановится состояние кластера на момент завершения создания резервной копии.

        * `configSpec` — настройки кластера:

          * `version` — версия {{ MG }}: 5.0, 6.0 или 7.0.
          * Тип хоста {{ MG }} — зависит от [типа шардирования](../concepts/sharding.md). Доступные значения: `mongod`, `mongocfg`, `mongos`, `mongoinfra`. Если кластер нешардированный, укажите `mongod`.
            
            * `resources` — ресурсы кластера:

              * `resourcePresetId` — [класс хостов](../concepts/instance-types.md).
              * `diskSize` — размер диска в байтах.
              * `diskTypeId` — [тип диска](../concepts/storage.md).

        * `hostSpecs` — настройки хостов кластера в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

          * `zoneId` — [зона доступности](../../overview/concepts/geo-scope.md).
          * `subnetId` — [идентификатор подсети](../../vpc/concepts/network.md#subnet).
          * `assignPublicIp` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.
          * `type`— тип хоста в шардированном кластере: `MONGOD`, `MONGOINFRA`, `MONGOS` или `MONGOCFG`. Если кластер нешардированный, укажите `MONGOD`.
          * `shardName` — имя шарда в шардированном кластере.
          * `hidden`— будет ли хост виден (`false`) или скрыт (`true`).
          * `secondaryDelaySecs` — время отставания хоста от мастера.
          * `priority` — приоритет назначения хоста мастером при [выходе из строя основного мастера](../concepts/replication.md#master-failover).
          * `tags`— метки хоста.

    1. Воспользуйтесь методом [Cluster.Restore](../api-ref/Cluster/restore.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters:restore' \
            --data "@body.json"
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/restore.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "folder_id": "<идентификатор_каталога>",
          "backup_id": "<идентификатор_резервной_копии>",
          "name": "<имя_нового_кластера>",
          "environment": "<окружение>",
          "network_id": "<идентификатор_сети>",
          "recovery_target_spec": {
            "timestamp": "<время>"
          },
          "config_spec": {
            "version": "<версия_{{ MG }}>",
            "mongodb": {
              "<тип_хоста_{{ MG }}>": {
                "resources": {
                  "resource_preset_id": "<класс_хостов>",
                  "disk_size": "<размер_хранилища_в_байтах>",
                  "disk_type_id": "<тип_диска>"
                }
              },
              ...
              "<тип_хоста_{{ MG }}>": {
                "resources": {
                  "resource_preset_id": "<класс_хостов>",
                  "disk_size": "<размер_хранилища_в_байтах>",
                  "disk_type_id": "<тип_диска>"
                }
              }
            }
          },
          "host_specs": [
            {
              "zone_id": "<зона_доступности>",
              "subnet_id": "<идентификатор_подсети>",
              "assign_public_ip": <разрешить_публичный_доступ_к_хосту>,
              "type": "<тип_хоста>",
              "shard_name": "<имя_шарда>",
              "hidden": <скрыть_хост>,
              "secondary_delay_secs": "<задержка_в_секундах>",
              "priority": "<приоритет_назначения_хоста_мастером>",
              "tags": "<метки_хоста>"
            }
          ]
        }
        ```

        Где:

        * `folder_id` — идентификатор каталога. Его можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
        * `backup_id` — идентификатор резервной копии. Чтобы восстановить шардированный кластер, укажите идентификатор [шардированной резервной копии](../concepts/backup.md#size). Такие копии имеют больший размер. Чтобы узнать идентификатор, [получите список резервных копий в каталоге](#list-backups).
        * `name` — имя нового кластера.
        * `environment` — окружение кластера: `PRODUCTION` или `PRESTABLE`.
        * `network_id` — идентификатор [сети](../../vpc/concepts/network.md#network), в которой будет размещен кластер.
        * `recovery_target_spec.timestamp` — момент времени, на который нужно восстановить состояние кластера {{ MG }}, в формате [UNIX time](https://ru.wikipedia.org/wiki/Unix-время). Если параметр не задан, восстановится состояние кластера на момент завершения создания резервной копии.

        * `config_spec` — настройки кластера:

          * `version` — версия {{ MG }}: 5.0, 6.0 или 7.0.
          * Тип хоста {{ MG }} — зависит от [типа шардирования](../concepts/sharding.md). Доступные значения: `mongod`, `mongocfg`, `mongos`, `mongoinfra`. Если кластер нешардированный, укажите `mongod`.
            
            * `resources` — ресурсы кластера:
            
              * `resource_preset_id` — [класс хостов](../concepts/instance-types.md).
              * `disk_size` — размер диска в байтах.
              * `disk_type_id` — [тип диска](../concepts/storage.md).

        * `host_specs` — настройки хостов кластера в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

          * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md).
          * `subnet_id` — [идентификатор подсети](../../vpc/concepts/network.md#subnet).
          * `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.
          * `type`— тип хоста в шардированном кластере: `MONGOD`, `MONGOINFRA`, `MONGOS` или `MONGOCFG`. Если кластер нешардированный, укажите `MONGOD`.
          * `shard_name` — имя шарда в шардированном кластере.
          * `hidden`— будет ли хост виден (`false`) или скрыт (`true`).
          * `secondary_delay_secs` — время отставания хоста от мастера.
          * `priority` — приоритет назначения хоста мастером при [выходе из строя основного мастера](../concepts/replication.md#master-failover).
          * `tags`— метки хоста.

    1. Воспользуйтесь вызовом [ClusterService.Restore](../api-ref/grpc/Cluster/restore.md#yandex.cloud.mdb.mongodb.v1.HostSpec) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.mongodb.v1.ClusterService.Restore \
            < body.json
        ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/restore.md#yandex.cloud.operation.Operation).
          

{% endlist %}

## Создать резервную копию {#create-backup}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.backups.button_create }}**.

  {% include [no-prompt](../../_includes/mdb/backups/no-prompt.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать резервную копию кластера:

  1. Посмотрите описание команды CLI для создания резервной копии {{ MG }}:

      ```bash
      {{ yc-mdb-mg }} cluster backup --help
      ```

  1. Запросите создание резервной копии, указав идентификатор или имя кластера:

      ```bash
      {{ yc-mdb-mg }} cluster backup <имя_или_идентификатор_кластера>
      ```

      Идентификатор и имя кластера можно получить со [списком кластеров](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.Backup](../api-ref/Cluster/backup.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<идентификатор_кластера>:backup'
      ```

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/backup.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService.Backup](../api-ref/grpc/Cluster/backup.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mongodb.v1.ClusterService.Backup
      ```

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/backup.md#yandex.cloud.operation.Operation).

{% endlist %}

{% include [backup-warning](../../_includes/mdb/backups/backup-create-warning.md) %}

## Получить список резервных копий {#list-backups}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы получить список резервных копий кластера:

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}**.

  Чтобы получить список всех резервных копий в каталоге:

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}**.

  В этих списках содержится следующая информация:

  * Имя резервной копии.
  * Шард-источник.
  * Размер резервной копии.
  * Тип резервной копии: автоматическая (`Automated`) или ручная (`Manual`).
  * Время начала создания резервной копии по UTC (Coordinated Universal Time).
  * Время окончания создания резервной копии по UTC.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список резервных копий кластеров {{ MG }}, доступных в каталоге по умолчанию, выполните команду:

  ```bash
  {{ yc-mdb-mg }} backup list
  ```

  Результат:

  ```text
  +--------------------------+---------------------+----------------------+---------------------+--------+-----------+
  |            ID            |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      |  SIZE  |   TYPE    |
  +--------------------------+---------------------+----------------------+---------------------+--------+-----------+
  | c9qlk4v13uq7********:... | 2020-08-10 12:00:00 | c9qlk4v13uq7******** | 2020-08-10 11:55:17 | 3.3 KB | AUTOMATED |
  | c9qpm90p3pcg********:... | 2020-08-09 22:01:04 | c9qpm90p3pcg******** | 2020-08-09 21:30:00 | 30 KB  | MANUAL    |
  +--------------------------+---------------------+----------------------+---------------------+--------+-----------+
  ```

  В выведенной таблице содержится следующая информация:
  * Идентификатор резервной копии.
  * Время окончания создания резервной копии по UTC (Coordinated Universal Time).
  * Идентификатор кластера, для которого создавалась эта резервная копия.
  * Время начала создания резервной копии по UTC.
  * Размер резервной копии.
  * Тип резервной копии: автоматическая (`AUTOMATED`) или ручная (`MANUAL`).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Чтобы получить список резервных копий кластера:

     1. Воспользуйтесь методом [Cluster.ListBackups](../api-ref/Cluster/listBackups.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
           --request GET \
           --header "Authorization: Bearer $IAM_TOKEN" \
           --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<идентификатор_кластера>/backups'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

     1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listBackups.md#yandex.cloud.mdb.mongodb.v1.ListClusterBackupsResponse).

  1. Чтобы получить список резервных копий всех кластеров в каталоге:

     1. Воспользуйтесь методом [Backup.List](../api-ref/Backup/list.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
           --request GET \
           --header "Authorization: Bearer $IAM_TOKEN" \
           --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/backups'
           --url-query folderId=<идентификатор_каталога>
        ```

        
        Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


     1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Backup/list.md#yandex.cloud.mdb.mongodb.v1.ListBackupsResponse).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Чтобы получить список резервных копий кластера:

      1. Воспользуйтесь вызовом [ClusterService.ListBackups](../api-ref/grpc/Cluster/listBackups.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

          ```bash
          grpcurl \
              -format json \
              -import-path ~/cloudapi/ \
              -import-path ~/cloudapi/third_party/googleapis/ \
              -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
              -rpc-header "Authorization: Bearer $IAM_TOKEN" \
              -d '{
                    "cluster_id": "<идентификатор_кластера>"
                  }' \
              {{ api-host-mdb }}:{{ port-https }} \
              yandex.cloud.mdb.mongodb.v1.ClusterService.ListBackups
          ```

          Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

      1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listBackups.md#yandex.cloud.mdb.mongodb.v1.ListClusterBackupsResponse).

  1. Чтобы получить список резервных копий всех кластеров в каталоге:

      1. Воспользуйтесь вызовом [BackupService.List](../api-ref/grpc/Backup/list.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

          ```bash
          grpcurl \
              -format json \
              -import-path ~/cloudapi/ \
              -import-path ~/cloudapi/third_party/googleapis/ \
              -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/backup_service.proto \
              -rpc-header "Authorization: Bearer $IAM_TOKEN" \
              -d '{
                    "folder_id": "<идентификатор_каталога>"
                  }' \
              {{ api-host-mdb }}:{{ port-https }} \
              yandex.cloud.mdb.mongodb.v1.BackupService.List
          ```

          
          Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


      1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Backup/list.md#yandex.cloud.mdb.mongodb.v1.ListBackupsResponse).


{% endlist %}

## Получить информацию о резервной копии {#get-backup}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы получить информацию о резервной копии существующего кластера:
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}**.

  Чтобы получить информацию о резервной копии удаленного ранее кластера:
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить данные о резервной копии кластера {{ MG }}, выполните команду:

  ```bash
  {{ yc-mdb-mg }} backup get <идентификатор_резервной_копии>
  ```

  Идентификатор резервной копии можно получить со [списком резервных копий](#list-backups).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Backup.Get](../api-ref/Backup/get.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/backups/<идентификатор_резервной_копии>'
     ```

     Идентификатор резервной копии можно запросить со [списком резервных копий](#list-backups).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Backup/get.md#yandex.cloud.mdb.mongodb.v1.Backup).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [BackupService.Get](../api-ref/grpc/Backup/get.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/backup_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "backup_id": "<идентификатор_резервной_копии>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.mongodb.v1.BackupService.Get
     ```

     Идентификатор резервной копии можно запросить со [списком резервных копий](#list-backups).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Backup/get.md#yandex.cloud.mdb.mongodb.v1.Backup).

{% endlist %}

## Задать срок хранения автоматических резервных копий {#set-backup-retain}

{% list tabs group=instructions %}

- Консоль управления {#console}

  В [консоли управления]({{ link-console-main }}) задать срок хранения автоматических резервных копий можно при [создании](cluster-create.md) или [изменении кластера](update.md).

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы задать срок хранения автоматических резервных копий, передайте нужное значение в аргументе `--backup-retain-period-days` команды изменения кластера:

    ```bash
    {{ yc-mdb-mg }} cluster update <имя_или_идентификатор_кластера> \
       --backup-retain-period-days=<срок_хранения_в_днях>
    ```

  Допустимые значения: от `7` до `35`. Значение по умолчанию — `7`.

  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера {{ MG }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mmg }}).

    1. Добавьте к описанию кластера {{ MG }} блок `backup_retain_period_days` в секции `cluster_config`:

        ```hcl
          resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
            ...
            cluster_config {
              ...
              backup_retain_period_days = <срок_хранения_в_днях>
              }
              ...
            }
            ...
        ```

       Где `backup_retain_period_days` — срок хранения автоматических резервных копий. 
       
       Допустимые значения: от `7` до `35`. Значение по умолчанию — `7`.

  1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

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
          --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<идентификатор_кластера>' \
          --data '{
                    "updateMask": "configSpec.backupRetainPeriodDays",
                    "configSpec": {
                      "backupRetainPeriodDays": <время_хранения_резервных_копий_в_днях>
                    }
                  }'
      ```

      Где:

      * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

          В данном случае передается только один параметр.

      * `configSpec.backupRetainPeriodDays` — срок хранения автоматических резервных копий в днях.

          Допустимые значения — от `7` до `35`. Значение по умолчанию — `7`.

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
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "update_mask": {
                  "paths": [
                    "config_spec.backup_retain_period_days"
                  ]
                },
                "config_spec": {
                  "backup_retain_period_days": <время_хранения_резервных_копий_в_днях>
                }
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mongodb.v1.ClusterService.Update
      ```

      Где:

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

          В данном случае передается только один параметр.

      * `config_spec.backup_retain_period_days` — срок хранения автоматических резервных копий в днях.

          Допустимые значения — от `7` до `35`. Значение по умолчанию — `7`.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.mongodb.v1.Cluster).

{% endlist %}         

## Примеры {#examples}

Создайте новый кластер {{ mmg-name }} из резервной копии с тестовыми характеристиками:


* Резервная копия для восстановления: `c9qlk4v13uq7********:...`.
* Момент времени, на который нужно восстановить: `1597060810` (`2020-08-10 12:00:10`).
* Версия: `6.0`.
* Имя нового кластера: `mynewmg`.
* Окружение: `PRODUCTION`.
* Сеть: `{{ network-name }}`.
* Один хост класса `{{ host-class }}` в зоне доступности `{{ region-id }}-a` и в подсети `b0rcctk2rvtr********`.
* Хранилище на сетевых SSD-дисках (`{{ disk-type-example }}`) размером 20 ГБ.     
* С базами данных и пользователями, которые существовали в кластере на момент восстановления.


{% list tabs group=instructions %}

- CLI {#cli}

  Выполните следующую команду:

  
  ```bash
  {{ yc-mdb-mg }} cluster restore \
     --backup-id c9qlk4v13uq7********:... \
     --recovery-target-timestamp 1597060810 \
     --mongodb-version 6.0 \
     --name mynewmg \
     --environment PRODUCTION \
     --network-name {{ network-name }} \
     --host {{ host-net-example }} \
     --mongod-resource-preset {{ host-class }} \
     --mongod-disk-size 20 \
     --mongod-disk-type {{ disk-type-example }}
  ```


{% endlist %}
