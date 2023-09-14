# Создание {{ PG }}-кластера

{{ PG }}-кластер — это один или несколько [хостов базы данных](../concepts/index.md), между которыми можно настроить [репликацию](../concepts/replication.md). Репликация работает по умолчанию в любом кластере из более чем одного хоста: хост-мастер принимает запросы на запись и дублирует изменения в репликах. Транзакция подтверждается, если данные записаны на [диск](../concepts/storage.md) и на хосте-мастере, и на определенном числе реплик, достаточном для формирования кворума.

{% note info %}

* Количество хостов, которые можно создать вместе с {{ PG }}-кластером, зависит от выбранного [типа диска](../concepts/storage.md#storage-type-selection) и [класса хостов](../concepts/instance-types.md#available-flavors).
* Доступные типы диска зависят от выбранного [класса хостов](../concepts/instance-types.md#available-flavors).
* Если хранилище БД заполнится на 95%, кластер перейдет в режим только чтения. Рассчитывайте и увеличивайте необходимый размер хранилища заранее.

{% endnote %}

По умолчанию {{ mpg-name }} выставляет максимально возможное количество подключений к каждому хосту {{ PG }}-кластера. Этот максимум не может быть больше значения настройки [Max connections](../concepts/settings-list.md#setting-max-connections).

{% include [note-pg-user-connections.md](../../_includes/mdb/note-pg-user-connections.md) %}

## Как создать кластер {{ PG }} {#create-cluster}

{% list tabs %}

- Консоль управления

  
  @[youtube](https://www.youtube.com/watch?v=UByUvah7lDU&list=PL1x4ET76A10bW1KU3twrdm7hH376z8G5R&index=6&pp=iAQB)


  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать кластер БД.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. Введите имя кластера в поле **{{ ui-key.yacloud.mdb.forms.base_field_name }}**. Имя кластера должно быть уникальным в рамках каталога.
  1. Выберите окружение, в котором нужно создать кластер (после создания кластера окружение изменить невозможно):
     * `PRODUCTION` — для стабильных версий ваших приложений.
     * `PRESTABLE` — для тестирования, в том числе самого сервиса {{ mpg-name }}. В prestable-окружении раньше появляются новая функциональность, улучшения и исправления ошибок. При этом не все обновления обеспечивают обратную совместимость.
  1. Выберите версию СУБД.

     {% note info %}

     При выборе [класса хоста](../concepts/instance-types.md) в версии `12-1c` ({{ PG }} 12 для 1C) ориентируйтесь на количество пользователей вашей инсталляции «1С:Предприятия»:
     * Для одновременной работы 50 и более пользователей рекомендуется использовать класс `s2.medium`.
     * Для работы менее 50 пользователей достаточно класса `s2.small`.

     {% endnote %}

  1. Выберите класс хостов — он определяет технические характеристики [виртуальных машин](../../compute/concepts/vm.md), на которых будут развернуты хосты БД. Все доступные варианты перечислены в разделе [{#T}](../concepts/instance-types.md). При изменении класса хостов для кластера меняются характеристики всех уже созданных хостов.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_disk }}**:

     
     * Выберите тип диска.

       
       {% include [storages-step-settings](../../_includes/mdb/settings-storages.md) %}



     * Выберите размер хранилища, который будет использоваться для данных и резервных копий. Подробнее о том, как занимают пространство резервные копии, см. раздел [{#T}](../concepts/backup.md).
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_database }}** укажите атрибуты БД:
     * Имя БД. Это имя должно быть уникальным в рамках каталога.

       {% include [database-name-limit](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

     * Имя пользователя — владельца БД и пароль. По умолчанию новому пользователю выделяется 50 подключений к каждому хосту кластера.

       {% include [username-and-password-limits](../../_includes/mdb/mpg/note-info-user-name-and-pass-limits.md) %}

     * Локаль сортировки и локаль набора символов. Эти настройки определяют правила, по которым производится сортировка строк (`LC_COLLATE`) и классификация символов (`LC_CTYPE`). В {{ mpg-name }} настройки локали действуют на уровне отдельно взятой БД.

       {% include [postgresql-locale](../../_includes/mdb/mpg-locale-settings.md) %}

  
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network }}** выберите:
     * [Облачную сеть](../../vpc/concepts/network.md#network) для размещения кластера.

       {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}

     * [Группы безопасности](../../vpc/concepts/security-groups.md) для сетевого трафика кластера. Может потребоваться дополнительная [настройка групп безопасности](connect.md#configuring-security-groups) для того, чтобы можно было подключаться к кластеру.

       {% include [security-groups-note](../../_includes/vpc/security-groups-note-services.md) %}


  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_host }}** выберите параметры хостов БД, создаваемых вместе с кластером. По умолчанию каждый хост создается в отдельной подсети. Чтобы выбрать для хоста конкретную [подсеть](../../vpc/concepts/network.md#subnet), в строке этого хоста нажмите значок ![image](../../_assets/pencil.svg).

         
     При настройке параметров хостов обратите внимание, что если в блоке **{{ ui-key.yacloud.mdb.forms.section_disk }}** выбран `local-ssd` или `network-ssd-nonreplicated`, необходимо добавить не менее трех хостов в кластер.


  1. При необходимости задайте дополнительные настройки кластера:

     {% include [Additional cluster settings](../../_includes/mdb/mpg/extra-settings-web-console.md) %}

  1. При необходимости задайте [настройки СУБД уровня кластера](../concepts/settings-list.md#dbms-cluster-settings).
  
     {% note info %}

     Некоторые настройки {{ PG }} [зависят от выбранного класса хостов или от размера хранилища](../concepts/settings-list.md#settings-instance-dependent).

     {% endnote %}

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать кластер:

  
  1. Проверьте, есть ли в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) [подсети](../../vpc/concepts/network.md#subnet) для хостов кластера:

     ```bash
     yc vpc subnet list
     ```

     Если ни одной подсети в каталоге нет, [создайте нужные подсети](../../vpc/operations/subnet-create.md) в [сервисе {{ vpc-full-name }}](../../vpc/).


  1. Посмотрите описание команды CLI для создания кластера:

     ```bash
     {{ yc-mdb-pg }} cluster create --help
     ```

  1. Укажите параметры кластера в команде создания (в примере приведены не все доступные параметры):

     
     ```bash
     {{ yc-mdb-pg }} cluster create \
       --name <имя кластера> \
       --environment <окружение, prestable или production> \
       --network-name <имя сети> \
       --host zone-id=<зона доступности>,subnet-id=<идентификатор подсети> \
       --resource-preset <класс хоста> \
       --user name=<имя пользователя>,password=<пароль пользователя> \
       --database name=<имя БД>,owner=<имя владельца БД> \
       --disk-size <размер хранилища, ГБ> \
       --disk-type <тип диска> \
       --security-group-ids <список идентификаторов групп безопасности> \
       --connection-pooling-mode=<режим работы менеджера соединений> \
       --deletion-protection=<защита от удаления кластера: true или false>
     ```

     Идентификатор подсети `subnet-id` необходимо указывать, если в выбранной [зоне доступности](../../overview/concepts/geo-scope.md) создано две и больше подсетей.

     {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}


     Доступные [режимы работы менеджера соединений](../concepts/pooling.md): `SESSION`, `TRANSACTION` или `STATEMENT`.

     {% include [database-name-limit](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

     {% include [username-limit](../../_includes/mdb/mpg/note-info-password-limits.md) %}

     {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

     Также вы можете указать дополнительную опцию `replication-source` в параметре `--host` для того, чтобы [вручную управлять потоками репликации](../concepts/replication.md#replication-manual).

     
     
     Чтобы разрешить доступ к кластеру из сервиса [{{ sf-full-name }}](../../functions/), передайте параметр `--serverless-access`. Подробнее о настройке доступа см. в документации [{{ sf-name }}](../../functions/operations/database-connection.md).



     {% note info %}

     По умолчанию при создании кластера устанавливается режим [технического обслуживания](../concepts/maintenance.md) `anytime` — в любое время. Вы можете установить конкретное время обслуживания при [изменении настроек кластера](update.md#change-additional-settings).

     {% endnote %}

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  
  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


  Чтобы создать кластер:
  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:
     * Кластер БД — описание кластера и его хостов.
     * База данных — описание БД кластера.
     * Пользователь — описание пользователя кластера.

     * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

     * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

     {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}

     Пример структуры конфигурационного файла:

     
     
     ```hcl
     resource "yandex_mdb_postgresql_cluster" "<имя кластера>" {
       name                = "<имя кластера>"
       environment         = "<окружение, PRESTABLE или PRODUCTION>"
       network_id          = "<идентификатор сети>"
       security_group_ids  = [ "<список групп безопасности>" ]
       deletion_protection = <защита от удаления кластера: true или false>

       config {
         version = "<версия {{ PG }}: {{ pg.versions.tf.str }}>"
         resources {
           resource_preset_id = "<класс хоста>"
           disk_type_id       = "<тип диска>"
           disk_size          = <размер хранилища, ГБ>
         }
         pooler_config {
           pool_discard = <параметр Odyssey pool_discard: true или false>
           pooling_mode = "<режим работы: SESSION, TRANSACTION или STATEMENT>"
         }
         ...
       }

       host {
         zone      = "<зона доступности>"
         name      = "<имя хоста>"
         subnet_id = "<идентификатор подсети>"
       }
     }

     resource "yandex_mdb_postgresql_database" "<имя БД>" {
       cluster_id = "<идентификатор кластера>"
       name       = "<имя БД>"
       owner      = "<имя владельца БД>"
       depends_on = [
         yandex_mdb_postgresql_user.<имя пользователя>
       ]
     }

     resource "yandex_mdb_postgresql_user" "<имя пользователя>" {
       cluster_id = "<идентификатор кластера>"
       name       = "<имя пользователя>"
       password   = "<пароль пользователя>"
     }

     resource "yandex_vpc_network" "<имя сети>" { name = "<имя сети>" }

     resource "yandex_vpc_subnet" "<имя подсети>" {
       name           = "<имя подсети>"
       zone           = "<зона доступности>"
       network_id     = "<идентификатор сети>"
       v4_cidr_blocks = ["<диапазон>"]
     }
     ```




     {% include [database-name-limit](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

     {% include [username-limit](../../_includes/mdb/mpg/note-info-password-limits.md) %}

     {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

     {% include [Maintenance window](../../_includes/mdb/mpg/terraform/maintenance-window.md) %}

     {% include [Performance diagnostics](../../_includes/mdb/mpg/terraform/performance-diagnostics.md) %}

     Полный список доступных для изменения полей конфигурации кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).
  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Создайте кластер.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- API

  Чтобы создать кластер, воспользуйтесь методом REST API [create](../api-ref/Cluster/create.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Create](../api-ref/grpc/cluster_service.md#Create) и передайте в запросе:
  * Идентификатор [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором должен быть размещен кластер, в параметре `folderId`.
  * Имя кластера в параметре `name`.
  * Окружение кластера в параметре `environment`.
  * Идентификатор [сети](../../vpc/concepts/network.md#network) в параметре `networkId`.

    {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}

  * Конфигурацию кластера в параметре `configSpec`.
  * Конфигурацию хостов кластера в одном или нескольких параметрах `hostSpecs`.

  
  * Идентификаторы [групп безопасности](../concepts/network.md#security-groups) в параметре `securityGroupIds`.


  * Конфигурацию БД в одном или нескольких параметрах `databaseSpecs`.

    {% include [database-name-limit](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

  * Настройки пользователей в одном или нескольких параметрах `userSpecs`.

    {% include [username-limit](../../_includes/mdb/mpg/note-info-password-limits.md) %}

  {% include [datatransfer access](../../_includes/mdb/api/datatransfer-access-create.md) %}

  
  
  Чтобы разрешить доступ к кластеру из сервиса [{{ sf-full-name }}](../../functions/), передайте значение `true` для параметра `configSpec.access.serverless`. Подробнее о настройке доступа см. в документации [{{ sf-name }}](../../functions/operations/database-connection.md).



  Чтобы активировать [сбор статистики](performance-diagnostics.md#activate-stats-collector):

  {% include [Performance diagnostic API](../../_includes/mdb/mpg/performance-diagnostics-api.md) %}

{% endlist %}


{% note warning %}

Если вы указали идентификаторы групп безопасности при создании кластера, для подключения к нему может потребоваться дополнительная [настройка групп безопасности](connect.md#configuring-security-groups).

{% endnote %}


## Примеры {#examples}

### Создание кластера с одним хостом {#creating-a-single-host-cluster}

{% list tabs %}

- CLI

  Чтобы создать кластер с одним хостом, передайте один параметр `--host`.

  Создайте кластер {{ mpg-name }} с тестовыми характеристиками:

  
  * С именем `mypg`.
  * В окружении `production`.
  * В сети `default`.
  * В группе безопасности `{{ security-group }}`.
  * С одним хостом класса `{{ host-class }}` в подсети `b0rcctk2rvtr8efcch64`, в зоне доступности `{{ region-id }}-a`.
  * С хранилищем на сетевых SSD-дисках (`{{ disk-type-example }}`) размером 20 ГБ.
  * С одним пользователем (`user1`), с паролем `user1user1`.
  * С одной БД `db1`, принадлежащей пользователю `user1`.
  * С защитой от случайного удаления кластера.


  Выполните следующую команду:

  
  ```bash
  {{ yc-mdb-pg }} cluster create \
     --name mypg \
     --environment production \
     --network-name default \
     --resource-preset {{ host-class }} \
     --host zone-id={{ region-id }}-a,subnet-id=b0rcctk2rvtr8efcch64 \
     --disk-type {{ disk-type-example }} \
     --disk-size 20 \
     --user name=user1,password=user1user1 \
     --database name=db1,owner=user1 \
     --security-group-ids {{ security-group }} \
     --deletion-protection=true
  ```


- {{ TF }}

  Создайте кластер {{ mpg-name }} и сеть для него с тестовыми характеристиками:

  * С именем `mypg`.
  * Версии `{{ pg.versions.tf.latest }}`.
  * В окружении `PRESTABLE`.
  * В облаке с идентификатором `{{ tf-cloud-id }}`.
  * В каталоге с идентификатором `{{ tf-folder-id }}`.
  * В новой сети `mynet`.

  
  * В новой группе безопасности `pgsql-sg`, разрешающей подключение к кластеру из интернета через порт `6432`.


  * С одним хостом класса `{{ host-class }}` в новой подсети `mysubnet`, в зоне доступности `{{ region-id }}-a`. Подсеть `mysubnet` будет иметь диапазон `10.5.0.0/24`.
  * С хранилищем на сетевых SSD-дисках (`{{ disk-type-example }}`) размером 20 ГБ.
  * С одним пользователем (`user1`), с паролем `user1user1`.
  * С одной БД `db1`, принадлежащей пользователю `user1`.
  * С защитой от случайного удаления кластера.

  Конфигурационный файл для такого кластера выглядит так:

  
  
  ```hcl
  resource "yandex_mdb_postgresql_cluster" "mypg" {
    name                = "mypg"
    environment         = "PRESTABLE"
    network_id          = yandex_vpc_network.mynet.id
    security_group_ids  = [ yandex_vpc_security_group.pgsql-sg.id ]
    deletion_protection = true

    config {
      version = {{ pg.versions.tf.latest }}
      resources {
        resource_preset_id = "{{ host-class }}"
        disk_type_id       = "{{ disk-type-example }}"
        disk_size          = "20"
      }
    }

    host {
      zone      = "{{ region-id }}-a"
      name      = "mypg-host-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
    }
  }

  resource "yandex_mdb_postgresql_database" "db1" {
    cluster_id = yandex_mdb_postgresql_cluster.mypg.id
    name       = "db1"
    owner      = "user1"
  }

  resource "yandex_mdb_postgresql_user" "user1" {
    cluster_id = yandex_mdb_postgresql_cluster.mypg.id
    name       = "user1"
    password   = "user1user1"
  }

  resource "yandex_vpc_network" "mynet" {
    name = "mynet"
  }

  resource "yandex_vpc_subnet" "mysubnet" {
    name           = "mysubnet"
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.mynet.id
    v4_cidr_blocks = ["10.5.0.0/24"]
  }

  resource "yandex_vpc_security_group" "pgsql-sg" {
    name       = "pgsql-sg"
    network_id = yandex_vpc_network.mynet.id

    ingress {
      description    = "PostgreSQL"
      port           = 6432
      protocol       = "TCP"
      v4_cidr_blocks = [ "0.0.0.0/0" ]
    }
  }
  ```




{% endlist %}
