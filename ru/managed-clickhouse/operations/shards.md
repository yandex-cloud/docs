# Управление шардами в кластере {{ CH }}

Вы можете включить шардирование для кластера, а также добавлять и настраивать отдельные шарды.

## Включить шардирование {#enable}

Кластеры {{ mch-name }} создаются с одним шардом. Чтобы начать непосредственно шардирование данных, [добавьте](#add-shard) еще один или несколько шардов и [создайте](../tutorials/sharding.md#example) распределенную таблицу.

## Создать шард {#add-shard}

Количество шардов в кластерах {{ mch-name }} ограничено квотами на количество CPU и объем памяти, которые доступны кластерам БД в вашем облаке. Чтобы проверить используемые ресурсы, откройте страницу [Квоты]({{ link-console-quotas }}) и найдите блок **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.

Вы можете создать сразу несколько шардов в кластере.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится кластер.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_shards }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.clickhouse.Cluster.Shards.action_add-shards_iULX7 }}**.
  1. Нажмите на значок ![pencil](../../_assets/console-icons/pencil.svg) в строке нового шарда, чтобы изменить его параметры:
      * имя и вес;
      * конфигурацию хостов шарда.
  1. (Опционально) Нажмите кнопку **{{ ui-key.yacloud.clickhouse.cluster.add_shard-btn }}**, чтобы добавить дополнительные шарды, и укажите их параметры.
  1. (Опционально) Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_add-host }}**, чтобы добавить дополнительные хосты, и укажите их параметры.
  1. Чтобы скопировать схему со случайной реплики одного из шардов на хосты новых шардов, выберите опцию **{{ ui-key.yacloud.mdb.forms.field_copy_schema }}**.

      {% include [warning-schema-copy](../../_includes/managed-clickhouse/warning-schema-copy.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create-shard }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать один или несколько шардов:

  1. Посмотрите описание команды CLI для создания шардов:

      ```bash
      {{ yc-mdb-ch }} shards add --help
      ```

  1. Выполните команду создания шардов.

      Укажите в команде один или несколько параметров `--shard`: по одному параметру на каждый шард, который нужно создать.

      Пример команды для создания одного шарда (приведены не все доступные параметры):

      ```bash
      {{ yc-mdb-ch }} shards add \
        --cluster-name=<имя_кластера> \
        --shard name=<имя_нового_шарда>,`
               `weight=<вес_шарда> \
        --host zone-id=<зона_доступности>,`
              `subnet-name=<имя_подсети>,`
              `shard-name=<имя_шарда> \
        --copy-schema
      ```

      Где:

      * `--cluster-name` — имя кластера.

          Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

      * `--shard` — параметры шарда:

          * `name` — имя шарда. Должно быть уникальным в кластере.

              Может содержать латинские буквы, цифры, дефис и подчеркивание. Максимальная длина — 63 символа.

          * `weight` — вес шарда.

      * `--host` — параметры хоста, который будет добавлен в шард:

          
          * `zone-id` — [зона доступности](../../overview/concepts/geo-scope.md).
          * `subnet-name` — [имя подсети](../../vpc/concepts/network.md#subnet).


          * `shard-name` — имя шарда, в который будет добавлен хост.

      * `--copy-schema` — опциональный параметр, который инициирует копирование схемы данных со случайной реплики одного из шардов на хосты нового шарда.

          {% include [warning-schema-copy](../../_includes/managed-clickhouse/warning-schema-copy.md) %}

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

  1. Добавьте к описанию кластера {{ mch-name }} один или несколько блоков `shard` и блоков `host` типа `CLICKHOUSE` с заполненным полем `shard_name`:

     ```hcl
     resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
       ...
       shard {
         name   = "<имя_шарда>"
         weight = <вес_шарда>
       }

       host {
         type       = "CLICKHOUSE"
         zone       = "<зона_доступности>"
         subnet_id  = yandex_vpc_subnet.<подсеть_в_зоне_доступности>.id
         shard_name = "<имя_шарда>"
       }
     }
     ```

  1. (Опционально) Чтобы скопировать схему со случайной реплики одного из шардов на хосты новых шардов, добавьте к описанию кластера поле `copy_schema_on_new_hosts` со значением `true`.

     {% include [warning-schema-copy](../../_includes/managed-clickhouse/warning-schema-copy.md) %}

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.AddShards](../api-ref/Cluster/addShards.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "shardSpecs": [
            {
              "name": "<имя_шарда>",
              "configSpec": {
                "clickhouse": {
                  "resources": {
                    "resourcePresetId": "<класс_хостов>",
                    "diskSize": "<размер_хранилища_в_байтах>",
                    "diskTypeId": "<тип_диска>"
                  },
                  "weight": "<вес_шарда>"
                }
              }
            }
          ],
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

        * `shardSpecs` — настройки шардов, которые будут добавлены в кластер. Настройки представлены в виде массива элементов. Каждый элемент соответствует отдельному шарду и имеет следующую структуру:

          * `name` — имя шарда.
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

          {% include [warning-schema-copy](../../_includes/managed-clickhouse/warning-schema-copy.md) %}

     1. Выполните запрос:

        ```bash
        curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/shards:batchCreate' \
          --data '@body.json'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/addShards.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService.AddShards](../api-ref/grpc/Cluster/addShards.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

     1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "cluster_id": "<идентификатор_кластера>",
          "shard_specs": [
            {
              "name": "<имя_шарда>",
              "config_spec": {
                "clickhouse": {
                  "resources": {
                    "resource_preset_id": "<класс_хостов>",
                    "disk_size": "<размер_хранилища_в_байтах>",
                    "disk_type_id": "<тип_диска>"
                  },
                  "weight": "<вес_шарда>"
                }
              }
            }
          ],
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

        * `cluster_id` — идентификатор кластера. Его можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
        * `shard_specs` — настройки шардов, которые будут добавлены в кластер. Настройки представлены в виде массива элементов. Каждый элемент соответствует отдельному шарду и имеет следующую структуру:

          * `name` — имя шарда.
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

          {% include [warning-schema-copy](../../_includes/managed-clickhouse/warning-schema-copy.md) %}

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
          yandex.cloud.mdb.clickhouse.v1.ClusterService.AddShards \
          < body.json
        ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/addShards.md#yandex.cloud.operation.Operation).

{% endlist %}

## Получить список шардов в кластере {#list-shards}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится кластер.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
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

  1. Воспользуйтесь методом [Cluster.ListShards](../api-ref/Cluster/listShards.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

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
  1. Воспользуйтесь вызовом [ClusterService.ListShards](../api-ref/grpc/Cluster/listShards.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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

Вы можете изменить вес шарда, а также [класс хоста](../concepts/instance-types.md), [тип диска](../concepts/storage.md) и размер хранилища.

{% include [note-change-disk-type-data-loss](../../_includes/mdb/mch/note-change-disk-type-data-loss.md) %}

{% note info %}

Чтобы изменить тип диска на `local-ssd`, обратитесь в [техническую поддержку]({{ link-console-support }}).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится кластер.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
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

  1. Передайте в команде параметры, которые вы хотите изменить:

     ```bash
     {{ yc-mdb-ch }} shards update <имя_шарда> \
       --cluster-name <имя_кластера> \
       --weight <вес_шарда> \
       --clickhouse-resource-preset <класс_хостов> \
       --clickhouse-disk-size <размер_хранилища> \
       --clickhouse-disk-type <тип_диска>
     ```

     Где:

     * `--cluster-name` — имя кластера. Его можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
     * `--weight` — вес шарда. Минимальное значение — `0`.
     * `--clickhouse-resource-preset` — [класс хостов](../concepts/instance-types.md).
     * `--clickhouse-disk-size` — размер хранилища в гигабайтах.
     * `--clickhouse-disk-type` — [тип диска](../concepts/storage.md).

     Имя шарда можно запросить со [списком шардов в кластере](#list-shards).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.UpdateShard](../api-ref/Cluster/updateShard.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

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
  1. Воспользуйтесь вызовом [ClusterService.UpdateShard](../api-ref/grpc/Cluster/updateShard.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится кластер.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_shards }}**.
    1. Удалите один или несколько шардов:
        * Чтобы удалить один шард, нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного шарда и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.
        * Чтобы удалить несколько шардов сразу, выберите нужные шарды и нажмите **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}** в нижней части экрана.
    1. В открывшемся окне включите опцию **Я удаляю шарды** и нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить один или несколько шардов из кластера, выполните команду, передав нужные имена шардов. Используйте пробел в качестве разделителя.

  Команда для удаления одного шарда имеет вид:

  ```bash
  {{ yc-mdb-ch }} shards delete \
    --cluster-name=<имя_кластера> \
    <имя_шарда>
  ```

  Имена шардов можно запросить со [списком шардов в кластере](#list-shards), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

  1. Удалите из описания кластера {{ mch-name }} нужные блоки `shard` и `host`.
  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Введите слово `yes` и нажмите **Enter**.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.DeleteShards](../api-ref/Cluster/deleteShards.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/shards:batchDelete' \
       --data '{
                 "shardNames": [
                   <перечень_имен_шардов>
                 ]
               }'
     ```

     Где `shardNames` — массив строк. Каждая строка — имя шарда, который нужно удалить. Имена шардов можно запросить со [списком шардов в кластере](#list-shards).

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/deleteShard.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService.DeleteShards](../api-ref/grpc/Cluster/deleteShards.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "shard_names": [
               <перечень_имен_шардов>
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.clickhouse.v1.ClusterService.DeleteShards
     ```

     Где `shard_names` — массив строк. Каждая строка — имя шарда, который нужно удалить. Имена шардов можно запросить со [списком шардов в кластере](#list-shards).

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/deleteShards.md#yandex.cloud.operation.Operation).

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
