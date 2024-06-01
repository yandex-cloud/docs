---
title: "Управление резервными копиями {{ RD }}"
description: "Вы можете создавать резервные копии и восстанавливать кластеры из имеющихся резервных копий {{ RD }}. Восстанавливая кластер из резервной копии, вы создаете новый кластер с данными из резервной копии. Если в облаке не хватает ресурсов для создания такого кластера, восстановиться из резервной копии не получится."
---

# Управление резервными копиями в {{ mrd-name }}


Вы можете создавать [резервные копии](../concepts/backup.md) и восстанавливать кластеры из имеющихся резервных копий.

Также {{ mrd-name }} ежедневно создает автоматическую резервную копию. Вы можете [задать время начала резервного копирования](#set-backup-window) для нее.

## Восстановить кластер из резервной копии {#restore}

Восстанавливая кластер из резервной копии, вы создаете новый кластер с данными из резервной копии. Если в каталоге не хватает [ресурсов](../concepts/limits.md) для создания такого кластера, восстановиться из резервной копии не получится. Средняя скорость восстановления из резервной копии — 10 МБайт/с.

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

  1. Посмотрите описание команды CLI для восстановления кластера {{ RD }}:

      ```bash
      {{ yc-mdb-rd }} cluster restore --help
      ```

  1. Получите список доступных резервных копий кластеров {{ RD }}:

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

      В результате будет создан кластер {{ RD }} со следующими характеристиками:

      * С именем `mynewrd`.
      * В окружении `PRODUCTION`.
      * В сети `default`.
      * С одним хостом класса `hm1.nano` в подсети `b0rcctk2rvtr********`, в зоне доступности `{{ region-id }}-a`, публичным доступом и приоритетом реплики `50`.
      * С паролем `P@ssWord`.
      * С хранилищем на сетевых SSD-дисках (`{{ disk-type-example }}`) размером 20 ГБ.

      {% include [requirements-to-password](../../_includes/mdb/mrd/requirements-to-password.md) %}

- API {#api}

    Чтобы восстановить кластер из резервной копии, воспользуйтесь методом REST API [restore](../api-ref/Cluster/restore.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Restore](../api-ref/grpc/cluster_service.md#Restore).

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

  1. Посмотрите описание команды CLI для создания резервной копии {{ RD }}:

      ```bash
      {{ yc-mdb-rd }} cluster backup --help
      ```

  1. Запросите создание резервной копии, указав имя или идентификатор кластера:

      ```bash
      {{ yc-mdb-rd }} cluster backup my-rd-cluster
      ```

      Имя и идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters).

- API {#api}

    Чтобы создать резервную копию, воспользуйтесь методом REST API [backup](../api-ref/Cluster/backup.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Backup](../api-ref/grpc/cluster_service.md#Backup) и передайте в запросе идентификатор кластера в параметре `clusterId`.

    Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters).

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

  Чтобы получить список резервных копий кластеров {{ RD }}, доступных в каталоге по умолчанию, выполните команду:

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

- API {#api}

    Чтобы получить список резервных копий кластера, воспользуйтесь методом REST API [listBackups](../api-ref/Cluster/listBackups.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/ListBackups](../api-ref/grpc/cluster_service.md#ListBackups) и передайте в запросе идентификатор кластера в параметре `clusterId`.

    Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters).

    Чтобы получить список всех резервных копий в каталоге, воспользуйтесь методом REST API [list](../api-ref/Backup/list.md) для ресурса [Backup](../api-ref/Backup/index.md) или вызовом gRPC API [BackupService/List](../api-ref/grpc/backup_service.md#List) и передайте в запросе идентификатор каталога в параметре `folderId`.

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

  Чтобы получить данные о резервной копии кластера {{ RD }}, выполните команду:

  ```bash
  {{ yc-mdb-rd }} backup get <идентификатор_резервной_копии>
  ```

  Идентификатор резервной копии можно получить со [списком резервных копий](#list-backups).

- API {#api}

    Чтобы получить информацию о резервной копии, воспользуйтесь методом REST API [get](../api-ref/Backup/get.md) для ресурса [Backup](../api-ref/Backup/index.md) или вызовом gRPC API [BackupService/Get](../api-ref/grpc/backup_service.md#Get) и передайте в запросе идентификатор резервной копии в параметре `backupId`.

    Идентификатор резервной копии можно получить со [списком резервных копий](#list-backups).

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

- API {#api}

  Чтобы задать время начала резервного копирования, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update).

{% endlist %}
