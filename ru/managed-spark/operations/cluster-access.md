---
title: Управление доступом к кластеру {{ msp-full-name }}
description: Следуя данной инструкции, вы настроите права доступа к кластеру {{ msp-name }}.
---

# Управление доступом к кластеру {{ msp-name }}

Вы можете предоставить пользователю или сервисному аккаунту [роль](../security.md) для доступа к конкретному [кластеру](../concepts/index.md).

Таким образом, вы можете гранулярно назначать разные роли на конкретные кластеры для разных пользователей и сервисных аккаунтов.


## Получить список ролей, назначенных на кластер {#list-access-bindings}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Получите список кластеров в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию, выполнив команду:

      ```bash
      {{ yc-mdb-sp }} cluster list
      ```

  1. Получите список ролей, назначенных на кластер, выполнив команду:

      ```bash
      {{ yc-mdb-sp }} cluster list-access-bindings <имя_или_идентификатор_кластера>
      ```

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
        -proto ~/cloudapi/yandex/cloud/spark/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "resource_id": "<идентификатор_кластера>"
            }' \
        {{ api-host-spark }}:{{ port-https }} \
       yandex.cloud.spark.v1.ClusterService.ListAccessBindings
      ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listAccessBindings.md#yandex.cloud.access.ListAccessBindingsResponse).

{% endlist %}


