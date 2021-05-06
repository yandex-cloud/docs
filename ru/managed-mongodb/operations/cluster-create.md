# Создание {{ MG }}-кластера

{{ MG }}-кластер — это один или несколько хостов базы данных, между которыми можно настроить репликацию. Репликация работает по умолчанию в любом кластере из более чем 1 хоста (первичный хост принимает запросы на запись и асинхронно дублирует изменения на вторичных хостах).

{% if audience != "internal" %}

Количество хостов, которые можно создать вместе с {{ MG }}-кластером, зависит от выбранного варианта хранилища:

  - При использовании сетевых дисков вы можете запросить любое количество хостов (от 1 до пределов текущей [квоты](../concepts/limits.md)).
  - При использовании SSD-дисков вместе с кластером можно создать не меньше 3 реплик (минимум 3 реплики необходимо, чтобы обеспечить отказоустойчивость). Если после создания кластера [доступных ресурсов каталога](../concepts/limits.md) останется достаточно, вы можете добавить дополнительные реплики.

{% note info %}

Возможность создания кластеров с версией {{ MG }} 3.6 будет отключена в марте 2021 г. в связи с [прекращением поддержки](https://www.mongodb.com/support-policy) этой версии разработчиком.

В апреле 2021 г. все существующие кластеры с этой версией {{ MG }} будут [принудительно обновлены](../qa/general.md#dbms-deprecated) до версии 4.0. Рекомендуем заранее [перейти](../operations/cluster-version-update.md) на использование актуальных версий {{ MG }}.

{% endnote %}

{% endif %}

{% list tabs %}

- Консоль управления

  1. В консоли управления выберите каталог, в котором нужно создать кластер БД.
  1. Выберите сервис **{{ mmg-name }}**.
  1. Нажмите кнопку **Создать кластер**.
  1. Введите имя кластера в поле **Имя кластера**. Имя кластера должно быть уникальным в рамках каталога.
  1. Выберите окружение, в котором нужно создать кластер (после создания кластера окружение изменить невозможно):
     - `PRODUCTION` — для стабильных версий ваших приложений.
     - `PRESTABLE` — для тестирования, в том числе самого сервиса {{ mmg-short-name }}. В Prestable-окружении раньше появляются новая функциональность, улучшения и исправления ошибок. При этом не все обновления обеспечивают обратную совместимость.
  1. Выберите версию СУБД.
  1. Выберите класс хостов — он определяет технические характеристики виртуальных машин, на которых будут развернуты хосты БД. При изменении класса хостов для кластера меняются характеристики всех уже созданных хостов.
  1. В блоке **Размер хранилища**:
      - Выберите [тип хранилища](../concepts/storage.md) — более гибкое сетевое (**network-hdd** или **network-ssd**) или более быстрое локальное хранилище (**local-ssd**). Размер локального хранилища можно менять только с шагом 100 ГБ.
      - Выберите объем, который будет использоваться для данных и резервных копий. Подробнее о том, как занимают пространство резервные копии, см. раздел [{#T}](../concepts/backup.md).
  1. В блоке **База данных** укажите атрибуты БД:
      - Имя БД.
      - Имя пользователя.
      - Пароль пользователя. Минимум 8 символов.
  1. В блоке **Сетевые настройки** выберите облачную сеть для размещения кластера и группы безопасности для сетевого трафика кластера. Может потребоваться дополнительная [настройка групп безопасности](connect.md#configuring-security-groups) для того, чтобы можно было подключаться к кластеру.
  1. В блоке **Хосты** выберите параметры хостов БД, создаваемых вместе с кластером (помните, что используя SSD-диски при создании {{ MG }}-кластера можно задать не меньше 3 хостов). Открыв блок **Расширенные настройки**, вы можете выбрать конкретные подсети для каждого хоста — по умолчанию каждый хост создается в отдельной подсети.
  1. При необходимости задайте дополнительные настройки кластера:

     {% include [mmg-extra-settings](../../_includes/mdb/mmg-extra-settings.md) %}

  1. При необходимости задайте [настройки СУБД](../concepts/settings-list.md#dbms-cluster-settings).
  1. Нажмите кнопку **Создать кластер**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать кластер:

  {% if audience != "internal" %}

  1. Проверьте, есть ли в каталоге подсети для хостов кластера:

     ```
     $ yc vpc subnet list
     ```

     Если ни одной подсети в каталоге нет, [создайте нужные подсети](../../vpc/operations/subnet-create.md) в сервисе {{ vpc-short-name }}.

  {% endif %}

  1. Посмотрите описание команды CLI для создания кластера:

      ```
      $ {{ yc-mdb-mg }} cluster create --help
      ```

  1. Укажите параметры кластера в команде создания (в примере приведены только обязательные флаги):

      {% if audience != "internal" %}

      ```
      $ {{ yc-mdb-mg }} cluster create \
         --name <имя кластера> \
         --environment=<окружение, prestable или production> \
         --network-name <имя сети> \
         --host zone-id=<зона доступности>,subnet-id=<идентификатор подсети> \
         --mongod-resource-preset <класс хоста> \
         --user name=<имя пользователя>,password=<пароль пользователя> \
         --database name=<имя базы данных> \
         --mongod-disk-type <network-hdd | network-ssd | local-ssd> \
         --mongod-disk-size <размер хранилища в гигабайтах>
      ```

      Идентификатор подсети `subnet-id` необходимо указывать, если в выбранной зоне доступности создано 2 и больше подсетей.

      {% else %}

      ```
      $ {{ yc-mdb-mg }} cluster create \
         --name <имя кластера> \
         --environment=<окружение, prestable или production> \
         --network-id {{ network-name }} \
         --host zone-id=<зона доступности> \
         --mongod-resource-preset <класс хоста> \
         --user name=<имя пользователя>,password=<пароль пользователя> \
         --database name=<имя базы данных> \
         --mongod-disk-type local-ssd \
         --mongod-disk-size <размер хранилища в гигабайтах>
      ```

      {% endif %}

- Terraform

  {% include [terraform-definition](../../_includes/solutions/terraform-definition.md) %}

  Если у вас ещё нет Terraform, [установите его и настройте провайдер](../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

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

     resource "yandex_mdb_mongodb_cluster" "<имя кластера>" {
       name               = "<имя кластера>"
       environment        = "<окружение: PRESTABLE или PRODUCTION>"
       network_id         = "<идентификатор сети>"
       security_group_ids = [ "<список групп безопасности>" ]

       cluster_config {
         version = "<версия MongoDB: 4.0, 4.2 или 4.4>"
       }

       database {
         name = "<имя базы данных>"
       }

       user {
         name     = "<имя пользователя>"
         password = "<пароль пользователя>"
         permission {
           database_name = "<имя базы данных>"
         }
       }

       resources {
         resource_preset_id = "<класс хоста>"
         disk_type_id       = "<тип хранилища>"
         disk_size          = "<размер хранилища в гигабайтах>"
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

     Более подробную информацию о ресурсах, которые вы можете создать с помощью Terraform, см. в [документации провайдера](https://www.terraform.io/docs/providers/yandex/r/mdb_mongodb_cluster.html).

  1. Проверьте корректность конфигурационных файлов.

     {% include [terraform-create-cluster-step-2](../../_includes/mdb/terraform-create-cluster-step-2.md) %}

  1. Создайте кластер.

     {% include [terraform-create-cluster-step-3](../../_includes/mdb/terraform-create-cluster-step-3.md) %}

{% endlist %}

{% note warning %}

Если вы указали идентификаторы групп безопасности при создании кластера, то для подключения к нему может потребоваться дополнительная [настройка групп безопасности](connect.md#configuring-security-groups).

{% endnote %}

## Примеры {#examples}

### Создание кластера с одним хостом {#creating-a-single-host-cluster}

{% list tabs %}

- CLI

  Чтобы создать кластер с одним хостом, следует передать один параметр `--host`.

  Допустим, нужно создать {{ MG }}-кластер со следующими характеристиками:

  {% if audience != "internal" %}

  - С именем `mymg`.
  - В окружении `production`.
  - В сети `{{ network-name }}`.
  - В группе безопасности с идентификатором `{{ security-group }}`.
  - С одним хостом класса `{{ host-class }}` в подсети `b0rcctk2rvtr8efcch64`, в зоне доступности `{{ zone-id }}`.
  - С быстрым сетевым хранилищем (`{{ disk-type-example }}`) объемом 20 ГБ.
  - С одним пользователем, `user1`, с паролем `user1user1`.
  - С одной базой данных, `db1`.

  {% else %}

  - С именем `mymg`.
  - В окружении `production`.
  - В группе безопасности с идентификатором `{{ security-group }}`.
  - С одним хостом класса `{{ host-class }}` в зоне доступности `{{ zone-id }}`.
  - С быстрым локальным хранилищем (`local-ssd`) объемом 20 ГБ.
  - С одним пользователем, `user1`, с паролем `user1user1`.
  - С одной базой данных, `db1`.

  {% endif %}

  Запустите следующую команду:

  {% if audience != "internal" %}

  ```
  $ {{ yc-mdb-mg }} cluster create \
       --name mymg \
       --environment production \
       --network-name {{ network-name }} \
       --security-group-ids {{ security-group }} \
       --mongod-resource-preset {{ host-class }} \
       --host zone-id={{ zone-id }},subnet-id=b0rcctk2rvtr8efcch64 \
       --mongod-disk-size 20 \
       --mongod-disk-type {{ disk-type-example }} \
       --user name=user1,password=user1user1 \
       --database name=db1
  ```

  {% else %}

  ```
  $ {{ yc-mdb-mg }} cluster create \
       --name mymg \
       --environment production \
       --network-id {{ network-name }} \
       --security-group-ids {{ security-group }} \
       --mongod-resource-preset {{ host-class }} \
       --host zone-id={{ zone-id }} \
       --mongod-disk-size 20 \
       --mongod-disk-type local-ssd \
       --user name=user1,password=user1user1 \
       --database name=db1
  ```

  {% endif %}

- Terraform

  Допустим, нужно создать {{ MG }}-кластер и сеть для него со следующими характеристиками:

    - С именем `mymg`.
    - Версии `4.4`.
    - В окружении `PRODUCTION`.
    - В облаке с идентификатором `{{ tf-cloud-id }}`.
    - В каталоге с идентификатором `{{ tf-folder-id }}`.
    - В новой сети `mynet`.
    - С одним хостом класса `{{ host-class }}` в новой подсети `mysubnet`, в зоне доступности `{{ zone-id }}`. Подсеть `mysubnet` будет иметь диапазон `10.5.0.0/24`.
    - В новой группе безопасности `mymg-sg`, разрешающей TCP-подключения к кластеру из интернета через порт `{{ port-mmg }}`.
    - С быстрым сетевым хранилищем (`{{ disk-type-example }}`) объемом 20 ГБ.
    - С одним пользователем, `user1`, с паролем `user1user1`.
    - С одной базой данных, `db1`.

  Конфигурационный файл для такого кластера выглядит так:

  ```go
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

  resource "yandex_mdb_mongodb_cluster" "mymg" {
    name               = "mymg"
    environment        = "PRODUCTION"
    network_id         = yandex_vpc_network.mynet.id
    security_group_ids = [ yandex_vpc_security_group.mymg-sg.id ]

    cluster_config {
      version = "4.4"
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
      zone_id   = "{{ zone-id }}"
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
    zone           = "{{ zone-id }}"
    network_id     = yandex_vpc_network.mynet.id
    v4_cidr_blocks = ["10.5.0.0/24"]
  }
  ```

{% endlist %}
