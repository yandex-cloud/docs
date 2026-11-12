---
title: Изменение сервиса координации с {{ ZK }} на {{ CK }} на отдельных хостах
description: Как перейти с сервиса координации {{ ZK }} на {{ CK }} на отдельных хостах в {{ mch-full-name }}.
---


# Изменение сервиса координации с {{ ZK }} на {{ CK }} на отдельных хостах

Вы можете перейти с [сервиса координации](../concepts/coordination-system.md) {{ ZK }} на {{ CK }} на отдельных хостах. Обратный переход с {{ CK }} на {{ ZK }} не поддерживается.

{% note warning %}

* На время выполнения операции кластер будет работать в режиме read-only.

* Хосты {{ CK }} учитываются в расчете использованной [квоты ресурсов]({{ link-console-quotas }}) в облаке и в [расчете стоимости](../pricing.md) кластера.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить сервис координации с {{ ZK }} на {{ CK }}:

  1. Посмотрите описание команды:

      ```bash
      {{ yc-mdb-ch }} cluster migrate-to-keeper --help
      ```

  1. Измените сервис координации:

      
      ```bash
      {{ yc-mdb-ch }} cluster migrate-to-keeper <имя_или_идентификатор_кластера> \
         --resource-preset <класс_хоста> \
         --disk-type <тип_диска> \
         --disk-size <размер_хранилища_ГБ> \
         --host zone-id=<зона_доступности>,`
               `subnet-id=<идентификатор_подсети> \
         --allow-degradation-to-read-only
      ```


      Где:

      * `<имя_или_идентификатор_кластера>` — имя или идентификатор кластера, которые можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
      * `--resource-preset` — [класс хоста](../concepts/instance-types.md).
      * `--disk-type` — [тип диска](../concepts/storage.md).
      * `--disk-size` — размер хранилища в гигабайтах.

      
      * `--host` — настройки хоста. Параметр задается для каждого хоста отдельно и имеет следующую структуру:

        * `zone-id` — [зона доступности](../../overview/concepts/geo-scope.md).
        * `subnet-id` — идентификатор [подсети](../../vpc/concepts/network.md#subnet).


      * `--allow-degradation-to-read-only` — переход кластера в режим read-only на время изменения сервиса координации. Обязательный параметр.


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  Чтобы изменить сервис координации с {{ ZK }} на {{ CK }}:

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, в разделе [Создание кластера](cluster-create.md).

  1. В описание ресурса кластера внесите следующие изменения:

      * Добавьте параметр `allow_degradation_to_read_only = true`, чтобы разрешить переход кластера в режим read-only на время изменения сервиса координации. Иначе операция не будет выполнена.
      * Замените хосты {{ ZK }} на хосты {{ CK }}.
      * Измените конфигурацию хостов в блоке `zookeeper.resources`.

      Пример конфигурационного файла:

      ```hcl
      resource "yandex_mdb_clickhouse_cluster_v2" "<локальное_имя_кластера>" {
        ...

        allow_degradation_to_read_only = true

        zookeeper = {
          resources = {
            resource_preset_id = "<класс_хоста>"
            disk_type_id       = "<тип_диска>"
            disk_size          = <размер_хранилища_ГБ>
          }
        }

        hosts = {
          ...
          <имя_хоста_1> = {
            type      = "KEEPER"
            zone      = "{{ region-id }}-a"
            subnet_id = yandex_vpc_subnet.<имя_подсети_в_зоне_{{ region-id }}-a>.id
          }

          <имя_хоста_2> = {
            type      = "KEEPER"
            zone      = "{{ region-id }}-b"
            subnet_id = yandex_vpc_subnet.<имя_подсети_в_зоне_{{ region-id }}-b>.id
          }

          <имя_хоста_3> = {
            type      = "KEEPER"
            zone      = "{{ region-id }}-d"
            subnet_id = yandex_vpc_subnet.<имя_подсети_в_зоне_{{ region-id }}-d>.id
          }
        }
      }
      ```

      Подробнее о ресурсе в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster_v2).

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}


- REST API {#api}

  Чтобы изменить сервис координации с {{ ZK }} на {{ CK }}:

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.MigrateToKeeper](../api-ref/Cluster/migrateToKeeper.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      1. Создайте файл `body.json` и добавьте в него следующее содержимое:

          
          ```json
          {
            "resources": {
              "resourcePresetId": "<класс_хоста>",
              "diskSize": "<размер_хранилища_в_байтах>",
              "diskTypeId": "<тип_диска>"
            },
            "hostSpecs": [
              {
                "type": "KEEPER",
                "zoneId": "<зона_доступности>",
                "subnetId": "<идентификатор_подсети>"
              }
            ],
            "allowDegradationToReadOnly": true
          }
          ```


          Где:

          * `resources` — конфигурация хостов:

            * `resourcePresetId` — [класс хоста](../concepts/instance-types.md). Список доступных классов хостов можно получить с помощью метода [ResourcePreset.list](../api-ref/ResourcePreset/list.md).
            * `diskSize` — размер хранилища в байтах.
            * `diskTypeId` — [тип диска](../concepts/storage.md).

          * `hostSpecs` — настройки хостов в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

            * `type` — тип хоста: `KEEPER`.
            * `zoneId` — [зона доступности](../../overview/concepts/geo-scope.md).
            
            
            * `subnetId` — идентификатор [подсети](../../vpc/concepts/network.md#subnet).


          * `allowDegradationToReadOnly` — переход кластера в режим read-only на время изменения сервиса координации: `true`. Обязательный параметр.

      1. Выполните запрос:

          ```bash
          curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>:migrateToKeeper' \
            --data '@body.json'
          ```

          Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/migrateToKeeper.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}
  
  Чтобы изменить сервис координации с {{ ZK }} на {{ CK }}:

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Воспользуйтесь вызовом [ClusterService.MigrateToKeeper](../api-ref/grpc/Cluster/migrateToKeeper.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

      1. Создайте файл `body.json` и добавьте в него следующее содержимое:

          
          ```json
          {
            "cluster_id": "<идентификатор_кластера>",
            "resources": {
              "resource_preset_id": "<класс_хоста>",
              "disk_size": "<размер_хранилища_в_байтах>",
              "disk_type_id": "<тип_диска>"
            },
            "host_specs": [
              {
                "type": "KEEPER",
                "zone_id": "<зона_доступности>",
                "subnet_id": "<идентификатор_подсети>"
              }
            ],
            "allow_degradation_to_read_only": true
          }
          ```


          Где:

          * `cluster_id` — идентификатор кластера, который можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
          * `resources` — конфигурация хостов:

            * `resource_preset_id` — [класс хоста](../concepts/instance-types.md). Список доступных классов хостов с их идентификаторами можно запросить с помощью метода [ResourcePresetService.List](../api-ref/grpc/ResourcePreset/list.md).
            * `disk_size` — размер хранилища в байтах.
            * `disk_type_id` — [тип диска](../concepts/storage.md).

          * `host_specs` — настройки хостов в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

            * `type` — тип хоста: `KEEPER`.
            * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md).

            
            * `subnet_id` — идентификатор [подсети](../../vpc/concepts/network.md#subnet).


          * `allow_degradation_to_read_only` — переход кластера в режим read-only на время изменения сервиса координации: `true`. Обязательный параметр.

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
            yandex.cloud.mdb.clickhouse.v1.ClusterService.MigrateToKeeper \
            < body.json
          ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/migrateToKeeper.md#yandex.cloud.operation.Operation).

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
