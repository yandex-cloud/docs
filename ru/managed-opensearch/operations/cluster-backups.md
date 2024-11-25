---
title: Управление резервными копиями (снапшотами) {{ OS }}
description: '{{ mos-name }} позволяет использовать механизм снапшотов {{ OS }} для управления резервными копиями данных. Для работы со снапшотами используется публичный API {{ OS }}, а для их хранения — бакет в {{ objstorage-name }}.'
keywords:
  - резервные копии OpenSearch
  - снапшоты OpenSearch
  - OpenSearch
---

# Управление резервными копиями в {{ mos-name }}

{{ mos-short-name }} позволяет создавать резервные копии [индексов](../concepts/indexing.md) как средствами {{ yandex-cloud }}, так и с помощью механизма [снапшотов](../../glossary/snapshot.md) {{ OS }}. Подробнее о механизме снапшотов см. в [документации {{ OS }}]({{ os.docs }}/opensearch/snapshots/snapshot-restore/).


## Резервное копирование средствами {{ yandex-cloud }} {#cloud-backups}

Вы можете создавать [резервные копии](../concepts/backup.md) и восстанавливать кластеры из имеющихся резервных копий.

Также {{ mos-name }} каждый час создает автоматическую резервную копию.

### Получить список резервных копий {#list-backups}

