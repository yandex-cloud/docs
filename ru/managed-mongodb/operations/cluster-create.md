# Создание {{ MG }}-кластера

{{ MG }}-кластер — это один или несколько хостов базы данных, между которыми можно настроить репликацию. Репликация работает по умолчанию в любом кластере из более чем 1 хоста (первичный хост принимает запросы на запись и асинхронно дублирует изменения на вторичных хостах).

{% if audience != "internal" %}

{% note info %}

* Количество хостов, которые можно создать вместе с {{ MG }}-кластером, зависит от выбранного {% if audience != "internal" %}[типа диска](../concepts/storage.md#storage-type-selection){% else %}[типа диска](../concepts/storage.md){% endif %} и [класса хостов](../concepts/instance-types.md#available-flavors).
* Доступные типы диска [зависят](../concepts/storage.md) от выбранного [класса хостов](../concepts/instance-types.md).

{% endnote %}

{% if policy != "keep" %}

{% note info %}

Возможность создания кластеров с версией {{ MG }} 4.0 будет отключена в декабре 2021 г. в связи с [прекращением поддержки](https://www.mongodb.com/support-policy) этой версии разработчиком.

В январе 2022 г. все существующие кластеры с этой версией {{ MG }} будут [принудительно обновлены](../qa/general.md#dbms-deprecated) до версии 4.2. Рекомендуем заранее [перейти](../operations/cluster-version-update.md) на использование актуальных версий {{ MG }}.

{% endnote %}

{% endif %}

{% endif %}

{% list tabs %}

- Консоль управления

  Чтобы создать кластер:

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер БД.

  1. Выберите сервис **{{ mmg-name }}**.

  1. Нажмите кнопку **Создать кластер**.

  1. В блоке **Базовые параметры**:

      * Введите название в поле **Имя кластера**. Имя кластера должно быть уникальным в рамках каталога.
      * (опционально) Введите **Описание** кластера.
      * Выберите окружение, в котором нужно создать кластер (после создания кластера окружение изменить невозможно):

          * `PRODUCTION` — для стабильных версий ваших приложений.
          * `PRESTABLE` — для тестирования, в том числе самого сервиса {{ mmg-short-name }}. В Prestable-окружении раньше появляются новая функциональность, улучшения и исправления ошибок. При этом не все обновления обеспечивают обратную совместимость.

      * Укажите версию СУБД.

  1. {% include [mmg-settings-host-class](../../_includes/mdb/mmg/settings-host-class.md) %}

  1. В блоке **Размер хранилища**:

      * Выберите [тип диска](../concepts/storage.md).

        {% include [storages-step-settings](../../_includes/mdb/settings-storages.md) %}

      * Выберите размер хранилища, который будет использоваться для данных и резервных копий. Подробнее о том, как занимают пространство резервные копии, см. раздел [{#T}](../concepts/backup.md).
      
  1. В блоке **База данных** укажите атрибуты БД:

      * Имя БД.
      * Имя пользователя.
      * Пароль пользователя. Минимум 8 символов.

  {% if audience != "internal" %}

  1. В блоке **Сетевые настройки** выберите:

      * Облачную сеть для размещения кластера.
      * Группы безопасности для сетевого трафика кластера. Может потребоваться дополнительная [настройка групп безопасности](connect/index.md#configuring-security-groups) для того, чтобы можно было подключаться к кластеру.

        {% include [preview-pp](../../_includes/preview-pp.md) %}

  {% endif %}

  1. В блоке **Хосты** добавьте хосты БД, создаваемые вместе с кластером:

     {% if audience != "internal" %}

     * Нажмите кнопку **Добавить хост**.
     * Выберите [зону доступности](../../overview/concepts/geo-scope.md).
     * Выберите [подсеть](../../vpc/concepts/network.md#subnet) в указанной зоне доступности. Если подсети нет, создайте ее.
     * Если хост должен быть доступен снаружи {{ yandex-cloud }}, включите опцию **Публичный доступ**.

     {% else %}

     * Нажмите кнопку **Добавить хост**.
     * Выберите зону доступности.
     * Выберите подсеть в указанной зоне доступности. Если подсети нет, создайте ее.
     * Если хост должен быть доступен снаружи {{ yandex-cloud }}, включите опцию **Публичный доступ**.
     
     {% endif %}

     Чтобы обеспечить отказоустойчивость, для типов диска `local-ssd`{% if audience != "internal" %} и `network-ssd-nonreplicated`{% endif %} необходимо как минимум 3 хоста. Подробнее см. в разделе [Хранилище](../concepts/storage.md).

     По умолчанию хосты создаются в разных зонах доступности. См. подробнее об [управлении хостами](hosts.md).
  
  1. При необходимости задайте дополнительные настройки кластера:

      {% include [mmg-extra-settings](../../_includes/mdb/mmg-extra-settings.md) %}

  1. При необходимости задайте [настройки СУБД](../concepts/settings-list.md#dbms-cluster-settings).

      {% include [mmg-settings-dependence](../../_includes/mdb/mmg/note-info-settings-dependence.md) %}

  1. Нажмите кнопку **Создать кластер**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать кластер:

  {% if audience != "internal" %}

  1. Проверьте, есть ли в каталоге подсети для хостов кластера:

     ```
     yc vpc subnet list
     ```

     Если ни одной подсети в каталоге нет, [создайте нужные подсети](../../vpc/operations/subnet-create.md) в сервисе {{ vpc-short-name }}.

  {% endif %}

  1. Посмотрите описание команды CLI для создания кластера:

      ```
      {{ yc-mdb-mg }} cluster create --help
      ```

  1. Укажите параметры кластера в команде создания (в примере приведены не все параметры):

      {% if audience != "internal" %}

      ```bash
      {{ yc-mdb-mg }} cluster create \
        --name <имя кластера> \
        --environment=<окружение, prestable или production> \
        --network-name <имя сети> \
        --host zone-id=<зона доступности>,subnet-id=<идентификатор подсети> \
        --mongod-resource-preset <класс хоста> \
        --user name=<имя пользователя>,password=<пароль пользователя> \
        --database name=<имя базы данных> \
        --mongod-disk-type <network-hdd | network-ssd | local-ssd | network-ssd-nonreplicated> \
        --mongod-disk-size <размер хранилища в гигабайтах> \
        --deletion-protection=<защита от удаления кластера: true или false>
      ```

      Идентификатор подсети `subnet-id` необходимо указывать, если в выбранной зоне доступности создано 2 и больше подсетей.

      {% else %}

      ```bash
      {{ yc-mdb-mg }} cluster create \
        --name <имя кластера> \
        --environment=<окружение, prestable или production> \
        --network-id {{ network-name }} \
        --host zone-id=<зона доступности> \
        --mongod-resource-preset <класс хоста> \
        --user name=<имя пользователя>,password=<пароль пользователя> \
        --database name=<имя базы данных> \
        --mongod-disk-type <local-ssd | local-hdd> \
        --mongod-disk-size <размер хранилища в гигабайтах> \
        --deletion-protection=<защита от удаления кластера: true или false>
      ```

      {% endif %}

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

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

     {% if audience != "internal" %}

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

       resources {
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

     {% else %}

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

     resource "yandex_mdb_mongodb_cluster" "<имя кластера>" {
       name                = "<имя кластера>"
       environment         = "<окружение: PRESTABLE или PRODUCTION>"
       network_id          = "<идентификатор сети>"
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

       resources {
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

     {% endif %}

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

       resources {
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

     {% endif %}

     {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

     1. {% include [Maintenance window](../../_includes/mdb/mmg/terraform/maintenance-window.md) %}

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-mmg }}).

  2. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  3. Создайте кластер.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      После этого в указанном каталоге будут созданы все требуемые ресурсы, а в терминале отобразятся IP-адреса виртуальных машин. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

      {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API

    Воспользуйтесь методом API [create](../api-ref/Cluster/create.md) и передайте в запросе:

    * Идентификатор каталога, в котором должен быть размещен кластер, в параметре `folderId`.
    * Имя кластера в параметре `name`.
    * Окружение кластера в параметре `environment`.
    * Идентификатор сети в параметре `networkId`.
    * Конфигурацию кластера в параметре `configSpec`.
    * Конфигурацию хостов кластера в одном или нескольких параметрах `hostSpecs`.
    {% if audience != "internal" %}
    * Идентификаторы [групп безопасности](../concepts/network.md#security-groups) в параметре `securityGroupIds`.
    {% endif %}
    * Конфигурацию баз данных в одном или нескольких параметрах `databaseSpecs`.
    * Настройки пользователей в одном или нескольких параметрах `userSpecs`.
    * Настройки защиты от удаления кластера в параметре `deletionProtection`.

        {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-data.md) %}

{% endlist %}

{% if audience != "internal" %}

{% note warning %}

Если вы указали идентификаторы групп безопасности при создании кластера, то для подключения к нему может потребоваться дополнительная [настройка групп безопасности](connect/index.md#configuring-security-groups).

{% endnote %}

{% endif %}

## Примеры {#examples}

### Создание кластера с одним хостом {#creating-a-single-host-cluster}

{% list tabs %}

- CLI

  Чтобы создать кластер с одним хостом, передайте один параметр `--host`.

  Создайте кластер {{ mmg-name }} с тестовыми характеристиками:

  {% if audience != "internal" %}

  * С именем `mymg`.
  * В окружении `production`.
  * В сети `{{ network-name }}`.
  * В группе безопасности с идентификатором `{{ security-group }}`.
  * С одним хостом класса `{{ host-class }}` в подсети `b0rcctk2rvtr8efcch64`, в зоне доступности `{{ region-id }}-a`.
  * С хранилищем на сетевых SSD-дисках (`{{ disk-type-example }}`) размером 20 ГБ.
  * С одним пользователем, `user1`, с паролем `user1user1`.
  * С одной базой данных, `db1`.
  * С защитой от случайного удаления кластера.

  {% else %}

  * С именем `mymg`.
  * В окружении `production`.
  * С одним хостом класса `{{ host-class }}` в зоне доступности `{{ region-id }}-a`.
  * С хранилищем на сетевых SSD-дисках (`local-ssd`) размером 20 ГБ.
  * С одним пользователем, `user1`, с паролем `user1user1`.
  * С одной базой данных, `db1`.
  * С защитой от случайного удаления кластера.

  {% endif %}

  Выполните следующую команду:

  {% if audience != "internal" %}

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

  {% else %}

  ```bash
  {{ yc-mdb-mg }} cluster create \
    --name mymg \
    --environment production \
    --network-id {{ network-name }} \
    --mongod-resource-preset {{ host-class }} \
    --host zone-id={{ region-id }}-a \
    --mongod-disk-size 20 \
    --mongod-disk-type local-ssd \
    --user name=user1,password=user1user1 \
    --database name=db1 \
    --deletion-protection=true
  ```

  {% endif %}

- {{ TF }}

  Создайте кластер {{ mmg-name }} и сеть для него с тестовыми характеристиками:

    * С именем `mymg`.
    * Версии `{{ versions.tf.latest }}`.
    * В окружении `PRODUCTION`.
    * В облаке с идентификатором `{{ tf-cloud-id }}`.
    * В каталоге с идентификатором `{{ tf-folder-id }}`.
    * В новой сети `mynet`.
    * С одним хостом класса `{{ host-class }}` в новой подсети `mysubnet`, в зоне доступности `{{ region-id }}-a`. Подсеть `mysubnet` будет иметь диапазон `10.5.0.0/24`.
    {% if audience != "internal" %}
    * В новой группе безопасности `mymg-sg`, разрешающей TCP-подключения к кластеру из интернета через порт `{{ port-mmg }}`.
    {% endif %}
    * С хранилищем на сетевых SSD-дисках (`{{ disk-type-example }}`) размером 20 ГБ.
    * С одним пользователем, `user1`, с паролем `user1user1`.
    * С одной базой данных, `db1`.
    * С защитой от случайного удаления кластера.

  Конфигурационный файл для такого кластера выглядит так:

  {% if product == "yandex-cloud" %}

  {% if audience != "internal" %}

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

    resources {
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

  {% else %}

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

  resource "yandex_mdb_mongodb_cluster" "mymg" {
    name                = "mymg"
    environment         = "PRODUCTION"
    network_id          = yandex_vpc_network.mynet.id
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

    resources {
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

  resource "yandex_vpc_subnet" "mysubnet" {
    name           = "mysubnet"
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.mynet.id
    v4_cidr_blocks = ["10.5.0.0/24"]
  }
  ```

  {% endif %}

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

    resources {
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

  {% endif %}

{% endlist %}
