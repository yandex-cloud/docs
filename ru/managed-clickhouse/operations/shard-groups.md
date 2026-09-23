# Управление группами шардов в кластере {{ CH }}

Вы можете сгруппировать несколько [шардов](../concepts/sharding.md) кластера {{ CH }} в _группу шардов_ и затем размещать таблицы в этой группе.

## Получить список групп шардов в кластере {#list-shard-groups}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится кластер.
  1. [Перейдите]({{ link-console-main }}/link/managed-clickhouse) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_shard-groups }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список групп шардов в кластере, выполните команду:

  ```bash
  {{ yc-mdb-ch }} shard-groups list \
     --cluster-name=<имя_кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.ListShardGroups](../api-ref/Cluster/listShardGroups.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/shardGroups'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listShardGroups.md#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsResponse).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService.ListShardGroups](../api-ref/grpc/Cluster/listShardGroups.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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
       yandex.cloud.mdb.clickhouse.v1.ClusterService.ListShardGroups
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listShardGroups.md#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsResponse).

{% endlist %}

## Получить детальную информацию о группе шардов {#get-shard-group}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится кластер.
  1. [Перейдите]({{ link-console-main }}/link/managed-clickhouse) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_shard-groups }}**.
  1. Выберите группу шардов для просмотра детальной информации о ней.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить детальную информацию о группе шардов в кластере, выполните команду:

  ```bash
  {{ yc-mdb-ch }} shard-groups get \
    --cluster-name=<имя_кластера> \
    --name=<имя_группы_шардов>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.GetShardGroup](../api-ref/Cluster/getShardGroup.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/shardGroups/<имя_группы_шардов>'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя группы шардов — со [списком групп в кластере](#list-shard-groups).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/getShardGroup.md#yandex.cloud.mdb.clickhouse.v1.ShardGroup).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService.GetShardGroup](../api-ref/grpc/Cluster/getShardGroup.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "shard_group_name": "<имя_группы_шардов>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.clickhouse.v1.ClusterService.GetShardGroup
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя группы шардов — со [списком групп в кластере](#list-shard-groups).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/getShardGroup.md#yandex.cloud.mdb.clickhouse.v1.ShardGroup).

{% endlist %}

## Создать группу шардов {#create-shard-group}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится кластер.
  1. [Перейдите]({{ link-console-main }}/link/managed-clickhouse) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_shard-groups }}**.
  1. В правом верхнем углу страницы нажмите кнопку **{{ ui-key.yacloud.mdb.shard-groups.button_add-group }}**.
  1. Введите имя группы шардов.

      {% include [shard-groups-name-limits](../../_includes/mdb/mch/shard-groups-name-limits.md) %}

  1. В поле **{{ ui-key.yacloud.mdb.shard-groups.field_shard-names }}** выберите шарды кластера, которые нужно включить в группу.
  1. При необходимости добавьте в группу внешние шарды:

      1. Нажмите кнопку **{{ ui-key.yacloud.mdb.shard-groups.button_add-external-shard }}**.
      1. Введите имя внешнего шарда.

          {% include [shard-groups-name-limits](../../_includes/mdb/mch/shard-groups-name-limits.md) %}

      1. Укажите вес шарда.

          {% include [shard priority weight](../../_includes/mdb/mch/ext-shard-priority-weight.md) %}

      1. В блоке **{{ ui-key.yacloud.mdb.shard-groups.field_external-shard-replicas }}** задайте параметры реплики внешнего шарда:

          * В поле **{{ ui-key.yacloud.mdb.shard-groups.field_external-shard-replica-host }}** укажите FQDN или IP-адрес хоста.

            О том, как получить FQDN хоста {{ CH }}, в [соответствующей инструкции](connect/fqdn.md#get-fqdn).

          * В поле **{{ ui-key.yacloud.mdb.shard-groups.field_external-shard-replica-port }}** укажите порт для подключения к {{ CH }}.
          * Включите опцию **{{ ui-key.yacloud.mdb.shard-groups.field_external-shard-replica-secure }}**, чтобы использовать шифрованное SSL/TLS-соединение при подключении к хосту.
          * В полях **{{ ui-key.yacloud.mdb.shard-groups.field_external-shard-replica-user }}** и **{{ ui-key.yacloud.mdb.shard-groups.field_external-shard-replica-password }}** укажите имя пользователя и пароль для доступа к БД {{ CH }}.
          * В поле **{{ ui-key.yacloud.mdb.shard-groups.field_external-shard-replica-priority }}** укажите приоритет хоста.

            Приоритет хоста используется для балансировки подключений к шарду. Значение по умолчанию — `0`. Чем меньше значение, тем выше приоритет при выборе хоста для подключения к шарду.

          Чтобы добавить еще одну реплику, нажмите кнопку **{{ ui-key.yacloud.mdb.shard-groups.button_add-external-shard-replica }}**.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.apply }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать группу шардов в кластере, выполните команду:

  ```bash
  {{ yc-mdb-ch }} shard-groups create \
    --cluster-name=<имя_кластера> \
    --name=<имя_группы_шардов> \
    --description="<описание_группы_шардов>" \
    --shards=<список_имен_шардов> \
    --external-shard name=<имя_шарда>,`
                    `weight=<вес_шарда> \
    --external-shard-replica shard=<имя_шарда>,`
                            `host=<FQDN_хоста_или_IP-адрес>,`
                            `port=<порт>,`
                            `secure=<использовать_SSL_соединение>,`
                            `user=<имя_пользователя>,`
                            `password=<пароль>,`
                            `priority=<приоритет_хоста>
  ```

  Где:

  * `--cluster-name` — имя кластера, которое можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  * `--name` — имя группы шардов.

    {% include [shard-groups-name-limits](../../_includes/mdb/mch/shard-groups-name-limits.md) %}

  * `--description` — описание группы шардов.
  * `--shards` — список имен шардов кластера.

    Имена шардов можно запросить со [списком шардов в кластере](shards.md#list-shards).

  * `--external-shard` — настройки внешнего шарда. Параметр задается для каждого внешнего шарда отдельно и имеет следующую структуру:

    * `name` — имя шарда.

      {% include [shard-groups-name-limits](../../_includes/mdb/mch/shard-groups-name-limits.md) %}

    * `weight` — вес шарда в группе.

      {% include [shard priority weight](../../_includes/mdb/mch/ext-shard-priority-weight.md) %}

  * `--external-shard-replica` — настройки реплики внешнего шарда. Параметр задается для каждой реплики отдельно и имеет следующую структуру:

    * `shard` — имя внешнего шарда, к которому относится реплика.
    * `host` — FQDN или IP-адрес хоста.
      
      О том, как получить FQDN хоста {{ CH }}, в [соответствующей инструкции](connect/fqdn.md#get-fqdn).

    * `port` — порт для подключения к {{ CH }}.
    * `secure` — использование шифрованного SSL/TLS-соединения при подключении к хосту: `true` или `false`.
    * `user`, `password` — имя пользователя и пароль для доступа к БД {{ CH }}.
    * `priority` — приоритет хоста для балансировки подключений к шарду. Значение по умолчанию — `0`. Чем меньше значение, тем выше приоритет при выборе хоста для подключения к шарду.


- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, в разделе [Создание кластера](cluster-create.md).
  1. Добавьте к описанию кластера {{ mch-name }} блок описания группы шардов `shard_group`.

     ```hcl
     resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
       ...
       shard_group {
         name        = "<имя_группы_шардов>"
         description = "<описание_группы_шардов>"
         shard_names = [
           "<имя_шарда_1>",
           ...
           "<имя_шарда_N>"
         ]

         external_shard {
           name   = "<имя_шарда>"
           weight = <вес_шарда>

           replica {
             host     = "<FQDN_хоста_или_IP-адрес>"
             port     = <порт>
             secure   = <использовать_SSL_соединение>
             user     = "<имя_пользователя>"
             password = "<пароль>"
             priority = <приоритет_хоста>
           }
         }
       }
     }
     ```

     Где:

     * `name` — имя группы шардов.

       {% include [shard-groups-name-limits](../../_includes/mdb/mch/shard-groups-name-limits.md) %}

     * `description` — описание группы шардов.
     * `shard_names` — список имен шардов кластера.
     * `external_shard` — настройки внешнего шарда. Блок задается для каждого внешнего шарда отдельно и содержит следующие параметры:

       * `name` — имя шарда.

         {% include [shard-groups-name-limits](../../_includes/mdb/mch/shard-groups-name-limits.md) %}

       * `weight` — вес шарда в группе.

         {% include [shard priority weight](../../_includes/mdb/mch/ext-shard-priority-weight.md) %}

       * `replica` — настройки реплики внешнего шарда. Блок задается для каждой реплики отдельно и содержит следующие параметры:

         * `host` — FQDN или IP-адрес хоста.
           
           О том, как получить FQDN хоста {{ CH }}, в [соответствующей инструкции](connect/fqdn.md#get-fqdn).

         * `port` — порт для подключения к {{ CH }}.
         * `secure` — использование шифрованного SSL/TLS-соединения при подключении к хосту: `true` или `false`.
         * `user`, `password` — имя пользователя и пароль для доступа к БД {{ CH }}.
         * `priority` — приоритет хоста для балансировки подключений к шарду. Значение по умолчанию — `0`. Чем меньше значение, тем выше приоритет при выборе хоста для подключения к шарду.

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster_v2).

  {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}


- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.CreateShardGroup](../api-ref/Cluster/createShardGroup.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/shardGroups' \
       --data '{
                 "shardGroupName": "<имя_группы_шардов>",
                 "description": "<описание_группы_шардов>",
                 "shardNames": [
                   "<шард_1>", "<шард_2>", ... "<шард_N>"
                 ],
                 "externalShards" [
                   {
                     "name": "<внешний_шард_1>",
                     "weight": <вес_шарда_при_записи_данных>,
                     "replicas": [
                       {
                         "host": "<FQDN_хоста>",
                         "port": "<порт>",
                         "secure": <использовать_SSL_соединение>,
                         "user": "<имя_пользователя>",
                         "password": "<пароль>",
                         "priority": <приоритет_хоста>
                       },
                       {
                         <параметры_хоста_2>
                       },
                       ...
                       {
                         <параметры_хоста_N>
                       }
                     ]
                   },
                   {
                     <параметры_внешнего_шарда_2>
                   },
                   ...
                   {
                     <параметры_внешнего_шарда_N>
                   }
                 ]
               }'
     ```

     Где:

     * `shardGroupName` — имя группы шардов.
       
       {% include [shard-groups-name-limits](../../_includes/mdb/mch/shard-groups-name-limits.md) %}

     * `description` — описание группы шардов.
     * `shardNames` — список шардов, которые нужно включить в создаваемую группу.
     * `externalShards` — список внешних шардов, которые нужно включить в создаваемую группу. Внешний шард — это шард в другом кластере {{ mch-name }} или пользовательской инсталляции {{ CH }}. Каждый элемент соответствует отдельному шарду и имеет следующую структуру:

        * `name` — имя шарда.
          
          {% include [shard-groups-name-limits](../../_includes/mdb/mch/shard-groups-name-limits.md) %}

        * `weight` — вес шарда в группе.

          {% include [shard priority weight](../../_includes/mdb/mch/ext-shard-priority-weight.md) %}

        * `replicas` — настройки хостов шарда:

          * `host` — FQDN или IP-адрес хоста.
            
            О том, как получить FQDN хоста {{ CH }}, в [соответствующей инструкции](connect/fqdn.md#get-fqdn).

          * `port` — порт для подключения к {{ CH }}.
          * `secure` — использование шифрованного SSL/TLS-соединения при подключении к хосту: `true` или `false`.
          * `user`, `password` — имя пользователя и пароль для доступа к БД {{ CH }}.
          * `priority` — приоритет хоста для балансировки подключений к шарду. Значение по умолчанию — `0`. Чем меньше значение, тем выше приоритет при выборе хоста для подключения к шарду.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/createShardGroup.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService.CreateShardGroup](../api-ref/grpc/Cluster/createShardGroup.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
         -format json \
         -import-path ~/cloudapi/ \
         -import-path ~/cloudapi/third_party/googleapis/ \
         -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
         -rpc-header "Authorization: Bearer $IAM_TOKEN" \
         -d '{
               "cluster_id": "<идентификатор_кластера>",
               "shard_group_name": "<имя_группы_шардов>",
               "description": "<описание_группы_шардов>",
               "shard_names": [
                 "<шард_1>", "<шард_2>", ... "<шард_N>"
               ],
               "external_shards" [
                 {
                   "name": "<внешний_шард_1>",
                   "weight": <вес_шарда_при_записи_данных>,
                   "replicas": [
                     {
                       "host": "<FQDN_хоста>",
                       "port": <порт>,
                       "secure": <использовать_SSL_соединение>,
                       "user": "<имя_пользователя>",
                       "password": "<пароль>",
                       "priority": <приоритет_хоста>
                     },
                     {
                       <параметры_хоста_2>
                     },
                     ...
                     {
                       <параметры_хоста_N>
                     }
                   ]
                 },
                 {
                   <параметры_внешнего_шарда_2>
                 },
                 ...
                 {
                   <параметры_внешнего_шарда_N>
                 }
               ]
             }' \
         {{ api-host-mdb }}:{{ port-https }} \
         yandex.cloud.mdb.clickhouse.v1.ClusterService.CreateShardGroup
     ```

     Где:

     * `shard_group_name` — имя группы шардов.
       
       {% include [shard-groups-name-limits](../../_includes/mdb/mch/shard-groups-name-limits.md) %}

     * `description` — описание группы шардов.
     * `shard_names` — список шардов, которые нужно включить в создаваемую группу.
     * `external_shards` — список внешних шардов, которые нужно включить в создаваемую группу. Внешний шард — это шард в другом кластере {{ mch-name }} или пользовательской инсталляции {{ CH }}. Каждый элемент соответствует отдельному шарду и имеет следующую структуру:

        * `name` — имя шарда.
          
          {% include [shard-groups-name-limits](../../_includes/mdb/mch/shard-groups-name-limits.md) %}

        * `weight` — вес шарда в группе.

          {% include [shard priority weight](../../_includes/mdb/mch/ext-shard-priority-weight.md) %}

        * `replicas` — настройки хостов шарда:

          * `host` — FQDN или IP-адрес хоста.
            
            О том, как получить FQDN хоста {{ CH }}, в [соответствующей инструкции](connect/fqdn.md#get-fqdn).

          * `port` — порт для подключения к {{ CH }}.
          * `secure` — использование шифрованного SSL/TLS-соединения при подключении к хосту: `true` или `false`.
          * `user`, `password` — имя пользователя и пароль для доступа к БД {{ CH }}.
          * `priority` — приоритет хоста для балансировки подключений к шарду. Значение по умолчанию — `0`. Чем ниже значение, тем выше приоритет при выборе хоста для подключения к шарду.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/createShardGroup.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить группу шардов {#update-shard-group}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится кластер.
  1. [Перейдите]({{ link-console-main }}/link/managed-clickhouse) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_shard-groups }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) для нужной группы шардов и выберите пункт **{{ ui-key.yacloud.common.edit }}**.
  1. В поле **{{ ui-key.yacloud.mdb.shard-groups.field_shard-names }}** выберите шарды кластера, которые нужно включить в группу.
  1. В блоке **{{ ui-key.yacloud.mdb.shard-groups.section_external-shards }}**:

      * Измените настройки нужного шарда:

          * Имя внешнего шарда.

            {% include [shard-groups-name-limits](../../_includes/mdb/mch/shard-groups-name-limits.md) %}

          * Вес шарда.

            {% include [shard priority weight](../../_includes/mdb/mch/ext-shard-priority-weight.md) %}

          * Параметры реплик шарда:

            * Хост (FQDN или IP-адрес).
              
              О том, как получить FQDN хоста {{ CH }}, в [соответствующей инструкции](connect/fqdn.md#get-fqdn).

            * Порт для подключения к {{ CH }}.
            * Защищенное соединение. 

              Если опция **{{ ui-key.yacloud.mdb.shard-groups.field_external-shard-replica-secure }}** включена, используется шифрованное SSL/TLS-соединение при подключении к хосту.

            * Имя пользователя и пароль для доступа к БД {{ CH }}.
            * Приоритет хоста.

              Приоритет хоста используется для балансировки подключений к шарду. Значение по умолчанию — `0`. Чем меньше значение, тем выше приоритет при выборе хоста для подключения к шарду.

            Чтобы добавить реплику, нажмите кнопку **{{ ui-key.yacloud.mdb.shard-groups.button_add-external-shard-replica }}**.

      * Чтобы добавить внешний шард, нажмите кнопку **{{ ui-key.yacloud.mdb.shard-groups.button_add-external-shard }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить группу шардов в кластере, выполните команду:

  ```bash
  {{ yc-mdb-ch }} shard-groups update \
    --cluster-name=<имя_кластера> \
    --name=<имя_группы_шардов> \
    --description="<новое_описание_группы_шардов>" \
    --shards=<новый_список_имен_шардов> \
    --external-shard name=<имя_шарда>,`
                    `weight=<вес_шарда> \
    --external-shard-replica shard=<имя_шарда>,`
                            `host=<FQDN_хоста_или_IP-адрес>,`
                            `port=<порт>,`
                            `secure=<использовать_SSL_соединение>,`
                            `user=<имя_пользователя>,`
                            `password=<пароль>,`
                            `priority=<приоритет_хоста>
  ```

  Где:

  * `--cluster-name` — имя кластера, которое можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).  
  * `--name` — имя изменяемой группы шардов, которое можно запросить со [списком групп шардов в кластере](#list-shard-groups).
  * `--description` — новое описание группы шардов.
  * `--shards` — новый список имен шардов кластера. Новый список заменит текущий, поэтому убедитесь, что в нем указаны все нужные шарды.

    Имена шардов можно запросить со [списком шардов в кластере](shards.md#list-shards).

  * `--external-shard` — настройки внешнего шарда. Параметр задается для каждого внешнего шарда отдельно и имеет следующую структуру:

    * `name` — имя шарда.

      {% include [shard-groups-name-limits](../../_includes/mdb/mch/shard-groups-name-limits.md) %}

    * `weight` — вес шарда в группе.

      {% include [shard priority weight](../../_includes/mdb/mch/ext-shard-priority-weight.md) %}

    {% note warning %}

    При использовании параметра `--external-shard` новые настройки внешних шардов заменят текущие.

    {% endnote %}

  * `--external-shard-replica` — настройки реплики внешнего шарда. Параметр задается для каждой реплики отдельно и имеет следующую структуру:

    * `shard` — имя внешнего шарда, к которому относится реплика.
    * `host` — FQDN или IP-адрес хоста.
      
      О том, как получить FQDN хоста {{ CH }}, в [соответствующей инструкции](connect/fqdn.md#get-fqdn).

    * `port` — порт для подключения к {{ CH }}.
    * `secure` — использование шифрованного SSL/TLS-соединения при подключении к хосту: `true` или `false`.
    * `user`, `password` — имя пользователя и пароль для доступа к БД {{ CH }}.
    * `priority` — приоритет хоста для балансировки подключений к шарду. Значение по умолчанию — `0`. Чем меньше значение, тем выше приоритет при выборе хоста для подключения к шарду.


- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, в разделе [Создание кластера](cluster-create.md).
  1. Измените в описании кластера {{ mch-name }} блок `shard_group` с нужной группой шардов:

     ```hcl
     resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
       ...
       shard_group {
         name        = "<имя_группы_шардов>"
         description = "<описание_группы_шардов>"
         shard_names = [
           "<имя_шарда_1>",
           ...
           "<имя_шарда_N>"
         ]

         external_shard {
           name   = "<имя_шарда>"
           weight = <вес_шарда>

           replica {
             host     = "<FQDN_хоста_или_IP-адрес>"
             port     = <порт>
             secure   = <использовать_SSL_соединение>
             user     = "<имя_пользователя>"
             password = "<пароль>"
             priority = <приоритет_хоста>
           }
         }
       }
     }
     ```

     Где:

     * `name` — имя группы шардов.

       {% include [shard-groups-name-limits](../../_includes/mdb/mch/shard-groups-name-limits.md) %}

     * `description` — описание группы шардов.
     * `shard_names` — список имен шардов кластера.
     * `external_shard` — настройки внешнего шарда. Блок задается для каждого внешнего шарда отдельно и содержит следующие параметры:

       * `name` — имя шарда.

         {% include [shard-groups-name-limits](../../_includes/mdb/mch/shard-groups-name-limits.md) %}

       * `weight` — вес шарда в группе.

         {% include [shard priority weight](../../_includes/mdb/mch/ext-shard-priority-weight.md) %}

       * `replica` — настройки реплики внешнего шарда. Блок задается для каждой реплики отдельно и содержит следующие параметры:

         * `host` — FQDN или IP-адрес хоста.
           
           О том, как получить FQDN хоста {{ CH }}, в [соответствующей инструкции](connect/fqdn.md#get-fqdn).

         * `port` — порт для подключения к {{ CH }}.
         * `secure` — использование шифрованного SSL/TLS-соединения при подключении к хосту: `true` или `false`.
         * `user`, `password` — имя пользователя и пароль для доступа к БД {{ CH }}.
         * `priority` — приоритет хоста для балансировки подключений к шарду. Значение по умолчанию — `0`. Чем меньше значение, тем выше приоритет при выборе хоста для подключения к шарду.

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster_v2).

  {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}


- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.updateShardGroup](../api-ref/Cluster/updateShardGroup.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/shardGroups/<имя_группы_шардов>' \
       --data '{
                 "updateMask": "description,shardNames,externalShards",
                 "description": "<описание_группы_шардов>",
                 "shardNames": [
                   "<шард_1>", "<шард_2>", ... "<шард_N>"
                 ],
                 "externalShards" [
                   {
                     "name": "<внешний_шард_1>",
                     "weight": <вес_шарда_при_записи_данных>,
                     "replicas": [
                       {
                         "host": "<FQDN_хоста>",
                         "port": "<порт>",
                         "secure": <использовать_SSL_соединение>,
                         "user": "<имя_пользователя>",
                         "password": "<пароль>",
                         "priority": <приоритет_хоста>
                       },
                       {
                         <параметры_хоста_2>
                       },
                       ...
                       {
                         <параметры_хоста_N>
                       }
                     ]
                   },
                   {
                     <параметры_внешнего_шарда_2>
                   },
                   ...
                   {
                     <параметры_внешнего_шарда_N>
                   }
                 ]
               }'
     ```

     Где:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.
     * `description` — новое описание группы шардов.
     * `shardNames` — новый список шардов кластера, которые нужно включить в группу. Чтобы узнать имена шардов, [получите их список](shards.md#list-shards) в кластере. Этот список заменит собой текущий: убедитесь, что вы включили в новый список все необходимые шарды.
     * `externalShards` — список внешних шардов с измененными параметрами, которые нужно включить в группу. Внешний шард — это шард в другом кластере {{ mch-name }} или пользовательской инсталляции {{ CH }}. Каждый элемент соответствует отдельному шарду и имеет следующую структуру:

        * `name` — имя шарда.
          
          {% include [shard-groups-name-limits](../../_includes/mdb/mch/shard-groups-name-limits.md) %}

        * `weight` — вес шарда в группе.

          {% include [shard priority weight](../../_includes/mdb/mch/ext-shard-priority-weight.md) %}

        * `replicas` — настройки хостов шарда:

          * `host` — FQDN или IP-адрес хоста.
            
            О том, как получить FQDN хоста {{ CH }}, в [соответствующей инструкции](connect/fqdn.md#get-fqdn).

          * `port` — порт для подключения к {{ CH }}.
          * `secure` — использование шифрованного SSL/TLS-соединения при подключении к хосту: `true` или `false`.
          * `user`, `password` — имя пользователя и пароль для доступа к БД {{ CH }}.
          * `priority` — приоритет хоста для балансировки подключений к шарду. Значение по умолчанию — `0`. Чем ниже значение, тем выше приоритет при выборе хоста для подключения к шарду.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя группы шардов — со [списком групп в кластере](#list-shard-groups).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/updateShardGroup.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService.UpdateShardGroup](../api-ref/grpc/Cluster/updateShardGroup.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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
             "shard_group_name": "<имя_группы_шардов>",
             "update_mask": {
               "paths": [
                 "description", "shard_names", "external_shards"
               ]
             },
             "description": "<описание_группы_шардов>",
             "shard_names": [
               "<шард_1>", "<шард_2>", ... "<шард_N>"
             ],
             "external_shards" [
               {
                 "name": "<внешний_шард_1>",
                 "weight": <вес_шарда_при_записи_данных>,
                 "replicas": [
                   {
                     "host": "<FQDN_хоста>",
                     "port": <порт>,
                     "secure": <использовать_SSL_соединение>,
                     "user": "<имя_пользователя>",
                     "password": "<пароль>",
                     "priority": <приоритет_хоста>
                   },
                   {
                     <параметры_хоста_2>
                   },
                   ...
                   {
                     <параметры_хоста_N>
                   }
                 ]
               },
               {
                 <параметры_внешнего_шарда_2>
               },
               ...
               {
                 <параметры_внешнего_шарда_N>
               }
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.clickhouse.v1.ClusterService.UpdateShardGroup
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.
     * `description` — новое описание группы шардов.
     * `shard_names` — новый список шардов кластера, которые нужно включить в группу. Чтобы узнать имена шардов, [получите их список](shards.md#list-shards) в кластере. Этот список заменит собой текущий: убедитесь, что вы включили в новый список все необходимые шарды.
     * `external_shards` — список внешних шардов с измененными параметрами, которые нужно включить в группу. Внешний шард — это шард в другом кластере {{ mch-name }} или пользовательской инсталляции {{ CH }}. Каждый элемент соответствует отдельному шарду и имеет следующую структуру:

        * `name` — имя шарда.
          
          {% include [shard-groups-name-limits](../../_includes/mdb/mch/shard-groups-name-limits.md) %}

        * `weight` — вес шарда в группе.

          {% include [shard priority weight](../../_includes/mdb/mch/ext-shard-priority-weight.md) %}

        * `replicas` — настройки хостов шарда:

          * `host` — FQDN или IP-адрес хоста.
            
            О том, как получить FQDN хоста {{ CH }}, в [соответствующей инструкции](connect/fqdn.md#get-fqdn).
            
          * `port` — порт для подключения к {{ CH }}.
          * `secure` — использование шифрованного SSL/TLS-соединения при подключении к хосту: `true` или `false`.
          * `user`, `password` — имя пользователя и пароль для доступа к БД {{ CH }}.
          * `priority` — приоритет хоста для балансировки подключений к шарду. Значение по умолчанию — `0`. Чем ниже значение, тем выше приоритет при выборе хоста для подключения к шарду.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя группы шардов — со [списком групп в кластере](#list-shard-groups).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/updateShardGroup.md#yandex.cloud.operation.Operation).

{% endlist %}

## Удалить группу шардов {#delete-shard-group}

Удаление группы шардов не затрагивает входящие в нее шарды — они остаются в кластере.

Таблицы, созданные поверх удаляемой группы, остаются, но становятся неработоспособными: попытки выполнить запрос к ним приведут к ошибкам. Однако такие таблицы можно удалить до или после удаления группы шардов.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится кластер.
  1. [Перейдите]({{ link-console-main }}/link/managed-clickhouse) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_shard-groups }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) для нужной группы шардов и выберите пункт **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить группу шардов в кластере, выполните команду:

  ```bash
  {{ yc-mdb-ch }} shard-groups delete \
     --cluster-name=<имя_кластера> \
     --name=<имя_группы_шардов>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  Имя группы шардов можно запросить со [списком групп шардов в кластере](#list-shard-groups).


- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, в разделе [Создание кластера](cluster-create.md).
  1. Удалите из описания кластера {{ mch-name }} блок описания нужной группы шардов `shard_group`.
  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Введите слово `yes` и нажмите **Enter**.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster_v2).

  {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}


- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.DeleteShardGroup](../api-ref/Cluster/deleteShardGroup.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/shardGroups/<имя_группы_шардов>'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя группы шардов — со [списком групп в кластере](#list-shard-groups).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/deleteShardGroup.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService.DeleteShardGroup](../api-ref/grpc/Cluster/deleteShardGroup.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "shard_group_name": "<имя_группы_шардов>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.clickhouse.v1.ClusterService.DeleteShardGroup
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя группы шардов — со [списком групп в кластере](#list-shard-groups).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/deleteShardGroup.md#yandex.cloud.operation.Operation).

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
