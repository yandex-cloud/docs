---
title: Управление резервными копиями MySQL
description: Вы можете создавать резервные копии и восстанавливать кластеры из имеющихся резервных копий MySQL. Технология Point-in-Time Recovery (PITR) позволяет восстановить состояние кластера на любой момент времени, начиная от создания резервной копии.
---

# Управление резервными копиями в {{ mmy-name }}

Вы можете создавать резервные копии и восстанавливать кластеры из имеющихся резервных копий, в том числе на указанный момент времени. Подробнее см. в разделе [Резервные копии](../concepts/backup.md).

Также {{ mmy-name }} ежедневно создает автоматическую резервную копию. Для нее вы можете [задать время начала резервного копирования](#set-backup-window).

## Получить список резервных копий {#list-backups}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы получить список резервных копий кластера:
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}**.

  Чтобы получить список всех резервных копий в каталоге:
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список резервных копий кластеров {{ MY }}, доступных в каталоге по умолчанию, выполните команду:

  ```bash
  {{ yc-mdb-my }} backup list
  ```

  Результат:

  ```text
  +--------------------------+---------------------+----------------------+---------------------+
  |            ID            |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      |
  +--------------------------+---------------------+----------------------+---------------------+
  | c9qgo11pud7kb3c********  | 2020-08-10 12:00:00 | c9qgo11pud7k******** | 2020-08-10 11:55:17 |
  | ...                                                                                         |
  +--------------------------+---------------------+----------------------+---------------------+
  ```

