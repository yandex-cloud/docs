# Управление хостами {{ ZK }}


[Шарды](../concepts/sharding.md) из одного хоста не отказоустойчивы и не обеспечивают репликацию данных. Чтобы сделать такие шарды отказоустойчивыми, нужно добавить в них еще один или несколько хостов. Если в кластере уже есть шард из нескольких хостов, то можно сразу [добавлять хосты {{ CH }}](./hosts.md#add-host) в нужный шард, в противном случае сначала нужно [включить отказоустойчивость](#add-zk) и только потом добавлять хосты {{ CH }}.

Подробнее см. в разделе [{#T}](../concepts/sharding.md).

Вы можете [добавлять](#add-zk-host) и [удалять](#delete-zk-host) хосты {{ ZK }} в отказоустойчивом кластере. Всего в отказоустойчивом кластере может быть от трех до пяти хостов {{ ZK }} включительно.

{% note warning %}

Если для кластера уже включена отказоустойчивость и созданы хосты {{ ZK }}, то полностью удалить эти хосты невозможно — в кластере всегда будет минимум три хоста {{ ZK }}.

{% endnote %}

Подробнее см. в разделе [{#T}](../concepts/replication.md).

## Включить отказоустойчивость для кластера {#add-zk}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Хосты**.
  1. Справа сверху нажмите **Настроить хосты {{ ZK }}**.
  1. Укажите [класс хостов](../concepts/instance-types.md).
  1. Задайте настройки хранилища.
  1. При необходимости измените настройки хостов {{ ZK }}. Чтобы это сделать, наведите курсор на строку нужного хоста и нажмите на значок ![image](../../_assets/pencil.svg).
  1. Нажмите кнопку **Сохранить изменения**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы включить отказоустойчивость для кластера:

  1. Посмотрите описание команды CLI для добавления хостов {{ ZK }}:

     ```bash
     {{ yc-mdb-ch }} cluster add-zookeeper --help
     ```

  1. Запустите операцию с характеристиками хостов по умолчанию:

     ```bash
     {{ yc-mdb-ch }} cluster add-zookeeper <имя кластера> \
        --host zone-id={{ region-id }}-c,subnet-name=default-c \
        --host zone-id={{ region-id }}-a,subnet-name=default-a \
        --host zone-id={{ region-id }}-b,subnet-name=default-b
     ```

     Если в сети, в которой расположен кластер, ровно 3 подсети, по одной в каждой зоне доступности, то явно указывать подсети для хостов необязательно: {{ mch-name }} автоматически распределит хосты по этим подсетям. 

     Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    2. Убедитесь, что в конфигурационном файле описаны три подсети — по одной для каждой зоны доступности. При необходимости добавьте недостающие:

        ```hcl
        resource "yandex_vpc_network" "<имя сети>" {
          name = "<имя сети>"
        }

        resource "yandex_vpc_subnet" "<имя подсети в зоне {{ region-id }}-a>" {
          name           = "<имя подсети в зоне {{ region-id }}-a>"
          zone           = "{{ region-id }}-a"
          network_id     = yandex_vpc_network.<имя сети>.id
          v4_cidr_blocks = [ "<диапазон адресов подсети в зоне {{ region-id }}-a>" ]
        }

        resource "yandex_vpc_subnet" "<имя подсети в зоне {{ region-id }}-b>" {
          name           = "<имя подсети в зоне {{ region-id }}-b>"
          zone           = "{{ region-id }}-b"
          network_id     = yandex_vpc_network.<имя сети>.id
          v4_cidr_blocks = [ "<диапазон адресов подсети в зоне {{ region-id }}-b>" ]
        }

        resource "yandex_vpc_subnet" "<имя подсети в зоне {{ region-id }}-c>" {
          name           = "<имя подсети в зоне {{ region-id }}-c>"
          zone           = "{{ region-id }}-c"
          network_id     = yandex_vpc_network.<имя сети>.id
          v4_cidr_blocks = [ "<диапазон адресов подсети в зоне {{ region-id }}-c>" ]
        }
        ```

    3. Добавьте к описанию кластера {{ CH }} необходимое количество блоков `host` с типом `CLICKHOUSE`.

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
              disk_type_id       = "<тип диска>"
              disk_size          = <размер хранилища, ГБ>
            }
          }
          ...
          host {
            type      = "CLICKHOUSE"
            zone      = "{{ region-id }}-a"
            subnet_id = yandex_vpc_subnet.<имя подсети в зоне доступности {{ region-id }}-a>.id
          }
          ...
        }
        ```

    4. Добавьте к описанию кластера {{ CH }} не меньше трех блоков `host` с типом `ZOOKEEPER`.

        Требования к хостам {{ ZK }}:

        * в каждой зоне доступности должно быть минимум по одному хосту;
        * минимальный класс хоста — `b1.medium`;
        * тип диска — `{{ disk-type-example }}`;
        * минимальный размер хранилища — 10 гигабайт.

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя кластера>" {
          ...
          zookeeper {
            resources {
              resource_preset_id = "<класс хоста: b1.medium или выше>"
              disk_type_id       = "{{ disk-type-example }}"
              disk_size          = <размер хранилища, ГБ>
            }
          }
          ...
          host {
            type      = "ZOOKEEPER"
            zone      = "{{ region-id }}-a"
            subnet_id = yandex_vpc_subnet.<имя подсети в зоне доступности {{ region-id }}-a>.id
          }
          host {
            type      = "ZOOKEEPER"
            zone      = "{{ region-id }}-b"
            subnet_id = yandex_vpc_subnet.<имя подсети в зоне доступности {{ region-id }}-b>.id
          }
          host {
            type      = "ZOOKEEPER"
            zone      = "{{ region-id }}-c"
            subnet_id = yandex_vpc_subnet.<имя подсети в зоне доступности {{ region-id }}-c>.id
          }
        }
        ```

    5. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    6. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mch }}).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

  Воспользуйтесь методом [addZookeeper](../api-ref/Cluster/addZookeeper.md). При добавлении укажите настройки для трех хостов {{ ZK }}, перечислив их в параметре `hostSpecs`.

