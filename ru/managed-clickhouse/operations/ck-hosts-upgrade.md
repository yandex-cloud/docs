---
title: Изменение сервиса координации со встроенного {{ CK }} на {{ CK }} на отдельных хостах
description: Следуя данной инструкции, вы сможете изменить сервис координации со встроенного {{ CK }} на {{ CK }} на отдельных хостах.
---

# Изменение сервиса координации со встроенного {{ CK }} на {{ CK }} на отдельных хостах

Если в качестве сервиса координации используется встроенный {{ CK }}, вы можете изменить его на {{ CK }} на отдельных хостах. После включения {{ CK }} на отдельных хостах его нельзя выключить или переключить обратно на встроенный {{ CK }}.

{% note warning %}

Хосты {{ CK }} учитываются в расчете использованной [квоты ресурсов]({{ link-console-quotas }}) в облаке и в [расчете стоимости](../pricing.md) кластера.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить сервис координации:

  1. Посмотрите описание команды:

      ```bash
      {{ yc-mdb-ch }} cluster add-zookeeper --help
      ```

  1. Укажите параметры хоста в команде:

      
      ```bash
      {{ yc-mdb-ch }} cluster add-zookeeper \
        --name <имя_кластера> \
        --resource-preset <класс_хоста> \
        --disk-type <тип_диска> \
        --disk-size <размер_хранилища> \
        --host type=keeper,`
              `zone-id=<зона_доступности>,`
              `subnet-id=<идентификатор_подсети> \
        --convert-tables-to-replicated <конвертировать_таблицы>
      ```


      Где:

      * `--resource-preset` — [класс хоста](../concepts/instance-types.md).
      * `--disk-type` — [тип диска](../concepts/storage.md).
      * `--disk-size` — размер хранилища в байтах.

      * `--host` — параметры хоста:
        * `type` — тип хоста: `keeper`.
        * `zone-id` — [зона доступности](../../overview/concepts/geo-scope.md).

        
        * `subnet-id` — идентификатор подсети. Его необходимо указывать, если в выбранной зоне доступности создано две и более подсетей.


        Вы можете добавить сразу несколько хостов. Для каждого хоста необходимо указать отдельный флаг `--host`.

      * `--convert-tables-to-replicated` — преобразовать нереплицируемые таблицы в [реплицируемые](../concepts/replication.md#replicated-tables).

      Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

    Чтобы изменить сервис координации:

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.AddZookeeper](../api-ref/Cluster/addZookeeper.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        1. Создайте файл `body.json` и добавьте в него следующее содержимое:

            
            ```json
            {
              "resources": {
                "resourcePresetId": "<класс_хоста>",
                "diskSize": "<размер_хранилища>",
                "diskTypeId": "<тип_диска>"
              },
              "hostSpecs": [
                {
                  "zoneId": "<зона_доступности>",
                  "type": "KEEPER",
                  "subnetId": "<идентификатор_подсети>"
                }
              ],
              "convertTablesToReplicated": <конвертировать_таблицы>
            }
            ```


            Где:

            * `resources` — конфигурация хоста:

               * `resourcePresetId` — идентификатор [класса хостов](../concepts/instance-types.md). Список доступных классов хостов с их идентификаторами можно запросить с помощью метода [ResourcePreset.list](../api-ref/ResourcePreset/list.md).
               * `diskSize` — размер хранилища в байтах.
               * `diskTypeId` — [тип диска](../concepts/storage.md).

            * `hostSpecs` — настройки хостов в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

                * `zoneId` — [зона доступности](../../overview/concepts/geo-scope.md).
                * `type` — тип хоста: `KEEPER`.

                
                * `subnetId` — идентификатор [подсети](../../vpc/concepts/network.md#subnet).


            * `convertTablesToReplicated` — преобразовать нереплицируемые таблицы в [реплицируемые](../concepts/replication.md#replicated-tables).

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        1. Выполните запрос:

            ```bash
            curl \
              --request POST \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>:addZookeeper' \
              --data '@body.json'
            ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/addZookeeper.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    Чтобы изменить сервис координации:

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService.AddZookeeper](../api-ref/grpc/Cluster/addZookeeper.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        1. Создайте файл `body.json` и добавьте в него следующее содержимое:

            
            ```json
            {
              "cluster_id": "<идентификатор_кластера>",
              "resources": {
                "resource_preset_id": "<класс_хоста>",
                "disk_size": "<размер_хранилища>",
                "disk_type_id": "<тип_диска>"
              },
              "host_specs": [
                {
                  "zone_id": "<зона_доступности>",
                  "type": "KEEPER",
                  "subnet_id": "<идентификатор_подсети>",
                }
              ],
              "convert_tables_to_replicated": <конвертировать_таблицы>
            }
            ```


            Где:

            * `resources` — конфигурация хоста:

               * `resource_preset_id` — идентификатор [класса хостов](../concepts/instance-types.md). Список доступных классов хостов с их идентификаторами можно запросить с помощью метода [ResourcePresetService.List](../api-ref/grpc/ResourcePreset/list.md).
               * `disk_size` — размер хранилища в байтах.
               * `disk_type_id` — [тип диска](../concepts/storage.md).

            * `host_specs` — настройки хостов в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

                * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md).
                * `type` — тип хоста: `KEEPER`.

                
                * `subnet_id` — идентификатор [подсети](../../vpc/concepts/network.md#subnet).


            * `convertTablesToReplicated` — преобразовать нереплицируемые таблицы в [реплицируемые](../concepts/replication.md#replicated-tables).

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        1. Выполните запрос:

            ```bash
            grpcurl \
              -format json \
              -import-path ~/cloudapi/ \
              -import-path ~/cloudapi/third_party/googleapis/ \
              -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
              -rpc-header "Authorization: Bearer $IAM_TOKEN" \
              -d @ \
              {{ api-host-mdb }}:{{ port-https }} \
              yandex.cloud.mdb.clickhouse.v1.ClusterService.addZookeeper \
              < body.json
            ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/addZookeeper.md#yandex.cloud.operation.Operation).

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
