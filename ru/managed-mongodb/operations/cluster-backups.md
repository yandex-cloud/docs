---
title: "Управление резервными копиями MongoDB"
description: "Вы можете создавать резервные копии и восстанавливать кластеры из имеющихся резервных копий MongoDB. Технология Point-in-Time Recovery (PITR) позволяет восстановить состояние кластера на любой момент времени, начиная от создания резервной копии."
---

# Управление резервными копиями в {{ mmg-name }}

Вы можете создавать [резервные копии](../concepts/backup.md) и восстанавливать кластеры из имеющихся резервных копий.

Также {{ mmg-name }} ежедневно создает автоматическую резервную копию. Вы можете [задать время начала резервного копирования и срок хранения](update.md#change-additional-settings) для нее.

## Восстановить кластер из резервной копии {#restore}

Технология Point-in-Time Recovery (PITR) позволяет восстановить состояние кластера на любой момент времени в интервале от создания самой старой резервной копии до архивации самой свежей коллекции oplog. Подробнее в разделе [{#T}](../concepts/backup.md).

Например, если операция создания резервной копии завершилась 10.08.2020 в 12:00:00 UTC, текущая дата — 15.08.2020 19:00:00 UTC, а последняя коллекция oplog была сохранена 15.08.2020 в 18:50:00 UTC, кластер может быть восстановлен в любое свое состояние в промежутке времени с 10.08.2020 12:00:01 UTC до 15.08.2020 18:50:00 UTC включительно.

{% note warning %}

* PITR работает только для кластеров с {{ MG }} версии 4.2 и выше.
* PITR не поддерживается для кластеров с включенным [шардированием](../tutorials/sharding.md). Такие кластеры могут быть восстановлены только на момент создания выбранной резервной копии.

{% endnote %}

Восстанавливая кластер из резервной копии, вы создаете новый кластер с данными из резервной копии. Если в каталоге не хватает [ресурсов](../concepts/limits.md) для создания такого кластера, восстановиться из резервной копии не получится. Средняя скорость восстановления из резервной копии — 10 МБайт/с.

Для нового кластера необходимо задать все параметры, обязательные при создании, кроме типа кластера (резервную копию {{ MG }} не получится восстановить как кластер {{ PG }}).

При восстановлении до состояния на текущий момент времени новый кластер будет отражать состояние:

* существующего кластера на момент восстановления;
* удаленного кластера на момент архивации последней коллекции oplog.

{% include [mmg-pitr-preview-note](../../_includes/mdb/mmg-pitr-preview-note.md) %}

{% list tabs %}

- Консоль управления

  Чтобы восстановить из резервной копии существующий кластер:

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.

  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/mdb/backup.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}**.

  1. Нажмите на значок ![image](../../_assets/horizontal-ellipsis.svg) нужной резервной копии и нажмите **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.

  1. Задайте настройки нового кластера. В списке **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** можно выбрать каталог для нового кластера.

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

  Чтобы восстановить из резервной копии удаленный ранее кластер:

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.

  1. На панели слева выберите ![image](../../_assets/mdb/backup.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}**.

  1. Найдите нужную резервную копию по времени создания и идентификатору кластера. В колонке **{{ ui-key.yacloud.mdb.cluster.backups.column_name }}** содержатся идентификаторы в формате `<идентификатор кластера>:<идентификатор резервной копии>`.

  1. Нажмите на значок ![image](../../_assets/horizontal-ellipsis.svg) нужной резервной копии и нажмите **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.

  1. Задайте настройки нового кластера. В списке **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** можно выбрать каталог для нового кластера.

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

  {{ mmg-name }} запустит операцию создания кластера из резервной копии.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы восстановить кластер из резервной копии:

  1. Посмотрите описание команды CLI для восстановления кластера {{ MG }}:

      ```bash
      {{ yc-mdb-mg }} cluster restore --help
      ```

  1. Получите список доступных резервных копий {{ MG }}-кластеров:

     ```bash
     {{ yc-mdb-mg }} backup list
     ```

     Результат:

     ```text
     +--------------------------+---------------------+----------------------+---------------------+--------+-----------+
     |            ID            |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      |  SIZE  |   TYPE    |
     +--------------------------+---------------------+----------------------+---------------------+--------+-----------+
     | c9qlk4v13uq79r9cgcku:... | 2020-08-10 12:00:00 | c9qlk4v13uq79r9cgcku | 2020-08-10 11:55:17 | 3.3 KB | AUTOMATED |
     | ...                                                                                         |                    |
     +--------------------------+---------------------+----------------------+---------------------+--------+-----------+
     ```
      
     Время завершения создания резервной копии указано в столбце `CREATED AT` списка доступных резервных копий в формате `yyyy-mm-dd hh:mm:ss` (`2020-08-10 12:00:00` в примере выше). Вы можете восстановить состояние кластера на любой момент времени, начиная от создания резервной копии.

  1. Выполните команду создания нового кластера из резервной копии (в примере приведены только некоторые параметры):
     
     
     ```bash
      {{ yc-mdb-mg }} cluster restore \
         --backup-id <идентификатор резервной копии> \
         --recovery-target-timestamp <момент времени> \
         --mongodb-version <версия {{ MG }}> \
         --name <имя нового кластера> \
         --environment <окружение, PRESTABLE или PRODUCTION> \
         --network-name <имя сети> \
         --host zone-id=<зона доступности>,`
               `subnet-id=<идентификатор подсети> \
         --mongod-resource-preset <класс хоста> \
         --mongod-disk-size <размер хранилища в гигабайтах> \
         --mongod-disk-type <тип диска: network-hdd или network-ssd>
      ```


      В параметре `--recovery-target-timestamp` укажите момент времени, на который нужно восстановить состояние {{ MG }}-кластера, в формате [UNIX time](https://ru.wikipedia.org/wiki/Unix-время). Если параметр не задан, восстановится состояние кластера на момент завершения создания резервной копии.

- API

    Чтобы восстановить из резервной копии существующий кластер, воспользуйтесь методом REST API [restore](../api-ref/Cluster/restore.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Restore](../api-ref/grpc/cluster_service.md#Restore) и передайте в запросе:

    * Идентификатор требуемой резервной копии в параметре `backupId`. Чтобы узнать идентификатор, [получите список резервных копий в кластере](#list-backups).
    * Имя нового кластера, который будет содержать восстановленные из резервной копии данные, в параметре `name`. Имя кластера должно быть уникальным в рамках каталога.

    В параметре `recoveryTargetSpec.timestamp` укажите момент времени, на который нужно восстановить состояние {{ MG }}-кластера, в формате [UNIX time](https://ru.wikipedia.org/wiki/Unix-время). Если параметр не задан, восстановится состояние кластера на момент завершения создания резервной копии.

{% endlist %}

## Создать резервную копию {#create-backup}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/mdb/backup.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.backups.button_create }}**.

  {% include [no-prompt](../../_includes/mdb/backups/no-prompt.md) %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать резервную копию кластера:

  1. Посмотрите описание команды CLI для создания резервной копии {{ MG }}:

      ```bash
      {{ yc-mdb-mg }} cluster backup --help
      ```

  1. Запросите создание резервной копии, указав идентификатор или имя кластера:

      ```bash
      {{ yc-mdb-mg }} cluster backup <идентификатор или имя кластера>
      ```

      Идентификатор и имя кластера можно получить со [списком кластеров](cluster-list.md#list-clusters).

- API

    Чтобы создать резервную копию, воспользуйтесь методом REST API [backup](../api-ref/Cluster/backup.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Backup](../api-ref/grpc/cluster_service.md#Backup) и передайте в запросе идентификатор кластера в параметре `clusterId`.

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

{% include [backup-warning](../../_includes/mdb/backups/backup-create-warning.md) %}

## Получить список резервных копий {#list-backups}

{% list tabs %}

- Консоль управления

  Чтобы получить список резервных копий кластера:

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/mdb/backup.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}**.

  Чтобы получить список всех резервных копий в каталоге:

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. На панели слева выберите ![image](../../_assets/mdb/backup.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}**.

  В этих списках содержится следующая информация:

  * Имя резервной копии.
  * Шард-источник.
  * Размер резервной копии.
  * Тип резервной копии: автоматическая (`Automated`) или ручная (`Manual`).  
  * Время начала создания резервной копии по UTC (Coordinated Universal Time).  
  * Время окончания создания резервной копии по UTC.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список резервных копий кластеров {{ MG }}, доступных в каталоге по умолчанию, выполните команду:

  ```bash
  {{ yc-mdb-mg }} backup list
  ```

  Результат:

  ```text
  +----------+---------------------+----------------------+---------------------+--------+-----------+
  |    ID    |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      |  SIZE  |   TYPE    |
  +----------+---------------------+----------------------+---------------------+--------+-----------+
  | c9qlk... | 2020-08-10 12:00:00 | c9qlk4v13uq79r9cgcku | 2020-08-10 11:55:17 | 3.3 KB | AUTOMATED |
  | c9qpm... | 2020-08-09 22:01:04 | c9qpm90p3pcg71jm7tqf | 2020-08-09 21:30:00 | 30 KB  | MANUAL    |
  +----------+---------------------+----------------------+---------------------+--------+-----------+
  ```

  В выведенной таблице содержится следующая информация:
  * Идентификатор резервной копии.
  * Время окончания создания резервной копии по UTC (Coordinated Universal Time).
  * Идентификатор кластера, для которого создавалась эта резервная копия.
  * Время начала создания резервной копии по UTC.
  * Размер резервной копии.
  * Тип резервной копии: автоматическая (`AUTOMATED`) или ручная (`MANUAL`).

- API

    Чтобы получить список резервных копий кластера, воспользуйтесь методом REST API [listBackups](../api-ref/Cluster/listBackups.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/ListBackups](../api-ref/grpc/cluster_service.md#ListBackups) и передайте в запросе идентификатор кластера в параметре `clusterId`. 
    
    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    Чтобы получить список резервных копий всех кластеров {{ mmg-name }} в каталоге, воспользуйтесь методом REST API [list](../api-ref/Backup/list.md) для ресурса [Backup](../api-ref/Backup/index.md) или вызовом gRPC API [BackupService/List](../api-ref/grpc/backup_service.md#List) и передайте в запросе идентификатор каталога в параметре `folderId`.

{% endlist %}

## Получить информацию о резервной копии {#get-backup}

{% list tabs %}

- Консоль управления

  Чтобы получить информацию о резервной копии существующего кластера:
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/mdb/backup.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}**.

  Чтобы получить информацию о резервной копии удаленного ранее кластера:
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. На панели слева выберите ![image](../../_assets/mdb/backup.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить данные о резервной копии кластера {{ MG }}, выполните команду:

  ```bash
  {{ yc-mdb-mg }} backup get <идентификатор резервной копии>
  ```

  Идентификатор резервной копии можно получить со [списком резервных копий](#list-backups).

- API

    Чтобы получить информацию о резервной копии, воспользуйтесь методом REST API [get](../api-ref/Backup/get.md) для ресурса [Backup](../api-ref/Backup/index.md) или вызовом gRPC API [BackupService/Get](../api-ref/grpc/backup_service.md#Get) и передайте в запросе идентификатор резервной копии в параметре `backupId`.

    Чтобы узнать идентификатор, [получите список резервных копий](#list-backups).

{% endlist %}

## Примеры {#examples}

Создайте новый кластер {{ mmg-name }} из резервной копии с тестовыми характеристиками:


* Резервная копия для восстановления: `c9qlk4v13uq79r9cgcku:...`.
* Момент времени, на который нужно восстановить: `1597060810` (`2020-08-10 12:00:10`).     
* Версия: `4.2`.
* Имя нового кластера: `mynewmg`.
* Окружение: `PRODUCTION`.
* Сеть: `{{ network-name }}`.
* Один хост класса `{{ host-class }}` в зоне доступности `{{ region-id }}-a` и в подсети `b0rcctk2rvtr8efcch64`.
* Хранилище на сетевых SSD-дисках (`{{ disk-type-example }}`) размером 20 ГБ.     
* С базами данных и пользователями, которые существовали в кластере на момент восстановления.
     

{% list tabs %}

- CLI

  Выполните следующую команду:

  
  ```bash
  {{ yc-mdb-mg }} cluster restore \
     --backup-id c9qlk4v13uq79r9cgcku:... \
     --recovery-target-timestamp 1597060810 \
     --mongodb-version 4.2 \
     --name mynewmg \
     --environment PRODUCTION \
     --network-name {{ network-name }} \
     --host {{ host-net-example }} \
     --mongod-resource-preset {{ host-class }} \
     --mongod-disk-size 20 \
     --mongod-disk-type {{ disk-type-example }}
  ```
        

{% endlist %}
