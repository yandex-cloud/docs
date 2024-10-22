---
title: Управление резервными копиями MongoDB
description: Вы можете создавать резервные копии и восстанавливать кластеры из имеющихся резервных копий MongoDB. Технология Point-in-Time Recovery (PITR) позволяет восстановить состояние кластера на любой момент времени, начиная от создания резервной копии.
---

# Управление резервными копиями в {{ mmg-name }}

Вы можете создавать [резервные копии](../concepts/backup.md) и восстанавливать кластеры из имеющихся резервных копий.

Также {{ mmg-name }} ежедневно создает автоматическую резервную копию. Вы можете [задать время начала резервного копирования и срок хранения](update.md#change-additional-settings) для нее.

## Восстановить кластер из резервной копии {#restore}

Технология Point-in-Time Recovery (PITR) позволяет восстановить состояние кластера на любой момент времени в интервале от создания самой старой резервной копии до архивации самой свежей коллекции [oplog](https://www.mongodb.com/docs/manual/core/replica-set-oplog/). Подробнее см. в разделе [Резервные копии](../concepts/backup.md).

Например, если операция создания резервной копии завершилась 10.08.2020 в 12:00:00 UTC, текущая дата — 15.08.2020 19:00:00 UTC, а последняя коллекция oplog была сохранена 15.08.2020 в 18:50:00 UTC, кластер может быть восстановлен в любое свое состояние в промежутке времени с 10.08.2020 12:00:01 UTC до 15.08.2020 18:50:00 UTC включительно.

{% note warning %}

PITR не поддерживается для кластеров с включенным [шардированием](../tutorials/sharding.md). Такие кластеры могут быть восстановлены только на момент создания выбранной резервной копии.

{% endnote %}

Восстанавливая кластер из резервной копии, вы создаете новый кластер с данными из резервной копии. Если в каталоге не хватает [ресурсов](../concepts/limits.md) для создания такого кластера, восстановиться из резервной копии не получится. Средняя скорость восстановления из резервной копии — 10 МБайт/с.

Для нового кластера необходимо задать все параметры, обязательные при создании, кроме типа кластера (резервную копию {{ MG }} не получится восстановить как кластер {{ PG }}).

При восстановлении до состояния на текущий момент времени новый кластер будет отражать состояние:

* существующего кластера на момент восстановления;
* удаленного кластера на момент архивации последней коллекции oplog.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы восстановить из резервной копии существующий кластер:

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.

  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}**.

  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) нужной резервной копии и нажмите **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.

  1. Задайте настройки нового кластера. В списке **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** можно выбрать каталог для нового кластера.

  1. Чтобы восстановить состояние кластера на требуемый момент времени после создания этой резервной копии, задайте нужное значение настройки **{{ ui-key.yacloud.mdb.forms.field_date }}**. Значение можно ввести вручную или выбрать из выпадающего календаря.

      Если оставить настройку без изменений, кластер будет восстановлен в состояние на момент завершения создания резервной копии.

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

  Чтобы восстановить из резервной копии удаленный ранее кластер:

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.

  1. На панели слева выберите ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}**.

  1. Найдите нужную резервную копию по времени создания и идентификатору кластера. В колонке **{{ ui-key.yacloud.common.id }}** содержатся идентификаторы в формате `<идентификатор_кластера>:<идентификатор_резервной_копии>`.

  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) нужной резервной копии и нажмите **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.

  1. Задайте настройки нового кластера. В списке **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** можно выбрать каталог для нового кластера.

  1. Чтобы восстановить состояние кластера на требуемый момент времени после создания этой резервной копии, задайте нужное значение настройки **{{ ui-key.yacloud.mdb.forms.field_date }}**. Значение можно ввести вручную или выбрать из выпадающего календаря.

      Если оставить настройку без изменений, кластер будет восстановлен в состояние на момент завершения создания резервной копии.

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

  {{ mmg-name }} запустит операцию создания кластера из резервной копии.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы восстановить кластер из резервной копии:

  1. Посмотрите описание команды CLI для восстановления кластера {{ MG }}:

      ```bash
      {{ yc-mdb-mg }} cluster restore --help
      ```

  1. Получите список доступных резервных копий кластеров {{ MG }}:

     ```bash
     {{ yc-mdb-mg }} backup list
     ```

     Результат:

     ```text
     +--------------------------+---------------------+----------------------+---------------------+--------+-----------+
     |            ID            |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      |  SIZE  |   TYPE    |
     +--------------------------+---------------------+----------------------+---------------------+--------+-----------+
     | c9qlk4v13uq7********:... | 2020-08-10 12:00:00 | c9qlk4v13uq7******** | 2020-08-10 11:55:17 | 3.3 KB | AUTOMATED |
     | ...                                                                                         |                    |
     +--------------------------+---------------------+----------------------+---------------------+--------+-----------+
     ```

     Время завершения создания резервной копии указано в столбце `CREATED AT` списка доступных резервных копий в формате `yyyy-mm-dd hh:mm:ss` (`2020-08-10 12:00:00` в примере выше). Вы можете восстановить состояние кластера на любой момент времени, начиная от создания резервной копии.

  1. Выполните команду создания нового кластера из резервной копии (в примере приведены только некоторые параметры):


     ```bash
      {{ yc-mdb-mg }} cluster restore \
         --backup-id <идентификатор_резервной_копии> \
         --recovery-target-timestamp <момент_времени> \
         --mongodb-version <версия_{{ MG }}> \
         --name <имя_нового_кластера> \
         --environment <окружение> \
         --network-name <имя_сети> \
         --host zone-id=<зона_доступности>,`
               `subnet-id=<идентификатор_подсети> \
         --mongod-resource-preset <класс_хоста> \
         --mongod-disk-size <размер_хранилища_ГБ> \
         --mongod-disk-type <тип_диска> \
         --performance-diagnostics=<включить_диагностику>
      ```


      Где:

      * `--recovery-target-timestamp` — момент времени, на который нужно восстановить состояние кластера {{ MG }}, в формате [UNIX time](https://ru.wikipedia.org/wiki/Unix-время). Если параметр не задан, восстановится состояние кластера на момент завершения создания резервной копии.
      * `--environment` — окружение: `PRESTABLE` или `PRODUCTION`.


      * `--mongod-disk-type` — тип диска: `network-hdd` или `network-ssd`.


      * `--performance-diagnostics` — включить диагностику производительности кластера: `true` или `false`.

- API {#api}

    Чтобы восстановить из резервной копии существующий кластер, воспользуйтесь методом REST API [restore](../api-ref/Cluster/restore.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Restore](../api-ref/grpc/Cluster/restore.md) и передайте в запросе:

    * Идентификатор требуемой резервной копии в параметре `backupId`. Чтобы узнать идентификатор, [получите список резервных копий в кластере](#list-backups).
    * Имя нового кластера, который будет содержать восстановленные из резервной копии данные, в параметре `name`. Имя кластера должно быть уникальным в рамках каталога.

    В параметре `recoveryTargetSpec.timestamp` укажите момент времени, на который нужно восстановить состояние кластера {{ MG }}, в формате [UNIX time](https://ru.wikipedia.org/wiki/Unix-время). Если параметр не задан, восстановится состояние кластера на момент завершения создания резервной копии.

{% endlist %}

## Создать резервную копию {#create-backup}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.backups.button_create }}**.

  {% include [no-prompt](../../_includes/mdb/backups/no-prompt.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать резервную копию кластера:

  1. Посмотрите описание команды CLI для создания резервной копии {{ MG }}:

      ```bash
      {{ yc-mdb-mg }} cluster backup --help
      ```

  1. Запросите создание резервной копии, указав идентификатор или имя кластера:

      ```bash
      {{ yc-mdb-mg }} cluster backup <имя_или_идентификатор_кластера>
      ```

      Идентификатор и имя кластера можно получить со [списком кластеров](cluster-list.md#list-clusters).

- API {#api}

    Чтобы создать резервную копию, воспользуйтесь методом REST API [backup](../api-ref/Cluster/backup.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Backup](../api-ref/grpc/Cluster/backup.md) и передайте в запросе идентификатор кластера в параметре `clusterId`.

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

{% include [backup-warning](../../_includes/mdb/backups/backup-create-warning.md) %}

## Получить список резервных копий {#list-backups}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы получить список резервных копий кластера:

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}**.

  Чтобы получить список всех резервных копий в каталоге:

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}**.

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

  Чтобы получить список резервных копий кластеров {{ MG }}, доступных в каталоге по умолчанию, выполните команду:

  ```bash
  {{ yc-mdb-mg }} backup list
  ```

  Результат:

  ```text
  +--------------------------+---------------------+----------------------+---------------------+--------+-----------+
  |            ID            |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      |  SIZE  |   TYPE    |
  +--------------------------+---------------------+----------------------+---------------------+--------+-----------+
  | c9qlk4v13uq7********:... | 2020-08-10 12:00:00 | c9qlk4v13uq7******** | 2020-08-10 11:55:17 | 3.3 KB | AUTOMATED |
  | c9qpm90p3pcg********:... | 2020-08-09 22:01:04 | c9qpm90p3pcg******** | 2020-08-09 21:30:00 | 30 KB  | MANUAL    |
  +--------------------------+---------------------+----------------------+---------------------+--------+-----------+
  ```

  В выведенной таблице содержится следующая информация:
  * Идентификатор резервной копии.
  * Время окончания создания резервной копии по UTC (Coordinated Universal Time).
  * Идентификатор кластера, для которого создавалась эта резервная копия.
  * Время начала создания резервной копии по UTC.
  * Размер резервной копии.
  * Тип резервной копии: автоматическая (`AUTOMATED`) или ручная (`MANUAL`).

- API {#api}

    Чтобы получить список резервных копий кластера, воспользуйтесь методом REST API [listBackups](../api-ref/Cluster/listBackups.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/ListBackups](../api-ref/grpc/Cluster/listBackups.md) и передайте в запросе идентификатор кластера в параметре `clusterId`. 

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    Чтобы получить список резервных копий всех кластеров {{ mmg-name }} в каталоге, воспользуйтесь методом REST API [list](../api-ref/Backup/list.md) для ресурса [Backup](../api-ref/Backup/index.md) или вызовом gRPC API [BackupService/List](../api-ref/grpc/Backup/list.md) и передайте в запросе идентификатор каталога в параметре `folderId`.

{% endlist %}

## Получить информацию о резервной копии {#get-backup}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы получить информацию о резервной копии существующего кластера:
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}**.

  Чтобы получить информацию о резервной копии удаленного ранее кластера:
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить данные о резервной копии кластера {{ MG }}, выполните команду:

  ```bash
  {{ yc-mdb-mg }} backup get <идентификатор_резервной_копии>
  ```

  Идентификатор резервной копии можно получить со [списком резервных копий](#list-backups).

- API {#api}

    Чтобы получить информацию о резервной копии, воспользуйтесь методом REST API [get](../api-ref/Backup/get.md) для ресурса [Backup](../api-ref/Backup/index.md) или вызовом gRPC API [BackupService/Get](../api-ref/grpc/Backup/get.md) и передайте в запросе идентификатор резервной копии в параметре `backupId`.

    Чтобы узнать идентификатор, [получите список резервных копий](#list-backups).

{% endlist %}

## Задать срок хранения автоматических резервных копий {#set-backup-retain}

{% list tabs group=instructions %}

- Консоль управления {#console}

  В [консоли управления]({{ link-console-main }}) задать срок хранения автоматических резервных копий можно при [создании](cluster-create.md) или [изменении кластера](update.md).

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы задать срок хранения автоматических резервных копий, передайте нужное значение в аргументе `--backup-retain-period-days` команды изменения кластера:

    ```bash
    {{ yc-mdb-mg }} cluster update <имя_или_идентификатор_кластера> \
       --backup-retain-period-days=<срок_хранения_в_днях>
    ```

  Допустимые значения: от `7` до `35`. Значение по умолчанию — `7`.

  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера {{ MG }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mmg }}).

    1. Добавьте к описанию кластера {{ MG }} блок `backup_retain_period_days` в секции `cluster_config`:

        ```hcl
          resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
            ...
            cluster_config {
              ...
              backup_retain_period_days = <срок_хранения_в_днях>
              }
              ...
            }
            ...
        ```

       Где `backup_retain_period_days` — срок хранения автоматических резервных копий. 
       
       Допустимые значения: от `7` до `35`. Значение по умолчанию — `7`.

  1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

      {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

      ```bash
      curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<идентификатор_кластера>' \
          --data '{
                    "updateMask": "configSpec.backupRetainPeriodDays",
                    "configSpec": {
                      "backupRetainPeriodDays": <срок_хранения_в_днях>
                    }
                  }'
      ```

      Где:

      * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

          В данном случае передается только один параметр.

      * `configSpec.backupRetainPeriodDays` — срок хранения автоматических резервных копий.

          Допустимые значения — от `7` до `35`. Значение по умолчанию — `7`.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  
  1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

      {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "update_mask": {
                  "paths": [
                    "config_spec.backup_retain_period_days"
                  ]
                },
                "config_spec": {
                  "backup_retain_period_days": <срок_хранения_в_днях>
                }
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mongodb.v1.ClusterService.Update
      ```

      Где:

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

          В данном случае передается только один параметр.

      * `config_spec.backup_retain_period_days` — срок хранения автоматических резервных копий.

          Допустимые значения — от `7` до `35`. Значение по умолчанию — `7`.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.mongodb.v1.Cluster).

{% endlist %}         

## Примеры {#examples}

Создайте новый кластер {{ mmg-name }} из резервной копии с тестовыми характеристиками:


* Резервная копия для восстановления: `c9qlk4v13uq7********:...`.
* Момент времени, на который нужно восстановить: `1597060810` (`2020-08-10 12:00:10`).
* Версия: `5.0`.
* Имя нового кластера: `mynewmg`.
* Окружение: `PRODUCTION`.
* Сеть: `{{ network-name }}`.
* Один хост класса `{{ host-class }}` в зоне доступности `{{ region-id }}-a` и в подсети `b0rcctk2rvtr********`.
* Хранилище на сетевых SSD-дисках (`{{ disk-type-example }}`) размером 20 ГБ.     
* С базами данных и пользователями, которые существовали в кластере на момент восстановления.


{% list tabs group=instructions %}

- CLI {#cli}

  Выполните следующую команду:


  ```bash
  {{ yc-mdb-mg }} cluster restore \
     --backup-id c9qlk4v13uq7********:... \
     --recovery-target-timestamp 1597060810 \
     --mongodb-version 5.0 \
     --name mynewmg \
     --environment PRODUCTION \
     --network-name {{ network-name }} \
     --host {{ host-net-example }} \
     --mongod-resource-preset {{ host-class }} \
     --mongod-disk-size 20 \
     --mongod-disk-type {{ disk-type-example }}
  ```


{% endlist %}
