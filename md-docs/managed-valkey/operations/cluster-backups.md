# Управление резервными копиями в Yandex Managed Service for Valkey™


Вы можете создавать [резервные копии](../concepts/backup.md) и восстанавливать кластеры из имеющихся резервных копий.

Также Yandex Managed Service for Valkey™ ежедневно создает автоматическую резервную копию. Вы можете [задать время начала резервного копирования](#set-backup-window) для нее.

## Восстановить кластер из резервной копии {#restore}

{% note warning %}

Для кластеров с неподдерживаемой версией СУБД восстановление из резервных копий недоступно.

{% endnote %}

Восстанавливая кластер из резервной копии, вы создаете новый кластер с данными из резервной копии. Если в каталоге не хватает [ресурсов](../concepts/limits.md) для создания такого кластера, восстановиться из резервной копии не получится. Средняя скорость восстановления из резервной копии — 10 МБайт/с.

Если при восстановлении кластера из резервной копии вы выбрали тип диска **local-ssd**, добавьте не менее двух хостов на шард.


Перед началом работы [назначьте](../../iam/operations/roles/grant.md) вашему аккаунту в Yandex Cloud роль [managed-redis.restorer](../../iam/roles-reference.md#managed-redis-restorer) или выше на каталог размещения резервной копии и каталог, где будет развернут новый кластер.


{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы восстановить из резервной копии существующий кластер:

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором нужно восстановить кластер.
  1. Перейдите в сервис **Yandex Managed Service for&nbsp;Valkey™**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Резервные копии**.
  1. В строке нужной резервной копии нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Восстановить кластер**.
  1. Задайте настройки нового кластера. В списке **Каталог** можно выбрать каталог для нового кластера.
  1. Нажмите кнопку **Восстановить кластер**.

  Чтобы восстановить из резервной копии удаленный ранее кластер:

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором нужно восстановить кластер.
  1. Перейдите в сервис **Yandex Managed Service for&nbsp;Valkey™**.
  1. На панели слева выберите ![image](../../_assets/console-icons/archive.svg) **Резервные копии**.
  1. Найдите нужную резервную копию по времени создания и идентификатору кластера. В колонке **Идентификатор** содержатся идентификаторы в формате `<идентификатор_кластера>:<идентификатор_резервной_копии>`.
  1. В строке нужной резервной копии нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Восстановить кластер**.
  1. Задайте настройки нового кластера. В списке **Каталог** можно выбрать каталог для нового кластера.
  1. Нажмите кнопку **Восстановить кластер**.

  Yandex Managed Service for Valkey™ запустит операцию создания кластера из резервной копии.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы восстановить кластер из резервной копии:

  1. Посмотрите описание команды CLI для восстановления кластера Valkey™:

      ```bash
      yc managed-redis cluster restore --help
      ```

  1. Получите список доступных резервных копий кластеров Valkey™:

      ```bash
      yc managed-redis backup list
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
      yc managed-redis cluster restore \
         --backup-id c9q287aqv5rf********:20181113T133617 \
         --name mynewrd \
         --environment=PRODUCTION \
         --network-name default \
         --host zone-id=ru-central1-a,subnet-id=b0rcctk2rvtr********,assign-public-ip=true,replica-priority=50 \
         --password P@ssWord \
         --disk-size 20
      ```

      В результате будет создан кластер Valkey™ со следующими характеристиками:

      * С именем `mynewrd`.
      * В окружении `PRODUCTION`.
      * В сети `default`.
      * С одним хостом класса `hm1.nano` в подсети `b0rcctk2rvtr********`, в зоне доступности `ru-central1-a`, публичным доступом и [приоритетом реплики](../concepts/replication.md#master-failover) `50`.
      * С паролем `P@ssWord`.
      * С хранилищем на сетевых SSD-дисках (`network-ssd`) размером 20 ГБ.

      Допустимая длина пароля — от 8 до 128 символов. Пароль должен удовлетворять регулярному выражению `[a-zA-Z0-9@=+?*.,!&#$^<>_-]*`.

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.Restore](../api-ref/Cluster/restore.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://mdb.api.cloud.yandex.net/managed-redis/v1/clusters:restore' \
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

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Воспользуйтесь вызовом [Cluster.Restore](../api-ref/grpc/Cluster/restore.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
            mdb.api.cloud.yandex.net:443 \
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

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, где нужно создать резервную копию.
  1. Перейдите в сервис **Yandex Managed Service for&nbsp;Valkey™**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Резервные копии**.
  1. Нажмите кнопку **Создать резервную копию**.

  Сервис начнет создавать резервную копию без дополнительного подтверждения.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы создать резервную копию кластера:

  1. Посмотрите описание команды CLI для создания резервной копии Valkey™:

      ```bash
      yc managed-redis cluster backup --help
      ```

  1. Запросите создание резервной копии, указав имя или идентификатор кластера:

      ```bash
      yc managed-redis cluster backup my-rd-cluster
      ```

      Имя и идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.Backup](../api-ref/Cluster/backup.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://mdb.api.cloud.yandex.net/managed-redis/v1/clusters/<идентификатор_кластера>:backup'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/backup.md#yandex.cloud.operation.Operation).

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

    1. Воспользуйтесь вызовом [ClusterService.Backup](../api-ref/grpc/Cluster/backup.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.redis.v1.ClusterService.Backup
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/backup.md#yandex.cloud.operation.Operation).

{% endlist %}

{% note warning %}

Во время создания резервной копии производительность кластера может снижаться.

{% endnote %}

## Получить список резервных копий {#list-backups}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы получить список резервных копий кластера:
  1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
  1. Перейдите в сервис **Yandex Managed Service for&nbsp;Valkey™**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Резервные копии**.

  Чтобы получить список всех резервных копий в каталоге:
  1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
  1. Перейдите в сервис **Yandex Managed Service for&nbsp;Valkey™**.
  1. На панели слева выберите ![image](../../_assets/console-icons/archive.svg) **Резервные копии**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить список резервных копий кластеров Valkey™, доступных в каталоге по умолчанию, выполните команду:

  ```bash
  yc managed-redis backup list
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

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Чтобы получить список резервных копий кластера:

        1. Воспользуйтесь методом [Cluster.ListBackups](../api-ref/Cluster/listBackups.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://mdb.api.cloud.yandex.net/managed-redis/v1/clusters/<идентификатор_кластера>/backups'
            ```

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listBackups.md#yandex.cloud.mdb.redis.v1.ListClusterBackupsResponse).

    1. Чтобы получить список резервных копий всех кластеров в каталоге:

        1. Воспользуйтесь методом [Backup.List](../api-ref/Backup/list.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://mdb.api.cloud.yandex.net/managed-redis/v1/backups' \
                --url-query folderId=<идентификатор_каталога>
            ```

            
            Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Backup/list.md#yandex.cloud.mdb.redis.v1.ListBackupsResponse).

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

    1. Чтобы получить список резервных копий кластера:

        1. Воспользуйтесь вызовом [ClusterService.ListBackups](../api-ref/grpc/Cluster/listBackups.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
                mdb.api.cloud.yandex.net:443 \
                yandex.cloud.mdb.redis.v1.ClusterService.ListBackups
            ```

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listBackups.md#yandex.cloud.mdb.redis.v1.ListClusterBackupsResponse).

    1. Чтобы получить список резервных копий всех кластеров в каталоге:

        1. Воспользуйтесь вызовом [BackupService.List](../api-ref/grpc/Backup/list.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
                mdb.api.cloud.yandex.net:443 \
                yandex.cloud.mdb.redis.v1.BackupService.List
            ```

            
            Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Backup/list.md#yandex.cloud.mdb.redis.v1.ListBackupsResponse).

{% endlist %}

## Получить информацию о резервной копии {#get-backup}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы получить информацию о резервной копии существующего кластера:
  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог с кластером, информацию о копии которого нужно получить.
  1. Перейдите в сервис **Yandex Managed Service for&nbsp;Valkey™**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Резервные копии**.

  Чтобы получить информацию о резервной копии удаленного ранее кластера:
  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором располагался удаленный кластер.
  1. Перейдите в сервис **Yandex Managed Service for&nbsp;Valkey™**.
  1. На панели слева выберите ![image](../../_assets/console-icons/archive.svg) **Резервные копии**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить данные о резервной копии кластера Valkey™, выполните команду:

  ```bash
  yc managed-redis backup get <идентификатор_резервной_копии>
  ```

  Идентификатор резервной копии можно получить со [списком резервных копий](#list-backups).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Backup.Get](../api-ref/Backup/get.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://mdb.api.cloud.yandex.net/managed-redis/v1/backups/<идентификатор_резервной_копии>'
        ```

        Идентификатор резервной копии можно запросить со [списком резервных копий](#list-backups).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Backup/get.md#yandex.cloud.mdb.redis.v1.Backup).

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

    1. Воспользуйтесь вызовом [BackupService.Get](../api-ref/grpc/Backup/get.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.redis.v1.BackupService.Get
        ```

        Идентификатор резервной копии можно запросить со [списком резервных копий](#list-backups).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Backup/get.md#yandex.cloud.mdb.redis.v1.Backup).

{% endlist %}

## Задать время начала резервного копирования {#set-backup-window}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Время начала резервного копирования можно задать при [создании](cluster-create.md) или [изменении](update.md#change-valkey-config) кластера в блоке **Дополнительные настройки**.

- CLI {#cli}

  Чтобы задать время начала резервного копирования, используйте параметр `--backup-window-start`. Время задается в формате `ЧЧ:ММ:СС`.

  ```bash
  yc managed-redis cluster create \
    --name <имя_кластера> \
    --environment <окружение> \
    --network-name <имя_сети> \
    --host zone-id=<зона_доступности>,subnet-id=<идентификатор_подсети> \
    --backup-window-start 10:25:00
  ```

  Где `--environment` — окружение: `prestable` или `production`.

  Изменить время начала резервного копирования в существующем кластере можно с помощью команды `update`:

  ```bash
  yc managed-redis cluster update \
     --name <имя_кластера> \
     --backup-window-start 11:25:00
  ```

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
            --url 'https://mdb.api.cloud.yandex.net/managed-redis/v1/clusters/<идентификатор_кластера>' \
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
            mdb.api.cloud.yandex.net:443 \
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