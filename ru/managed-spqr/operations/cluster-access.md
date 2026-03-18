---
title: Управление доступом к кластеру {{ mspqr-full-name }}
description: Следуя данной инструкции, вы настроите права доступа к кластеру {{ mspqr-name }}.
---

# Управление доступом к кластеру {{ mspqr-name }}

Вы можете предоставить пользователю или сервисному аккаунту [роль](../security.md) для доступа к конкретному [кластеру](../concepts/index.md).

Таким образом вы можете гранулярно назначать разные роли на конкретные кластеры для разных пользователей и сервисных аккаунтов.


{% note warning %}

Учитывайте, что помимо роли для доступа к кластеру у пользователя должна быть минимальная роль для просмотра ресурсов в каталоге, например [managed-spqr.viewer](../security.md#managed-spqr-viewer) (для просмотра информации обо всех кластерах в каталоге) или примитивная [viewer](../../iam/security/index.md#viewer) (для просмотра всех ресурсов в каталоге).

Например, вы можете выдать пользователю роль [managed-spqr.viewer](../security.md#managed-spqr-viewer) на каталог и роль [managed-spqr.editor](../security.md#managed-spqr-editor) для управления конкретным кластером. Таким образом пользователь сможет просматривать информацию обо всех кластерах каталога, а работать только с конкретным кластером.

Для разграничения возможности просмотра списка кластеров разными пользователями рекомендуем использовать разные каталоги в облаке.

{% endnote %}


## Получить список ролей, назначенных на кластер {#list-access-bindings}

{% list tabs group=instructions %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.ListAccessBindings](../api-ref/Cluster/listAccessBindings.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<идентификатор_кластера>:listAccessBindings'
      ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listAccessBindings.md#yandex.cloud.access.ListAccessBindingsResponse).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService.ListAccessBindings](../api-ref/grpc/Cluster/listAccessBindings.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "resource_id": "<идентификатор_кластера>"
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.spqr.v1.ClusterService.ListAccessBindings
      ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listAccessBindings.md#yandex.cloud.access.ListAccessBindingsResponse).

{% endlist %}

## Назначить роль {#add-access-binding}

{% list tabs group=instructions %}

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл с описанием кластера {{ mspqr-name }}.

      О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

  1. Добавьте описание ресурса:

      ```hcl
      resource "yandex_mdb_sharded_postgresql_cluster_iam_binding" "<локальное_имя_ресурса>" {
        cluster_id = "<идентификатор_кластера>"
        role       = "<роль>"
        members    = [
          "<тип_субъекта>:<идентификатор_субъекта>"
        ]
      }
      ```

            
      Где:

      * `cluster_id` — идентификатор кластера.
      * `role` — назначаемая [роль](../security.md#roles-list), например `managed-spqr.editor`.
      * `members` — список [субъектов](../../iam/concepts/access-control/index.md#subject), которым назначается роль, в формате: `<тип_субъекта>:<идентификатор_субъекта>`.

          Например:

          * `serviceAccount:aje6p030123a********`,
          * `userAccount:ajerq94vab34********`,
          * `system:allAuthenticatedUsers`.

          {% include [access-control-subject](../../_includes/mdb/access-control-subject.md) %}


  1. Проверьте корректность конфигурационных файлов.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_sharded_postgresql_cluster_iam_binding).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.UpdateAccessBindings](../api-ref/Cluster/updateAccessBindings.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<идентификатор_кластера>:updateAccessBindings' \
        --data '{
                  "access_binding_deltas": [
                    {
                      "action": "ADD",
                      "access_binding": {
                        "role_id": "<роль>",
                        "subject": {
                          "id": "<идентификатор_субъекта>",
                          "type": "<тип_субъекта>"
                        }
                      }
                    }
                  ]
                }'
      ```

      
      Где:

      * `access_binding_deltas.roleId` — назначаемая [роль](../security.md#roles-list), например `managed-spqr.editor`.
      * `access_binding_deltas.subject.id` — идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.
      * `access_binding_deltas.subject.type` — тип субъекта, которому назначается роль.

          {% include [access-control-subject](../../_includes/mdb/access-control-subject.md) %}



  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/updateAccessBindings.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService.UpdateAccessBindings](../api-ref/grpc/Cluster/updateAccessBindings.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "resource_id": "<идентификатор_кластера>",
              "access_binding_deltas": [
                {
                  "action": "ADD",
                  "access_binding": {
                    "role_id": "<роль>",
                    "subject": {
                      "id": "<идентификатор_субъекта>",
                      "type": "<тип_субъекта>"
                    }
                  }
                }
              ]
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.spqr.v1.ClusterService.UpdateAccessBindings
      ```
      
      Где:

      * `resource_id` — идентификатор кластера.
      * `access_binding_deltas.roleId` — назначаемая [роль](../security.md#roles-list), например `managed-spqr.editor`.
      * `access_binding_deltas.subject.id` — идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.
      * `access_binding_deltas.subject.type` — тип субъекта, которому назначается роль.

          {% include [access-control-subject](../../_includes/mdb/access-control-subject.md) %}
      


  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/updateAccessBindings.md#yandex.cloud.operation.Operation).

{% endlist %}

## Назначить несколько ролей {#set-access-bindings}

{% list tabs group=instructions %}

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

  1. Добавьте описание ресурсов:

      ```hcl
      resource "yandex_mdb_sharded_postgresql_cluster_iam_binding" "<локальное_имя_ресурса_1>" {
        cluster_id = "<идентификатор_кластера>"
        role       = "<роль_1>"
        members    = [
          "<тип_субъекта>:<идентификатор_субъекта_1>",
          "<тип_субъекта>:<идентификатор_субъекта_2>"
        ]
      }

      resource "yandex_mdb_sharded_postgresql_cluster_iam_binding" "<локальное_имя_ресурса_2>" {
        cluster_id = "<идентификатор_кластера>"
        role       = "<роль_2>"
        members    = [
          "<тип_субъекта>:<идентификатор_субъекта_3>"
        ]
      }
      ```

      
      Где:

      * `cluster_id` — идентификатор кластера.
      * `role` — назначаемая [роль](../security.md#roles-list), например `managed-spqr.editor`.
      * `members` — список [субъектов](../../iam/concepts/access-control/index.md#subject), которым назначается роль, в формате: `<тип_субъекта>:<идентификатор_субъекта>`.

          Например:

          * `serviceAccount:aje6p030123a********`,
          * `userAccount:ajerq94vab34********`,
          * `system:allAuthenticatedUsers`.

          {% include [access-control-subject](../../_includes/mdb/access-control-subject.md) %}


  1. Проверьте корректность конфигурационных файлов.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_sharded_postgresql_cluster_iam_binding).

- REST API {#api}

  {% note alert %}

  Метод `setAccessBindings` перезаписывает права доступа к ресурсу. Все текущие роли на ресурс будут удалены.

  {% endnote %}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.SetAccessBindings](../api-ref/Cluster/setAccessBindings.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<идентификатор_кластера>:setAccessBindings' \
        --data '{
                  "accessBindings": [
                    {
                      "roleId": "<роль>",
                      "subject": {
                        "id": "<идентификатор_субъекта_1>",
                        "type": "<тип_субъекта>"
                      }
                    },
                    {
                      "roleId": "<роль>",
                      "subject": {
                        "id": "<идентификатор_субъекта_2>",
                        "type": "<тип_субъекта>"
                      }
                    },
                    ...
                    {
                      "roleId": "<роль>",
                      "subject": {
                        "id": "<идентификатор_субъекта_N>",
                        "type": "<тип_субъекта>"
                      }
                    }
                  ]
                }'
      ```

      
      Где:

      * `accessBindings.roleId` — назначаемая [роль](../security.md#roles-list), например `managed-spqr.editor`.
      * `accessBindings.subject.id` — идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.
      * `accessBindings.subject.type` — тип субъекта, которому назначается роль.

          {% include [access-control-subject](../../_includes/mdb/access-control-subject.md) %}



  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/setAccessBindings.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  {% note alert %}

  Вызов `ClusterService.SetAccessBindings` полностью перезаписывает права доступа к ресурсу. Все текущие роли на ресурс будут удалены.

  {% endnote %}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService.SetAccessBindings](../api-ref/grpc/Cluster/setAccessBindings.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "resource_id": "<идентификатор_кластера>",
              "accessBindings": [
                {
                  "roleId": "<роль>",
                  "subject": {
                    "id": "<идентификатор_субъекта_1>",
                    "type": "<тип_субъекта>"
                  }
                },
                {
                  "roleId": "<роль>",
                  "subject": {
                    "id": "<идентификатор_субъекта_2>",
                    "type": "<тип_субъекта>"
                  }
                },
                ...
                {
                  "roleId": "<роль>",
                  "subject": {
                    "id": "<идентификатор_субъекта_N>",
                    "type": "<тип_субъекта>"
                  }
                }
              ]
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.spqr.v1.ClusterService.SetAccessBindings
      ```

      
      Где:

      * `resource_id` — идентификатор кластера.
      * `accessBindings.roleId` — назначаемая [роль](../security.md#roles-list), например `managed-spqr.editor`.
      * `accessBindings.subject.id` — идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.
      * `accessBindings.subject.type` — тип субъекта, которому назначается роль.

          {% include [access-control-subject](../../_includes/mdb/access-control-subject.md) %}



  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/setAccessBindings.md#yandex.cloud.operation.Operation).

{% endlist %}

## Отозвать роль {#remove-access-binding}

{% list tabs group=instructions %}

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

  1. Найдите описание ресурса с ролью, которую вы хотите отозвать, и удалите его:

      ```hcl
      resource "yandex_mdb_sharded_postgresql_cluster_iam_binding" "<локальное_имя_ресурса>" {
        cluster_id = "<идентификатор_кластера>"
        role       = "<роль>"
        members    = [
          "<тип_субъекта>:<идентификатор_субъекта>"
        ]
      }
      ```

  1. Проверьте корректность конфигурационных файлов.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_sharded_postgresql_cluster_iam_binding).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.UpdateAccessBindings](../api-ref/Cluster/updateAccessBindings.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<идентификатор_кластера>:updateAccessBindings' \
        --data '{
                  "access_binding_deltas": [
                    {
                      "action": "REMOVE",
                      "access_binding": {
                        "role_id": "<роль>",
                        "subject": {
                          "id": "<идентификатор_субъекта>",
                          "type": "<тип_субъекта>"
                        }
                      }
                    }
                  ]
                }'
      ```

      
      Где:

      * `access_binding_deltas.roleId` — назначаемая [роль](../security.md#roles-list), например `managed-spqr.editor`.
      * `access_binding_deltas.subject.id` — идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.
      * `access_binding_deltas.subject.type` — тип субъекта, которому назначается роль.

          {% include [access-control-subject](../../_includes/mdb/access-control-subject.md) %}


  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/updateAccessBindings.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService.UpdateAccessBindings](../api-ref/grpc/Cluster/updateAccessBindings.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "resource_id": "<идентификатор_кластера>",
              "access_binding_deltas": [
                {
                  "action": "REMOVE",
                  "access_binding": {
                    "role_id": "<роль>",
                    "subject": {
                      "id": "<идентификатор_субъекта>",
                      "type": "<тип_субъекта>"
                    }
                  }
                }
              ]
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.spqr.v1.ClusterService.UpdateAccessBindings
      ```

      
      Где:

      * `resource_id` — идентификатор кластера.
      * `access_binding_deltas.roleId` — назначаемая [роль](../security.md#roles-list), например `managed-spqr.editor`.
      * `access_binding_deltas.subject.id` — идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.
      * `access_binding_deltas.subject.type` — тип субъекта, которому назначается роль.

          {% include [access-control-subject](../../_includes/mdb/access-control-subject.md) %}


  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/updateAccessBindings.md#yandex.cloud.operation.Operation).

{% endlist %}

## Примеры {#examples}

### Добавить сервисному аккаунту доступ к управлению кластером {#sa-cluster-control}

Чтобы сервисный аккаунт мог просматривать информацию обо всех кластерах {{ mspqr-name }} в каталоге, но изменять ресурсы только конкретного кластера, выдайте ему роль `managed-spqr.viewer` на каталог и роль `managed-spqr.editor` на этот кластер:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

  1. Добавьте описание ресурса:

      ```hcl
      resource "yandex_mdb_sharded_postgresql_cluster_iam_binding" "spqr-cluster-editor" {
        cluster_id = "<идентификатор_кластера>"
        role       = "managed-spqr.editor"
        members    = [
          "serviceAccount:<идентификатор_сервисного_аккаунта>"
        ]
      }
      ```

      
      Где:

      * `cluster_id` — идентификатор кластера.
      * `role` — назначаемая [роль](../security.md#roles-list).
      * `members` — список [субъектов](../../iam/concepts/access-control/index.md#subject), которым назначается роль, в формате: `<тип_субъекта>:<идентификатор_субъекта>`.


  1. Проверьте корректность конфигурационных файлов.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_sharded_postgresql_cluster_iam_binding).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Назначьте роль на каталог:

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://resource-manager.{{ api-host }}/resource-manager/v1/folders/<идентификатор_каталога>:updateAccessBindings' \
        --data '{
                  "access_binding_deltas": [
                    {
                      "action": "ADD",
                      "access_binding": {
                        "role_id": "managed-spqr.viewer",
                        "subject": {
                          "id": "<идентификатор_сервисного_аккаунта>",
                          "type": "serviceAccount"
                        }
                      }
                    }
                  ]
                }'
      ```

      Где `access_binding_deltas.subject.id` — идентификатор сервисного аккаунта, которому назначается роль.

  1. Воспользуйтесь методом [Cluster.UpdateAccessBindings](../api-ref/Cluster/updateAccessBindings.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<идентификатор_кластера>:updateAccessBindings' \
        --data '{
                  "access_binding_deltas": [
                    {
                      "action": "ADD",
                      "access_binding": {
                        "role_id": "managed-spqr.editor",
                        "subject": {
                          "id": "<идентификатор_сервисного_аккаунта>",
                          "type": "serviceAccount"
                        }
                      }
                    }
                  ]
                }'
      ```

      Где `access_binding_deltas.subject.id` — идентификатор сервисного аккаунта, которому назначается роль.

  1. Проверьте список ролей, назначенных на каталог:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://resource-manager.{{ api-host }}/resource-manager/v1/folders/<идентификатор_каталога>:listAccessBindings'
      ```

  1. Проверьте список ролей, назначенных на кластер:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<идентификатор_кластера>:listAccessBindings'
      ```

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Назначьте роль на каталог:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/resourcemanager/v1/folder_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "resource_id": "<идентификатор_каталога>",
              "access_binding_deltas": [
                {
                  "action": "ADD",
                  "access_binding": {
                    "role_id": "managed-spqr.viewer",
                    "subject": {
                      "id": "<идентификатор_сервисного_аккаунта>",
                      "type": "serviceAccount"
                    }
                  }
                }
              ]
            }' \
        resource-manager.{{ api-host }}:443 \
        yandex.cloud.resourcemanager.v1.FolderService.UpdateAccessBindings
      ```

      Где `access_binding_deltas.subject.id` — идентификатор сервисного аккаунта, которому назначается роль.

  1. Назначьте роль на кластер:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "resource_id": "<идентификатор_кластера>",
              "access_binding_deltas": [
                {
                  "action": "ADD",
                  "access_binding": {
                    "role_id": "managed-spqr.editor",
                    "subject": {
                      "id": "<идентификатор_сервисного_аккаунта>",
                      "type": "serviceAccount"
                    }
                  }
                }
              ]
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.spqr.v1.ClusterService.UpdateAccessBindings
      ```

      Где `access_binding_deltas.subject.id` — идентификатор сервисного аккаунта, которому назначается роль.

  1. Проверьте список ролей, назначенных на каталог:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/resourcemanager/v1/folder_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "resource_id": "<идентификатор_каталога>"
            }' \
        resource-manager.{{ api-host }}:443 \
        yandex.cloud.resourcemanager.v1.FolderService.ListAccessBindings
      ```

  1. Проверьте список ролей, назначенных на кластер:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "resource_id": "<идентификатор_кластера>"
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.spqr.v1.ClusterService.ListAccessBindings
      ```

{% endlist %}
