# Управление шардами в кластере {{ CH }}

Вы можете включить шардирование для кластера, а также добавлять и настраивать отдельные шарды.

## Включить шардирование {#enable}

Кластеры {{ mch-name }} создаются с одним шардом. Чтобы начать непосредственно шардирование данных, [добавьте](#add-shard) еще один или несколько шардов и [создайте](../tutorials/sharding.md#example) распределенную таблицу.

## Создать шард {#add-shard}

Количество шардов в кластерах {{ mch-name }} ограничено квотами на количество CPU и объем памяти, которые доступны кластерам БД в вашем облаке. Чтобы проверить используемые ресурсы, откройте страницу [Квоты]({{ link-console-quotas }}) и найдите блок **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_shards }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.shards.action_add-shard }}**.
  1. Укажите параметры шарда:
     * Имя и вес.
     * Чтобы скопировать схему со случайной реплики одного из шардов на хосты нового шарда, выберите опцию **{{ ui-key.yacloud.mdb.forms.field_copy_schema }}**.
     * Нужное количество хостов.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create-shard }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать шард, выполните команду (в примере приведены не все доступные параметры):

  ```bash
  {{ yc-mdb-ch }} shards add <имя_нового_шарда> \
    --cluster-name=<имя_кластера> \
    --host zone-id=<зона_доступности>,`
      `subnet-name=<имя_подсети>
  ```

  Где:

  
  * `<имя_нового_шарда>` — должно быть уникальным в кластере.

    Может содержать латинские буквы, цифры, дефис и подчеркивание. Максимальная длина — 63 символа.
  * `--cluster-name` — имя кластера.

    Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  * `--host` — параметры хоста:
    * `zone-id` — [зона доступности](../../overview/concepts/geo-scope.md).
    * `subnet-name` — [имя подсети](../../vpc/concepts/network.md#subnet).


- {{ TF }} {#tf}

  {% note info %}

  {{ TF }} не позволяет указывать вес шардов.

  {% endnote %}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  1. Добавьте к описанию кластера {{ mch-name }} блок `host` типа `CLICKHOUSE` с заполненным полем `shard_name` или измените существующие хосты:

     ```hcl
     resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
       ...
       host {
         type       = "CLICKHOUSE"
         zone       = "<зона_доступности>"
         subnet_id  = yandex_vpc_subnet.<подсеть_в_зоне_доступности>.id
         shard_name = "<имя_шарда>"
       }
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

  1. Воспользуйтесь методом [Cluster.AddShard](../api-ref/Cluster/addShard.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "shardName": "<имя_шарда>",
          "configSpec": {
            "clickhouse": {
              "resources": {
                "resourcePresetId": "<класс_хостов>",
                "diskSize": "<размер_хранилища_в_байтах>",
                "diskTypeId": "<тип_диска>"
              },
              "weight": "<вес_шарда>"
            }
          },
          "hostSpecs": [
            {
              "zoneId": "<зона_доступности>",
              "type": "CLICKHOUSE",
              "subnetId": "<идентификатор_подсети>",
              "assignPublicIp": <публичный_доступ_к_хосту>,
              "shardName": "<имя_шарда>"
            }
          ],
          "copySchema": <копирование_схемы_данных>
        }
        ```

        Где:

        * `shardName` — имя шарда.
        * `configSpec.clickhouse.resources` — ресурсы хостов, которые добавляются в создаваемый шард:

          * `resourcePresetId` — идентификатор [класса хостов](../concepts/instance-types.md). Список доступных классов хостов с их идентификаторами можно запросить с помощью метода [ResourcePreset.List](../api-ref/ResourcePreset/list.md).
          * `diskSize` — размер диска в байтах.
          * `diskTypeId` — [тип диска](../concepts/storage.md).

        * `configSpec.clickhouse.weight` — вес шарда.

          По умолчанию каждому шарду назначается вес `1`. Если какому-либо шарду назначить вес больше, данные будут распределены между шардами в соответствии с весами.

          При расчете приоритета шарда при распределении данных складываются веса всех шардов, далее вес каждого шарда делится на полученную сумму. Например, если у одного шарда вес `1`, а у другого — `3`, то у первого шарда приоритет `1/4`, а у второго — `3/4`. Чем выше приоритет, тем больше данных окажется на шарде.

          Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/engines/table-engines/special/distributed).

        * `hostSpecs` — настройки хостов, которые будут добавлены в шард. Настройки представлены в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

          * `zoneId` — зона доступности.
          * `type` — тип хоста. В шарды добавляются только хосты `CLICKHOUSE`.
          * `subnetId` — идентификатор подсети.
          * `assignPublicIp` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.
          * `shardName` — имя шарда.

        * `copySchema` — копирование схемы данных со случайной реплики одного из шардов на хосты нового шарда. Возможные значения: `true` или `false`.

     1. Выполните запрос:

        ```bash
        curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/shards' \
          --data '@body.json'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/addShard.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService.AddShard](../api-ref/grpc/Cluster/addShard.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "cluster_id": "<идентификатор_кластера>",
          "shard_name": "<имя_шарда>",
          "config_spec": {
            "clickhouse": {
              "resources": {
                "resource_preset_id": "<класс_хостов>",
                "disk_size": "<размер_хранилища_в_байтах>",
                "disk_type_id": "<тип_диска>"
              },
              "weight": "<вес_шарда>"
            }
          },
          "host_specs": [
            {
              "zone_id": "<зона_доступности>",
              "type": "CLICKHOUSE",
              "subnet_id": "<идентификатор_подсети>",
              "assign_public_ip": <публичный_доступ_к_хосту>,
              "shard_name": "<имя_шарда>"
            }
          ],
          "copy_schema": <копирование_схемы_данных>
        }
        ```

        Где:

        * `shard_name` — имя шарда.
        * `config_spec.clickhouse.resources` — ресурсы хостов, которые добавляются в создаваемый шард:

          * `resource_preset_id` — идентификатор [класса хостов](../concepts/instance-types.md). Список доступных классов хостов с их идентификаторами можно запросить с помощью метода [ResourcePresetService.List](../api-ref/grpc/ResourcePreset/list.md).
          * `disk_size` — размер диска в байтах.
          * `disk_type_id` — [тип диска](../concepts/storage.md).

        * `config_spec.clickhouse.weight` — вес шарда.

          По умолчанию каждому шарду назначается вес `1`. Если какому-либо шарду назначить вес больше, данные будут распределены между шардами в соответствии с весами.

          При расчете приоритета шарда при распределении данных складываются веса всех шардов, далее вес каждого шарда делится на полученную сумму. Например, если у одного шарда вес `1`, а у другого — `3`, то у первого шарда приоритет `1/4`, а у второго — `3/4`. Чем выше приоритет, тем больше данных окажется на шарде.

          Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/engines/table-engines/special/distributed).

        * `host_specs` — настройки хостов, которые будут добавлены в шард. Настройки представлены в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

          * `zone_id` — зона доступности.
          * `type` — тип хоста. В шарды добавляются только хосты `CLICKHOUSE`.
          * `subnet_id` — идентификатор подсети.
          * `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.
          * `shard_name` — имя шарда.

        * `copy_schema` — копирование схемы данных со случайной реплики одного из шардов на хосты нового шарда. Возможные значения: `true` или `false`.

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
          yandex.cloud.mdb.clickhouse.v1.ClusterService.AddShard \
          < body.json
        ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/addShard.md#yandex.cloud.operation.Operation).

{% endlist %}

{% note warning %}

Используйте опцию копирования схемы данных только в том случае, когда схема одинакова на всех шардах кластера.

{% endnote %}

## Получить список шардов в кластере {#list-shards}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_shards }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список шардов в кластере, выполните команду:

  ```bash
  {{ yc-mdb-ch }} shards list --cluster-name=<имя_кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.ListShards](../api-ref/Cluster/listShards.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/shards'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listShards.md#yandex.cloud.mdb.clickhouse.v1.ListClusterShardsResponse).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService.ListShards](../api-ref/grpc/Cluster/listShards.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
               "cluster_id": "<идентификатор_кластера>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.clickhouse.v1.ClusterService.ListShards
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listShards.md#yandex.cloud.mdb.clickhouse.v1.ListClusterShardsResponse).

{% endlist %}

## Изменить шард {#shard-update}

Вы можете изменить вес шарда, а также [класс хоста](../concepts/instance-types.md) и размер хранилища.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_shards }}**.
  1. Нажмите ![horizontal-ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить шард в кластере:
  1. Посмотрите описание команды CLI для изменения шарда:

     ```bash
     {{ yc-mdb-ch }} shards update --help
     ```

  1. Запустите операцию, например, изменения веса для шарда:

     ```bash
     {{ yc-mdb-ch }} shards update <имя_шарда> \
       --cluster-name=<имя_кластера> \
       --weight=<вес_шарда>
     ```

     Где:
     * `<имя_шарда>` — можно запросить со [списком шардов в кластере](#list-shards).
     * `--cluster-name` — имя кластера.

       Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
     * `--weight` — вес шарда. Минимальное значение — `0`.

     После успешного завершения операции CLI выведет информацию об измененном шарде.

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.UpdateShard](../api-ref/Cluster/updateShard.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
         --request PATCH \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --header "Content-Type: application/json" \
         --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/shards/<имя_шарда>' \
         --data '{
                   "updateMask": "configSpec.clickhouse.config.<настройка_{{ CH }}>,configSpec.clickhouse.resources,configSpec.clickhouse.weight",
                   "configSpec": {
                     "clickhouse": {
                       "config": {
                         <настройки_{{ CH }}>
                       },
                       "resources": {
                         "resourcePresetId": "<класс_хостов>",
                         "diskSize": "<размер_хранилища_в_байтах>",
                         "diskTypeId": "<тип_диска>"
                       },
                       "weight": "<вес_шарда>"
                     }
                   }
                 }'
     ```

     Где:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.
     * `configSpec.clickhouse` — изменяемые параметры шарда:

       * `config` — [настройки {{ CH }}](../concepts/settings-list.md). Список доступных настроек приведен в [описании метода](../api-ref/Cluster/updateShard.md#yandex.cloud.mdb.clickhouse.v1.UpdateClusterShardRequest).

       * `resources` — ресурсы хостов, которые добавляются в создаваемый шард:

         * `resourcePresetId` — идентификатор [класса хостов](../concepts/instance-types.md). Список доступных классов хостов с их идентификаторами можно запросить с помощью метода [ResourcePreset.List](../api-ref/ResourcePreset/list.md).
         * `diskSize` — размер диска в байтах.
         * `diskTypeId` — [тип диска](../concepts/storage.md).

       * `weight` — вес шарда.

         По умолчанию каждому шарду назначается вес `1`. Если какому-либо шарду назначить вес больше, данные будут распределены между шардами в соответствии с весами.

         При расчете приоритета шарда при распределении данных складываются веса всех шардов, далее вес каждого шарда делится на полученную сумму. Например, если у одного шарда вес `1`, а у другого — `3`, то у первого шарда приоритет `1/4`, а у второго — `3/4`. Чем выше приоритет, тем больше данных окажется на шарде.

         Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/engines/table-engines/special/distributed).

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя шарда — со [списком шардов в кластере](#list-shards).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/updateShard.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService.UpdateShard](../api-ref/grpc/Cluster/updateShard.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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
             "shard_name": "<имя_шарда>",
             "update_mask": {
               "paths": [
                 "config_spec.clickhouse.config.<настройка_{{ CH }}>",
                 "config_spec.clickhouse.resources",
                 "config_spec.clickhouse.weight"
               ]
             },
             "config_spec": {
               "clickhouse": {
                 "config": {
                   <настройки_{{ CH }}>
                 },
                 "resources": {
                   "resource_preset_id": "<класс_хостов>",
                   "disk_size": "<размер_хранилища_в_байтах>",
                   "disk_type_id": "<тип_диска>"
                 },
                 "weight": "<вес_шарда>"
               }
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.clickhouse.v1.ClusterService.UpdateShard
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.
     * `config_spec.clickhouse` — изменяемые параметры шарда:

       * `config` — [настройки {{ CH }}](../concepts/settings-list.md). Список доступных настроек приведен в [описании метода](../api-ref/Cluster/updateShard.md#yandex.cloud.mdb.clickhouse.v1.UpdateClusterShardRequest).

       * `resources` — ресурсы хостов, которые добавляются в создаваемый шард:

         * `resource_preset_id` — идентификатор [класса хостов](../concepts/instance-types.md). Список доступных классов хостов с их идентификаторами можно запросить с помощью метода [ResourcePreset.List](../api-ref/ResourcePreset/list.md).
         * `disk_size` — размер диска в байтах.
         * `disk_type_id` — [тип диска](../concepts/storage.md).

       * `weight` — вес шарда.

         По умолчанию каждому шарду назначается вес `1`. Если какому-либо шарду назначить вес больше, данные будут распределены между шардами в соответствии с весами.

         При расчете приоритета шарда при распределении данных складываются веса всех шардов, далее вес каждого шарда делится на полученную сумму. Например, если у одного шарда вес `1`, а у другого — `3`, то у первого шарда приоритет `1/4`, а у второго — `3/4`. Чем выше приоритет, тем больше данных окажется на шарде.

         Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/engines/table-engines/special/distributed).

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя шарда — со [списком шардов в кластере](#list-shards).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/updateShard.md#yandex.cloud.operation.Operation).

{% endlist %}

## Удалить шард {#delete-shard}

Вы можете удалить шард из кластера {{ CH }}, если он не является:
* Единственным шардом.
* Единственным шардом в [группе шардов](shard-groups.md).

Удаление шарда приведет к удалению всех таблиц и данных, которые находятся на этом шарде.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_shards }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного хоста и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить шард из кластера, выполните команду:

  ```bash
  {{ yc-mdb-ch }} shards delete <имя_шарда> \
    --cluster-name=<имя_кластера>
  ```

  Имя шарда можно запросить со [списком шардов в кластере](#list-shards), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  1. Удалите из описания кластера {{ mch-name }} блок `host` с описанием шарда.
  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Введите слово `yes` и нажмите **Enter**.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.DeleteShard](../api-ref/Cluster/deleteShard.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/shards/<имя_шарда>'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя шарда — со [списком шардов в кластере](#list-shards).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/deleteShard.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService.DeleteShard](../api-ref/grpc/Cluster/deleteShard.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "shard_name": "<имя_шарда>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.clickhouse.v1.ClusterService.DeleteShard
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя шарда — со [списком шардов в кластере](#list-shards).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/deleteShard.md#yandex.cloud.operation.Operation).

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
