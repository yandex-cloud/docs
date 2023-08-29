---
title: "Управление резервными копиями (снапшотами) Elasticsearch"
description: "Сервис Elasticsearch позволяет использовать механизм снапшотов Elasticsearch для управления резервными копиями данных. Для работы со снапшотами используется публичный API Elasticsearch, а для их хранения — бакет в {{ objstorage-name }}."
keywords:
  - резервные копии Elasticsearch
  - снапшоты Elasticsearch
  - Elasticsearch
---

# Управление резервными копиями в {{ mes-name }}

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}


{{ mes-short-name }} позволяет создавать резервные копии [индексов](../concepts/indexing.md) как средствами {{ yandex-cloud }}, так и с помощью механизма [снапшотов](https://cloud.yandex.ru/docs/glossary/snapshot) {{ ES }}. Подробнее о механизме снапшотов см. в [документации {{ ES }}](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore.html).

## Резервное копирование средствами {{ yandex-cloud }} {#cloud-backups}


Вы можете создавать [резервные копии](../concepts/backup.md) и восстанавливать кластеры из имеющихся резервных копий.

Также {{ mes-name }} каждый час создает автоматическую резервную копию.


### Получить список резервных копий {#list-backups}


{% list tabs %}

- Консоль управления

  Чтобы получить список резервных копий кластера:
  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}**.

  Чтобы получить список всех резервных копий в каталоге:
  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
  1. Выберите вкладку **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список резервных копий кластеров {{ ES }}, доступных в каталоге по умолчанию, выполните команду:

    ```bash
    {{ yc-mdb-es }} backup list
    ```

    Результат:

    ```text
    +----------------------+----------------------+----------------------+----------------------+
    |          ID          |      CREATED AT      |  SOURCE CLUSTER ID   |      STARTED AT      |
    +----------------------+----------------------+----------------------+----------------------+
    | c9qlk4v13uq7******** | 2020-08-10T12:00:00Z | c9qlk4v13uq7******** | 2020-08-10T11:55:17Z |
    | c9qpm90p3pcg******** | 2020-08-09T22:01:04Z | c9qpm90p3pcg******** | 2020-08-09T21:30:00Z |
    +----------------------+----------------------+----------------------+----------------------+
    ```

