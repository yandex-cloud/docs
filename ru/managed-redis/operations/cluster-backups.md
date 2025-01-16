---
title: Управление резервными копиями {{ VLK }}
description: Вы можете создавать резервные копии и восстанавливать кластеры из имеющихся резервных копий {{ VLK }}. Восстанавливая кластер из резервной копии, вы создаете новый кластер с данными из резервной копии. Если в облаке не хватает ресурсов для создания такого кластера, восстановиться из резервной копии не получится.
---

# Управление резервными копиями в {{ mrd-name }}


Вы можете создавать [резервные копии](../concepts/backup.md) и восстанавливать кластеры из имеющихся резервных копий.

Также {{ mrd-name }} ежедневно создает автоматическую резервную копию. Вы можете [задать время начала резервного копирования](#set-backup-window) для нее.

## Восстановить кластер из резервной копии {#restore}

Восстанавливая кластер из резервной копии, вы создаете новый кластер с данными из резервной копии. Если в каталоге не хватает [ресурсов](../concepts/limits.md) для создания такого кластера, восстановиться из резервной копии не получится. Средняя скорость восстановления из резервной копии — 10 МБайт/с.

Если при восстановлении кластера из резервной копии вы выбрали тип диска **local-ssd**, добавьте не менее двух хостов на шард.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы восстановить из резервной копии существующий кластер:

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором нужно восстановить кластер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.redis.switch_backups }}**.
  1. В строке нужной резервной копии нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
  1. Задайте настройки нового кластера. В списке **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** можно выбрать каталог для нового кластера.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

  Чтобы восстановить из резервной копии удаленный ранее кластер:

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором нужно восстановить кластер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.redis.switch_backups }}**.
  1. Найдите нужную резервную копию по времени создания и идентификатору кластера. В колонке **{{ ui-key.yacloud.common.id }}** содержатся идентификаторы в формате `<идентификатор_кластера>:<идентификатор_резервной_копии>`.
  1. В строке нужной резервной копии нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
  1. Задайте настройки нового кластера. В списке **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** можно выбрать каталог для нового кластера.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

  {{ mrd-name }} запустит операцию создания кластера из резервной копии.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы восстановить кластер из резервной копии:

  1. Посмотрите описание команды CLI для восстановления кластера {{ VLK }}:

      ```bash
      {{ yc-mdb-rd }} cluster restore --help
      ```

  1. Получите список доступных резервных копий кластеров {{ VLK }}:

      ```bash
      {{ yc-mdb-rd }} backup list
      ```

      Результат:

      ```text
      +--------------------------+---------------------+----------------------+---------------------+
      |            ID            |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      |
      +--------------------------+---------------------+----------------------+---------------------+
      | c9qlk4v13uq7********:... | 2020-08-10 12:00:00 | c9qlk4v13uq7******** | 2020-08-10 11:55:17 |
      | ...                                                                                         |
      +--------------------------+---------------------+----------------------+---------------------+
      ```

  1. Запросите [создание кластера](cluster-create.md) из резервной копии:

      ```bash
      {{ yc-mdb-rd }} cluster restore \
         --backup-id c9q287aqv5rf********:20181113T133617 \
         --name mynewrd \
         --environment=PRODUCTION \
         --network-name default \
         --host zone-id={{ region-id }}-a,subnet-id=b0rcctk2rvtr********,assign-public-ip=true,replica-priority=50 \
         --password P@ssWord \
         --disk-size 20
      ```

      В результате будет создан кластер {{ VLK }} со следующими характеристиками:

      * С именем `mynewrd`.
      * В окружении `PRODUCTION`.
      * В сети `default`.
      * С одним хостом класса `hm1.nano` в подсети `b0rcctk2rvtr********`, в зоне доступности `{{ region-id }}-a`, публичным доступом и [приоритетом реплики](../concepts/replication.md#master-failover) `50`.
      * С паролем `P@ssWord`.
      * С хранилищем на сетевых SSD-дисках (`{{ disk-type-example }}`) размером 20 ГБ.

      {% include [requirements-to-password](../../_includes/mdb/mrd/requirements-to-password.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.Restore](../api-ref/Cluster/restore.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters:restore' \
            --data '{
                      "backupId": "<идентификатор_резервной_копии>",
                      "name": "<имя_кластера>",
                      "environment": "<окружение>",
                      "configSpec": {
                        "redis": {
                          "password": "<пароль_пользователя>"
                        }
                      },
                      "hostSpecs": [
                        {
                          "zoneId": "<зона_доступности>",
                          "subnetId": "<идентификатор_подсети>",
                          "replicaPriority": "<приоритет_хоста>",
                          "assignPublicIp": <публичный_доступ_к_хосту_кластера>
                        },
                        { <аналогичный_набор_настроек_для_хоста_2> },
                        { ... },
                        { <аналогичный_набор_настроек_для_хоста_N> }
                      ],
                      "networkId": "<идентификатор_сети>",
                      "tlsEnabled": <поддержка_шифрованных_TLS-соединений>
                    }'
        ```

        Где:

        * `backupId` — идентификатор резервной копии. Чтобы узнать идентификатор, [получите список резервных копий в каталоге](#list-backups).
        * `name` — имя кластера.
        * `environment` — окружение: `PRESTABLE` или `PRODUCTION`.
        * `configSpec.redis.password` — пароль пользователя.
        * `hostSpecs` — параметры хоста:

             * `zoneId` — [зона доступности](../../overview/concepts/geo-scope.md).
            * `subnetId` — [идентификатор подсети](../../vpc/concepts/network.md#subnet). Необходимо указывать, если в выбранной зоне доступности создано две или больше подсетей.
            * `replicaPriority` — приоритет назначения хоста мастером при [выходе из строя основного мастера](../concepts/replication.md#master-failover).
            * `assignPublicIp` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`. Включить публичный доступ можно, только если для параметра `tlsEnabled` указано значение `true`.

        * `networkId` — идентификатор [сети](../../vpc/concepts/network.md#network), в которой будет размещен кластер.

        * `tlsEnabled` — поддержка шифрованных TLS-соединений с кластером: `true` или `false`.

            {% note warning %}

            Включить шифрование соединений можно только при создании нового кластера. Отключить шифрование в кластере, для которого оно включено, невозможно.

            {% endnote %}

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/restore.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [Cluster.Restore](../api-ref/grpc/Cluster/restore.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "backup_id": "<идентификатор_резервной_копии>",
                  "name": "<имя_кластера>",
                  "environment": "<окружение>",
                  "config_spec": {
                    "redis": {
                      "password": "<пароль_пользователя>"
                    }
                  },
                  "host_specs": [
                    {
                      "zone_id": "<зона_доступности>",
                      "subnet_id": "<идентификатор_подсети>",
                      "replica_priority": "<приоритет_хоста>",
                      "assign_public_ip": <публичный_доступ_к_хосту_кластера>
                    },
                    { <аналогичный_набор_настроек_для_хоста_2> },
                    { ... },
                    { <аналогичный_набор_настроек_для_хоста_N> }
                  ],
                  "network_id": "<идентификатор_сети>",
                  "tls_enabled": <поддержка_шифрованных_TLS-соединений>
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.Restore
        ```

        Где:

        * `backup_id` — идентификатор резервной копии. Чтобы узнать идентификатор, [получите список резервных копий в каталоге](#list-backups).
        * `name` — имя кластера.
        * `environment` — окружение: `PRESTABLE` или `PRODUCTION`.
        * `config_spec.redis.password` — пароль пользователя.
        * `host_specs` — параметры хоста:

             * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md).
            * `subnet_id` — [идентификатор подсети](../../vpc/concepts/network.md#subnet). Необходимо указывать, если в выбранной зоне доступности создано две или больше подсетей.
            * `replica_priority` — приоритет назначения хоста мастером при [выходе из строя основного мастера](../concepts/replication.md#master-failover).
            * `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`. Включить публичный доступ можно, только если для параметра `tlsEnabled` указано значение `true`.

        * `network_id` — идентификатор [сети](../../vpc/concepts/network.md#network), в которой будет размещен кластер.

        * `tls_enabled` — поддержка шифрованных TLS-соединений с кластером: `true` или `false`.

            {% note warning %}

            Включить шифрование соединений можно только при создании нового кластера. Отключить шифрование в кластере, для которого оно включено, невозможно.

            {% endnote %}

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/restore.md#yandex.cloud.operation.Operation).

{% endlist %}

## Создать резервную копию {#create-backup}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где нужно создать резервную копию.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.redis.switch_backups }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.backups.button_create }}**.

  {% include [no-prompt](../../_includes/mdb/backups/no-prompt.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать резервную копию кластера:

  1. Посмотрите описание команды CLI для создания резервной копии {{ VLK }}:

      ```bash
      {{ yc-mdb-rd }} cluster backup --help
      ```

  1. Запросите создание резервной копии, указав имя или идентификатор кластера:

      ```bash
      {{ yc-mdb-rd }} cluster backup my-rd-cluster
      ```

      Имя и идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.Backup](../api-ref/Cluster/backup.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<идентификатор_кластера>:backup'
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
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.Backup
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/backup.md#yandex.cloud.operation.Operation).

{% endlist %}

{% include [backup-warning](../../_includes/mdb/backups/backup-create-warning.md) %}

## Получить список резервных копий {#list-backups}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы получить список резервных копий кластера:
  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.redis.switch_backups }}**.

  Чтобы получить список всех резервных копий в каталоге:
  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.redis.switch_backups }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список резервных копий кластеров {{ VLK }}, доступных в каталоге по умолчанию, выполните команду:

  ```bash
  {{ yc-mdb-rd }} backup list
  ```

  Результат:

  ```text
  +--------------------------+---------------------+----------------------+---------------------+
  |            ID            |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      |
  +--------------------------+---------------------+----------------------+---------------------+
  | c9qlk4v13uq7********:... | 2020-08-10 12:00:00 | c9qlk4v13uq7******** | 2020-08-10 11:55:17 |
  | c9qpm90p3pcg********:... | 2020-08-09 22:01:04 | c9qpm90p3pcg******** | 2020-08-09 21:30:00 |
  +--------------------------+---------------------+----------------------+---------------------+
  ```

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Чтобы получить список резервных копий кластера:

        1. Воспользуйтесь методом [Cluster.ListBackups](../api-ref/Cluster/listBackups.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<идентификатор_кластера>/backups'
            ```

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listBackups.md#yandex.cloud.mdb.redis.v1.ListClusterBackupsResponse).

    1. Чтобы получить список резервных копий всех кластеров в каталоге:

        1. Воспользуйтесь методом [Backup.List](../api-ref/Backup/list.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-redis/v1/backups' \
                --url-query folderId=<идентификатор_каталога>
            ```


            Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Backup/list.md#yandex.cloud.mdb.redis.v1.ListBackupsResponse).

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
                -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                      "cluster_id": "<идентификатор_кластера>"
                    }' \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.redis.v1.ClusterService.ListBackups
            ```

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listBackups.md#yandex.cloud.mdb.redis.v1.ListClusterBackupsResponse).

    1. Чтобы получить список резервных копий всех кластеров в каталоге:

        1. Воспользуйтесь вызовом [BackupService.List](../api-ref/grpc/Backup/list.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/backup_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                      "folder_id": "<идентификатор_каталога>"
                    }' \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.redis.v1.BackupService.List
            ```


            Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Backup/list.md#yandex.cloud.mdb.redis.v1.ListBackupsResponse).

{% endlist %}

## Получить информацию о резервной копии {#get-backup}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы получить информацию о резервной копии существующего кластера:
  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с кластером, информацию о копии которого нужно получить.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.redis.switch_backups }}**.

  Чтобы получить информацию о резервной копии удаленного ранее кластера:
  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором располагался удаленный кластер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.redis.switch_backups }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить данные о резервной копии кластера {{ VLK }}, выполните команду:

  ```bash
  {{ yc-mdb-rd }} backup get <идентификатор_резервной_копии>
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
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/backups/<идентификатор_резервной_копии>'
        ```

        Идентификатор резервной копии можно запросить со [списком резервных копий](#list-backups).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Backup/get.md#yandex.cloud.mdb.redis.v1.Backup).

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
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/backup_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "backup_id": "<идентификатор_резервной_копии>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.BackupService.Get
        ```

        Идентификатор резервной копии можно запросить со [списком резервных копий](#list-backups).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Backup/get.md#yandex.cloud.mdb.redis.v1.Backup).

{% endlist %}

## Задать время начала резервного копирования {#set-backup-window}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Время начала резервного копирования можно задать при [создании](cluster-create.md) или [изменении](update.md#change-redis-config) кластера в блоке **{{ ui-key.yacloud.mdb.forms.section_additional }}**.

- CLI {#cli}

  Чтобы задать время начала резервного копирования, используйте флаг `--backup-window-start`. Время задается в формате `ЧЧ:ММ:СС`.

  ```bash
  {{ yc-mdb-rd }} cluster create \
    --name <имя_кластера> \
    --environment <окружение> \
    --network-name <имя_сети> \
    --host zone-id=<зона_доступности>,subnet-id=<идентификатор_подсети> \
    --backup-window-start 10:25:00
  ```

  Где `--environment` — окружение: `prestable` или `production`.

  Изменить время начала резервного копирования в существующем кластере можно с помощью команды `update`:

  ```bash
  {{ yc-mdb-rd }} cluster update \
     --name <имя_кластера> \
     --backup-window-start 11:25:00
  ```

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
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<идентификатор_кластера>' \
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

            В данном случае передается только один параметр.

        * `configSpec.backupWindowStart` — настройки окна [резервного копирования](../concepts/backup.md).

            В параметре укажите время, когда начинать резервное копирование:

            * `hours` — от `0` до `23` часов;
            * `minutes` — от `0` до `59` минут;
            * `seconds` — от `0` до `59` секунд;
            * `nanos` — от `0` до `999999999` наносекунд.

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
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [ "config_spec.backup_window_start" ]
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
            yandex.cloud.mdb.redis.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            В данном случае передается только один параметр.

        * `config_spec.backup_window_start` — настройки окна [резервного копирования](../concepts/backup.md).

            В параметре укажите время, когда начинать резервное копирование:

            * `hours` — от `0` до `23` часов;
            * `minutes` — от `0` до `59` минут;
            * `seconds` — от `0` до `59` секунд;
            * `nanos` — от `0` до `999999999` наносекунд.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}
