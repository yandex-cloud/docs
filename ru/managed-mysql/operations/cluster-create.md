# Создание {{ MY }}-кластера

{{ MY }}-кластер — один или несколько хостов базы данных. В кластерах из более чем одного хоста автоматически настраивается [полусинхронная репликация](../concepts/replication.md).

Подробнее об устройстве кластера {{ mmy-name }} см. в разделе [{#T}](../concepts/index.md).

{% note info %}

* Количество хостов, которые можно создать вместе с {{ MY }}-кластером, зависит от выбранного [типа диска](../concepts/storage.md#storage-type-selection) и [класса хостов](../concepts/instance-types.md#available-flavors).
* Доступные типы диска [зависят](../concepts/storage.md) от выбранного [класса хостов](../concepts/instance-types.md#available-flavors).

{% endnote %}

## Как создать кластер {{ MY }} {#create-cluster}

{% list tabs %}

- Консоль управления

  
  @[youtube](https://www.youtube.com/watch?v=XflGoG03SHE&list=PL1x4ET76A10bW1KU3twrdm7hH376z8G5R&index=5&pp=iAQB)


  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать кластер БД.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. Введите имя кластера {{ mmy-name }} в поле **{{ ui-key.yacloud.mdb.forms.base_field_name }}**. Имя кластера должно быть уникальным в рамках каталога.
  1. Выберите окружение, в котором нужно создать кластер {{ mmy-name }} (после создания кластера окружение изменить невозможно):
     * `PRODUCTION` — для стабильных версий ваших приложений.
     * `PRESTABLE` — для тестирования, в том числе самого сервиса {{ mmy-name }}. В prestable-окружении раньше появляются новая функциональность, улучшения и исправления ошибок. При этом не все обновления обеспечивают обратную совместимость.
  1. Выберите версию СУБД.
  1. Выберите класс хостов — он определяет технические характеристики [виртуальных машин](../../compute/concepts/vm-platforms.md), на которых будут развернуты хосты БД. Все доступные варианты перечислены в разделе [{#T}](../concepts/instance-types.md). При изменении класса хостов для кластера {{ mmy-name }} меняются характеристики всех уже созданных хостов.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_disk }}**:

     * Выберите [тип диска](../concepts/storage.md).

              
       {% include [storages-step-settings](../../_includes/mdb/settings-storages.md) %}


     * Выберите объем, который будет использоваться для данных и резервных копий. Подробнее о том, как занимают пространство резервные копии, см. раздел [{#T}](../concepts/backup.md).

       {% note info %}

       Если хранилище БД заполнится на 95%, кластер {{ mmy-name }} перейдет в режим «только чтение». Увеличивайте размер хранилища заранее.

       {% endnote %}

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_database }}** укажите атрибуты БД:
     * Имя БД. Имя БД должно быть уникальным в рамках каталога и содержать только латинские буквы, цифры и подчеркивания.
     * Имя пользователя—владельца БД и пароль.

       {% include [user-name-and-passwords-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

  
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network }}** выберите:
     * [Облачную сеть](../../vpc/concepts/network.md#network) для размещения кластера {{ mmy-name }}.
     * [Группы безопасности](../../vpc/concepts/security-groups.md) для сетевого трафика кластера {{ mmy-name }}. Может потребоваться дополнительная [настройка групп безопасности](connect.md#configuring-security-groups), чтобы можно было подключаться к кластеру {{ mmy-name }}.

       {% note info %}

       {% include [security-groups-note](../../_includes/vpc/security-groups-note-services.md) %}

       {% endnote %}


  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_host }}** выберите параметры хостов БД, создаваемых вместе с кластером {{ mmy-name }}. При необходимости нажмите на значок ![image](../../_assets/edit.svg) и выберите конкретные [подсети](../../vpc/concepts/network.md#subnet) для каждого хоста — по умолчанию каждый хост создается в отдельной подсети.

          
     Если в блоке **{{ ui-key.yacloud.mdb.forms.section_disk }}** выбран `local-ssd` или `network-ssd-nonreplicated`, необходимо добавить не менее трех хостов в кластер {{ mmy-name }}. После создания кластера {{ mmy-name }} в него можно добавить дополнительные хосты, если для этого достаточно [ресурсов каталога](../concepts/limits.md).

     
  1. При необходимости задайте дополнительные настройки кластера {{ mmy-name }}:

     {% include [mmy-extra-settings](../../_includes/mdb/mmy-extra-settings-web-console.md) %}

  1. При необходимости задайте [настройки СУБД уровня кластера](../concepts/settings-list.md#dbms-cluster-settings).

     {% include [mmy-settings-dependence](../../_includes/mdb/mmy/note-info-settings-dependence.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.

- CLI

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
       --name=<имя кластера> \
       --environment <окружение, prestable или production> \
       --network-name <имя сети> \
       --host zone-id=<зона доступности>,subnet-id=<идентификатор подсети> \
       --mysql-version <версия {{ MY }}: {{ versions.cli.str }}> \
       --resource-preset <класс хоста> \
       --user name=<имя пользователя>,password=<пароль пользователя> \
       --database name=<имя БД> \
       --disk-size <размер хранилища в гигабайтах> \
       --disk-type <тип диска> \
       --security-group-ids <список идентификаторов групп безопасности>
     ```

     Идентификатор подсети `subnet-id` необходимо указывать, если в выбранной [зоне доступности](../../overview/concepts/geo-scope.md) создано две и больше подсетей.




     При необходимости задайте дополнительные настройки кластера {{ mmy-name }}:

     
     ```bash
     {{ yc-mdb-my }} cluster create \
       ...
       --backup-window-start <время начала резервного копирования> \
       --backup-retain-period-days=<срок хранения автоматических резервных копий, дней> \
       --datalens-access=<доступ к кластеру из {{ datalens-name }}: true или false> \
       --websql-access=<запросы из консоли управления: true или false> \
       --deletion-protection=<защита от удаления кластера: true или false>
     ```



     {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-db.md) %}

     При необходимости задайте [настройки СУБД](../concepts/settings-list.md#dbms-cluster-settings).

     {% note info %}

     По умолчанию при создании кластера устанавливается режим [технического обслуживания](../concepts/maintenance.md) `anytime` — в любое время. Вы можете установить конкретное время обслуживания при [изменении настроек кластера](update.md#change-additional-settings).

     {% endnote %}

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  
  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


  Чтобы создать кластер {{ mmy-name }}:
  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:
     * Кластер БД — описание кластера и его хостов.
     * База данных — описание БД кластера.
     * Пользователь — описание пользователя кластера.

     * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

     * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

     Пример структуры конфигурационного файла:

     
     
     ```hcl
     resource "yandex_mdb_mysql_cluster" "<имя кластера>" {
       name                = "<имя кластера>"
       environment         = "<окружение, PRESTABLE или PRODUCTION>"
       network_id          = "<идентификатор сети>"
       version             = "<версия {{ MY }}: {{ versions.tf.str }}>"
       security_group_ids  = [ "<список групп безопасности>" ]
       deletion_protection = <защита от удаления кластера: true или false>

       resources {
         resource_preset_id = "<класс хоста>"
         disk_type_id       = "<тип диска>"
         disk_size          = "<размер хранилища в гигабайтах>"
       }

       host {
         zone      = "<зона доступности>"
         subnet_id = "<идентификатор подсети>"
       }
     }

     resource "yandex_mdb_mysql_database" "<имя БД>" {
       cluster_id = "<идентификатор кластера>"
       name       = "<имя БД>"
     }

     resource "yandex_mdb_mysql_user" "<имя пользователя>" {
       cluster_id = "<идентификатор кластера>"
       name       = "<имя пользователя>"
       password   = "<пароль пользователя>"
       permission {
         database_name = "<имя БД>"
         roles         = ["ALL"]
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




     {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-db.md) %}

     * {% include [Maintenance window](../../_includes/mdb/mmy/terraform/maintenance-window.md) %}

     * {% include [Access settings](../../_includes/mdb/mmy/terraform/access-settings.md) %}

     * Чтобы задать время начала [резервного копирования](../concepts/backup.md), добавьте к описанию кластера {{ mmy-name }} блок `backup_window_start`:

       ```hcl
       resource "yandex_mdb_mysql_cluster" "<имя кластера>" {
         ...
         backup_window_start {
           hours   = <час начала резервного копирования>
           minutes = <минута начала резервного копирования>
         }
         ...
       }
       ```

     * Чтобы задать срок хранения резервных копий, укажите в описании кластера {{ mmy-name }} параметр `backup_retain_period_days`:

       ```hcl
       resource "yandex_mdb_mysql_cluster" "<имя кластера>" {
         ...
           backup_retain_period_days = <срок хранения автоматических резервных копий (в днях)>
           ...
       }
       ```

       Допустимые значения: от `7` до `60`. Значение по умолчанию — `7`.

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-mmy }}).
  1. Проверьте корректность конфигурационных файлов.

     {% include [terraform-create-cluster-step-2](../../_includes/mdb/terraform-create-cluster-step-2.md) %}

  1. Создайте кластер {{ mmy-name }}.

     {% include [terraform-create-cluster-step-3](../../_includes/mdb/terraform-create-cluster-step-3.md) %}

     {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API

  Чтобы создать кластер {{ MY }}, воспользуйтесь методом REST API [create](../api-ref/Cluster/create.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Create](../api-ref/grpc/cluster_service.md#Create) и передайте в запросе:
  * Идентификатор [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором должен быть размещен кластер {{ mmy-name }}, в параметре `folderId`.
  * Имя кластера {{ mmy-name }} в параметре `name`. Имя кластера должно быть уникальным в рамках каталога.
  * Окружение кластера {{ mmy-name }} в параметре `environment`.
  * Конфигурацию кластера {{ mmy-name }} в параметре `configSpec`.
  * Конфигурацию БД в одном или нескольких параметрах `databaseSpecs`.
  * Настройки пользователей в одном или нескольких параметрах `userSpecs`.
  * Конфигурацию хостов кластера {{ mmy-name }} в одном или нескольких параметрах `hostSpecs`.
  * Идентификатор [сети](../../vpc/concepts/network.md#network) в параметре `networkId`.

  
  * Идентификаторы [групп безопасности](../concepts/network.md#security-groups) в параметре `securityGroupIds`.


  При необходимости передайте время начала [резервного копирования](../concepts/backup.md) в параметре `configSpec.backupWindowStart` и срок хранения автоматических резервных копий (в днях) в параметре `configSpec.backupRetainPeriodDays`. Допустимые значения: от `7` до `60`. Значение по умолчанию — `7`.

  {% include [datatransfer access](../../_includes/mdb/api/datatransfer-access-create.md) %}

  {% include [datalens access](../../_includes/mdb/api/datalens-access.md) %}

{% endlist %}


{% note warning %}

Если вы указали идентификаторы групп безопасности при создании кластера {{ mmy-name }}, для подключения к нему может потребоваться дополнительная [настройка групп безопасности](connect.md#configure-security-groups).

{% endnote %}


## Примеры {#examples}

### Создание кластера с одним хостом {#creating-a-single-host-cluster}

{% list tabs %}

- CLI

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
      --deletion-protection=true
    ```


  1. Запустите команду изменения привилегий пользователя `user1`.

    ```bash
    {{ yc-mdb-my }} user grant-permission user1 \
      --cluster-name="my-mysql" \
      --database=db1 \
      --permissions ALL
    ```

- {{ TF }}

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

  resource "yandex_mdb_mysql_user" "<имя пользователя>" {
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
