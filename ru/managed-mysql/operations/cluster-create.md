# Создание {{ MY }}-кластера

{{ MY }}-кластер — это один или несколько хостов базы данных. В кластерах из более чем одного хоста автоматически настраивается [полусинхронная репликация](../concepts/replication.md).

Подробнее об устройстве кластера {{ mmy-name }} см. в разделе [{#T}](../concepts/index.md).

{% note info %}

Количество хостов, которые можно создать вместе с {{ MY }}-кластером, зависит от выбранного [типа хранилища](../concepts/storage.md#storage-type-selection).

{% endnote %}

## Как создать кластер {{ MY }} {#create-cluster}

{% list tabs %}

- Консоль управления

  1. В консоли управления выберите каталог, в котором нужно создать кластер БД.
  1. Выберите сервис **{{ mmy-name }}**.
  1. Нажмите кнопку **Создать кластер**.
  1. Введите имя кластера в поле **Имя кластера**. Имя кластера должно быть уникальным в рамках каталога.
  1. Выберите окружение, в котором нужно создать кластер (после создания кластера окружение изменить невозможно):
      * `PRODUCTION` — для стабильных версий ваших приложений.
      * `PRESTABLE` — для тестирования, в том числе самого сервиса {{ mmy-short-name }}. В Prestable-окружении раньше появляются новая функциональность, улучшения и исправления ошибок. При этом не все обновления обеспечивают обратную совместимость.
  1. Выберите версию СУБД.
  1. Выберите класс хостов — он определяет технические характеристики виртуальных машин, на которых будут развернуты хосты БД. Все доступные варианты перечислены в разделе [{#T}](../concepts/instance-types.md). При изменении класса хостов для кластера меняются характеристики всех уже созданных хостов.
  1. В блоке **Размер хранилища**:
      * Выберите [тип хранилища](../concepts/storage.md) — более гибкое сетевое (`network-hdd`, `network-ssd` или `network-ssd-nonreplicated`) или более быстрое локальное хранилище (`local-ssd`).

        {% include [storages-step-settings](../../_includes/mdb/settings-storages.md) %}

      * Выберите объем, который будет использоваться для данных и резервных копий. Подробнее о том, как занимают пространство резервные копии, см. раздел [{#T}](../concepts/backup.md).

          {% note info %}

          Если хранилище баз данных заполнится на 95%, кластер перейдет в режим <q>только чтение</q>. Увеличивайте размер хранилища заранее.

          {% endnote %}

  1. В блоке **База данных** укажите атрибуты БД:

      * Имя базы данных. Имя БД должно быть уникальным в рамках каталога и содержать только латинские буквы, цифры и подчеркивания.
      * Имя пользователя — владельца БД. Имя пользователя должно содержать только латинские буквы, цифры и подчеркивания.
      * Пароль пользователя, от 8 до 128 символов.

  1. В блоке **Сетевые настройки** выберите облачную сеть для размещения кластера и группы безопасности для сетевого трафика кластера. Может потребоваться дополнительная [настройка групп безопасности](connect.md#configure-security-groups) для того, чтобы можно было подключаться к кластеру.

  1. В блоке **Хосты** выберите параметры хостов БД, создаваемых вместе с кластером. Открыв блок **Расширенные настройки**, вы можете выбрать конкретные подсети для каждого хоста — по умолчанию каждый хост создается в отдельной подсети.

      При настройке параметров хостов обратите внимание, что если в блоке **Хранилище** выбран `local-ssd` или `network-ssd-nonreplicated`, то необходимо добавить не менее трех хостов в кластер. После создания кластера в него можно добавить дополнительные хосты, если для этого достаточно [ресурсов каталога](../concepts/limits.md).

  1. При необходимости задайте дополнительные настройки кластера:

      {% include [mmy-extra-settings](../../_includes/mdb/mmy-extra-settings-web-console.md) %}

  1. При необходимости задайте [настройки СУБД уровня кластера](../concepts/settings-list.md#dbms-cluster-settings).

      {% include [mmy-settings-dependence](../../_includes/mdb/mmy/note-info-settings-dependence.md) %}

  1. Нажмите кнопку **Создать кластер**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать кластер:

  1. Проверьте, есть ли в каталоге подсети для хостов кластера:

     ```
     $ yc vpc subnet list
     ```
     {% if audience != "internal" %}

     Если ни одной подсети в каталоге нет, [создайте нужные подсети](../../vpc/operations/subnet-create.md) в сервисе {{ vpc-short-name }}.

     {% else %}
     
     Если ни одной подсети в каталоге нет, создайте нужные подсети в сервисе {{ vpc-short-name }}.

     {% endif %}


  1. Посмотрите описание команды CLI для создания кластера:

      ```
      $ {{ yc-mdb-my }} cluster create --help
      ```

  1. Укажите параметры кластера в команде создания:

     ```bash
     {{ yc-mdb-my }} cluster create \
        --name=<имя кластера> \
        --environment <окружение, prestable или production> \
        --network-name <имя сети> \
        --host zone-id=<зона доступности>,subnet-id=<идентификатор подсети> \
        --mysql-version <версия MySQL> \
        --resource-preset <класс хоста> \
        --user name=<имя пользователя>,password=<пароль пользователя> \
        --database name=<имя базы данных> \
        --disk-size <размер хранилища в гигабайтах> \
        --disk-type <network-hdd | network-ssd | local-ssd | network-ssd-nonreplicated> \
        --security-group-ids <список идентификаторов групп безопасности> \
        --deletion-protection=<защита от удаления кластера: true или fasle>
     ```

      Идентификатор подсети `subnet-id` необходимо указывать, если в выбранной зоне доступности создано 2 и больше подсетей.

      {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-db.md) %}

      При необходимости задайте [настройки СУБД](../concepts/settings-list.md#dbms-cluster-settings).

- Terraform

  {% include [terraform-definition](../../_includes/solutions/terraform-definition.md) %}
  {% if audience != "internal" %}

  Если у вас еще нет Terraform, [установите его и настройте провайдер](../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  {% else %}

  Если у вас еще нет Terraform, установите его и настройте провайдер.

  {% endif %}
  Чтобы создать кластер:

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     {% include [terraform-create-cluster-step-1](../../_includes/mdb/terraform-create-cluster-step-1.md) %}

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

     resource "yandex_mdb_mysql_cluster" "<имя кластера>" {
       name                = "<имя кластера>"
       environment         = "<окружение, PRESTABLE или PRODUCTION>"
       network_id          = "<идентификатор сети>"
       version             = "<версия MySQL: 5.7 или 8.0>"
       security_group_ids  = [ "<список групп безопасности>" ]
       deletion_protection = <защита от удаления кластера: true или false>

       resources {
         resource_preset_id = "<класс хоста>"
         disk_type_id       = "<тип хранилища>"
         disk_size          = "<размер хранилища в гигабайтах>"
       }

       database {
         name = "<имя базы данных>"
       }

       user {
         name     = "<имя пользователя>"
         password = "<пароль пользователя>"
         permission {
           database_name = "<имя базы данных>"
           roles         = ["ALL"]
         }
       }

       host {
         zone      = "<зона доступности>"
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

     {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-db.md) %}

     Более подробную информацию о ресурсах, которые вы можете создать с помощью Terraform, см. в [документации провайдера](https://www.terraform.io/docs/providers/yandex/r/mdb_mysql_cluster.html).

  1. Проверьте корректность конфигурационных файлов.

     {% include [terraform-create-cluster-step-2](../../_includes/mdb/terraform-create-cluster-step-2.md) %}

  1. Создайте кластер.

     {% include [terraform-create-cluster-step-3](../../_includes/mdb/terraform-create-cluster-step-3.md) %}

- API

    Воспользуйтесь методом API [create](../api-ref/Cluster/create.md) и передайте в запросе:

    * Идентификатор каталога, в котором должен быть размещен кластер, в параметре `folderId`.
    * Имя кластера в параметре `name`. Имя кластера должно быть уникальным в рамках каталога.
    * Окружение кластера в параметре `environment`.
    * Конфигурацию кластера в параметре `configSpec`.
    * Конфигурацию баз данных в одном или нескольких параметрах `databaseSpecs`.
    * Настройки пользователей в одном или нескольких параметрах `userSpecs`.
    * Конфигурацию хостов кластера в одном или нескольких параметрах `hostSpecs`.
    * Идентификатор сети в параметре `networkId`.
    * Идентификаторы [групп безопасности](../concepts/network.md#security-groups) в параметре `securityGroupIds`.

{% endlist %}

{% note warning %}

Если вы указали идентификаторы групп безопасности при создании кластера, то для подключения к нему может потребоваться дополнительная [настройка групп безопасности](connect.md#configure-security-groups).

{% endnote %}

## Примеры {#examples}

### Создание кластера с одним хостом {#creating-a-single-host-cluster}

{% list tabs %}

- CLI

  Чтобы создать кластер с одним хостом, передайте один параметр `--host`.

  Допустим, нужно создать {{ MY }}-кластер со следующими характеристиками:

    {% if audience != "internal" %}

    * С именем `my-mysql`.
    * Версии `8.0`.
    * В окружении `production`.
    * В сети `default`.
    * В группе безопасности с идентификатором `{{ security-group }}`.
    * С одним хостом класса `{{ host-class }}` в подсети `{{ subnet-id }}`, в зоне доступности `{{ zone-id }}`.
    * С быстрым сетевым хранилищем (`{{ disk-type-example }}`) объемом 20 Гб.
    * С одним пользователем (`user1`), с паролем `user1user1`.
    * С одной базой данных `db1`, в которой пользователь `user1` имеет полные права (эквивалент `GRANT ALL PRIVILEGES on db1.*`).
    * С защитой от случайного удаления кластера.

    {% else %}

    * С именем `my-mysql`.
    * Версии `8.0`.
    * В окружении `production`.
    * С одним хостом класса `{{ host-class }}` в зоне доступности `man`.
    * С быстрым локальным хранилищем (`local-ssd`) объемом 20 Гб.
    * С одним пользователем (`user1`), с паролем `user1user1`.
    * С одной базой данных `db1`, в которой пользователь `user1` имеет полные права (эквивалент `GRANT ALL PRIVILEGES on db1.*`).
    * С защитой от случайного удаления кластера.

    {% endif %}

  1. Запустите команду создания кластера:

      {% if audience != "internal" %}

      ```bash
      {{ yc-mdb-my }} cluster create \
         --name="my-mysql" \
         --mysql-version 8.0 \
         --environment=production \
         --network-name=default \
         --security-group-ids {{ security-group }} \
         --host zone-id={{ host-net-example }} \
         --resource-preset {{ host-class }} \
         --disk-type {{ disk-type-example }} \
         --disk-size 20 \
         --user name=user1,password="user1user1" \
         --database name=db1 \
         --deletion-protection=true
      ```

      {% else %}

      ```bash
      {{ yc-mdb-my }} cluster create \
         --name="my-mysql" \
         --mysql-version 8.0 \
         --environment=production \
         --network-id=' ' \
         --host zone-id=man \
         --resource-preset {{ host-class }} \
         --disk-type local-ssd \
         --disk-size 20 \
         --user name=user1,password="user1user1" \
         --database name=db1 \
         --deletion-protection=true
      ```

      {% endif %}

  1. Запустите команду изменения привилегий пользователя `user1`.

      ```bash
      {{ yc-mdb-my }} user grant-permission user1 \
         --cluster-name="my-mysql" \
         --database=db1 \
         --permissions ALL
      ```

- Terraform

  Допустим, нужно создать {{ MY }}-кластер и сеть для него со следующими характеристиками:

    * С именем `my-mysql`.
    * Версии `8.0`.
    * В окружении `PRESTABLE`.
    * В облаке с идентификатором `{{ tf-cloud-id }}`.
    * В каталоге с идентификатором `{{ tf-folder-id }}`.
    * В новой сети `mynet`.
    * С одним хостом класса `{{ host-class }}` в новой подсети `mysubnet`, в зоне доступности `{{ zone-id }}`. Подсеть `mysubnet` будет иметь диапазон `10.5.0.0/24`.
    * В новой группе безопасности `mysql-sg`, разрешающей подключение к кластеру из интернета через порт `{{ port-mmy }}`.
    * С быстрым сетевым хранилищем (`{{ disk-type-example }}`) объемом 20 ГБ.
    * С одним пользователем (`user1`), с паролем `user1user1`.
    * С одной базой данных `db1`, в которой пользователь `user1` имеет полные права (эквивалент `GRANT ALL PRIVILEGES on db1.*`).
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
    zone      = "{{ zone-id }}"
  }

  resource "yandex_mdb_mysql_cluster" "my-mysql" {
    name                = "my-mysql"
    environment         = "PRESTABLE"
    network_id          = yandex_vpc_network.mynet.id
    version             = "8.0"
    security_group_ids  = [ yandex_vpc_security_group.mysql-sg.id ]
    deletion_protection = true

    resources {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 20
    }

    database {
      name = "db1"
    }

    user {
      name     = "user1"
      password = "user1user1"
      permission {
        database_name = "db1"
        roles         = ["ALL"]
      }
    }

    host {
      zone      = "{{ zone-id }}"
      subnet_id = yandex_vpc_subnet.mysubnet.id
    }
  }

  resource "yandex_vpc_network" "mynet" {
    name = "mynet"
  }

  resource "yandex_vpc_security_group" "mysql-sg" {
    name       = "mysql-sg"
    network_id = yandex_vpc_network.mynet.id

    ingress {
      description    = "MySQL"
      port           = {{ port-mmy }}
      protocol       = "TCP"
      v4_cidr_blocks = [ "0.0.0.0/0" ]
    }
  }

  resource "yandex_vpc_subnet" "mysubnet" {
    name           = "mysubnet"
    zone           = "{{ zone-id }}"
    network_id     = yandex_vpc_network.mynet.id
    v4_cidr_blocks = ["10.5.0.0/24"]
  }
  ```

{% endlist %}
