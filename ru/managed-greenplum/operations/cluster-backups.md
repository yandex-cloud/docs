# Управление резервными копиями в {{ mgp-name }}

Вы можете просматривать имеющиеся [резервные копии](../concepts/backup.md) и восстанавливать из них кластеры.

## Получить список резервных копий {#list-backups}

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы получить список резервных копий кластера:
    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.switch_backups }}**.

    Чтобы получить список всех резервных копий в каталоге:
    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.switch_backups }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список резервных копий кластера {{ GP }}, выполните команду:

    ```bash
    {{ yc-mdb-gp }} cluster list-backups <имя_или_идентификатор_кластера>
    ```

    Идентификатор и имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

    Результат:

    ```text
    +--------------------------+---------------------+----------------------+---------------------+
    |            ID            |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      |
    +--------------------------+---------------------+----------------------+---------------------+
    | c9qgo11pud7k********:... | 2020-08-10 12:00:00 | c9qgo11pud7k******** | 2020-08-10 11:55:17 |
    | ...                                                                                         |
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
                --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<идентификатор_кластера>/backups'
            ```

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listBackups.md#yandex.cloud.mdb.greenplum.v1.ListClusterBackupsResponse).

    1. Чтобы получить список резервных копий всех кластеров в каталоге:

        1. Воспользуйтесь методом [Backup.List](../api-ref/Backup/list.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/backups' \
                --url-query folderId=<идентификатор_каталога>
            ```

            
            Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Backup/list.md#yandex.cloud.mdb.greenplum.v1.ListBackupsResponse).

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
                -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                      "cluster_id": "<идентификатор_кластера>"
                    }' \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.greenplum.v1.ClusterService.ListBackups
            ```

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listBackups.md#yandex.cloud.mdb.greenplum.v1.ListClusterBackupsResponse).

    1. Чтобы получить список резервных копий всех кластеров в каталоге:

        1. Воспользуйтесь вызовом [BackupService.List](../api-ref/grpc/Backup/list.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/backup_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                      "folder_id": "<идентификатор_каталога>"
                    }' \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.greenplum.v1.BackupService.List
            ```

            
            Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Backup/list.md#yandex.cloud.mdb.greenplum.v1.ListBackupsResponse).

{% endlist %}

## Получить информацию о резервной копии {#get-backup}

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы получить информацию о резервной копии существующего кластера:
    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.switch_backups }}**.

    Чтобы получить информацию о резервной копии удаленного ранее кластера:
    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.switch_backups }}**.

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Backup.Get](../api-ref/Backup/get.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/backups/<идентификатор_резервной_копии>'
        ```

        Идентификатор резервной копии можно запросить со [списком резервных копий](#list-backups).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Backup/get.md#yandex.cloud.mdb.greenplum.v1.Backup).

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
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/backup_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "backup_id": "<идентификатор_резервной_копии>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.BackupService.Get
        ```

        Идентификатор резервной копии можно запросить со [списком резервных копий](#list-backups).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Backup/get.md#yandex.cloud.mdb.greenplum.v1.Backup).

{% endlist %}

## Создать резервную копию {#create-backup}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.switch_backups }}**.
    1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.mdb.cluster.backups.button_create }}**.

    {% include [no-prompt](../../_includes/mdb/backups/no-prompt.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.Backup](../api-ref/Cluster/backup.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<идентификатор_кластера>:backup'
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
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Backup
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/backup.md#yandex.cloud.operation.Operation).

{% endlist %}

{% include [backup-warning](../../_includes/mdb/backups/backup-create-warning.md) %}

## Восстановить кластер из резервной копии {#restore}


Технология Point-in-Time Recovery (PITR) позволяет вернуть состояние кластера на любую из точек восстановления, созданных позже сохраненной резервной копии. Подробнее см. в разделе [Резервные копии](../concepts/backup.md).

Восстанавливая кластер из резервной копии, вы создаете новый кластер с данными из резервной копии. Если в каталоге не хватает [ресурсов](../concepts/limits.md) для создания такого кластера, восстановиться из резервной копии не получится.

Для нового кластера необходимо задать все параметры, обязательные при создании.

Если вы хотите перенести хосты кластера {{ mgp-name }} в другую зону доступности, восстановите кластер из резервной копии. Во время восстановления из резервной копии укажите новую зону доступности. Если ваш кластер выступает в роли [эндпоинта {{ data-transfer-full-name }}](../../data-transfer/concepts/index.md#endpoint), после восстановления из резервной копии создайте заново [эндпоинт](../../data-transfer/operations/endpoint/index.md#create) и [трансфер](../../data-transfer/operations/transfer.md#create).

{% note warning %}

Существуют ограничения на параметры нового кластера при восстановлении из резервной копии:

{% include [limits](../../_includes/mdb/mgp/restore-limits.md) %}

{% endnote %}

Если в качестве времени восстановления выбран текущий момент, состояние нового кластера будет соответствовать последней доступной точке восстановления.

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы восстановить из резервной копии существующий кластер:

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.switch_backups }}**.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) для нужной резервной копии, затем нажмите **{{ ui-key.yacloud.mdb.forms.button_restore }}**.
    1. Задайте настройки нового кластера. В списке **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** можно выбрать каталог для нового кластера.
    1. В настройке **{{ ui-key.yacloud.mdb.forms.field_date }}** задайте момент времени, на который нужно восстановить состояние кластера. Введите значение вручную или выберите из выпадающего календаря. Будет использована ближайшая к этому времени точка восстановления.

       Если оставить настройку без изменений, кластер будет приведен в состояние, сохраненное в резервной копии. Точки восстановления использованы не будут.

    1. Если нужно восстановить только определенные базы данных или таблицы, задайте их список в поле **{{ ui-key.yacloud.greenplum.field_restore-only }}**. Если оставить поле пустым, кластер будет восстановлен целиком.
    1. В настройке **{{ ui-key.yacloud.greenplum.field_hosts-count }}** укажите количество хостов-сегментов.
    1. В настройке **{{ ui-key.yacloud.greenplum.field_segments-in-host }}** укажите количество [сегментов](../concepts/index.md) на хост.

        {% include [max-ram-each-process](../../_includes/mdb/mgp/max-ram-each-process.md) %}

    
    1. (Опционально) Чтобы разместить хосты-мастеры или хосты-сегменты на выделенных хостах, выберите группы [выделенных хостов](../../compute/concepts/dedicated-host.md). Можно назначить группы на один из двух видов хостов {{ GP }} либо сразу на оба.

        Группа выделенных хостов должна быть предварительно [создана](../../compute/operations/dedicated-host/create-host-group.md) в сервисе {{ compute-full-name }}.

        {% include [Dedicated hosts note](../../_includes/mdb/mgp/note-dedicated-hosts.md) %}


    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

    Чтобы восстановить из резервной копии удаленный ранее кластер:
    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.switch_backups }}**.
    1. Найдите нужную резервную копию по времени создания и идентификатору кластера. В колонке **{{ ui-key.yacloud.common.id }}** содержатся идентификаторы в формате `<идентификатор_кластера>:<идентификатор_резервной_копии>`.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) для нужной резервной копии, затем нажмите **{{ ui-key.yacloud.mdb.forms.button_restore }}**.
    1. Задайте настройки нового кластера. В списке **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** можно выбрать каталог для нового кластера.
    1. В настройке **{{ ui-key.yacloud.mdb.forms.field_date }}** задайте момент времени, на который нужно восстановить состояние кластера. Введите значение вручную или выберите из выпадающего календаря. Будет использована ближайшая к этому времени точка восстановления.

       Если оставить настройку без изменений, кластер будет приведен в состояние, сохраненное в резервной копии. Точки восстановления использованы не будут.

    1. Если нужно восстановить только определенные базы данных или таблицы, задайте их список в поле **{{ ui-key.yacloud.greenplum.field_restore-only }}**. Если оставить поле пустым, кластер будет восстановлен целиком.
    1. В настройке **{{ ui-key.yacloud.greenplum.field_hosts-count }}** укажите количество хостов-сегментов.
    1. В настройке **{{ ui-key.yacloud.greenplum.field_segments-in-host }}** укажите количество [сегментов](../concepts/index.md) на хост.

        {% include [max-ram-each-process](../../_includes/mdb/mgp/max-ram-each-process.md) %}

    
    1. (Опционально) Чтобы разместить хосты-мастеры или хосты-сегменты на выделенных хостах, выберите группы [выделенных хостов](../../compute/concepts/dedicated-host.md). Можно назначить группы на один из двух видов хостов {{ GP }} либо сразу на оба.

        Группа выделенных хостов должна быть предварительно [создана](../../compute/operations/dedicated-host/create-host-group.md) в сервисе {{ compute-full-name }}.

        {% include [Dedicated hosts note](../../_includes/mdb/mgp/note-dedicated-hosts.md) %}


    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

    {{ mgp-name }} запустит операцию создания кластера из резервной копии.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы восстановить кластер из резервной копии:

    1. Посмотрите описание команды CLI для восстановления кластера {{ GP }}:

        ```bash
        {{ yc-mdb-gp }} cluster restore --help
        ```

    1. Запросите создание кластера из резервной копии:

        
        ```bash
        {{ yc-mdb-gp }} cluster restore \
           --backup-id=<идентификатор_резервной_копии> \
           --time=<момент_времени> \
           --name=<имя_кластера> \
           --environment=<окружение> \
           --network-name={{ network-name }} \
           --master-resource-preset=<класс_хоста> \
           --master-disk-size=<объем_хранилища_ГБ> \
           --master-disk-type=<тип_диска> \
           --segment-resource-preset=<класс_хоста> \
           --segment-disk-size=<объем_хранилища_ГБ> \
           --segment-disk-type=<тип_диска> \
           --segment-host-count <количество_хостов-сегментов> \
           --segment-in-host <количество_сегментов_на_хост> \
           --restore-only=<список_БД_и_таблиц_для_восстановления> \
           --zone-id=<зона_доступности> \
           --subnet-id=<идентификатор_подсети> \
           --assign-public-ip=<публичный_доступ_к_кластеру> \
           --master-host-group-ids=<идентификаторы_групп_выделенных_хостов_для_хостов-мастеров> \
           --segment-host-group-ids=<идентификаторы_групп_выделенных_хостов_для_хостов-сегментов>
        ```


        Где:

        * `--backup-id` — идентификатор [резервной копии](../concepts/backup.md).
        * `--time` — момент времени, на который нужно восстановить состояние кластера {{ GP }}, в формате `yyyy-mm-ddThh:mm:ssZ`. По умолчанию кластер будет восстановлен в состояние, сохраненное в резервной копии.
        * `--name` — имя кластера.
        * `--environment` — окружение:

            * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.
            * `PRODUCTION` — для стабильных версий ваших приложений.

        * `--network-name` — [имя сети](../../vpc/concepts/network.md#network).
        * `--master-resource-preset` — [класс хостов-мастеров](../concepts/instance-types.md#available-flavors).
        * `--master-disk-size` — размер хранилища хостов-мастеров в гигабайтах.
        * `--master-disk-type` — [тип диска](../concepts/storage.md) хостов-мастеров.
        * `--segment-resource-preset` — [класс хостов-сегментов](../concepts/instance-types.md#available-flavors).

            {% include [max-ram-each-process](../../_includes/mdb/mgp/max-ram-each-process.md) %}

        * `--segment-disk-size` — размер хранилища хостов-сегментов в гигабайтах.
        * `--segment-disk-type` — [тип диска](../concepts/storage.md) хостов-сегментов.
        * `--segment-host-count` — количество хостов-сегментов.
        * `--segment-in-host` — количество [сегментов](../concepts/index.md) на хост.
        * `--restore-only` — (опционально) список БД и таблиц, которые будут восстановлены из резервной копии, через запятую. Поддерживаются форматы `<БД>/<схема>/<таблица>`, `<БД>/<таблица>` и `<БД>`. Допускается использование подстановочного символа `*`. Если не использовать этот параметр, кластер будет восстановлен целиком.
        * `--zone-id` — [зона доступности](../../overview/concepts/geo-scope.md).

        
        * `--master-host-group-ids` и `--segment-host-group-ids` — (опционально) идентификаторы групп [выделенных хостов](../../compute/concepts/dedicated-host.md) для хостов-мастеров и хостов-сегментов.

            Группа выделенных хостов должна быть предварительно [создана](../../compute/operations/dedicated-host/create-host-group.md) в сервисе {{ compute-full-name }}.

            {% include [Dedicated hosts note](../../_includes/mdb/mgp/note-dedicated-hosts.md) %}

        * `--subnet-id` — [идентификатор подсети](../../vpc/concepts/network.md#subnet). Необходимо указывать, если в выбранной зоне доступности создано две или больше подсетей.
        * `--assign-public-ip` — флаг, который указывается, если кластеру требуется доступ из интернета.


- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        
        ```json
        {
          "backupId": "<идентификатор_резервной_копии>",
          "time": "<время>",
          "folderId": "<идентификатор_каталога>",
          "name": "<имя_кластера>",
          "environment": "<окружение>",
          "networkId": "<идентификатор_сети>",
          "config": {
            "zoneId": "<зона_доступности>",
            "subnetId": "<идентификатор_подсети>",
            "assignPublicIp": <публичный_доступ_к_хостам_кластера>
          },
          "masterResources": {
            "resourcePresetId": "<класс_хостов>",
            "diskSize": "<размер_хранилища_в_байтах>",
            "diskTypeId": "<тип_диска>"
          },
          "segmentResources": {
            "resourcePresetId": "<класс_хостов>",
            "diskSize": "<размер_хранилища_в_байтах>",
            "diskTypeId": "<тип_диска>"
          },
          "segmentHostCount": "<количество_хостов-сегментов>",
          "segmentInHost": "<количество_сегментов_на_хост>",
          "restoreOnly": [
            "<БД_и_таблица_1>",
            "<БД_и_таблица_2>",
            ...
            "<БД_и_таблица_N>"
          ],
          "masterHostGroupIds": [
            "string"
          ],
          "segmentHostGroupIds": [
            "string"
          ]
        }
        ```


        Где:

        * `backupId` — идентификатор [резервной копии](../concepts/backup.md). Его можно запросить со [списком резервных копий](#list-backups).
        * `time` — момент времени, на который нужно восстановить состояние кластера {{ GP }}, в формате `yyyy-mm-ddThh:mm:ssZ`. По умолчанию кластер будет восстановлен в состояние, сохраненное в резервной копии.
        * `folderId` — идентификатор каталога, где будет восстановлен кластер. Идентификатор можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md). По умолчанию кластер будет восстановлен в тот же каталог, где находится резервная копия.
        * `name` — имя нового кластера.
        * `environment` — окружение:

            * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.
            * `PRODUCTION` — для стабильных версий ваших приложений.

        * `networkId` — идентификатор [сети](../../vpc/concepts/network.md#network).
        * `config` — настройки кластера:

            * `zoneId` — [зона доступности](../../overview/concepts/geo-scope.md).
            * `subnetId` — идентификатор [подсети](../../vpc/concepts/network.md#subnet).
            * `assignPublicIp` — публичный доступ к хостам кластера: `true` или `false`.

        * `masterResources`, `segmentResources` — конфигурация хостов-мастеров и хостов-сегментов кластера:

            * `resourcePresetId` — [класс хостов](../concepts/instance-types.md);
            * `diskSize` — размер диска в байтах;
            * `diskTypeId` — [тип диска](../concepts/storage.md).

        * `segmentHostCount` — количество хостов-сегментов: от `2` до `32`.
        * `segmentInHost` — [количество сегментов на хост](../concepts/index.md). Максимальное значение этого параметра зависит от класса хостов.

            {% include [max-ram-each-process](../../_includes/mdb/mgp/max-ram-each-process.md) %}

        * `restoreOnly` — (опционально) список БД и таблиц, которые будут восстановлены из резервной копии. Поддерживаются форматы `<БД>/<схема>/<таблица>`, `<БД>/<таблица>` и `<БД>`. Допускается использование подстановочного символа `*`. Если не использовать этот параметр, кластер будет восстановлен целиком.

        
        * `masterHostGroupIds` и `segmentHostGroupIds` — (опционально) идентификаторы групп [выделенных хостов](../../compute/concepts/dedicated-host.md) для хостов-мастеров и хостов-сегментов.

            Группа выделенных хостов должна быть предварительно [создана](../../compute/operations/dedicated-host/create-host-group.md) в сервисе {{ compute-full-name }}.

            {% include [Dedicated hosts note](../../_includes/mdb/mgp/note-dedicated-hosts.md) %}


    1. Воспользуйтесь методом [Cluster.Restore](../api-ref/Cluster/restore.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters:restore' \
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
          "time": "<время>",
          "folder_id": "<идентификатор_каталога>",
          "name": "<имя_кластера>",
          "environment": "<окружение>",
          "network_id": "<идентификатор_сети>",
          "config": {
            "zone_id": "<зона_доступности>",
            "subnet_id": "<идентификатор_подсети>",
            "assign_public_ip": <публичный_доступ_к_хостам_кластера>
          },
          "master_resources": {
            "resource_preset_id": "<класс_хостов>",
            "disk_size": "<размер_хранилища_в_байтах>",
            "disk_type_id": "<тип_диска>"
          },
          "segment_resources": {
            "resource_preset_id": "<класс_хостов>",
            "disk_size": "<размер_хранилища_в_байтах>",
            "disk_type_id": "<тип_диска>"
          },
          "segment_host_count": "<количество_хостов-сегментов>",
          "segment_in_host": "<количество_сегментов_на_хост>",
          "restore_only": [
            "<БД_и_таблица_1>",
            "<БД_и_таблица_2>",
            ...
            "<БД_и_таблица_N>"
          ],
          "master_host_group_ids": [
            "string"
          ],
          "segment_host_group_ids": [
            "string"
          ]
        }
        ```


        Где:

        * `backup_id` — идентификатор [резервной копии](../concepts/backup.md). Его можно запросить со [списком резервных копий](#list-backups).
        * `time` — момент времени, на который нужно восстановить состояние кластера {{ GP }}, в формате `yyyy-mm-ddThh:mm:ssZ`. По умолчанию кластер будет восстановлен в состояние, сохраненное в резервной копии.
        * `folder_id` — идентификатор каталога, где будет восстановлен кластер. Идентификатор можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md). По умолчанию кластер будет восстановлен в тот же каталог, где находится резервная копия.
        * `name` — имя нового кластера.
        * `environment` — окружение:

            * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.
            * `PRODUCTION` — для стабильных версий ваших приложений.

        * `network_id` — идентификатор [сети](../../vpc/concepts/network.md#network).
        * `config` — настройки кластера:

            * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md).
            * `subnet_id` — идентификатор [подсети](../../vpc/concepts/network.md#subnet).
            * `assign_public_ip` — публичный доступ к хостам кластера: `true` или `false`.

        * `master_resources`, `segment_resources` — конфигурация хостов-мастеров и хостов-сегментов кластера:

            * `resource_preset_id` — [класс хостов](../concepts/instance-types.md);
            * `disk_size` — размер диска в байтах;
            * `disk_type_id` — [тип диска](../concepts/storage.md).

        * `segment_host_count` — количество хостов-сегментов: от `2` до `32`.
        * `segment_in_host` — [количество сегментов на хост](../concepts/index.md). Максимальное значение этого параметра зависит от класса хостов.

            {% include [max-ram-each-process](../../_includes/mdb/mgp/max-ram-each-process.md) %}

        * `restore_only` — (опционально) список БД и таблиц, которые будут восстановлены из резервной копии. Поддерживаются форматы `<БД>/<схема>/<таблица>`, `<БД>/<таблица>` и `<БД>`. Допускается использование подстановочного символа `*`. Если не использовать этот параметр, кластер будет восстановлен целиком.

        
        * `master_host_group_ids` и `segment_host_group_ids` — (опционально) идентификаторы групп [выделенных хостов](../../compute/concepts/dedicated-host.md) для хостов-мастеров и хостов-сегментов.

            Группа выделенных хостов должна быть предварительно [создана](../../compute/operations/dedicated-host/create-host-group.md) в сервисе {{ compute-full-name }}.

            {% include [Dedicated hosts note](../../_includes/mdb/mgp/note-dedicated-hosts.md) %}


    1. Воспользуйтесь вызовом [ClusterService.Restore](../api-ref/grpc/Cluster/restore.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Restore \
            < body.json
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/restore.md#yandex.cloud.operation.Operation).

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
