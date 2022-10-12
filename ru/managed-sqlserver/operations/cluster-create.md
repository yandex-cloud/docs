# Создание кластера {{ MS }}

Кластер {{ MS }} — это один или несколько хостов базы данных. [Репликация](../concepts/replication.md) работает по умолчанию в любом кластере из более чем 1 хоста: первичная реплика принимает запросы на чтение и запись и синхронно дублирует изменения во вторичных репликах.

{% note info %}

* Количество хостов, которые можно создать вместе с кластером {{ MS }}, зависит от выбранного [типа диска](../concepts/storage.md#storage-type-selection) и [класса хостов](../concepts/instance-types.md#available-flavors).
* Доступные типы диска [зависят](../concepts/storage.md) от выбранного [класса хостов](../concepts/instance-types.md).

{% endnote %}

Если хранилище баз данных заполнится на 95%, кластер перейдет в режим только чтения. Рассчитывайте и увеличивайте необходимый размер хранилища заранее.

{% include [ms-licensing-personal-data](../../_includes/ms-licensing-personal-data.md) %}

## Как создать кластер {{ MS }} {#create-cluster}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mms-name }}**.
  1. Нажмите кнопку **Создать кластер**.
  1. Введите имя кластера в поле **Имя кластера**. Имя кластера должно быть уникальным в рамках каталога.
  1. Выберите окружение, в котором нужно создать кластер (после создания кластера окружение изменить невозможно):
      * `PRODUCTION` — для стабильных версий ваших приложений.
      * `PRESTABLE` — для тестирования, в том числе самого сервиса {{ mms-short-name }}. В Prestable-окружении раньше появляются новая функциональность, улучшения и исправления ошибок. При этом не все обновления обеспечивают обратную совместимость.
  1. Выберите версию СУБД. Для всех поддерживаемых версий доступны редакции:
     * Standard Edition.
     * Enterprise Edition.

     Подробнее см. в разделе [{#T}](../concepts/index.md).

  1. Выберите класс хостов — он определяет технические характеристики виртуальных машин, на которых будут развернуты хосты баз данных. Все доступные варианты перечислены в разделе [{#T}](../concepts/instance-types.md). При изменении класса хостов для кластера меняются характеристики всех уже созданных хостов.
  1. В блоке **Размер хранилища**:

      
      * Выберите [тип диска](../concepts/storage.md).

        {% include [storages-step-settings](../../_includes/mdb/settings-storages.md) %}


      * Выберите объем, который будет использоваться для данных и резервных копий. Подробнее о том, как занимают пространство резервные копии, см. раздел [{#T}](../concepts/backup.md).
  1. В блоке **База данных** укажите атрибуты базы данных:

      * Имя базы данных. Это имя должно быть уникальным в рамках каталога и содержать только латинские буквы, цифры и подчеркивания.
      * Имя пользователя — владельца базы данных. Это имя должно содержать только латинские буквы, цифры и подчеркивания. По умолчанию новому пользователю выделяется 50 подключений к каждому хосту кластера.
      * Пароль пользователя, от 8 до 128 символов.

  1. В блоке **Сетевые настройки** выберите облачную сеть для размещения кластера и группы безопасности для сетевого трафика кластера. Может потребоваться дополнительная [настройка групп безопасности](connect.md#configuring-security-groups) для того, чтобы можно было подключаться к кластеру.

  1. В блоке **Хосты**:

      1. Выберите параметры хостов баз данных, создаваемых вместе с кластером. По умолчанию каждый хост создается в отдельной подсети. Чтобы выбрать конкретную подсеть для хоста, нажмите на значок ![image](../../_assets/pencil.svg) в строке этого хоста и выберите необходимые зону доступности и подсеть.

          Доступное для добавления количество хостов зависит от [редакции](../concepts/index.md) SQL Server:

          * В редакции **Standard Edition** вы можете создать кластер из одного или двух хостов:

              * Кластер из одного хоста не обеспечивает отказоустойчивости.
              * Кластер из двух хостов отказоустойчивый. Для него автоматически создается дополнительный третий witness-хост с минимально необходимыми ресурсами и лицензией Windows Standard, что учитывается при расчете стоимости.

          * В редакции **Enterprise Edition** вы можете создать кластер из одного и более хостов:

              * Кластер из одного хоста не обеспечивает отказоустойчивости.
              * Кластер из двух и более хостов отказоустойчивый. Для кластера из двух хостов автоматически создается дополнительный третий witness-хост с минимально необходимыми ресурсами и лицензией Windows Standard, что учитывается при расчете стоимости.
              * Если в блоке **Хранилище** выбран `local-ssd` или `network-ssd-nonreplicated`, то добавьте не менее трех хостов в кластер.

      
      1. (Опционально) Выберите группы [выделенных хостов](../../compute/concepts/dedicated-host.md), на которых будет размещен кластер.

          {% include [Dedicated hosts note](../../_includes/mdb/mms/note-dedicated-hosts.md) %}


  1. При необходимости задайте дополнительные настройки кластера:

      {% include [extra-settings-create](../../_includes/mdb/mms/extra-settings-create.md) %}

  1. При необходимости задайте [настройки СУБД](../concepts/settings-list.md).
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
        {{ yc-mdb-ms }} cluster create --help
        ```

    1. Укажите параметры кластера в команде создания (в примере приведены не все доступные параметры):

        
        ```bash
        {{ yc-mdb-ms }} cluster create <имя кластера> \
           --sqlserver-version=<версия {{ MS }}: {{ versions.cli.str }}> \
           --environment=<окружение: PRESTABLE или PRODUCTION> \
           --host zone-id=<зона доступности>,`
                 `subnet-id=<идентификатор подсети>,`
                 `assign-public-ip=<доступ к хосту через публичный IP-адрес: true или false> \
           --network-name=<имя сети> \
           --user name=<имя пользователя>,`
                 `password=<пароль пользователя> \
           --database name=<имя базы данных> \
           --resource-preset=<класс хоста> \
           --disk-size=<объем хранилища, ГБ> \
           --disk-type=<тип диска> \
           --security-group-ids=<список идентификаторов групп безопасности> \
           --deletion-protection=<защита от удаления кластера: true или false>
        ```

        {% note info %}

        Имя кластера должно быть уникальным в каталоге. Может содержать латинские буквы, цифры, дефис и нижнее подчеркивание. Максимальная длина имени 63 символа.

        {% endnote %}

        Где:

        * `--sqlserver-version` — версия {{ MS }}.
        * `--environment` — окружение:
            * `PRODUCTION` — для стабильных версий ваших приложений.
            * `PRESTABLE` — для тестирования, в том числе самого сервиса {{ MS }}. В Prestable-окружении раньше появляются новая функциональность, улучшения и исправления ошибок. При этом не все обновления обеспечивают обратную совместимость.
        * `--host` — параметры хоста:
            * `zone-id` — [зона доступности](../../overview/concepts/geo-scope.md).
            * `subnet-id` — [идентификатор подсети](../../vpc/concepts/network.md#subnet). Необходимо указывать, если в выбранной зоне доступности создано 2 и больше подсетей.
            * `assign-public-ip` — флаг, который указывается, если хосту требуется [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses).
        * `--network-name` — [имя сети](../../vpc/concepts/network.md#network).
        * `--user` — параметры пользователя:
            * `name` — имя. Может содержать латинские буквы, цифры, дефис и нижнее подчеркивание, но должно начинаться с буквы, цифры или нижнего подчеркивания. Длина от 1 до 32 символов.
            * `password` — пароль. Длина от 8 до 128 символов.
        * `--database name` — имя базы данных. Может содержать латинские буквы, цифры, дефис и нижнее подчеркивание. Максимальная длина имени 63 символа.
        * `--resource-preset` — [класс хоста](../concepts/instance-types.md#available-flavors).
        * `--disk-size` — объем хранилища в гигабайтах.
        * `--disk-type` — [тип диска](../concepts/storage.md):
            * `network-hdd`;
            * `network-ssd`;
            * `local-ssd`;
            * `network-ssd-nonreplicated`.
        * `--security-group-ids` — список идентификаторов [групп безопасности](../../vpc/concepts/security-groups.md).
        * `--deletion-protection` — защита от удаления кластера.


            {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

    1. Чтобы задать время начала резервного копирования, передайте нужное значение в формате `HH:MM:SS` в параметре `--backup-window-start`:

        ```bash
        {{ yc-mdb-ms }} cluster create <имя кластера> \
           ...
           --backup-window-start=<время начала резервного копирования>
        ```

    
    1. Чтобы создать кластер, размещенный на группах [выделенных хостов](../../compute/concepts/dedicated-host.md), укажите через запятую их идентификаторы в параметре `--host-group-ids`:

        ```bash
        {{ yc-mdb-ms }} cluster create <имя кластера> \
           ...
           --host-group-ids=<идентификаторы групп выделенных хостов>
        ```

        {% include [Dedicated hosts note](../../_includes/mdb/mms/note-dedicated-hosts.md) %}

    1. Чтобы привязать к кластеру [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) для настройки взаимодействия с другими ресурсами {{ yandex-cloud }}, передайте его [идентификатор](../../iam/operations/sa/get-id.md) в параметре `--service-account-id`:

        ```bash
        {{ yc-mdb-ms }} cluster create <имя кластера> \
           ...
           --service-account-id=<идентификатор сервисного аккаунта>
        ```
       

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
        resource "yandex_mdb_sqlserver_cluster" "<имя кластера>" {
          name                = "<имя кластера>"
          environment         = "<окружение: PRESTABLE или PRODUCTION>"
          network_id          = "<идентификатор сети>"
          version             = "<версия {{ MS }}: {{ versions.tf.str }}>"
          security_groups_id  = ["<список идентификаторов групп безопасности>"]
          deletion_protection = <защита от удаления кластера: true или false>

          resources {
            resource_preset_id = "<класс хоста>"
            disk_type_id       = "<тип диска>"
            disk_size          = <размер хранилища в гигабайтах>
          }

          host {
            zone      = "<зона доступности>"
            subnet_id = "<идентификатор подсети>"
          }

          database = {
            name = "<имя базы>"
          }

          user {
            name     = "<имя пользователя>"
            password = "<пароль>"

            permission {
              database_name = "<имя базы>"
              roles         = ["<список ролей>"]
            }
          }

          backup_window_start {
            hours   = <Час начала резервного копирования>
            minutes = <Минута начала резервного копирования>
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

        {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

               
        1. Чтобы создать кластер, размещенный на группах [выделенных хостов](../../compute/concepts/dedicated-host.md), добавьте к описанию кластера поле `host_group_ids` и укажите в нем через запятую идентификаторы нужных групп:

            ```hcl
            resource "yandex_mdb_sqlserver_cluster" "<имя кластера>" {
              ...
              host_group_ids = [ "<идентификатор 1>", "<идентификатор 2>", ... ]
              ...
            }
            ```

            {% include [Dedicated hosts note](../../_includes/mdb/mms/note-dedicated-hosts.md) %}
 

        Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-mms }}).

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Создайте кластер.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        После этого в указанном каталоге будут созданы все требуемые ресурсы, а в терминале отобразятся IP-адреса виртуальных машин. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

        {% include [Terraform timeouts](../../_includes/mdb/mms/terraform/timeouts.md) %}

- API

  Воспользуйтесь методом API [create](../api-ref/Cluster/create.md) и передайте в запросе:
  * Идентификатор каталога, в котором должен быть размещен кластер, в параметре `folderId`.
  * Имя кластера в параметре `name`.
  * Конфигурацию кластера в параметре `configSpec`.
  * Конфигурацию хостов кластера в одном или нескольких параметрах `hostSpecs`.
  * Конфигурацию баз данных кластера в одном или нескольких параметрах `databaseSpecs`.
  * Конфигурацию учетных записей баз данных кластера в одном или нескольких параметрах `userSpecs`.
  * Идентификатор сети в параметре `networkId`.
  * Имя параметров сортировки баз данных кластера в параметре `sqlcollation`.
  * Настройки защиты от удаления кластера в параметре `deletionProtection`.

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

  
  Чтобы создать кластер, размещенный на группах [выделенных хостов](../../compute/concepts/dedicated-host.md), передайте список их идентификаторов в параметре `hostGroupIds`.

  {% include [Dedicated hosts note](../../_includes/mdb/mms/note-dedicated-hosts.md) %}

  Чтобы привязать к кластеру [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), передайте его [идентификатор](../../iam/operations/sa/get-id.md) в параметре `serviceAccountId`.


{% endlist %}

{% note warning %}

Если вы указали идентификаторы групп безопасности при создании кластера, то для подключения к нему может потребоваться дополнительная [настройка групп безопасности](./connect.md#configuring-security-groups).

{% endnote %}

## Примеры {#examples}

### Создание кластера с одним хостом

{% list tabs %}

- CLI

    Чтобы создать кластер с одним хостом, передайте один параметр `--host`.

    Создайте кластер {{ mms-name }} с тестовыми характеристиками:

    
    * С именем `mssql-1`.
    * Версии `{{ versions.cli.latest.long-std }}`.
    * В окружении `PRODUCTION`.
    * В сети `default`.
    * В группе безопасности `{{ security-group }}`.
    * С одним хостом класса `s2.small` в подсети `b0cd5bv7pfpr7r900tkp`, в зоне доступности `{{ region-id }}-a`.
    * С хранилищем на сетевых SSD-дисках (`{{ disk-type-example }}`) объемом 20 ГБ.
    * С одним пользователем (`user1`), с паролем `user1user1`.
    * С одной базой данных `db1`.
    * С защитой от случайного удаления кластера.


    Выполните следующую команду:

    
    ```bash
    {{ yc-mdb-ms }} cluster create \
       --name=mssql-1 \
       --sqlserver-version={{ versions.cli.latest.std }} \
       --environment=PRODUCTION \
       --network-name=default \
       --resource-preset=s2.small \
       --host zone-id={{ region-id }}-a,`
             `subnet-id=b0cd5bv7pfpr7r900tkp \
       --disk-type={{ disk-type-example }} \
       --disk-size=20 \
       --user name=user1,`
             `password=user1user1 \
       --database name=db1 \
       --security-group-ids={{ security-group }} \
       --deletion-protection=true
    ```


- {{ TF }}

    Создайте кластер {{ mms-name }} и сеть для него с тестовыми характеристиками:

    * С именем `mssql-1`.
    * В окружении `PRODUCTION`.
    * С версией {{ MS }} `{{ versions.tf.latest.long-std }}`.
    * В облаке с идентификатором `{{ tf-cloud-id }}`.
    * В каталоге с идентификатором `{{ tf-folder-id }}`.
    * В новой сети `mynet`.
    * В новой группе безопасности `ms-sql-sg`, разрешающей подключение к кластеру из интернета через порт `{{ port-mms }}`.
    * С одним хостом класса `s2.small` в новой подсети `mysubnet`, в зоне доступности `{{ region-id }}-a`. Подсеть `mysubnet` будет иметь диапазон `10.5.0.0/24`.
    * С хранилищем на сетевых SSD-дисках объемом 32 Гб.
    * С базой данных `db1`.
    * С пользователем `user1` и паролем `user1user1`. Этот пользователь будет владельцем базы `db1` ([предопределенная роль `DB_OWNER`](./grant.md#predefined-db-roles)).
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

    resource "yandex_mdb_sqlserver_cluster" "mssql-1" {
      name                = "mssql-1"
      environment         = "PRODUCTION"
      version             = "{{ versions.tf.latest.std }}"
      network_id          = yandex_vpc_network.mynet.id
      security_group_ids  = [yandex_vpc_security_group.ms-sql-sg.id]
      deletion_protection = true

      resources {
        resource_preset_id = "s2.small"
        disk_type_id       = "network-ssd"
        disk_size          = 32
      }

      host {
        zone             = "{{ region-id }}-a"
        subnet_id        = yandex_vpc_subnet.mysubnet.id
        assign_public_ip = true
      }

      database {
        name = "db1"
      }

      user {
        name     = "user1"
        password = "user1user1"
        permission {
          database_name = "db1"
          roles         = ["OWNER"]
        }
      }
    }

    resource "yandex_vpc_network" "mynet" { name = "mynet" }

    resource "yandex_vpc_subnet" "mysubnet" {
      name           = "mysubnet"
      zone           = "{{ region-id }}-a"
      network_id     = yandex_vpc_network.mynet.id
      v4_cidr_blocks = ["10.5.0.0/24"]
    }

    resource "yandex_vpc_security_group" "ms-sql-sg" {
      name       = "ms-sql-sg"
      network_id = yandex_vpc_network.mynet.id

      ingress {
        description    = "Public access to SQL Server"
        port           = {{ port-mms }}
        protocol       = "TCP"
        v4_cidr_blocks = ["0.0.0.0/0"]
      }
    }
    ```



{% endlist %}
