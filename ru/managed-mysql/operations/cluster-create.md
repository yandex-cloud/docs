---
title: Как создать кластер {{ MY }}
description: Следуя данной инструкции, вы сможете создать кластер {{ MY }} с одним или несколькими хостами базы данных.
---

# Создание кластера {{ MY }}


[Кластер](../../glossary/cluster.md) {{ MY }} — один или несколько хостов базы данных. В кластерах из более чем одного хоста автоматически настраивается [полусинхронная репликация](../concepts/replication.md).

Подробнее об устройстве кластера {{ mmy-name }} см. в разделе [Взаимосвязь ресурсов сервиса](../concepts/index.md).

{% note info %}

* Количество хостов, которые можно создать вместе с кластером {{ MY }}, зависит от выбранного [типа диска](../concepts/storage.md#storage-type-selection) и [класса хостов](../concepts/instance-types.md#available-flavors).
* Доступные типы диска [зависят](../concepts/storage.md) от выбранного [класса хостов](../concepts/instance-types.md#available-flavors).

{% endnote %}


## Создать кластер {#create-cluster}


Для создания кластера {{ mmy-name }} нужна роль [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) и роль [{{ roles.mmy.editor }} или выше](../security/index.md#roles-list). О том, как назначить роль, см. [документацию {{ iam-name }}](../../iam/operations/roles/grant.md).


{% list tabs group=instructions %}

- Консоль управления {#console}

  
  <iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvfjog2u3zppo74es4?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

  [Смотреть видео на YouTube](https://www.youtube.com/watch?v=XflGoG03SHE&list=PL1x4ET76A10bW1KU3twrdm7hH376z8G5R&index=5&pp=iAQB).



  Чтобы создать кластер {{ mmy-name }}:

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать кластер БД.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. Введите имя кластера {{ mmy-name }} в поле **{{ ui-key.yacloud.mdb.forms.base_field_name }}**. Имя кластера должно быть уникальным в рамках каталога.
  1. Выберите окружение, в котором нужно создать кластер {{ mmy-name }} (после создания кластера окружение изменить невозможно):
     * `PRODUCTION` — для стабильных версий ваших приложений.
     * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.
  1. Выберите версию СУБД.
  1. Выберите класс хостов — он определяет технические характеристики [виртуальных машин](../../compute/concepts/vm-platforms.md), на которых будут развернуты хосты БД. Все доступные варианты перечислены в разделе [Классы хостов](../concepts/instance-types.md). При изменении класса хостов для кластера {{ mmy-name }} меняются характеристики всех уже созданных хостов.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_disk }}**:

     * Выберите [тип диска](../concepts/storage.md).

       {% include [storages-step-settings](../../_includes/mdb/settings-storages.md) %}

     * Выберите объем, который будет использоваться для данных и резервных копий. Подробнее о том, как занимают пространство резервные копии, см. раздел [Резервные копии](../concepts/backup.md).

       {% note info %}

       Если хранилище БД заполнится на 95%, кластер {{ mmy-name }} перейдет в режим «только чтение». Увеличивайте размер хранилища заранее.

       {% endnote %}

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_database }}** укажите атрибуты БД:
     * Имя БД. Это имя должно быть уникальным в рамках каталога.

       {% include [db-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}

     * Имя пользователя—владельца БД и пароль.

       {% include [user-name-and-passwords-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

  
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network }}** выберите:

     * [Облачную сеть](../../vpc/concepts/network.md#network) для размещения кластера.
     * [Группы безопасности](../../vpc/concepts/security-groups.md) для сетевого трафика кластера. Может потребоваться дополнительная [настройка групп безопасности](connect.md#configuring-security-groups), чтобы можно было подключаться к кластеру {{ mmy-name }}.


  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_host }}** нажмите на значок ![image](../../_assets/console-icons/pencil.svg) и выберите параметры хостов БД, создаваемых вместе с кластером {{ mmy-name }}:
     * Зону доступности.
     * [Подсеть](../../vpc/concepts/network.md#subnet) хоста — по умолчанию каждый хост создается в отдельной подсети.
     * Опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**, если хост должен быть доступен извне {{ yandex-cloud }}.
     * [Приоритет назначения хоста мастером](../concepts/replication.md#master-failover).
     * [Приоритет хоста как {{ MY }}-реплики](../concepts/backup.md#size) для создания резервной копии.

     Если в блоке **{{ ui-key.yacloud.mdb.forms.section_disk }}** выбран `local-ssd` или `network-ssd-nonreplicated`, необходимо добавить не менее трех хостов в кластер {{ mmy-name }}. После создания кластера {{ mmy-name }} в него можно добавить дополнительные хосты, если для этого достаточно [ресурсов каталога](../concepts/limits.md).

  1. При необходимости задайте дополнительные настройки кластера {{ mmy-name }}:

     {% include [mmy-extra-settings](../../_includes/mdb/mmy-extra-settings-web-console.md) %}

  1. При необходимости задайте [настройки СУБД уровня кластера](../concepts/settings-list.md#dbms-cluster-settings).

     {% include [mmy-settings-dependence](../../_includes/mdb/mmy/note-info-settings-dependence.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать кластер {{ mmy-name }}:

  
  1. Проверьте, есть ли в каталоге [подсети](../../vpc/concepts/network.md#subnet) для хостов кластера {{ mmy-name }}:

     ```bash
     yc vpc subnet list
     ```

     Если ни одной подсети в каталоге нет, [создайте нужные подсети](../../vpc/operations/subnet-create.md) в [сервисе {{ vpc-full-name }}](../../vpc/).


  1. Посмотрите описание команды CLI для создания кластера {{ mmy-name }}:

     ```bash
     {{ yc-mdb-my }} cluster create --help
     ```

  1. Укажите параметры кластера {{ mmy-name }} в команде создания:

     
     ```bash
     {{ yc-mdb-my }} cluster create \
       --name=<имя_кластера> \
       --environment <окружение> \
       --network-name <имя_сети> \
       --host zone-id=<зона_доступности>,`
         `subnet-id=<идентификатор_подсети>,`
         `assign-public-ip=<публичный_доступ_к_хосту>,`
         `priority=<приоритет_при_выборе_хоста-мастера>,`
         `backup-priority=<приоритет_для_резервного_копирования> \
       --mysql-version <версия_{{ MY }}> \
       --resource-preset <класс_хоста> \
       --user name=<имя_пользователя>,password=<пароль_пользователя> \
       --database name=<имя_БД> \
       --disk-size <размер_хранилища_ГБ> \
       --disk-type <network-hdd|network-ssd|network-ssd-nonreplicated|local-ssd> \
       --security-group-ids <список_идентификаторов_групп_безопасности>
     ```

     Идентификатор подсети `subnet-id` необходимо указывать, если в выбранной [зоне доступности](../../overview/concepts/geo-scope.md) создано две и больше подсетей.


     Где:

     * `environment` — окружение: `prestable` или `production`.

     
     * `assign-public-ip` — публичный доступ к хосту: `true` или `false`.


     * `disk-type` — [тип диска](../concepts/storage.md).
     * `priority` — приоритет при выборе нового хоста-мастера: от `0` до `100`.
     * `backup-priority` — приоритет для резервного копирования: от `0` до `100`.
     * `mysql-version` — версия {{ MY }}: `{{ versions.cli.str }}`.

     При необходимости задайте дополнительные настройки кластера {{ mmy-name }}:

     ```bash
     {{ yc-mdb-my }} cluster create \
       ...
       --backup-window-start <время_начала_резервного_копирования> \
       --backup-retain-period-days=<срок_хранения_копий> \
       --datalens-access=<true_или_false> \
       --websql-access=<true_или_false> \
       --deletion-protection \
       --performance-diagnostics enabled=true,`
                                `sessions-sampling-interval=<интервал_сбора_сессий>,`
                                `statements-sampling-interval=<интервал_сбора_запросов>
     ```

     Где:

     * `backup-window-start` — время начала резервного копирования.
     * `backup-retain-period-days` — срок хранения автоматических резервных копий в днях.
     * `datalens-access` — разрешает доступ из {{ datalens-full-name }}. Значение по умолчанию — `false`. Подробнее о настройке подключения см в разделе [{#T}](datalens-connect.md).
     * `websql-access` — разрешает [выполнять SQL-запросы](web-sql-query.md) к базам данных кластера из консоли управления {{ yandex-cloud }} с помощью сервиса {{ websql-full-name }}. Значение по умолчанию — `false`.
     * `deletion-protection` — защита от удаления кластера.
     * `performance-diagnostics` — активация сбора статистики для [диагностики производительности кластера](performance-diagnostics.md). Допустимые значения параметров `sessions-sampling-interval` и `statements-sampling-interval` — от `1` до `86400` секунд.

     {% include [db-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}

     {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-db.md) %}

     При необходимости задайте [настройки СУБД](../concepts/settings-list.md#dbms-cluster-settings).

     {% note info %}

     По умолчанию при создании кластера устанавливается режим [технического обслуживания](../concepts/maintenance.md) `anytime` — в любое время. Вы можете установить конкретное время обслуживания при [изменении настроек кластера](update.md#change-additional-settings).

     {% endnote %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы создать кластер {{ mmy-name }}:
  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:
     * Кластер БД — описание кластера и его хостов.
     * База данных — описание БД кластера.

       {% include [db-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}

     * Пользователь — описание пользователя кластера.

     * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

     * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

     Пример структуры конфигурационного файла:

     
     ```hcl
     resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
       name                = "<имя_кластера>"
       environment         = "<окружение>"
       network_id          = "<идентификатор_сети>"
       version             = "<версия_{{ MY }}>"
       security_group_ids  = [ "<список_идентификаторов_групп_безопасности>" ]
       deletion_protection = <защита_от_удаления_кластера>

       resources {
         resource_preset_id = "<класс_хоста>"
         disk_type_id       = "<тип_диска>"
         disk_size          = "<размер_хранилища_ГБ>"
       }

       host {
         zone             = "<зона_доступности>"
         subnet_id        = "<идентификатор_подсети>"
         assign_public_ip = <публичный_доступ_к_хосту>
         priority         = <приоритет_при_выборе_хоста-мастера>
         backup_priority  = <приоритет_для_резервного_копирования>
       }
     }

     resource "yandex_mdb_mysql_database" "<имя_БД>" {
       cluster_id = "<идентификатор_кластера>"
       name       = "<имя_БД>"
     }

     resource "yandex_mdb_mysql_user" "<имя_пользователя>" {
       cluster_id = "<идентификатор_кластера>"
       name       = "<имя_пользователя>"
       password   = "<пароль_пользователя>"
       permission {
         database_name = "<имя_БД>"
         roles         = ["ALL"]
       }
     }

     resource "yandex_vpc_network" "<имя_сети>" { name = "<имя_сети>" }

     resource "yandex_vpc_subnet" "<имя_подсети>" {
       name           = "<имя_подсети>"
       zone           = "<зона_доступности>"
       network_id     = "<идентификатор_сети>"
       v4_cidr_blocks = ["<диапазон>"]
     }
     ```


     Где:

     * `environment` — окружение: `PRESTABLE` или `PRODUCTION`.
     * `version` — версия {{ MY }}: `{{ versions.tf.str }}`.
     * `deletion_protection` — защита от удаления кластера: `true` или `false`.
     * `assign_public_ip` — публичный доступ к хосту: `true` или `false`.
     * `priority` — приоритет при выборе нового хоста-мастера: от `0` до `100`.
     * `backup_priority` — приоритет для резервного копирования: от `0` до `100`.

     {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-db.md) %}

     * {% include [Maintenance window](../../_includes/mdb/mmy/terraform/maintenance-window.md) %}

     * {% include [Access settings](../../_includes/mdb/mmy/terraform/access-settings.md) %}

     * Чтобы задать время начала [резервного копирования](../concepts/backup.md), добавьте к описанию кластера {{ mmy-name }} блок `backup_window_start`:

       ```hcl
       resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
         ...
         backup_window_start {
           hours   = <час>
           minutes = <минута>
         }
         ...
       }
       ```

       Где:

       * `hours` — час начала резервного копирования.
       * `minutes` — минута начала резервного копирования.

     * Чтобы задать срок хранения резервных копий, укажите в описании кластера {{ mmy-name }} параметр `backup_retain_period_days`:

       ```hcl
       resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
         ...
           backup_retain_period_days = <срок_хранения_копий>
           ...
       }
       ```

       Где `backup_retain_period_days` — срок хранения автоматических резервных копий в днях.

       Допустимые значения: от `7` до `60`. Значение по умолчанию — `7`.

     * Чтобы активировать сбор статистики для [диагностики производительности кластера](performance-diagnostics.md), добавьте к описанию кластера {{ mmy-name }} блок `performance_diagnostics`:

       ```hcl
       resource "yandex_mdb_mysql_cluster" "<название_кластера>" {
         ...
         performance_diagnostics {
           enabled = true
           sessions_sampling_interval = <интервал_сбора_сессий>
           statements_sampling_interval = <интервал_сбора_запросов>
         }
         ...
       }
       ```

       Допустимые значения параметров `sessions_sampling_interval` и `statements_sampling_interval` — от `1` до `86400` секунд.

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-mmy }}).
  1. Проверьте корректность конфигурационных файлов.

     {% include [terraform-create-cluster-step-2](../../_includes/mdb/terraform-create-cluster-step-2.md) %}

  1. Создайте кластер {{ mmy-name }}.

     {% include [terraform-create-cluster-step-3](../../_includes/mdb/terraform-create-cluster-step-3.md) %}

     {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

      
      ```json
      {
          "folderId": "<идентификатор_каталога>",
          "name": "<имя_кластера>",
          "environment": "<окружение>",
          "networkId": "<идентификатор_сети>",
          "securityGroupIds": [
              "<идентификатор_группы_безопасности_1>",
              "<идентификатор_группы_безопасности_2>",
              ...
              "<идентификатор_группы_безопасности_N>"
          ],
          "deletionProtection": <защита_от_удаления:_true_или_false>,
          "configSpec": {
              "version": "<версия_{{ MY }}>",
              "resources": {
                  "resourcePresetId": "<класс_хостов>",
                  "diskSize": "<размер_хранилища_в_байтах>",
                  "diskTypeId": "<тип_диска>"
              },
              "access": {
                  "dataLens": <доступ_к_{{ datalens-name }}:_true_или_false>,
                  "webSql": <доступ_к_{{ websql-name }}:_true_или_false>,
                  "dataTransfer": <доступ_к_Data_Transfer:_true_или_false>
              },
              "performanceDiagnostics": {
                  "enabled": <активация_сбора_статистики:_true_или_false>,
                  "sessionsSamplingInterval": "<интервал_сбора_сессий>",
                  "statementsSamplingInterval": "<интервал_сбора_запросов>"
              }
          },
          "databaseSpecs": [
              {
                  "name": "<имя_БД>"
              },
              { <аналогичный_набор_настроек_для_БД_2> },
              { ... },
              { <аналогичный_набор_настроек_для_БД_N> }
          ],
          "userSpecs": [
              {
                  "name": "<имя_пользователя>",
                  "password": "<пароль_пользователя>",
                  "permissions": [
                      {
                          "databaseName": "<имя_БД>",
                          "roles": [
                              "<привилегия_1>", "<привилегия_2>", ..., "<привилегия_N>"
                          ]
                      }
                  ]
              },
              { <аналогичный_набор_настроек_для_пользователя_2> },
              { ... },
              { <аналогичный_набор_настроек_для_пользователя_N> }
          ],
          "hostSpecs": [
              {
                  "zoneId": "<зона_доступности>",
                  "subnetId": "<идентификатор_подсети>",
                  "assignPublicIp": <публичный_адрес_хоста:_true_или_false>
              },
              { <аналогичный_набор_настроек_для_хоста_2> },
              { ... },
              { <аналогичный_набор_настроек_для_хоста_N> }
          ]
      }
      ```


      Где:

      * `folderId` — идентификатор каталога. Его можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
      * `name` — имя кластера.
      * `environment` — окружение кластера: `PRODUCTION` или `PRESTABLE`.
      * `networkId` — идентификатор [сети](../../vpc/concepts/network.md#network), в которой будет размещен кластер.

      
      * `securityGroupIds` — идентификаторы [групп безопасности](../concepts/network.md#security-groups).


      * `deletionProtection` — защита от удаления кластера, его баз данных и пользователей.
      * `configSpec` — настройки кластера:

          * `version` — версия {{ MY }}.
          * `resources` — ресурсы кластера:

              * `resourcePresetId` — [класс хостов](../concepts/instance-types.md);
              * `diskSize` — размер диска в байтах;
              * `diskTypeId` — [тип диска](../concepts/storage.md).

          
          * `access` — настройки доступа кластера к следующим сервисам {{ yandex-cloud }}:

              * `dataLens` — [{{ datalens-full-name }}](../../datalens/index.yaml);
              * `webSql` — [{{ websql-full-name }}](../../websql/index.yaml);
              * `dataTransfer` — [{{ data-transfer-full-name }}](../../data-transfer/index.yaml).


      * `performanceDiagnostics` — настройки для [сбора статистики](performance-diagnostics.md#activate-stats-collector):

          * `enabled` — активация сбора статистики;
          * `sessionsSamplingInterval` — интервал сбора сессий: от `1` до `86400` секунд;
          * `statementsSamplingInterval` — интервал сбора запросов: от `1` до `86400` секунд.

      * `databaseSpecs` — настройки баз данных в виде массива элементов. Каждый элемент соответствует отдельной БД и содержит параметр `name` — имя БД.

          {% include [db-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}

      * `userSpecs` — настройки пользователей в виде массива элементов. Каждый элемент соответствует отдельному пользователю и имеет следующую структуру:

          * `name` — имя пользователя.
          * `password` — пароль пользователя.
          * `permissions` — настройки разрешений пользователя:

              * `databaseName` — имя базы данных, к которой пользователь получает доступ.
              * `roles` — массив привилегий пользователя. Каждая привилегия представлена в виде отдельной строки в массиве. Список доступных значений см. в разделе [Привилегии пользователей в кластере](../concepts/user-rights.md#db-privileges).

              Для каждой базы данных добавьте отдельный элемент с настройками разрешений в массив `permissions`.

      * `hostSpecs` — настройки хостов кластера в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

          * `zoneId` — [зона доступности](../../overview/concepts/geo-scope.md);
          * `subnetId` — идентификатор [подсети](../../vpc/concepts/network.md#subnet);
          * `assignPublicIp` — разрешение на [подключение](connect.md) к хосту из интернета.

  1. Воспользуйтесь методом [Cluster.create](../api-ref/Cluster/create.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters' \
          --data "@body.json"
      ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

      
      ```json
      {
          "folder_id": "<идентификатор_каталога>",
          "name": "<имя_кластера>",
          "environment": "<окружение>",
          "network_id": "<идентификатор_сети>",
          "security_group_ids": [
              "<идентификатор_группы_безопасности_1>",
              "<идентификатор_группы_безопасности_2>",
              ...
              "<идентификатор_группы_безопасности_N>"
          ],
          "deletion_protection": <защита_от_удаления:_true_или_false>,
          "config_spec": {
              "version": "<версия_{{ MY }}>",
              "resources": {
                  "resource_preset_id": "<класс_хостов>",
                  "disk_size": "<размер_хранилища_в_байтах>",
                  "disk_type_id": "<тип_диска>"
              },
              "access": {
                  "data_lens": <доступ_к_{{ datalens-name }}:_true_или_false>,
                  "web_sql": <доступ_к_{{ websql-name }}:_true_или_false>,
                  "data_transfer": <доступ_к_Data_Transfer:_true_или_false>
              },
              "performance_diagnostics": {
                  "enabled": <активация_сбора_статистики:_true_или_false>,
                  "sessions_sampling_interval": "<интервал_сбора_сессий>",
                  "statements_sampling_interval": "<интервал_сбора_запросов>"
              }
          },
          "database_specs": [
                {
                    "name": "<имя_БД>"
                },
                { <аналогичный_набор_настроек_для_БД_2> },
                { ... },
                { <аналогичный_набор_настроек_для_БД_N> }
            ],
          "user_specs": [
              {
                  "name": "<имя_пользователя>",
                  "password": "<пароль_пользователя>",
                  "permissions": [
                      {
                          "database_name": "<имя_БД>",
                          "roles": [
                              "<привилегия_1>", "<привилегия_2>", ..., "<привилегия_N>"
                          ]
                      }
                  ]
              }
          ],
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

      * `folder_id` — идентификатор каталога. Его можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
      * `name` — имя кластера.
      * `environment` — окружение кластера: `PRODUCTION` или `PRESTABLE`.
      * `network_id` — идентификатор [сети](../../vpc/concepts/network.md#network), в которой будет размещен кластер.

      
      * `security_group_ids` — идентификаторы [групп безопасности](../concepts/network.md#security-groups).


      * `deletion_protection` — защита от удаления кластера, его баз данных и пользователей.
      * `config_spec` — настройки кластера:

          * `version` — версия {{ MY }}.
          * `resources` — ресурсы кластера:

              * `resource_preset_id` — [класс хостов](../concepts/instance-types.md);
              * `disk_size` — размер диска в байтах;
              * `disk_type_id` — [тип диска](../concepts/storage.md).

          
          * `access` — настройки доступа кластера к следующим сервисам {{ yandex-cloud }}:

              * `data_lens` — [{{ datalens-full-name }}](../../datalens/index.yaml);
              * `web_sql` — [{{ websql-full-name }}](../../websql/index.yaml);
              * `data_transfer` — [{{ data-transfer-full-name }}](../../data-transfer/index.yaml).


      * `performance_diagnostics` — настройки для [сбора статистики](performance-diagnostics.md#activate-stats-collector):

          * `enabled` — активация сбора статистики;
          * `sessions_sampling_interval` — интервал сбора сессий: от `1` до `86400` секунд;
          * `statements_sampling_interval` — интервал сбора запросов: от `60` до `86400` секунд.

      * `database_specs` — настройки баз данных в виде массива элементов. Каждый элемент соответствует отдельной БД и содержит параметр `name` — имя БД.
      * `user_specs` — настройки пользователей в виде массива элементов. Каждый элемент соответствует отдельному пользователю и имеет следующую структуру:

          * `name` — имя пользователя.
          * `password` — пароль пользователя.
          * `permissions` — настройки разрешений пользователя:

              * `database_name` — имя базы данных, к которой пользователь получает доступ.
              * `roles` — массив привилегий пользователя. Каждая привилегия представлена в виде отдельной строки в массиве. Список доступных значений см. в разделе [Привилегии пользователей в кластере](../concepts/user-rights.md#db-privileges).

              Для каждой базы данных добавьте отдельный элемент с настройками разрешений в массив `permissions`.

      * `host_specs` — настройки хостов кластера в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

          * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md);
          * `subnet_id` — идентификатор [подсети](../../vpc/concepts/network.md#subnet);
          * `assign_public_ip` — разрешение на [подключение](connect.md) к хосту из интернета.

  1. Воспользуйтесь вызовом [ClusterService/Create](../api-ref/grpc/Cluster/create.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.Create \
          < body.json
      ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}


{% note warning %}

Если вы указали идентификаторы групп безопасности при создании кластера {{ mmy-name }}, для подключения к нему может потребоваться дополнительная [настройка групп безопасности](connect.md#configure-security-groups).

{% endnote %}


## Создать копию кластера {#duplicate}

Вы можете создать кластер {{ MY }}, который будет обладать настройками созданного ранее кластера. Для этого конфигурация исходного кластера {{ MY }} импортируется в {{ TF }}. В результате вы можете либо создать идентичную копию, либо взять за основу импортированную конфигурацию и внести в нее изменения. Использовать импорт удобно, если исходный кластер {{ MY }} обладает множеством настроек и нужно создать похожий на него кластер.

Чтобы создать копию кластера {{ MY }}:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. В той же рабочей директории разместите файл с расширением `.tf` и содержимым:

        ```hcl
        resource "yandex_mdb_mysql_cluster" "old" { }
        ```

    1. Запишите идентификатор первоначального кластера {{ MY }} в переменную окружения:

        ```bash
        export MYSQL_CLUSTER_ID=<идентификатор_кластера>
        ```

        Идентификатор можно запросить вместе со [списком кластеров в каталоге](../../managed-mysql/operations/cluster-list.md#list-clusters).

    1. Импортируйте настройки первоначального кластера {{ MY }} в конфигурацию {{ TF }}:

        ```bash
        terraform import yandex_mdb_mysql_cluster.old ${MYSQL_CLUSTER_ID}
        ```

    1. Получите импортированную конфигурацию:

        ```bash
        terraform show
        ```

    1. Скопируйте ее из терминала и вставьте в файл с расширением `.tf`.
    1. Расположите файл в новой директории `imported-cluster`.
    1. Измените скопированную конфигурацию так, чтобы из нее можно было создать новый кластер:

        * Укажите новое имя кластера в строке `resource` и параметре `name`.
        * Удалите параметры `created_at`, `health`, `id` и `status`.
        * В блоках `host` удалите параметры `fqdn`.
        * Если в блоке `maintenance_window` указано значение параметра `type = "ANYTIME"`, удалите параметр `hour`.
        * (Опционально) Внесите дополнительные изменения, если вам нужна не идентичная, а кастомизированная копия.

    1. В директории `imported-cluster` [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials).

    1. В этой же директории [настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).

    1. Поместите конфигурационный файл в директорию `imported-cluster` и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Проверьте корректность файлов конфигурации {{ TF }}:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

    {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

{% endlist %}

## Примеры {#examples}

### Создание кластера с одним хостом {#creating-a-single-host-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы создать кластер {{ mmy-name }} с одним хостом, передайте один параметр `--host`.

  Создайте кластер {{ mmy-name }} с тестовыми характеристиками:

  
  * С именем `my-mysql`.
  * Версии `{{ versions.cli.latest }}`.
  * В окружении `production`.
  * В сети `default`.
  * В группе безопасности с идентификатором `{{ security-group }}`.
  * С одним хостом класса `{{ host-class }}` в подсети `{{ subnet-id }}`, в зоне доступности `{{ region-id }}-a`.
  * С хранилищем на сетевых SSD-дисках (`{{ disk-type-example }}`) объемом 20 ГБ.
  * С одним пользователем (`user1`), с паролем `user1user1`.
  * С одной БД `db1`, в которой пользователь `user1` имеет полные права (эквивалент `GRANT ALL PRIVILEGES on db1.*`).
  * С защитой от случайного удаления кластера.


  1. Запустите команду создания кластера {{ mmy-name }}:

     
     ```bash
     {{ yc-mdb-my }} cluster create \
       --name="my-mysql" \
       --mysql-version {{ versions.cli.latest }} \
       --environment=production \
       --network-name=default \
       --security-group-ids {{ security-group }} \
       --host {{ host-net-example }} \
       --resource-preset {{ host-class }} \
       --disk-type {{ disk-type-example }} \
       --disk-size 20 \
       --user name=user1,password="user1user1" \
       --database name=db1 \
       --deletion-protection
     ```


  1. Запустите команду изменения привилегий пользователя `user1`.

     ```bash
     {{ yc-mdb-my }} user grant-permission user1 \
       --cluster-name="my-mysql" \
       --database=db1 \
       --permissions ALL
     ```

- {{ TF }} {#tf}

  Создайте кластер {{ mmy-name }} и сеть для него с тестовыми характеристиками:

    * С именем `my-mysql`.
    * Версии `{{ versions.tf.latest }}`.
    * В окружении `PRESTABLE`.
    * В облаке с идентификатором `{{ tf-cloud-id }}`.
    * В каталоге с идентификатором `{{ tf-folder-id }}`.
    * В новой сети `mynet`.
    * С одним хостом класса `{{ host-class }}` в новой подсети `mysubnet`, в зоне доступности `{{ region-id }}-a`. Подсеть `mysubnet` будет иметь диапазон `10.5.0.0/24`.

    
    * В новой группе безопасности `mysql-sg`, разрешающей подключение к кластеру {{ mmy-name }} из интернета через порт `{{ port-mmy }}`.


    * С хранилищем на сетевых SSD-дисках (`{{ disk-type-example }}`) объемом 20 ГБ.
    * С одним пользователем (`user1`), с паролем `user1user1`.
    * С одной БД `db1`, в которой пользователь `user1` имеет полные права (эквивалент `GRANT ALL PRIVILEGES on db1.*`).
    * С защитой от случайного удаления кластера {{ mmy-name }}.

  Конфигурационный файл для такого кластера {{ mmy-name }} выглядит так:

  
  ```hcl
  resource "yandex_mdb_mysql_cluster" "my-mysql" {
    name                = "my-mysql"
    environment         = "PRESTABLE"
    network_id          = yandex_vpc_network.mynet.id
    version             = "{{ versions.tf.latest }}"
    security_group_ids  = [ yandex_vpc_security_group.mysql-sg.id ]
    deletion_protection = true

    resources {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 20
    }

    host {
      zone      = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
    }
  }

  resource "yandex_mdb_mysql_database" "db1" {
    cluster_id = yandex_mdb_mysql_cluster.my-mysql.id
    name       = "db1"
  }

  resource "yandex_mdb_mysql_user" "<имя_пользователя>" {
    cluster_id = yandex_mdb_mysql_cluster.my-mysql.id
    name       = "user1"
    password   = "user1user1"
    permission {
      database_name = yandex_mdb_mysql_database.db1.name
      roles         = ["ALL"]
    }
  }

  resource "yandex_vpc_network" "mynet" {
    name = "mynet"
  }

  resource "yandex_vpc_security_group" "mysql-sg" {
    name       = "mysql-sg"
    network_id = yandex_vpc_network.mynet.id

    ingress {
      description    = "{{ MY }}"
      port           = {{ port-mmy }}
      protocol       = "TCP"
      v4_cidr_blocks = [ "0.0.0.0/0" ]
    }
  }

  resource "yandex_vpc_subnet" "mysubnet" {
    name           = "mysubnet"
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.mynet.id
    v4_cidr_blocks = ["10.5.0.0/24"]
  }
  ```


{% endlist %}

### Создание кластера из нескольких хостов {#creating-multiple-hosts-cluster}


{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы создать кластер {{ mmy-name }} из нескольких хостов, передайте столько параметров `--host`, сколько должно быть хостов в кластере.

  Создайте кластер {{ mmy-name }} с тестовыми характеристиками:

  
  * С именем `my-mysql-3`.
  * Версии `{{ versions.cli.latest }}`.
  * В окружении `prestable`.
  * В сети `default`.
  * В группе безопасности с идентификатором `{{ security-group }}`.
  * С тремя хостами класса `{{ host-class }}` с публичным доступом к ним.

    По одному хосту будет размещено в подсетях сети `default`:
    * `subnet-a`: `10.5.0.0/24`, зона доступности `{{ region-id }}-a`.
    * `subnet-b`: `10.6.0.0/24`, зона доступности `{{ region-id }}-b`.
    * `subnet-d`: `10.7.0.0/24`, зона доступности `{{ region-id }}-d`.

    Хосту в подсети `subnet-b` будет присвоен приоритет резервного копирования. Резервные копии будут создаваться из данных с этого хоста, если он не выбран хостом-мастером.

  * С хранилищем на сетевых SSD-дисках (`{{ disk-type-example }}`) объемом 32 ГБ.
  * С одним пользователем (`user1`), с паролем `user1user1`.
  * С одной БД `db1`, в которой пользователь `user1` имеет полные права (эквивалент `GRANT ALL PRIVILEGES on db1.*`).


  1. Запустите команду создания кластера {{ mmy-name }}:

     
     ```bash
     {{ yc-mdb-my }} cluster create \
       --name="my-mysql-3" \
       --mysql-version {{ versions.cli.latest }} \
       --environment=prestable \
       --network-name=default \
       --security-group-ids {{ security-group }} \
       --host zone-id={{ region-id }}-a,`
              `subnet-name=subnet-a,`
              `assign-public-ip=true \
       --host zone-id={{ region-id }}-b,`
              `subnet-name=subnet-b,`
              `backup-priority=10,`
              `assign-public-ip=true \
       --host zone-id={{ region-id }}-d,`
              `subnet-name=subnet-d,`
              `assign-public-ip=true \
       --resource-preset {{ host-class }} \
       --disk-type {{ disk-type-example }} \
       --disk-size 32 \
       --user name=user1,password="user1user1" \
       --database name=db1
     ```


  1. Запустите команду изменения привилегий пользователя `user1`.

     ```bash
     {{ yc-mdb-my }} user grant-permission user1 \
       --cluster-name="my-mysql-3" \
       --database=db1 \
       --permissions ALL
     ```

- {{ TF }} {#tf}

  Создайте кластер {{ mmy-name }} и сеть для него с тестовыми характеристиками:

    * С именем `my-mysql-3`.
    * Версии `{{ versions.tf.latest }}`.
    * В окружении `PRESTABLE`.
    * В облаке с идентификатором `{{ tf-cloud-id }}`.
    * В каталоге с идентификатором `{{ tf-folder-id }}`.
    * В новой сети `mynet`.
    * С тремя хостами класса `{{ host-class }}` с публичным доступом к ним.

      По одному хосту будет размещено в новых подсетях:
       * `mysubnet-a`: `10.5.0.0/24`, зона доступности `{{ region-id }}-a`.
       * `mysubnet-b`: `10.6.0.0/24`, зона доступности `{{ region-id }}-b`.
       * `mysubnet-d`: `10.7.0.0/24`, зона доступности `{{ region-id }}-d`.

      Эти подсети будут принадлежать сети `mynet`.

      Хосту в подсети `mysubnet-b` будет присвоен приоритет резервного копирования. Резервные копии будут создаваться из данных с этого хоста, если он не выбран хостом-мастером.

    
    * В новой группе безопасности `mysql-sg`, разрешающей подключение к кластеру {{ mmy-name }} из интернета через порт `{{ port-mmy }}`.


    * С хранилищем на сетевых SSD-дисках (`{{ disk-type-example }}`) объемом 32 ГБ.
    * С одним пользователем (`user1`), с паролем `user1user1`.
    * С одной БД `db1`, в которой пользователь `user1` имеет полные права (эквивалент `GRANT ALL PRIVILEGES on db1.*`).

  Конфигурационный файл для такого кластера {{ mmy-name }} выглядит так:

  
  ```hcl
  resource "yandex_mdb_mysql_cluster" "my-mysql-3" {
    name                = "my-mysql-3"
    environment         = "PRESTABLE"
    network_id          = yandex_vpc_network.mynet.id
    version             = "{{ versions.tf.latest }}"
    security_group_ids  = [ yandex_vpc_security_group.mysql-sg.id ]

    resources {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 32
    }

    host {
      zone             = "{{ region-id }}-a"
      subnet_id        = yandex_vpc_subnet.mysubnet-a.id
      assign_public_ip = true
    }

    host {
      zone             = "{{ region-id }}-b"
      subnet_id        = yandex_vpc_subnet.mysubnet-b.id
      assign_public_ip = true
      backup_priority  = 10
    }

    host {
      zone             = "{{ region-id }}-d"
      subnet_id        = yandex_vpc_subnet.mysubnet-d.id
      assign_public_ip = true
    }
  }

  resource "yandex_mdb_mysql_database" "db1" {
    cluster_id = yandex_mdb_mysql_cluster.my-mysql-3.id
    name       = "db1"
  }

  resource "yandex_mdb_mysql_user" "user1" {
    cluster_id = yandex_mdb_mysql_cluster.my-mysql-3.id
    name       = "user1"
    password   = "user1user1"
    permission {
      database_name = yandex_mdb_mysql_database.db1.name
      roles         = ["ALL"]
    }
  }

  resource "yandex_vpc_network" "mynet" {
    name = "mynet"
  }

  resource "yandex_vpc_security_group" "mysql-sg" {
    name       = "mysql-sg"
    network_id = yandex_vpc_network.mynet.id

    ingress {
      description    = "{{ MY }}"
      port           = {{ port-mmy }}
      protocol       = "TCP"
      v4_cidr_blocks = [ "0.0.0.0/0" ]
    }
  }

  resource "yandex_vpc_subnet" "mysubnet-a" {
    name             = "mysubnet-a"
    zone             = "{{ region-id }}-a"
    network_id       = yandex_vpc_network.mynet.id
    v4_cidr_blocks   = ["10.5.0.0/24"]
  }

  resource "yandex_vpc_subnet" "mysubnet-b" {
    name             = "mysubnet-b"
    zone             = "{{ region-id }}-b"
    network_id       = yandex_vpc_network.mynet.id
    v4_cidr_blocks   = ["10.6.0.0/24"]
  }

  resource "yandex_vpc_subnet" "mysubnet-d" {
    name             = "mysubnet-d"
    zone             = "{{ region-id }}-d"
    network_id       = yandex_vpc_network.mynet.id
    v4_cidr_blocks   = ["10.7.0.0/24"]
  }
  ```


{% endlist %}


{% include [connection-manager](../../_includes/mdb/connection-manager.md) %}

