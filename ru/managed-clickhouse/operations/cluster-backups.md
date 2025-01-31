---
title: Управление резервными копиями {{ CH }}
description: Вы можете создавать резервные копии и восстанавливать кластеры из имеющихся резервных копий {{ CH }}. Восстанавливая кластер из резервной копии, вы создаете новый кластер с данными из резервной копии. Если в облаке не хватает ресурсов для создания такого кластера, восстановиться из резервной копии не получится.
---

# Управление резервными копиями в {{ mch-name }}


Вы можете создавать [резервные копии](../concepts/backup.md) и восстанавливать кластеры из имеющихся резервных копий.

Также {{ mch-name }} ежедневно создает автоматическую резервную копию. Вы можете [задать время начала резервного копирования](#set-backup-window) и [срок хранения](#set-backup-retain) для нее.

## Создать резервную копию {#create-backup}

{% note warning %}

Для создания резервной копии используется случайный хост-реплика. Если нет консистентности данных между хостами кластера, то его восстановление из резервной копии не гарантирует полного восстановления данных. Подробнее см. в разделе [Резервные копии](../concepts/backup.md).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_backups }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.backups.button_create }}**.

  {% include [no-prompt](../../_includes/mdb/backups/no-prompt.md) %}

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы создать резервную копию кластера:
  
  1. Посмотрите описание команды CLI для создания резервной копии {{ CH }}:
  
      ```bash
      {{ yc-mdb-ch }} cluster backup --help
      ```
  
  1. Запросите создание резервной копии, указав имя или идентификатор кластера:
  
      ```bash
      {{ yc-mdb-ch }} cluster backup <имя_или_идентификатор_кластера>
      ```
  
      Имя и идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.Backup](../api-ref/Cluster/backup.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>:backup'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/backup.md#responses).

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
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Backup
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/backup.md#yandex.cloud.operation.Operation).

{% endlist %}

{% include [backup-warning](../../_includes/mdb/backups/backup-create-warning.md) %}

## Восстановить кластер из резервной копии {#restore}

Восстанавливая кластер из резервной копии, вы создаете новый кластер с данными из резервной копии. Если в облаке не хватает [ресурсов](../concepts/limits.md) для создания такого кластера, восстановиться из резервной копии не получится. Средняя скорость восстановления из резервной копии — 10 МБайт/с на каждое ядро БД.

Вы можете восстановить как отдельный [шард](../concepts/sharding.md), так и весь кластер целиком. Восстановить кластер целиком можно только с помощью CLI или API.


Перед началом работы [убедитесь](../../iam/operations/roles/get-assigned-roles.md), что вашему аккаунту в {{ yandex-cloud }} назначена роль [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) или выше. Она нужна, если вы восстанавливаете из резервной копии кластер с привязкой к [сервисному аккаунту](../../iam/concepts/users/service-accounts.md).


{% include [mch-mergetree-conversion](../../_includes/mdb/mch-restore-tables-conversion-alert.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы восстановить из резервной копии существующий кластер:
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_backups }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) для нужной резервной копии, затем нажмите **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
  1. Если необходимо, измените настройки нового кластера. В списке **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** можно выбрать каталог для нового кластера.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

  Чтобы восстановить из резервной копии удаленный ранее кластер:
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.clickhouse.switch_backups }}**.
  1. Найдите нужную резервную копию по времени создания и идентификатору кластера. В колонке **{{ ui-key.yacloud.common.id }}** содержатся идентификаторы в формате `<идентификатор_кластера>:<идентификатор_резервной_копии>`.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) для нужной резервной копии, затем нажмите **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
  1. Если необходимо, измените настройки нового кластера. В списке **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** можно выбрать каталог для нового кластера.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

  {{ mch-name }} запустит операцию создания кластера из резервной копии.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы восстановить кластер из резервной копии:

  1. Посмотрите описание команды CLI для восстановления кластера {{ CH }}:

      ```bash
      {{ yc-mdb-ch }} cluster restore --help
      ```

  1. Получите список доступных резервных копий кластеров {{ CH }}:

      ```bash
      {{ yc-mdb-ch }} backup list
      ```

      ```text
      +--------------------------+---------------------+----------------------+---------------------+-------------+-------+-----------+
      |            ID            |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      | SHARD NAMES | SIZE  |   TYPE    |
      +--------------------------+---------------------+----------------------+---------------------+-------------+-------+-----------+
      | c9qud5etkq19********:... | 2023-12-08 00:09:17 | c9qud5etkq19******** | 2023-12-08 00:08:06 | shard1      | 30 KB | AUTOMATED |
      | ...                      |                     |                      |                     |             |       |           |
      +--------------------------+---------------------+----------------------+---------------------+-------------+-------+-----------+
      ```

  1. Чтобы восстановить отдельный шард, передайте идентификатор одной резервной копии:

      
      ```bash
      {{ yc-mdb-ch }} cluster restore \
         --backup-id=<идентификатор_резервной_копии> \
         --name=<имя_кластера> \
         --environment=<окружение> \
         --network-name=<имя_сети> \
         --host type=<тип_хоста>,`
               `zone-id=<зона_доступности>,`
               `subnet-id=<идентификатор_подсети> \
         --clickhouse-disk-size=<размер_хранилища_ГБ> \
         --clickhouse-disk-type=<тип_диска> \
         --clickhouse-resource-preset=<класс_хоста>
      ```


      Где:

      * `--backup-id` — идентификатор [резервной копии](../concepts/backup.md).
      * `--name` — имя кластера.
      * `--environment` — окружение:

          * `PRODUCTION` — для стабильных версий ваших приложений.
          * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.

      * `--network-name` — [имя сети](../../vpc/concepts/network.md#network).
      * `--host` — параметры хоста:

          * `type` — тип хоста: `clickhouse` или `zookeeper`.
          * `zone-id` — [зона доступности](../../overview/concepts/geo-scope.md).
          * `subnet-id` — [идентификатор подсети](../../vpc/concepts/network.md#subnet). Необходимо указывать, если в выбранной зоне доступности создано две или больше подсетей.

      * `--resource-preset` — [класс хоста](../concepts/instance-types.md#available-flavors).
      * `--disk-size` — размер хранилища в гигабайтах.
      * `--disk-type` — [тип диска](../concepts/storage.md):

          
          * `network-hdd`;
          * `network-ssd`;

          * `local-ssd`;
          * `network-ssd-nonreplicated`;
          * `network-ssd-io-m3`.


  1. Чтобы восстановить весь кластер целиком, передайте идентификаторы резервных копий всех шардов кластера:

      ```bash
      {{ yc-mdb-ch }} cluster restore \
         --backup-id=<список_идентификаторов_резервных_копий_всех_шардов> \
         ...
      ```

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.Restore](../api-ref/Cluster/restore.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        1. Создайте файл `body.json` и добавьте в него следующее содержимое:

            ```json
            {
              "backupId": "<идентификатор_резервной_копии>",
              "additionalBackupIds": [
                <список_дополнительных_идентификаторов_резервных_копий>
              ],
              "name": "<имя_кластера>",
              "environment": "<окружение>",
              "configSpec": { <конфигурация_кластера> },
              "hostSpecs": [
                {
                  "type": "<тип_хоста>",
                  "zoneId": "<зона_доступности>",
                  "subnetId": "<идентификатор_подсети>",
                  "shardName": "<имя_шарда>",
                  "assignPublicIp": <публичный_доступ_к_хосту>
                },
                { <аналогичный_набор_настроек_для_хоста_2> },
                { ... },
                { <аналогичный_набор_настроек_для_хоста_N> }
              ],
              "folderId": "<идентификатор_каталога>",
              "networkId": "<идентификатор_сети>",
              "serviceAccountId": "<идентификатор_сервисного аккаунта>",
              "securityGroupIds": [
                <список_идентификаторов_групп_безопасности>
              ],
              "deletionProtection": <защита_от_удаления>
            }
            ```

            Где:

            * `backupId` — идентификатор резервной копии.

                Будет восстановлен шард, для которого была создана эта резервная копия.

            * `additionalBackupIds` — массив, содержащий список дополнительных идентификаторов резервных копий.

                Будут восстановлены шарды, для которых были созданы эти резервные копии. Чтобы восстановить весь кластер целиком, передайте идентификаторы резервных копий всех шардов кластера.

            * `name` — имя кластера.
            * `environment` — окружение:

                * `PRODUCTION` — для стабильных версий ваших приложений.
                * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.

            * `configSpec` — конфигурация кластера {{ CH }}. Подробное описание параметров см. в описании метода [Cluster.restore](../api-ref/Cluster/restore.md).
            * `hostSpecs` — массив, содержащий настройки создаваемых хостов. Один элемент массива содержит настройки для одного хоста и имеет следующую структуру:

                * `type` — тип хоста.
                * `zoneId` — зона доступности.
                * `subnetId` — идентификатор подсети.
                * `shardName` — имя шарда.
                * `assignPublicIp` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.

            * `folderId` — идентификатор каталога, в котором будет создан кластер.
            * `networkId` — идентификатор сети, в которой будет создан кластер.
            * `serviceAccountId` — идентификатор сервисного аккаунта.
            * `securityGroupIds` — массив, содержащий список идентификаторов групп безопасности.
            * `deletionProtection` — опция, которая управляет защитой кластера, его баз данных и пользователей от непреднамеренного удаления.

                Включенная защита от удаления не помешает подключиться вручную и удалить содержимое базы данных.

            Идентификатор резервной копии можно запросить со [списком резервных копий в каталоге](#list-backups).

        1. Выполните запрос:

            ```bash
            curl \
                --request POST \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters:restore' \
                --data "@body.json"
            ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/restore.md#responses).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService.Restore](../api-ref/grpc/Cluster/restore.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        1. Создайте файл `body.json` и добавьте в него следующее содержимое:

            ```json
            {
              "backup_id": "<идентификатор_резервной_копии>",
              "additional_backup_ids": [
                <список_дополнительных_идентификаторов_резервных_копий>
              ],
              "name": "<имя_кластера>",
              "environment": "<окружение>",
              "config_spec": { <конфигурация_кластера> },
              "host_specs": [
                {
                  "type": "<тип_хоста>",
                  "zone_id": "<зона_доступности>",
                  "subnet_id": "<идентификатор_подсети>",
                  "shard_name": "<имя_шарда>",
                  "assign_public_ip": <публичный_доступ_к_хосту>
                },
                { <аналогичный_набор_настроек_для_хоста_2> },
                { ... },
                { <аналогичный_набор_настроек_для_хоста_N> }
              ],
              "folder_id": "<идентификатор_каталога>",
              "network_id": "<идентификатор_сети>",
              "service_account_id": "<идентификатор_сервисного аккаунта>",
              "security_group_ids": [
                <список_идентификаторов_групп_безопасности>
              ],
              "deletion_protection": <защита_от_удаления>
            }
            ```

            Где:

            * `backup_id` — идентификатор резервной копии.

                Будет восстановлен шард, для которого была создана эта резервная копия.

            * `additional_backup_ids` — массив, содержащий список дополнительных идентификаторов резервных копий.

                Будут восстановлены шарды, для которых были созданы эти резервные копии. Чтобы восстановить весь кластер целиком, передайте идентификаторы резервных копий всех шардов кластера.

            * `name` — имя кластера.
            * `environment` — окружение:

                * `PRODUCTION` — для стабильных версий ваших приложений.
                * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.

            * `config_spec` — конфигурация кластера {{ CH }}. Подробное описание параметров см. в описании вызова [ClusterService/Restore](../api-ref/grpc/Cluster/restore.md).
            * `host_specs` — массив, содержащий настройки создаваемых хостов. Один элемент массива содержит настройки для одного хоста и имеет следующую структуру:

                * `type` — тип хоста.
                * `zone_id` — зона доступности.
                * `subnet_id` — идентификатор подсети.
                * `shard_name` — имя шарда.
                * `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.

            * `folder_id` — идентификатор каталога, в котором будет создан кластер.
            * `network_id` — идентификатор сети, в которой будет создан кластер.
            * `service_account_id` — идентификатор сервисного аккаунта.
            * `security_group_ids` — массив, содержащий список идентификаторов групп безопасности.
            * `deletion_protection` — опция, которая управляет защитой кластера, его баз данных и пользователей от непреднамеренного удаления.

                Включенная защита от удаления не помешает подключиться вручную и удалить содержимое базы данных.

            Идентификатор резервной копии можно запросить со [списком резервных копий в каталоге](#list-backups).

        1. Выполните запрос:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d @ \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.clickhouse.v1.ClusterService.Restore \
                < body.json
            ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/restore.md#yandex.cloud.operation.Operation).

{% endlist %}

## Получить список резервных копий {#list-backups}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы получить список резервных копий кластера:
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_backups }}**.

  Чтобы получить список всех резервных копий в каталоге:
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.clickhouse.switch_backups }}**.

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

  Чтобы получить список резервных копий кластеров {{ CH }}, доступных в каталоге по умолчанию, выполните команду:

  ```bash
  {{ yc-mdb-ch }} backup list
  ```

  ```text
  +--------------------------+---------------------+----------------------+---------------------+-------------+-------+-----------+
  |            ID            |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      | SHARD NAMES | SIZE  |   TYPE    |
  +--------------------------+---------------------+----------------------+---------------------+-------------+-------+-----------+
  | c9qud5etkq19********:... | 2023-12-08 00:09:17 | c9qud5etkq19******** | 2023-12-08 00:08:06 | shard1      | 30 KB | AUTOMATED |
  | c9qud5etkq19********:... | 2023-12-07 08:17:04 | c9qud5etkq19******** | 2023-12-07 08:15:54 | shard1      | 30 KB | MANUAL    |
  +--------------------------+---------------------+----------------------+---------------------+-------------+-------+-----------+
  ```

  В выведенной таблице содержится следующая информация:

  * Идентификатор резервной копии.
  * Время окончания создания резервной копии по UTC (Coordinated Universal Time).
  * Идентификатор кластера, для которого создавалась эта резервная копия.
  * Время начала создания резервной копии по UTC.
  * Имя шарда-источника.
  * Размер резервной копии.
  * Тип резервной копии: автоматическая (`AUTOMATED`) или ручная (`MANUAL`).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Чтобы получить список резервных копий кластера {{ CH }}:

        1. Воспользуйтесь методом [Cluster.ListBackups](../api-ref/Cluster/listBackups.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/backups'
            ```

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listBackups.md#responses).

    1. Чтобы получить список резервных копий всех кластеров {{ CH }} в каталоге:

        1. Воспользуйтесь методом [Backup.List](../api-ref/Backup/list.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/backups' \
                --url-query folderId=<идентификатор_каталога>
            ```

            
            Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Backup/list.md#responses).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Чтобы получить список резервных копий кластера {{ CH }}:

        1. Воспользуйтесь вызовом [ClusterService.ListBackups](../api-ref/grpc/Cluster/listBackups.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                        "cluster_id": "<идентификатор_кластера>"
                    }' \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.clickhouse.v1.ClusterService.ListBackups
            ```

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listBackups.md#yandex.cloud.mdb.clickhouse.v1.ListClusterBackupsResponse).

    1. Чтобы получить список резервных копий всех кластеров {{ CH }} в каталоге:

        1. Воспользуйтесь вызовом [BackupService.List](../api-ref/grpc/Backup/list.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/backup_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                        "folder_id": "<идентификатор_каталога>"
                    }' \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.clickhouse.v1.BackupService.List
            ```

            
            Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Backup/list.md#yandex.cloud.mdb.clickhouse.v1.ListBackupsResponse).

{% endlist %}

## Получить информацию о резервной копии {#get-backup}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы получить информацию о резервной копии существующего кластера:
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_backups }}**.

  Чтобы получить информацию о резервной копии удаленного ранее кластера:
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.clickhouse.switch_backups }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить данные о резервной копии кластера {{ CH }}, выполните команду:

  ```bash
  {{ yc-mdb-ch }} backup get <идентификатор_резервной_копии>
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
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/backups/<идентификатор_резервной_копии>'
        ```

        Идентификатор резервной копии можно запросить со [списком резервных копий в каталоге](#list-backups).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Backup/get.md#responses).

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
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/backup_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "backup_id": "<идентификатор_резервной_копии>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.BackupService.Get
        ```

        Идентификатор резервной копии можно запросить со [списком резервных копий в каталоге](#list-backups).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Backup/get.md#yandex.cloud.mdb.clickhouse.v1.Backup).

{% endlist %}

## Задать время начала резервного копирования {#set-backup-window}

{% list tabs group=instructions %}

- Консоль управления {#console}

  В [консоли управления]({{ link-console-main }}) задать время начала резервного копирования можно при [создании](cluster-create.md) или [изменении кластера](update.md).

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы задать время начала резервного копирования, передайте нужное значение в формате `HH:MM:SS` в аргументе `--backup-window-start` команды изменения кластера:

  ```bash
  {{ yc-mdb-ch }} cluster update <имя_или_идентификатор_кластера> \
     --backup-window-start=<время_начала_резервного_копирования>
  ```

  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

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
                      "updateMask": "configSpec.backupWindowStart",
                      "configSpec": {
                        "backupWindowStart": {
                          "hours": "<часы>",
                          "minutes": "<минуты>",
                          "seconds": "<секунды>",
                          "nanos": "<наносекунды>"
                        }
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            В данном случае указан только один параметр: `configSpec.backupWindowStart`.

        * {% include [backup-windows-start-rest](../../_includes/mdb/api/backup-windows-start-rest.md) %}

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#responses).

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
                      "config_spec.backup_window_start"
                    ]
                  },
                  "config_spec": {
                    "backup_window_start": {
                      "hours": "<часы>",
                      "minutes": "<минуты>",
                      "seconds": "<секунды>",
                      "nanos": "<наносекунды>"
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            В данном случае указан только один параметр: `config_spec.backup_window_start`.

        * {% include [backup-windows-start-grpc](../../_includes/mdb/api/backup-windows-start-grpc.md) %}

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Задать срок хранения автоматических резервных копий {#set-backup-retain}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  В [консоли управления]({{ link-console-main }}) задать срок хранения автоматических резервных копий можно при [создании](cluster-create.md) или [изменении кластера](update.md).
  
- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы задать срок хранения автоматических резервных копий, передайте нужное значение в формате `HH:MM:SS` в аргументе `--backup-retain-period-days` команды изменения кластера:

  ```bash
  {{ yc-mdb-ch }} cluster update <имя_или_идентификатор_кластера> \
     --backup-retain-period-days=<срок_хранения_автоматических_резервных_копий_в_днях>
  ```
  
  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

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
                    "updateMask": "configSpec.backupRetainPeriodDays",
                    "configSpec": {
                      "backupRetainPeriodDays": <количество_дней>
                    }
                  }'
      ```

      Где:

      * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

        В данном случае указан только один параметр: `configSpec.backupRetainPeriodDays`.

      * `configSpec.backupRetainPeriodDays` — новый срок хранения автоматических резервных копий в днях.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

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
                      "config_spec.backup_retain_period_days"
                    ]
                  },
                  "config_spec": {
                    "backup_retain_period_days": <количество_дней>
                  }
                }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
      ```

      Где:

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

        В данном случае указан только один параметр: `config_spec.backup_retain_period_days`.

      * `config_spec.backup_retain_period_days` — новый срок хранения автоматических резервных копий в днях.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Удалить резервную копию {#delete-backup}

{% note warning %}

Удалить можно только резервные копии, созданные вручную.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_backups }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) для нужной резервной копии и нажмите **{{ ui-key.yacloud.mdb.cluster.backups.button_delete }}**.

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы удалить резервную копию кластера:
  
  1. Посмотрите описание команды CLI для удаления резервной копии {{ CH }}:
  
      ```bash
      {{ yc-mdb-ch }} backup delete --help
      ```
  
  1. Запросите удаление резервной копии, указав ее идентификатор:
  
      ```bash
      {{ yc-mdb-ch }} backup delete <идентификатор_резервной_копии>
      ```
  
      Идентификатор резервной копии можно получить со [списком резервных копий](#list-backups).
  
- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Backup.Delete](../api-ref/Backup/delete.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/backups/<идентификатор_резервной_копии>'
     ```

     Идентификатор резервной копии можно запросить со [списком резервных копий](#list-backups).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Backup/delete.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [BackupService.Delete](../api-ref/grpc/Backup/delete.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/backup_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "backup_id": "<идентификатор_резервной_копии>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.clickhouse.v1.BackupService.Delete
     ```

     Идентификатор резервной копии можно запросить со [списком резервных копий](#list-backups).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Backup/delete.md#yandex.cloud.operation.Operation).

{% endlist %}  

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}