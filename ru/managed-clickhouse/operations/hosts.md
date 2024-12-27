---
title: Управление хостами {{ CH }}
description: 'Следуя данной инструкции, вы сможете управлять хостами кластера {{ CH }}: получать список хостов в кластере, создавать хост, изменять настройки {{ CH }} для хоста, перезапускать хост, удалять хост.'
---

# Управление хостами {{ CH }}

Вы можете выполнить следующие действия над хостами {{ CH }}:

* [получить список хостов в кластере](#list-hosts);
* [создать хост](#add-host);
* [изменить настройки {{ CH }} для хоста](#update);
* [перезапустить хост](#restart);
* [удалить хост](#remove-host).

О том, как перенести хосты {{ CH }} в другую [зону доступности](../../overview/concepts/geo-scope.md), читайте в [инструкции](host-migration.md#clickhouse-hosts).

{% note warning %}

Если вы создали кластер без поддержки [{{ CK }}](../concepts/replication.md#ck), то прежде чем добавлять новые хосты в любой из [шардов](../concepts/sharding.md), [включите отказоустойчивость](zk-hosts.md#add-zk) с использованием хостов {{ ZK }}.

{% endnote %}

## Получить список хостов в кластере {#list-hosts}

{% include notitle [get-hosts](../../_includes/mdb/mch/get-hosts.md) %}

## Создать хост {#add-host}

Количество хостов в кластерах {{ mch-name }} ограничено квотами на количество CPU и объем памяти, которые доступны кластерам БД в вашем облаке. Чтобы проверить используемые ресурсы, откройте страницу [Квоты]({{ link-console-quotas }}) и найдите блок **{{ ui-key.yacloud.iam.folder.dashboard.label_mdb }}**.

С помощью CLI, {{ TF }} и API можно создать сразу несколько хостов в кластере.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}**.


  1. Укажите параметры хоста:
     * Зону доступности.
     * Подсеть (если нужной подсети в списке нет, [создайте ее](../../vpc/operations/subnet-create.md)).
     * Выберите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**, если хост должен быть доступен извне {{ yandex-cloud }}.
     * Имя шарда.
     * Выберите опцию **{{ ui-key.yacloud.clickhouse.hosts.dialog.field_copy_schema }}**, чтобы скопировать схему со случайной реплики на новый хост.


- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать один или несколько хостов:


  1. Запросите список подсетей кластера, чтобы выбрать подсеть для нового хоста:

     ```bash
     yc vpc subnet list
     ```

     Результат:

     ```text
     +-----------+-----------+------------+---------------+------------------+
     |     ID    |   NAME    | NETWORK ID |     ZONE      |      RANGE       |
     +-----------+-----------+------------+---------------+------------------+
     | b0cl69... | default-d | enp6rq7... | {{ region-id }}-d | [172.16.0.0/20]  |
     | e2lkj9... | default-b | enp6rq7... | {{ region-id }}-b | [10.10.0.0/16]   |
     | e9b0ph... | a-2       | enp6rq7... | {{ region-id }}-a | [172.16.32.0/20] |
     | e9b9v2... | default-a | enp6rq7... | {{ region-id }}-a | [172.16.16.0/20] |
     +-----------+-----------+------------+---------------+------------------+
     ```

     Если нужной подсети в списке нет, [создайте ее](../../vpc/operations/subnet-create.md).


  1. Посмотрите описание команды CLI для создания хостов:

     ```bash
     {{ yc-mdb-ch }} hosts add --help
     ```

  1. Выполните команду создания хостов.

     Укажите в команде один или несколько параметров `--host`: по одному параметру на каждый хост, который нужно создать.

     Команда для создания одного хоста имеет вид:


     ```bash
     {{ yc-mdb-ch }} hosts add \
       --cluster-name=<имя_кластера> \
       --host zone-id=<зона_доступности>,`
         `subnet-id=<идентификатор_подсети>,`
         `assign-public-ip=<публичный_доступ_к_хосту>,`
         `shard-name=<имя_шарда>,`
         `type=clickhouse
     ```

     Где `assign-public-ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.


     Чтобы скопировать схему данных со случайной реплики на новый хост, укажите необязательный параметр `--copy-schema`.

     {{ mch-name }} запустит операцию создания хостов.


     Идентификатор подсети необходимо указать, если в зоне доступности больше одной подсети, в противном случае {{ mch-name }} автоматически выберет единственную подсеть. Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).


- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  1. Добавьте к описанию кластера {{ mch-name }} один или несколько блоков `host`: по одному блоку на каждый хост, который нужно создать.

     Единичный блок `host` имеет вид:

     ```hcl
     resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
       ...
       host {
         type             = "CLICKHOUSE"
         zone             = "<зона_доступности>"
         subnet_id        = "<идентификатор_подсети>"
         assign_public_ip = <публичный_доступ_к_хосту>
       }
     }
     ```

     Где `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.

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
                          "type": "CLICKHOUSE",
                          "zoneId": "<зона_доступности>",
                          "subnetId": "<идентификатор_подсети>",
                          "shardName": "<имя_шарда>",
                          "assignPublicIp": <публичный_доступ_к_хосту>
                        },
                        { <аналогичный_набор_настроек_для_создаваемого_хоста_2> },
                        { ... },
                        { <аналогичный_набор_настроек_для_создаваемого_хоста_N> }
                      ],
                      "copySchema": <копирование_схемы_данных>
                    }'
        ```

        Где:

        * `hostSpecs` — массив, содержащий настройки создаваемых хостов. Один элемент массива содержит настройки для одного хоста и имеет следующую структуру:

            * `type` — тип хоста, всегда `CLICKHOUSE` для хостов {{ CH }}.
            * `zoneId` — зона доступности.
            * `subnetId` — идентификатор подсети.
            * `shardName` — имя шарда.
            * `assignPublicIp` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.

        * `copySchema` — параметр, который определяет, копировать ли схему данных со случайной реплики на создаваемые хосты: `true` или `false`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

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
                            "type": "CLICKHOUSE",
                            "zone_id": "<зона_доступности>",
                            "subnet_id": "<идентификатор_подсети>",
                            "shard_name": "<имя_шарда>",
                            "assign_public_ip": <публичный_доступ_к_хосту>
                        },
                        { <аналогичный_набор_настроек_для_создаваемого_хоста_2> },
                        { ... },
                        { <аналогичный_набор_настроек_для_создаваемого_хоста_N> }
                    ],
                    "copy_schema": <копировать_ли_схему_данных>
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.AddHosts
        ```

        Где:

        * `host_specs` — массив, содержащий настройки создаваемых хостов. Один элемент массива содержит настройки для одного хоста и имеет следующую структуру:

            * `type` — тип хоста, всегда `CLICKHOUSE` для хостов {{ CH }}.
            * `zone_id` — зона доступности.
            * `subnet_id` — идентификатор подсети.
            * `shard_name` — имя шарда.
            * `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.

        * `copy_schema` — параметр, который определяет, копировать ли схему данных со случайной реплики на создаваемые хосты: `true` или `false`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/addHosts.md#yandex.cloud.operation.Operation).

{% endlist %}

{% note warning %}


Если после создания хоста к нему невозможно [подключиться](connect/clients.md), убедитесь, что [группа безопасности](../concepts/network.md#security-groups) кластера настроена корректно для подсети, в которую помещен хост.


Используйте опцию копирования схемы данных только в том случае, когда схема одинакова на всех хостах-репликах кластера.

{% endnote %}

## Изменить хост {#update}

Для каждого хоста в кластере {{ mch-name }} можно изменить настройки публичного доступа.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить параметры хоста в кластере:
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного хоста и выберите пункт **{{ ui-key.yacloud.common.edit }}**.
  1. Включите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**, если хост должен быть доступен извне {{ yandex-cloud }}.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить параметры хоста, выполните команду:

  ```bash
  {{ yc-mdb-ch }} host update <имя_хоста> \
    --cluster-name=<имя_кластера> \
    --assign-public-ip=<публичный_доступ_к_хосту>
  ```

  Где `assign-public-ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.

  Имя хоста можно запросить со [списком хостов в кластере](#list-hosts), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

  1. В блоке `host` нужного хоста добавьте параметр `assign_public_ip` или измените его значение.

     ```hcl
     resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
       ...
       host {
         ...
         assign_public_ip = <публичный_доступ_к_хосту>
       }
       ...
     }
     ```

     Где `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mch }}).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.UpdateHosts](../api-ref/Cluster/updateHosts.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/hosts:batchUpdate' \
            --data '{
                      "updateHostSpecs": [
                        {
                          "hostName": "<имя_хоста>",
                          "updateMask": "assignPublicIp",
                          "assignPublicIp": <публичный_доступ_к_хосту>
                        }
                      ]
                    }'
        ```

        Где `updateHostSpecs[]` — перечень хостов, которые надо изменить, и их параметров. Структура отдельного элемента:

        * `hostName` — имя хоста, которое можно запросить со [списком хостов в кластере](#list-hosts).
        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            В данном случае указан только один параметр: `assignPublicIp`.

        * `assignPublicIp` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/updateHosts.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService.UpdateHosts](../api-ref/grpc/Cluster/updateHosts.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "update_host_specs": [
                    {
                        "host_name": "<имя_хоста>",
                        "update_mask": {
                            "paths": [
                                "assign_public_ip"
                            ]
                        },
                        "assign_public_ip": <публичный_доступ_к_хосту>
                    }]
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.UpdateHosts
        ```

        Где `update_host_specs[]` — перечень хостов, которые надо изменить, и их параметров. Структура отдельного элемента:

        * `host_name` — имя хоста, которое можно запросить со [списком хостов в кластере](#list-hosts).
        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            В данном случае указан только один параметр: `assign_public_ip`.

        * `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/updateHosts.md#yandex.cloud.operation.Operation).

{% endlist %}


{% note warning %}

Если после изменения хоста к нему невозможно [подключиться](connect/clients.md), убедитесь, что [группа безопасности](../concepts/network.md#security-groups) кластера настроена корректно для подсети, в которую помещен хост.

{% endnote %}


## Перезапустить хост {#restart}

{% include notitle [restart-host](../../_includes/mdb/mch/restart-host.md) %}

## Удалить хост {#remove-host}

С помощью CLI, {{ TF }} и API можно удалить сразу несколько хостов из кластера.

{% note warning %}

Нельзя удалить хост из кластера или шарда, если достигнут [соответствующий лимит на минимальное количество хостов](../concepts/limits.md#mch-limits).

Нельзя удалить хосты, на которых размещается [{{ CK }}](../concepts/replication.md#ck), если при создании кластера была включена поддержка этого механизма репликации.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного хоста и выберите пункт **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить один или несколько хостов из кластера, выполните команду, передав нужные имена хостов. Используйте пробел в качестве разделителя.

  Команда для удаления одного хоста имеет вид:

  ```bash
  {{ yc-mdb-ch }} hosts delete --cluster-name=<имя_кластера> \
    <имя_хоста>
     
  ```

  Имена хостов можно запросить со [списком хостов в кластере](#list-hosts), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  1. Удалите из описания кластера {{ mch-name }} один или несколько блоков `host` с типом `CLICKHOUSE`.
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
