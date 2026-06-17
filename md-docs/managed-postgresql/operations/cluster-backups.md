# Управление резервными копиями в Managed Service for PostgreSQL


Вы можете создавать [резервные копии](../concepts/backup.md) и восстанавливать кластеры из имеющихся резервных копий.

Также Managed Service for PostgreSQL ежедневно создает автоматическую резервную копию. Вы можете [задать время начала резервного копирования](#set-backup-window) и [установить срок хранения](#set-backup-retain) для нее.

## Восстановить кластер из резервной копии {#restore}

{% note warning %}

Для кластеров с неподдерживаемой версией СУБД восстановление из резервных копий недоступно.

{% endnote %}


Перед началом работы [назначьте](../../iam/operations/roles/grant.md) вашему аккаунту в Yandex Cloud роль [managed-postgresql.restorer](../../iam/roles-reference.md#managed-postgresql-restorer) или выше на каталог размещения резервной копии и каталог, где будет развернут новый кластер.


{% note warning %}

Если резервная копия создана вручную, то кластер можно восстановить только в состояние на момент завершения создания резервной копии.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  **Чтобы восстановить из резервной копии существующий кластер:**

  1. Перейдите в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Резервные копии**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) для нужной резервной копии, затем нажмите **Восстановить кластер**.
  1. Задайте настройки нового кластера. В списке **Каталог** можно выбрать каталог для нового кластера.
  1. Чтобы восстановить состояние кластера на требуемый момент времени после создания этой резервной копии, задайте нужное значение настройки **Дата и время восстановления (UTC)**. Значение можно ввести вручную или выбрать из выпадающего календаря.

     Если оставить настройку без изменений, кластер будет восстановлен в состояние на момент завершения создания резервной копии.

  1. Нажмите кнопку **Восстановить кластер**.

  **Чтобы восстановить из резервной копии удаленный ранее кластер:**

  1. Перейдите в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Выберите вкладку **Резервные копии**.
  1. Найдите нужную резервную копию по времени создания и идентификатору кластера. В колонке **Идентификатор** содержатся идентификаторы в формате `<идентификатор_кластера>:<идентификатор_резервной_копии>`.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) для нужной резервной копии, затем нажмите **Восстановить кластер**.
  1. Задайте настройки нового кластера. В списке **Каталог** можно выбрать каталог для нового кластера.
  1. Чтобы восстановить состояние кластера на требуемый момент времени после создания этой резервной копии, задайте нужное значение настройки **Дата и время восстановления (UTC)**. Значение можно ввести вручную или выбрать из выпадающего календаря.

     Если оставить настройку без изменений, кластер будет восстановлен в состояние на момент завершения создания резервной копии.

  1. Нажмите кнопку **Восстановить кластер**.
  
  Managed Service for PostgreSQL запустит операцию создания кластера из резервной копии.
  
- CLI {#cli}
  
  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).
  
  По умолчанию кластер будет восстановлен в тот же каталог, где находится резервная копия. Чтобы восстановить кластер в другом каталоге, укажите идентификатор этого каталога в параметре `--folder-id`.
  
  Чтобы восстановить кластер из резервной копии:
  
  1. Посмотрите описание команды CLI для восстановления кластера PostgreSQL:
  
      ```bash
      yc managed-postgresql cluster restore --help
      ```
  
  1. Получите список доступных резервных копий кластеров PostgreSQL:
  
      ```bash
      yc managed-postgresql backup list
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
      yc managed-postgresql cluster restore \
         --backup-id=<идентификатор_резервной_копии> \
         --time=<время> \
         --name=<имя_кластера> \
         --environment=<окружение> \
         --network-name=<имя_сети> \
         --host zone-id=<зона_доступности>,`
               `subnet-name=<имя_подсети>,`
               `assign-public-ip=<разрешить_публичный_доступ_к_хосту> \
         --resource-preset=<класс_хоста> \
         --disk-size=<размер_хранилища_ГБ> \
         --disk-type=<тип_диска>
      ```


      Где:

      * `--backup-id` — идентификатор [резервной копии](../concepts/backup.md).
      * `--time` — момент времени, на который нужно восстановить состояние кластера PostgreSQL, в формате `yyyy-mm-ddThh:mm:ssZ`.
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


