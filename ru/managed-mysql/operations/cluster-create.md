# Создание {{ MY }}-кластера

{{ MY }}-кластер — это один или несколько хостов базы данных. В кластерах из более чем одного хоста автоматически настраивается [полусинхронная репликация](../concepts/replication.md).

Подробнее об устройстве кластера {{ mmy-name }} см. в разделе [{#T}](../concepts/index.md).

{% note info %}

* Количество хостов, которые можно создать вместе с {{ MY }}-кластером, зависит от выбранного {% if audience != "internal" %}[типа хранилища](../concepts/storage.md#storage-type-selection){% else %}[типа хранилища](../concepts/storage.md){% endif %} и [класса хостов](../concepts/instance-types.md#available-flavors).
* Доступные типы хранилища [зависят](../concepts/storage.md) от выбранного [класса хостов](../concepts/instance-types.md#available-flavors).

{% endnote %}

## Как создать кластер {{ MY }} {#create-cluster}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер БД.
  1. Выберите сервис **{{ mmy-name }}**.
  1. Нажмите кнопку **Создать кластер**.
  1. Введите имя кластера в поле **Имя кластера**. Имя кластера должно быть уникальным в рамках каталога.
  1. Выберите окружение, в котором нужно создать кластер (после создания кластера окружение изменить невозможно):
      * `PRODUCTION` — для стабильных версий ваших приложений.
      * `PRESTABLE` — для тестирования, в том числе самого сервиса {{ mmy-short-name }}. В Prestable-окружении раньше появляются новая функциональность, улучшения и исправления ошибок. При этом не все обновления обеспечивают обратную совместимость.
  1. Выберите версию СУБД.
  1. Выберите класс хостов — он определяет технические характеристики виртуальных машин, на которых будут развернуты хосты БД. Все доступные варианты перечислены в разделе [{#T}](../concepts/instance-types.md). При изменении класса хостов для кластера меняются характеристики всех уже созданных хостов.
  1. В блоке **Размер хранилища**:

      * Выберите [тип хранилища](../concepts/storage.md).

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

      Если в блоке **Размер хранилища** выбран `local-ssd`{% if audience != "internal" %} или `network-ssd-nonreplicated`{% endif %}, то необходимо добавить не менее трех хостов в кластер. После создания кластера в него можно добавить дополнительные хосты, если для этого достаточно [ресурсов каталога](../concepts/limits.md).

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
     yc vpc subnet list
     ```
     {% if audience != "internal" %}

     Если ни одной подсети в каталоге нет, [создайте нужные подсети](../../vpc/operations/subnet-create.md) в сервисе {{ vpc-short-name }}.

     {% else %}
     
     Если ни одной подсети в каталоге нет, создайте нужные подсети в сервисе {{ vpc-short-name }}.

     {% endif %}


  1. Посмотрите описание команды CLI для создания кластера:

      ```
      {{ yc-mdb-my }} cluster create --help
      ```

  1. Укажите параметры кластера в команде создания:

     {% if audience != "internal" %}

     ```bash
     {{ yc-mdb-my }} cluster create \
       --name=<имя кластера> \
       --environment <окружение, prestable или production> \
       --network-name <имя сети> \
       --host zone-id=<зона доступности>,subnet-id=<идентификатор подсети> \
       --mysql-version <версия {{ MY }}: {{ versions.cli.str }}> \
       --resource-preset <класс хоста> \
       --user name=<имя пользователя>,password=<пароль пользователя> \
       --database name=<имя базы данных> \
       --disk-size <размер хранилища в гигабайтах> \
       --disk-type <network-hdd | network-ssd | local-ssd | network-ssd-nonreplicated> \
       --security-group-ids <список идентификаторов групп безопасности> \
       --deletion-protection=<защита от удаления кластера: true или fasle>
     ```

      Идентификатор подсети `subnet-id` необходимо указывать, если в выбранной зоне доступности создано 2 и больше подсетей.

     {% else %}

     ```bash
     {{ yc-mdb-my }} cluster create \
       --name=<имя кластера> \
       --environment <окружение, prestable или production> \
       --network-id ' ' \
       --host zone-id=<зона доступности> \
       --mysql-version <версия MySQL> \
       --resource-preset <класс хоста> \
       --user name=<имя пользователя>,password=<пароль пользователя> \
       --database name=<имя базы данных> \
       --disk-size <размер хранилища в гигабайтах> \
       --disk-type <local-ssd | local-hdd> \
       --security-group-ids <список идентификаторов групп безопасности> \
       --deletion-protection=<защита от удаления кластера: true или fasle>
     ```

     {% endif %}

      {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-db.md) %}

      При необходимости задайте [настройки СУБД](../concepts/settings-list.md#dbms-cluster-settings).

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}
  
  {% if audience != "internal" %}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  {% else %}

  Если у вас еще нет {{ TF }}, установите его и настройте провайдер.

  {% endif %}

  Чтобы создать кластер:

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     * Кластер базы данных — описание кластера и его хостов.

     * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

     * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

     Пример структуры конфигурационного файла:

     {% if product == "yandex-cloud" %}

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
       version             = "<версия MySQL: {{ versions.tf.str }}>"
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

     {% endif %}

     {% if product == "cloud-il" %}

     ```hcl
     terraform {
       required_providers {
         yandex = {
           source = "yandex-cloud/yandex"
         }
       }
     }

     provider "yandex" {
       endpoint  = "{{ api-host }}:443"
       token     = "<статический ключ сервисного аккаунта>"
       cloud_id  = "<идентификатор облака>"
       folder_id = "<идентификатор каталога>"
       zone      = "<зона доступности>"
     }

     resource "yandex_mdb_mysql_cluster" "<имя кластера>" {
       name                = "<имя кластера>"
       environment         = "<окружение, PRESTABLE или PRODUCTION>"
       network_id          = "<идентификатор сети>"
       version             = "<версия MySQL: {{ versions.tf.str }}>"
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

     {% endif %}

     {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-db.md) %}

     1. {% include [Maintenance window](../../_includes/mdb/mmy/terraform/maintenance-window.md) %}

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-mmy }}).

  1. Проверьте корректность конфигурационных файлов.

     {% include [terraform-create-cluster-step-2](../../_includes/mdb/terraform-create-cluster-step-2.md) %}

  1. Создайте кластер.

     {% include [terraform-create-cluster-step-3](../../_includes/mdb/terraform-create-cluster-step-3.md) %}

     {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

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

    {% include [datatransfer access](../../_includes/mdb/api/datatransfer-access-create.md) %}

{% endlist %}

{% note warning %}

Если вы указали идентификаторы групп безопасности при создании кластера, то для подключения к нему может потребоваться дополнительная [настройка групп безопасности](connect.md#configure-security-groups).

{% endnote %}

## Примеры {#examples}

### Создание кластера с одним хостом {#creating-a-single-host-cluster}

{% list tabs %}

- CLI

  Чтобы создать кластер с одним хостом, передайте один параметр `--host`.

  Создайте кластер {{ mmy-name }} с тестовыми характеристиками:

    {% if audience != "internal" %}

    * С именем `my-mysql`.
    * Версии `{{ versions.cli.latest }}`.
    * В окружении `production`.
    * В сети `default`.
    * В группе безопасности с идентификатором `{{ security-group }}`.
    * С одним хостом класса `{{ host-class }}` в подсети `{{ subnet-id }}`, в зоне доступности `{{ region-id }}-a`.
    * С хранилищем на сетевых SSD-дисках (`{{ disk-type-example }}`) объемом 20 Гб.
    * С одним пользователем (`user1`), с паролем `user1user1`.
    * С одной базой данных `db1`, в которой пользователь `user1` имеет полные права (эквивалент `GRANT ALL PRIVILEGES on db1.*`).
    * С защитой от случайного удаления кластера.

    {% else %}

    * С именем `my-mysql`.
    * Версии `{{ versions.cli.latest }}`.
    * В окружении `production`.
    * С одним хостом класса `{{ host-class }}` в зоне доступности `man`.
    * С хранилищем на локальных SSD-дисках (`local-ssd`) объемом 20 Гб.
    * С одним пользователем (`user1`), с паролем `user1user1`.
    * С одной базой данных `db1`, в которой пользователь `user1` имеет полные права (эквивалент `GRANT ALL PRIVILEGES on db1.*`).
    * С защитой от случайного удаления кластера.

    {% endif %}

  1. Запустите команду создания кластера:

      {% if audience != "internal" %}

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

      {% else %}

      ```bash
      {{ yc-mdb-my }} cluster create \
        --name="my-mysql" \
        --mysql-version {{ versions.cli.latest }} \
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

- {{ TF }}

  Создайте кластер {{ mmy-name }} и сеть для него с тестовыми характеристиками:

    * С именем `my-mysql`.
    * Версии `{{ versions.tf.latest }}`.
    * В окружении `PRESTABLE`.
    * В облаке с идентификатором `{{ tf-cloud-id }}`.
    * В каталоге с идентификатором `{{ tf-folder-id }}`.
    * В новой сети `mynet`.
    * С одним хостом класса `{{ host-class }}` в новой подсети `mysubnet`, в зоне доступности `{{ region-id }}-a`. Подсеть `mysubnet` будет иметь диапазон `10.5.0.0/24`.
    * В новой группе безопасности `mysql-sg`, разрешающей подключение к кластеру из интернета через порт `{{ port-mmy }}`.
    * С хранилищем на сетевых SSD-дисках (`{{ disk-type-example }}`) объемом 20 ГБ.
    * С одним пользователем (`user1`), с паролем `user1user1`.
    * С одной базой данных `db1`, в которой пользователь `user1` имеет полные права (эквивалент `GRANT ALL PRIVILEGES on db1.*`).
    * С защитой от случайного удаления кластера.

  Конфигурационный файл для такого кластера выглядит так:

  {% if product == "yandex-cloud" %}

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
      zone      = "{{ region-id }}-a"
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
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.mynet.id
    v4_cidr_blocks = ["10.5.0.0/24"]
  }
  ```

  {% endif %}

  {% if product == "cloud-il" %}

  ```hcl
  terraform {
    required_providers {
      yandex = {
        source = "yandex-cloud/yandex"
      }
    }
  }

  provider "yandex" {
    endpoint  = "{{ api-host }}:443"
    token     = "<статический ключ сервисного аккаунта>"
    cloud_id  = "{{ tf-cloud-id }}"
    folder_id = "{{ tf-folder-id }}"
    zone      = "{{ region-id }}-a"
  }

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
      zone      = "{{ region-id }}-a"
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
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.mynet.id
    v4_cidr_blocks = ["10.5.0.0/24"]
  }
  ```

  {% endif %}

{% endlist %}