{% endlist %}

{% note info %}

По умолчанию для хостов {{ ZK }} задаются следующие характеристики:
* класс хоста `b2.medium`;
* [хранилище](../concepts/storage.md) на сетевых SSD-дисках (`{{ disk-type-example }}`) объемом 10 ГБ.

{% endnote %}

## Добавить хост {{ ZK }} {#add-zk-host}

{% list tabs %}

- Консоль управления
  
  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **Хосты**.
  1. Нажмите кнопку **Добавить хосты {{ ZK }}**.
  1. При необходимости измените настройки хоста.
  1. Нажмите кнопку **Сохранить**.
  
- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы добавить хост в кластер:
  1. Соберите необходимую информацию:
     - Запросите идентификатор подсети, выполнив команду:
       
       ```
       yc vpc subnet list
       ```

              
       Если нужной подсети в списке нет, [создайте ее](../../vpc/operations/subnet-create.md).
       

     - Запросите имя кластера со [списком кластеров в каталоге](cluster-list.md#list-clusters).
     
  1. Посмотрите описание команды CLI для добавления хостов:
  
     ```
     {{ yc-mdb-ch }} host add --help
     ```
     
  1. Выполните команду добавления хоста {{ ZK }}:
  
     ```
     {{ yc-mdb-ch }} hosts add \
        --cluster-name <имя кластера> \
        --host zone-id=<зона доступности>,subnet-id=<идентификатор подсети>,type=zookeeper
     ```

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    2. Добавьте к описанию кластера {{ mch-name }} блок `host` с типом `ZOOKEEPER`:

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

    3. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    4. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

  Воспользуйтесь методом [addHosts](../api-ref/Cluster/addHosts.md) и передайте в запросе:
  - Идентификатор кластера, в котором нужно разместить хост, в параметре `clusterId`. Чтобы узнать идентификатор, получите [список кластеров в каталоге](cluster-list.md#list-clusters).
  - Настройки для хоста в параметре `hostSpecs` (в том числе укажите тип `ZOOKEEPER` в параметре `hostSpecs.type`). Не указывайте настройки для нескольких хостов в этом параметре — хосты {{ ZK }} добавляются в кластер по одному, в отличие от [хостов {{ CH }}](hosts.md#add-host), которых можно добавить сразу несколько.

{% endlist %}

## Удалить хост {{ ZK }} {#delete-zk-host}

{% list tabs %}

- Консоль управления
  
  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **Хосты**.
  1. Наведите курсор на строку нужного хоста и нажмите на значок ![image](../../_assets/cross.svg).
  1. Подтвердите удаление хоста.  
  
- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить хост из кластера, выполните команду:
  
  ```
  {{ yc-mdb-ch }} hosts delete <имя хоста> \
     --cluster-name=<имя кластера>
  ```

  Имя хоста можно запросить со [списком хостов в кластере](hosts.md#list-hosts), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Удалите из описания кластера {{ mch-name }} блок `host` с типом `ZOOKEEPER`.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите удаление ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

  Воспользуйтесь методом [deleteHosts](../api-ref/Cluster/deleteHosts.md) и передайте в запросе:
  - Идентификатор кластера, в котором находится хост, в параметре `clusterId`. Чтобы узнать идентификатор, получите [список кластеров в каталоге](cluster-list.md#list-clusters).
  - Имя хоста в параметре `hostNames`. Чтобы узнать имя, получите [список хостов в кластере](hosts.md#list-hosts).

{% endlist %}
