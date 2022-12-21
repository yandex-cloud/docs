# Создание {{ PG }}-кластера

{{ PG }}-кластер — это один или несколько хостов базы данных, между которыми можно настроить репликацию. Репликация работает по умолчанию в любом кластере из более чем 1 хоста: хост-мастер принимает запросы на запись и дублирует изменения в репликах. Транзакция подтверждается, если данные записаны на диск и на хосте-мастере, и на определенном числе реплик, достаточном [для формирования кворума](../concepts/replication.md).

{% note info %}

* Количество хостов, которые можно создать вместе с {{ PG }}-кластером, зависит от выбранного [типа диска](../concepts/storage.md#storage-type-selection) и [класса хостов](../concepts/instance-types.md#available-flavors).
* Доступные типы диска [зависят](../concepts/storage.md) от выбранного [класса хостов](../concepts/instance-types.md#available-flavors).
* Если хранилище баз данных заполнится на 95%, кластер перейдет в режим только чтения. Рассчитывайте и увеличивайте необходимый размер хранилища заранее.

{% endnote %}

По умолчанию {{ mpg-short-name }} выставляет максимально возможное количество подключений к каждому хосту {{ PG }}-кластера. Этот максимум не может быть больше значения настройки [Max connections](../concepts/settings-list.md#setting-max-connections).

{% include [note-pg-user-connections.md](../../_includes/mdb/note-pg-user-connections.md) %}

## Как создать кластер {{ PG }} {#create-cluster}

{% list tabs %}

- Консоль управления

  1. В консоли управления выберите каталог, в котором нужно создать кластер баз данных.
  1. Выберите сервис **{{ mpg-name }}**.
  1. Нажмите кнопку **Создать кластер**.
  1. Введите имя кластера в поле **Имя кластера**. Имя кластера должно быть уникальным в рамках каталога.
  1. Выберите окружение, в котором нужно создать кластер (после создания кластера окружение изменить невозможно):
      * `PRODUCTION` — для стабильных версий ваших приложений.
      * `PRESTABLE` — для тестирования, в том числе самого сервиса {{ mpg-short-name }}. В Prestable-окружении раньше появляются новая функциональность, улучшения и исправления ошибок. При этом не все обновления обеспечивают обратную совместимость.
  1. Выберите версию СУБД.

      {% note info %}

      При выборе класса хоста в версии `12-1c` ({{ PG }} 12 для 1C) ориентируйтесь на количество пользователей вашей инсталляции «1С:Предприятия»:
      * для одновременной работы 50 и более пользователей рекомендуется использовать класс `s2.medium`;
      * для работы менее 50 пользователей достаточно класса `s2.small`.

      {% endnote %}

  1. Выберите класс хостов — он определяет технические характеристики виртуальных машин, на которых будут развернуты хосты баз данных. Все доступные варианты перечислены в разделе [{#T}](../concepts/instance-types.md). При изменении класса хостов для кластера меняются характеристики всех уже созданных хостов.
  1. В блоке **Размер хранилища**:

      
      * Выберите [тип диска](../concepts/storage.md).

          {% include [storages-step-settings](../../_includes/mdb/settings-storages.md) %}


      * Выберите размер хранилища, который будет использоваться для данных и резервных копий. Подробнее о том, как занимают пространство резервные копии, см. раздел [{#T}](../concepts/backup.md).

  1. В блоке **База данных** укажите атрибуты базы данных:

      * Имя базы данных. Это имя должно быть уникальным в рамках каталога и содержать только латинские буквы, цифры и подчеркивания.
      * Имя пользователя — владельца базы данных и пароль. По умолчанию новому пользователю выделяется 50 подключений к каждому хосту кластера.

          {% include [username-and-password-limits](../../_includes/mdb/mpg/note-info-user-name-and-pass-limits.md) %}

      * Локаль сортировки и локаль набора символов. Эти настройки определяют правила, по которым производится сортировка строк (`LC_COLLATE`) и классификация символов (`LC_CTYPE`). В {{ mpg-name }} настройки локали действуют на уровне отдельно взятой базы данных.

           {% include [postgresql-locale](../../_includes/mdb/mpg-locale-settings.md) %}

  
  1. В блоке **Сетевые настройки** выберите облачную сеть для размещения кластера и группы безопасности для сетевого трафика кластера. Может потребоваться дополнительная [настройка групп безопасности](connect.md#configuring-security-groups) для того, чтобы можно было подключаться к кластеру.

        {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}


  1. В блоке **Хосты** выберите параметры хостов баз данных, создаваемых вместе с кластером. Открыв блок **Расширенные настройки**, вы можете выбрать конкретные подсети для каждого хоста — по умолчанию каждый хост создается в отдельной подсети.

      При настройке параметров хостов обратите внимание, что если в блоке **Хранилище** выбран `local-ssd` или `network-ssd-nonreplicated`, то необходимо добавить не менее трех хостов в кластер.

  1. При необходимости задайте дополнительные настройки кластера:

     {% include [Additional cluster settings](../../_includes/mdb/mpg/extra-settings-web-console.md) %}

  1. При необходимости задайте [настройки СУБД уровня кластера](../concepts/settings-list.md#dbms-cluster-settings).
  
     {% note info %}

     Некоторые настройки {{ PG }} [зависят от выбранного класса хостов или от размера хранилища](../concepts/settings-list.md#settings-instance-dependent).

     {% endnote %}

  1. Нажмите кнопку **Создать кластер**.

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
         --database name=<имя базы данных>,owner=<имя владельца базы данных> \
         --disk-size <размер хранилища, ГБ> \
         --disk-type <network-hdd | network-ssd | local-ssd | network-ssd-nonreplicated> \
         --security-group-ids <список идентификаторов групп безопасности> \
         --connection-pooling-mode=<режим работы менеджера соединений> \
         --deletion-protection=<защита от удаления кластера: true или false> \
         --serverless-access
      ```

      Идентификатор подсети `subnet-id` необходимо указывать, если в выбранной зоне доступности создано 2 и больше подсетей.

      {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}


      Доступные [режимы работы менеджера соединений](../concepts/pooling.md): `SESSION`, `TRANSACTION` или `STATEMENT`.

      {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

      Также вы можете указать несколько дополнительных опций в параметре `--host` для управления репликацией в кластере:
      * Источник репликации для хоста в опции `replication-source` для того, чтобы [вручную управлять потоками репликации](../concepts/replication.md#replication-manual).
      * Приоритет хоста в опции `priority` для того, чтобы [влиять на процесс выбора мастера](../concepts/replication.md#selecting-the-master):
        * Хост с наибольшим значением приоритета в кластере становится синхронной репликой.
        * Если в кластере есть несколько хостов с наибольшим приоритетом, то среди них проводятся выборы мастера.
        * Наименьший приоритет — `0` (по умолчанию), наивысший — `100`.

            
      Чтобы разрешить доступ к кластеру из сервиса [{{ sf-full-name }}](../../functions/concepts/index.md), передайте параметр `--serverless-access`. Подробнее о настройке доступа см. в документации [{{ sf-name }}](../../functions/operations/database-connection.md).


- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  
  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


  Чтобы создать кластер:

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     * Кластер базы данных — описание кластера и его хостов.

     * База данных — описание базы данных кластера.

     * Пользователь — описание пользователя кластера.

     * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

     * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

     {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}

     Пример структуры конфигурационного файла:

     
     
     ```hcl
     terraform {
       required_providers {
         yandex = {
           source = "yandex-cloud/yandex"
         }
       }
     }

     provider "yandex" {
       token     = "<OAuth или статический ключ сервисного аккаунта>"
       cloud_id  = "<идентификатор облака>"
       folder_id = "<идентификатор каталога>"
       zone      = "<зона доступности>"
     }

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

     resource "yandex_mdb_postgresql_database" "<имя базы данных>" {
       cluster_id = "<идентификатор кластера>"
       name       = "<имя базы данных>"
       owner      = "<имя владельца базы данных>"
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




     {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

     {% include [Maintenance window](../../_includes/mdb/mpg/terraform/maintenance-window.md) %}

     {% include [Performance diagnostics](../../_includes/mdb/mpg/terraform/performance-diagnostics.md) %}

     Полный список доступных для изменения полей конфигурации кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).

  2. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  3. Создайте кластер.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- API

  Воспользуйтесь методом API [create](../api-ref/Cluster/create.md) и передайте в запросе:

    * Идентификатор каталога, в котором должен быть размещен кластер, в параметре `folderId`.
    * Имя кластера в параметре `name`.
    * Окружение кластера в параметре `environment`.
    * Идентификатор сети в параметре `networkId`.

        {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}

    * Конфигурацию кластера в параметре `configSpec`.
    * Конфигурацию хостов кластера в одном или нескольких параметрах `hostSpecs`.
        * Идентификаторы [групп безопасности](../concepts/network.md#security-groups) в параметре `securityGroupIds`.
    * Конфигурацию баз данных в одном или нескольких параметрах `databaseSpecs`.
    * Настройки пользователей в одном или нескольких параметрах `userSpecs`.

  {% include [datatransfer access](../../_includes/mdb/api/datatransfer-access-create.md) %}

    
  Чтобы разрешить доступ к кластеру из сервиса [{{ sf-full-name }}](../../functions/concepts/index.md), передайте значение `true` для параметра `configSpec.access.serverless`. Подробнее о настройке доступа см. в документации [{{ sf-name }}](../../functions/operations/database-connection.md).


  Чтобы активировать [сбор статистики](./performance-diagnostics.md#activate-stats-collector):

  {% include [Performance diagnostic API](../../_includes/mdb/mpg/performance-diagnostics-api.md) %}

{% endlist %}


{% note warning %}

Если вы указали идентификаторы групп безопасности при создании кластера, то для подключения к нему может потребоваться дополнительная [настройка групп безопасности](connect.md#configuring-security-groups).

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
  * С одной базой данных `db1`, принадлежащей пользователю `user1`.
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
  * С одной базой данных `db1`, принадлежащей пользователю `user1`.
  * С защитой от случайного удаления кластера.

  Конфигурационный файл для такого кластера выглядит так:

  
  
  ```hcl
  terraform {
    required_providers {
      yandex = {
        source = "yandex-cloud/yandex"
      }
    }
  }

  provider "yandex" {
    token     = "<OAuth или статический ключ сервисного аккаунта>"
    cloud_id  = "{{ tf-cloud-id }}"
    folder_id = "{{ tf-folder-id }}"
    zone      = "{{ region-id }}-a"
  }

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
