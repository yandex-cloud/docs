# Управление группами шардов в кластере {{ CH }}

Вы можете сгруппировать несколько [шардов](../concepts/sharding.md) кластера {{ CH }} в _группу шардов_ и затем размещать таблицы в этой группе.

## Получить список групп шардов в кластере {#list-shard-groups}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
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

  1. Воспользуйтесь методом [Cluster.ListShardGroups](../api-ref/Cluster/listShardGroups.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

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
  1. Воспользуйтесь вызовом [ClusterService.ListShardGroups](../api-ref/grpc/Cluster/listShardGroups.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
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

  1. Воспользуйтесь методом [Cluster.GetShardGroup](../api-ref/Cluster/getShardGroup.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

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
  1. Воспользуйтесь вызовом [ClusterService.GetShardGroup](../api-ref/grpc/Cluster/getShardGroup.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_shard-groups }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.shard-groups.button_add-group }}**.
  1. Заполните поля формы и нажмите кнопку **{{ ui-key.yacloud.common.apply }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать группу шардов в кластере, выполните команду:

  ```bash
  {{ yc-mdb-ch }} shard-groups create \
    --cluster-name=<имя_кластера> \
    --name=<имя_группы_шардов> \
    --description=<описание_группы_шардов> \
    --shards=<список_имен_шардов>
  ```

  Где `--shards` — список имен шардов, которые нужно включить в группу.

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  Имена шардов можно запросить со [списком шардов в кластере](shards.md#list-shards).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  1. Добавьте к описанию кластера {{ mch-name }} блок описания группы шардов `shard_group`.

     ```hcl
     resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
       ...
       shard_group {
         name        = "<имя_группы_шардов>"
         description = "<необязательное_описание_группы_шардов>"
         shard_names = [
           # Список шардов, входящих в группу
           "<имя_шарда_1>",
           ...
           "<имя_шарда_N>"
         ]
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

  1. Воспользуйтесь методом [Cluster.CreateShardGroup](../api-ref/Cluster/createShardGroup.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

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
                 ]
               }'
     ```

     Где:

     * `shardGroupName` — название группы шардов.
     * `description` — описание группы шардов.
     * `shardNames` — список шардов, которые нужно включить в создаваемую группу.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/createShardGroup.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService.CreateShardGroup](../api-ref/grpc/Cluster/createShardGroup.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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
               ]
             }' \
         {{ api-host-mdb }}:{{ port-https }} \
         yandex.cloud.mdb.clickhouse.v1.ClusterService.CreateShardGroup
     ```

     Где:

     * `shard_group_name` — название группы шардов.
     * `description` — описание группы шардов.
     * `shard_names` — список шардов, которые нужно включить в создаваемую группу.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/createShardGroup.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить группу шардов {#update-shard-group}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_shard-groups }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) для нужной группы шардов и выберите пункт **{{ ui-key.yacloud.common.edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить группу шардов в кластере, выполните команду:

  ```bash
  {{ yc-mdb-ch }} shard-groups update \
    --cluster-name=<имя_кластера> \
    --name=<имя_группы_шардов> \
    --description=<новое_описание_группы_шардов> \
    --shards=<новый_список_имен_шардов>
  ```

  Где `--shards` — новый список имен шардов, которые нужно включить в группу.

  Эта команда заменяет существующий список шардов в группе новым, который был передан команде в параметре `--shards`. Перед выполнением команды убедитесь, что вы включили в новый список все необходимые шарды.

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  Имя группы шардов можно запросить со [списком групп шардов в кластере](#list-shard-groups).

  Имена шардов можно запросить со [списком шардов в кластере](shards.md#list-shards).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  1. Измените в описании кластера {{ mch-name }} блок `shard_group` с нужной группой шардов:

     ```hcl
     resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
       ...
       shard_group {
         name        = "<новое_имя_группы_шардов>"
         description = "<новое_описание_группы_шардов>"
         shard_names = [
           # Новый список входящих в группу шардов
           "<имя_шарда_1>",
           ...
           "<имя_шарда_N>"
         ]
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

  1. Воспользуйтесь методом [Cluster.updateShardGroup](../api-ref/Cluster/updateShardGroup.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/shardGroups/<имя_группы_шардов>' \
       --data '{
                 "updateMask": "description,shardNames",
                 "description": "<описание_группы_шардов>",
                 "shardNames": [
                   "<шард_1>", "<шард_2>", ... "<шард_N>"
                 ]
               }'
     ```

     Где:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.
     * `description` — новое описание группы шардов.
     * `shardNames` — новый список шардов, которые нужно включить в группу. Чтобы узнать имена шардов, [получите их список](shards.md#list-shards) в кластере. Этот список заменит собой текущий: убедитесь, что вы включили в новый список все необходимые шарды.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя группы шардов — со [списком групп в кластере](#list-shard-groups).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/updateShardGroup.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService.UpdateShardGroup](../api-ref/grpc/Cluster/updateShardGroup.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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
                 "description", "shard_names"
               ]
             },
             "description": "<описание_группы_шардов>",
             "shard_names": [
               "<шард_1>", "<шард_2>", ... "<шард_N>"
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.clickhouse.v1.ClusterService.UpdateShardGroup
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.
     * `description` — новое описание группы шардов.
     * `shard_names` — новый список шардов, которые нужно включить в группу. Чтобы узнать имена шардов, [получите их список](shards.md#list-shards) в кластере. Этот список заменит собой текущий: убедитесь, что вы включили в новый список все необходимые шарды.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя группы шардов — со [списком групп в кластере](#list-shard-groups).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/updateShardGroup.md#yandex.cloud.operation.Operation).

{% endlist %}

## Удалить группу шардов {#delete-shard-group}

Удаление группы шардов не затрагивает входящие в нее шарды — они остаются в кластере.

Таблицы, созданные поверх удаляемой группы, остаются, но становятся неработоспособными: попытки выполнить запрос к ним приведут к ошибкам. Однако такие таблицы можно удалить до или после удаления группы шардов.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
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

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  1. Удалите из описания кластера {{ mch-name }} блок описания нужной группы шардов `shard_group`.
  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Введите слово `yes` и нажмите **Enter**.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.DeleteShardGroup](../api-ref/Cluster/deleteShardGroup.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

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
  1. Воспользуйтесь вызовом [ClusterService.DeleteShardGroup](../api-ref/grpc/Cluster/deleteShardGroup.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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