- Terraform {#tf}

  Используйте Terraform для восстановления:

   * Существующего кластера из резервной копии.
   * Кластера, созданного и удаленного через Консоль управления, CLI или API.

   {% note info %}

   Кластер будет восстановлен в каталог, идентификатор которого указан в [настройках провайдера](../../terraform/index.md) в параметре `folder_id`.

   {% endnote %}

   Для восстановления потребуется идентификатор резервной копии. Получите список доступных резервных копий кластеров PostgreSQL [с помощью CLI](#list-backups):

   ```bash
   yc managed-postgresql backup list
   ```

   ```text
   +--------------------------+---------------------+----------------------+---------------------+
   |            ID            |      CREATED AT     |  SOURCE CLUSTER ID   |      STARTED AT     |
   +--------------------------+---------------------+----------------------+---------------------+
   | c9qlk4v13uq7********:... | 2020-08-10 12:00:00 | c9qlk4v13uq7******** | 2020-08-10 11:55:17 |
   | ...                                                                                         |
   +--------------------------+---------------------+----------------------+---------------------+
   ```

   {% note warning "Ограничения по времени" %}
   
   Провайдер Terraform ограничивает время на выполнение операций с кластером Managed Service for PostgreSQL:
   
   * создание, в том числе путем восстановления из резервной копии, — 30 минут;
   * изменение — 60 минут;
   * удаление — 15 минут.
   
   Операции, длящиеся дольше указанного времени, прерываются.
   
   {% cut "Как изменить эти ограничения?" %}
   
   Добавьте к описанию кластера блок `timeouts`, например:
   
   ```hcl
   resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
     ...
     timeouts {
       create = "1h30m" # Полтора часа
       update = "2h"    # 2 часа
       delete = "30m"   # 30 минут
     }
   }
   ```
   
   {% endcut %}
   
   {% endnote %}

   **Чтобы восстановить из резервной копии существующий кластер:**

   1. Создайте [конфигурационный файл Terraform](cluster-create.md#create-cluster) для нового кластера.

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
       * `time` — момент времени, на который нужно восстановить состояние кластера PostgreSQL, начиная со времени создания выбранной резервной копии. Формат: `yyyy-mm-ddThh:mm:ss`.

       {% note info %}

       Если параметр `time` не указан, кластер будет восстановлен на момент завершения создания резервной копии.

       {% endnote %}

   1. Проверьте корректность настроек.

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.

   1. Подтвердите изменение ресурсов.

      1. Выполните команду для просмотра планируемых изменений:
      
         ```bash
         terraform plan
         ```
      
         Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
      
      1. Если вас устраивают планируемые изменения, внесите их:
         1. Выполните команду:
      
            ```bash
            terraform apply
            ```
      
         1. Подтвердите изменение ресурсов.
         1. Дождитесь завершения операции.

  Terraform создаст копию существующего кластера. Базы данных и пользователи будут развернуты из выбранной резервной копии.

  **Чтобы восстановить из резервной копии удаленный ранее кластер:**

   1. Создайте [конфигурационный файл Terraform](cluster-create.md#create-cluster) для нового кластера.

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

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.

   1. Подтвердите изменение ресурсов.

      1. Выполните команду для просмотра планируемых изменений:
      
         ```bash
         terraform plan
         ```
      
         Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
      
      1. Если вас устраивают планируемые изменения, внесите их:
         1. Выполните команду:
      
            ```bash
            terraform apply
            ```
      
         1. Подтвердите изменение ресурсов.
         1. Дождитесь завершения операции.

  Terraform создаст новый кластер. Базы данных и пользователи будут развернуты из резервной копии.

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

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
         "version": "<версия_PostgreSQL>",
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
           "assignPublicIp": <разрешить_публичный_доступ_к_хосту>
         }
       ]
     }
     ```

     Где:

     * `backupId` — идентификатор [резервной копии](../concepts/backup.md). Его можно запросить со [списком резервных копий](#list-backups).
     * `time` — момент времени, на который нужно восстановить состояние кластера PostgreSQL, в формате `yyyy-mm-ddThh:mm:ssZ`.
     * `folderId` — идентификатор каталога, где будет восстановлен кластер. Идентификатор можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
     * `name` — имя кластера.
     * `environment` — окружение:

       * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.
       * `PRODUCTION` — для стабильных версий ваших приложений.

     * `networkId` — идентификатор [сети](../../vpc/concepts/network.md#network).
     * `configSpec` — настройки кластера:

       * `version` — версия PostgreSQL.
       * `resources` — ресурсы кластера:

         * `resourcePresetId` — [класс хостов](../concepts/instance-types.md);
         * `diskSize` — размер диска в байтах;
         * `diskTypeId` — [тип диска](../concepts/storage.md).

     * `hostSpecs` — настройки хостов кластера в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

       * `zoneId` — [зона доступности](../../overview/concepts/geo-scope.md);
       * `subnetId` — идентификатор [подсети](../../vpc/concepts/network.md#subnet);
       * `assignPublicIp` — разрешение на [подключение](connect/index.md) к хосту из интернета: `true` или `false`.

  1. Воспользуйтесь методом [Cluster.Restore](../api-ref/Cluster/restore.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters:restore' \
       --data "@body.json"
     ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/restore.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
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
         "version": "<версия_PostgreSQL>",
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
           "assign_public_ip": <разрешить_публичный_доступ_к_хосту>
         }
       ]
     }
     ```

     Где:

     * `backup_id` — идентификатор [резервной копии](../concepts/backup.md). Его можно запросить со [списком резервных копий](#list-backups).
     * `time` — момент времени, на который нужно восстановить состояние кластера PostgreSQL, в формате `yyyy-mm-ddThh:mm:ssZ`.
     * `folder_id` — идентификатор каталога, где будет восстановлен кластер. Идентификатор можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
     * `name` — имя кластера.
     * `environment` — окружение:

       * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.
       * `PRODUCTION` — для стабильных версий ваших приложений.

     * `network_id` — идентификатор [сети](../../vpc/concepts/network.md#network).
     * `config_spec` — настройки кластера:

       * `version` — версия PostgreSQL.
       * `resources` — ресурсы кластера:

         * `resource_preset_id` — [класс хостов](../concepts/instance-types.md);
         * `disk_size` — размер диска в байтах;
         * `disk_type_id` — [тип диска](../concepts/storage.md).

     * `host_specs` — настройки хостов кластера в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

       * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md);
       * `subnet_id` — идентификатор [подсети](../../vpc/concepts/network.md#subnet);
       * `assign_public_ip` — разрешение на [подключение](connect/index.md) к хосту из интернета: `true` или `false`.

  1. Воспользуйтесь вызовом [ClusterService.Restore](../api-ref/grpc/Cluster/restore.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d @ \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Restore \
       < body.json
     ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/restore.md#yandex.cloud.operation.Operation).

{% endlist %}

## Создать резервную копию {#create-backup}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. Перейдите в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Резервные копии**.
  1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **Создать резервную копию**.

  Сервис начнет создавать резервную копию без дополнительного подтверждения.

- CLI {#cli}
  
  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).
  
  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
  
  Чтобы создать резервную копию кластера:
  
  1. Посмотрите описание команды CLI для создания резервной копии PostgreSQL:
  
      ```
      yc managed-postgresql cluster backup --help
      ```
  1. Запросите создание резервной копии, указав имя или идентификатор кластера:
  
      ```
      yc managed-postgresql cluster backup my-pg-cluster
      ```
  
      Имя и идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Воспользуйтесь методом [Cluster.Backup](../api-ref/Cluster/backup.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/<идентификатор_кластера>:backup'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/backup.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
  1. Воспользуйтесь вызовом [ClusterService.Backup](../api-ref/grpc/Cluster/backup.md#yandex.cloud.mdb.postgresql.v1.Backup) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Backup
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/backup.md#yandex.cloud.operation.Operation).

{% endlist %}

Во время создания резервной копии производительность кластера может снижаться.

## Получить список резервных копий {#list-backups}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы получить список резервных копий кластера:
  1. Перейдите в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Резервные копии**.

  Чтобы получить список всех резервных копий в каталоге:
  1. Перейдите в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Выберите вкладку **Резервные копии**.
  
- CLI {#cli}
  
  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).
  
  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
  
  Чтобы получить список резервных копий кластеров PostgreSQL, доступных в каталоге по умолчанию, выполните команду:
  
  ```
  yc managed-postgresql backup list
  
  +--------------------------+---------------------+----------------------+---------------------+
  |            ID            |      CREATED AT     |  SOURCE CLUSTER ID   |      STARTED AT     |
  +--------------------------+---------------------+----------------------+---------------------+
  | c9qlk4v13uq7********:... | 2020-08-10 12:00:00 | c9qlk4v13uq7******** | 2020-08-10 11:55:17 |
  | c9qpm90p3pcg********:... | 2020-08-09 22:01:04 | c9qpm90p3pcg******** | 2020-08-09 21:30:00 |
  +--------------------------+---------------------+----------------------+---------------------+
  ```

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Чтобы получить список резервных копий кластера:

     1. Воспользуйтесь методом [Cluster.ListBackups](../api-ref/Cluster/listBackups.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        ```bash
        curl \
           --request GET \
           --header "Authorization: Bearer $IAM_TOKEN" \
           --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/<идентификатор_кластера>/backups'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

     1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listBackups.md#yandex.cloud.mdb.postgresql.v1.ListClusterBackupsResponse).

  1. Чтобы получить список резервных копий всех кластеров в каталоге:

     1. Воспользуйтесь методом [Backup.List](../api-ref/Backup/list.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        ```bash
        curl \
           --request GET \
           --header "Authorization: Bearer $IAM_TOKEN" \
           --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/backups' \
           --url-query folderId=<идентификатор_каталога>
        ```

        
        Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


     1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Backup/list.md#yandex.cloud.mdb.postgresql.v1.ListBackupsResponse).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
  1. Чтобы получить список резервных копий кластера:

     1. Воспользуйтесь вызовом [ClusterService.ListBackups](../api-ref/grpc/Cluster/listBackups.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.postgresql.v1.ClusterService.ListBackups
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

     1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listBackups.md#yandex.cloud.mdb.postgresql.v1.ListClusterBackupsResponse).

  1. Чтобы получить список резервных копий всех кластеров в каталоге:

     1. Воспользуйтесь вызовом [BackupService.List](../api-ref/grpc/Backup/list.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.postgresql.v1.BackupService.List
        ```

        
        Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


     1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Backup/list.md#yandex.cloud.mdb.postgresql.v1.ListBackupsResponse).

{% endlist %}

## Получить информацию о резервной копии {#get-backup}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы получить информацию о резервной копии существующего кластера:
  1. Перейдите в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Резервные копии**.

  Чтобы получить информацию о резервной копии удаленного ранее кластера:
  1. Перейдите в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Выберите вкладку **Резервные копии**.
  
- CLI {#cli}
  
  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).
  
  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
  
  Чтобы получить данные о резервной копии кластера PostgreSQL, выполните команду:
  
  ```
  yc managed-postgresql backup get <идентификатор_резервной_копии>
  ```
  
  Идентификатор резервной копии можно получить со [списком резервных копий](#list-backups).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Воспользуйтесь методом [Backup.Get](../api-ref/Backup/get.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

     ```bash
     curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/backups/<идентификатор_резервной_копии>'
     ```

     Идентификатор резервной копии можно запросить со [списком резервных копий](#list-backups).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Backup/get.md#yandex.cloud.mdb.postgresql.v1.Backup).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
  1. Воспользуйтесь вызовом [BackupService.Get](../api-ref/grpc/Backup/get.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
       mdb.api.cloud.yandex.net:443 \
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

  Чтобы задать время начала резервного копирования, используйте параметр `--backup-window-start`. Время задается в формате `ЧЧ:ММ:СС`.

  ```bash
  yc managed-postgresql cluster create \
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
  yc managed-postgresql cluster update \
     --cluster-name <имя_кластера> \
     --backup-window-start 11:25:00
  ```

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        Инструкцию по созданию такого файла читайте в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера Managed Service for PostgreSQL вы найдете в [документации провайдера Terraform](../../terraform/resources/mdb_postgresql_cluster.md).

    1. Добавьте к описанию кластера Managed Service for PostgreSQL блок `backup_window_start` в секции `config`:

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

        1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
        1. Выполните команду:
        
           ```bash
           terraform validate
           ```
        
           Если в файлах конфигурации есть ошибки, Terraform на них укажет.

    1. Подтвердите изменение ресурсов.

        1. Выполните команду для просмотра планируемых изменений:
        
           ```bash
           terraform plan
           ```
        
           Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
        
        1. Если вас устраивают планируемые изменения, внесите их:
           1. Выполните команду:
        
              ```bash
              terraform apply
              ```
        
           1. Подтвердите изменение ресурсов.
           1. Дождитесь завершения операции.

        {% note warning "Ограничения по времени" %}
        
        Провайдер Terraform ограничивает время на выполнение операций с кластером Managed Service for PostgreSQL:
        
        * создание, в том числе путем восстановления из резервной копии, — 30 минут;
        * изменение — 60 минут;
        * удаление — 15 минут.
        
        Операции, длящиеся дольше указанного времени, прерываются.
        
        {% cut "Как изменить эти ограничения?" %}
        
        Добавьте к описанию кластера блок `timeouts`, например:
        
        ```hcl
        resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
          ...
          timeouts {
            create = "1h30m" # Полтора часа
            update = "2h"    # 2 часа
            delete = "30m"   # 30 минут
          }
        }
        ```
        
        {% endcut %}
        
        {% endnote %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

     {% note warning %}
     
     Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
     
     {% endnote %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/<идентификатор_кластера>' \
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

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
  1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

     {% note warning %}
     
     Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask` (в виде массива строк `paths[]`).
     
     {% cut "Формат перечисления настроек" %}
     
     ```yaml
     "update_mask": {
         "paths": [
             "<настройка_1>",
             "<настройка_2>",
             ...
             "<настройка_N>"
         ]
     }
     ```
     
     {% endcut %}
     
     {% endnote %}

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
       mdb.api.cloud.yandex.net:443 \
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

  В [консоли управления](https://console.yandex.cloud) задать срок хранения автоматических резервных копий можно при [создании](cluster-create.md) или [изменении кластера](update.md).

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы задать срок хранения автоматических резервных копий, передайте нужное значение в аргументе `--backup-retain-period-days` команды изменения кластера:

    ```bash
    yc managed-postgresql cluster update <имя_или_идентификатор_кластера> \
       --backup-retain-period-days=<срок_хранения_в_днях>
    ```

  Допустимые значения: от `7` до `60`. Значение по умолчанию — `7`.

  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        Инструкцию по созданию такого файла читайте в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера Managed Service for PostgreSQL вы найдете в [документации провайдера Terraform](../../terraform/resources/mdb_postgresql_cluster.md).

    1. Добавьте к описанию кластера Managed Service for PostgreSQL блок `backup_retain_period_days` в секции `config`:

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

        1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
        1. Выполните команду:
        
           ```bash
           terraform validate
           ```
        
           Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Подтвердите изменение ресурсов.

        1. Выполните команду для просмотра планируемых изменений:
        
           ```bash
           terraform plan
           ```
        
           Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
        
        1. Если вас устраивают планируемые изменения, внесите их:
           1. Выполните команду:
        
              ```bash
              terraform apply
              ```
        
           1. Подтвердите изменение ресурсов.
           1. Дождитесь завершения операции.

        {% note warning "Ограничения по времени" %}
        
        Провайдер Terraform ограничивает время на выполнение операций с кластером Managed Service for PostgreSQL:
        
        * создание, в том числе путем восстановления из резервной копии, — 30 минут;
        * изменение — 60 минут;
        * удаление — 15 минут.
        
        Операции, длящиеся дольше указанного времени, прерываются.
        
        {% cut "Как изменить эти ограничения?" %}
        
        Добавьте к описанию кластера блок `timeouts`, например:
        
        ```hcl
        resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
          ...
          timeouts {
            create = "1h30m" # Полтора часа
            update = "2h"    # 2 часа
            delete = "30m"   # 30 минут
          }
        }
        ```
        
        {% endcut %}
        
        {% endnote %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1.  Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

       {% note warning %}
       
       Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
       
       {% endnote %}

       ```bash
       curl \
         --request PATCH \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --header "Content-Type: application/json" \
         --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/<идентификатор_кластера>' \
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

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

  1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

     {% note warning %}
     
     Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask` (в виде массива строк `paths[]`).
     
     {% cut "Формат перечисления настроек" %}
     
     ```yaml
     "update_mask": {
         "paths": [
             "<настройка_1>",
             "<настройка_2>",
             ...
             "<настройка_N>"
         ]
     }
     ```
     
     {% endcut %}
     
     {% endnote %}

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
        mdb.api.cloud.yandex.net:443 \
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

    1. Перейдите в сервис **Managed Service for&nbsp;PostgreSQL**.
    1. Выберите кластер Managed Service for PostgreSQL, резервную копию которого нужно удалить.
    1. На левой панели выберите раздел **Резервные копии**.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) справа в строке резервной копии, которую вы хотите удалить.
    1. Выберите пункт **Удалить резервную копию**.
    1. Подтвердите удаление и нажмите кнопку **Удалить**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы удалить резервную копию:

    1. Посмотрите описание команды CLI для удаления резервной копии PostgreSQL:

        ```bash
        yc managed-postgresql backup delete --help
        ```

    1. Запросите удаление резервной копии, указав ее идентификатор:

        ```bash
        yc managed-postgresql backup delete <идентификатор_резервной_копии>
        ```

    Идентификатор резервной копии можно получить со [списком резервных копий](#list-backups).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Воспользуйтесь методом [Backup.Delete](../api-ref/Backup/delete.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/backups/<идентификатор_резервной_копии>'
     ```

     Идентификатор резервной копии можно запросить со [списком резервных копий](#list-backups).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Backup/delete.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
  1. Воспользуйтесь вызовом [BackupService.Delete](../api-ref/grpc/Backup/delete.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.postgresql.v1.BackupService.Delete
     ```

     Идентификатор резервной копии можно запросить со [списком резервных копий](#list-backups).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Backup/delete.md#yandex.cloud.operation.Operation).

{% endlist %}