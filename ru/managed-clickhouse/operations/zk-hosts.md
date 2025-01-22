---
title: Управление хостами {{ ZK }}
description: Следуя данной инструкции, вы сможете управлять хостами {{ ZK }}.
---

# Управление хостами {{ ZK }}


[Шарды](../concepts/sharding.md) из одного хоста не отказоустойчивы и не обеспечивают [репликацию данных](../concepts/replication.md). Чтобы сделать такие шарды отказоустойчивыми, нужно добавить в них еще хосты. Если в кластере уже есть шард из нескольких хостов, то можно сразу [добавлять хосты {{ CH }}](hosts.md#add-host) в нужный шард, в противном случае сначала нужно включить отказоустойчивость и только потом добавлять хосты {{ CH }}.

{% note warning %}

Если для кластера уже включена отказоустойчивость и созданы хосты {{ ZK }}, то полностью удалить эти хосты невозможно — в кластере всегда будет минимум три хоста {{ ZK }}.

{% endnote %}

Вы можете выполнить следующие действия над хостами {{ ZK }} в отказоустойчивом кластере:

* [получить список хостов в кластере](#list-hosts);
* [включить отказоустойчивость для кластера](#add-zk) с помощью хостов {{ ZK }};
* [добавить хост](#add-zk-host);
* [перезапустить хост](#restart);
* [удалить хост](#delete-zk-host).

Всего в отказоустойчивом кластере может быть от трех до пяти хостов {{ ZK }} включительно.

О том, как перенести хосты {{ ZK }} в другую зону доступности, читайте в [инструкции](host-migration.md#zookeeper-hosts).

## Получить список хостов в кластере {#list-hosts}

{% include notitle [get-hosts](../../_includes/mdb/mch/get-hosts.md) %}


## Включить отказоустойчивость для кластера {#add-zk}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
  1. Справа сверху нажмите **{{ ui-key.yacloud.mdb.cluster.hosts.button_create-zookeeper }}**.
  1. Укажите [класс хостов](../concepts/instance-types.md).
  1. Задайте настройки хранилища.
  1. При необходимости измените настройки хостов {{ ZK }}. Чтобы это сделать, наведите курсор на строку нужного хоста и нажмите на значок ![image](../../_assets/console-icons/pencil.svg).
  1. Для преобразования нереплицируемых таблиц в [реплицируемые](../concepts/replication.md#replicated-tables) включите настройку **{{ ui-key.yacloud.clickhouse.field_convert_tables_to_replicated }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

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
        --host zone-id={{ region-id }}-d,subnet-name=default-d \
        --host zone-id={{ region-id }}-a,subnet-name=default-a \
        --host zone-id={{ region-id }}-b,subnet-name=default-b
     ```

     Если в сети, в которой расположен кластер, ровно 3 подсети, по одной в каждой зоне доступности, то явно указывать подсети для хостов необязательно: {{ mch-name }} автоматически распределит хосты по этим подсетям.

     Для преобразования нереплицируемых таблиц в [реплицируемые](../concepts/replication.md#replicated-tables) добавьте в команду параметр `--convert-tables-to-replicated`.

     Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

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

     resource "yandex_vpc_subnet" "<имя_подсети_в_зоне_{{ region-id }}-d>" {
       name           = "<имя_подсети_в_зоне_{{ region-id }}-d>"
       zone           = "{{ region-id }}-d"
       network_id     = yandex_vpc_network.<имя_сети>.id
       v4_cidr_blocks = [ "<диапазон_адресов_подсети_в_зоне_{{ region-id }}-d>" ]
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
         zone      = "{{ region-id }}-d"
         subnet_id = yandex_vpc_subnet.<имя_подсети_в_зоне_{{ region-id }}-d>.id
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

- REST API {#api}

  {% include [zk-hosts-rest](../../_includes/mdb/mch/api/zk-hosts-rest.md) %}

- gRPC API {#grpc-api}

  {% include [zk-hosts-grpc](../../_includes/mdb/mch/api/zk-hosts-grpc.md) %}

{% endlist %}

{% note info %}

По умолчанию для хостов {{ ZK }} задаются следующие характеристики:
* Класс хоста `b2.medium`.
* [Хранилище](../concepts/storage.md) на сетевых SSD-дисках (`{{ disk-type-example }}`) размером 10 ГБ.

{% endnote %}

## Добавить хост {{ ZK }} {#add-zk-host}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.hosts.button_add-zookeeper }}**.
  1. При необходимости измените настройки хоста.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

- CLI {#cli}

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

- {{ TF }} {#tf}

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

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.AddHosts](../api-ref/Cluster/addHosts.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/hosts:batchCreate' \
            --data '{
                      "hostSpecs": [
                        {
                          "type": "ZOOKEEPER",
                          "zoneId": "<зона_доступности>",
                          "subnetId": "<идентификатор_подсети>",
                          "assignPublicIp": <публичный_доступ_к_хосту>
                        }
                      ]
                    }'
        ```

        Где `hostSpecs` — массив, содержащий настройки создаваемого хоста.

        {% note warning %}

        Не указывайте настройки для нескольких хостов в параметре `hostSpecs`. Хосты {{ ZK }} добавляются в кластер по одному в отличие от [хостов {{ CH }}](hosts.md#add-host), которых можно добавить сразу несколько.

        {% endnote %}

        Один элемент массива `hostSpecs` содержит настройки для одного хоста и имеет следующую структуру:

        * `type` — тип хоста `ZOOKEEPER`;
        * `zoneId` — зона доступности;
        * `subnetId` — идентификатор подсети;
        * `assignPublicIp` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/addHosts.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Воспользуйтесь вызовом [ClusterService.AddHosts](../api-ref/grpc/Cluster/addHosts.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "host_specs": [
                        {
                            "type": "ZOOKEEPER",
                            "zone_id": "<зона_доступности>",
                            "subnet_id": "<идентификатор_подсети>",
                            "assign_public_ip": <публичный_доступ_к_хосту>
                        }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.AddHosts
        ```

        Где `host_specs` — массив, содержащий настройки создаваемых хостов.

        {% note warning %}

        Не указывайте настройки для нескольких хостов в параметре `hostSpecs`. Хосты {{ ZK }} добавляются в кластер по одному в отличие от [хостов {{ CH }}](hosts.md#add-host), которых можно добавить сразу несколько.

        {% endnote %}

        Один элемент массива `host_specs` содержит настройки для одного хоста и имеет следующую структуру:

        * `type` — тип хоста `ZOOKEEPER`;
        * `zone_id` — зона доступности;
        * `subnet_id` — идентификатор подсети;
        * `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/addHosts.md#yandex.cloud.operation.Operation).

{% endlist %}

## Перезапустить хост {{ ZK }} {#restart}

{% include notitle [restart-host](../../_includes/mdb/mch/restart-host.md) %}

## Преобразовать нереплицируемые таблицы в реплицируемые {#replicated-tables}

Чтобы автоматически преобразовать нереплицируемые таблицы на движке семейства [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) в реплицируемые на движке [ReplicatedMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication/), добавьте хосты {{ ZK }} с включенным преобразованием таблиц.

Подробнее читайте в разделе [Репликация](../concepts/replication.md) и в [документации {{ CH }}]({{ ch.docs }}/development/architecture#replication).

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы преобразовать нереплицируемые таблицы в реплицируемые:

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/cube.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
  1. Справа сверху нажмите **{{ ui-key.yacloud.mdb.cluster.hosts.button_create-zookeeper }}**.
  1. [Добавьте хосты {{ ZK }}](#add-zk-host).

     На странице добавления хостов по умолчанию включена опция **{{ ui-key.yacloud.clickhouse.field_convert_tables_to_replicated }}**.

  1. Чтобы оставить таблицы нереплицируемыми, отключите опцию **{{ ui-key.yacloud.clickhouse.field_convert_tables_to_replicated }}**. Чтобы включить поддержку реплицируемых таблиц, оставьте опцию включенной.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы преобразовать нереплицируемые таблицы в реплицируемые, выполните команду:

  ```bash
  {{ yc-mdb-ch }} cluster add-zookeeper \
     --name <имя_кластера> \
     --resource-preset <класс_хостов> \
     --disk-size <размер_хранилища_ГБ> \
     --disk-type <тип_диска> \
     --host zone-id=<зона_доступности>,subnet-name=<имя_подсети> \
     --host <аналогичный_набор_настроек_для_создаваемого_хоста_2> \
     --host ... \
     --host <аналогичный_набор_настроек_для_создаваемого_хоста_N> \
     --convert-tables-to-replicated
  ```

  В команде укажите не меньше трех параметров `--host`, так как в кластере должно быть минимум три хоста {{ ZK }}.

  Параметр `--convert-tables-to-replicated` включает преобразование нереплицируемых таблиц на движке семейства `MergeTree` в реплицируемые на движке семейства `ReplicatedMergeTree`.

- REST API {#api}

  {% include [zk-hosts-rest](../../_includes/mdb/mch/api/zk-hosts-rest.md) %}

- gRPC API {#grpc-api}

  {% include [zk-hosts-grpc](../../_includes/mdb/mch/api/zk-hosts-grpc.md) %}

{% endlist %}

## Удалить хост {{ ZK }} {#delete-zk-host}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
  1. Наведите курсор на строку нужного хоста и нажмите на значок ![image](../../_assets/console-icons/xmark.svg).
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить хост из кластера, выполните команду:

  ```bash
  {{ yc-mdb-ch }} hosts delete <имя_хоста> \
    --cluster-name=<имя_кластера>
  ```

  Имя хоста можно запросить со [списком хостов в кластере](hosts.md#list-hosts), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

   1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
   1. Удалите из описания кластера {{ mch-name }} блок `host` с типом `ZOOKEEPER`.
   1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Введите слово `yes` и нажмите **Enter**.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

  {% include [zk-hosts-rest](../../_includes/mdb/mch/api/delete-zk-hosts-rest.md) %}

- gRPC API {#grpc-api}

  {% include [zk-hosts-grpc](../../_includes/mdb/mch/api/delete-zk-hosts-grpc.md) %}

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}