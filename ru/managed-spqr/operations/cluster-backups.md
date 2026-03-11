---
title: Управление резервными копиями в {{ mspqr-name }}
description: Как создавать резервные копии и восстанавливать кластеры из существующих резервных копий в {{ mspqr-full-name }}.
---

# Управление резервными копиями в {{ mspqr-full-name }}

{% include [preview](../../_includes/note-service-preview.md) %}

Вы можете [создавать](#create-backup) резервные копии и [восстанавливать](#restore) кластеры из существующих резервных копий.

Также {{ mspqr-name }} ежедневно создает автоматическую резервную копию. Вы можете [задать время начала](#set-backup-window) резервного копирования и [установить срок хранения](#set-backup-retain) автоматических резервных копий.

## Восстановить кластер из резервной копии {#restore}

{% note warning %}

{% include [deprecated-note](../../_includes/mdb/backups/deprecated-note.md) %}

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы восстановить из резервной копии существующий кластер:

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужной резервной копии и выберите пункт **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
  1. Задайте настройки нового кластера.
      
      В поле **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** можно выбрать каталог для нового кластера.
  
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.

  Чтобы восстановить из резервной копии удаленный кластер:

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужной резервной копии и выберите пункт **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
  1. Задайте настройки нового кластера.
      
      В поле **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** можно выбрать каталог для нового кластера.
  
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы восстановить кластер из резервной копии:

  1. Посмотрите описание команды CLI для восстановления кластера:
  
      ```bash
      yc managed-sharded-postgresql cluster restore --help
      ```
  
  1. Создайте кластер из резервной копии (в примере приведены не все доступные флаги):

      
      ```bash
      yc managed-sharded-postgresql cluster restore \
        --backup-id <идентификатор_резервной_копии> \
        --time <момент_времени_для_восстановления> \
        --name <имя_кластера> \
        --description <описание_кластера> \
        --environment <окружение> \
        --network-id <идентификатор_сети> \
        --host zone-id=<зона_доступности>,`
              `subnet-id=<идентификатор_подсети>,`
              `assign-public-ip=<публичный_доступ_к_хосту>,`
              `type=<тип_хоста> \
        --router-resource-preset <класс_хостов_роутера> \
        --router-disk-size <размер_хранилища_ГБ> \
        --router-disk-type <тип_диска> \
        --coordinator-resource-preset <класс_хостов_координатора> \
        --coordinator-disk-size <размер_хранилища_ГБ> \
        --coordinator-disk-type <тип_диска> \
        --infra-resource-preset <класс_хостов_INFRA> \
        --infra-disk-size <размер_хранилища_ГБ> \
        --infra-disk-type <тип_диска> \
        --backup-window-start <время_начала_резервного_копирования> \
        --backup-retain-period-days <срок_хранения_резервных_копий> \
        --security-group-ids <идентификаторы_групп_безопасности> \
        --deletion-protection
      ```


      Где:

      * `--backup-id` — идентификатор резервной копии.
        
        Идентификатор резервной копии можно получить со [списком резервных копий](#list-backups).

      * `--time` — момент времени, на который нужно восстановить состояние кластера, в формате `yyyy-mm-ddThh:mm:ssZ`.
      * `--name` — имя кластера.
      * `--description` — описание кластера.
      * `--environment` — окружение кластера: `PRODUCTION` или `PRESTABLE`.
      * `--network-id` — идентификатор [сети](../../vpc/concepts/network.md#network), в которой будет размещен кластер.
      * `--host` — параметры хоста:
        
        * `zone-id` — [зона доступности](../../overview/concepts/geo-scope.md).
        
                
        * `subnet-id` — идентификатор [подсети](../../vpc/concepts/network.md#subnet).
        * `assign-public-ip` — разрешить [подключение](connect.md) к хосту из интернета: `true` или `false`.
        
        
        * `type` — [тип хоста](../concepts/index.md). Возможные значения:
          
          * `ROUTER` — роутер в кластере с расширенным шардированием;
          * `COORDINATOR` — координатор в кластере с расширенным шардированием;
          * `INFRA` — хост `INFRA` в кластере со стандартным шардированием.

      * `--router-resource-preset` — [класс хостов](../concepts/instance-types.md) роутера.
      * `--router-disk-size` — размер хранилища для хостов роутера в гигабайтах.
      * `--router-disk-type` — [тип диска](../concepts/storage.md) для хостов роутера.
      * `--coordinator-resource-preset` — класс хостов координатора.
      * `--coordinator-disk-size` — размер хранилища для хостов координатора в гигабайтах.
      * `--coordinator-disk-type` — тип диска для хостов координатора.
      * `--infra-resource-preset` — класс хостов `INFRA`.
      * `--infra-disk-size` — размер хранилища `INFRA` в гигабайтах.
      * `--infra-disk-type` — тип диска для хостов `INFRA`.
      * `--backup-window-start` — время начала ежедневного резервного копирования по UTC в формате `HH:MM:SS`.
      * `--backup-retain-period-days` — срок хранения автоматических резервных копий кластера. Возможные значения: от `7` до `60` дней. По умолчанию — `7`.
      
      
      * `--security-group-ids` — идентификаторы [групп безопасности](../../vpc/concepts/security-groups.md).

        {% include [note-sg](../../_includes/managed-spqr/note-sg.md) %}


      * `--deletion-protection` — включает защиту кластера от удаления.

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

      
      ```json
      {
        "backupId": "<идентификатор_резервной_копии>",
        "name": "<имя_кластера>",
        "description": "<описание_кластера>",
        "environment": "<окружение>",
        "configSpec": {
          "spqrSpec": {
            "router": {
              "resources": {
                "resourcePresetId": "<класс_хостов_роутера>",
                "diskSize": "<размер_хранилища_в_байтах>",
                "diskTypeId": "<тип_диска>"
              }
            },
            "coordinator": {
              "resources": {
                "resourcePresetId": "<класс_хостов_координатора>",
                "diskSize": "<размер_хранилища_в_байтах>",
                "diskTypeId": "<тип_диска>"
              }
            },
            "infra": {
              "resources": {
                "resourcePresetId": "<класс_хостов_INFRA>",
                "diskSize": "<размер_хранилища_в_байтах>",
                "diskTypeId": "<тип_диска>"
              }
            },
            "consolePassword": "<пароль_консоли_Sharded_PostgreSQL>",
            "logLevel": "<уровень_логирования>"
          },
          "backupWindowStart": {
            "hours": <часы>,
            "minutes": <минуты>,
            "seconds": <секунды>,
            "nanos": <наносекунды>
          },
          "backupRetainPeriodDays": "<количество_дней>"
        },
        "hostSpecs": [
          {
            "zoneId": "<зона_доступности>",
            "subnetId": "<идентификатор_подсети>",
            "assignPublicIp": <разрешить_публичный_доступ_к_хосту>,
            "type": "<тип_хоста>",
            "shardName": "<имя_шарда>",
            "mdbPostgresql": {
              "clusterId": "<идентификатор_кластера_{{ PG }}>"
            }
          },
          { <аналогичный_набор_настроек_для_хоста_2> },
          { ... },
          { <аналогичный_набор_настроек_для_хоста_N> }
        ],
        "networkId": "<идентификатор_сети>",
        "folderId": "<идентификатор_каталога>",
        "securityGroupIds": [
          "<идентификатор_группы_безопасности_1>",
          "<идентификатор_группы_безопасности_2>",
          ...
          "<идентификатор_группы_безопасности_N>"
        ],
        "deletionProtection": <защитить_кластер_от_удаления>,
        "time": "<момент_времени_для_восстановления>",
        "timeInclusive": <восстановить_после_указанного_времени>
      }
      ```


      Где:

      * `backupId` — идентификатор резервной копии.
        
        Идентификатор резервной копии можно получить со [списком резервных копий](#list-backups).

      * `name` — имя кластера.
      * `description` — описание кластера.
      * `environment` — окружение кластера: `PRODUCTION` или `PRESTABLE`.
      * `configSpec.spqrSpec.router.resources` — параметры ресурсов хостов роутера:
        
        * `resourcePresetId` — [класс хостов](../concepts/instance-types.md);
        * `diskSize` — размер диска в байтах;
        * `diskTypeId` — [тип диска](../concepts/storage.md).
      
      * `configSpec.spqrSpec.coordinator.resources` — параметры ресурсов хостов координатора:
        
        * `resourcePresetId` — класс хостов;
        * `diskSize` — размер диска в байтах;
        * `diskTypeId` — тип диска.
      
      * `configSpec.spqrSpec.infra.resources` — параметры ресурсов хостов `INFRA`:
        
        * `resourcePresetId` — класс хостов;
        * `diskSize` — размер диска в байтах;
        * `diskTypeId` — тип диска.
      
      * `configSpec.spqrSpec.consolePassword` — пароль консоли {{ SPQR }}.
      * `configSpec.spqrSpec.logLevel` — уровень логирования запросов: `DEBUG`, `INFO`, `WARNING`, `ERROR`, `FATAL`.
      * `configSpec.backupWindowStart` — настройки окна резервного копирования.

        В параметре укажите время, когда начинать резервное копирование. Возможные значения параметров:

        * `hours` — от `0` до `23` часов;
        * `minutes` — от `0` до `59` минут;
        * `seconds` — от `0` до `59` секунд;
        * `nanos` — от `0` до `999999999` наносекунд.

      * `configSpec.backupRetainPeriodDays` — срок хранения автоматических резервных копий кластера. Возможные значения: от `7` до `60` дней. По умолчанию — `7`.
      * `hostSpecs` — настройки хостов кластера в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

        * `zoneId` — [зона доступности](../../overview/concepts/geo-scope.md);

        
        * `subnetId` — идентификатор [подсети](../../vpc/concepts/network.md#subnet);
        * `assignPublicIp` — разрешить [подключение](connect.md) к хосту из интернета: `true` или `false`;


        * `type` — тип хоста. Возможные значения:

          * `ROUTER` — роутер в кластере с расширенным шардированием;
          * `COORDINATOR` — координатор в кластере с расширенным шардированием;
          * `INFRA` — хост `INFRA` в кластере со стандартным шардированием.
        
        * `shardName` — имя шарда.
        * `mdbPostgresql.clusterId` — идентификатор кластера {{ mpg-name }}.

          Идентификатор кластера {{ mpg-name }} можно получить со [списком кластеров](../../managed-postgresql/operations/cluster-list.md#list-clusters) в каталоге.

     * `networkId` — идентификатор [сети](../../vpc/concepts/network.md#network), в которой будет размещен кластер.
     * `folderId` — идентификатор каталога.
       
              
       Идентификатор каталога можно получить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
       
     
     
     * `securityGroupIds` — идентификаторы [групп безопасности](../../vpc/concepts/security-groups.md).

       {% include [note-sg](../../_includes/managed-spqr/note-sg.md) %}

     
     * `deletionProtection` — защита кластера от удаления: `true` или `false`.
     * `time` — момент времени, на который нужно восстановить состояние кластера, в формате `yyyy-mm-ddThh:mm:ssZ`.
     * `timeInclusive` — восстановить кластер после указанного времени: `true` или `false`.

  1. Воспользуйтесь методом [Cluster.Restore](../api-ref/Cluster/restore.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters:restore' \
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
        "name": "<имя_кластера>",
        "description": "<описание_кластера>",
        "environment": "<окружение>",
        "config_spec": {
          "spqr_spec": {
            "router": {
              "resources": {
                "resource_preset_id": "<класс_хостов_роутера>",
                "disk_size": <размер_хранилища_в_байтах>,
                "disk_type_id": "<тип_диска>"
              }
            },
            "coordinator": {
              "resources": {
                "resource_preset_id": "<класс_хостов_координатора>",
                "disk_size": <размер_хранилища_в_байтах>,
                "disk_type_id": "<тип_диска>"
              }
            },
            "infra": {
              "resources": {
                "resource_preset_id": "<класс_хостов_INFRA>",
                "disk_size": <размер_хранилища_в_байтах>,
                "disk_type_id": "<тип_диска>"
              }
            },
            "console_password": "<пароль_консоли_Sharded_PostgreSQL>",
            "log_level": "<уровень_логирования>"
          },
          "backup_window_start": {
            "hours": <часы>,
            "minutes": <минуты>,
            "seconds": <секунды>,
            "nanos": <наносекунды>
          },
          "backup_retain_period_days": <количество_дней>
        },
        "host_specs": [
          {
            "zone_id": "<зона_доступности>",
            "subnet_id": "<идентификатор_подсети>",
            "assign_public_ip": <разрешить_публичный_доступ_к_хосту>,
            "type": "<тип_хоста>",
            "shard_name": "<имя_шарда>",
            "mdb_postgresql": {
              "cluster_id": "<идентификатор_кластера_{{ PG }}>"
            }
          },
          { <аналогичный_набор_настроек_для_хоста_2> },
          { ... },
          { <аналогичный_набор_настроек_для_хоста_N> }
        ],
        "network_id": "<идентификатор_сети>",
        "folder_id": "<идентификатор_каталога>",
        "security_group_ids": [
          "<идентификатор_группы_безопасности_1>",
          "<идентификатор_группы_безопасности_2>",
          ...
          "<идентификатор_группы_безопасности_N>"
        ],
        "deletion_protection": <защитить_кластер_от_удаления>,
        "time": "<момент_времени_для_восстановления>",
        "time_inclusive": <восстановить_после_указанного_времени>
      }
      ```


      Где:

      * `backup_id` — идентификатор резервной копии.
        
        Идентификатор резервной копии можно получить со [списком резервных копий](#list-backups).

      * `name` — имя кластера.
      * `description` — описание кластера.
      * `environment` — окружение кластера: `PRODUCTION` или `PRESTABLE`.
      * `config_spec.spqr_spec.router.resources` — параметры ресурсов хостов роутера:
        
        * `resource_preset_id` — [класс хостов](../concepts/instance-types.md);
        * `disk_size` — размер диска в байтах;
        * `disk_type_id` — [тип диска](../concepts/storage.md).
      
      * `config_spec.spqr_spec.coordinator.resources` — параметры ресурсов хостов координатора:
        
        * `resource_preset_id` — класс хостов;
        * `disk_size` — размер диска в байтах;
        * `disk_type_id` — тип диска.
      
      * `config_spec.spqr_spec.infra.resources` — параметры ресурсов хостов `INFRA`:
        
        * `resource_preset_id` — класс хостов;
        * `disk_size` — размер диска в байтах;
        * `disk_type_id` — тип диска.
      
      * `config_spec.spqr_spec.console_password` — пароль консоли {{ SPQR }}.
      * `config_spec.spqr_spec.log_level` — уровень логирования запросов: `DEBUG`, `INFO`, `WARNING`, `ERROR`, `FATAL`.
      * `config_spec.backup_window_start` — настройки окна резервного копирования.

        В параметре укажите время, когда начинать резервное копирование. Возможные значения параметров:

        * `hours` — от `0` до `23` часов;
        * `minutes` — от `0` до `59` минут;
        * `seconds` — от `0` до `59` секунд;
        * `nanos` — от `0` до `999999999` наносекунд.

      * `config_spec.backup_retain_period_days` — срок хранения автоматических резервных копий кластера. Возможные значения: от `7` до `60` дней.
      * `host_specs` — настройки хостов кластера в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

        * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md);

        
        * `subnet_id` — идентификатор [подсети](../../vpc/concepts/network.md#subnet);
        * `assign_public_ip` — разрешить [подключение](connect.md) к хосту из интернета: `true` или `false`;


        * `type` — тип хоста. Возможные значения:

          * `ROUTER` — роутер в кластере с расширенным шардированием;
          * `COORDINATOR` — координатор в кластере с расширенным шардированием;
          * `INFRA` — хост `INFRA` в кластере со стандартным шардированием.
        
        * `shard_name` — имя шарда.
        * `mdb_postgresql.cluster_id` — идентификатор кластера {{ mpg-name }}.
          
          Идентификатор кластера {{ mpg-name }} можно получить со [списком кластеров](../../managed-postgresql/operations/cluster-list.md#list-clusters) в каталоге.

     * `network_id` — идентификатор [сети](../../vpc/concepts/network.md#network), в которой будет размещен кластер.
     * `folder_id` — идентификатор каталога.

              
       Идентификатор каталога можно получить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
       
     
     
     * `security_group_ids` — идентификаторы [групп безопасности](../../vpc/concepts/security-groups.md).

         {% include [note-sg](../../_includes/managed-spqr/note-sg.md) %}

     
     * `deletion_protection` — защита кластера от удаления: `true` или `false`.
     * `time` — момент времени, на который нужно восстановить состояние кластера, в формате `yyyy-mm-ddThh:mm:ssZ`.
     * `time_inclusive` — восстановить кластер после указанного времени: `true` или `false`.
  
  1. Воспользуйтесь вызовом [ClusterService.Restore](../api-ref/grpc/Cluster/restore.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d @ \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.ClusterService.Restore \
       < body.json
     ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/restore.md#yandex.cloud.operation.Operation).

{% endlist %}

## Создать резервную копию {#create-backup}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}**.
  1. В правом верхнем углу страницы нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.backups.button_create }}**.
  1. Подтвердите создание резервной копии.

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы создать резервную копию кластера:

  1. Посмотрите описание команды CLI для создания резервной копии кластера:
  
      ```bash
      yc managed-sharded-postgresql cluster backup --help
      ```
  
  1. Создайте резервную копию кластера:

      ```bash
      yc managed-sharded-postgresql cluster backup <имя_или_идентификатор_кластера>
      ```

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.Backup](../api-ref/Cluster/backup.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<идентификатор_кластера>:backup'
      ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/backup.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Воспользуйтесь вызовом [ClusterService.Backup](../api-ref/grpc/Cluster/backup.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>"
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.spqr.v1.ClusterService.Backup
      ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/backup.md#yandex.cloud.operation.Operation).

{% endlist %}

## Получить список резервных копий {#list-backups}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы получить список резервных копий конкретного кластера:

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}**.

  Чтобы получить список резервных копий всех кластеров {{ mspqr-name }} в каталоге:

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}**.

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы получить список резервных копий конкретного кластера:

  1. Посмотрите описание команды CLI для получения списка резервных копий кластера:
  
      ```bash
      yc managed-sharded-postgresql cluster list-backups --help
      ```
  
  1. Получите список резервных копий кластера:

      ```bash
      yc managed-sharded-postgresql cluster list-backups <имя_или_идентификатор_кластера>
      ```    

  Чтобы получить список резервных копий всех кластеров {{ mspqr-name }} в каталоге:

  1. Посмотрите описание команды CLI для получения списка резервных копий:
  
      ```bash
      yc managed-sharded-postgresql backup list --help
      ```
  
  1. Получите список резервных копий:

      ```bash
      yc managed-sharded-postgresql backup list
      ```

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Чтобы получить список резервных копий конкретного кластера:

      1. Воспользуйтесь методом [Cluster.ListBackups](../api-ref/Cluster/listBackups.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

          ```bash
          curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<идентификатор_кластера>/backups'
          ```

      1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listBackups.md#yandex.cloud.mdb.spqr.v1.ListClusterBackupsResponse).

  1. Чтобы получить список резервных копий всех кластеров {{ mspqr-name }} в каталоге:

      1. Воспользуйтесь методом [Backup.List](../api-ref/Backup/list.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

          ```bash
          curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-spqr/v1/backups' \
            --url-query folderId=<идентификатор_каталога>
          ```

                 
          Идентификатор каталога можно получить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
       

      1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Backup/list.md#yandex.cloud.mdb.spqr.v1.ListBackupsResponse).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Чтобы получить список резервных копий конкретного кластера:
      
      1. Воспользуйтесь вызовом [ClusterService.ListBackups](../api-ref/grpc/Cluster/listBackups.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

          ```bash
          grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.spqr.v1.ClusterService.ListBackups
          ```

      1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listBackups.md#yandex.cloud.mdb.spqr.v1.ListClusterBackupsResponse).

  1. Чтобы получить список резервных копий всех кластеров {{ mspqr-name }} в каталоге:

      1. Воспользуйтесь вызовом [BackupService.List](../api-ref/grpc/Backup/list.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

          ```bash
          grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/backup_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "folder_id": "<идентификатор_каталога>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.spqr.v1.BackupService.List
          ```

                 
          Идентификатор каталога можно получить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
       

      1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Backup/list.md#yandex.cloud.mdb.spqr.v1.ListBackupsResponse).

{% endlist %}

## Получить информацию о резервной копии {#get-backup}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы получить информацию о резервной копии существующего кластера:

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}**.

  Чтобы получить информацию о резервной копии удаленного кластера:
  
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}**.

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы получить информацию о конкретной резервной копии:

  1. Посмотрите описание команды CLI для получения информации о резервной копии:
  
      ```bash
      yc managed-sharded-postgresql backup get --help
      ```
  
  1. Получите информацию о резервной копии:

      ```bash
      yc managed-sharded-postgresql backup get <идентификатор_резервной_копии>
      ```
      
      Идентификатор резервной копии можно получить со [списком резервных копий](#list-backups).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Backup.Get](../api-ref/Backup/get.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-mdb }}/managed-spqr/v1/backups/<идентификатор_резервной_копии>'
      ```

      Идентификатор резервной копии можно получить со [списком резервных копий](#list-backups).
  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Backup/get.md#yandex.cloud.mdb.spqr.v1.Backup).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Воспользуйтесь вызовом [BackupService.Get](../api-ref/grpc/Backup/get.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/backup_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "backup_id": "<идентификатор_резервной_копии>"
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.spqr.v1.BackupService.Get
      ```

      Идентификатор резервной копии можно получить со [списком резервных копий](#list-backups).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Backup/get.md#yandex.cloud.mdb.spqr.v1.Backup).
  
{% endlist %}

## Задать время начала резервного копирования {#set-backup-window}

{% list tabs group=instructions %}

- Консоль управления {#console}

  В консоли управления задать время начала резервного копирования можно при [создании](cluster-create.md) или [изменении](cluster-update.md) кластера.

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы задать время начала резервного копирования:

  1. Посмотрите описание команды CLI для изменения кластера:
  
      ```bash
      yc managed-sharded-postgresql cluster update --help
      ```
  
  1. Задайте время начала резервного копирования:

      ```bash
      yc managed-sharded-postgresql cluster update <имя_или_идентификатор_кластера> \
        --backup-window-start <время_начала_резервного_копирования>
      ```

      Где `--backup-window-start` — время начала ежедневного резервного копирования по UTC в формате `HH:MM:SS`.

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

      ```json
      {
        "updateMask": "configSpec.backupWindowStart",
        "configSpec": {
          "backupWindowStart": {
            "hours": <часы>,
            "minutes": <минуты>,
            "seconds": <секунды>,
            "nanos": <наносекунды>
          }
        }
      }
      ```

      Где:

      * `updateMask` — перечень изменяемых параметров в строку через запятую.

        В этом примере передается только один параметр `configSpec.backupWindowStart`.

        {% note warning %}

        При изменении кластера все параметры изменяемого объекта, которые не были явно переданы в запросе, будут переопределены на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask`.

        {% endnote %}

      * `configSpec.backupWindowStart` — настройки окна резервного копирования.

        В параметре укажите время, когда начинать резервное копирование. Возможные значения параметров:

        * `hours` — от `0` до `23` часов;
        * `minutes` — от `0` до `59` минут;
        * `seconds` — от `0` до `59` секунд;
        * `nanos` — от `0` до `999999999` наносекунд.

  1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<идентификатор_кластера>' \
        --data "@body.json"
      ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

      ```json
      {
        "update_mask": {
          "paths": [
            "config_spec.backup_window_start"
          ]
        },
        "config_spec": {
          "backup_window_start": {
            "hours": <часы>,
            "minutes": <минуты>,
            "seconds": <секунды>,
            "nanos": <наносекунды>
          }
        }
      }
      ```

      Где:

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

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

        В этом примере передается только один параметр `config_spec.backup_window_start`.

        {% note warning %}

        При изменении кластера все параметры изменяемого объекта, которые не были явно переданы в запросе, будут переопределены на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask`.

        {% endnote %}
    
      * `config_spec.backup_window_start` — настройки окна резервного копирования.

        В параметре укажите время, когда начинать резервное копирование. Возможные значения параметров:

        * `hours` — от `0` до `23` часов;
        * `minutes` — от `0` до `59` минут;
        * `seconds` — от `0` до `59` секунд;
        * `nanos` — от `0` до `999999999` наносекунд.

  1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d @ \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.spqr.v1.ClusterService.Update \
        < body.json
      ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Задать срок хранения автоматических резервных копий {#set-backup-retain}

{% list tabs group=instructions %}

- Консоль управления {#console}

  В консоли управления задать срок хранения автоматических резервных копий можно при [создании](cluster-create.md) или [изменении](cluster-update.md) кластера.

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы задать срок хранения автоматических резервных копий:

  1. Посмотрите описание команды CLI для изменения кластера:
  
      ```bash
      yc managed-sharded-postgresql cluster update --help
      ```
  
  1. Задайте срок хранения автоматических резервных копий:

      ```bash
      yc managed-sharded-postgresql cluster update <имя_или_идентификатор_кластера> \
        --backup-retain-period-days <количество_дней>
      ```

      Где `--backup-retain-period-days` — срок хранения автоматических резервных копий кластера. Возможные значения: от `7` до `60` дней. По умолчанию — `7`.

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

      ```json
      {
        "updateMask": "configSpec.backupRetainPeriodDays",
        "configSpec": {
          "backupRetainPeriodDays": "<количество_дней>"
        }
      }
      ```

      Где:

      * `updateMask` — перечень изменяемых параметров в строку через запятую.

        В этом примере передается только один параметр `configSpec.backupRetainPeriodDays`.

        {% note warning %}

        При изменении кластера все параметры изменяемого объекта, которые не были явно переданы в запросе, будут переопределены на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask`.

        {% endnote %}

      * `backupRetainPeriodDays` — срок хранения автоматических резервных копий кластера. Возможные значения: от `7` до `60` дней. По умолчанию — `7`.

  1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<идентификатор_кластера>' \
        --data "@body.json"
      ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

      ```json
      {
        "update_mask": {
          "paths": [
            "config_spec.backup_retain_period_days"
          ]
        },
        "config_spec": {
          "backup_retain_period_days": <количество_дней>
        }
      }
      ```

      Где:

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

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

        В этом примере передается только один параметр `config_spec.backup_retain_period_days`.

        {% note warning %}

        При изменении кластера все параметры изменяемого объекта, которые не были явно переданы в запросе, будут переопределены на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask`.

        {% endnote %}

      * `config_spec.backup_retain_period_days` — срок хранения автоматических резервных копий кластера. Возможные значения: от `7` до `60` дней. По умолчанию — `7`.

  1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d @ \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.spqr.v1.ClusterService.Update \
        < body.json
      ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Удалить резервную копию {#delete}

Удалить можно только резервные копии, созданные вручную.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}**.
  1. В строке резервной копии, которую вы хотите удалить, нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.cluster.backups.button_delete }}**.
  1. Подтвердите удаление резервной копии.

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы удалить резервную копию:

  1. Посмотрите описание команды CLI для удаления резервной копии:
  
      ```bash
      yc managed-sharded-postgresql backup delete --help
      ```
  
  1. Удалите резервную копию:

      ```bash
      yc managed-sharded-postgresql backup delete <идентификатор_резервной_копии>
      ```
      
      Идентификатор резервной копии можно получить со [списком резервных копий](#list-backups).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Backup.Delete](../api-ref/Backup/delete.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request DELETE \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-spqr/v1/backups/<идентификатор_резервной_копии>'
      ```

      Идентификатор резервной копии можно получить со [списком резервных копий](#list-backups).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Backup/delete.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Воспользуйтесь вызовом [BackupService.Delete](../api-ref/grpc/Backup/delete.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/backup_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "backup_id": "<идентификатор_резервной_копии>"
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.spqr.v1.BackupService.Delete
      ```

      Идентификатор резервной копии можно получить со [списком резервных копий](#list-backups).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Backup/delete.md#yandex.cloud.operation.Operation).

{% endlist %}