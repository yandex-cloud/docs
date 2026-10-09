---
title: Создание кластера {{ SPQR }}
description: Следуя данной инструкции, вы сможете создать кластер {{ SPQR }} со стандартным или расширенным шардированием.
keywords:
  - keyword: создание кластера {{ SPQR }}
  - keyword: кластер {{ SPQR }}
  - keyword: '{{ SPQR }}'
---

# Создание кластера {{ SPQR }}



## Роли для создания кластера {#roles}

Для создания кластера {{ mspqr-name }} и работы с ним вашему аккаунту в {{ yandex-cloud }} нужны роли:

* {% include [roles-mspqr-editor](../../_includes/mdb/mspqr/roles-mspqr-editor.md) %}
* {% include [roles-vpc-user](../../_includes/mdb/roles-vpc-user.md) %}
* {% include [roles-mdb-viewer](../../_includes/mdb/roles-mdb-viewer-create-cluster.md) %}

О назначении ролей читайте в [документации {{ iam-full-name }}](../../iam/operations/roles/grant.md).


## Создать кластер {#create-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер {{ SPQR }}.
    1. [Перейдите]({{ link-console-main }}/link/managed-spqr) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        1. Задайте имя кластера. Имя должно быть уникальным в рамках каталога.
        1. (Опционально) Введите описание кластера.
        1. (Опционально) Создайте [метки](../../resource-manager/concepts/labels.md):

            1. Нажмите кнопку **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Введите метку в формате `ключ: значение`.
            1. Нажмите **Enter**.

        1. Выберите окружение, в котором нужно создать кластер (после создания кластера окружение изменить невозможно):

            * `PRODUCTION` — для стабильных версий ваших приложений.
            * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению, и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.

        1. Выберите тип шардирования:

            * `{{ ui-key.yacloud.spqr.section_sharding-type-standard }}` — кластер будет состоять только из инфраструктурных хостов.
            * `{{ ui-key.yacloud.spqr.section_sharding-type-advanced }}` — кластер будет состоять только из хостов-роутеров и хостов-координаторов.

    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network }}** выберите [сеть](../../vpc/operations/network-create.md) и [группы безопасности](../../vpc/concepts/security-groups.md) для кластера.

        
        {% include [note-sg](../../_includes/managed-spqr/note-sg.md) %}


    1. Задайте конфигурацию вычислительных ресурсов:

        * Для стандартного шардирования задайте в блоке **{{ ui-key.yacloud.spqr.section_infra }}** конфигурацию инфраструктурных хостов.
        * Для расширенного шардирования задайте в блоке **{{ ui-key.yacloud.spqr.section_router }}** конфигурацию хостов-роутеров.

            В блоке **{{ ui-key.yacloud.spqr.section_coordinator }}** задайте конфигурацию хостов-координаторов.

        Чтобы задать конфигурацию вычислительных ресурсов:

        1. В поле **{{ ui-key.yacloud.mdb.forms.resource_presets_field-generation }}** выберите платформу.
        1. Укажите **{{ ui-key.yacloud.mdb.forms.resource_presets_field-type }}** виртуальной машины, на которой будут развернуты хосты.
        1. Выберите **{{ ui-key.yacloud.mdb.forms.section_resource }}**.
        1. В блоке **{{ ui-key.yacloud.mdb.forms.section_storage }}** выберите тип диска и укажите размер [хранилища](../concepts/storage.md).
        1. В блоке **{{ ui-key.yacloud.spqr.section_hosts }}**:

            1. Нажмите кнопку **{{ ui-key.yacloud.mdb.hosts.dialog.label_title }}**, чтобы добавить нужное количество хостов, создаваемых вместе с кластером {{ SPQR }}.
            
            
            1. Нажмите на значок ![image](../../_assets/console-icons/pencil.svg) и укажите для каждого хоста:
                
                * [Зону доступности](../../overview/concepts/geo-scope.md).
                * [Подсеть](../../vpc/concepts/network.md#subnet) — по умолчанию каждый хост создается в отдельной подсети.
                * Опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**, если хост должен быть доступен извне {{ yandex-cloud }}.


            После создания кластера {{ SPQR }} в него можно добавить дополнительные хосты, если для этого достаточно [ресурсов каталога](../concepts/limits.md).

    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_database }}** укажите параметры БД, в которой можно выполнять запросы к таблицам на шардах. [Подробнее о подключении к БД](connect.md).

        * Имя БД. Допустимая длина — от 1 до 63 символов. Может содержать строчные и прописные буквы латинского алфавита, цифры, нижние подчеркивания и дефисы.

        * Имя пользователя. Допустимая длина — от 1 до 63 символов. Может содержать строчные и прописные буквы латинского алфавита, цифры, нижние подчеркивания и дефисы, но не может начинаться с дефиса.

        * Пароль пользователя. Допустимая длина — от 8 до 128 символов.

    1. Задайте дополнительные настройки кластера:

        {% include [extra-settings](../../_includes/mdb/mspqr/console/extra-settings.md) %}

    1. Чтобы задать [настройки СУБД уровня кластера](../concepts/settings-list.md), в блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}** нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}**.

    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать кластер {{ mspqr-name }}:

  1. Посмотрите описание команды CLI для создания кластера:

      ```bash
      yc managed-sharded-postgresql cluster create --help
      ```

  1. Укажите параметры кластера в команде создания (в примере приведены не все параметры):

      {% cut "Для кластера со стандартным шардированием" %}

            
      ```bash
      yc managed-sharded-postgresql cluster create \
         --name <имя_кластера> \
         --environment <окружение> \
         --network-name <имя_сети> \
         --security-group-ids <идентификаторы_групп_безопасности> \
         --host type=infra,`
               `zone-id=<зона_доступности>,`
               `subnet-id=<идентификатор_подсети>,`
               `assign-public-ip=<разрешить_публичный_доступ_к_хосту> \
         --infra-resource-preset <класс_хостов_INFRA> \
         --infra-disk-size <размер_хранилища_ГБ> \
         --infra-disk-type <тип_диска> \
         --database name=<имя_БД> \
         --user name=<имя_пользователя>,`
               `password=<пароль>,`
               `permission=<имя_БД>,`
               `connection-limit=<количество_подключений_для_пользователя>,`
               `connection-retries=<количество_повторных_попыток_соединения> \
         --deletion-protection=<защитить_кластер_от_удаления>
      ```


      {% endcut %}

      {% cut "Для кластера с расширенным шардированием" %}

      
      ```bash
      yc managed-sharded-postgresql cluster create \
         --name <имя_кластера> \
         --environment <окружение> \
         --network-name <имя_сети> \
         --security-group-ids <идентификаторы_групп_безопасности> \
         --host type=router,`
               `zone-id=<зона_доступности>,`
               `subnet-id=<идентификатор_подсети>,`
               `assign-public-ip=<разрешить_публичный_доступ_к_хосту> \
         --router-resource-preset <класс_хостов_роутера> \
         --router-disk-size <размер_хранилища_ГБ> \
         --router-disk-type <тип_диска> \
         --host type=coordinator,`
               `zone-id=<зона_доступности>,`
               `subnet-id=<идентификатор_подсети>,`
               `assign-public-ip=<разрешить_публичный_доступ_к_хосту> \
         --coordinator-resource-preset <класс_хостов_координатора> \
         --coordinator-disk-size <размер_хранилища_ГБ> \
         --coordinator-disk-type <тип_диска> \
         --database name=<имя_БД> \
         --user name=<имя_пользователя>,`
               `password=<пароль>,`
               `permission=<имя_БД>,`
               `connection-limit=<количество_подключений_для_пользователя>,`
               `connection-retries=<количество_повторных_попыток_соединения> \
         --deletion-protection=<защитить_кластер_от_удаления>
      ```


      {% endcut %}

      Где:

      * `--name` — имя кластера.
      * `--environment` — окружение кластера: `production` или `prestable`.
      * `--network-name` — имя [сети](../../vpc/concepts/network.md#network), в которой будет размещен кластер.

        {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}

      
      * `--security-group-ids` — идентификаторы [групп безопасности](../../vpc/concepts/security-groups.md) через запятую.

        {% include [note-sg](../../_includes/managed-spqr/note-sg.md) %}


      * `--host` — настройки хоста кластера. Параметр задается для каждого хоста отдельно и имеет следующую структуру:

        * `type` — тип хоста. Возможные значения:
          
          * `router` — [роутер](../concepts/index.md#router) в кластере с расширенным шардированием;
          * `coordinator` — [координатор](../concepts/index.md#coordinator) в кластере с расширенным шардированием;
          * `infra` — хост `INFRA` в кластере со стандартным шардированием.
        
        * `zone-id` — [зона доступности](../../overview/concepts/geo-scope.md).
        
        
        * `subnet-id` — идентификатор [подсети](../../vpc/concepts/network.md#subnet).
        * `assign-public-ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.

      
      * `--router-resource-preset` — [класс хостов](../concepts/instance-types.md) роутера.
      * `--router-disk-size` — размер диска роутера в гигабайтах.
      * `--router-disk-type` — [тип диска](../concepts/storage.md) роутера.
      * `--coordinator-resource-preset` — класс хостов координатора.
      * `--coordinator-disk-size` — размер диска координатора в гигабайтах.
      * `--coordinator-disk-type` — тип диска координатора.
      * `--infra-resource-preset` — класс хостов `INFRA`.
      * `--infra-disk-size` — размер диска `INFRA` в гигабайтах.
      * `--infra-disk-type` — тип диска `INFRA`.
      * `--database` — настройки базы данных:
        
        * `name` — имя базы данных.

        Для каждой базы данных задайте отдельный параметр `--database`.

      * `--user` — настройки пользователя. Параметр задается для каждого пользователя отдельно и имеет следующую структуру:
        
        * `name` — имя пользователя.
          
          {% include [user-name-limits](../../_includes/mdb/mspqr/console/user-name-limits.md) %}

        * `password` — пароль пользователя. Длина пароля — от 8 до 128 символов.
        * `permission` — имя базы данных, к которой пользователь получает доступ.

          Для каждой базы данных, к которой пользователю нужно предоставить доступ, передайте отдельный параметр `permission`.

        * `connection-limit` — максимальное количество одновременных подключений для пользователя.
        * `connection-retries` — максимальное количество повторных попыток соединения.

      * `--deletion-protection` — защита кластера от непреднамеренного удаления: `true` или `false`.

        {% include [deletion-protection-cluster](../../_includes/mdb/mspqr/deletion-protection-cluster.md) %}

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-data.md) %}
      
      1. Чтобы настроить окно [резервного копирования](../concepts/backup.md), передайте следующие параметры:

          ```bash
          yc managed-sharded-postgresql cluster create \
             ...
             --backup-window-start <время_начала_резервного_копирования> \
             --backup-retain-period-days <срок_хранения_автоматических_резервных_копий_в_днях> \
             ...
          ```

          Где:

          * `--backup-window-start` — время начала резервного копирования кластера по UTC в формате `HH:MM:SS`.
          * `--backup-retain-period-days` — срок хранения автоматических резервных копий. Возможные значения: от `7` до `60` дней. Значение по умолчанию — `7` дней.
      


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы создать кластер {{ mspqr-name }}:

  1. Опишите в конфигурационном файле параметры следующих ресурсов:

      * Кластер {{ mspqr-name }}.
      * База данных кластера.
      * Пользователь кластера.
      * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}
      * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

      Пример структуры конфигурационного файла:

      {% cut "Для кластера со стандартным шардированием" %}

      ```hcl
      resource "yandex_mdb_sharded_postgresql_cluster" "<локальное_имя_кластера>" {
        name                = "<имя_кластера>"
        environment         = "<окружение>"
        network_id          = yandex_vpc_network.<локальное_имя_сети>.id
        security_group_ids  = ["<идентификаторы_групп_безопасности>"]
        deletion_protection = <защитить_кластер_от_удаления>
  
        config = {
          sharded_postgresql_config = {
            infra = {
              resources = {
                resource_preset_id = "<класс_хостов_INFRA>"
                disk_size          = <размер_хранилища_ГБ>
                disk_type_id       = "<тип_диска>"
              }
            }
          }
        }

        hosts = {
          <имя_хоста> = {
            type             = "INFRA"
            zone             = "<зона_доступности>"
            subnet_id        = yandex_vpc_subnet.<локальное_имя_подсети>.id
            assign_public_ip = <разрешить_публичный_доступ_к_хосту>
          }
        } 
      }

      resource "yandex_mdb_sharded_postgresql_database" "<локальное_имя_БД>" {
        cluster_id = yandex_mdb_sharded_postgresql_cluster.<локальное_имя_кластера>.id
        name       = "<имя_БД>"
      }
      
      resource "yandex_mdb_sharded_postgresql_user" "<локальное_имя_пользователя>" {
        cluster_id = yandex_mdb_sharded_postgresql_cluster.<локальное_имя_кластера>.id
        name       = "<имя_пользователя>"
        password   = "<пароль>"

        permissions {
          database = yandex_mdb_sharded_postgresql_database.<локальное_имя_БД>.name
        }

        settings = {
          connection_limit   = <количество_подключений_для_пользователя>
          connection_retries = <количество_повторных_попыток_соединения>
        }
      }

      resource "yandex_vpc_network" "<локальное_имя_сети>" {
        name = "<имя_сети>"
      }

      resource "yandex_vpc_subnet" "<локальное_имя_подсети>" {
        name           = "<имя_подсети>"
        zone           = "<зона_доступности>"
        network_id     = yandex_vpc_network.<локальное_имя_сети>.id
        v4_cidr_blocks = ["<диапазон_IP-адресов>"]
      }
      ```
      
      {% endcut %}

      {% cut "Для кластера с расширенным шардированием" %}

      ```hcl
      resource "yandex_mdb_sharded_postgresql_cluster" "<локальное_имя_кластера>" {
        name                = "<имя_кластера>"
        environment         = "<окружение>"
        network_id          = yandex_vpc_network.<локальное_имя_сети>.id
        security_group_ids  = ["<идентификаторы_групп_безопасности>"]
        deletion_protection = <защитить_кластер_от_удаления>
  
        config = {
          sharded_postgresql_config = {
            router = {
              resources = {
                resource_preset_id = "<класс_хостов_роутера>"
                disk_size          = <размер_хранилища_ГБ>
                disk_type_id       = "<тип_диска>"
              }
            }
            
            coordinator = {
              resources = {
                resource_preset_id = "<класс_хостов_координатора>"
                disk_size          = <размер_хранилища_ГБ>
                disk_type_id       = "<тип_диска>"
              }
            }
          }
        }

        hosts = {
          <имя_хоста_1> = {
            type             = "ROUTER"
            zone             = "<зона_доступности>"
            subnet_id        = yandex_vpc_subnet.<локальное_имя_подсети>.id
            assign_public_ip = <разрешить_публичный_доступ_к_хосту>
          }

          <имя_хоста_2> = {
            type             = "COORDINATOR"
            zone             = "<зона_доступности>"
            subnet_id        = yandex_vpc_subnet.<локальное_имя_подсети>.id
            assign_public_ip = <разрешить_публичный_доступ_к_хосту>
          }
        } 
      }

      resource "yandex_mdb_sharded_postgresql_database" "<локальное_имя_БД>" {
        cluster_id = yandex_mdb_sharded_postgresql_cluster.<локальное_имя_кластера>.id
        name       = "<имя_БД>"
      }
      
      resource "yandex_mdb_sharded_postgresql_user" "<локальное_имя_пользователя>" {
        cluster_id = yandex_mdb_sharded_postgresql_cluster.<локальное_имя_кластера>.id
        name       = "<имя_пользователя>"
        password   = "<пароль>"

        permissions {
          database = yandex_mdb_sharded_postgresql_database.<локальное_имя_БД>.name
        }

        settings = {
          connection_limit   = <количество_пользовательских_подключений>
          connection_retries = <количество_повторов_при_подключении>
        }
      }

      resource "yandex_vpc_network" "<локальное_имя_сети>" {
        name = "<имя_сети>"
      }

      resource "yandex_vpc_subnet" "<локальное_имя_подсети>" {
        name           = "<имя_подсети>"
        zone           = "<зона_доступности>"
        network_id     = yandex_vpc_network.<локальное_имя_сети>.id
        v4_cidr_blocks = ["<диапазон_IP-адресов>"]
      }
      ```

      {% endcut %}

      Где:

      * `name` — имя кластера.
      * `environment` — окружение кластера: `PRODUCTION` или `PRESTABLE`.
      * `network_id` — идентификатор [сети](../../vpc/concepts/network.md#network), в которой будет размещен кластер.

        {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}

      * `security_group_ids` — список идентификаторов [групп безопасности](../../vpc/concepts/security-groups.md).

        {% include [note-sg](../../_includes/managed-spqr/note-sg.md) %}
      
      * `deletion_protection` — защита кластера от непреднамеренного удаления: `true` или `false`.

        {% include [deletion-protection-cluster](../../_includes/mdb/mspqr/deletion-protection-cluster.md) %}

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-data.md) %}

      * `hosts` — хосты кластера в виде ассоциативного массива элементов. Ключ задает имя хоста, а значение — параметры хоста. Каждый элемент имеет следующую структуру:

        * `type` — тип хоста. Возможные значения:
          
          * `ROUTER` — [роутер](../concepts/index.md#router) в кластере с расширенным шардированием;
          * `COORDINATOR` — [координатор](../concepts/index.md#coordinator) в кластере с расширенным шардированием;
          * `INFRA` — хост `INFRA` в кластере со стандартным шардированием.
        
        * `zone` — [зона доступности](../../overview/concepts/geo-scope.md).
        * `subnet_id` — идентификатор [подсети](../../vpc/concepts/network.md#subnet).
        * `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.
      
      * `config.sharded_postgresql_config.router.resources` — параметры ресурсов роутера в кластере с расширенным шардированием:
        
        * `resource_preset_id` — [класс хостов](../concepts/instance-types.md).
        * `disk_size` — размер диска в гигабайтах.
        * `disk_type_id` — [тип диска](../concepts/storage.md).
      
      * `config.sharded_postgresql_config.coordinator.resources` — параметры ресурсов координатора в кластере с расширенным шардированием:
        
        * `resource_preset_id` — класс хостов.
        * `disk_size` — размер диска в гигабайтах.
        * `disk_type_id` — тип диска.
      
      * `config.sharded_postgresql_config.infra.resources` — параметры ресурсов `INFRA` в кластере со стандартным шардированием:
        
        * `resource_preset_id` — класс хостов.
        * `disk_size` — размер диска в гигабайтах.
        * `disk_type_id` — тип диска.
      
      1. Чтобы настроить окно [резервного копирования](../concepts/backup.md), добавьте в блок `config` следующие параметры:

          ```hcl
          resource "yandex_mdb_sharded_postgresql_cluster" "<локальное_имя_кластера>" {
            ...
            config = {
              backup_window_start = {
                hours   = <часы>
                minutes = <минуты>
              }

              backup_retain_period_days = <срок_хранения_автоматических_резервных_копий_в_днях>
              ...
            }
            ...
          }
          ```

          Где:

          * `backup_window_start` — время начала резервного копирования кластера по UTC:
        
            * `hours` — от `0` до `23` часов.
            * `minutes` — от `0` до `59` минут.
        
          * `backup_retain_period_days` — срок хранения автоматических резервных копий. Возможные значения: от `7` до `60` дней. Значение по умолчанию — `7` дней.
    
      1. {% include [Maintenance window](../../_includes/mdb/mspqr/terraform/maintenance-window.md) %}
  
      Подробнее о ресурсе `yandex_mdb_sharded_postgresql_cluster` в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_sharded_postgresql_cluster).

  1. Проверьте корректность файлов конфигурации {{ TF }}:

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Создайте кластер:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}
      
      {% include [Terraform timeouts](../../_includes/mdb/mspqr/terraform/timeouts.md) %}


- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

     
     ```json
     {
       "folderId": "<идентификатор_каталога>",
       "name": "<имя_кластера>",
       "description": "<описание>",
       "environment": "<окружение>",
       "securityGroupIds": [
         "<идентификатор_группы_безопасности_1>",
         "<идентификатор_группы_безопасности_2>",
         ...
         "<идентификатор_группы_безопасности_N>"
       ],
       "networkId": "<идентификатор_сети>",
       "deletionProtection": <защитить_кластер_от_удаления>,
       "configSpec": {
         "spqrSpec": {
           "router": {
             "config": {
               "showNoticeMessages": <показывать_информационные_уведомления>,
               "timeQuantiles": [
                 <список_квантилей_времени_для_отображения_статистики>
               ],
               "defaultRouteBehavior": "<разрешать_мультишардовые_запросы>",
               "preferSameAvailabilityZone": <приоритет_маршрутизации_в_зону_доступности_роутера>
             },
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
             "router": {
               "showNoticeMessages": <показывать_информационные_уведомления>,
               "time_quantiles": [
                 <список_квантилей_времени_для_отображения_статистики>
               ],
               "defaultRouteBehavior": "<разрешать_мультишардовые_запросы>",
               "preferSameAvailabilityZone": <приоритет_маршрутизации_в_зону_доступности_роутера>
             },
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
           "hours": "<часы>",
           "minutes": "<минуты>",
           "seconds": "<секунды>",
           "nanos": "<наносекунды>"
         },
         "backupRetainPeriodDays": "<количество_дней>",
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
               "databaseName": "<имя_БД>"
             },
             { <имя_БД_2> },
             { ... },
             { <имя_БД_N> }
           ],
           "settings": {
             "connectionLimit": "<количество_пользовательских_соединений>",
             "connectionRetries": "<количество_повторов_при_подключении>"
           },
           "grants": [
             "привилегия_1",
             ...,
             "привилегия_N"
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
           "assignPublicIp": <разрешить_публичный_доступ_к_хосту>,
           "type": "<тип_хоста>"
         },
         { <аналогичный_набор_настроек_для_хоста_2> },
         { ... },
         { <аналогичный_набор_настроек_для_хоста_N> }
       ],
       "shardSpecs": [
         {
           "shardName": "<имя_шарда>",
           "mdbPostgresql": {
             "clusterId": "<идентификатор_кластера>"
           }
         },
         { <аналогичный_набор_настроек_для_шарда_2> },
         { ... },
         { <аналогичный_набор_настроек_для_шарда_N> }
       ],
       "maintenanceWindow": {
         "weeklyMaintenanceWindow": {
           "day": "<день_недели>",
           "hour": "<порядковый_номер_часового_интервала>"
         }
       }
     }
     ```


     Где:

     * `folderId` — идентификатор каталога.  Его можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
     * `name` — имя кластера.
     * `environment` — окружение кластера: `PRODUCTION` или `PRESTABLE`.
     * `networkId` — идентификатор [сети](../../vpc/concepts/network.md#network), в которой будет размещен кластер.

       {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}

     
     * `securityGroupIds` — идентификаторы [групп безопасности](../../vpc/concepts/security-groups.md).

        {% include [note-sg](../../_includes/managed-spqr/note-sg.md) %}


     * `deletionProtection` — защита кластера от удаления: `true` или `false`.

        {% include [deletion-protection-cluster](../../_includes/mdb/mspqr/deletion-protection-cluster.md) %}

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-data.md) %}

     * `configSpec` — настройки кластера:

       * `spqrSpec` — настройки сервиса {{ SPQR }}:

         * `router` — при [расширенном шардировании](../concepts/index.md#router) задайте настройки роутера:

           * `config` — конфигурация роутера:

             * `showNoticeMessages` — показывать информационные уведомления: `true` или `false`.
             * `timeQuantiles` — массив строк временных квантилей для отображения статистики. По умолчанию используются значения `"0.5"`, `"0.75"`, `"0.9"`, `"0.95"`, `"0.99"`, `"0.999"`, `"0.9999"`.
             * `defaultRouteBehavior` — политика выполнения мультишардовых запросов роутером. Возможные значения: `BLOCK` — блокировать, `ALLOW` — разрешать.
             * `preferSameAvailabilityZone` — включить приоритет маршрутизации запросов на чтение в зону доступности роутера: `true` или `false`.

           * `resources` — параметры ресурсов хостов `ROUTER`:
             
             * `resourcePresetId` — [класс хостов](../concepts/instance-types.md);
             * `diskSize` — размер диска в байтах;
             * `diskTypeId` — [тип диска](../concepts/storage.md).

         * `coordinator` – при расширенном шардировании задайте параметры ресурсов координатора:
             
             * `resourcePresetId` — класс хостов;
             * `diskSize` — размер диска в байтах;
             * `diskTypeId` — тип диска.

         * `infra` – при стандартном шардировании задайте настройки хостов `INFRA`:

           * `resources` — параметры ресурсов:
              
              * `resourcePresetId` — класс хостов;
              * `diskSize` — размер диска в байтах;
              * `diskTypeId` — тип диска.

           * `router` — конфигурация роутера:

             * `showNoticeMessages` — показывать информационные уведомления: `true` или `false`.
             * `timeQuantiles` — массив временных квантилей для отображения статистики. По умолчанию используются значения `0.5`, `0.75`, `0.9`, `0.95`, `0.99`, `0.999`, `0.9999`.
             * `defaultRouteBehavior` — политика выполнения мультишардовых запросов роутером. Возможные значения: `BLOCK` — блокировать, `ALLOW` — разрешать.
             * `preferSameAvailabilityZone` — включить приоритет маршрутизации запросов на чтение в зону доступности роутера: `true` или `false`.

           * `consolePassword` — пароль консоли {{ SPQR }}.
           * `logLevel` — уровень логирования запросов: `DEBUG`, `INFO`, `WARNING`, `ERROR`, `FATAL`, `PANIC`.


       * `backupWindowStart` — настройки окна резервного копирования.

           В параметре укажите время, когда начинать резервное копирование. Возможные значения параметров:

           * `hours` — от `0` до `23` часов;
           * `minutes` — от `0` до `59` минут;
           * `seconds` — от `0` до `59` секунд;
           * `nanos` — от `0` до `999999999` наносекунд.

       * `backupRetainPeriodDays` — сколько дней хранить резервную копию кластера. Возможные значения: от `7` до `60` дней.

     * `databaseSpecs` — настройки баз данных в виде массива элементов. Каждый элемент соответствует отдельной БД и имеет следующую структуру:

       * `name` — имя БД.

     * `userSpecs` — настройки пользователей в виде массива элементов. Каждый элемент соответствует отдельному пользователю и имеет следующую структуру:

       * `name` — имя пользователя.
       * `password` — пароль пользователя. Длина пароля — от 8 до 128 символов.
       * `permissions.databaseName` — имя базы данных, к которой пользователь получает доступ.
       * `settings` — параметры пользовательских подключений к БД:

         * `connectionLimit` — лимит подключений.
         * `connectionRetries` — количество повторных попыток подключения.

       * `grants` – привилегии пользователя в виде массива строк. Возможные значения: `reader`, `writer`, `admin`, `transfer`.

     * `hostSpecs` — настройки хостов кластера в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

       * `zoneId` — [зона доступности](../../overview/concepts/geo-scope.md);

       
       * `subnetId` — идентификатор [подсети](../../vpc/concepts/network.md#subnet);
       * `assignPublicIp` — разрешение на [подключение](connect.md) к хосту из интернета: `true` или `false`;


       * `type` — тип хоста. Возможные значения:
         
         * `ROUTER` — роутер в кластере с расширенным шардированием;
         * `COORDINATOR` — координатор в кластере с расширенным шардированием;
         * `INFRA` — хост `INFRA` в кластере со стандартным шардированием.

     * `shardSpecs` — настройки шардов в виде массива элементов. Каждый элемент соответствует отдельному шарду и имеет следующую структуру:

       * `shardName` — имя шарда.
       * `mdbPostgresql.clusterId` — идентификатор кластера {{ mpg-name }} в составе шарда.

     * `maintenanceWindow` — настройки расписания окна [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). Передайте один из двух параметров:

         * `anytime` — техническое обслуживание проводится в любое время.
         * `weeklyMaintenanceWindow` — техническое обслуживание проводится раз в неделю в указанное время:

             * `day` — день недели: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
             * `hour` — порядковый номер часового интервала по UTC: от `1` до `24`.

               > Например, `1` соответствует интервалу с `00:00` до `01:00`, `5` — с `04:00` до `05:00`.

  1. Воспользуйтесь методом [Cluster.Create](../api-ref/Cluster/create.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters' \
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
       "description": "<описание>",
       "environment": "<окружение>",
       "security_group_ids": [
         "<идентификатор_группы_безопасности_1>",
         "<идентификатор_группы_безопасности_2>",
         ...
         "<идентификатор_группы_безопасности_N>"
       ],
       "network_id": "<идентификатор_сети>",
       "deletion_protection": <защитить_кластер_от_удаления>,
       "config_spec": {
         "spqr_spec": {
           "router": {
             "config": {
               "show_notice_messages": {
                 "value": <показывать_информационные_уведомления>
               },
               "time_quantiles": [
                 <список_квантилей_времени_для_отображения_статистики>
               ],
               "default_route_behavior": "<разрешать_мультишардовые_запросы>",
               "prefer_same_availability_zone": {
                 "value": <приоритет_маршрутизации_в_зону_доступности_роутера>
               }
             },
             "resources": {
               "resource_preset_id": "<класс_хостов_роутера>",
               "disk_size": "<размер_хранилища_в_байтах>",
               "disk_type_id": "<тип_диска>" }
           },
           "coordinator": {
             "resources": {
               "resource_preset_id": "<класс_хостов_координатора>",
               "disk_size": "<размер_хранилища_в_байтах>",
               "disk_type_id": "<тип_диска>"
             }
           },
           "infra": {
             "resources": {
               "resource_preset_id": "класс_хостов_INFRA",
               "disk_size": "<размер_хранилища_в_байтах>",
               "disk_type_id": "<тип_диска>"
             },
             "router": {
               "show_notice_messages": {
                 "value": <показывать_информационные_уведомления>
               },
               "time_quantiles": [
                 <список_квантилей_времени_для_отображения_статистики>
               ],
               "default_route_behavior": "<разрешать_мультишардовые_запросы>",
               "prefer_same_availability_zone": {
                 "value": <приоритет_маршрутизации_в_зону_доступности_роутера>
               }
             },
           },
           "console_password": "<пароль_консоли_Sharded_PostgreSQL>",
           "log_level": "<уровень_логирования>"
         },
         "backup_window_start": {
           "hours": "<часы>",
           "minutes": "<минуты>",
           "seconds": "<секунды>",
           "nanos": "<наносекунды>"
         },
         "backup_retain_period_days": "<количество_дней>"
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
               "database_name": "<имя_БД>"
             },
             { <имя_БД_2> },
             { ... },
             { <имя_БД_N> }
           ],
           "settings": {
             "connection_limit": {
               "value": <количество_пользовательских_соединений>
             },
             "connection_retries": {
               "value": <количество_повторов_при_подключении>
             }
           },
           "grants": [
             "привилегия_1",
             ...,
             "привилегия_N"
           ]
         },
         { <аналогичный_набор_настроек_для_пользователя_2> },
         { ... },
         { <аналогичный_набор_настроек_для_пользователя_N> }
       ],
       "host_specs": [
         {
           "zone_id": "<зона_доступности>",
           "subnet_id": "<идентификатор_подсети>",
           "assign_public_ip": <разрешить_публичный_доступ_к_хосту>,
           "type": "<тип_хоста>"
         },
         { <аналогичный_набор_настроек_для_хоста_2> },
         { ... },
         { <аналогичный_набор_настроек_для_хоста_N> }
       ],
       "shard_specs": [
         {
           "shard_name": "<имя_шарда>",
           "mdb_postgresql": {
             "cluster_id": "<идентификатор_кластера>"
           }
         },
         { <аналогичный_набор_настроек_для_шарда_2> },
         { ... },
         { <аналогичный_набор_настроек_для_шарда_N> }
       ],
       "maintenance_window": {
         "weekly_maintenance_window": {
           "day": "<день_недели>",
           "hour": "<порядковый_номер_часового_интервала>"
         }
       }
     }
     ```


     Где:

     * `folder_id` — идентификатор каталога.  Его можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
     * `name` — имя кластера.
     * `environment` — окружение кластера: `PRODUCTION` или `PRESTABLE`.
     * `network_id` — идентификатор [сети](../../vpc/concepts/network.md#network), в которой будет размещен кластер.

       {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}

     
     * `security_group_ids` — идентификаторы [групп безопасности](../../vpc/concepts/security-groups.md).

        {% include [note-sg](../../_includes/managed-spqr/note-sg.md) %}


     * `deletion_protection` — защита кластера от удаления: `true` или `false`.

        {% include [deletion-protection-cluster](../../_includes/mdb/mspqr/deletion-protection-cluster.md) %}

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-data.md) %}

     * `config_spec` — настройки кластера:

       * `spqr_spec` — настройки сервиса {{ SPQR }}:

         * `router` — при [расширенном шардировании](../concepts/index.md#router) задайте настройки роутера:
           
           * `config` — конфигурация роутера:

             * `show_notice_messages` — показывать информационные уведомления: `true` или `false`.
             * `time_quantiles` — массив временных квантилей для отображения статистики. По умолчанию используются значения `0.5`, `0.75`, `0.9`, `0.95`, `0.99`, `0.999`, `0.9999`.
             * `default_route_behavior` — политика выполнения мультишардовых запросов роутером. Возможные значения: `BLOCK` — блокировать, `ALLOW` — разрешать.
             * `prefer_same_availability_zone` — включить приоритет маршрутизации запросов на чтение в зону доступности роутера: `true` или `false`.

           * `resources` — параметры ресурсов хостов `ROUTER`:
             
             * `resource_preset_id` — [класс хостов](../concepts/instance-types.md);
             * `disk_size` — размер диска в байтах;
             * `disk_type_id` — [тип диска](../concepts/storage.md).

         * `coordinator` – при расширенном шардировании задайте параметры ресурсов координатора:
             
             * `resource_preset_id` — класс хостов;
             * `disk_size` — размер диска в байтах;
             * `disk_type_id` — тип диска.

         * `infra` – при стандартном шардировании задайте настройки хостов `INFRA`:

           * `resources` — параметры ресурсов:
              
              * `resource_preset_id` — класс хостов;
              * `disk_size` — размер диска в байтах;
              * `disk_type_id` — тип диска.

           * `router` — конфигурация роутера:
               
               * `default_route_behavior` — поведение роутера по умолчанию. Возможные значения: `BLOCK` — блокировать запрос, `ALLOW` — разрешать.
               * `prefer_same_availability_zone` — включить приоритет маршрутизации в зону доступности роутера: `true` или `false`.

           * `console_password` — пароль консоли {{ SPQR }}.
           * `log_level` — уровень логирования запросов: `DEBUG`, `INFO`, `WARNING`, `ERROR`, `FATAL`, `PANIC`.


       * `backup_window_start` — настройки окна резервного копирования.

         В параметре укажите время, когда начинать резервное копирование. Возможные значения параметров:

         * `hours` — от `0` до `23` часов;
         * `minutes` — от `0` до `59` минут;
         * `seconds` — от `0` до `59` секунд;
         * `nanos` — от `0` до `999999999` наносекунд.

       * `backup_retain_period_days` — сколько дней хранить резервную копию кластера. Возможные значения: от `7` до `60` дней.

     * `database_specs` — настройки баз данных в виде массива элементов. Каждый элемент соответствует отдельной БД и имеет следующую структуру:

       * `name` — имя БД.

     * `user_specs` — настройки пользователей в виде массива элементов. Каждый элемент соответствует отдельному пользователю и имеет следующую структуру:

       * `name` — имя пользователя.
       * `password` — пароль пользователя. Длина пароля — от 8 до 128 символов.
       * `permissions.database_name` — имя базы данных, к которой пользователь получает доступ.
       * `settings` — параметры пользовательских подключений к БД:

         * `connection_limit` — лимит подключений.
         * `connection_retries` — количество повторных попыток подключения.

       * `grants` – привилегии пользователя в виде массива строк. Возможные значения: `reader`, `writer`, `admin`, `transfer`.

     * `host_specs` — настройки хостов кластера в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

       * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md);

       
       * `subnet_id` — идентификатор [подсети](../../vpc/concepts/network.md#subnet);
       * `assign_public_ip` — разрешение на [подключение](connect.md) к хосту из интернета: `true` или `false`;


       * `type` — тип хоста. Возможные значения:
         
         * `ROUTER` — роутер в кластере с расширенным шардированием;
         * `COORDINATOR` — координатор в кластере с расширенным шардированием;
         * `INFRA` — хост `INFRA` в кластере со стандартным шардированием.

     * `shard_specs` — настройки шардов в виде массива элементов. Каждый элемент соответствует отдельному шарду и имеет следующую структуру:

       * `shard_name` — имя шарда.
       * `mdb_postgresql.cluster_id` — идентификатор кластера {{ mpg-name }} в составе шарда.

     * `maintenance_window` — настройки расписания окна [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). Передайте один из двух параметров:

         * `anytime` — техническое обслуживание проводится в любое время.
         * `weekly_maintenance_window` — техническое обслуживание проводится раз в неделю в указанное время:

             * `day` — день недели: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
             * `hour` — порядковый номер часового интервала по UTC: от `1` до `24`.

               > Например, `1` соответствует интервалу с `00:00` до `01:00`, `5` — с `04:00` до `05:00`.

  1. Воспользуйтесь вызовом [ClusterService.Create](../api-ref/grpc/Cluster/create.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d @ \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.ClusterService.Create \
       < body.json
     ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}


## Примеры {#examples}


### Создание кластера со стандартным шардированием {#creating-standard-sharded-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

  Создайте кластер {{ mspqr-name }} с тестовыми характеристиками:

  * Имя `spqr-std`.
  * Окружение `production`.
  * Сеть `{{ network-name }}`.

    
  * Группа безопасности `enpjfvd3f34c********`.
  * Один хост `infra` в зоне доступности `{{ region-id }}-a` в подсети с идентификатором `e9bhbia2scnk********`.

  
  * Класс хоста `{{ host-class }}`.
  
  
  * Хранилище на сетевых SSD-дисках (`{{ disk-type-example }}`) размером `10` ГБ.
  

  * База данных `db1`.
  * Пользователь `user1` с паролем `Password123` и доступом к базе данных `db1`.
  * Защита от непреднамеренного удаления кластера включена.

  Выполните следующую команду:

  
  ```bash
  yc managed-sharded-postgresql cluster create \
     --name spqr-std \
     --environment production \
     --network-name {{ network-name }} \
     --security-group-ids enpjfvd3f34c******** \
     --host type=infra,zone-id={{ region-id }}-a,subnet-id=e9bhbia2scnk******** \
     --infra-resource-preset {{ host-class }} \
     --infra-disk-size 10 \
     --infra-disk-type {{ disk-type-example }} \
     --database name=db1 \
     --user name=user1,password=Password123,permission=db1 \
     --deletion-protection=true
  ```



- {{ TF }} {#tf}
  
  Создайте кластер {{ mspqr-name }}, а также сеть, подсеть и группу безопасности для него, используя следующие тестовые характеристики:
  
  * Имя `spqr-std`.
  * Окружение `PRODUCTION`.
  * Сеть `spqr-network`.
  * Группа безопасности `spqr-sg` с правилами, которые разрешают входящие и исходящие TCP-подключения на порт `{{ port-mpg }}`.
    
    Эти правила нужны для подключения роутера к хостам шарда, а также для подключения к кластеру через интернет. Для подключения к кластеру через интернет также включите публичный доступ к хосту. [Подробнее о подключении к кластеру](connect.md).

  * Один хост `INFRA` в зоне доступности `{{ region-id }}-a` в подсети `spqr-network-{{ region-id }}-a` с диапазоном IP-адресов `10.128.0.0/24`.
  * Класс хоста `{{ host-class }}`.
  * Хранилище на сетевых SSD-дисках (`{{ disk-type-example }}`) размером `10` ГБ.
  * База данных `db1`.
  * Пользователь `user1` с паролем `Password123` и доступом к базе данных `db1`.
  * Защита от непреднамеренного удаления кластера включена.
  
  Конфигурационный файл для создания этих ресурсов выглядит так:

  ```hcl
  resource "yandex_vpc_network" "spqr_network" {
    description = "Network for the Managed Service for Sharded PostgreSQL"
    name        = "spqr-network"
  }

  resource "yandex_vpc_subnet" "subnet_a" {
    description    = "Subnet in the {{ region-id }}-a availability zone"
    name           = "spqr-network-{{ region-id }}-a"
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.spqr_network.id
    v4_cidr_blocks = ["10.128.0.0/24"]
  }

  resource "yandex_vpc_security_group" "spqr_sg" {
    description = "Security group for the Managed Service for Sharded PostgreSQL"
    name        = "spqr-sg"
    network_id  = yandex_vpc_network.spqr_network.id

    ingress {
      description    = "Allow connections from the Internet and between cluster components"
      port           = 6432
      protocol       = "TCP"
      v4_cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
      description    = "Allow connections between cluster components"
      port           = 6432
      protocol       = "TCP"
      v4_cidr_blocks = ["0.0.0.0/0"]
    }
  }

  resource "yandex_mdb_sharded_postgresql_cluster" "spqr_cluster" {
    description         = "Managed Service for Sharded PostgreSQL cluster with standard sharding"
    name                = "spqr-std"
    environment         = "PRODUCTION"
    network_id          = yandex_vpc_network.spqr_network.id
    security_group_ids  = [yandex_vpc_security_group.spqr_sg.id]
    deletion_protection = true
  
    config = {
      sharded_postgresql_config = {
        infra = {
          resources = {
            disk_size          = 10
            disk_type_id       = "{{ disk-type-example }}"
            resource_preset_id = "{{ host-class }}"
          }
        }
      }
    }

    hosts = {
      infra1 = {
        type      = "INFRA"
        zone      = "{{ region-id }}-a"
        subnet_id = yandex_vpc_subnet.subnet_a.id
      }
    } 
  }

  resource "yandex_mdb_sharded_postgresql_database" "spqr_cluster_db" {
    cluster_id = yandex_mdb_sharded_postgresql_cluster.spqr_cluster.id
    name       = "db1"
  }

  resource "yandex_mdb_sharded_postgresql_user" "spqr_cluster_user" {
    cluster_id = yandex_mdb_sharded_postgresql_cluster.spqr_cluster.id
    name       = "user1"
    password   = "Password123"
    
    permissions {
      database = yandex_mdb_sharded_postgresql_database.spqr_cluster_db.name
    }
  }
  ```


{% endlist %}


### Создание кластера с расширенным шардированием {#creating-advanced-sharded-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

  Создайте кластер {{ mspqr-name }} с тестовыми характеристиками:

  * Имя `spqr-adv`.
  * Окружение `production`.
  * Сеть `{{ network-name }}`.
  
  
  * Группа безопасности `enpjfvd3f34c********`.
  * Три хоста `router` класса `{{ host-class }}` по одному в каждой зоне доступности:
    
    * в зоне доступности `{{ region-id }}-a` в подсети с идентификатором `e9bhbia2scnk********`;
    * в зоне доступности `{{ region-id }}-b` в подсети с идентификатором `e2lfqbm5nt9r********`;
    * в зоне доступности `{{ region-id }}-d` в подсети с идентификатором `fl8beqmjckv8********`.
  
  * Три хоста `coordinator` класса `{{ host-class }}` по одному в каждой зоне доступности:
    
    * в зоне доступности `{{ region-id }}-a` в подсети с идентификатором `e9bhbia2scnk********`;
    * в зоне доступности `{{ region-id }}-b` в подсети с идентификатором `e2lfqbm5nt9r********`;
    * в зоне доступности `{{ region-id }}-d` в подсети с идентификатором `fl8beqmjckv8********`.

  * Хранилище на сетевых SSD-дисках (`{{ disk-type-example }}`) размером `10` ГБ для каждого хоста `router`.
  * Хранилище на сетевых SSD-дисках (`{{ disk-type-example }}`) размером `10` ГБ для каждого хоста `coordinator`.
  

  * База данных `db1`.
  * Пользователь `user1` с паролем `Password123` и доступом к базе данных `db1`.
  * Защита от непреднамеренного удаления кластера включена.

  Выполните следующую команду:

  
  ```bash
  yc managed-sharded-postgresql cluster create \
     --name spqr-adv \
     --environment production \
     --network-name {{ network-name }} \
     --security-group-ids enpjfvd3f34c******** \
     --host type=router,zone-id={{ region-id }}-a,subnet-id=e9bhbia2scnk******** \
     --host type=router,zone-id={{ region-id }}-b,subnet-id=e2lfqbm5nt9r******** \
     --host type=router,zone-id={{ region-id }}-d,subnet-id=fl8beqmjckv8******** \
     --host type=coordinator,zone-id={{ region-id }}-a,subnet-id=e9bhbia2scnk******** \
     --host type=coordinator,zone-id={{ region-id }}-b,subnet-id=e2lfqbm5nt9r******** \
     --host type=coordinator,zone-id={{ region-id }}-d,subnet-id=fl8beqmjckv8******** \
     --router-resource-preset {{ host-class }} \
     --router-disk-size 10 \
     --router-disk-type {{ disk-type-example }} \
     --coordinator-resource-preset {{ host-class }} \
     --coordinator-disk-size 10 \
     --coordinator-disk-type {{ disk-type-example }} \
     --database name=db1 \
     --user name=user1,password=Password123,permission=db1 \
     --deletion-protection=true
  ```



- {{ TF }} {#tf}
  
  Создайте кластер {{ mspqr-name }}, а также сеть, подсеть и группу безопасности для него, используя следующие тестовые характеристики:
  
  * Имя `spqr-adv`.
  * Окружение `PRODUCTION`.
  * Сеть `spqr-network`.
  * Группа безопасности `spqr-sg` с правилами, которые разрешают входящие и исходящие TCP-подключения на порт `{{ port-mpg }}`.
    
    Эти правила нужны для подключения роутера к хостам шарда, а также для подключения к кластеру через интернет. Для подключения к кластеру через интернет также включите публичный доступ к хостам. [Подробнее о подключении к кластеру](connect.md).
  
  * Три хоста `ROUTER` класса `{{ host-class }}` по одному в каждой зоне доступности:
    
    * в зоне доступности `{{ region-id }}-a` в подсети `spqr-network-{{ region-id }}-a` с диапазоном IP-адресов `10.128.0.0/24`;
    * в зоне доступности `{{ region-id }}-b` в подсети `spqr-network-{{ region-id }}-b` с диапазоном IP-адресов `10.128.1.0/24`;
    * в зоне доступности `{{ region-id }}-d` в подсети `spqr-network-{{ region-id }}-d` с диапазоном IP-адресов `10.128.2.0/24`.
  
  * Три хоста `COORDINATOR` класса `{{ host-class }}` по одному в каждой зоне доступности:
    
    * в зоне доступности `{{ region-id }}-a` в подсети `spqr-network-{{ region-id }}-a` с диапазоном IP-адресов `10.128.0.0/24`;
    * в зоне доступности `{{ region-id }}-b` в подсети `spqr-network-{{ region-id }}-b` с диапазоном IP-адресов `10.128.1.0/24`;
    * в зоне доступности `{{ region-id }}-d` в подсети `spqr-network-{{ region-id }}-d` с диапазоном IP-адресов `10.128.2.0/24`.
  
  * Хранилище на сетевых SSD-дисках (`{{ disk-type-example }}`) размером `10` ГБ для каждого хоста `ROUTER`.
  * Хранилище на сетевых SSD-дисках (`{{ disk-type-example }}`) размером `10` ГБ для каждого хоста `COORDINATOR`.
  * База данных `db1`.
  * Пользователь `user1` с паролем `Password123` и доступом к базе данных `db1`.
  * Защита от непреднамеренного удаления кластера включена.
  
  Конфигурационный файл для создания этих ресурсов выглядит так:

  ```hcl
  resource "yandex_vpc_network" "spqr_network" {
    description = "Network for the Managed Service for Sharded PostgreSQL"
    name        = "spqr-network"
  }

  resource "yandex_vpc_subnet" "subnet_a" {
    description    = "Subnet in the {{ region-id }}-a availability zone"
    name           = "spqr-network-{{ region-id }}-a"
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.spqr_network.id
    v4_cidr_blocks = ["10.128.0.0/24"]
  }

  resource "yandex_vpc_subnet" "subnet_b" {
    description    = "Subnet in the {{ region-id }}-b availability zone"
    name           = "spqr-network-{{ region-id }}-b"
    zone           = "{{ region-id }}-b"
    network_id     = yandex_vpc_network.spqr_network.id
    v4_cidr_blocks = ["10.128.1.0/24"]
  }

  resource "yandex_vpc_subnet" "subnet_d" {
    description    = "Subnet in the {{ region-id }}-d availability zone"
    name           = "spqr-network-{{ region-id }}-d"
    zone           = "{{ region-id }}-d"
    network_id     = yandex_vpc_network.spqr_network.id
    v4_cidr_blocks = ["10.128.2.0/24"]
  }

  resource "yandex_vpc_security_group" "spqr_sg" {
    description = "Security group for the Managed Service for Sharded PostgreSQL"
    name        = "spqr-sg"
    network_id  = yandex_vpc_network.spqr_network.id

    ingress {
      description    = "Allow connections from the Internet and between cluster components"
      port           = 6432
      protocol       = "TCP"
      v4_cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
      description    = "Allow connections between cluster components"
      port           = 6432
      protocol       = "TCP"
      v4_cidr_blocks = ["0.0.0.0/0"]
    }
  }

  resource "yandex_mdb_sharded_postgresql_cluster" "spqr_cluster" {
    description         = "Managed Service for Sharded PostgreSQL cluster with advanced sharding"
    name                = "spqr-adv"
    environment         = "PRODUCTION"
    network_id          = yandex_vpc_network.spqr_network.id
    security_group_ids  = [yandex_vpc_security_group.spqr_sg.id]
    deletion_protection = true
  
    config = {
      sharded_postgresql_config = {
        router = {
          resources = {
            disk_size          = 10
            disk_type_id       = "{{ disk-type-example }}"
            resource_preset_id = "{{ host-class }}"
          }
        }
        coordinator = {
          resources = {
            disk_size          = 10
            disk_type_id       = "{{ disk-type-example }}"
            resource_preset_id = "{{ host-class }}"
          }
        }
      }
    }

    hosts = {
      router1 = {
        type      = "ROUTER"
        zone      = "{{ region-id }}-a"
        subnet_id = yandex_vpc_subnet.subnet_a.id
      }

      router2 = {
        type      = "ROUTER"
        zone      = "{{ region-id }}-b"
        subnet_id = yandex_vpc_subnet.subnet_b.id
      }
    
      router3 = {
        type      = "ROUTER"
        zone      = "{{ region-id }}-d"
        subnet_id = yandex_vpc_subnet.subnet_d.id
      }

      coordinator1 = {
        type      = "COORDINATOR"
        zone      = "{{ region-id }}-a"
        subnet_id = yandex_vpc_subnet.subnet_a.id
      }

      coordinator2 = {
        type      = "COORDINATOR"
        zone      = "{{ region-id }}-b"
        subnet_id = yandex_vpc_subnet.subnet_b.id
      }
    
      coordinator3 = {
        type      = "COORDINATOR"
        zone      = "{{ region-id }}-d"
        subnet_id = yandex_vpc_subnet.subnet_d.id
      }
    } 
  }

  resource "yandex_mdb_sharded_postgresql_database" "spqr_cluster_db" {
    cluster_id = yandex_mdb_sharded_postgresql_cluster.spqr_cluster.id
    name       = "db1"
  }

  resource "yandex_mdb_sharded_postgresql_user" "spqr_cluster_user" {
    cluster_id = yandex_mdb_sharded_postgresql_cluster.spqr_cluster.id
    name       = "user1"
    password   = "Password123"
  
    permissions {
      database = yandex_mdb_sharded_postgresql_database.spqr_cluster_db.name
    }
  }
  ```


{% endlist %}