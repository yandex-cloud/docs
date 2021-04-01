# Управление хостами {{ ZK }}

[Шард](../concepts/sharding.md) с одним хостом в кластере {{ mch-name }} не отказоустойчив и не обеспечивает [репликацию данных](../concepts/replication.md). Чтобы кластер с этим шардом был более надежным, можно [добавить дополнительные хосты {{ CH }}](hosts.md) в шард, но для управления ими сначала необходимо [включить отказоустойчивость](#add-zk) (при этом в кластер будет добавлено минимально допустимое количество хостов {{ ZK }} — три).

Вы можете [добавлять](#add-zk-host) и [удалять](#delete-zk-host) хосты {{ ZK }} в отказоустойчивом кластере. Всего в отказоустойчивом кластере может быть от трех до пяти хостов {{ ZK }} включительно.

{% note warning %}

Обратите внимание:
* Если кластер использует [гибридное хранилище](../concepts/storage.md#hybrid-storage-features) на стадии [Preview](https://cloud.yandex.ru/docs/overview/concepts/launch-stages), то в нем нельзя включить отказоустойчивость и управлять хостами {{ ZK }}. На стадии General Availability это ограничение будет снято.
* Если для кластера уже включена отказоустойчивость и созданы хосты {{ ZK }}, то полностью удалить эти хосты невозможно — в кластере всегда будет минимум три хоста {{ ZK }}. 

{% endnote %}

## Включить отказоустойчивость для кластера {#add-zk}

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **Хосты**.
  1. Нажмите кнопку **Настроить хосты {{ ZK }}**.
  1. Укажите [класс хостов](../concepts/instance-types.md).
  1. Задайте настройки хранилища.
  1. При необходимости измените настройки хостов {{ ZK }}. Чтобы это сделать, наведите курсор на строку нужного хоста и нажмите значок ![image](../../_assets/pencil.svg).
  1. Нажмите кнопку **Сохранить изменения**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы включить отказоустойчивость для кластера:
  1. Посмотрите описание команды CLI для добавления хостов {{ ZK }}:

     ```
     $ {{ yc-mdb-ch }} cluster add-zookeeper --help
     ```

  1. Запустите операцию с характеристиками хостов по умолчанию:

     ```bash
     $ {{ yc-mdb-ch }} cluster add-zookeeper <имя кластера> \
                             --host zone-id=ru-central1-c,subnet-name=default-c \
                             --host zone-id=ru-central1-a,subnet-name=default-a \
                             --host zone-id=ru-central1-b,subnet-name=default-b
     ```

     Если в сети, в которой расположен кластер, ровно 3 подсети, по одной в каждой зоне доступности, то явно указывать подсети для хостов необязательно: {{ mch-name }} автоматически распределит хосты по этим подсетям. 

     Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform

    Чтобы включить отказоустойчивость для кластера:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Убедитесь, что в конфигурационном файле описаны три подсети — по одной для каждой зоны доступности. При необходимости добавьте недостающие:

        ```hcl
        resource "yandex_vpc_network" "<имя сети>" {
          name = "<имя сети>"
        }

        resource "yandex_vpc_subnet" "<имя подсети в зоне ru-central1-a>" {
          name           = "<имя подсети в зоне ru-central1-a>"
          zone           = "ru-central1-a"
          network_id     = yandex_vpc_network.<имя сети>.id
          v4_cidr_blocks = [ "<диапазон адресов подсети в зоне ru-central1-a>" ]
        }

        resource "yandex_vpc_subnet" "<имя подсети в зоне ru-central1-b>" {
          name           = "<имя подсети в зоне ru-central1-b>"
          zone           = "ru-central1-b"
          network_id     = yandex_vpc_network.<имя сети>.id
          v4_cidr_blocks = [ "<диапазон адресов подсети в зоне ru-central1-b>" ]
        }

        resource "yandex_vpc_subnet" "<имя подсети в зоне ru-central1-c>" {
          name           = "<имя подсети в зоне ru-central1-c>"
          zone           = "ru-central1-c"
          network_id     = yandex_vpc_network.<имя сети>.id
          v4_cidr_blocks = [ "<диапазон адресов подсети в зоне ru-central1-c>" ]
        }
        ```

    1. Добавьте к описанию кластера {{ CH }} необходимое количество блоков `host` с типом `CLICKHOUSE`.

        Требования к хостам {{ CH }}:

        * минимальный класс хоста — `b1.medium`;
        * если хостов больше одного, они должны размещаться в разных зонах доступности.

        При необходимости измените класс существующих хостов {{ CH }} и зоны доступности, добавьте необходимое количество новых хостов.

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя кластера>" {
          name = "<имя кластера>"
          ...
          clickhouse {
            resources {
              resource_preset_id = "<класс хоста: b1.medium или выше>"
              disk_type_id       = "<тип хранилища>"
              disk_size          = <размер хранилища, ГБ>
            }
          }
          ...
          host {
            type      = "CLICKHOUSE"
            zone      = "ru-central1-a"
            subnet_id = yandex_vpc_subnet.<имя подсети в зоне доступности ru-central1-a>.id
          }
          ...
        }
        ```

    1. Добавьте к описанию кластера {{ CH }} не меньше трех блоков `host` с типом `ZOOKEEPER`.

        Требования к хостам {{ ZK }}:

        * в каждой зоне доступности должно быть минимум по одному хосту;
        * минимальный класс хоста — `b1.medium`;
        * тип хранилища — `network-ssd`;
        * минимальный размер хранилища — 10 гигабайт.

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя кластера>" {
          ...
          zookeeper {
            resources {
              resource_preset_id = "<класс хоста: b1.medium или выше>"
              disk_type_id       = "network-ssd"
              disk_size          = <размер хранилища, ГБ>
            }
          }
          ...
          host {
            type      = "ZOOKEEPER"
            zone      = "ru-central1-a"
            subnet_id = yandex_vpc_subnet.<имя подсети в зоне доступности ru-central1-a>.id
          }
          host {
            type      = "ZOOKEEPER"
            zone      = "ru-central1-b"
            subnet_id = yandex_vpc_subnet.<имя подсети в зоне доступности ru-central1-b>.id
          }
          host {
            type      = "ZOOKEEPER"
            zone      = "ru-central1-c"
            subnet_id = yandex_vpc_subnet.<имя подсети в зоне доступности ru-central1-c>.id
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_clickhouse_cluster).

- API

  Воспользуйтесь методом  [addZookeeper](../api-ref/Cluster/addZookeeper.md). При добавлении укажите настройки для трех хостов {{ ZK }}, перечислив их в параметре `hostSpecs`.

{% endlist %}

{% note info %}

По умолчанию для хостов {{ ZK }} задаются следующие характеристики:
* класс хоста `b2.medium`;
* объем диска 10 ГБ;
* [тип хранилища](../concepts/storage.md) — быстрое сетевое.

{% endnote %}

## Добавить хост {{ ZK }} {#add-zk-host}

{% list tabs %}

- Консоль управления
  
  1. Перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **Хосты**.
  1. Нажмите кнопку **Добавить хосты {{ ZK }}**.
  1. При необходимости измените настройки хоста.
  1. Нажмите кнопку **Сохранить изменения**.
  
- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы добавить хост в кластер:
  1. Соберите необходимую информацию:
     - Запросите идентификатор подсети, выполнив команду:
       ```
       $ yc vpc subnet list
       ```
       Если нужной подсети в списке нет, [создайте ее](../../vpc/operations/subnet-create.md).
     - Запросите имя кластера со [списком кластеров в каталоге](cluster-list.md#list-clusters).
     
  1. Посмотрите описание команды CLI для добавления хостов:
  
     ```
     $ {{ yc-mdb-ch }} host add --help
     ```
     
  1. Выполните команду добавления хоста {{ ZK }}:
  
     ```
     $ {{ yc-mdb-ch }} hosts add \
          --cluster-name <имя кластера> \
          --host zone-id=<зона доступности>,subnet-id=<идентификатор подсети>,type=zookeeper
     ```

- Terraform

    Чтобы добавить хост {{ ZK }} в кластер:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Добавьте к описанию кластера {{ mch-name }} блок `host` с типом `ZOOKEEPER`:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя кластера>" {
          ...
          host {
            type      = "ZOOKEEPER"
            zone      = "<зона доступности>"
            subnet_id = yandex_vpc_subnet.<имя подсети в выбранной зоне доступности>.id
          }
          ...
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_clickhouse_cluster).

- API

  Воспользуйтесь методом [addHosts](../api-ref/Cluster/addHosts.md) и передайте в запросе:
  - Идентификатор кластера, в котором нужно разместить хост, в параметре `clusterId`. Чтобы узнать идентификатор, получите [список кластеров в каталоге](cluster-list.md#list-clusters).
  - Настройки для хоста в параметре `hostSpecs` (в том числе укажите тип `ZOOKEEPER` в параметре `hostSpecs.type`). Не указывайте настройки для нескольких хостов в этом параметре — хосты {{ ZK }} добавляются в кластер по одному, в отличие от [хостов {{ CH }}](hosts.md#add-host), которых можно добавить сразу несколько.

{% endlist %}

## Удалить хост {{ ZK }} {#delete-zk-host}

{% list tabs %}

- Консоль управления
  
  1. Перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **Хосты**.
  1. Наведите курсор на строку нужного хоста и нажмите значок ![image](../../_assets/cross.svg).
  1. Подтвердите удаление хоста.  
  
- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить хост из кластера, выполните команду:
  
  ```
  $ {{ yc-mdb-ch }} hosts delete <имя хоста> \
       --cluster-name=<имя кластера>
  ```

  Имя хоста можно запросить со [списком хостов в кластере](hosts.md#list-hosts), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform

    Чтобы удалить хост {{ ZK }} из кластера:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Удалите из описания кластера {{ mch-name }} блок `host` с типом `ZOOKEEPER`.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите удаление ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_clickhouse_cluster).

- API

  Воспользуйтесь методом [deleteHosts](../api-ref/Cluster/deleteHosts.md) и передайте в запросе:
  - Идентификатор кластера, в котором находится хост, в параметре `clusterId`. Чтобы узнать идентификатор, получите [список кластеров в каталоге](cluster-list.md#list-clusters).
  - Имя хоста в параметре `hostNames`. Чтобы узнать имя, получите [список хостов в кластере](hosts.md#list-hosts).

{% endlist %}
