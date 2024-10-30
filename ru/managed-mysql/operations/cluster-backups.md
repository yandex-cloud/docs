---
title: Управление резервными копиями MySQL
description: Вы можете создавать резервные копии и восстанавливать кластеры из имеющихся резервных копий MySQL. Технология Point-in-Time Recovery (PITR) позволяет восстановить состояние кластера на любой момент времени, начиная от создания резервной копии.
---

# Управление резервными копиями в {{ mmy-name }}

Вы можете создавать резервные копии и восстанавливать кластеры из имеющихся резервных копий, в том числе на указанный момент времени. Подробнее см. в разделе [Резервные копии](../concepts/backup.md).

Также {{ mmy-name }} ежедневно создает автоматическую резервную копию. Вы можете [задать время начала резервного копирования](#set-backup-window) и [срок хранения](#set-backup-retain) для нее.

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

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Чтобы получить список резервных копий кластера:

      1. Воспользуйтесь методом [Cluster.listBackups](../api-ref/Cluster/listBackups.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

          ```bash
          curl \
              --request GET \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>/backups'
          ```

          Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

      1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listBackups.md#yandex.cloud.mdb.mysql.v1.ListClusterBackupsResponse).

  1. Чтобы получить список резервных копий всех кластеров в каталоге:

      1. Воспользуйтесь методом [Backup.list](../api-ref/Backup/list.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

          ```bash
          curl \
              --request GET \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --url 'https://{{ api-host-mdb }}/managed-mysql/v1/backups' \
              --url-query folderId=<идентификатор_каталога>
          ```


          Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


      1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Backup/list.md#yandex.cloud.mdb.mysql.v1.ListBackupsResponse).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Чтобы получить список резервных копий кластера:

      1. Воспользуйтесь вызовом [ClusterService/ListBackups](../api-ref/grpc/Cluster/listBackups.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

          ```bash
          grpcurl \
              -format json \
              -import-path ~/cloudapi/ \
              -import-path ~/cloudapi/third_party/googleapis/ \
              -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
              -rpc-header "Authorization: Bearer $IAM_TOKEN" \
              -d '{
                    "cluster_id": "<идентификатор_кластера>"
                  }' \
              {{ api-host-mdb }}:{{ port-https }} \
              yandex.cloud.mdb.mysql.v1.ClusterService.ListBackups
          ```

          Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

      1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listBackups.md#yandex.cloud.mdb.mysql.v1.ListClusterBackupsResponse).

  1. Чтобы получить список резервных копий всех кластеров в каталоге:

      1. Воспользуйтесь вызовом [BackupService/List](../api-ref/grpc/Backup/list.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

          ```bash
          grpcurl \
              -format json \
              -import-path ~/cloudapi/ \
              -import-path ~/cloudapi/third_party/googleapis/ \
              -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/backup_service.proto \
              -rpc-header "Authorization: Bearer $IAM_TOKEN" \
              -d '{
                    "folder_id": "<идентификатор_каталога>"
                  }' \
              {{ api-host-mdb }}:{{ port-https }} \
              yandex.cloud.mdb.mysql.v1.BackupService.List
          ```


          Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


      1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Backup/list.md#yandex.cloud.mdb.mysql.v1.ListBackupsResponse).

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

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Backup.get](../api-ref/Backup/get.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/backups/<идентификатор_резервной_копии>'
      ```

      Идентификатор резервной копии можно запросить со [списком резервных копий](#list-backups).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Backup/get.md#yandex.cloud.mdb.mysql.v1.Backup).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [BackupService/Get](../api-ref/grpc/Backup/get.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/backup_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "backup_id": "<идентификатор_резервной_копии>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.BackupService.Get
      ```

      Идентификатор резервной копии можно запросить со [списком резервных копий](#list-backups).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Backup/get.md#yandex.cloud.mdb.mysql.v1.Backup).

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

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.backup](../api-ref/Cluster/backup.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>:backup'
      ```

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/backup.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService/Backup](../api-ref/grpc/Cluster/get.md#yandex.cloud.mdb.mysql.v1.Backup) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.Backup
      ```

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

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
          backup_id = "<идентификатор_резервной_копии>"
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
      * `time` — момент времени, на который нужно восстановить состояние кластера {{ MY }}, в формате `yyyy-mm-ddThh:mm:ssZ`.
      * `folderId` — идентификатор каталога, где будет восстановлен кластер. Идентификатор можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
      * `name` — имя кластера.
      * `environment` — окружение:

          * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.
          * `PRODUCTION` — для стабильных версий ваших приложений.

      * `networkId` — идентификатор [сети](../../vpc/concepts/network.md#network).
      * `configSpec` — настройки кластера:

          * `version` — версия {{ MY }}.
          * `resources` — ресурсы кластера:

              * `resourcePresetId` — [класс хостов](../concepts/instance-types.md);
              * `diskSize` — размер диска в байтах;
              * `diskTypeId` — [тип диска](../concepts/storage.md).

      * `hostSpecs` — настройки хостов кластера в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

          * `zoneId` — [зона доступности](../../overview/concepts/geo-scope.md);
          * `subnetId` — идентификатор [подсети](../../vpc/concepts/network.md#subnet);
          * `assignPublicIp` — разрешение на [подключение](connect.md) к хосту из интернета.

  1. Воспользуйтесь методом [Cluster.restore](../api-ref/Cluster/restore.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters:restore' \
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
              "version": "<версия_{{ MY }}>",
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
      * `time` — момент времени, на который нужно восстановить состояние кластера {{ MY }}, в формате `yyyy-mm-ddThh:mm:ssZ`.
      * `folder_id` — идентификатор каталога, где будет восстановлен кластер. Идентификатор можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
      * `name` — имя кластера.
      * `environment` — окружение:

          * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.
          * `PRODUCTION` — для стабильных версий ваших приложений.

      * `network_id` — идентификатор [сети](../../vpc/concepts/network.md#network).
      * `config_spec` — настройки кластера:

          * `version` — версия {{ MY }}.
          * `resources` — ресурсы кластера:

              * `resource_preset_id` — [класс хостов](../concepts/instance-types.md);
              * `disk_size` — размер диска в байтах;
              * `disk_type_id` — [тип диска](../concepts/storage.md).

      * `host_specs` — настройки хостов кластера в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

          * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md);
          * `subnet_id` — идентификатор [подсети](../../vpc/concepts/network.md#subnet);
          * `assign_public_ip` — разрешение на [подключение](connect.md) к хосту из интернета.

  1. Воспользуйтесь вызовом [ClusterService/Restore](../api-ref/grpc/Cluster/restore.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.Restore \
          < body.json
      ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

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
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>' \
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
  1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

      {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
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
          yandex.cloud.mdb.mysql.v1.ClusterService.Update
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

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.mysql.v1.Cluster).

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
    {{ yc-mdb-my }} cluster update <имя_или_идентификатор_кластера> \
       --backup-retain-period-days=<срок_хранения_в_днях>
    ```

  Допустимые значения: от `7` до `60`. Значение по умолчанию — `7`.

  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера {{ mmy-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).

    1. Чтобы задать срок хранения автоматических резервных копий, добавьте к описанию кластера {{ mmy-name }} блок `backup_retain_period_days`:

        ```hcl
        resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
          ...
          backup_window_start: <срок_хранения_в_днях>
        }
        ```

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmy }}).

  {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

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
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>' \
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
  
  1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

      {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "update_mask": {
                  "paths": [
                    "config_spec.backup_retain_period_days"
                  ]
                },
                "config_spec": {
                  "backup_retain_period_days": <число_дней>
                }
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.Update
      ```

      Где:

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

          В данном случае передается только один параметр.

      * `config_spec.backup_retain_period_days` — срок хранения автоматических резервных копий.

          Допустимые значения — от `7` до `60`. Значение по умолчанию — `7`.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.mysql.v1.Cluster).

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

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.updateHosts](../api-ref/Cluster/updateHosts.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>/hosts:batchUpdate' \
          --data '{
                    "updateHostSpecs": [
                      {
                        "updateMask": "backupPriority",
                        "hostName": "<FQDN_хоста>",
                        "backupPriority": "<приоритет_хоста_при_резервном_копировании>"
                      }
                    ]
                  }'
      ```

      Где `updateHostSpecs` — массив хостов, которым вы задаете приоритет. Один элемент массива содержит настройки для одного хоста и имеет следующую структуру:

      * `updateMask` — перечень изменяемых параметров в одну строку через запятую;
      * `hostName` — [FQDN изменяемого хоста](connect.md#fqdn);
      * `backupPriority` — [приоритет хоста при резервном копировании](../concepts/backup.md#size): от `0` до `100`.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/updateHosts.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService/UpdateHosts](../api-ref/grpc/Cluster/updateHosts.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "update_host_specs": [
                  {
                    "update_mask": {
                      "paths": [
                        "backup_priority"
                      ]
                    },
                    "host_name": "<FQDN_хоста>",
                    "backup_priority": "<приоритет_хоста_при_резервном_копировании>"
                  }
                ]
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.UpdateHosts
      ```

      Где `update_host_specs` — массив хостов, которым вы задаете приоритет. Один элемент массива содержит настройки для одного хоста и имеет следующую структуру:

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`;
      * `host_name` — [FQDN изменяемого хоста](connect.md#fqdn);
      * `backup_priority` — [приоритет хоста при резервном копировании](../concepts/backup.md#size): от `0` до `100`.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}
