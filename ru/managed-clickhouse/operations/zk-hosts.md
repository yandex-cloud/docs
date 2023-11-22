# Управление хостами {{ ZK }}

[Шарды](../concepts/sharding.md) из одного хоста не отказоустойчивы и не обеспечивают репликацию данных. Чтобы сделать такие шарды отказоустойчивыми, нужно добавить в них еще один или несколько хостов. Если в кластере уже есть шард из нескольких хостов, то можно сразу [добавлять хосты {{ CH }}](hosts.md#add-host) в нужный шард, в противном случае сначала нужно [включить отказоустойчивость](#add-zk) и только потом добавлять хосты {{ CH }}.

Подробнее см. в разделе [Шардирование](../concepts/sharding.md).

Вы можете [добавлять](#add-zk-host) и [удалять](#delete-zk-host) хосты {{ ZK }} в отказоустойчивом кластере. Всего в отказоустойчивом кластере может быть от трех до пяти хостов {{ ZK }} включительно.

{% note warning %}

Если для кластера уже включена отказоустойчивость и созданы хосты {{ ZK }}, то полностью удалить эти хосты невозможно — в кластере всегда будет минимум три хоста {{ ZK }}.

{% endnote %}

Подробнее см. в разделе [Репликация](../concepts/replication.md).

## Включить отказоустойчивость для кластера {#add-zk}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
  1. Справа сверху нажмите **{{ ui-key.yacloud.mdb.cluster.hosts.button_create-zookeeper }}**.
  1. Укажите [класс хостов](../concepts/instance-types.md).
  1. Задайте настройки хранилища.
  1. При необходимости измените настройки хостов {{ ZK }}. Чтобы это сделать, наведите курсор на строку нужного хоста и нажмите на значок ![image](../../_assets/pencil.svg).
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

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
     {{ yc-mdb-ch }} cluster add-zookeeper <имя_кластера> \
        --host zone-id={{ region-id }}-c,subnet-name=default-c \
        --host zone-id={{ region-id }}-a,subnet-name=default-a \
        --host zone-id={{ region-id }}-b,subnet-name=default-b
     ```

     Если в сети, в которой расположен кластер, ровно 3 подсети, по одной в каждой зоне доступности, то явно указывать подсети для хостов необязательно: {{ mch-name }} автоматически распределит хосты по этим подсетям.

     Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  1. Убедитесь, что в конфигурационном файле описаны три подсети — по одной для каждой зоны доступности. При необходимости добавьте недостающие:

     ```hcl
     resource "yandex_vpc_network" "<имя_сети>" {
       name = "<имя_сети>"
     }

     resource "yandex_vpc_subnet" "<имя_подсети_в_зоне_{{ region-id }}-a>" {
       name           = "<имя_подсети_в_зоне_{{ region-id }}-a>"
       zone           = "{{ region-id }}-a"
       network_id     = yandex_vpc_network.<имя_сети>.id
       v4_cidr_blocks = [ "<диапазон_адресов_подсети_в_зоне_{{ region-id }}-a>" ]
     }

     resource "yandex_vpc_subnet" "<имя_подсети_в_зоне_{{ region-id }}-b>" {
       name           = "<имя_подсети_в_зоне_{{ region-id }}-b>"
       zone           = "{{ region-id }}-b"
       network_id     = yandex_vpc_network.<имя_сети>.id
       v4_cidr_blocks = [ "<диапазон_адресов_подсети_в_зоне_{{ region-id }}-b>" ]
     }

     resource "yandex_vpc_subnet" "<имя_подсети_в_зоне_{{ region-id }}-c>" {
       name           = "<имя_подсети_в_зоне_{{ region-id }}-c>"
       zone           = "{{ region-id }}-c"
       network_id     = yandex_vpc_network.<имя_сети>.id
       v4_cidr_blocks = [ "<диапазон_адресов_подсети_в_зоне_{{ region-id }}-c>" ]
     }
     ```

  1. Добавьте к описанию кластера {{ CH }} необходимое количество блоков `host` с типом `CLICKHOUSE`.

     Требования к хостам {{ CH }}:
     * Минимальный класс хоста — `b1.medium`.
     * Если хостов больше одного, они должны размещаться в разных зонах доступности.

     При необходимости измените класс существующих хостов {{ CH }} и зоны доступности, добавьте необходимое количество новых хостов.

     ```hcl
     resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
       name = "<имя_кластера>"
       ...
       clickhouse {
         resources {
           resource_preset_id = "<класс_хоста>"
           disk_type_id       = "<тип_диска>"
           disk_size          = <размер_хранилища_ГБ>
         }
       }
       ...
       host {
         type      = "CLICKHOUSE"
         zone      = "{{ region-id }}-a"
         subnet_id = yandex_vpc_subnet.<имя_подсети_в_зоне_{{ region-id }}-a>.id
       }
       ...
     }
     ```

     Где `resource_preset_id` — класс хоста: `b1.medium` или выше.

  1. Добавьте к описанию кластера {{ CH }} не меньше трех блоков `host` с типом `ZOOKEEPER`.

     Требования к хостам {{ ZK }}:
     * В каждой зоне доступности должно быть минимум по одному хосту.
     * Минимальный класс хоста — `b1.medium`.
     * Тип диска — `{{ disk-type-example }}`.
     * Минимальный размер хранилища — 10 гигабайт.

     ```hcl
     resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
       ...
       zookeeper {
         resources {
           resource_preset_id = "<класс_хоста>"
           disk_type_id       = "{{ disk-type-example }}"
           disk_size          = <размер_хранилища_ГБ>
         }
       }
       ...
       host {
         type      = "ZOOKEEPER"
         zone      = "{{ region-id }}-a"
         subnet_id = yandex_vpc_subnet.<имя_подсети_в_зоне_{{ region-id }}-a>.id
       }
       host {
         type      = "ZOOKEEPER"
         zone      = "{{ region-id }}-b"
         subnet_id = yandex_vpc_subnet.<имя_подсети_в_зоне_{{ region-id }}-b>.id
       }
       host {
         type      = "ZOOKEEPER"
         zone      = "{{ region-id }}-c"
         subnet_id = yandex_vpc_subnet.<имя_подсети_в_зоне_{{ region-id }}-c>.id
       }
     }
     ```

     Где `resource_preset_id` — класс хоста: `b1.medium` или выше.

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mch }}).

  {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

  Чтобы включить отказоустойчивость для кластера, воспользуйтесь методом [addZookeeper](../api-ref/Cluster/addZookeeper.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/AddZookeeper](../api-ref/grpc/cluster_service.md#AddZookeeper). При добавлении укажите настройки для трех хостов {{ ZK }}, перечислив их в параметре `hostSpecs`.

{% endlist %}

{% note info %}

По умолчанию для хостов {{ ZK }} задаются следующие характеристики:
* Класс хоста `b2.medium`.
* [Хранилище](../concepts/storage.md) на сетевых SSD-дисках (`{{ disk-type-example }}`) размером 10 ГБ.

{% endnote %}

## Добавить хост {{ ZK }} {#add-zk-host}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.hosts.button_add-zookeeper }}**.
  1. При необходимости измените настройки хоста.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы добавить хост в кластер:
  1. Соберите необходимую информацию:
     * Запросите идентификатор подсети, выполнив команду:

       ```bash
       yc vpc subnet list
       ```

       
       Если нужной подсети в списке нет, [создайте ее](../../vpc/operations/subnet-create.md).


     * Запросите имя кластера со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  1. Посмотрите описание команды CLI для добавления хостов:

     ```bash
     {{ yc-mdb-ch }} host add --help
     ```

  1. Выполните команду добавления хоста {{ ZK }}:

     ```bash
     {{ yc-mdb-ch }} hosts add \
       --cluster-name <имя_кластера> \
       --host zone-id=<зона_доступности>,subnet-id=<идентификатор_подсети>,type=zookeeper
     ```

- {{ TF }}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  1. Добавьте к описанию кластера {{ mch-name }} блок `host` с типом `ZOOKEEPER`:

    ```hcl
     resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
       ...
       host {
         type      = "ZOOKEEPER"
         zone      = "<зона_доступности>"
         subnet_id = yandex_vpc_subnet.<имя_подсети_в_выбранной_зоне_доступности>.id
       }
       ...
     }
     ```

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

  Чтобы добавить хост {{ ZK }}, воспользуйтесь методом REST API [addHosts](../api-ref/Cluster/addHosts.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/AddHosts](../api-ref/grpc/cluster_service.md#AddHosts) и передайте в запросе:
  * Идентификатор кластера, в котором нужно разместить хост, в параметре `clusterId`. Чтобы узнать идентификатор, получите [список кластеров в каталоге](cluster-list.md#list-clusters).
  * Настройки для хоста в параметре `hostSpecs` (в том числе укажите тип `ZOOKEEPER` в параметре `hostSpecs.type`). Не указывайте настройки для нескольких хостов в этом параметре — хосты {{ ZK }} добавляются в кластер по одному, в отличие от [хостов {{ CH }}](hosts.md#add-host), которых можно добавить сразу несколько.

{% endlist %}

## Удалить хост {{ ZK }} {#delete-zk-host}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
  1. Наведите курсор на строку нужного хоста и нажмите на значок ![image](../../_assets/cross.svg).
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить хост из кластера, выполните команду:

  ```bash
  {{ yc-mdb-ch }} hosts delete <имя_хоста> \
    --cluster-name=<имя_кластера>
  ```

  Имя хоста можно запросить со [списком хостов в кластере](hosts.md#list-hosts), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }}

   1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
   1. Удалите из описания кластера {{ mch-name }} блок `host` с типом `ZOOKEEPER`.
   1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Введите слово `yes` и нажмите **Enter**.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

  Чтобы удалить хост {{ ZK }}, воспользуйтесь методом REST API [deleteHosts](../api-ref/Cluster/deleteHosts.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/DeleteHosts](../api-ref/grpc/cluster_service.md#DeleteHosts) и передайте в запросе:
  * Идентификатор кластера, в котором находится хост, в параметре `clusterId`. Чтобы узнать идентификатор, получите [список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя хоста в параметре `hostNames`. Чтобы узнать имя, получите [список хостов в кластере](hosts.md#list-hosts).

{% endlist %}