- API {#api}

  Чтобы получить список резервных копий кластера, воспользуйтесь методом REST API [listBackups](../api-ref/Cluster/listBackups.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/ListBackups](../api-ref/grpc/cluster_service.md#ListBackups) и передайте в запросе идентификатор кластера в параметре `clusterId`.

  Чтобы получить список резервных копий всех кластеров {{ mmy-name }} в каталоге, воспользуйтесь методом REST API [list](../api-ref/Backup/list.md) для ресурса [Backup](../api-ref/Backup/index.md) или вызовом gRPC API [BackupService/List](../api-ref/grpc/backup_service.md#List) и передайте в запросе идентификатор каталога в параметре `folderId`.

  {% include [Получение идентификатора кластера](../../_includes/mdb/mmy/note-api-get-cluster-id.md) %}

{% endlist %}

## Получить информацию о резервной копии {#get-backup}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы получить информацию о резервной копии существующего кластера:
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}**.

  Чтобы получить информацию о резервной копии удаленного ранее кластера:
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить данные о резервной копии кластера {{ MY }}, выполните команду:

  ```bash
  {{ yc-mdb-my }} backup get <идентификатор_резервной_копии>
  ```

  Идентификатор резервной копии можно получить со [списком резервных копий](#list-backups).

- API {#api}

  Чтобы получить информацию о резервной копии, воспользуйтесь методом REST API [get](../api-ref/Backup/get.md) для ресурса [Backup](../api-ref/Backup/index.md) или вызовом gRPC API [BackupService/Get](../api-ref/grpc/backup_service.md#Get) и передайте в запросе идентификатор резервной копии в параметре `backupId`.

  Чтобы узнать идентификатор, [получите список резервных копий](#list-backups).

{% endlist %}

## Создать резервную копию {#create-backup}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.backups.button_create }}**.

  {% include [no-prompt](../../_includes/mdb/backups/no-prompt.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать резервную копию кластера:

  1. Посмотрите описание команды CLI для создания резервной копии кластера {{ MY }}:

      ```bash
      {{ yc-mdb-my }} cluster backup --help
      ```

  1. Запросите создание резервной копии, указав идентификатор или имя кластера:

      ```bash
      {{ yc-mdb-my }} cluster backup <имя_или_идентификатор_кластера>
      ```

      Идентификатор и имя кластера можно получить со [списком кластеров](cluster-list.md#list-clusters).

- API {#api}

  Чтобы создать резервную копию, воспользуйтесь методом REST API [backup](../api-ref/Cluster/backup.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Backup](../api-ref/grpc/cluster_service.md#Backup) и передайте в запросе идентификатор кластера в параметре `clusterId`.

  {% include [Получение идентификатора кластера](../../_includes/mdb/mmy/note-api-get-cluster-id.md) %}

{% endlist %}

{% include [backup-warning](../../_includes/mdb/backups/backup-create-warning.md) %}

В кластерах из одного хоста резервная копия создается чтением данных с хоста-мастера, а в многохостовых кластерах — с одной из реплик. При этом можно [задать приоритет использования хостов при создании резервных копий](#set-backup-priority).

## Восстановить кластер из резервной копии {#restore}

Для нового кластера необходимо задать все параметры, обязательные при создании, кроме типа кластера.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы восстановить из резервной копии существующий кластер:

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) для нужной резервной копии, затем нажмите **{{ ui-key.yacloud.mdb.forms.button_restore }}**.
  1. Задайте настройки нового кластера. В списке **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** можно выбрать каталог для нового кластера.
  1. Чтобы восстановить состояние кластера [на требуемый момент времени](../concepts/backup.md) после создания этой резервной копии (Point-in-Time-Recovery), задайте нужное значение настройки **{{ ui-key.yacloud.mdb.forms.field_date }}**.

     Если оставить настройку без изменений, кластер будет восстановлен в состояние на момент завершения создания резервной копии.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

  Чтобы восстановить из резервной копии удаленный ранее кластер:
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}**.
  1. Найдите нужную резервную копию по времени создания и идентификатору кластера. В колонке **{{ ui-key.yacloud.common.id }}** содержатся идентификаторы в формате `<идентификатор_кластера>:<идентификатор_резервной_копии>`.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) для нужной резервной копии, затем нажмите **{{ ui-key.yacloud.mdb.forms.button_restore }}**.
  1. Задайте настройки нового кластера. В списке **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** можно выбрать каталог для нового кластера.
  1. Чтобы восстановить состояние кластера на требуемый момент времени после создания этой резервной копии, задайте нужное значение настройки **{{ ui-key.yacloud.mdb.forms.field_date }}**. Значение можно ввести вручную или выбрать из выпадающего календаря.

     Если оставить настройку без изменений, кластер будет восстановлен в состояние на момент завершения создания резервной копии.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

  {{ mmy-name }} запустит операцию создания кластера из резервной копии.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы восстановить кластер из резервной копии:

  1. Посмотрите описание команды CLI для восстановления кластера {{ MY }}:

      ```bash
      {{ yc-mdb-my }} cluster restore --help
      ```

  1. Получите список доступных резервных копий кластеров {{ MY }}:

     ```bash
     {{ yc-mdb-my }} backup list
     ```

     Результат:

     ```text
     +--------------------------+---------------------+----------------------+---------------------+
     |            ID            |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      |
     +--------------------------+---------------------+----------------------+---------------------+
     | c9qgo11pud7kb3c********  | 2020-08-10 12:00:00 | c9qgo11pud7k******** | 2020-08-10 11:55:17 |
     | ...                                                                                         |
     +--------------------------+---------------------+----------------------+---------------------+
     ```

     Время завершения создания резервной копии указано в столбце `CREATED AT` списка доступных резервных копий в формате `yyyy-mm-dd hh:mm:ss` (`2020-08-10 12:00:00` в примере выше). Вы можете восстановить состояние кластера на любой момент времени, начиная от создания резервной копии.

  1. Запросите создание кластера из резервной копии:


      ```bash
      {{ yc-mdb-my }} cluster restore \
         --backup-id=<идентификатор_резервной_копии> \
         --time=<время> \
         --name=<имя_кластера> \
         --environment=<окружение> \
         --network-name=<имя_сети> \
         --host zone-id=<зона_доступности>,`
               `subnet-name=<имя_подсети>,`
               `assign-public-ip=<публичный_доступ_к_хосту> \
         --resource-preset=<класс_хоста> \
         --disk-size=<размер_хранилища_ГБ> \
         --disk-type=<тип_диска>
      ```


      Где:

      * `--backup-id` — идентификатор [резервной копии](../concepts/backup.md).
      * `--time` — момент времени, на который нужно восстановить состояние кластера {{ MY }}, в формате `yyyy-mm-ddThh:mm:ssZ`.
      * `--name` — имя кластера.
      * `--environment` — окружение:

          * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.
          * `PRODUCTION` — для стабильных версий ваших приложений.

      * `--network-name` — [имя сети](../../vpc/concepts/network.md#network).
      * `--host` — параметры хоста:

          * `zone-id` — [зона доступности](../../overview/concepts/geo-scope.md).


          * `subnet-name` — [имя подсети](../../vpc/concepts/network.md#subnet). Необходимо указывать, если в выбранной зоне доступности создано две или больше подсетей.
          * `assign-public-ip` — флаг, который указывается, если для хоста нужен [публичный доступ](../concepts/network.md#public-access-to-host): `true` или `false`.


      * `--resource-preset` — [класс хоста](../concepts/instance-types.md#available-flavors).
      * `--disk-size` — размер хранилища в гигабайтах.
      * `--disk-type` — [тип диска](../concepts/storage.md):


          * `network-hdd`;
          * `network-ssd`;
          * `local-ssd`;
          * `network-ssd-nonreplicated`.


- {{ TF }} {#tf}

  Используйте {{ TF }} для восстановления:

  * Существующего кластера из резервной копии.
  * Кластера, созданного и удаленного через Консоль управления, CLI или API.

  Для восстановления потребуется ID резервной копии. Получите список доступных резервных копий кластеров {{ MY }} [с помощью CLI](#list-backups):

  ```bash
  {{ yc-mdb-my }} backup list
  ```

  Результат:

  ```text
  +--------------------------+---------------------+----------------------+---------------------+
  |            ID            |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      |
  +--------------------------+---------------------+----------------------+---------------------+
  | c9qgo11pud7kb3c********  | 2020-08-10 12:00:00 | c9qgo11pud7k******** | 2020-08-10 11:55:17 |
  | ...                                                                                         |
  +--------------------------+---------------------+----------------------+---------------------+
  ```

  **Чтобы восстановить из резервной копии существующий кластер:**

  1. Создайте [конфигурационный файл {{ TF }}](cluster-create.md#create-cluster) для нового кластера.

      При этом не используйте ресурсы баз данных (`yandex_mdb_mysql_database`) и пользователей (`yandex_mdb_mysql_user`) — они будут восстановлены из резервной копии.

  1. Добавьте в этот конфигурационный файл блок `restore`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
        ...
        restore {
          backup_id = "<имя_резервной_копии>"
          time      = "<время>"
        }
      }
      ```

      В параметре `time` укажите момент времени в формате `yyyy-mm-ddThh:mm:ss`, на который нужно восстановить состояние кластера {{ MY }}, начиная со времени создания выбранной резервной копии.

      {% note info %}

      Параметр `time` не является обязательным. Если его не указывать, кластер будет восстановлен на момент запуска процесса восстановления.

      {% endnote %}

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  {{ TF }} создаст копию существующего кластера. Базы данных и пользователи будут развернуты из выбранной резервной копии.

  {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

  **Чтобы восстановить из резервной копии удаленный ранее кластер**:

  1. Создайте [конфигурационный файл {{ TF }}](cluster-create.md#create-cluster) для нового кластера.

      При этом не используйте ресурсы баз данных (`yandex_mdb_mysql_database`) и пользователей (`yandex_mdb_mysql_user`) — они будут восстановлены из резервной копии.

  1. Добавьте в этот конфигурационный файл блок `restore` с именем резервной копии, из которой нужно восстановиться:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
        ...
        restore {
            backup_id = "<идентификатор_резервной_копии>"
        }
      }
      ```

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  {{ TF }} создаст новый кластер. Базы данных и пользователи будут развернуты из резервной копии.

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmy }}).

  {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API {#api}

  Чтобы восстановить кластер из резервной копии, воспользуйтесь методом REST API [restore](../api-ref/Cluster/restore.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Restore](../api-ref/grpc/cluster_service.md#Restore) и передайте в запросе:

  * Идентификатор требуемой резервной копии в параметре `backupId`. Чтобы узнать идентификатор, [получите список резервных копий в кластере](#list-backups).
  * Момент времени, на который должен быть восстановлен кластер, в параметре `time`.
  * Имя нового кластера, который будет содержать восстановленные из резервной копии данные, в параметре `name`. Имя кластера должно быть уникальным в рамках каталога.

{% endlist %}

## Задать время начала резервного копирования {#set-backup-window}

{% list tabs group=instructions %}

- Консоль управления {#console}

  В [консоли управления]({{ link-console-main }}) задать время начала резервного копирования можно при [создании](cluster-create.md) или [изменении кластера](update.md).

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Задать время начала резервного копирования в существующем кластере можно с помощью команды `update`:

  ```bash
  {{ yc-mdb-my }} cluster update <имя_или_идентификатор_кластера> \
     --backup-window-start=<время>
  ```

  Где `backup-window-start` — время начала резервного копирования, по UTC в формате `HH:MM:SS`.

  Идентификатор и имя кластера можно получить со [списком кластеров](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

  1. Добавьте к описанию кластера {{ mmy-name }} блок `backup_window_start`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
        ...
        backup_window_start {
          hours   = <час>
          minutes = <минута>
        }
      }
      ```

      Где:

      * `hours` — час начала резервного копирования (UTC).
      * `minutes` — минута начала резервного копирования (UTC).

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmy }}).

  {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API {#api}

    Чтобы задать время начала резервного копирования, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Его можно получить [со списком кластеров в каталоге](cluster-list.md#list-clusters).
    * Новое время начала резервного копирования в параметре `configSpec.backupWindowStart`.
    * Список изменяемых полей конфигурации кластера в параметре `updateMask` (в данном случае — `configSpec.backupWindowStart`).

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Задать приоритет использования хостов при создании резервных копий {#set-backup-priority}

Минимальное значение приоритета использования хоста при создании резервных копий — `0`, максимальное — `100`, по умолчанию — `0`. Источником резервного копирования выбирается хост-реплика с наибольшим приоритетом. Подробнее см. раздел [Создание резервной копии](../concepts/backup.md#size).

{% list tabs group=instructions %}

- Консоль управления {#console}

  В [консоли управления]({{ link-console-main }}) приоритет хоста задается при [создании](cluster-create.md) кластера, [добавлении](../operations/hosts.md#add) в него новых хостов или [изменении настроек](../operations/hosts.md#update) существующих.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы задать приоритет резервного копирования для выбранного хоста, выполните команду:

  ```bash
  {{ yc-mdb-my }} host update <имя_хоста> \
     --cluster-name=<имя_кластера> \
     --backup-priority=<приоритет_хоста_при_резервном_копировании>
  ```

  Где `backup-priority` — приоритет хоста при резервном копировании: от `0` до `100`.

  Имя хоста можно запросить со [списком хостов в кластере](hosts.md#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API {#api}

  Чтобы задать приоритет хоста, воспользуйтесь методом REST API [updateHosts](../api-ref/Cluster/updateHosts.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/UpdateHosts](../api-ref/grpc/cluster_service.md#UpdateHosts) и передайте в запросе:

  * Идентификатор кластера в параметре `clusterId`. Его можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя хоста в параметре `updateHostSpecs.hostName`. Его можно получить со [списком хостов в кластере](hosts.md#list).
  * Новое значение приоритета хоста в параметре `updateHostSpecs.backupPriority`.
  * Список полей конфигурации кластера, подлежащих изменению (в данном случае — `updateHostSpecs.hostName` и `updateHostSpecs.backupPriority`), в параметре `updateMask`.

  {% include [Сброс настроек изменяемого объекта](../../_includes/note-api-updatemask.md) %}

{% endlist %}