## Назначить роль {#add-access-binding}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для назначения роли на кластер:

      ```bash
      {{ yc-mdb-sp }} cluster add-access-binding --help
      ```

  1. Назначьте роль, выполнив команду:

      ```bash
      {{ yc-mdb-sp }} cluster add-access-binding <имя_или_идентификатор_кластера> \
        --role <роль> \
        --subject <тип_субъекта>:<идентификатор_субъекта>
      ```

      Где:

      * `--role` — назначаемая [роль](../security.md#roles-list), например `managed-spark.editor`.
      * `--subject` — тип и идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль, в формате: `<тип_субъекта>:<идентификатор_субъекта>`.

          Например:

          * `serviceAccount:aje6p030************`,
          * `userAccount:aje8tj79************`,
          * `system:allAuthenticatedUsers`.

          {% include [access-control-subject](../../_includes/mdb/access-control-subject.md) %}

  1. Проверьте список ролей, назначенных на кластер, выполнив команду:

      ```bash
      {{ yc-mdb-sp }} cluster list-access-bindings <имя_или_идентификатор_кластера>
      ```

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
        -proto ~/cloudapi/yandex/cloud/spark/v1/cluster_service.proto \
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
        {{ api-host-spark }}:{{ port-https }} \
       yandex.cloud.spark.v1.ClusterService.UpdateAccessBindings
      ```

      Где:

      * `resource_id` — идентификатор кластера.
      * `access_binding_deltas.roleId` — назначаемая [роль](../security.md#roles-list), например `managed-spark.editor`.
      * `access_binding_deltas.subject.id` — идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.
      * `access_binding_deltas.subject.type` — тип субъекта, которому назначается роль.

          {% include [access-control-subject](../../_includes/mdb/access-control-subject.md) %}

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/updateAccessBindings.md#yandex.cloud.operation.Operation).

{% endlist %}

## Назначить несколько ролей {#set-access-bindings}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  {% note alert %}

  Команда `set-access-bindings` удаляет все назначенные на кластер роли и задает новые.

  {% endnote %}

  1. Посмотрите список ролей, назначенных на кластер, выполнив команду:

      ```bash
      {{ yc-mdb-sp }} cluster list-access-bindings <имя_или_идентификатор_кластера>
      ```

  1. Посмотрите описание команды CLI для назначения ролей на кластер:

      ```bash
      {{ yc-mdb-sp }} cluster set-access-bindings --help
      ```

  1. Назначьте роли, выполнив команду:

      ```bash
      {{ yc-mdb-sp }} cluster set-access-bindings <имя_или_идентификатор_кластера> \
        --access-binding role=<роль>,subject=<тип_субъекта>:<идентификатор_субъекта_1> \
        --access-binding role=<роль>,subject=<тип_субъекта>:<идентификатор_субъекта_2>
      ```

      Где `--access-binding` — назначает роль субъекту. Вы можете назначить несколько ролей одновременно, описав каждую в отдельном параметре `--access-binding`.

      * `role` — назначаемая [роль](../security.md#roles-list), например `managed-spark.editor`.
      * `subject` — тип и идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль, в формате: `<тип_субъекта>:<идентификатор_субъекта>`.

          Например:

          * `serviceAccount:aje6p030************`,
          * `userAccount:aje8tj79************`,
          * `system:allAuthenticatedUsers`.

          {% include [access-control-subject](../../_includes/mdb/access-control-subject.md) %}

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
        -proto ~/cloudapi/yandex/cloud/spark/v1/cluster_service.proto \
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
        {{ api-host-spark }}:{{ port-https }} \
       yandex.cloud.spark.v1.ClusterService.SetAccessBindings
      ```

      Где:

      * `resource_id` — идентификатор кластера.
      * `accessBindings.roleId` — назначаемая [роль](../security.md#roles-list), например `managed-spark.editor`.
      * `accessBindings.subject.id` — идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.
      * `accessBindings.subject.type` — тип субъекта, которому назначается роль.

          {% include [access-control-subject](../../_includes/mdb/access-control-subject.md) %}

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/setAccessBindings.md#yandex.cloud.operation.Operation).

{% endlist %}

## Отозвать роль {#remove-access-binding}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите список ролей, назначенных на кластер, выполнив команду:

      ```bash
      {{ yc-mdb-sp }} cluster list-access-bindings <имя_или_идентификатор_кластера>
      ```

  1. Посмотрите описание команды CLI для отзыва роли на кластер:

      ```bash
      {{ yc-mdb-sp }} cluster remove-access-binding --help
      ```
  1. Отзовите роль, выполнив команду:

      ```bash
      {{ yc-mdb-sp }} cluster remove-access-binding <имя_или_идентификатор_кластера> \
        --role <роль> \
        --subject <тип_субъекта>:<идентификатор_субъекта>
      ```

      Где:

      * `--role` — отзываемая [роль](../security.md#roles-list), например `managed-spark.editor`.
      * `--subject` — тип и идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначена роль, в формате: `<тип_субъекта>:<идентификатор_субъекта>`.

          Например:

          * `serviceAccount:aje6p030************`,
          * `userAccount:aje8tj79************`,
          * `system:allAuthenticatedUsers`.

          {% include [access-control-subject](../../_includes/mdb/access-control-subject.md) %}

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
        -proto ~/cloudapi/yandex/cloud/spark/v1/cluster_service.proto \
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
        {{ api-host-spark }}:{{ port-https }} \
       yandex.cloud.spark.v1.ClusterService.UpdateAccessBindings
      ```

      Где:

      * `resource_id` — идентификатор кластера.
      * `access_binding_deltas.roleId` — назначаемая [роль](../security.md#roles-list), например `managed-spark.editor`.
      * `access_binding_deltas.subject.id` — идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.
      * `access_binding_deltas.subject.type` — тип субъекта, которому назначается роль.

          {% include [access-control-subject](../../_includes/mdb/access-control-subject.md) %}

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/updateAccessBindings.md#yandex.cloud.operation.Operation).

{% endlist %}

## Примеры {#examples}

### Добавить сервисному аккаунту доступ к управлению кластером {#sa-cluster-control}

Чтобы сервисный аккаунт мог просматривать информацию обо всех кластерах {{ msp-name }} в каталоге, но изменять ресурсы только конкретного кластера, выдайте ему роль `managed-spark.viewer` на каталог и роль `managed-spark.editor` на этот кластер:

{% list tabs group=instructions %}

- CLI {#cli}

  1. Назначьте роль на каталог:

      ```bash
      yc resource-manager folder add-access-binding <имя_или_идентификатор_каталога> \
        --role managed-spark.viewer \
        --subject=serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

  1. Назначьте роли на кластер:

      ```bash
      {{ yc-mdb-sp }} cluster add-access-bindings <имя_или_идентификатор_кластера> \
        --access-binding role=managed-spark.editor,subject=serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

  1. Проверьте список ролей, назначенных на кластер:

      ```bash
      {{ yc-mdb-sp }} cluster list-access-bindings <имя_или_идентификатор_кластера>
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
              "resource_id": "<идентификатор_кластера>",
              "access_binding_deltas": [
                {
                  "action": "ADD",
                  "access_binding": {
                    "role_id": "managed-spark.viewer",
                    "subject": {
                      "id": "<идентификатор_ссервисного_аккаунта>",
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
        -proto ~/cloudapi/yandex/cloud/spark/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "resource_id": "<идентификатор_кластера>",
              "access_binding_deltas": [
                {
                  "action": "ADD",
                  "access_binding": {
                    "role_id": "managed-spark.editor",
                    "subject": {
                      "id": "<идентификатор_ссервисного_аккаунта>",
                      "type": "serviceAccount"
                    }
                  }
                }
              ]
            }' \
        {{ api-host-spark }}:{{ port-https }} \
       yandex.cloud.spark.v1.ClusterService.UpdateAccessBindings
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
        -proto ~/cloudapi/yandex/cloud/spark/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "resource_id": "<идентификатор_кластера>"
            }' \
        {{ api-host-spark }}:{{ port-https }} \
       yandex.cloud.spark.v1.ClusterService.ListAccessBindings
      ```

{% endlist %}