---
title: Создание кластера {{ MG }}
description: Следуя данной инструкции, вы сможете создать кластер {{ MG }}.
---

# Создание кластера {{ MG }}

[Кластер](../../glossary/cluster.md) {{ MG }} — это один или несколько хостов базы данных, между которыми можно настроить [репликацию](../concepts/replication.md). Репликация работает по умолчанию в любом кластере из более чем 1 хоста (первичный хост принимает запросы на запись и асинхронно дублирует изменения на вторичных хостах).


{% note info %}


* Количество хостов, которые можно создать вместе с кластером {{ MG }}, зависит от выбранного [типа диска](../concepts/storage.md#storage-type-selection) и [класса хостов](../concepts/instance-types.md#available-flavors).
* Доступные типы диска [зависят](../concepts/storage.md) от выбранного [класса хостов](../concepts/instance-types.md).


{% endnote %}




## Создать кластер {#create-cluster}


Для создания кластера {{ mmg-name }} нужна роль [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) и роль [{{ roles.mmg.editor }} или выше](../security/index.md#roles-list). О том, как назначить роль, см. в [документации {{ iam-name }}](../../iam/operations/roles/grant.md).


{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы создать кластер {{ mmg-name }}:

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер БД.

  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}**:

      * Введите название в поле **{{ ui-key.yacloud.mdb.forms.base_field_name }}**. Имя кластера должно быть уникальным в рамках облака.
      * (Опционально) Введите **{{ ui-key.yacloud.mdb.forms.base_field_description }}** кластера.
      * Выберите окружение, в котором нужно создать кластер (после создания кластера окружение изменить невозможно):

          * `PRODUCTION` — для стабильных версий ваших приложений.
          * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.

      * Укажите версию СУБД.

  1. {% include [mmg-settings-host-class](../../_includes/mdb/mmg/settings-host-class.md) %}

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_disk }}**:

      * Выберите [тип диска](../concepts/storage.md).

        {% include [storages-type-no-change](../../_includes/mdb/storages-type-no-change.md) %}


        {% include [storages-step-settings](../../_includes/mdb/settings-storages.md) %}


      * Выберите размер хранилища, который будет использоваться для данных и резервных копий. Подробнее о том, как занимают пространство резервные копии, см. в разделе [Резервные копии](../concepts/backup.md).

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_database }}** укажите атрибуты БД:

      * Имя БД.

        {% include [db-name-limits](../../_includes/mdb/mmg/note-info-db-name-limits.md) %}

      * Имя пользователя.
      * Пароль пользователя. Минимум 8 символов.


  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network }}** выберите:

      * [Облачную сеть](../../vpc/concepts/network.md#network) для размещения кластера.
      * Группы безопасности для сетевого трафика кластера. Может потребоваться дополнительная [настройка групп безопасности](connect/index.md#configuring-security-groups) для того, чтобы можно было подключаться к кластеру.


  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_host }}** добавьте хосты БД, создаваемые вместе с кластером:


     * Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_add-host }}**.
     * Выберите [зону доступности](../../overview/concepts/geo-scope.md).
     * Выберите [подсеть](../../vpc/concepts/network.md#subnet) в указанной зоне доступности. Если подсети нет, создайте ее.
     * Если хост должен быть доступен снаружи {{ yandex-cloud }}, включите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**. Эту настройку нельзя изменить после создания хоста.


     
     Чтобы обеспечить отказоустойчивость, для типов диска `local-ssd` и `network-ssd-nonreplicated` необходимо как минимум 3 хоста. Подробнее см. в разделе [Хранилище](../concepts/storage.md).


     По умолчанию хосты создаются в разных зонах доступности. См. подробнее об [управлении хостами](hosts.md).
  
  1. При необходимости задайте дополнительные настройки кластера:

      {% include [mmg-extra-settings](../../_includes/mdb/mmg-extra-settings.md) %}

  1. При необходимости задайте [настройки СУБД](../concepts/settings-list.md#dbms-cluster-settings).

      {% include [mmg-settings-dependence](../../_includes/mdb/mmg/note-info-settings-dependence.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать кластер {{ mmg-name }}:


  1. Проверьте, есть ли в каталоге подсети для хостов кластера:

     ```bash
     yc vpc subnet list
     ```

     Если ни одной подсети в каталоге нет, [создайте нужные подсети](../../vpc/operations/subnet-create.md) в сервисе {{ vpc-short-name }}.


  1. Посмотрите описание команды CLI для создания кластера:

      ```bash
      {{ yc-mdb-mg }} cluster create --help
      ```

  1. Укажите параметры кластера в команде создания (в примере приведены не все параметры):


      ```bash
      {{ yc-mdb-mg }} cluster create \
        --name <имя_кластера> \
        --environment=<окружение> \
        --network-name <имя_сети> \
        --host zone-id=<зона_доступности>,`
              `subnet-id=<идентификатор_подсети>,`
              `assign-public-ip=<публичный_доступ> \
        --mongod-resource-preset <класс_хоста> \
        --user name=<имя_пользователя>,password=<пароль_пользователя> \
        --database name=<имя_БД> \
        --mongod-disk-type <network-hdd|network-ssd|network-ssd-nonreplicated|local-ssd> \
        --mongod-disk-size <размер_хранилища_ГБ> \
        --performance-diagnostics=<включить_диагностику> \
        --deletion-protection
      ```

      Идентификатор подсети `subnet-id` необходимо указывать, если в выбранной зоне доступности создано 2 и больше подсетей.


      Где:

      * `--environment` — окружение: `prestable` или `production`.


      * `--host` — параметры хоста:
         * `zone-id` — [зона доступности](../../overview/concepts/geo-scope.md).
         * `subnet-id` — [идентификатор подсети](../../vpc/concepts/network.md#subnet). Необходимо указывать, если в выбранной зоне доступности создано две или больше подсетей.
         * `assign-public-ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.

      * `--mongod-disk-type` — тип диска.

        {% include [storages-type-no-change](../../_includes/mdb/storages-type-no-change.md) %}


      * `--performance-diagnostics` — включить диагностику производительности кластера: `true` или `false`.
      * `--deletion-protection` — защита от удаления кластера.

      {% include [db-name-limits](../../_includes/mdb/mmg/note-info-db-name-limits.md) %}

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

      {% note info %}

      По умолчанию при создании кластера устанавливается режим [технического обслуживания](../concepts/maintenance.md) `anytime` — в любое время. Вы можете установить конкретное время обслуживания при [изменении настроек кластера](update.md#change-additional-settings).

      {% endnote %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы создать кластер {{ mmg-name }}:

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     * Кластер базы данных — описание кластера и его хостов.

     * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

     * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

     Пример структуры конфигурационного файла:



     ```hcl
     resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
       name                = "<имя_кластера>"
       environment         = "<окружение>"
       network_id          = "<идентификатор_сети>"
       security_group_ids  = [ "<список_идентификаторов_групп_безопасности>" ]
       deletion_protection = <защита_от_удаления_кластера>

       cluster_config {
         version = "<версия_{{ MG }}>"
       }

       resources_mongod {
         resource_preset_id = "<класс_хоста>"
         disk_type_id       = "<тип_диска>"
         disk_size          = <размер_хранилища_ГБ>
       }

       host {
         zone_id          = "<зона_доступности>"
         subnet_id        = "<идентификатор_подсети>"
         assign_public_ip = <публичный_доступ>
       }
     }

     resource "yandex_mdb_mongodb_database" "<имя_БД>" {
       cluster_id = "<идентификатор_кластера>"
       name       = "<имя_БД>"
     }

     resource "yandex_mdb_mongodb_user" "<имя_пользователя>" {
       cluster_id = <идентификатор_кластера>
       name       = "<имя_пользователя>"
       password   = "<пароль>"
       permission {
         database_name = "<имя_БД>"
         roles         = [ "<список_ролей_пользователя>" ]
       }
       depends_on = [
         yandex_mdb_mongodb_database.<имя_БД>
       ]
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


     * `host` — параметры хоста:
       * `zone_id` — зона доступности.
       * `subnet_id` — идентификатор подсети в выбранной зоне доступности.
       * `assign_public_ip` — публичный доступ к хосту: `true` или `false`.


     * `deletion_protection` — защита от удаления кластера: `true` или `false`.
     * `version` — версия {{ MG }}: {{ versions.tf.str }}.

     {% include [db-name-limits](../../_includes/mdb/mmg/note-info-db-name-limits.md) %}

     {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

     {% include [Maintenance window](../../_includes/mdb/mmg/terraform/maintenance-window.md) %}

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-mmg }}).

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Создайте кластер.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      После этого в указанном каталоге будут созданы все требуемые ресурсы, а в терминале отобразятся [FQDN хостов](../concepts/network.md#hostname). Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

      {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API {#api}

    Чтобы создать кластер {{ mmg-name }}, воспользуйтесь методом REST API [create](../api-ref/Cluster/create.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Create](../api-ref/grpc/Cluster/create.md) и передайте в запросе:

    * Идентификатор каталога, в котором должен быть размещен кластер, в параметре `folderId`.
    * Имя кластера в параметре `name`.
    * Окружение кластера в параметре `environment`.
    * Идентификатор сети в параметре `networkId`.
    * Конфигурацию кластера в параметре `configSpec`.
    * Конфигурацию хостов кластера в одном или нескольких параметрах `hostSpecs`.


    * Идентификаторы [групп безопасности](../concepts/network.md#security-groups) в параметре `securityGroupIds`.


    * Конфигурацию баз данных в одном или нескольких параметрах `databaseSpecs`.

      {% include [db-name-limits](../../_includes/mdb/mmg/note-info-db-name-limits.md) %}

    * Настройки пользователей в одном или нескольких параметрах `userSpecs`.
    * Настройки защиты от удаления кластера в параметре `deletionProtection`.

        {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-data.md) %}

{% endlist %}


{% note warning %}

Если вы указали идентификаторы групп безопасности при создании кластера, то для подключения к нему может потребоваться дополнительная [настройка групп безопасности](connect/index.md#configuring-security-groups).

{% endnote %}


## Создать копию кластера {#duplicate}

Вы можете создать кластер {{ MG }}, который будет обладать настройками созданного ранее кластера. Для этого конфигурация исходного кластера {{ MG }} импортируется в {{ TF }}. В результате вы можете либо создать идентичную копию, либо взять за основу импортированную конфигурацию и внести в нее изменения. Использовать импорт удобно, если исходный кластер {{ MG }} обладает множеством настроек и нужно создать похожий на него кластер.

Чтобы создать копию кластера {{ MG }}:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. В той же рабочей директории разместите файл с расширением `.tf` и содержимым:

        ```hcl
        resource "yandex_mdb_mongodb_cluster" "old" { }
        ```

    1. Запишите идентификатор первоначального кластера {{ MG }} в переменную окружения:

        ```bash
        export MONGODB_CLUSTER_ID=<идентификатор_кластера>
        ```

        Идентификатор можно запросить вместе со [списком кластеров в каталоге](../../managed-mongodb/operations/cluster-list.md#list-clusters).

    1. Импортируйте настройки первоначального кластера {{ MG }} в конфигурацию {{ TF }}:

        ```bash
        terraform import yandex_mdb_mongodb_cluster.old ${MONGODB_CLUSTER_ID}
        ```

    1. Получите импортированную конфигурацию:

        ```bash
        terraform show
        ```

    1. Скопируйте ее из терминала и вставьте в файл с расширением `.tf`.
    1. Расположите файл в новой директории `imported-cluster`.
    1. Измените скопированную конфигурацию так, чтобы из нее можно было создать новый кластер:

        * Укажите новое имя кластера в строке `resource` и параметре `name`.
        * Удалите параметры `created_at`, `health`, `id`, `sharded` и `status`.
        * В блоках `host` удалите параметры `health` и `name`.
        * Если в блоке `maintenance_window` указано значение параметра `type = "ANYTIME"`, удалите параметр `hour`.
        * Если есть блоки `user`, удалите их. Пользователи БД добавляются с помощью отдельного ресурса `yandex_mdb_mongodb_user`.
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

    {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

{% endlist %}

## Примеры {#examples}

### Создание кластера с одним хостом {#creating-a-single-host-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы создать кластер с одним хостом, передайте один параметр `--host`.

  Создайте кластер {{ mmg-name }} с тестовыми характеристиками:


  * С именем `mymg`.
  * В окружении `production`.
  * В сети `{{ network-name }}`.
  * В группе безопасности с идентификатором `{{ security-group }}`.
  * С одним хостом класса `{{ host-class }}` в подсети `b0rcctk2rvtr********`, в зоне доступности `{{ region-id }}-a`.
  * С хранилищем на сетевых SSD-дисках (`{{ disk-type-example }}`) размером 20 ГБ.
  * С одним пользователем, `user1`, с паролем `user1user1`.
  * С одной базой данных, `db1`.
  * С защитой от случайного удаления кластера.


  Выполните следующую команду:


  ```bash
  {{ yc-mdb-mg }} cluster create \
    --name mymg \
    --environment production \
    --network-name {{ network-name }} \
    --security-group-ids {{ security-group }} \
    --mongod-resource-preset {{ host-class }} \
    --host zone-id={{ region-id }}-a,subnet-id=b0rcctk2rvtr******** \
    --mongod-disk-size 20 \
    --mongod-disk-type {{ disk-type-example }} \
    --user name=user1,password=user1user1 \
    --database name=db1 \
    --deletion-protection
  ```


- {{ TF }} {#tf}

  Создайте кластер {{ mmg-name }} и сеть для него с тестовыми характеристиками:

  * Название — `mymg`.
  * Версия — `{{ versions.tf.latest }}`.
  * Окружение — `PRODUCTION`.
  * Идентификатор облака — `{{ tf-cloud-id }}`.
  * Идентификатор каталога — `{{ tf-folder-id }}`.
  * Сеть — `mynet`.
  * Класс хоста — `{{ host-class }}`.
  * Количество блоков `host` — один.
  * Подсеть — `mysubnet`. Сетевые настройки: 

    * Зона доступности — `{{ region-id }}-a`.
    * Диапазон — `10.5.0.0/24`.


  * Группа безопасности — `mymg-sg`. Правила группы разрешают TCP-подключения к кластеру из интернета через порт `{{ port-mmg }}`.


  * Хранилище на сетевых SSD-дисках — `{{ disk-type-example }}`.
  * Размер хранилища — 20 ГБ.
  * Пользователь — `user1`.
  * Пароль — `user1user1`.
  * База данных — `db1`.
  * Защита от случайного удаления кластера — включена.

  Конфигурационный файл для кластера с одним хостом:



  ```hcl
  resource "yandex_mdb_mongodb_cluster" "mymg" {
    name                = "mymg"
    environment         = "PRODUCTION"
    network_id          = yandex_vpc_network.mynet.id
    security_group_ids  = [ yandex_vpc_security_group.mymg-sg.id ]
    deletion_protection = true

    cluster_config {
      version = "{{ versions.tf.latest }}"
    }

    resources_mongod {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 20
    }

    host {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
    }
  }

  resource "yandex_mdb_mongodb_database" "db1" {
    cluster_id = yandex_mdb_mongodb_cluster.mymg.id
    name       = "db1"
  }

  resource "yandex_mdb_mongodb_user" "user1" {
    cluster_id = yandex_mdb_mongodb_cluster.mymg.id
    name       = "user1"
    password   = "user1user1"
    permission {
      database_name = "db1"
    }
    depends_on = [
      yandex_mdb_mongodb_database.db1
    ]
  }

  resource "yandex_vpc_network" "mynet" {
    name = "mynet"
  }

  resource "yandex_vpc_security_group" "mymg-sg" {
    name       = "mymg-sg"
    network_id = yandex_vpc_network.mynet.id

    ingress {
      description    = "MongoDB"
      port           = {{ port-mmg }}
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

### Создание шардированного кластера {#creating-a-sharded-cluster}

Кластер {{ mmg-name }} можно создать со [стандартным](#std-sharding) или [расширенным](#adv-sharding) шардированием. Подробнее о видах шардирования см. в разделе [Особенности управления шардированием](../concepts/sharding.md#shard-management).

#### Стандартное шардирование {#std-sharding}

Создайте кластер {{ mmg-name }} и сеть для него с несколькими хостами:

* один хост `MONGOD`;
* три хоста `MONGOINFRA`.

Тестовые характеристики кластера:

* Название — `mymg`.
* Окружение — `PRODUCTION`.
* Защита от случайного удаления кластера — включена.
* Версия — `{{ versions.tf.latest }}`.
* База данных — `db1`.
* Пользователь — `user1`.
* Пароль — `user1user1`.
* Класс хоста `MONGOD` — `{{ host-class }}`.
* Класс хостов `MONGOINFRA` — `c3-c2-m4`.
* Хранилище на сетевых SSD-дисках — `{{ disk-type-example }}`.
* Размер хранилища — 10 ГБ.

Сетевые характеристики:

* Сеть — `mynet`.
* Группа безопасности — `mymg-sg` с идентификатором `{{ security-group }}`. В {{ TF }} группа создается с правилом, которое разрешает TCP-подключения к кластеру из интернета через порт `{{ port-mmg }}`.

* Подсеть — `mysubnet`. 
* Зона доступности — `{{ region-id }}-a`.
* Диапазон — `10.5.0.0/24` (только для {{ TF }}).

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните команду, чтобы создать кластер {{ mmg-name }} со стандартным шардированием:

  ```bash
  {{ yc-mdb-mg }} cluster create \
     --name mymg \
     --environment production \
     --deletion-protection \
     --mongodb-version {{ versions.cli.latest }} \
     --database name=db1 \
     --user name=user1,password=user1user1 \
     --mongod-resource-preset {{ host-class }} \
     --mongod-disk-type {{ disk-type-example }} \
     --mongod-disk-size 10 \
     --host type=mongod,`
       `zone-id={{ region-id }}-a,`
       `subnet-name=mysubnet \
     --mongoinfra-resource-preset c3-c2-m4 \
     --mongoinfra-disk-type {{ disk-type-example }} \
     --mongoinfra-disk-size 10 \
     --host type=mongoinfra,`
       `zone-id={{ region-id }}-a,`
       `subnet-name=mysubnet \
     --host type=mongoinfra,`
       `zone-id={{ region-id }}-a,`
       `subnet-name=mysubnet \
     --host type=mongoinfra,`
       `zone-id={{ region-id }}-a,`
       `subnet-name=mysubnet \
     --network-name mynet \
     --security-group-ids {{ security-group }}
  ```

- {{ TF }} {#tf}

  Конфигурационный файл для кластера со стандартным шардированием:

  ```hcl
  resource "yandex_mdb_mongodb_cluster" "mymg" {
    name                = "mymg"
    environment         = "PRODUCTION"
    network_id          = yandex_vpc_network.mynet.id
    security_group_ids  = [ yandex_vpc_security_group.mymg-sg.id ]
    deletion_protection = true

    cluster_config {
      version = "{{ versions.tf.latest }}"
    }

    resources_mongod {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 10
    }

    resources_mongoinfra {
      resource_preset_id = "c3-c2-m4"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 10
    }

    host {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongod"
    }

    host {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongoinfra"
    }

    host {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongoinfra"
    }

    host {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongoinfra"
    }

  resource "yandex_mdb_mongodb_database" "db1" {
    cluster_id = yandex_mdb_mongodb_cluster.mymg.id
    name       = "db1"
  }

  resource "yandex_mdb_mongodb_user" "user1" {
    cluster_id = yandex_mdb_mongodb_cluster.mymg.id
    name       = "user1"
    password   = "user1user1"
    permission {
      database_name = "db1"
    }
    depends_on = [
      yandex_mdb_mongodb_database.db1
    ]
  }

  resource "yandex_vpc_network" "mynet" {
    name = "mynet"
  }

  resource "yandex_vpc_security_group" "mymg-sg" {
    name       = "mymg-sg"
    network_id = yandex_vpc_network.mynet.id

    ingress {
      description    = "MongoDB"
      port           = {{ port-mmg }}
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

#### Расширенное шардирование {#adv-sharding}

Создайте кластер {{ mmg-name }} и сеть для него с несколькими хостами:

* один хост `MONGOD`;
* два хоста `MONGOS`;
* три хоста `MONGOCFG`.

Тестовые характеристики кластера:

* Название — `mymg`.
* Окружение — `PRODUCTION`.
* Защита от случайного удаления кластера — включена.
* Версия — `{{ versions.tf.latest }}`.
* База данных — `db1`.
* Пользователь — `user1`.
* Пароль — `user1user1`.
* Класс хостов — `{{ host-class }}`.
* Хранилище на сетевых SSD-дисках — `{{ disk-type-example }}`.
* Размер хранилища — 10 ГБ.

Сетевые характеристики:

* Сеть — `mynet`.
* Группа безопасности — `mymg-sg` с идентификатором `{{ security-group }}`. В {{ TF }} группа создается с правилом, которое разрешает TCP-подключения к кластеру из интернета через порт `{{ port-mmg }}`.
* Подсеть — `mysubnet`. 
* Зона доступности — `{{ region-id }}-a`.
* Диапазон — `10.5.0.0/24` (только для {{ TF }}).

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните команду, чтобы создать кластер {{ mmg-name }} с расширенным шардированием:

  ```bash
  {{ yc-mdb-mg }} cluster create \
    --name mymg \
    --environment production \
    --deletion-protection \
    --mongodb-version {{ versions.cli.latest }} \
    --database name=db1 \
    --user name=user1,password=user1user1 \
    --mongod-resource-preset {{ host-class }} \
    --mongod-disk-type {{ disk-type-example }} \
    --mongod-disk-size 10 \
    --host type=mongod,`
      `zone-id={{ region-id }}-a,`
      `subnet-name=mysubnet \
    --mongos-resource-preset {{ host-class }} \
    --mongos-disk-type {{ disk-type-example }} \
    --mongos-disk-size 10 \
    --host type=mongos,`
      `zone-id={{ region-id }}-a,`
      `subnet-name=mysubnet \
    --host type=mongos,`
      `zone-id={{ region-id }}-a,`
      `subnet-name=mysubnet \
    --mongocfg-resource-preset {{ host-class }} \
    --mongocfg-disk-type {{ disk-type-example }} \
    --mongocfg-disk-size 10 \
    --host type=mongocfg,`
      `zone-id={{ region-id }}-a,`
      `subnet-name=mysubnet \
    --host type=mongocfg,`
      `zone-id={{ region-id }}-a,`
      `subnet-name=mysubnet \
    --host type=mongocfg,`
      `zone-id={{ region-id }}-a,`
      `subnet-name=mysubnet \
    --network-name mynet \
    --security-group-ids {{ security-group }}
  ```

- {{ TF }} {#tf}

  Конфигурационный файл для кластера с расширенным шардированием:

  ```hcl
  resource "yandex_mdb_mongodb_cluster" "mymg" {
    name                = "mymg"
    environment         = "PRODUCTION"
    network_id          = yandex_vpc_network.mynet.id
    security_group_ids  = [ yandex_vpc_security_group.mymg-sg.id ]
    deletion_protection = true

    cluster_config {
      version = "{{ versions.tf.latest }}"
    }

    resources_mongod {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 10
    }

    resources_mongos {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 10
    }

    resources_mongocfg {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 10
    }

    host {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongod"
    }

    host {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongos"
    }

    host {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongos"
    }

    host {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongocfg"
    }

    host {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongocfg"
    }

    host {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongocfg"
    }
  }

  resource "yandex_mdb_mongodb_database" "db1" {
    cluster_id = yandex_mdb_mongodb_cluster.mymg.id
    name       = "db1"
  }

  resource "yandex_mdb_mongodb_user" "user1" {
    cluster_id = yandex_mdb_mongodb_cluster.mymg.id
    name       = "user1"
    password   = "user1user1"
    permission {
      database_name = "db1"
    }
    depends_on = [
      yandex_mdb_mongodb_database.db1
    ]
  }

  resource "yandex_vpc_network" "mynet" {
    name = "mynet"
  }

  resource "yandex_vpc_security_group" "mymg-sg" {
    name       = "mymg-sg"
    network_id = yandex_vpc_network.mynet.id

    ingress {
      description    = "MongoDB"
      port           = {{ port-mmg }}
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
