---
title: "Управление резервными копиями {{ CH }}"
description: "Вы можете создавать резервные копии и восстанавливать кластеры из имеющихся резервных копий {{ CH }}. Восстанавливая кластер из резервной копии, вы создаете новый кластер с данными из резервной копии. Если в облаке не хватает ресурсов для создания такого кластера, восстановиться из резервной копии не получится."
---

# Управление резервными копиями в {{ mch-name }}


Вы можете создавать [резервные копии](../concepts/backup.md) и восстанавливать кластеры из имеющихся резервных копий.

Также {{ mch-name }} ежедневно создает автоматическую резервную копию. Вы можете [задать время начала резервного копирования](#set-backup-window) для нее.

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

- API {#api}

  Чтобы создать резервную копию, воспользуйтесь методом REST API [backup](../api-ref/Cluster/backup.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Backup](../api-ref/grpc/cluster_service.md#Backup) и передайте в запросе идентификатор кластера в параметре `clusterId`.

  Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

{% include [backup-warning](../../_includes/mdb/backups/backup-create-warning.md) %}

## Восстановить кластер из резервной копии {#restore}

Восстанавливая кластер из резервной копии, вы создаете новый кластер с данными из резервной копии. Если в облаке не хватает [ресурсов](../concepts/limits.md) для создания такого кластера, восстановиться из резервной копии не получится. Средняя скорость восстановления из резервной копии — 10 МБайт/с на каждое ядро БД.

Вы можете восстановить как отдельный [шард](../concepts/sharding.md), так и весь кластер целиком. Восстановить кластер целиком можно только с помощью CLI или API.

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
          * `network-ssd-nonreplicated`.



  1. Чтобы восстановить весь кластер целиком, передайте идентификаторы резервных копий всех шардов кластера:

      ```bash
      {{ yc-mdb-ch }} cluster restore \
         --backup-id=<список_идентификаторов_резервных_копий_всех_шардов> \
         ...
      ```

- API {#api}

  Чтобы восстановить кластер из резервной копии, воспользуйтесь методом REST API [restore](../api-ref/Cluster/restore.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Restore](../api-ref/grpc/cluster_service.md#Restore) и передайте в запросе:

  * Идентификатор резервной копии нужного шарда в параметре `backupId`. Чтобы узнать идентификатор, [получите список резервных копий в кластере](#list-backups).
  * Имя нового кластера, который будет содержать восстановленные из резервной копии данные, в параметре `name`. Имя кластера должно быть уникальным в рамках каталога.
  * Окружение кластера в параметре `environment`.
  * Конфигурацию кластера в параметре `configSpec`.
  * Конфигурацию хостов кластера в одном или нескольких параметрах `hostSpecs`.
  * Идентификатор сети в параметре `networkId`.

  Чтобы восстановить весь кластер целиком, передайте идентификаторы резервных копий всех остальных шардов кластера в параметре `additionalBackupIds`.

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

- API {#api}

  Чтобы получить список резервных копий кластера, воспользуйтесь методом REST API [listBackups](../api-ref/Cluster/listBackups.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/ListBackups](../api-ref/grpc/cluster_service.md#ListBackups) и передайте в запросе идентификатор кластера в параметре `clusterId`.

  Чтобы получить список резервных копий всех кластеров {{ mch-name }} в каталоге, воспользуйтесь методом REST API [list](../api-ref/Backup/list.md) для ресурса [Backup](../api-ref/Backup/index.md) или вызовом gRPC API [BackupService/List](../api-ref/grpc/backup_service.md#List) и передайте в запросе идентификатор каталога в параметре `folderId`.

  Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

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

- API {#api}

  Чтобы получить информацию о резервной копии, воспользуйтесь методом REST API [get](../api-ref/Backup/get.md) для ресурса [Backup](../api-ref/Backup/index.md) или вызовом gRPC API [BackupService/Get](../api-ref/grpc/backup_service.md#Get) и передайте в запросе идентификатор резервной копии в параметре `backupId`.

  Чтобы узнать идентификатор, [получите список резервных копий](#list-backups).

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

- API {#api}

    Чтобы задать время начала резервного копирования, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Его можно получить [со списком кластеров в каталоге](cluster-list.md#list-clusters).
    * Новое время начала резервного копирования в параметре `configSpec.backupWindowStart`.
    * Список изменяемых полей конфигурации кластера в параметре `updateMask` (в данном случае — `configSpec.backupWindowStart`).

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
