---
title: Управление ресурсными группами в {{ mtr-name }}
description: Вы можете получить информацию о конфигурации ресурсных групп, задать или удалить ее.
---

# Управление ресурсными группами в {{ mtr-name }}

В {{ mtr-name }} вы можете управлять конфигурацией [ресурсных групп](../concepts/resource-groups.md):
* [получить информацию о текущей конфигурации](#get),
* [задать конфигурацию при создании кластера](#set-at-create),
* [задать или изменить конфигурацию для существующего кластера](#set-at-update),
* [удалить конфигурацию](#delete).

## Получить информацию о конфигурации ресурсных групп {#get}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Нажмите на имя нужного кластера.
  1. Перейдите в блок **{{ ui-key.yacloud.trino.section_resource-management }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить описание ресурсных групп и правил маршрутизации в кластере {{ mtr-name }}, выполните команду:

  ```bash
  {{ yc-mdb-tr }} cluster get-resource-groups <имя_или_идентификатор_кластера>
  ```

  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.Get](../api-ref/Cluster/get.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<идентификатор_кластера>'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

    1. Описание ресурсных групп и правил маршрутизации в кластере {{ mtr-name }} содержится в [ответе сервера](../api-ref/Cluster/get.md#yandex.cloud.trino.v1.Cluster) в поле `resourceGroups`.

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService.Get](../api-ref/grpc/Cluster/get.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/trino/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>"
                }' \
            {{ api-host-trino }}:{{ port-https }} \
            yandex.cloud.trino.v1.ClusterService.Get
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

    1. Описание ресурсных групп и правил маршрутизации в кластере {{ mtr-name }} содержится в [ответе сервера](../api-ref/grpc/Cluster/get.md#yandex.cloud.trino.v1.Cluster) в поле `resource_groups`.

{% endlist %}

## Задать конфигурацию ресурсных групп при создании кластера {#set-at-create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер {{ mtr-name }}.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}** и задайте параметры кластера.
  1. Перейдите в блок **{{ ui-key.yacloud.trino.section_resource-management }}**.
  1. В поле **{{ ui-key.yacloud.trino.ClusterView.label_cpu-quota-period_tD5vD }}** задайте период расчета квоты CPU для ресурсных групп.
  1. Нажмите кнопку **{{ ui-key.yacloud.trino.ClusterForm.ResourceGroupsTable.button_add-group_m99qN }}** и задайте параметры ресурсной группы:

     {% include [resources-rg-params-console](../../_includes/managed-trino/resources-rg-params-console.md) %}

  1. (Опционально) Добавьте другие ресурсные группы аналогичным образом.
  1. Нажмите кнопку **{{ ui-key.yacloud.trino.ClusterForm.SelectorRulesTable.button_add-rule_3Gide }}** и задайте параметры правила:

     {% include [resources-sel-params-console](../../_includes/managed-trino/resources-sel-params-console.md) %}

  1. (Опционально) Добавьте другие правила маршрутизации аналогичным образом.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы задать конфигурацию ресурсных групп:

  1. Создайте файл с описанием ресурсных групп и правил маршрутизации в формате JSON или YAML. Ниже представлен пример YAML-файла `resource-groups.yaml`.

     {% include [resources-syntax-cli](../../_includes/managed-trino/resources-syntax-cli.md) %}

     Где:

     {% include [resources-params-cli-tf-rest](../../_includes/managed-trino/resources-params-cli-tf-rest.md) %}

  1. Посмотрите описание команды CLI для создания кластера:

     ```bash
     {{ yc-mdb-tr }} cluster create --help
     ```

  1. Выполните команду:

     ```bash
     {{ yc-mdb-tr }} cluster create \
       ...
       --resource-groups-from-file resource-groups.yaml
     ```

     Доступные параметры кластера и их описания представлены в [инструкции](cluster-create.md#create-cluster).

- {{ TF }} {#tf}

  1. Создайте конфигурационный файл {{ TF }} с [планом инфраструктуры](cluster-create.md).

  1. Добавьте в описание кластера блок `resource_groups`:

     {% include [resources-syntax-tf](../../_includes/managed-trino/resources-syntax-tf.md) %}

     Где:

     {% include [resources-params-cli-tf-rest](../../_includes/managed-trino/resources-params-cli-tf-rest.md) %}

     {% note info %}

     Вы также можете создать отдельный JSON-файл с описанием ресурсных групп и правил маршрутизации и передать его в параметре `resource_groups` следующим образом:

     ```hcl
     resource_groups = file("resource-groups.json")
     ```

     {% endnote %}

  2. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  3. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее в [документации провайдера {{ TF }}]({{ tf-provider-mtr-access }}).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

     ```json
     {
       <Параметры_кластера>
       ...
       "trino": {
         ...
         "resourceManagement": {
           "resourceGroups": {
             "rootGroups": [
               {
                 "name" : "<имя_ресурсной_группы>",
                 "softMemoryLimit" : "<лимит_использования_памяти>",
                 "softConcurrencyLimit" : "<мягкий_лимит_числа_запущенных_запросов>",
                 "hardConcurrencyLimit" : "<жесткий_лимит_числа_запущенных_запросов>",
                 "softCpuLimit" : "<мягкий_лимит_процессорного_времени>",
                 "hardCpuLimit" : "<жесткий_лимит_процессорного_времени>",
                 "maxQueued" : "<лимит_числа_запросов_в_очереди>",
                 "schedulingPolicy" : "<политика_планирования_запросов>",
                 "schedulingWeight" : "<вес_группы>",
                 "subGroups": [
                   {
                     <Дочерняя_ресурсная_группа_1>
                     ...
                     "subGroups" : [<список_дочерних_групп_следующих уровней>]
                   },
                   {
                     <Дочерняя_ресурсная_группа_2>
                     ...
                     "subGroups" : [<список_дочерних_групп_следующих уровней>]
                   },
                   ...
                   {
                     <Дочерняя_ресурсная_группа_N>
                     ...
                     "subGroups" : [<список_дочерних_групп_следующих уровней>]
                   }
                 ]
               },
               {
                 <Корневая_ресурсная_группа_2>
               },
               ...
               {
                 <Корневая_ресурсная_группа_N>
               }
             ],
             "selectors": [
               {
                 "user": "<регулярное_выражение_для_имен_пользователей>",
                 "userGroup": "<регулярное_выражение_для_групп_пользователей>",
                 "queryType": "<тип_запроса>",
                 "source": "<регулярное_выражение_для_источников_запросов>",
                 "clientTags": ["<список_тегов>"],
                 "group": "<имя_ресурсной_группы>"
               },
               {
                 <Правило_маршрутизации_2> 
               },
               ...
               {
                 <Правило_маршрутизации_N>
               }
             ],
             "cpuQuotaPeriod": "<период_расчета_квоты_CPU>"
           }
           ...
         },
       }
     }
     ```

     Где:

     {% include [resources-params-cli-tf-rest](../../_includes/managed-trino/resources-params-cli-tf-rest.md) %}

  1. Воспользуйтесь методом [Cluster.Create](../api-ref/Cluster/create.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
         --request POST \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters'
         --data '@body.json'
     ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}
  
  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

     ```json
     {
       <Параметры_кластера>
       ...
       "trino": {
         ...
         "resource_management": {
           "resource_groups": {
             "root_groups": [
               {
                 "name" : "<имя_ресурсной_группы>",
                 "soft_memory_limit" : "<лимит_использования_памяти>",
                 "soft_concurrency_limit" : "<мягкий_лимит_числа_запущенных_запросов>",
                 "hard_concurrency_limit" : "<жесткий_лимит_числа_запущенных_запросов>",
                 "soft_cpu_limit" : "<мягкий_лимит_процессорного_времени>",
                 "hard_cpu_limit" : "<жесткий_лимит_процессорного_времени>",
                 "max_queued" : "<лимит_числа_запросов_в_очереди>",
                 "scheduling_policy" : "<политика_планирования_запросов>",
                 "scheduling_weight" : "<вес_группы>",
                 "sub_groups": [
                   {
                     <Дочерняя_ресурсная_группа_1>
                     ...
                     "sub_groups" : [<список_дочерних_групп_следующих уровней>]
                   },
                   {
                     <Дочерняя_ресурсная_группа_2>
                     ...
                     "sub_groups" : [<список_дочерних_групп_следующих уровней>]
                   },
                   ...
                   {
                     <Дочерняя_ресурсная_группа_N>
                     ...
                     "sub_groups" : [<список_дочерних_групп_следующих уровней>]
                   }
                 ]
               },
               {
                 <Корневая_ресурсная_группа_2>
               },
               ...
               {
                 <Корневая_ресурсная_группа_N>
               }
             ],
             "selectors": [
               {
                 "user": "<регулярное_выражение_для_имен_пользователей>",
                 "user_group": "<регулярное_выражение_для_групп_пользователей>",
                 "query_type": "<тип_запроса>",
                 "source": "<регулярное_выражение_для_источников_запросов>",
                 "client_tags": ["<список_тегов>"],
                 "group": "<имя_ресурсной_группы>"
               },
               {
                 <Правило_маршрутизации_2> 
               },
               ...
               {
                 <Правило_маршрутизации_N>
               }
             ],
             "cpu_quota_period": "<период_расчета_квоты_CPU>"
           }
           ...
         },
       }
     }
     ```

     Где:

     {% include [resources-params-grpc](../../_includes/managed-trino/resources-params-grpc.md) %}

     Доступные параметры кластера и их описания представлены в [инструкции](cluster-create.md#create-cluster).

  1. Воспользуйтесь вызовом [ClusterService.Create](../api-ref/grpc/Cluster/create.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/trino/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          {{ api-host-trino }}:{{ port-https }} \
          yandex.cloud.trino.v1.ClusterService.Create \
          < body.json
      ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Задать или изменить конфигурацию ресурсных групп кластера {#set-at-update}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Нажмите на имя нужного кластера.
  1. Перейдите в блок **{{ ui-key.yacloud.trino.section_resource-management }}**.
  1. В поле **{{ ui-key.yacloud.trino.ClusterView.label_cpu-quota-period_tD5vD }}** задайте новое значение периода расчета квоты CPU для ресурсных групп.
  1. Чтобы добавить новую ресурсную группу, нажмите кнопку **{{ ui-key.yacloud.trino.ClusterForm.ResourceGroupsTable.button_add-group_m99qN }}** и задайте параметры группы:

     {% include [resources-rg-params-console](../../_includes/managed-trino/resources-rg-params-console.md) %}

  1. (Опционально) Добавьте другие ресурсные группы аналогичным образом.
  1. Чтобы отредактировать ресурсную группу:
     1. В строке этой группы нажмите на значок ![trash-bin](../../_assets/console-icons/pencil.svg).
     1. Измените параметры группы и нажмите кнопку **{{ ui-key.yacloud.common.edit }}**.
  1. Чтобы добавить новое правило маршрутизации, нажмите кнопку **{{ ui-key.yacloud.trino.ClusterForm.SelectorRulesTable.button_add-rule_3Gide }}** и задайте параметры правила:

     {% include [resources-sel-params-console](../../_includes/managed-trino/resources-sel-params-console.md) %}

  1. (Опционально) Добавьте другие правила маршрутизации аналогичным образом.
  1. Чтобы отредактировать правило маршрутизации:
     1. В строке этого правила нажмите на значок ![pencil](../../_assets/console-icons/pencil.svg).
     1. Измените параметры правила.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save-changes }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы задать конфигурацию ресурсных групп:

  1. Если описание ресурсных групп и правил маршрутизации в кластере {{ mtr-name }} еще не задано, создайте файл с описанием в формате JSON или YAML. Ниже представлен пример YAML-файла `resource-groups.yaml`.

     {% include [resources-syntax-cli](../../_includes/managed-trino/resources-syntax-cli.md) %}

     Где:

     {% include [resources-params-cli-tf-rest](../../_includes/managed-trino/resources-params-cli-tf-rest.md) %}

  1. Если описание ресурсных групп и правил маршрутизации уже задано, откройте файл `resource-groups.yaml` и внесите в него изменения. Вы можете:

     * добавить новые ресурсные группы и правила маршрутизации;
     * изменить параметры существующих групп и правил;
     * удалить ненужные группы и правила.

  1. Выполните команду:

  ```bash
  {{ yc-mdb-tr }} cluster set-resource-groups <имя_или_идентификатор_кластера> \
     --from-file resource-groups.yaml
  ```

  Имя и идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.   

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  
     Инструкция по созданию файла описана в разделе [Создание кластера](cluster-create.md).
  
  1. Если описание ресурсных групп и правил маршрутизации в кластере {{ mtr-name }} еще не задано, добавьте в описание кластера блок `resource_groups`:

     {% include [resources-syntax-tf](../../_includes/managed-trino/resources-syntax-tf.md) %}

     Где:

     {% include [resources-params-cli-tf-rest](../../_includes/managed-trino/resources-params-cli-tf-rest.md) %}

     {% note info %}

     Вы также можете создать отдельный JSON-файл с описанием ресурсных групп и правил маршрутизации и передать его в параметре `resource_groups` следующим образом:

     ```hcl
     resource_groups = file("resource-groups.json")
     ```

     {% endnote %}

  1. Если описание ресурсных групп и правил маршрутизации уже задано, внесите правки в блок `resource_groups` или JSON-файл. Вы можете:

     * добавить новые ресурсные группы и правила маршрутизации;
     * изменить параметры существующих групп и правил;
     * удалить ненужные группы и правила.

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее в [документации провайдера {{ TF }}]({{ tf-provider-mtr-access }}).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

     ```json
     {
       "updateMask": "<список_изменяемых_параметров>",
       "trino": {
         "resourceManagement": {
           "resourceGroups": {
             "rootGroups": [
               {
                 "name" : "<имя_ресурсной_группы>",
                 "softMemoryLimit" : "<лимит_использования_памяти>",
                 "softConcurrencyLimit" : "<мягкий_лимит_числа_запущенных_запросов>",
                 "hardConcurrencyLimit" : "<жесткий_лимит_числа_запущенных_запросов>",
                 "softCpuLimit" : "<мягкий_лимит_процессорного_времени>",
                 "hardCpuLimit" : "<жесткий_лимит_процессорного_времени>",
                 "maxQueued" : "<лимит_числа_запросов_в_очереди>",
                 "schedulingPolicy" : "<политика_планирования_запросов>",
                 "schedulingWeight" : "<вес_группы>",
                 "subGroups": [
                   {
                     <Дочерняя_ресурсная_группа_1>
                     ...
                     "subGroups" : [<список_дочерних_групп_следующих уровней>]
                   },
                   {
                     <Дочерняя_ресурсная_группа_2>
                     ...
                     "subGroups" : [<список_дочерних_групп_следующих уровней>]
                   },
                   ...
                   {
                     <Дочерняя_ресурсная_группа_N>
                     ...
                     "subGroups" : [<список_дочерних_групп_следующих уровней>]
                   }
                 ]
               },
               {
                 <Корневая_ресурсная_группа_2>
               },
               ...
               {
                 <Корневая_ресурсная_группа_N>
               }
             ],
             "selectors": [
               {
                 "user": "<регулярное_выражение_для_имен_пользователей>",
                 "userGroup": "<регулярное_выражение_для_групп_пользователей>",
                 "queryType": "<тип_запроса>",
                 "source": "<регулярное_выражение_для_источников_запросов>",
                 "clientTags": ["<список_тегов>"],
                 "group": "<имя_ресурсной_группы>"
               },
               {
                 <Правило_маршрутизации_2> 
               },
               ...
               {
                 <Правило_маршрутизации_N>
               }
             ],
             "cpuQuotaPeriod": "<период_расчета_квоты_CPU>"
           }
           ...
         },
       }
     }
     ```

     Где:

     * `updateMask` — перечень изменяемых параметров в строку через запятую.

       {% note warning %}

       При изменении кластера все параметры изменяемого объекта, которые не были явно переданы в запросе, будут переопределены на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask`.

       {% endnote %}

     {% include [resources-params-cli-tf-rest](../../_includes/managed-trino/resources-params-cli-tf-rest.md) %}

  1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<идентификатор_кластера>'
       --data '@body.json'
     ```

     Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

     ```json
     {
       "cluster_id": "<идентификатор_кластера>",
         "update_mask": {
           "paths": [
             <список_изменяемых_параметров>
           ]
         },
       "trino": {
         "resource_management": {
           "resource_groups": {
             "root_groups": [
               {
                 "name" : "<имя_ресурсной_группы>",
                 "soft_memory_limit" : "<лимит_использования_памяти>",
                 "soft_concurrency_limit" : "<мягкий_лимит_числа_запущенных_запросов>",
                 "hard_concurrency_limit" : "<жесткий_лимит_числа_запущенных_запросов>",
                 "soft_cpu_limit" : "<мягкий_лимит_процессорного_времени>",
                 "hard_cpu_limit" : "<жесткий_лимит_процессорного_времени>",
                 "max_queued" : "<лимит_числа_запросов_в_очереди>",
                 "scheduling_policy" : "<политика_планирования_запросов>",
                 "scheduling_weight" : "<вес_группы>",
                 "sub_groups": [
                   {
                     <Дочерняя_ресурсная_группа_1>
                     ...
                     "sub_groups" : [<список_дочерних_групп_следующих уровней>]
                   },
                   {
                     <Дочерняя_ресурсная_группа_2>
                     ...
                     "sub_groups" : [<список_дочерних_групп_следующих уровней>]
                   },
                   ...
                   {
                     <Дочерняя_ресурсная_группа_N>
                     ...
                     "sub_groups" : [<список_дочерних_групп_следующих уровней>]
                   }
                 ]
               },
               {
                 <Корневая_ресурсная_группа_2>
               },
               ...
               {
                 <Корневая_ресурсная_группа_N>
               }
             ],
             "selectors": [
               {
                 "user": "<регулярное_выражение_для_имен_пользователей>",
                 "user_group": "<регулярное_выражение_для_групп_пользователей>",
                 "query_type": "<тип_запроса>",
                 "source": "<регулярное_выражение_для_источников_запросов>",
                 "client_tags": ["<список_тегов>"],
                 "group": "<имя_ресурсной_группы>"
               },
               {
                 <Правило_маршрутизации_2> 
               },
               ...
               {
                 <Правило_маршрутизации_N>
               }
             ],
             "cpu_quota_period": "<период_расчета_квоты_CPU>"
           }
           ...
         },
       }
     }
     ```

     Где:

     * `cluster_id` — идентификатор кластера.

         Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.
         {% cut "Формат перечисления настроек" %}
         ```yaml
         "update_mask": {
           "paths": [
             "<настройка_1>",
             "<настройка_2>",
             ...
             "<настройка_N>"
           ]
         }
         ```
         {% endcut %}

         {% note warning %}

         При изменении кластера все параметры изменяемого объекта, которые не были явно переданы в запросе, будут переопределены на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask`.

         {% endnote %}

     {% include [resources-params-grpc](../../_includes/managed-trino/resources-params-grpc.md) %}

  1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/trino/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d @ \
       {{ api-host-trino }}:{{ port-https }} \
       yandex.cloud.trino.v1.ClusterService.Update \
       < body.json
     ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Удалить конфигурацию ресурсных групп {#delete}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Нажмите на имя нужного кластера.
  1. Перейдите в блок **{{ ui-key.yacloud.trino.section_resource-management }}**.
  1. Чтобы удалить ненужные ресурсные группы:
     1. В строке ресурсной группы, которую вы хотите удалить, нажмите на значок ![trash-bin](../../_assets/console-icons/trash-bin.svg).
     1. (Опционально) Удалите другие ресурсные группы аналогичным образом.
  1. Чтобы удалить ненужные правила маршрутизации:
     1. В строке правила, которое вы хотите удалить, нажмите на значок ![trash-bin](../../_assets/console-icons/trash-bin.svg).
     1. (Опционально) Удалите другие правила маршрутизации аналогичным образом.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save-changes }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить все ресурсные группы и правила маршрутизации, выполните команду:

  ```bash
  {{ yc-mdb-tr }} cluster remove-resource-groups <имя_или_идентификатор_кластера>
  ```

  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  
      Инструкция по созданию файла описана в разделе [Создание кластера](cluster-create.md).
  
  1. Чтобы удалить все ресурсные группы и правила маршрутизации, удалите из описания кластера параметр `resource_groups`.

  1. Проверьте корректность настроек.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Подтвердите изменение ресурсов.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "updateMask": "trino.resourceManagement.resourceGroups",
          "trino": {
            "resourceManagement": {
              "resourceGroups": {}
            }
          }
        }
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в строку через запятую.

            {% note warning %}

            При изменении кластера все параметры изменяемого объекта, которые не были явно переданы в запросе, будут переопределены на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask`.

            {% endnote %}

        * `resourceGroups` — описание ресурсных групп и правил маршрутизации.

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<идентификатор_кластера>'
          --data '@body.json'
        ```

        Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

      ```json
      {
        "cluster_id": "<идентификатор_кластера>",
        "update_mask": {
          "paths": [
            "trino.resource_management.resource_groups"
          ]
        },
        "trino": {
          "resource_management": {
            "resource_groups": {}
          }
        }
      }
      ```

      Где:

      * `cluster_id` — идентификатор кластера.
          
          Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

          {% cut "Формат перечисления настроек" %}

          ```yaml
          "update_mask": {
            "paths": [
              "<настройка_1>",
              "<настройка_2>",
              ...
              "<настройка_N>"
            ]
          }
          ```

          {% endcut %}

          {% note warning %}

          При изменении кластера все параметры изменяемого объекта, которые не были явно переданы в запросе, будут переопределены на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask`.

          {% endnote %}

      * `resource_groups` — описание ресурсных групп и правил маршрутизации.

  1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d @ \
        {{ api-host-trino }}:{{ port-https }} \
        yandex.cloud.trino.v1.ClusterService.Update \
        < body.json
      ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Пример конфигурации ресурсных групп в кластере {{ mtr-name }} {#example}

В примере используются следующие ресурсные группы:

* `global` — корневая группа, задающая общие лимиты `hardConcurrencyLimit` и `maxQueued`. Группа `global` содержит дочерние группы `adm`, `bi`, `etl` и `adhoc`.

* `adm` — группа для запросов администраторов и запросов с типом `DATA_DEFINITION`. Благодаря высокому значению `schedulingWeight` снижается вероятность блокировки этих запросов пользовательской нагрузкой.

* `bi` — группа для запросов систем бизнес-аналитики. В этой группе используется лимит `softMemoryLimit`, чтобы запросы не занимали слишком много памяти и не вытесняли другие типы запросов. Внутри этой группы для каждого инструмента создается экземпляр дочерней группы с динамически сформированным именем. Внутри группы каждого инструмента создаются экземпляры дочерних групп для каждого пользователя. Это задает отдельный лимит для каждого инструмента и пользователя. В результате ограничивается влияние запросов от разных пользователей и разных инструментов друг на друга.

* `etl` — группа для запросов извлечения, преобразования и загрузки данных. В этой группе используются лимиты `softCpuLimit` и `hardCpuLimit`, чтобы ограничить потребление процессорного времени запросами.

* `adhoc` — группа для интерактивных пользовательских запросов. Внутри этой группы для каждого пользователя создается экземпляр дочерней группы с динамически сформированным именем. Это задает отдельный лимит для каждого пользователя, что ограничивает влияние запросов от разных пользователей друг на друга.

Между группами `adm`, `bi`, `etl` и `adhoc` запросы распределяются в соответствии с политикой планирования `weighted_fair`. Для группы `adhoc` не указан параметр `schedulingWeight`, поэтому используется значение по умолчанию — `1`. Для групп `bi` и `adhoc` не указана политика планирования, поэтому между их дочерними группами запросы распределяются в соответствии с политикой по умолчанию `fair`.

Для направления запросов в группы используются следующие правила маршрутизации:

1. Запросы пользователей из группы `admins` направляются в ресурсную группу `global.adm`.

1. Запросы с тегом `etl_job` направляются в группу `global.etl`.

1. Запросы с типом `DATA_DEFINITION` направляются в ресурсную группу `global.adm`. Благодаря этому запросы для вызова процедуры `system.runtime.kill_query()` не будут ожидать завершения других пользовательских запросов.

1. Запросы типа `SELECT` от источника с именем вида `jdbc#(?<toolname>[^#]+)` направляются в группу-шаблон `global.bi.${toolname}.${USER}`. Например, запрос пользователя `bob` от источника `jdbc#grafana` будет направлен в экземпляр группы с именем `global.bi.grafana.bob`.

1. Все остальные запросы направляются в группу-шаблон `global.adhoc.${USER}`. Например, запрос пользователя `bob` будет направлен в экземпляр группы с именем `global.adhoc.bob`.

{% list tabs group=instructions %}

- CLI {#cli}

  Файл `resource-groups.json` этого примера:

  {% include [resources-example](../../_includes/managed-trino/resources-example.md) %}

- {{ TF }} {#tf}

  Файл `resource-groups.json` этого примера:

  {% include [resources-example](../../_includes/managed-trino/resources-example.md) %}

- REST API {#api}

  Файл `body.json` этого примера:

  ```json
  {
    "updateMask": "trino.resourceManagement.resourceGroups",
    "trino": {
      "resourceManagement": {
        "resourceGroups": {
          "rootGroups": [
            {
              "name": "global",
              "hardConcurrencyLimit": "20",
              "maxQueued": "200",
              "schedulingPolicy": "weighted_fair",
              "subGroups": [
                {
                  "name": "adm",
                  "hardConcurrencyLimit": "5",
                  "maxQueued": "50",
                  "schedulingWeight": "5"
                },
                {
                  "name": "bi",
                  "hardConcurrencyLimit": "10",
                  "softMemoryLimit": "20%",
                  "maxQueued": "100",
                  "schedulingWeight": "3",
                  "subGroups": [
                    {
                      "name": "${toolname}",
                      "hardConcurrencyLimit": "5",
                      "maxQueued": "50",
                      "subGroups": [
                        {
                          "name": "${USER}",
                          "hardConcurrencyLimit": "2",
                          "maxQueued": "20"
                        }
                      ]
                    }
                  ]
                },
                {
                  "name": "etl",
                  "hardConcurrencyLimit": "5",
                  "softCpuLimit": "20s",
                  "hardCpuLimit": "40s",
                  "maxQueued": "50",
                  "schedulingWeight": "1"
                },
                {
                  "name": "adhoc",
                  "hardConcurrencyLimit": "5",
                  "maxQueued": "100",
                  "subGroups": [
                    {
                      "name": "${USER}",
                      "hardConcurrencyLimit": "2",
                      "maxQueued": "20"
                    }
                  ]
                }
              ]
            }
          ],
          "selectors": [
            {
              "userGroup": "admins",
              "group": "global.adm"
            },
            {
              "clientTags": ["etl_job"],
              "group": "global.etl"
            },
            {
              "queryType": "DATA_DEFINITION",
              "group": "global.adm"
            },
            {
              "source": "jdbc#(?<toolname>[^#]+)",
              "queryType": "SELECT",
              "group": "global.bi.${toolname}.${USER}"
            },
            {
              "group": "global.adhoc.${USER}"
            }
          ],
          "cpuQuotaPeriod": "1m"
        }
      }
    }
  }
  ```

- gRPC API {#grpc-api}

  Файл `body.json` этого примера:

  ```json
  {
    "cluster_id": "<идентификатор_кластера>",
    "update_mask": {
      "paths": [
        "trino.resource_management.resource_groups"
      ]
    },
    "trino": {
      "resource_management": {
        "resource_groups": {
          "root_groups": [
            {
              "name": "global",
              "hard_concurrency_limit": "20",
              "max_queued": "200",
              "scheduling_policy": "weighted_fair",
              "sub_groups": [
                {
                  "name": "adm",
                  "hard_concurrency_limit": "5",
                  "max_queued": "50",
                  "scheduling_weight": "5"
                },
                {
                  "name": "bi",
                  "hard_concurrency_limit": "10",
                  "soft_memory_limit": "20%",
                  "max_queued": "100",
                  "scheduling_weight": "3",
                  "sub_groups": [
                    {
                      "name": "${toolname}",
                      "hard_concurrency_limit": "5",
                      "max_queued": "50",
                      "sub_groups": [
                        {
                          "name": "${USER}",
                          "hard_concurrency_limit": "2",
                          "max_queued": "20"
                        }
                      ]
                    }
                  ]
                },
                {
                  "name": "etl",
                  "hard_concurrency_limit": "5",
                  "soft_cpu_limit": "20s",
                  "hard_cpu_limit": "40s",
                  "max_queued": "50",
                  "scheduling_weight": "1"
                },
                {
                  "name": "adhoc",
                  "hard_concurrency_limit": "5",
                  "max_queued": "100",
                  "sub_groups": [
                    {
                      "name": "${USER}",
                      "hard_concurrency_limit": "2",
                      "max_queued": "20"
                    }
                  ]
                }
              ]
            }
          ],
          "selectors": [
            {
              "user_group": "admins",
              "group": "global.adm"
            },
            {
              "client_tags": ["etl_job"],
              "group": "global.etl"
            },
            {
              "query_type": "DATA_DEFINITION",
              "group": "global.adm"
            },
            {
              "source": "jdbc#(?<toolname>[^#]+)",
              "query_type": "SELECT",
              "group": "global.bi.${toolname}.${USER}"
            },
            {
              "group": "global.adhoc.${USER}"
            }
          ],
          "cpu_quota_period": "1m"
        }
      }
    }
  }
  ```

{% endlist %}