- API

    Чтобы получить список резервных копий кластера, воспользуйтесь методом REST API [listBackups](../api-ref/Cluster/listBackups.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/ListBackups](../api-ref/grpc/cluster_service.md#ListBackups) и передайте в запросе идентификатор кластера в параметре `clusterId`.

    Чтобы получить список резервных копий всех кластеров {{ mes-name }} в каталоге, воспользуйтесь методом REST API [list](../api-ref/Backup/list.md) для ресурса [Backup](../api-ref/Backup/index.md) или вызовом gRPC API [BackupService/List](../api-ref/grpc/backup_service.md#List) и передайте в запросе идентификатор каталога в параметре `folderId`.

    {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

{% endlist %}


### Получить информацию о резервной копии {#get-backup}


{% list tabs %}

- Консоль управления

  Чтобы получить информацию о резервной копии существующего кластера:
  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}**.

  Чтобы получить информацию о резервной копии удаленного ранее кластера:
  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
  1. Выберите вкладку **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить данные о резервной копии кластера {{ ES }}, выполните команду:

    ```bash
    {{ yc-mdb-es }} backup get <идентификатор резервной копии>
    ```

    Идентификатор резервной копии можно получить со [списком резервных копий](#list-backups).

- API

    Чтобы получить информацию о резервной копии, воспользуйтесь методом REST API [get](../api-ref/Backup/get.md) для ресурса [Backup](../api-ref/Backup/index.md) или вызовом gRPC API [BackupService/Get](../api-ref/grpc/backup_service.md#Get) и передайте в запросе идентификатор резервной копии в параметре `backupId`.

    Чтобы узнать идентификатор, [получите список резервных копий](#list-backups).

{% endlist %}


### Создать резервную копию {#create-backup}


{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}**.
  1. Нажмите кнопку ![image](../../_assets/plus-sign.svg) **{{ ui-key.yacloud.mdb.cluster.backups.button_create }}**.

  {% include [no-prompt](../../_includes/mdb/backups/no-prompt.md) %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать резервную копию кластера:

    1. Посмотрите описание команды CLI для создания резервной копии {{ ES }}:

        ```bash
        {{ yc-mdb-es }} cluster backup --help
        ```

    1. Запросите создание резервной копии, указав идентификатор или имя кластера:

        ```bash
        {{ yc-mdb-es }} cluster backup <идентификатор или имя кластера>
        ```

        Идентификатор и имя кластера можно получить со [списком кластеров](cluster-list.md#list-clusters).

- API

    Чтобы создать резервную копию, воспользуйтесь методом REST API [backup](../api-ref/Cluster/backup.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Backup](../api-ref/grpc/cluster_service.md#Backup) и передайте в запросе идентификатор кластера в параметре `clusterId`.

    {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

{% endlist %}

{% include [backup-warning](../../_includes/mdb/backups/backup-create-warning.md) %}


### Восстановить кластер из резервной копии {#restore}


Восстанавливая кластер из резервной копии, вы создаете новый кластер с данными из резервной копии. Если в каталоге не хватает [ресурсов](../concepts/limits.md) для создания такого кластера, восстановиться из резервной копии не получится. Скорость восстановления можно регулировать [средствами {{ ES }}](https://www.elastic.co/guide/en/elasticsearch/reference/current/recovery.html).

Для нового кластера необходимо задать все параметры, обязательные при его создании.

{% list tabs %}

- Консоль управления

  Чтобы восстановить из резервной копии существующий кластер:
  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}**.
  1. Нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) для нужной резервной копии, затем нажмите **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
  1. Задайте настройки нового кластера. В списке **{{ ui-key.yacloud.common.folder }}** можно выбрать каталог для нового кластера.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

  Чтобы восстановить из резервной копии удаленный ранее кластер:
  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
  1. Выберите вкладку **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}**.
  1. Найдите нужную резервную копию по времени создания и идентификатору кластера. В колонке **{{ ui-key.yacloud.common.name }}** содержатся идентификаторы в формате `<идентификатор кластера>:<идентификатор резервной копии>`.
  1. Нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) для нужной резервной копии, затем нажмите **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
  1. Задайте настройки нового кластера. В списке **{{ ui-key.yacloud.common.folder }}** можно выбрать каталог для нового кластера.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

  {{ mes-name }} запустит операцию создания кластера из резервной копии.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы восстановить кластер из резервной копии:

    1. Посмотрите описание команды CLI для восстановления кластера {{ ES }}:

        ```bash
        {{ yc-mdb-es }} cluster restore --help
        ```

    1. Получите список доступных резервных копий {{ ES }}-кластеров:

        ```bash
        {{ yc-mdb-es }} backup list
        ```

        Результат:

        ```text
        +--------------------------+----------------------+----------------------+----------------------+
        |            ID            |      CREATED AT      |  SOURCE CLUSTER ID   |      STARTED AT      |
        +--------------------------+----------------------+----------------------+----------------------+
        | c9qlk4v13uq79r9********  | 2020-08-10T12:00:00Z | c9qlk4v13uq7******** | 2020-08-10T11:55:17Z |
        | ...                                                                                           |
        +--------------------------+----------------------+----------------------+----------------------+
        ```

        Время завершения создания резервной копии указано в столбце `CREATED AT` списка доступных резервных копий в формате `yyyy-mm-ddThh:mm:ssZ` (`2020-08-10T12:00:00Z` в примере выше).

    1. Запросите создание кластера из резервной копии:

        
        ```bash
        {{ yc-mdb-es }} cluster restore \
           --backup-id=<идентификатор резервной копии> \
           --name=<имя кластера> \
           --environment=<окружение: PRESTABLE или PRODUCTION> \
           --network-name=<имя сети> \
           --host zone-id=<зона доступности>,`
                 `subnet-id=<имя подсети>,`
                 `assign-public-ip=<публичный доступ к хосту: true или false>,`
                 `type=<роль хоста: datanode или masternode> \
           --datanode-resource-preset=<класс хостов с ролью Data node> \
           --datanode-disk-size=<размер хранилища в гигабайтах для хостов с ролью Data node> \
           --datanode-disk-type=<тип диска для хостов с ролью Data node> \
           --masternode-resource-preset=<класс хостов с ролью Master node> \
           --masternode-disk-size=<размер хранилища в гигабайтах для хостов с ролью Master node> \
           --masternode-disk-type=<тип диска для хостов с ролью Master node: network-ssd> \
           --admin-password=<пароль пользователя admin>
        ```


        Где:

        * `--backup-id` — идентификатор [резервной копии](../concepts/backup.md).
        * `--name` — имя кластера.
        * `--environment` — окружение:

            * `PRESTABLE` — для тестирования, в том числе самого сервиса {{ ES }}. В Prestable-окружении раньше появляются новая функциональность, улучшения и   исправления ошибок. При этом не все обновления обеспечивают обратную совместимость.
            * `PRODUCTION` — для стабильных версий ваших приложений.

        * `--network-name` — [имя сети](../../vpc/concepts/network.md#network).
        * `--host` — параметры хоста:

            * `zone-id` — [зона доступности](../../overview/concepts/geo-scope.md).

            
            * `subnet-name` — [имя подсети](../../vpc/concepts/network.md#subnet). Необходимо указывать, если в выбранной зоне доступности создано две или   больше подсетей.
            * `assign-public-ip` — флаг, который указывается, если для хоста требуется [публичный доступ](../concepts/network.md#public-access-to-a-host).


            * `type` — [роль хоста](../concepts/hosts-roles.md).

        * `--datanode-resource-preset` — [класс хостов](../concepts/instance-types.md#available-flavors) с ролью Data node.
        * `--datanode-disk-size` — размер хранилища в гигабайтах для хостов с ролью Data node.
        * `--datanode-disk-type` — [тип диска](../concepts/storage.md) для хостов с ролью Data node:

            
            * `network-hdd`;
            * `network-ssd`;
            * `local-ssd`;
            * `network-ssd-nonreplicated`.


        * `--masternode-resource-preset` — [класс хостов](../concepts/instance-types.md#available-flavors) с ролью Master node.
        * `--masternode-disk-size` — размер хранилища в гигабайтах для хостов с ролью Master node.
        * `--masternode-disk-type` — [тип диска](../concepts/storage.md) для хостов с ролью Master node. Доступен только `network-ssd`.

        * `--admin-password` — пароль пользователя `admin`.

            {% include [mes-superuser](../../_includes/mdb/mes-superuser.md) %}


- API

    Чтобы восстановить кластер из резервной копии, воспользуйтесь методом REST API [restore](../api-ref/Cluster/restore.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Restore](../api-ref/grpc/cluster_service.md#Restore) и передайте в запросе:

    * Идентификатор требуемой резервной копии в параметре `backupId`. Чтобы узнать идентификатор, [получите список резервных копий в кластере](#list-backups).
    * Имя нового кластера, который будет содержать восстановленные из резервной копии данные, в параметре `name`. Имя кластера должно быть уникальным в рамках каталога.
    * Окружение кластера в параметре `environment`.
    * Конфигурацию кластера в параметре `configSpec`.
    * Конфигурацию хостов кластера в одном или нескольких параметрах `hostSpecs`.
    * Идентификатор сети в параметре `networkId`.

{% endlist %}



## Резервное копирование с помощью снапшотов {#snapshot-backups}

Для работы со снапшотами используется [публичный API {{ ES }}](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore-apis.html), а для их хранения — бакет в {{ objstorage-name }}.

### Получить список снапшотов {#list-snapshots}

1. Найдите в списке репозиториев {{ ES }} тот, который содержит в себе резервные копии в виде снапшотов:

    ```http
    GET https://admin:<пароль>@<FQDN_хоста>:9200/_snapshot/_all
    ```

    Если нужного репозитория нет в списке — [подключите его](./s3-access.md).

1. Получите список снапшотов в репозитории:

    ```http
    GET https://admin:<пароль>@<FQDN_хоста>:9200/_snapshot/<репозиторий>/_all
    ```

    Каждой резервной копии соответствует один снапшот.


### Создать снапшот {#create-snapshot}

1. Найдите в списке репозиториев {{ ES }} тот, в котором нужно создать резервную копию в виде снапшота:

    ```http
    GET https://admin:<пароль>@<FQDN_хоста>:9200/_snapshot/_all
    ```

    Если нужного репозитория нет в списке — [подключите его](./s3-access.md).

1. [Создайте снапшот](https://www.elastic.co/guide/en/elasticsearch/reference/current/create-snapshot-api.html) нужных данных или целого кластера в выбранном репозитории:

    ```http
    PUT https://admin:<пароль>@<FQDN_хоста>:9200/_snapshot/<репозиторий>/<снапшот>
    ```

### Восстановить кластер из снапшота {#restore-from-snapshot}

{% note warning %}

При восстановлении из снапшотов действуют следующие ограничения:

* Версия {{ ES }} в кластере должна быть не ниже версии {{ ES }}, в которой был сделан снапшот.
* Для восстановления индексов необходимо, чтобы мажорная версия {{ ES }} в кластере была не больше чем на единицу старше мажорной версии {{ ES }}, в которой сделан снапшот. Например, индексы, созданные в версии 5.0, можно восстановить в версии 6.0, а в версии 7.0 — нельзя.

{% endnote %}

1. [Создайте новый кластер {{ ES }}](./cluster-create.md) в нужной конфигурации, но не наполняйте его данными.

    При создании кластера выберите:

    * Количество и класс хостов, размер хранилища и тип дисков исходя из размера снапшота и требований к быстродействию. При необходимости [повысьте класс хостов](./cluster-update.md#change-resource-preset) или [увеличьте размер хранилища кластера](./cluster-update.md#change-disk-size).

    * Версию {{ ES }}, в которой был создан снапшот, или более новую.

1. Закройте открытые индексы с помощью [{{ ES }} API](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-close.html):

    ```http
    POST: https://admin:<пароль>@<FQDN_хоста>:9200/<индекс>/_close
    ```

    Для восстановления всего кластера закройте все открытые индексы. Для восстановления отдельных индексов закройте только их.

1. [Получите список резервных копий](#list-snapshots) и найдите нужный снапшот.
1. [Запустите операцию восстановления](https://www.elastic.co/guide/en/elasticsearch/reference/current/restore-snapshot-api.html) из нужного снапшота всего кластера или отдельных индексов и потоков данных.

Подробнее о восстановлении из снапшотов см. в [документации {{ ES }}](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html).

