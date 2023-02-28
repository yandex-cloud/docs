# Создание {{ RD }}-кластера

{{ RD }}-кластер — это один или несколько хостов базы данных, между которыми можно настроить репликацию. Репликация работает по умолчанию в любом кластере из более чем 1 хоста: хост-мастер принимает запросы на запись, асинхронно дублируя изменения в репликах.

Подробнее об устройстве кластера {{ mrd-name }} см. в разделе [{#T}](../concepts/index.md).

{% note info %}

* Количество хостов, которые можно создать вместе с {{ RD }}-кластером, зависит от выбранного {% if audience != "internal" %}[типа диска](../concepts/storage.md#storage-type-selection){% else %}[типа диска](../concepts/storage.md){% endif %}, [класса хостов](../concepts/instance-types.md#available-flavors) и использования [шардирования](../concepts/sharding.md).
* Доступные типы диска [зависят](../concepts/storage.md) от выбранного [класса хостов](../concepts/instance-types.md).

{% endnote %}

## Как создать кластер {{ RD }} {#create-cluster}

{% note info %}

С 1 июня 2022 года прекращена поддержка {{ RD }} версий 5.0 и 6.0. Подробнее см. в разделе [{#T}](cluster-version-update.md#version-supported).

{% endnote %}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором нужно создать кластер БД.
  1. Выберите сервис **{{ mrd-name }}**.
  1. Нажмите кнопку **Создать кластер**.
  1. В блоке **Базовые параметры**:

     * Введите имя кластера в поле **Имя кластера**. Имя кластера должно быть уникальным в рамках каталога.
     * (Опционально) Добавьте описание кластера.
     * Выберите окружение, в котором нужно создать кластер (после создания кластера окружение изменить невозможно):
       * `PRODUCTION` — для стабильных версий ваших приложений.
       * `PRESTABLE` — для тестирования, в том числе самого сервиса {{ mrd-short-name }}. В Prestable-окружении раньше появляются новая функциональность, улучшения и исправления ошибок. При этом не все обновления обеспечивают обратную совместимость.
     * Выберите версию СУБД.
     * Если требуется, включите [шардирование кластера](../concepts/sharding.md).

       {% note warning %}

       Включить шардирование можно только при создании нового кластера. Шардировать уже созданный нешардированный кластер невозможно, как и отключить шардирование кластера, для которого оно включено.

       {% endnote %}

     * Если требуется, включите поддержку шифрованных SSL-соединений с кластером.

       {% note warning %}

       Включить шифрование соединений можно только при создании нового кластера. Отключить шифрование в кластере, для которого оно включено, невозможно.

       {% endnote %}

  1. В блоке **Класс хоста**:

     * Выберите **Платформу**.
     * Укажите **Тип** виртуальной машины, на которой будут развернуты хосты.
     * Выберите конфигурацию [хостов](../concepts/instance-types.md) — она определяет технические характеристики виртуальных машин, на которых будут развернуты хосты БД. При изменении конфигурации меняются характеристики всех уже созданных хостов.

  1. В блоке **Размер хранилища**:

        {% if audience != "internal" %}

        * Выберите [тип диска](../concepts/storage.md):
            * либо более гибкое хранилище — на сетевых SSD-дисках (`network-ssd`) или на нереплицируемых SSD-дисках (`network-ssd-nonreplicated`);
            * либо более быстрое хранилище — на локальных SSD-дисках (`local-ssd`).

            {% include [storages-step-settings-no-hdd](../../_includes/mdb/settings-storages-no-hdd.md) %}

        {% endif %}

        * Выберите размер хранилища. Доступный размер хранилища ограничен [квотами и лимитами](../concepts/limits.md#mrd-limits).

  1. В блоке **Настройки кластера** в поле **Пароль** укажите пароль пользователя, от 8 до 128 символов.

  {% if audience != "internal" %}

  1. В блоке **Сетевые настройки** выберите:
     * Облачную сеть для размещения кластера.
     * Группы безопасности для сетевого трафика кластера. Может потребоваться дополнительная [настройка групп безопасности](connect/index.md#configuring-security-groups) для того, чтобы можно было подключаться к кластеру.

       {% include [preview-pp.md](../../_includes/preview-pp.md) %}

  {% endif %}

  1. В блоке **Хосты**:

       * Чтобы изменить настройки отдельного хоста, нажмите на значок ![pencil](../../_assets/pencil.svg) в строке с его именем.

           * **Зона доступности** — выберите {% if audience != "internal" %}[зону доступности](../../overview/concepts/geo-scope.md){% else %}зону доступности{% endif %}.
           * **Подсеть** — укажите {% if audience != "internal" %}[подсеть](../../vpc/concepts/network.md#subnet){% else %}подсеть{% endif %} в выбранной зоне доступности.
           * **Публичный доступ** — разрешает доступ к хосту из интернета, если кластер создается с включенной настройкой **Поддержка TLS**.
           * **Имя шарда** — позволяет изменить имя шарда для хоста. Поле доступно только если кластер создается с включенной настройкой **Шардирование кластера**.

       * Чтобы добавить хосты в кластер, нажмите кнопку **Добавить хост**.

  1. При необходимости задайте дополнительные настройки кластера:

      {% include [mrd-extra-settings](../../_includes/mdb/mrd-extra-settings-web-console.md) %}

  1. При необходимости задайте [настройки СУБД](../concepts/settings-list.md).

  1. Нажмите кнопку **Создать кластер**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать кластер:

  {% if audience != "internal" %} 

  1. Проверьте, есть ли в каталоге подсети для хостов кластера:

     ```bash
     yc vpc subnet list
     ```

     Если ни одной подсети в каталоге нет, [создайте нужные подсети](../../vpc/operations/subnet-create.md) в сервисе {{ vpc-short-name }}. 

  {% endif %}

  1. Посмотрите описание команды CLI для создания кластера:

      ```bash
      {{ yc-mdb-rd }} cluster create --help
      ```

  1. При создании кластера с помощью CLI нельзя напрямую указать тип хоста и объем оперативной памяти. Вместо этого выберите подходящий [класс хостов](../concepts/instance-types.md). Чтобы просмотреть доступные классы хостов, выполните команду:

     ```bash
     {{ yc-mdb-rd }} resource-preset list
     ```

  1. Укажите параметры кластера в команде создания (в примере приведены не все флаги):

      {% if audience != "internal" %}

      ```bash
      {{ yc-mdb-rd }} cluster create \
        --name <имя кластера> \
        --environment <окружение, prestable или production> \
        --network-name <имя сети> \
        --host zone-id=<зона доступности>,`
              `subnet-id=<идентификатор подсети>,`
              `assign-public-ip=<публичный доступ к хосту: true или false>,`
              `replica-priority=<приоритет хоста> \
        --security-group-ids <список идентификаторов групп безопасности> \
        --enable-tls \
        --resource-preset <класс хоста> \
        --disk-size <размер хранилища в гигабайтах> \
        --password=<пароль пользователя> \
        --backup-window-start <время начала резервного копирования в формате ЧЧ:ММ:СС> \
        --deletion-protection=<защита от удаления кластера: true или false>
      ```

      {% else %}

      ```bash
      {{ yc-mdb-rd }} cluster create \
        --name <имя кластера> \
        --environment <окружение, prestable или production> \
        --network-name <имя сети> \
        --host zone-id=<зона доступности>,subnet-id=<идентификатор подсети> \
        --enable-tls \
        --resource-preset <класс хоста> \
        --disk-size <размер хранилища в гигабайтах> \
        --password=<пароль пользователя> \
        --backup-window-start <время начала резервного копирования в формате ЧЧ:ММ:СС>
        --deletion-protection=<защита от удаления кластера: true или false>
      ```

      {% endif %}

      Идентификатор подсети `subnet-id` необходимо указывать, если в выбранной зоне доступности создано 2 и больше подсетей.

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

       * Кластер базы данных — описание кластера и его хостов. При необходимости здесь же можно задать [настройки СУБД](../concepts/settings-list.md).

       {% if audience != "internal" %}

       * Сеть — описание [облачной сети](../../vpc/concepts/network.md#network), в которой будет расположен кластер. Если подходящая сеть у вас уже есть, описывать ее повторно не нужно.
       * Подсети — описание [подсетей](../../vpc/concepts/network.md#network), к которым будут подключены хосты кластера. Если подходящие подсети у вас уже есть, описывать их повторно не нужно.

       {% else %}

       * Сеть — описание облачной сети, в которой будет расположен кластер. Если подходящая сеть у вас уже есть, описывать ее повторно не нужно.
       * Подсети — описание подсетей, к которым будут подключены хосты кластера. Если подходящие подсети у вас уже есть, описывать их повторно не нужно.

       {% endif %}

       Пример структуры конфигурационного файла для создания шардированного кластера с поддержкой SSL:

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

       resource "yandex_mdb_redis_cluster" "<имя кластера>" {
         name                = "<имя кластера>"
         environment         = "<окружение: PRESTABLE или PRODUCTION>"
         network_id          = "<идентификатор сети>"
         security_group_ids  = [ "<идентификаторы групп безопасности>" ]
         tls_enabled         = true
         deletion_protection = <защита от удаления кластера: true или false>

         config {
           password = "<пароль>"
           version  = "<версия {{ RD }}: {{ versions.tf.str }}>"
         }

         resources {
           resource_preset_id = "<класс хоста>"
           disk_type_id       = "<тип диска>"
           disk_size          = <размер хранилища в гигабайтах>
         }

         host {
           zone             = "<зона доступности>"
           subnet_id        = "<идентификатор подсети>"
           assign_public_ip = <публичный доступ к хосту: true или false>
           replica_priority = <приоритет хоста>
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

       resource "yandex_mdb_redis_cluster" "<имя кластера>" {
         name                = "<имя кластера>"
         environment         = "<окружение: PRESTABLE или PRODUCTION>"
         network_id          = "<идентификатор сети>"
         tls_enabled         = true
         sharded             = true
         deletion_protection = <защита от удаления кластера: true или false>

         config {
           password = "<пароль>"
           version  = "<версия {{ RD }}: {{ versions.tf.str }}>"
         }

         resources {
           resource_preset_id = "<класс хоста>"
           disk_type_id       = "<тип диска>"
           disk_size          = <размер хранилища в гигабайтах>
         }

         host {
           zone             = "<зона доступности>"
           subnet_id        = "<идентификатор подсети>"
           assign_public_ip = <публичный доступ к хосту: true или false>
           replica_priority = <приоритет хоста>
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

       resource "yandex_mdb_redis_cluster" "<имя кластера>" {
         name                = "<имя кластера>"
         environment         = "<окружение: PRESTABLE или PRODUCTION>"
         network_id          = "<идентификатор сети>"
         security_group_ids  = [ "<идентификаторы групп безопасности>" ]
         tls_enabled         = true
         sharded             = true
         deletion_protection = <защита от удаления кластера: true или false>

         config {
           password = "<пароль>"
           version  = "<версия {{ RD }}: {{ versions.tf.str }}>"
         }

         resources {
           resource_preset_id = "<класс хоста>"
           disk_type_id       = "<тип диска>"
           disk_size          = <размер хранилища в гигабайтах>
         }

         host {
           zone             = "<зона доступности>"
           subnet_id        = "<идентификатор подсети>"
           assign_public_ip = <публичный доступ к хосту: true или false>
           replica_priority = <приоритет хоста>
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

       1. {% include [Maintenance window](../../_includes/mdb/mrd/terraform/maintenance-window.md) %}

       Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-mrd }}).

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Создайте кластер.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

       После этого в указанном каталоге будут созданы все требуемые ресурсы, а в терминале отобразятся IP-адреса виртуальных машин. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

       {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API

  Воспользуйтесь методом API [create](../api-ref/Cluster/create.md) и передайте в запросе:
  * Идентификатор каталога, в котором должен быть размещен кластер, в параметре `folderId`.
  * Имя кластера в параметре `name`.
  {% if audience != "internal" %}
  * Идентификаторы групп безопасности в параметре `securityGroupIds`.
  {% endif %}
  * Флаг `tlsEnabled=true` для создания кластера с поддержкой шифрованных SSL-соединений.

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

  Создайте кластер {{ mrd-name }} с тестовыми характеристиками:

  * Имя `myredis`.
  * Версия `{{ versions.cli.latest }}`.
  * Окружение — `production`.
  * Сеть `default`.
  * Один хост класса `hm1.nano` в подсети `b0rcctk2rvtr8efcch64`, в зоне доступности `{{ region-id }}-a`{% if audience != "internal" %} и группе безопасности с идентификатором `{{ security-group }}`{% endif %}, с публичным доступом и [приоритетом хоста](../concepts/replication.md#master-failover) `50`.
  * С поддержкой SSL-соединений.
  * Хранилище на сетевых SSD-дисках (`{{ disk-type-example }}`) размером 16 ГБ.
  * Пароль `user1user1`.
  * С защитой от случайного удаления кластера.

  Выполните следующую команду:

  {% if audience != "internal" %}

  ```bash
  {{ yc-mdb-rd }} cluster create \
    --name myredis \
    --redis-version {{ versions.cli.latest }} \
    --environment production \
    --network-name default \
    --resource-preset hm1.nano \
    --host zone-id={{ region-id }}-a,subnet-id=b0rcctk2rvtr8efcch64,assign-public-ip=true,replica-priority=50 \
    --security-group-ids {{ security-group }} \
    --enable-tls \
    --disk-type-id {{ disk-type-example }} \
    --disk-size 16 \
    --password=user1user1 \
    --deletion-protection=true
  ```

  {% else %}

  ```bash
  {{ yc-mdb-rd }} cluster create \
    --name myredis \
    --redis-version {{ versions.cli.latest }} \
    --environment production \
    --network-name default \
    --resource-preset hm1.nano \
    --host zone-id={{ region-id }}-a,subnet-id=b0rcctk2rvtr8efcch64 \
    --enable-tls \
    --disk-type-id {{ disk-type-example }} \
    --disk-size 16 \
    --password=user1user1 \
    --deletion-protection=true
  ```

  {% endif %}

- {{ TF }}

  Создайте кластер {{ mrd-name }} и сеть для него с тестовыми характеристиками:

    * Имя `myredis`.
    * Версия `{{ versions.tf.latest }}`.
    * Окружение — `PRODUCTION`.
    * Облако с идентификатором `{{ tf-cloud-id }}`.
    * Каталог с идентификатором `{{ tf-folder-id }}`.
    * Новая сеть `mynet`.
    * Один хост класса `{{ host-class }}` в новой подсети `mysubnet`, в зоне доступности `{{ region-id }}-a`, с публичным доступом и [приоритетом хоста](../concepts/replication.md#master-failover) `50`. Подсеть `mysubnet` будет иметь диапазон `10.5.0.0/24`.
    {% if audience != "internal" %}
    * Новая группа безопасности `redis-sg`, разрешающая подключения через порт `{{ port-mrd-tls }}` с любых адресов подсети `mysubnet`.
    {% endif %}
    * С поддержкой SSL-соединений.
    * Хранилище на сетевых SSD-дисках (`{{ disk-type-example }}`) размером 16 ГБ.
    * Пароль `user1user1`.
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

  resource "yandex_mdb_redis_cluster" "myredis" {
    name                = "myredis"
    environment         = "PRODUCTION"
    network_id          = yandex_vpc_network.mynet.id
    security_group_ids  = [ yandex_vpc_security_group.redis-sg.id ]
    tls_enabled         = true
    deletion_protection = true

    config {
      password = "user1user1"
      version  = "{{ versions.tf.latest }}"
    }

    resources {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 16
    }

    host {
      zone             = "{{ region-id }}-a"
      subnet_id        = yandex_vpc_subnet.mysubnet.id
      assign_public_ip = true
      replica_priority = 50
    }
  }

  resource "yandex_vpc_network" "mynet" { name = "mynet" }

  resource "yandex_vpc_security_group" "redis-sg" {
    name       = "redis-sg"
    network_id = yandex_vpc_network.mynet.id

    ingress {
      description    = "Redis"
      port           = {{ port-mrd-tls }}
      protocol       = "TCP"
      v4_cidr_blocks = ["10.5.0.0/24"]
    }

    egress {
      description    = "Redis"
      port           = {{ port-mrd-tls }}
      protocol       = "TCP"
      v4_cidr_blocks = ["10.5.0.0/24"]
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

  resource "yandex_mdb_redis_cluster" "myredis" {
    name                = "myredis"
    environment         = "PRODUCTION"
    network_id          = yandex_vpc_network.mynet.id
    tls_enabled         = true
    deletion_protection = true

    config {
      password = "user1user1"
      version  = "{{ versions.tf.latest }}"
    }

    resources {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 16
    }

    host {
      zone      = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
    }
  }

  resource "yandex_vpc_network" "mynet" { name = "mynet" }

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

  resource "yandex_mdb_redis_cluster" "myredis" {
    name                = "myredis"
    environment         = "PRODUCTION"
    network_id          = yandex_vpc_network.mynet.id
    security_group_ids  = [ yandex_vpc_security_group.redis-sg.id ]
    tls_enabled         = true
    deletion_protection = true

    config {
      password = "user1user1"
      version  = "{{ versions.tf.latest }}"
    }

    resources {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 16
    }

    host {
      zone      = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
    }
  }

  resource "yandex_vpc_network" "mynet" { name = "mynet" }

  resource "yandex_vpc_security_group" "redis-sg" {
    name       = "redis-sg"
    network_id = yandex_vpc_network.mynet.id

    ingress {
      description    = "Redis"
      port           = {{ port-mrd-tls }}
      protocol       = "TCP"
      v4_cidr_blocks = ["10.5.0.0/24"]
    }

    egress {
      description    = "Redis"
      port           = {{ port-mrd-tls }}
      protocol       = "TCP"
      v4_cidr_blocks = ["10.5.0.0/24"]
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

### Создание шардированного кластера {#creating-a-sharded-cluster}

{% list tabs %}

- {{ TF }}

    Создайте [шардированный](../concepts/sharding.md) кластер {{ mgp-name }} с тестовыми характеристиками:

    * Имя `myredis`.
    * Версия `{{ versions.tf.latest }}`.
    * Окружение `PRODUCTION`.
    * Облако с идентификатором `{{ tf-cloud-id }}`.
    * Каталог с идентификатором `{{ tf-folder-id }}`.
    * Новая сеть `mynet`.
    * Три подсети в сети `mynet`, по одной в каждой зоне доступности:
      * `subnet-a` с диапазоном `10.1.0.0/24`;
      * `subnet-b` с диапазоном `10.2.0.0/24`;
      * `subnet-c` с диапазоном `10.3.0.0/24`.
    * Три хоста класса `{{ host-class }}`, по одному в каждой подсети.
    {% if audience != "internal" %}
    * Новая группа безопасности `redis-sg`, разрешающая подключения через порты `{{ port-mrd }}` и `{{ port-mrd-sentinel }}` ([Redis Sentinel](./connect/index.md)) с любых адресов подсетей.
    {% endif %}
    * Хранилище на сетевых SSD-дисках (`{{ disk-type-example }}`) размером 16 ГБ.
    * Пароль `user1user1`.
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

    resource "yandex_mdb_redis_cluster" "myredis" {
      name                = "myredis"
      environment         = "PRODUCTION"
      network_id          = yandex_vpc_network.mynet.id
      security_group_ids  = [yandex_vpc_security_group.redis-sg.id]
      sharded             = true
      deletion_protection = true

      config {
        password = "user1user1"
        version  = "{{ versions.tf.latest }}"
      }

      resources {
        resource_preset_id = "{{ host-class }}"
        disk_type_id       = "{{ disk-type-example }}"
        disk_size          = 16
      }

      host {
        zone       = "{{ region-id }}-a"
        subnet_id  = yandex_vpc_subnet.subnet-a.id
        shard_name = "shard1"
      }

      host {
        zone       = "{{ region-id }}-b"
        subnet_id  = yandex_vpc_subnet.subnet-b.id
        shard_name = "shard2"
      }

      host {
        zone       = "{{ region-id }}-c"
        subnet_id  = yandex_vpc.subnet.subnet-c.id
        shard_name = "shard3"
      }
    }

    resource "yandex_vpc_network" "mynet" { name = "mynet" }

    resource "yandex_vpc_subnet" "subnet-a" {
      name           = "subnet-a"
      zone           = "{{ region-id }}-a"
      network_id     = yandex_vpc_network.mynet.id
      v4_cidr_blocks = ["10.1.0.0/24"]
    }

    resource "yandex_vpc_subnet" "subnet-b" {
      name           = "subnet-b"
      zone           = "{{ region-id }}-b"
      network_id     = yandex_vpc_network.mynet.id
      v4_cidr_blocks = ["10.2.0.0/24"]
    }

    resource "yandex_vpc_subnet" "subnet-c" {
      name           = "subnet-c"
      zone           = "{{ region-id }}-c"
      network_id     = yandex_vpc_network.mynet.id
      v4_cidr_blocks = ["10.3.0.0/24"]
    }

    resource "yandex_vpc_security_group" "redis-sg" {
      name       = "redis-sg"
      network_id = yandex_vpc_network.mynet.id

      ingress {
        description    = "Redis"
        port           = {{ port-mrd }}
        protocol       = "TCP"
        v4_cidr_blocks = [
          "10.1.0.0/24",
          "10.2.0.0/24",
          "10.3.0.0/24"
        ]
      }

      egress {
        description    = "Redis"
        port           = {{ port-mrd }}
        protocol       = "TCP"
        v4_cidr_blocks = [
          "10.1.0.0/24",
          "10.2.0.0/24",
          "10.3.0.0/24"
        ]
      }

      ingress {
        description    = "Redis Sentinel"
        port           = {{ port-mrd-sentinel }}
        protocol       = "TCP"
        v4_cidr_blocks = [
          "10.1.0.0/24",
          "10.2.0.0/24",
          "10.3.0.0/24"
        ]
      }

      egress {
        description    = "Redis Sentinel"
        port           = {{ port-mrd-sentinel }}
        protocol       = "TCP"
        v4_cidr_blocks = [
          "10.1.0.0/24",
          "10.2.0.0/24",
          "10.3.0.0/24"
        ]
      }
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

    resource "yandex_mdb_redis_cluster" "myredis" {
      name                = "myredis"
      environment         = "PRODUCTION"
      network_id          = yandex_vpc_network.mynet.id
      sharded             = true
      deletion_protection = true

      config {
        password = "user1user1"
        version  = "{{ versions.tf.latest }}"
      }

      resources {
        resource_preset_id = "{{ host-class }}"
        disk_type_id       = "{{ disk-type-example }}"
        disk_size          = 16
      }

      host {
        zone       = "{{ region-id }}-a"
        subnet_id  = yandex_vpc_subnet.subnet-a.id
        shard_name = "shard1"
      }

      host {
        zone       = "{{ region-id }}-b"
        subnet_id  = yandex_vpc_subnet.subnet-b.id
        shard_name = "shard2"
      }

      host {
        zone       = "{{ region-id }}-c"
        subnet_id  = yandex_vpc.subnet.subnet-c.id
        shard_name = "shard3"
      }
    }

    resource "yandex_vpc_network" "mynet" { name = "mynet" }

    resource "yandex_vpc_subnet" "subnet-a" {
      name           = "subnet-a"
      zone           = "{{ region-id }}-a"
      network_id     = yandex_vpc_network.mynet.id
      v4_cidr_blocks = ["10.1.0.0/24"]
    }

    resource "yandex_vpc_subnet" "subnet-b" {
      name           = "subnet-b"
      zone           = "{{ region-id }}-b"
      network_id     = yandex_vpc_network.mynet.id
      v4_cidr_blocks = ["10.2.0.0/24"]
    }

    resource "yandex_vpc_subnet" "subnet-c" {
      name           = "subnet-c"
      zone           = "{{ region-id }}-c"
      network_id     = yandex_vpc_network.mynet.id
      v4_cidr_blocks = ["10.3.0.0/24"]
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

    resource "yandex_mdb_redis_cluster" "myredis" {
      name                = "myredis"
      environment         = "PRODUCTION"
      network_id          = yandex_vpc_network.mynet.id
      security_group_ids  = [yandex_vpc_security_group.redis-sg.id]
      sharded             = true
      deletion_protection = true

      config {
        password = "user1user1"
        version  = "{{ versions.tf.latest }}"
      }

      resources {
        resource_preset_id = "{{ host-class }}"
        disk_type_id       = "{{ disk-type-example }}"
        disk_size          = 16
      }

      host {
        zone       = "{{ region-id }}-a"
        subnet_id  = yandex_vpc_subnet.subnet-a.id
        shard_name = "shard1"
      }

      host {
        zone       = "{{ region-id }}-b"
        subnet_id  = yandex_vpc_subnet.subnet-b.id
        shard_name = "shard2"
      }

      host {
        zone       = "{{ region-id }}-c"
        subnet_id  = yandex_vpc.subnet.subnet-c.id
        shard_name = "shard3"
      }
    }

    resource "yandex_vpc_network" "mynet" { name = "mynet" }

    resource "yandex_vpc_subnet" "subnet-a" {
      name           = "subnet-a"
      zone           = "{{ region-id }}-a"
      network_id     = yandex_vpc_network.mynet.id
      v4_cidr_blocks = ["10.1.0.0/24"]
    }

    resource "yandex_vpc_subnet" "subnet-b" {
      name           = "subnet-b"
      zone           = "{{ region-id }}-b"
      network_id     = yandex_vpc_network.mynet.id
      v4_cidr_blocks = ["10.2.0.0/24"]
    }

    resource "yandex_vpc_subnet" "subnet-c" {
      name           = "subnet-c"
      zone           = "{{ region-id }}-c"
      network_id     = yandex_vpc_network.mynet.id
      v4_cidr_blocks = ["10.3.0.0/24"]
    }

    resource "yandex_vpc_security_group" "redis-sg" {
      name       = "redis-sg"
      network_id = yandex_vpc_network.mynet.id

      ingress {
        description    = "Redis"
        port           = {{ port-mrd }}
        protocol       = "TCP"
        v4_cidr_blocks = [
          "10.1.0.0/24",
          "10.2.0.0/24",
          "10.3.0.0/24"
        ]
      }

      egress {
        description    = "Redis"
        port           = {{ port-mrd }}
        protocol       = "TCP"
        v4_cidr_blocks = [
          "10.1.0.0/24",
          "10.2.0.0/24",
          "10.3.0.0/24"
        ]
      }

      ingress {
        description    = "Redis Sentinel"
        port           = {{ port-mrd-sentinel }}
        protocol       = "TCP"
        v4_cidr_blocks = [
          "10.1.0.0/24",
          "10.2.0.0/24",
          "10.3.0.0/24"
        ]
      }

      egress {
        description    = "Redis Sentinel"
        port           = {{ port-mrd-sentinel }}
        protocol       = "TCP"
        v4_cidr_blocks = [
          "10.1.0.0/24",
          "10.2.0.0/24",
          "10.3.0.0/24"
        ]
      }
    }
    ```

    {% endif %}

{% endlist %}
