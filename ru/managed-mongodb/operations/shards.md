# Управление шардами {{ MG }}

Кластер можно [создать шардированным](cluster-create.md#creating-a-sharded-cluster) либо [включить шардирование](#enable) позже. Затем можно [добавлять и настраивать шарды](#add-shard).

Для повышения доступности шарды должны состоять как минимум из трех хостов `MONGOD`. Небольшие коллекции обычно нет смысла шардировать: скорость обработки запросов будет выше в обычном кластере реплик.

{% note alert %}

После того как [шардирование кластера](../concepts/sharding.md) включено:
* Выключить шардирование невозможно. В кластере всегда будет поддерживаться минимальное количество хостов `MONGOS`, `MONGOCFG` или `MONGOINFRA` в зависимости от [типа шардирования](../concepts/sharding.md#shard-management).
* Обращаться к базам данных следует только через хосты `MONGOS` или `MONGOINFRA`, которые маршрутизируют запросы к шардам. Измените адреса хостов в коде ваших приложений соответствующим образом.

{% endnote %}

## Включить шардирование {#enable}

Через интерфейс {{ mmg-name }} вы можете быстро создать [инфраструктуру шардирования {{ MG }}](../concepts/sharding.md#shard-management).

О том, как непосредственно шардировать базу и коллекции {{ MG }}, читайте в разделе [Шардирование коллекций](../tutorials/sharding.md).

Для включения шардирования необходимо:
* Не менее трех хостов `MONGOINFRA` при стандартном шардировании.
* Не менее двух хостов `MONGOS` и не менее трех хостов `MONGOCFG` при расширенном шардировании.

{% note info %}

Шардирование [не поддерживается](../concepts/sharding.md#shard-management) для хостов с классами **b1.medium** и **b2.medium**. Если у вас нет вкладки **{{ ui-key.yacloud.mongodb.cluster.switch_shards }}**, [повысьте класс хостов кластера](update.md#change-resource-preset) до поддерживаемого.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mongodb.cluster.switch_shards }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.shards.button_sharding-enable }}**.
  1. Выберите один из типов шардирования:
     * **{{ ui-key.yacloud.mongodb.cluster.shards.label_standard }}** — с использованием хостов `MONGOINFRA`.
     * **{{ ui-key.yacloud.mongodb.cluster.shards.label_custom }}** — с использованием хостов `MONGOS` и `MONGOCFG`.

       Подробнее см. в разделе [Шардирование](../concepts/sharding.md).

     {% note warning %}

     После включения шардирования будет невозможно поменять его тип.

     {% endnote %}

  1. Задайте параметры хостов, которые будут обеспечивать доступ к шардированным данным.
  1. Нажмите кнопку **{{ ui-key.yacloud.mongodb.cluster.shards.button_enable_sharding }}**.

  Кластер начнет обновляться, при этом будут созданы запрошенные хосты, а также первый шард кластера.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  * Чтобы включить стандартное шардирование кластера с использованием хостов `MONGOINFRA`, выполните команду (в примере приведены не все доступные параметры):

    ```bash
    {{ yc-mdb-mg }} cluster enable-sharding \
      --cluster-name=<имя_кластера> \
      --host type=mongoinfra,`
        `zone-id=<зона_доступности>,`
        `subnet-name=<имя_подсети> \
      --host type=mongoinfra,`
        `zone-id=<зона_доступности>,`
        `subnet-name=<имя_подсети> \
      --host type=mongoinfra,`
        `zone-id=<зона_доступности>,`
        `subnet-name=<имя_подсети> \
      --mongoinfra resource-preset=<класс_хоста>,`
        `disk-size=<размер_хранилища_ГБ>,`
        `disk-type=<тип_диска>
    ```

    Где:
    * `--cluster-name` — имя кластера, которое можно получить со [списком кластеров в каталоге](cluster-list.md#list).
    * `--host` — параметры хоста:
      * `type` — тип (`MONGOINFRA`).
      * `zone-id` — [зона доступности](../../overview/concepts/geo-scope.md).
      * `subnet-name` — [имя подсети](../../vpc/concepts/network.md#subnet).
    * `--mongoinfra` — параметры хостов `MONGOINFRA`:
      * `resource-preset` — [класс хоста](../concepts/instance-types.md).
      * `disk-size` — размер хранилища в гигабайтах.
      * `disk-type` — [тип диска](../concepts/storage.md).

  * Чтобы включить расширенное шардирование кластера с использованием хостов `MONGOS` и `MONGOCFG`, выполните команду (в примере приведены не все доступные параметры):

    ```bash
    {{ yc-mdb-mg }} cluster enable-sharding \
      --cluster-name=<имя_кластера> \
      --host type=mongos,`
        `zone-id=<зона_доступности>,`
        `subnet-name=<имя_подсети> \
      --host type=mongos,`
        `zone-id=<зона_доступности>,`
        `subnet-name=<имя_подсети> \
      --mongos resource-preset=<класс_хоста>,`
        `disk-size=<размер_хранилища_ГБ>,`
        `disk-type=<тип_диска> \
      --host type=mongocfg,`
        `zone-id=<зона_доступности>,`
        `subnet-name=<имя_подсети> \
      --host type=mongocfg,`
        `zone-id=<зона_доступности>,`
        `subnet-name=<имя_подсети> \
      --host type=mongocfg,`
        `zone-id=<зона_доступности>,`
        `subnet-name=<имя_подсети> \
      --mongocfg resource-preset=<класс_хоста>,`
        `disk-size=<размер_хранилища_ГБ>,`
        `disk-type=<тип_диска>
    ```

    Где:
    * `--cluster-name` — имя кластера, которое можно получить со [списком кластеров в каталоге](cluster-list.md#list).
    * `--host` — параметры хоста:
      * `type` — тип (`MONGOS` или `MONGOCFG`).
      * `zone-id` — [зона доступности](../../overview/concepts/geo-scope.md).
      * `subnet-name` — [имя подсети](../../vpc/concepts/network.md#subnet).
    * `--mongos` — параметры хостов `MONGOS`:
      * `resource-preset` — [класс хоста](../concepts/instance-types.md).
      * `disk-size` — размер хранилища в гигабайтах.
      * `disk-type` — [тип диска](../concepts/storage.md).
    * `--mongocfg` — параметры хостов `MONGOCFG`:
      * `resource-preset` — [класс хоста](../concepts/instance-types.md).
      * `disk-size` — размер хранилища в гигабайтах.
      * `disk-type` — [тип диска](../concepts/storage.md).

- {{ TF }} {#tf}

  1. {% include [update-provider-version](../../_includes/mdb/mmg/terraform/update-provider-version.md) %}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О создании такого файла читайте в разделе [Создание кластера](cluster-create.md).

  1. Добавьте дополнительные ресурсы в конфигурационный файл.

     {% cut "Для стандартного шардирования кластера с использованием хостов `MONGOINFRA`" %}

        ```hcl
        resources_mongoinfra {
          resource_preset_id = "<класс_хоста>"
          disk_type_id       = "<тип_диска>"
          disk_size          = <размер_хранилища_ГБ>
        }

        host {
          zone_id   = "<зона_доступности>"
          subnet_id = "<идентификатор_подсети>"
          type      = "mongoinfra"
        }

        host {
          zone_id   = "<зона_доступности>"
          subnet_id = "<идентификатор_подсети>"
          type      = "mongoinfra"
        }

        host {
          zone_id   = "<зона_доступности>"
          subnet_id = "<идентификатор_подсети>"
          type      = "mongoinfra"
        }
        ```

     {% endcut %}

     {% cut "Для расширенного шардирования кластера с использованием хостов `MONGOS` и `MONGOCFG`" %}

        ```hcl
        resources_mongos {
          resource_preset_id = "<класс_хоста>"
          disk_type_id       = "<тип_диска>"
          disk_size          = <размер_хранилища_ГБ>
        }

        resources_mongocfg {
          resource_preset_id = "<класс_хоста>"
          disk_type_id       = "<тип_диска>"
          disk_size          = <размер_хранилища_ГБ>
        }

        host {
          zone_id   = "<зона_доступности>"
          subnet_id = "<идентификатор_подсети>"
          type      = "mongos"
        }

        host {
          zone_id   = "<зона_доступности>"
          subnet_id = "<идентификатор_подсети>"
          type      = "mongos"
        }

        host {
          zone_id   = "<зона_доступности>"
          subnet_id = "<идентификатор_подсети>"
          type      = "mongocfg"
        }

        host {
          zone_id   = "<зона_доступности>"
          subnet_id = "<идентификатор_подсети>"
          type      = "mongocfg"
        }

        host {
          zone_id   = "<зона_доступности>"
          subnet_id = "<идентификатор_подсети>"
          type      = "mongocfg"
        }
        ```

     {% endcut %}

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmg }}).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.EnableSharding](../api-ref/Cluster/enableSharding.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<идентификатор_кластера>:enableSharding' \
            --data '{
                      "<тип_хоста_{{ MG }}>": {
                        "resources": {
                          "resourcePresetId": "<класс_хоста>",
                          "diskSize": "<размер_хранилища_в_байтах>",
                          "diskTypeId": "<тип_диска>"
                        }
                      },
                      "hostSpecs": [
                        {
                          "zoneId": "<зона_доступности>",
                          "subnetId": "<идентификатор_подсети>",
                          "assignPublicIp": <разрешить_публичный_доступ_к_хосту>,
                          "type": "<тип_хоста>",
                          "shardName": "<имя_шарда>",
                          "hidden": <скрыть_хост>,
                          "secondaryDelaySecs": "<задержка_в_секундах>",
                          "priority": "<приоритет_назначения_хоста_мастером>",
                          "tags": "<метки_хоста>"
                        },
                        { <аналогичный_набор_настроек_для_хоста_2> },
                        { ... },
                        { <аналогичный_набор_настроек_для_хоста_N> }
                      ]
                    }'
        ```

        Где:

        * Тип хоста {{ MG }} — зависит от [типа шардирования](../concepts/sharding.md). Доступные значения: `mongocfg`, `mongos`, `mongoinfra`.
        
        * `hostSpecs` — массив новых хостов. Один элемент массива содержит настройки для одного хоста. Количество хостов зависит от [типа шардирования](../concepts/sharding.md#shard-management). 

          * `zoneId` — [зона доступности](../../overview/concepts/geo-scope.md).
          * `subnetId` — [идентификатор подсети](../../vpc/concepts/network.md#subnet).
          * `assignPublicIp` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.
          * `type`— тип хоста (`MONGOINFRA`, `MONGOS` или `MONGOCFG`).
          * `shardName` — имя шарда.
          * `hidden`— будет ли хост виден (`false`) или скрыт (`true`).
          * `secondaryDelaySecs` — время отставания хоста от мастера.
          * `priority` — приоритет назначения хоста мастером при [выходе из строя основного мастера](../concepts/replication.md#master-failover).
          * `tags`— метки хоста.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/enableSharding.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService.EnableSharding](../api-ref/grpc/Cluster/enableSharding.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "<тип_хоста_{{ MG }}>": {
                  "resources": {
                    "resource_preset_id": "<класс_хоста>",
                    "disk_size": "<размер_хранилища_в_байтах>",
                    "disk_type_id": "<тип_диска>"
                  }
                },
                "host_specs": [
                  {
                    "zone_id": "<зона_доступности>",
                    "subnet_id": "<идентификатор_подсети>",
                    "assign_public_ip": <разрешить_публичный_доступ_к_хосту>,
                    "type": "<тип_хоста>",
                    "shard_name": "<имя_шарда>",
                    "hidden": <скрыть_хост>,
                    "secondary_delay_secs": "<задержка_в_секундах>",
                    "priority": "<приоритет_назначения_хоста_мастером>",
                    "tags": "<метки_хоста>"
                  },
                  { <аналогичный_набор_настроек_для_хоста_2> },
                  { ... },
                  { <аналогичный_набор_настроек_для_хоста_N> }
                ]
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mongodb.v1.ClusterService.EnableSharding
      ```

      Где:
      
      * Тип хоста {{ MG }} — зависит от [типа шардирования](../concepts/sharding.md). Доступные значения: `mongocfg`, `mongos`, `mongoinfra`.
        
      * `host_specs` — массив новых хостов. Один элемент массива содержит настройки для одного хоста. Количество хостов зависит от [типа шардирования](../concepts/sharding.md#shard-management). 

        * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md).
        * `subnet_id` — [идентификатор подсети](../../vpc/concepts/network.md#subnet).
        * `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.
        * `type`— тип хоста (`MONGOINFRA`, `MONGOS` или `MONGOCFG`).
        * `shard_name` — имя шарда.
        * `hidden`— будет ли хост виден (`false`) или скрыт (`true`).
        * `secondary_delay_secs` — время отставания хоста от мастера.
        * `priority` — приоритет назначения хоста мастером при [выходе из строя основного мастера](../concepts/replication.md#master-failover).
        * `tags`— метки хоста.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/enableSharding.md#yandex.cloud.operation.Operation).

{% endlist %}

## Получить список шардов в кластере {#list-shards}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mongodb.cluster.switch_shards }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список шардов в кластере, выполните команду:

  ```bash
  {{ yc-mdb-mg }} shards list --cluster-name <имя_кластера>
  ```

  Результат:

  ```text
  +------+
  | NAME |
  +------+
  | rs01 |
  | rs02 |
  +------+
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
            --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<идентификатор_кластера>/shards'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listShards.md#yandex.cloud.mdb.mongodb.v1.ListClusterShardsResponse).

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
            -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.mongodb.v1.ClusterService.ListShards
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listShards.md#yandex.cloud.mdb.mongodb.v1.ListClusterShardsResponse).

{% endlist %}

## Создать шард {#add-shard}

Количество шардов в кластерах {{ mmg-name }} ограничено квотами на количество CPU и объем памяти, которые доступны кластерам БД в вашем облаке. Чтобы проверить используемые ресурсы, откройте страницу [Квоты]({{ link-console-quotas }}) и найдите блок **{{ mmg-full-name }}**.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mongodb.cluster.switch_shards }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.shards.action_add-shard }}**.
  1. Укажите имя шарда и добавьте нужное количество хостов.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create-shard }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать шард, выполните команду (в примере приведены не все доступные параметры):

  ```bash
  {{ yc-mdb-mg }} shards add <имя_нового_шарда> \
    --cluster-name=<имя_кластера> \
    --host zone-id=<зона_доступности>,`
      `subnet-name=<имя_подсети>
  ```

  Где:
  * `--cluster-name` — имя кластера, которое можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  * `--host` — параметры хоста:
    * `zone-id` — [зона доступности](../../overview/concepts/geo-scope.md).
    * `subnet-name` — [имя подсети](../../vpc/concepts/network.md#subnet).

- {{ TF }} {#tf}

  1. {% include [update-provider-version](../../_includes/mdb/mmg/terraform/update-provider-version.md) %}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О создании такого файла читайте в разделе [Создание кластера](cluster-create.md).

  1. Добавьте к описанию кластера {{ mmg-name }} нужное количество блоков `host` с типом `MONGOD` в параметре `type` и именем шарда в параметре `shard_name`:

     ```hcl
     resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
       ...
       host {
         zone_id    = "<зона_доступности>"
         subnet_id  = "<идентификатор_подсети>"
         type       = "mongod"
         shard_name = "<имя_шарда>"
       }
     }
     ```

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmg }}).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.AddShard](../api-ref/Cluster/addShard.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<идентификатор_кластера>/shards' \
            --data '{
                      "shardName": "<имя_шарда>",
                      "hostSpecs": [
                        {
                          "zoneId": "<зона_доступности>",
                          "subnetId": "<идентификатор_подсети>",
                          "assignPublicIp": <разрешить_публичный_доступ_к_хосту>,
                          "type": "<тип_хоста>",
                          "shardName": "<имя_шарда>",
                          "hidden": <скрыть_хост>,
                          "secondaryDelaySecs": "<время_в_секундах>",
                          "priority": "<приоритет_назначения_хоста_мастером>",
                          "tags": "<метки>"
                        },
                        { <аналогичный_набор_настроек_для_хоста_2> },
                        { ... },
                        { <аналогичный_набор_настроек_для_хоста_N> }
                      ]
                    }'

        ```

        Где:

        * `shardName` — имя создаваемого шарда.
        * `hostSpecs` — параметры хоста:

          * `zoneId` — [зона доступности](../../overview/concepts/geo-scope.md).
          * `subnetId` — [идентификатор подсети](../../vpc/concepts/network.md#subnet).
          * `assignPublicIp` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.
          * `type`— тип хоста. Укажите `MONGOD`.
          * `shardName` — имя шарда.
          * `hidden`— будет ли хост виден (`false`) или скрыт (`true`).
          * `secondaryDelaySecs` — время отставания хоста от мастера.
          * `priority` — приоритет назначения хоста мастером при [выходе из строя основного мастера](../concepts/replication.md#master-failover).
          * `tags`— метки хоста.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/addShard.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService.AddShard](../api-ref/grpc/Cluster/addShard.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "shard_name": "<имя_шарда>",
                  "host_specs": [
                    {
                      "zone_id": "<зона_доступности>",
                      "subnet_id": "<идентификатор_подсети>",
                      "assign_public_ip": <разрешить_публичный_доступ_к_хосту>,
                      "type": "<тип_хоста>",
                      "shard_name": "<имя_шарда>",
                      "hidden": <скрыть_хост>,
                      "secondary_delay_secs": "<время_в_секундах>",
                      "priority": "<приоритет_назначения_хоста_мастером>",
                      "tags": "<метки>"
                    },
                    { <аналогичный_набор_настроек_для_хоста_2> },
                    { ... },
                    { <аналогичный_набор_настроек_для_хоста_N> }
                  ]
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.AddShard    
        ```

        Где:

        * `shard_name` — имя создаваемого шарда.
        * `host_specs` — параметры хоста:

          * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md).
          * `subnet_id` — [идентификатор подсети](../../vpc/concepts/network.md#subnet).
          * `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.
          * `type`— тип хоста. Укажите `MONGOD`.
          * `shard_name` — имя шарда.
          * `hidden`— будет ли хост виден (`false`) или скрыт (`true`).
          * `secondary_delay_secs` — время отставания хоста от мастера.
          * `priority` — приоритет назначения хоста мастером при [выходе из строя основного мастера](../concepts/replication.md#master-failover).
          * `tags`— метки хоста.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/addShard.md#yandex.cloud.operation.Operation).    

{% endlist %}

## Удалить шард {#delete-shard}

Вы можете удалить шард из кластера {{ MG }}, если это не единственный шард. Чтобы заменить единственный шард, сначала создайте новый шард, а затем удалите старый.

{% note info %}

Для удаляемого шарда будет вызвана операция [removeShard](https://docs.mongodb.com/manual/reference/command/removeShard/), которая безопасно переносит данные на оставшиеся шарды.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mongodb.cluster.switch_shards }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного шарда и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.shards.popup-confirm_button_delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить шард из кластера, выполните команду:

  ```bash
  {{ yc-mdb-mg }} shards delete <имя_шарда> \
    --cluster-name=<имя_кластера>
  ```

  Имя шарда можно запросить со [списком шардов в кластере](#list-shards), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О создании такого файла читайте в разделе [Создание кластера](cluster-create.md).

  1. Удалите из описания кластера {{ mmg-name }} все блоки `host`, которые относятся к шарду.
  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Введите слово `yes` и нажмите **Enter**.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmg }}).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.DeleteShard](../api-ref/Cluster/deleteShard.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request DELETE \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<идентификатор_кластера>/shards/<имя_шарда>'
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
            -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "shard_name": "<имя_шарда>" 
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.mongodb.v1.ClusterService.DeleteShard
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя шарда — со [списком шардов в кластере](#list-shards).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/deleteShard.md#yandex.cloud.operation.Operation).

{% endlist %}