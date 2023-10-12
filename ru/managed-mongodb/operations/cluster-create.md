# Создание {{ MG }}-кластера

{{ MG }}-кластер — это один или несколько хостов базы данных, между которыми можно настроить репликацию. Репликация работает по умолчанию в любом кластере из более чем 1 хоста (первичный хост принимает запросы на запись и асинхронно дублирует изменения на вторичных хостах).


{% note info %}


* Количество хостов, которые можно создать вместе с {{ MG }}-кластером, зависит от выбранного [типа диска](../concepts/storage.md#storage-type-selection) и [класса хостов](../concepts/instance-types.md#available-flavors).
* Доступные типы диска [зависят](../concepts/storage.md) от выбранного [класса хостов](../concepts/instance-types.md).


{% endnote %}



{% list tabs %}

- Консоль управления

  Чтобы создать кластер:

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер БД.

  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}**:

      * Введите название в поле **{{ ui-key.yacloud.mdb.forms.base_field_name }}**. Имя кластера должно быть уникальным в рамках каталога.
      * (Опционально) Введите **{{ ui-key.yacloud.mdb.forms.base_field_description }}** кластера.
      * Выберите окружение, в котором нужно создать кластер (после создания кластера окружение изменить невозможно):

          * `PRODUCTION` — для стабильных версий ваших приложений.
          * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.

      * Укажите версию СУБД.

  1. {% include [mmg-settings-host-class](../../_includes/mdb/mmg/settings-host-class.md) %}

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_disk }}**:

      * Выберите [тип диска](../concepts/storage.md).

        
        {% include [storages-step-settings](../../_includes/mdb/settings-storages.md) %}


      * Выберите размер хранилища, который будет использоваться для данных и резервных копий. Подробнее о том, как занимают пространство резервные копии, см. раздел [{#T}](../concepts/backup.md).

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_database }}** укажите атрибуты БД:

      * Имя БД.

        {% include [db-name-limits](../../_includes/mdb/mmg/note-info-db-name-limits.md) %}

      * Имя пользователя.
      * Пароль пользователя. Минимум 8 символов.

  
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network }}** выберите:

      * Облачную сеть для размещения кластера.
      * Группы безопасности для сетевого трафика кластера. Может потребоваться дополнительная [настройка групп безопасности](connect/index.md#configuring-security-groups) для того, чтобы можно было подключаться к кластеру.


  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_host }}** добавьте хосты БД, создаваемые вместе с кластером:

     
     * Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_add-host }}**.
     * Выберите [зону доступности](../../overview/concepts/geo-scope.md).
     * Выберите [подсеть](../../vpc/concepts/network.md#subnet) в указанной зоне доступности. Если подсети нет, создайте ее.
     * Если хост должен быть доступен снаружи {{ yandex-cloud }}, включите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.


          
     Чтобы обеспечить отказоустойчивость, для типов диска `local-ssd` и `network-ssd-nonreplicated` необходимо как минимум 3 хоста. Подробнее см. в разделе [Хранилище](../concepts/storage.md).


     По умолчанию хосты создаются в разных зонах доступности. См. подробнее об [управлении хостами](hosts.md).
  
  1. При необходимости задайте дополнительные настройки кластера:

      {% include [mmg-extra-settings](../../_includes/mdb/mmg-extra-settings.md) %}

  1. При необходимости задайте [настройки СУБД](../concepts/settings-list.md#dbms-cluster-settings).

      {% include [mmg-settings-dependence](../../_includes/mdb/mmg/note-info-settings-dependence.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать кластер:

  
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
        --name <имя кластера> \
        --environment=<окружение, prestable или production> \
        --network-name <имя сети> \
        --host zone-id=<зона доступности>,subnet-id=<идентификатор подсети> \
        --mongod-resource-preset <класс хоста> \
        --user name=<имя пользователя>,password=<пароль пользователя> \
        --database name=<имя базы данных> \
        --mongod-disk-type <тип диска> \
        --mongod-disk-size <размер хранилища в гигабайтах> \
        --deletion-protection=<защита от удаления кластера: true или false>
      ```

      Идентификатор подсети `subnet-id` необходимо указывать, если в выбранной зоне доступности создано 2 и больше подсетей.


      {% include [db-name-limits](../../_includes/mdb/mmg/note-info-db-name-limits.md) %}

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

      {% note info %}

      По умолчанию при создании кластера устанавливается режим [технического обслуживания](../concepts/maintenance.md) `anytime` — в любое время. Вы можете установить конкретное время обслуживания при [изменении настроек кластера](update.md#change-additional-settings).

      {% endnote %}

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  
  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


  Чтобы создать кластер:

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     * Кластер базы данных — описание кластера и его хостов.

     * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

     * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

     Пример структуры конфигурационного файла:

     
     
     ```hcl
     resource "yandex_mdb_mongodb_cluster" "<имя кластера>" {
       name                = "<имя кластера>"
       environment         = "<окружение: PRESTABLE или PRODUCTION>"
       network_id          = "<идентификатор сети>"
       security_group_ids  = [ "<список групп безопасности>" ]
       deletion_protection = <защита от удаления кластера: true или false>

       cluster_config {
         version = "<версия {{ MG }}: {{ versions.tf.str }}>"
       }

       database {
         name = "<имя базы данных>"
       }

       user {
         name     = "<имя пользователя>"
         password = "<пароль пользователя>"
         permission {
           database_name = "<имя базы данных>"
           roles         = [ "<список ролей пользователя>" ]
         }
       }

       resources_mongod {
         resource_preset_id = "<класс хоста>"
         disk_type_id       = "<тип диска>"
         disk_size          = <размер хранилища, ГБ>
       }

       host {
         zone_id   = "<зона доступности>"
         subnet_id = "<идентификатор подсети>"
       }
     }

     resource "yandex_vpc_network" "<имя сети>" { name = "<имя сети>" }

     resource "yandex_vpc_subnet" "<имя подсети>" {
       name           = "<имя подсети>"
       zone           = "<зона доступности>"
       network_id     = "<идентификатор сети>"
       v4_cidr_blocks = ["<диапазон>"]
     }
     ```




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

- API

    Чтобы создать кластер, воспользуйтесь методом REST API [create](../api-ref/Cluster/create.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Create](../api-ref/grpc/cluster_service.md#Create) и передайте в запросе:

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


## Примеры {#examples}

### Создание кластера с одним хостом {#creating-a-single-host-cluster}

{% list tabs %}

- CLI

  Чтобы создать кластер с одним хостом, передайте один параметр `--host`.

  Создайте кластер {{ mmg-name }} с тестовыми характеристиками:

  
  * С именем `mymg`.
  * В окружении `production`.
  * В сети `{{ network-name }}`.
  * В группе безопасности с идентификатором `{{ security-group }}`.
  * С одним хостом класса `{{ host-class }}` в подсети `b0rcctk2rvtr8efcch64`, в зоне доступности `{{ region-id }}-a`.
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
    --host zone-id={{ region-id }}-a,subnet-id=b0rcctk2rvtr8efcch64 \
    --mongod-disk-size 20 \
    --mongod-disk-type {{ disk-type-example }} \
    --user name=user1,password=user1user1 \
    --database name=db1 \
    --deletion-protection=true
  ```


- {{ TF }}

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

    database {
      name = "db1"
    }

    user {
      name     = "user1"
      password = "user1user1"
      permission {
        database_name = "db1"
      }
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

Кластер {{ mmg-name }} можно создать со [стандартным](#std-sharding) или [расширенным](#adv-sharding) шардированием. Подробнее о видах шардирования см. в разделе [{#T}](../concepts/sharding.md#shard-management).

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
* Количество блоков `host` — четыре. Для каждого из них задается тип хоста: `mongod` или `mongoinfra`.

Сетевые характеристики:

* Сеть — `mynet`.
* Группа безопасности — `mymg-sg`. Правила группы разрешают TCP-подключения к кластеру из интернета через порт `{{ port-mmg }}`.
* Подсеть — `mysubnet`. 
* Зона доступности — `{{ region-id }}-a`.
* Диапазон — `10.5.0.0/24`.

{% list tabs %}

- {{ TF }}

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

    database {
      name = "db1"
    }

    user {
      name     = "user1"
      password = "user1user1"
      permission {
        database_name = "db1"
      }
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
* Количество блоков `host` — шесть. Для каждого из них задается тип хоста: `mongod`, `mongos` или `mongocfg`.

Сетевые характеристики:

* Сеть — `mynet`.
* Группа безопасности — `mymg-sg`. Правила группы разрешают TCP-подключения к кластеру из интернета через порт `{{ port-mmg }}`.
* Подсеть — `mysubnet`. 
* Зона доступности — `{{ region-id }}-a`.
* Диапазон — `10.5.0.0/24`.

{% list tabs %}

- {{ TF }}

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

    database {
      name = "db1"
    }

    user {
      name     = "user1"
      password = "user1user1"
      permission {
        database_name = "db1"
      }
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
