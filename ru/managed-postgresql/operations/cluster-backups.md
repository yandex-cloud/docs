---
title: Управление резервными копиями PostgreSQL
description: Вы можете создавать резервные копии и восстанавливать кластеры из имеющихся резервных копий PostgreSQL. Технология Point-in-Time Recovery (PITR) позволяет восстановить состояние кластера на любой момент времени, начиная от создания резервной копии.
---

# Управление резервными копиями в {{ mpg-name }}


Вы можете создавать [резервные копии](../concepts/backup.md) и восстанавливать кластеры из имеющихся резервных копий.

Также {{ mpg-name }} ежедневно создает автоматическую резервную копию. Вы можете [задать время начала резервного копирования](#set-backup-window) и [установить срок хранения](#set-backup-retain) для нее.

## Восстановить кластер из резервной копии {#restore}

Технология Point-in-Time Recovery (PITR) позволяет восстановить состояние кластера на любой момент времени в интервале от создания самой старой полной резервной копии до архивации самого свежего журнала опережающей записи (Write Ahead Log, WAL). Подробнее см. в разделе [Резервные копии](../concepts/backup.md).

Восстанавливая кластер из резервной копии, вы создаете новый кластер с данными из резервной копии. Если в каталоге не хватает [ресурсов](../concepts/limits.md) для создания такого кластера, восстановиться из резервной копии не получится. Средняя скорость восстановления из резервной копии — 10 МБайт/с на каждое ядро БД.

Для нового кластера необходимо задать все параметры, обязательные при его создании.

При восстановлении до состояния на текущий момент времени новый кластер будет отражать состояние:

* существующего кластера на момент восстановления;
* удаленного кластера на момент архивации последнего журнала опережающей записи.

{% include [manual-backup-restore](../../_includes/mdb/mpg/note-warn-restore-manual-backup.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  **Чтобы восстановить из резервной копии существующий кластер:**

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) для нужной резервной копии, затем нажмите **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
  1. Задайте настройки нового кластера. В списке **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** можно выбрать каталог для нового кластера.
  1. Чтобы восстановить состояние кластера на требуемый момент времени после создания этой резервной копии, задайте нужное значение настройки **{{ ui-key.yacloud.mdb.forms.field_date }}**. Значение можно ввести вручную или выбрать из выпадающего календаря.

     Если оставить настройку без изменений, кластер будет восстановлен в состояние на момент завершения создания резервной копии.

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.

  **Чтобы восстановить из резервной копии удаленный ранее кластер:**

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Выберите вкладку **{{ ui-key.yacloud.postgresql.switch_backups }}**.
  1. Найдите нужную резервную копию по времени создания и идентификатору кластера. В колонке **{{ ui-key.yacloud.common.id }}** содержатся идентификаторы в формате `<идентификатор_кластера>:<идентификатор_резервной_копии>`.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) для нужной резервной копии, затем нажмите **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
  1. Задайте настройки нового кластера. В списке **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** можно выбрать каталог для нового кластера.
  1. Чтобы восстановить состояние кластера на требуемый момент времени после создания этой резервной копии, задайте нужное значение настройки **{{ ui-key.yacloud.mdb.forms.field_date }}**. Значение можно ввести вручную или выбрать из выпадающего календаря.

     Если оставить настройку без изменений, кластер будет восстановлен в состояние на момент завершения создания резервной копии.

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
  
  {{ mpg-name }} запустит операцию создания кластера из резервной копии.
  
- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  По умолчанию кластер будет восстановлен в тот же каталог, где находится резервная копия. Чтобы восстановить кластер в другом каталоге, укажите идентификатор этого каталога в параметре `--folder-id`.
  
  Чтобы восстановить кластер из резервной копии:
  
  1. Посмотрите описание команды CLI для восстановления кластера {{ PG }}:
  
      ```bash
      {{ yc-mdb-pg }} cluster restore --help
      ```
  
  1. Получите список доступных резервных копий кластеров {{ PG }}:
  
      ```bash
      {{ yc-mdb-pg }} backup list
      ```
  
      ```text
      +--------------------------+---------------------+----------------------+---------------------+
      |              ID          |      CREATED AT     |  SOURCE CLUSTER ID   |      STARTED AT     |
      +--------------------------+---------------------+----------------------+---------------------+
      | c9qlk4v13uq7********:... | 2020-08-10 12:00:00 | c9qlk4v13uq7******** | 2020-08-10 11:55:17 |
      | ...                                                                                         |
      +--------------------------+---------------------+----------------------+---------------------+
      ```

      Время завершения создания резервной копии указано в столбце `CREATED AT` списка доступных резервных копий в формате `yyyy-mm-dd hh:mm:ss` (`2020-08-10 12:00:00` в примере выше). Вы можете восстановить состояние кластера на любой момент времени, начиная от создания резервной копии.

  1. Запросите создание кластера из резервной копии:


      ```bash
      {{ yc-mdb-pg }} cluster restore \
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
      * `--time` — момент времени, на который нужно восстановить состояние кластера {{ PG }}, в формате `yyyy-mm-ddThh:mm:ssZ`.
      * `--name` — имя кластера.
      * `--environment` — окружение:

          * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.
          * `PRODUCTION` — для стабильных версий ваших приложений.

      * `--network-name` — [имя сети](../../vpc/concepts/network.md#network).
      * `--host` — параметры хоста:

          * `zone-id` — [зона доступности](../../overview/concepts/geo-scope.md).


          * `subnet-name` — [имя подсети](../../vpc/concepts/network.md#subnet). Необходимо указывать, если в выбранной зоне доступности создано две или больше подсетей.
          * `assign-public-ip` — флаг, который указывается, если требуется [публичный доступ к хосту](../concepts/network.md#public-access-to-a-host): `true` или `false`.


      * `--resource-preset` — [класс хоста](../concepts/instance-types.md#available-flavors).
      * `--disk-size` — размер хранилища в гигабайтах.
      * `--disk-type` — [тип диска](../concepts/storage.md):


          * `network-hdd`;
          * `network-ssd`;
          * `local-ssd`;
          * `network-ssd-nonreplicated`;
          * `network-ssd-io-m3`.


- {{ TF }} {#tf}

  Используйте {{ TF }} для восстановления:

   * Существующего кластера из резервной копии.
   * Кластера, созданного и удаленного через Консоль управления, CLI или API.

   {% note info %}

   Кластер будет восстановлен в каталог, идентификатор которого указан в [настройках провайдера]({{ tf-provider-link }}) в параметре `folder_id`.

   {% endnote %}

   Для восстановления потребуется идентификатор резервной копии. Получите список доступных резервных копий кластеров {{ PG }} [с помощью CLI](#list-backups):

   ```bash
   {{ yc-mdb-pg }} backup list
   ```

   ```text
   +--------------------------+---------------------+----------------------+---------------------+
   |            ID            |      CREATED AT     |  SOURCE CLUSTER ID   |      STARTED AT     |
   +--------------------------+---------------------+----------------------+---------------------+
   | c9qlk4v13uq7********:... | 2020-08-10 12:00:00 | c9qlk4v13uq7******** | 2020-08-10 11:55:17 |
   | ...                                                                                         |
   +--------------------------+---------------------+----------------------+---------------------+
   ```

   {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

   **Чтобы восстановить из резервной копии существующий кластер:**

   1. Создайте [конфигурационный файл {{ TF }}](cluster-create.md#create-cluster) для нового кластера.

       При этом не используйте ресурсы баз данных (`yandex_mdb_postgresql_database`) и пользователей (`yandex_mdb_postgresql_user`) — они будут восстановлены из резервной копии.

   1. Добавьте в конфигурационный файл блок `restore`:

       ```hcl
       resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
         ...
         restore {
           backup_id = "<идентификатор_резервной_копии>"
           time      = "<время>"
         }
       }
       ```

       Где:

       * `backup_id` — идентификатор резервной копии.
       * `time` — момент времени, на который нужно восстановить состояние кластера {{ PG }}, начиная со времени создания выбранной резервной копии. Формат: `yyyy-mm-ddThh:mm:ss`.

       {% note info %}

       Если параметр `time` не указан, кластер будет восстановлен на момент завершения создания резервной копии.

       {% endnote %}

   1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  {{ TF }} создаст копию существующего кластера. Базы данных и пользователи будут развернуты из выбранной резервной копии.

  **Чтобы восстановить из резервной копии удаленный ранее кластер:**

   1. Создайте [конфигурационный файл {{ TF }}](cluster-create.md#create-cluster) для нового кластера.

       При этом не используйте ресурсы баз данных (`yandex_mdb_postgresql_database`) и пользователей (`yandex_mdb_postgresql_user`) — они будут восстановлены из резервной копии.

   1. Добавьте в этот конфигурационный файл блок `restore` с именем резервной копии, из которой нужно восстановиться:

       ```hcl
       resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
         ...
         restore {
             backup_id = "<идентификатор_резервной_копии>"
         }
       }
       ```

       Где `backup-id` — идентификатор резервной копии удаленного кластера.

   1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  {{ TF }} создаст новый кластер. Базы данных и пользователи будут развернуты из резервной копии.

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
       "configSpec": {
         "version": "<версия_{{ PG }}>",
         "resources": {
           "resourcePresetId": "<класс_хостов>",
           "diskSize": "<размер_хранилища_в_байтах>",
           "diskTypeId": "<тип_диска>"
         }
       },
       "hostSpecs": [
         {
           "zoneId": "<зона_доступности>",
           "subnetId": "<идентификатор_подсети>",
           "assignPublicIp": <публичный_адрес_хоста:_true_или_false>
         }
       ]
     }
     ```

     Где:

     * `backupId` — идентификатор [резервной копии](../concepts/backup.md). Его можно запросить со [списком резервных копий](#list-backups).
     * `time` — момент времени, на который нужно восстановить состояние кластера {{ PG }}, в формате `yyyy-mm-ddThh:mm:ssZ`.
     * `folderId` — идентификатор каталога, где будет восстановлен кластер. Идентификатор можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
     * `name` — имя кластера.
     * `environment` — окружение:

       * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.
       * `PRODUCTION` — для стабильных версий ваших приложений.

     * `networkId` — идентификатор [сети](../../vpc/concepts/network.md#network).
     * `configSpec` — настройки кластера:

       * `version` — версия {{ PG }}.
       * `resources` — ресурсы кластера:

         * `resourcePresetId` — [класс хостов](../concepts/instance-types.md);
         * `diskSize` — размер диска в байтах;
         * `diskTypeId` — [тип диска](../concepts/storage.md).

     * `hostSpecs` — настройки хостов кластера в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

       * `zoneId` — [зона доступности](../../overview/concepts/geo-scope.md);
       * `subnetId` — идентификатор [подсети](../../vpc/concepts/network.md#subnet);
       * `assignPublicIp` — разрешение на [подключение](connect.md) к хосту из интернета.

  1. Воспользуйтесь методом [Cluster.Restore](../api-ref/Cluster/restore.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters:restore' \
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
       "config_spec": {
         "version": "<версия_{{ PG }}>",
         "resources": {
           "resource_preset_id": "<класс_хостов>",
           "disk_size": "<размер_хранилища_в_байтах>",
           "disk_type_id": "<тип_диска>"
         }
       },
       "host_specs": [
         {
           "zone_id": "<зона_доступности>",
           "subnet_id": "<идентификатор_подсети>",
           "assign_public_ip": <публичный_адрес_хоста:_true_или_false>
         }
       ]
     }
     ```

     Где:

     * `backup_id` — идентификатор [резервной копии](../concepts/backup.md). Его можно запросить со [списком резервных копий](#list-backups).
     * `time` — момент времени, на который нужно восстановить состояние кластера {{ PG }}, в формате `yyyy-mm-ddThh:mm:ssZ`.
     * `folder_id` — идентификатор каталога, где будет восстановлен кластер. Идентификатор можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
     * `name` — имя кластера.
     * `environment` — окружение:

       * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.
       * `PRODUCTION` — для стабильных версий ваших приложений.

     * `network_id` — идентификатор [сети](../../vpc/concepts/network.md#network).
     * `config_spec` — настройки кластера:

       * `version` — версия {{ PG }}.
       * `resources` — ресурсы кластера:

         * `resource_preset_id` — [класс хостов](../concepts/instance-types.md);
         * `disk_size` — размер диска в байтах;
         * `disk_type_id` — [тип диска](../concepts/storage.md).

     * `host_specs` — настройки хостов кластера в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

       * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md);
       * `subnet_id` — идентификатор [подсети](../../vpc/concepts/network.md#subnet);
       * `assign_public_ip` — разрешение на [подключение](connect.md) к хосту из интернета.

  1. Воспользуйтесь вызовом [ClusterService.Restore](../api-ref/grpc/Cluster/restore.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d @ \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Restore \
       < body.json
     ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/restore.md#yandex.cloud.operation.Operation).

{% endlist %}

## Создать резервную копию {#create-backup}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}**.
  1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.mdb.cluster.backups.button_create }}**.

  {% include [no-prompt](../../_includes/mdb/backups/no-prompt.md) %}

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы создать резервную копию кластера:
  
  1. Посмотрите описание команды CLI для создания резервной копии {{ PG }}:
  
      ```
      {{ yc-mdb-pg }} cluster backup --help
      ```
  1. Запросите создание резервной копии, указав имя или идентификатор кластера:
  
      ```
      {{ yc-mdb-pg }} cluster backup my-pg-cluster
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
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>:backup'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/backup.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService.Backup](../api-ref/grpc/Cluster/backup.md#yandex.cloud.mdb.postgresql.v1.Backup) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Backup
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/backup.md#yandex.cloud.operation.Operation).

{% endlist %}

{% include [backup-warning](../../_includes/mdb/backups/backup-create-warning.md) %}

## Получить список резервных копий {#list-backups}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы получить список резервных копий кластера:
  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}**.

  Чтобы получить список всех резервных копий в каталоге:
  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Выберите вкладку **{{ ui-key.yacloud.postgresql.switch_backups }}**.
  
- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы получить список резервных копий кластеров {{ PG }}, доступных в каталоге по умолчанию, выполните команду:
  
  ```
  {{ yc-mdb-pg }} backup list
  
  +--------------------------+---------------------+----------------------+---------------------+
  |            ID            |      CREATED AT     |  SOURCE CLUSTER ID   |      STARTED AT     |
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
           --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>/backups'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

     1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listBackups.md#yandex.cloud.mdb.postgresql.v1.ListClusterBackupsResponse).

  1. Чтобы получить список резервных копий всех кластеров в каталоге:

     1. Воспользуйтесь методом [Backup.List](../api-ref/Backup/list.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
           --request GET \
           --header "Authorization: Bearer $IAM_TOKEN" \
           --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/backups' \
           --url-query folderId=<идентификатор_каталога>
        ```


        Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


     1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Backup/list.md#yandex.cloud.mdb.postgresql.v1.ListBackupsResponse).

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
          -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.postgresql.v1.ClusterService.ListBackups
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

     1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listBackups.md#yandex.cloud.mdb.postgresql.v1.ListClusterBackupsResponse).

  1. Чтобы получить список резервных копий всех кластеров в каталоге:

     1. Воспользуйтесь вызовом [BackupService.List](../api-ref/grpc/Backup/list.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/backup_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "folder_id": "<идентификатор_каталога>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.postgresql.v1.BackupService.List
        ```


        Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


     1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Backup/list.md#yandex.cloud.mdb.postgresql.v1.ListBackupsResponse).

{% endlist %}

## Получить информацию о резервной копии {#get-backup}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы получить информацию о резервной копии существующего кластера:
  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}**.

  Чтобы получить информацию о резервной копии удаленного ранее кластера:
  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Выберите вкладку **{{ ui-key.yacloud.postgresql.switch_backups }}**.
  
- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы получить данные о резервной копии кластера {{ PG }}, выполните команду:
  
  ```
  {{ yc-mdb-pg }} backup get <идентификатор_резервной_копии>
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
        --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/backups/<идентификатор_резервной_копии>'
     ```

     Идентификатор резервной копии можно запросить со [списком резервных копий](#list-backups).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Backup/get.md#yandex.cloud.mdb.postgresql.v1.Backup).

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
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/backup_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "backup_id": "<идентификатор_резервной_копии>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.BackupService.Get
     ```

     Идентификатор резервной копии можно запросить со [списком резервных копий](#list-backups).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Backup/get.md#yandex.cloud.mdb.postgresql.v1.Backup).

{% endlist %}

## Задать время начала резервного копирования {#set-backup-window}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  В консоли управления задать время начала резервного копирования можно при [создании](cluster-create.md) или [изменении кластера](update.md).

- CLI {#cli}

  Чтобы задать время начала резервного копирования, используйте флаг `--backup-window-start`. Время задается в формате `ЧЧ:ММ:СС`.

  ```bash
  {{ yc-mdb-pg }} cluster create \
     --cluster-name <имя_кластера> \
     --environment <окружение> \
     --network-name <имя_сети> \
     --host zone-id=<зона_доступности>,subnet-id=<идентификатор_подсети> \
     --resource-preset <класс_хоста> \
     --user name=<имя_пользователя>,password=<пароль_пользователя> \
     --database name=<имя_БД>,owner=<имя_владельца_БД> \
     --disk-size <размер_хранилища_ГБ>
     --backup-window-start 10:00:00
  ```

  Где `environment` — окружение: `prestable` или `production`.

  Изменить время начала резервного копирования в существующем кластере можно с помощью команды `update`:

  ```bash
  {{ yc-mdb-pg }} cluster update \
     --cluster-name <имя_кластера> \
     --backup-window-start 11:25:00
  ```

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).

    1. Добавьте к описанию кластера {{ mpg-name }} блок `backup_window_start` в секции `config`:

        ```hcl
        resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
          ...
          config {
            ...
            backup_window_start {
              hours   = <час>
              minutes = <минута>
            }
            ...
          }
          ...
        ```

        Где:

        * `hours` — час начала резервного копирования (UTC).
        * `minutes` — минута начала резервного копирования (UTC).

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

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
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>' \
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

       В параметре укажите время, когда начинать резервное копирование. Возможные значения параметров:

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
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "update_mask": {
               "paths": [
                 "config_spec.backup_window_start"
               ]
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
       yandex.cloud.mdb.postgresql.v1.ClusterService.Update
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

       В данном случае передается только один параметр.

     * `config_spec.backup_window_start` — настройки окна [резервного копирования](../concepts/backup.md).

       В параметре укажите время, когда начинать резервное копирование. Возможные значения параметров:

       * `hours` — от `0` до `23` часов;
       * `minutes` — от `0` до `59` минут;
       * `seconds` — от `0` до `59` секунд;
       * `nanos` — от `0` до `999999999` наносекунд.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.Cluster).

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
    {{ yc-mdb-pg }} cluster update <имя_или_идентификатор_кластера> \
       --backup-retain-period-days=<срок_хранения_в_днях>
    ```

  Допустимые значения: от `7` до `60`. Значение по умолчанию — `7`.

  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).

    1. Добавьте к описанию кластера {{ mpg-name }} блок `backup_retain_period_days` в секции `config`:

        ```hcl
          resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
            ...
            config {
              ...
              backup_retain_period_days = <срок_хранения_в_днях>
              }
              ...
            }
            ...
        ```

       Где `backup_retain_period_days` — срок хранения автоматических резервных копий. 
       
       Допустимые значения: от `7` до `60`. Значение по умолчанию — `7`.

  1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1.  Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

       {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

       ```bash
       curl \
         --request PATCH \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --header "Content-Type: application/json" \
         --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>' \
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
 
         Допустимые значения — от `7` до `60`. Значение по умолчанию — `7`.

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
        -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
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
        yandex.cloud.mdb.postgresql.v1.ClusterService.Update
        ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

       В данном случае передается только один параметр.

     * `config_spec.backup_retain_period_days` — срок хранения автоматических резервных копий.

       Допустимые значения — от `7` до `60`. Значение по умолчанию — `7`.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.mdb.postgresql.v1.Cluster).

{% endlist %}

## Удалить резервную копию {#delete}

Вы можете удалить только те резервные копии, которые были созданы вручную.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
    1. Выберите кластер {{ mpg-name }}, резервную копию которого нужно удалить.
    1. На левой панели выберите раздел **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}**.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) справа в строке резервной копии, которую вы хотите удалить.
    1. Выберите пункт **{{ ui-key.yacloud.mdb.cluster.backups.button_delete }}**.
    1. Подтвердите удаление и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.backups.action_delete-backup }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы удалить резервную копию:

    1. Посмотрите описание команды CLI для удаления резервной копии {{ PG }}:

        ```bash
        {{ yc-mdb-pg }} backup delete --help
        ```

    1. Запросите удаление резервной копии, указав ее идентификатор:

        ```bash
        {{ yc-mdb-pg }} backup delete <идентификатор_резервной_копии>
        ```

    Идентификатор резервной копии можно получить со [списком резервных копий](#list-backups).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Backup.Delete](../api-ref/Backup/delete.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/backups/<идентификатор_резервной_копии>'
     ```

     Идентификатор резервной копии можно запросить со [списком резервных копий](#list-backups).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Backup/delete.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [BackupService.Delete](../api-ref/grpc/Backup/delete.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/backup_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "backup_id": "<идентификатор_резервной_копии>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.BackupService.Delete
     ```

     Идентификатор резервной копии можно запросить со [списком резервных копий](#list-backups).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Backup/delete.md#yandex.cloud.operation.Operation).

{% endlist %}