Вы можете получить список резервных копий, которые были созданы за последние 14 дней.

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы получить список резервных копий кластера:

    1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![backups](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}**.

    Чтобы получить список всех резервных копий в каталоге:

    1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Выберите вкладку ![backups](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список всех резервных копий в каталоге, выполните команду:

    ```bash
    {{ yc-mdb-os }} backup list
    ```

    Результат:

    ```text
    +----------------------+---------------------+-------------------+---------------------+
    |          ID          |      CREATED AT     | SOURCE CLUSTER ID |      STARTED AT     |
    +----------------------+---------------------+-------------------+---------------------+
    | c9qlk4v13uq7******** | 2024-01-09 14:38:34 | c9qpm4i********   | 2024-01-09 14:38:28 |
    | c9qpm90p3pcg******** | 2024-01-09 13:38:31 | c9qpm4i********   | 2024-01-09 13:38:28 |
    +----------------------+---------------------+-------------------+---------------------+
    ```

    Если вы хотите ограничить список резервных копий, который выводится после запуска команды, передайте в команде флаг `--limit <количество_записей>`. Например, если вывод команды `{{ yc-mdb-os }} backup list` занимает несколько экранов, выполните команду `{{ yc-mdb-os }} backup list --limit 5`. Тогда вывод будет содержать список из последних пяти резервных копий.

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Чтобы получить список резервных копий кластера:

        1. Воспользуйтесь методом [Cluster.ListBackups](../api-ref/Cluster/listBackups.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<идентификатор_кластера>/backups'
            ```

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listBackups.md#yandex.cloud.mdb.opensearch.v1.ListClusterBackupsResponse).

    1. Чтобы получить список резервных копий всех кластеров в каталоге:

        1. Воспользуйтесь методом [Backup.List](../api-ref/Backup/list.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/backups' \
                --url-query folderId=<идентификатор_каталога>
            ```


            Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Backup/list.md#yandex.cloud.mdb.opensearch.v1.ListBackupsResponse).

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
                -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                      "cluster_id": "<идентификатор_кластера>"
                    }' \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.opensearch.v1.ClusterService.ListBackups
            ```

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listBackups.md#yandex.cloud.mdb.opensearch.v1.ListClusterBackupsResponse).

    1. Чтобы получить список резервных копий всех кластеров в каталоге:

        1. Воспользуйтесь вызовом [BackupService.List](../api-ref/grpc/Backup/list.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/backup_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                      "folder_id": "<идентификатор_каталога>"
                    }' \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.opensearch.v1.BackupService.List
            ```


            Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Backup/list.md#yandex.cloud.mdb.opensearch.v1.ListBackupsResponse).

{% endlist %}

### Получить информацию о резервной копии {#get-backup}

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы получить информацию о резервной копии существующего кластера:

    1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![backups](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}**.

    Чтобы получить информацию о резервной копии удаленного ранее кластера:

    1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Выберите вкладку ![backups](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить информацию о резервной копии кластера:

    1. Получите идентификатор резервной копии вместе со списком всех резервных копий в каталоге:

        ```bash
        {{ yc-mdb-os }} backup list
        ```

        Идентификатор указан в столбце `ID` в выводе команды.

    1. Получите информацию о нужной резервной копии:

        ```bash
        {{ yc-mdb-os }} backup get <идентификатор_резервной_копии>
        ```

        Пример результата команды:

        ```text
        id: c9qlk4v13uq7********
        folder_id: {{ folder-id-example }}
        source_cluster_id: c9qpm4i********
        started_at: "2024-01-09T10:38:28.683Z"
        created_at: "2024-01-09T10:38:31.685Z"
        indices:
          - .mdb-sli
          - .opendistro_security
          - .kibana_1
          - .opendistro-job-scheduler-lock
          - .opensearch-observability
          - .opendistro-ism-config
        opensearch_version: 2.8.0
        indices_total: "6"
        ```

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Backup.Get](../api-ref/Backup/get.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/backups/<идентификатор_резервной_копии>'
        ```

        Идентификатор резервной копии можно запросить со [списком резервных копий](#list-backups).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Backup/get.md#yandex.cloud.mdb.opensearch.v1.Backup).

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
            -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/backup_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "backup_id": "<идентификатор_резервной_копии>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.opensearch.v1.BackupService.Get
        ```

        Идентификатор резервной копии можно запросить со [списком резервных копий](#list-backups).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Backup/get.md#yandex.cloud.mdb.opensearch.v1.Backup).

{% endlist %}

### Создать резервную копию {#create-backup}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
    1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![backups](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}**.
    1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.mdb.cluster.backups.button_create }}**.

    {% include [no-prompt](../../_includes/mdb/backups/no-prompt.md) %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать резервную копию данных кластера, выполните команду:

    ```bash
    {{ yc-mdb-os }} cluster backup <имя_или_идентификатор_кластера>
    ```

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.Backup](../api-ref/Cluster/backup.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<идентификатор_кластера>:backup'
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
            -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.opensearch.v1.ClusterService.Backup
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/backup.md#yandex.cloud.operation.Operation).

{% endlist %}

{% include [backup-warning](../../_includes/mdb/backups/backup-create-warning.md) %}

### Восстановить кластер из резервной копии {#restore}

Восстанавливая кластер из резервной копии, вы создаете новый кластер с данными из резервной копии. Если в каталоге не хватает [ресурсов](../concepts/limits.md) для создания такого кластера, восстановиться из резервной копии не получится.

Для нового кластера необходимо задать все параметры, обязательные при его создании.

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы восстановить из резервной копии существующий кластер:

    1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![backups](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}**.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) для нужной резервной копии, затем нажмите **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
    1. Задайте настройки нового кластера.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

    Чтобы восстановить из резервной копии удаленный ранее кластер:

    1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Выберите вкладку ![backups](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}**.
    1. Найдите нужную резервную копию по времени создания и идентификатору кластера. В колонке **{{ ui-key.yacloud.common.id }}** содержатся идентификаторы в формате `<идентификатор_кластера>:<идентификатор_резервной_копии>`.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) для нужной резервной копии, затем нажмите **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
    1. Задайте настройки нового кластера.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

    {{ mos-name }} запустит операцию создания кластера из резервной копии.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы восстановить кластер из резервной копии:

    1. Получите идентификатор резервной копии вместе со списком всех резервных копий в каталоге:

        ```bash
        {{ yc-mdb-os }} backup list
        ```

        Результат:

        ```text
        +----------------------+---------------------+-------------------+---------------------+
        |          ID          |      CREATED AT     | SOURCE CLUSTER ID |      STARTED AT     |
        +----------------------+---------------------+-------------------+---------------------+
        | c9qlk4v13uq7******** | 2024-01-09 14:38:34 | c9qpm4i********   | 2024-01-09 14:38:28 |
        | ...                                                                                  |
        +----------------------+---------------------+-------------------+---------------------+
        ```

        Идентификатор резервной копии указан в столбце `ID`. Время завершения создания резервной копии указано в столбце `CREATED AT` в формате `yyyy-mm-dd hh:mm:ss`.

    1. Запросите создание кластера из резервной копии:

        ```bash
        {{ yc-mdb-os }} cluster restore --backup-id <идентификатор_резервной_копии>
        ```

        В команде также можно передать параметры, которые задаются при создании кластера. Описание таких параметров читайте в разделе [Создание кластера](cluster-create.md).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
            "backupId": "<идентификатор_резервной_копии>",
            "folderId": "<идентификатор_каталога>",
            "name": "<имя_кластера>",
            "environment": "<окружение>",
            "networkId": "<идентификатор_сети>",
            "configSpec": {
                "version": "<версия_{{ OS }}>",
                "adminPassword": "<пароль_пользователя-администратора>",
                "opensearchSpec": {
                    "nodeGroups": [
                        {
                            "name": "<имя_группы_хостов_{{ OS }}>",
                            "resources": {
                                "resourcePresetId": "<класс_хостов>",
                                "diskSize": "<размер_хранилища_в_байтах>",
                                "diskTypeId": "<тип_диска>"
                            },
                            "roles": ["<роль_1>","<роль_2>"],
                            "hostsCount": "<число_хостов>",
                            "zoneIds": [
                                "<зона_доступности_1>",
                                "<зона_доступности_2>",
                                "<зона_доступности_3>"
                            ],
                            "subnetIds": [
                                "<идентификатор_подсети_1>",
                                "<идентификатор_подсети_2>",
                                "<идентификатор_подсети_3>"
                            ]
                        }
                    ]
                },
                "dashboardsSpec": {
                    "nodeGroups": [
                        {
                            "name": "<имя_группы_хостов_Dashboards>",
                            "resources": {
                                "resourcePresetId": "<класс_хостов>",
                                "diskSize": "<размер_хранилища_в_байтах>",
                                "diskTypeId": "<тип_диска>"
                            },
                            "hostsCount": "<число_хостов>",
                            "zoneIds": [
                                "<зона_доступности_1>",
                                "<зона_доступности_2>",
                                "<зона_доступности_3>"
                            ],
                            "subnetIds": [
                                "<идентификатор_подсети_1>",
                                "<идентификатор_подсети_2>",
                                "<идентификатор_подсети_3>"
                            ]
                        }
                    ]
                }
            }
        }
        ```

        Где:

        * `backupId` — идентификатор резервной копии, из которой восстанавливаете кластер. Идентификатор можно запросить со [списком резервных копий](#list-backups).
        * `folderId` — идентификатор каталога. Его можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
        * `name` — имя кластера.
        * `environment` — окружение кластера: `PRODUCTION` или `PRESTABLE`.
        * `networkId` — идентификатор [сети](../../vpc/concepts/network.md#network), в которой будет размещен кластер.
        * `configSpec` — настройки кластера:

            * `version` — версия {{ OS }}.
            * `adminPassword` — пароль пользователя `admin`.
            * `opensearchSpec` — настройки групп хостов `{{ OS }}`. Содержат массив элементов `nodeGroups`. Каждый элемент соответствует отдельной группе хостов и имеет следующую структуру:

                * `name` — имя группы хостов.
                * `resources` — ресурсы кластера:

                    * `resourcePresetId` — [класс хостов](../concepts/instance-types.md);
                    * `diskSize` — размер диска в байтах;
                    * `diskTypeId` — [тип диска](../concepts/storage.md).

                * `roles` — список [ролей хостов](../concepts/host-roles.md). Кластер должен содержать хотя бы по одной группе хостов `DATA` и `MANAGER`. Это может быть одна группа, на которую назначены две роли, или несколько групп с разными ролями.
                * `hostsCount` — количество хостов в группе. Миниальное число хостов `DATA` — один, хостов `MANAGER` — три.
                * `zoneIds` — список зон доступности, где размещаются хосты кластера.
                * `subnetIds` — список идентификаторов подсетей.

            * `dashboardsSpec` — настройки групп хостов `Dashboards`. Содержат массив элементов `nodeGroups`, структура которого совпадает со структурой `opensearchSpec.nodeGroups`. Исключение — параметр `roles`: у хостов `Dashboards` есть только одна роль `DASHBOARDS`, поэтому ее не нужно указывать.

    1. Воспользуйтесь методом [Cluster.Restore](../api-ref/Cluster/restore.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters:restore' \
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
            "backup_id": "<идентификатор_резервной_копии>",
            "folder_id": "<идентификатор_каталога>",
            "name": "<имя_кластера>",
            "environment": "<окружение>",
            "network_id": "<идентификатор_сети>",
            "config_spec": {
                "version": "<версия_{{ OS }}>",
                "admin_password": "<пароль_пользователя-администратора>",
                "opensearch_spec": {
                    "node_groups": [
                        {
                            "name": "<имя_группы_хостов_{{ OS }}>",
                            "resources": {
                                "resource_preset_id": "<класс_хостов>",
                                "disk_size": "<размер_хранилища_в_байтах>",
                                "disk_type_id": "<тип_диска>"
                            },
                            "roles": ["<роль_1>","<роль_2>"],
                            "hosts_count": "<число_хостов>",
                            "zone_ids": [
                                "<зона_доступности_1>",
                                "<зона_доступности_2>",
                                "<зона_доступности_3>"
                            ],
                            "subnet_ids": [
                                "<идентификатор_подсети_1>",
                                "<идентификатор_подсети_2>",
                                "<идентификатор_подсети_3>"
                            ]
                        }
                    ]
                },
                "dashboards_spec": {
                    "node_groups": [
                        {
                            "name": "<имя_группы_хостов_Dashboards>",
                            "resources": {
                                "resource_preset_id": "<класс_хостов>",
                                "disk_size": "<размер_хранилища_в_байтах>",
                                "disk_type_id": "<тип_диска>"
                            },
                            "hosts_count": "<число_хостов>",
                            "zone_ids": [
                                "<зона_доступности_1>",
                                "<зона_доступности_2>",
                                "<зона_доступности_3>"
                            ],
                            "subnet_ids": [
                                "<идентификатор_подсети_1>",
                                "<идентификатор_подсети_2>",
                                "<идентификатор_подсети_3>"
                            ]
                        }
                    ]
                }
            }
        }
        ```

        Где:

        * `backup_id` — идентификатор резервной копии, из которой восстанавливаете кластер. Идентификатор можно запросить со [списком резервных копий](#list-backups).
        * `folder_id` — идентификатор каталога. Его можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
        * `name` — имя кластера.
        * `environment` — окружение кластера: `PRODUCTION` или `PRESTABLE`.
        * `network_id` — идентификатор [сети](../../vpc/concepts/network.md#network), в которой будет размещен кластер.
        * `config_spec` — настройки кластера:

            * `version` — версия {{ OS }}.
            * `admin_password` — пароль пользователя `admin`.
            * `opensearch_spec` — настройки групп хостов `{{ OS }}`. Содержат массив элементов `nodeGroups`. Каждый элемент соответствует отдельной группе хостов и имеет следующую структуру:

                * `name` — имя группы хостов.
                * `resources` — ресурсы кластера:

                    * `resource_preset_id` — [класс хостов](../concepts/instance-types.md);
                    * `disk_size` — размер диска в байтах;
                    * `disk_type_id` — [тип диска](../concepts/storage.md).

                * `roles` — список [ролей хостов](../concepts/host-roles.md). Кластер должен содержать хотя бы по одной группе хостов `DATA` и `MANAGER`. Это может быть одна группа, на которую назначены две роли, или несколько групп с разными ролями.
                * `hosts_count` — количество хостов в группе. Миниальное число хостов `DATA` — один, хостов `MANAGER` — три.
                * `zone_ids` — список зон доступности, где размещаются хосты кластера.
                * `subnet_ids` — список идентификаторов подсетей.

            * `dashboards_spec` — настройки групп хостов `Dashboards`. Содержат массив элементов `node_groups`, структура которого совпадает со структурой `opensearch_spec.node_groups`. Исключение — параметр `roles`: у хостов `Dashboards` есть только одна роль `DASHBOARDS`, поэтому ее не нужно указывать.

    1. Воспользуйтесь вызовом [ClusterService.Restore](../api-ref/grpc/Cluster/restore.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.opensearch.v1.ClusterService.Restore \
            < body.json
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/restore.md#yandex.cloud.operation.Operation).

{% endlist %}

## Резервное копирование с помощью снапшотов {#snapshot-backups}

Для работы со снапшотами используется [публичный API {{ OS }}]({{ os.docs }}/api-reference/index/), а для их хранения — бакет в {{ objstorage-name }}.

### Получить список снапшотов {#list-snapshots}

1. Найдите в списке репозиториев {{ OS }} тот, который содержит в себе резервные копии в виде снапшотов:

    ```http
    GET https://admin:<пароль>@<идентификатор_хоста_{{ OS }}_с_ролью_DATA>.{{ dns-zone }}:{{ port-mos }}/_snapshot/_all
    ```

   Если нужного репозитория нет в списке, [подключите его](s3-access.md).

1. Получите список снапшотов в репозитории:

    ```http
    GET https://admin:<пароль>@<идентификатор_хоста_{{ OS }}_с_ролью_DATA>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<имя_репозитория>/_all
    ```

   Каждой резервной копии соответствует один снапшот.

### Создать снапшот {#create-snapshot}

1. Найдите в списке репозиториев {{ OS }} тот, в котором нужно создать резервную копию в виде снапшота:

    ```http
    GET https://admin:<пароль>@<идентификатор_хоста_{{ OS }}_с_ролью_DATA>.{{ dns-zone }}:{{ port-mos }}/_snapshot/_all
    ```

    Если нужного репозитория нет в списке, [подключите его](s3-access.md).

1. [Создайте снапшот]({{ os.docs }}/opensearch/snapshots/snapshot-restore/#take-snapshots) нужных данных или целого кластера в выбранном репозитории:

    ```http
    PUT https://admin:<пароль>@<идентификатор_хоста_{{ OS }}_с_ролью_DATA>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<имя_репозитория>/<имя_снапшота>
    ```

### Восстановить кластер из снапшота {#restore-from-snapshot}

{% note warning %}

При восстановлении из снапшота версия {{ OS }} в кластере должна быть не ниже версии {{ OS }}, в которой был сделан снапшот.

{% endnote %}

1. [Создайте новый кластер {{ OS }}](cluster-create.md) в нужной конфигурации, но не наполняйте его данными.

    При создании кластера выберите:

    * Количество и класс хостов, размер и тип хранилища исходя из размера снапшота и требований к быстродействию.

    * Версию {{ OS }}, в которой был создан снапшот, или более новую.

1. Закройте открытые индексы с помощью [{{ OS }} API]({{ os.docs }}/api-reference/index-apis/close-index/):

    ```http
    POST: https://admin:<пароль>@<идентификатор_хоста_{{ OS }}_с_ролью_DATA>.{{ dns-zone }}:{{ port-mos }}/<имя_индекса>/_close
    ```

    Для восстановления всего кластера закройте все открытые индексы. Для восстановления отдельных индексов закройте только их.

1. [Получите список резервных копий](#list-snapshots) и найдите нужный снапшот.
1. [Запустите операцию восстановления]({{ os.docs }}/opensearch/snapshots/snapshot-restore/#restore-snapshots) из нужного снапшота всего кластера или отдельных индексов и потоков данных.
