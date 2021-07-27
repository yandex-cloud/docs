---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# Создание {{ RD }}-кластера

{{ RD }}-кластер — это один или несколько хостов базы данных, между которыми можно настроить репликацию. Репликация работает по умолчанию в любом кластере из более чем 1 хоста: хост-мастер принимает запросы на запись, асинхронно дублируя изменения в репликах.

Количество хостов, которые можно создать вместе с {{ RD }}-кластером, зависит от выбранного типа хоста:

* В кластере с типом хостов **high-memory** можно создать неограниченное число хостов (от 1 до пределов текущей [квоты](../concepts/limits.md)).

* В кластере с типом хостов **burstable** можно создать только один хост.

## Как создать кластер {{ RD }} {#create-cluster}

{% list tabs %}

- Консоль управления
  
  1. В консоли управления выберите каталог, в котором нужно создать кластер БД.
  1. Выберите сервис **{{ mrd-name }}**.
  1. Нажмите кнопку **Создать кластер**.
  1. Введите имя кластера в поле **Имя кластера**. Имя кластера должно быть уникальным в рамках каталога.
  1. Выберите окружение, в котором нужно создать кластер (после создания кластера окружение изменить невозможно):
      - `PRODUCTION` — для стабильных версий ваших приложений.
      - `PRESTABLE` — для тестирования, в том числе самого сервиса {{ mrd-short-name }}. В Prestable-окружении раньше появляются новая функциональность, улучшения и исправления ошибок. При этом не все обновления обеспечивают обратную совместимость.
  1. Выберите версию СУБД.
  1. Если требуется, включите [шардирование кластера](../concepts/sharding.md).

     {% note warning %}

     Включить шардирование можно только при создании нового кластера. Шардировать уже созданный нешардированный кластер невозможно, как и отключить шардирование кластера, для которого оно включено.
    
     {% endnote %}

  1. Если требуется, включите поддержку шифрованных TLS/SSL-соединений с кластером (для версии {{ RD }} 6 или старше).

     {% note warning %}

     Включить шифрование соединений можно только при создании нового кластера. Отключить шифрование в кластере, для которого оно включено, невозможно.

     {% endnote %}

  1. Настройте [класс хостов](../concepts/instance-types.md) кластера:
      - Выберите тип хостов — он определяет их [гарантированную долю vCPU](../../compute/concepts/performance-levels.md). Хосты типа **high-memory** работают с полным использованием ядра, а **burstable** — с частичным.
      - Выберите объем оперативной памяти для хоста.
      - Выберите размер диска. Доступный размер диска зависит от объема оперативной памяти и ограничен [квотами и лимитами](../concepts/limits.md#limits). Минимальный размер диска в 2 раза больше выбранного объема оперативной памяти, максимальный — в 8 раз больше.
  1. В блоке **Настройки кластера** в поле **Пароль** укажите пароль пользователя, от 8 до 128 символов.
  1. В блоке **Сетевые настройки** выберите облачную сеть для размещения кластера и группы безопасности для сетевого трафика кластера. Может потребоваться дополнительная [настройка групп безопасности](connect.md#configuring-security-groups) для того, чтобы можно было подключаться к кластеру.
  1. В блоке **Хосты** нажмите на кнопку **Добавить хост** и выберите зону доступности и подсеть, к которой будет подключен хост. Создайте необходимое количество хостов. Для изменения зоны доступности и добавленного хоста нажмите на значок карандаша в строке хоста.

     Если вы включили шардирование, укажите названия шардов.

  1. При необходимости задайте дополнительные настройки кластера:
  
     {% include [mrd-extra-settings](../../_includes/mdb/mrd-extra-settings-web-console.md) %}

  1. При необходимости задайте [настройки СУБД](../concepts/settings-list.md).

  1. Нажмите кнопку **Создать кластер**.
  
- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы создать кластер:
  
  

  1. Проверьте, есть ли в каталоге подсети для хостов кластера:
  
     ```
     $ yc vpc subnet list
     ```
  
     Если ни одной подсети в каталоге нет, [создайте нужные подсети](../../vpc/operations/subnet-create.md) в сервисе {{ vpc-short-name }}.
  
  1. Посмотрите описание команды CLI для создания кластера:
  
      ```
      $ {{ yc-mdb-rd }} cluster create --help
      ```
  
  1. При создании кластера с помощью CLI нельзя напрямую указать тип хоста и объем оперативной памяти. Вместо этого выберите подходящий [класс хостов](../concepts/instance-types.md). Чтобы просмотреть доступные классы хостов, выполните команду:
  
     ```
     $ {{ yc-mdb-rd }} resource-preset list
     ```
  
  1. Укажите параметры кластера в команде создания (в примере приведены не все флаги):
  
      ```bash
      $ {{ yc-mdb-rd }} cluster create \
         --name <имя кластера> \
         --environment <окружение, prestable или production> \
         --network-name <имя сети> \
         --host zone-id=<зона доступности>,subnet-id=<идентификатор подсети> \
         --security-group-ids <список идентификаторов групп безопасности> \
         --enable-tls \
         --resource-preset <класс хоста> \
         --disk-size <размер хранилища в гигабайтах> \
         --password=<пароль пользователя> \
         --backup-window-start <время начала резервного копирования в формате ЧЧ:ММ:СС>
      ```
      
      Идентификатор подсети `subnet-id` необходимо указывать, если в выбранной зоне доступности создано 2 и больше подсетей.
      
- API

  Чтобы создать кластер, воспользуйтесь методом API [create](../api-ref/Cluster/create.md) и передайте в запросе:
  - Идентификатор каталога, в котором должен быть размещен кластер, в параметре `folderId`.
  - Имя кластера в параметре `name`.
  - Идентификаторы групп безопасности в параметре `securityGroupIds`.
  - Флаг `tlsEnabled=true` для создания кластера с поддержкой шифрованных TLS/SSL-соединений (для версии {{ RD }} 6 или старше).

- Terraform

  {% include [terraform-definition](../../_includes/solutions/terraform-definition.md) %}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер](../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы создать кластер:

    1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

       * Кластер базы данных — описание кластера и его хостов. При необходимости здесь же можно задать [настройки СУБД](../concepts/settings-list.md).
       * Сеть — описание [облачной сети](../../vpc/concepts/network.md#network), в которой будет расположен кластер. Если подходящая сеть у вас уже есть, описывать ее повторно не нужно.
       * Подсети — описание [подсетей](../../vpc/concepts/network.md#network), к которым будут подключены хосты кластера. Если подходящие подсети у вас уже есть, описывать их повторно не нужно.

       Пример структуры конфигурационного файла для создания кластера с поддержкой TLS:

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
         name               = "<имя кластера>"
         environment        = "<окружение: PRESTABLE или PRODUCTION>"
         network_id         = "<идентификатор сети>"
         security_group_ids = [ "<идентификаторы групп безопасности>" ]
         tls_enabled        = true
         sharded            = <шардирование: true или false>

         config {
           password = "<пароль>"
           version  = "<версия Redis: 5.0 или 6.0>"
         }

         resources {
           resource_preset_id = "<класс хоста>"
           disk_type_id       = "<тип хранилища>"
           disk_size          = <размер хранилища в гигабайтах>
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

       Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-mrd }}).

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Создайте кластер.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

       После этого в указанном каталоге будут созданы все требуемые ресурсы, а в терминале отобразятся IP-адреса виртуальных машин. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

{% endlist %}

{% note warning %}

Если вы указали идентификаторы групп безопасности при создании кластера, то для подключения к нему может потребоваться дополнительная [настройка групп безопасности](connect.md#configuring-security-groups).

{% endnote %}

## Примеры {#examples}

### Создание кластера с одним хостом {#creating-a-single-host-cluster}

{% list tabs %}

- CLI
  
  Чтобы создать кластер с одним хостом, передайте один параметр `--host`.
  
  Допустим, нужно создать {{ RD }}-кластер со следующими характеристиками:
  
  - С именем `myredis`.
  - С версией `6.0`.
  - В окружении `production`.
  - В сети `default`.
  - С одним хостом класса `hm1.nano` в подсети `b0rcctk2rvtr8efcch64`, в зоне доступности `{{ zone-id }}` и группе безопасности с идентификатором `{{ security-group }}`.
  - С поддержкой TLS-соединений.
  - С быстрым сетевым хранилищем (`{{ disk-type-example }}`) объемом 16 ГБ.
  - C паролем `user1user1`.
  
  Запустите следующую команду:
  
  ```
  $ {{ yc-mdb-rd }} cluster create \
       --name myredis \
       --redis-version 6.0 \
       --environment production \
       --network-name default \
       --resource-preset hm1.nano \
       --host zone-id={{ zone-id }},subnet-id=b0rcctk2rvtr8efcch64 \
       --security-group-ids {{ security-group }} \
       --enable-tls \
       --disk-type-id {{ disk-type-example }} \
       --disk-size 16 \
       --password=user1user1
  ```

- Terraform

  Допустим, нужно создать {{ RD }}-кластер и сеть для него со следующими характеристиками:

    - С именем `myredis`.
    - С версией `6.0`.
    - В окружении `PRODUCTION`.
    - В облаке с идентификатором `{{ tf-cloud-id }}`.
    - В каталоге с идентификатором `{{ tf-folder-id }}`.
    - В новой сети `mynet`.
    - С одним хостом класса `{{ host-class }}` в новой подсети `mysubnet`, в зоне доступности `{{ zone-id }}`. Подсеть `mysubnet` будет иметь диапазон `10.5.0.0/24`.
    - В новой группе безопасности `redis-sg`, разрешающей подключения через порт `{{ port-mrd-tls }}` с любых адресов подсети `mysubnet`.
    - С поддержкой TLS-соединений.
    - С быстрым сетевым хранилищем (`{{ disk-type-example }}`) объемом 16 ГБ.
    - C паролем `user1user1`.

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

  resource "yandex_mdb_redis_cluster" "myredis" {
    name               = "myredis"
    environment        = "PRODUCTION"
    network_id         = yandex_vpc_network.mynet.id
    security_group_ids = [ yandex_vpc_security_group.redis-sg.id ]
    tls_enabled        = true

    config {
      password = "user1user1"
      version  = "6.0"
    }

    resources {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 16
    }

    host {
      zone      = "{{ zone-id }}"
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

  resource  "yandex_vpc_subnet" "mysubnet" {
    name           = "mysubnet"
    zone           = "{{ zone-id }}"
    network_id     = yandex_vpc_network.mynet.id
    v4_cidr_blocks = ["10.5.0.0/24"]
  }
  ```

{% endlist %}

### Создание шардированного кластера {#creating-a-sharded-cluster}

{% list tabs %}

* Terraform

    Допустим, нужно создать [шардированный](../concepts/sharding.md) {{RD}}-кластер со следующими характеристиками:

    * С именем `myredis`.
    * В окружении `PRODUCTION`.
    * В облаке с идентификатором `{{ tf-cloud-id }}`.
    * В каталоге с идентификатором `{{ tf-folder-id }}`.
    * В новой сети `mynet`.
    * С тремя подсетями в сети `mynet`, по одной в каждой зоне доступности:
        * `subnet-a` с диапазоном `10.1.0.0/24`;
        * `subnet-b` с диапазоном `10.2.0.0/24`;
        * `subnet-c` с диапазоном `10.3.0.0/24`.
    * С тремя хостами класса `{{ host-class }}`, по одному в каждой подсети.
    * В новой группе безопасности `redis-sg`, разрешающей подключения через порты `{{ port-mrd }}` и `{{ port-mrd-sentinel }}` ([Redis Sentinel](./connect.md)) с любых адресов подсетей.
    * С быстрым сетевым хранилищем (`{{ disk-type-example }}`) объемом 16 ГБ.
    * C паролем `user1user1`.

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

    resource "yandex_mdb_redis_cluster" "myredis" {
      name               = "myredis"
      environment        = "PRODUCTION"
      network_id         = yandex_vpc_network.mynet.id
      security_group_ids = [yandex_vpc_security_group.redis-sg.id]
      sharded            = true

      config {
        password = "user1user1"
      }

      resources {
        resource_preset_id = "{{ host-class }}"
        disk_type_id       = "{{ disk-type-example }}"
        disk_size          = 16
      }

      host {
        zone       = "ru-central1-a"
        subnet_id  = yandex_vpc_subnet.subnet-a.id
        shard_name = "shard1"
      }

      host {
        zone       = "ru-central1-b"
        subnet_id  = yandex_vpc_subnet.subnet-b.id
        shard_name = "shard2"
      }

      host {
        zone       = "ru-central1-c"
        subnet_id  = yandex_vpc.subnet.subnet-c.id
        shard_name = "shard3"
      }
    }

    resource "yandex_vpc_network" "mynet" { name = "mynet" }

    resource "yandex_vpc_subnet" "subnet-a" {
      name           = "subnet-a"
      zone           = "ru-central1-a"
      network_id     = yandex_vpc_network.mynet.id
      v4_cidr_blocks = ["10.1.0.0/24"]
    }

    resource "yandex_vpc_subnet" "subnet-b" {
      name           = "subnet-b"
      zone           = "ru-central1-b"
      network_id     = yandex_vpc_network.mynet.id
      v4_cidr_blocks = ["10.2.0.0/24"]
    }

    resource "yandex_vpc_subnet" "subnet-c" {
      name           = "subnet-c"
      zone           = "ru-central1-c"
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

{% endlist %}
