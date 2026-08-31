[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Trino](../index.md) > [Пошаговые инструкции](index.md) > Кластеры > Управление доступом к кластеру

# Управление доступом к кластеру Managed Service for Trino

Вы можете предоставить пользователю или сервисному аккаунту [роль](../security.md) для доступа к конкретному [кластеру](../concepts/index.md).

Таким образом, вы можете гранулярно назначать разные роли на конкретные кластеры для разных пользователей и сервисных аккаунтов.


## Получить список ролей, назначенных на кластер {#list-access-bindings}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Получите список кластеров в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию, выполнив команду:

      ```bash
      yc managed-trino cluster list
      ```

  1. Получите список ролей, назначенных на кластер, выполнив команду:

      ```bash
      yc managed-trino cluster list-access-bindings <имя_или_идентификатор_кластера>
      ```

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. Воспользуйтесь методом [Cluster.ListAccessBindings](../api-ref/Cluster/listAccessBindings.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://trino.api.cloud.yandex.net/managed-trino/v1/clusters/<идентификатор_кластера>:listAccessBindings'
      ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listAccessBindings.md#yandex.cloud.access.ListAccessBindingsResponse).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
  1. Воспользуйтесь вызовом [ClusterService.ListAccessBindings](../api-ref/grpc/Cluster/listAccessBindings.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "resource_id": "<идентификатор_кластера>"
            }' \
        trino.api.cloud.yandex.net:443 \
        yandex.cloud.trino.v1.ClusterService.ListAccessBindings
      ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listAccessBindings.md#yandex.cloud.access.ListAccessBindingsResponse).

{% endlist %}


## Назначить роль {#add-access-binding}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для назначения роли на кластер:

      ```bash
      yc managed-trino cluster add-access-binding --help
      ```

  1. Назначьте роль, выполнив команду:

      ```bash
      yc managed-trino cluster add-access-binding <имя_или_идентификатор_кластера> \
        --role <роль> \
        --subject <тип_субъекта>:<идентификатор_субъекта>
      ```

      Где:

      * `--role` — назначаемая [роль](../security.md#roles-list), например `managed-trino.editor`.
      * `--subject` — обозначение [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.

          Например:

          * `serviceAccount:aje6p030************`,
          * `userAccount:aje8tj79************`,
          * `system:allAuthenticatedUsers`.

          {% cut "Обозначения субъектов" %}

          Для обозначения субъекта используется параметр `--subject` со значением в формате `<тип_субъекта>:<идентификатор>`. Для некоторых типов субъектов в [Yandex Cloud CLI](../../cli/index.md) вместо `--subject` доступны отдельные параметры, в которых достаточно указать имя или идентификатор субъекта без типа. Возможные обозначения субъектов и соответствующие параметры CLI:
          
          #|
          || **Тип субъекта** | **Обозначение субъекта** | **Параметр Yandex Cloud CLI** ||
          || `userAccount`    | `userAccount:<идентификатор_пользователя>` | `--user-account-id` или `--user-yandex-login` ||
          || `serviceAccount` | `serviceAccount:<идентификатор_сервисного_аккаунта>` | `--service-account-id` или `--service-account-name` ||
          || `federatedUser`  | `federatedUser:<идентификатор_пользователя>` | `--user-account-id` ||
          || `group`          | `group:<идентификатор_группы>` | `--group-members` ||
          || `system`         | `system:allAuthenticatedUsers`
          
          (группа `All authenticated users`) | `--all-authenticated-users` ||
          || ^                | `system:allUsers`
          
          (группа `All users`) | — ||
          || ^                | `system:group:organization:<идентификатор_организации>:users`
          
          (группа `All users in organization X`) | `--organization-users` ||
          || ^                | `system:group:federation:<идентификатор_федерации>:users`
          
          (группа `All users in federation N`) | `--federation-users` ||
          || ^                | `system:group:userpool:<идентификатор_пула>:users`
          
          (группа `All users in userpool P`) | — ||
          |#

          {% endcut %}

  1. Проверьте список ролей, назначенных на кластер, выполнив команду:

      ```bash
      yc managed-trino cluster list-access-bindings <имя_или_идентификатор_кластера>
      ```

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. Воспользуйтесь методом [Cluster.UpdateAccessBindings](../api-ref/Cluster/updateAccessBindings.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://trino.api.cloud.yandex.net/managed-trino/v1/clusters/<идентификатор_кластера>:updateAccessBindings' \
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

      * `access_binding_deltas.roleId` — назначаемая [роль](../security.md#roles-list), например `managed-trino.editor`.
      * `access_binding_deltas.subject.id` — идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.
      * `access_binding_deltas.subject.type` — тип субъекта, которому назначается роль.

          {% cut "Обозначения субъектов" %}

          Для обозначения субъекта используется комбинация типа и уникального идентификатора в полях запроса `subject.type` и `subject.id`. Возможные комбинации:
          
          #|
          || **subject.type** | **subject.id** ||
          || `userAccount`    | `<идентификатор_пользователя>` ||
          || `serviceAccount` | `<идентификатор_сервисного_аккаунта>` ||
          || `federatedUser`  | `<идентификатор_пользователя>` ||
          || `group`          | `<идентификатор_группы>` ||
          || `system`         | `allAuthenticatedUsers`
          
          (группа `All authenticated users`) ||
          || ^                | `allUsers`
          
          (группа `All users`) ||
          || ^                | `group:organization:<идентификатор_организации>:users`
          
          (группа `All users in organization X`) ||
          || ^                | `group:federation:<идентификатор_федерации>:users`
          
          (группа `All users in federation N`) ||
          || ^                | `group:userpool:<идентификатор_пула>:users`
          
          (группа `All users in userpool P`) ||
          |#

          {% endcut %}

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/updateAccessBindings.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
  1. Воспользуйтесь вызовом [ClusterService.UpdateAccessBindings](../api-ref/grpc/Cluster/updateAccessBindings.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/cluster_service.proto \
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
        trino.api.cloud.yandex.net:443 \
        yandex.cloud.trino.v1.ClusterService.UpdateAccessBindings
      ```

      Где:

      * `resource_id` — идентификатор кластера.
      * `access_binding_deltas.roleId` — назначаемая [роль](../security.md#roles-list), например `managed-trino.editor`.
      * `access_binding_deltas.subject.id` — идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.
      * `access_binding_deltas.subject.type` — тип субъекта, которому назначается роль.

          {% cut "Обозначения субъектов" %}

          Для обозначения субъекта используется комбинация типа и уникального идентификатора в полях запроса `subject.type` и `subject.id`. Возможные комбинации:
          
          #|
          || **subject.type** | **subject.id** ||
          || `userAccount`    | `<идентификатор_пользователя>` ||
          || `serviceAccount` | `<идентификатор_сервисного_аккаунта>` ||
          || `federatedUser`  | `<идентификатор_пользователя>` ||
          || `group`          | `<идентификатор_группы>` ||
          || `system`         | `allAuthenticatedUsers`
          
          (группа `All authenticated users`) ||
          || ^                | `allUsers`
          
          (группа `All users`) ||
          || ^                | `group:organization:<идентификатор_организации>:users`
          
          (группа `All users in organization X`) ||
          || ^                | `group:federation:<идентификатор_федерации>:users`
          
          (группа `All users in federation N`) ||
          || ^                | `group:userpool:<идентификатор_пула>:users`
          
          (группа `All users in userpool P`) ||
          |#

          {% endcut %}

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/updateAccessBindings.md#yandex.cloud.operation.Operation).

{% endlist %}

## Назначить несколько ролей {#set-access-bindings}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  {% note alert %}

  Команда `set-access-bindings` удаляет все назначенные на кластер роли и задает новые.

  {% endnote %}

  1. Посмотрите список ролей, назначенных на кластер, выполнив команду:

      ```bash
      yc managed-trino cluster list-access-bindings <имя_или_идентификатор_кластера>
      ```

  1. Посмотрите описание команды CLI для назначения ролей на кластер:

      ```bash
      yc managed-trino cluster set-access-bindings --help
      ```

  1. Назначьте роли, выполнив команду:

      ```bash
      yc managed-trino cluster set-access-bindings <имя_или_идентификатор_кластера> \
        --access-binding role=<роль>,subject=<тип_субъекта>:<идентификатор_субъекта_1> \
        --access-binding role=<роль>,subject=<тип_субъекта>:<идентификатор_субъекта_2>
      ```

      Где `--access-binding` — назначает роль субъекту. Вы можете назначить несколько ролей одновременно, описав каждую в отдельном параметре `--access-binding`.

      * `role` — назначаемая [роль](../security.md#roles-list), например `managed-trino.editor`.
      * `subject` — обозначение [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.

          Например:

          * `serviceAccount:aje6p030************`,
          * `userAccount:aje8tj79************`,
          * `system:allAuthenticatedUsers`.

          {% cut "Обозначения субъектов" %}

          Для обозначения субъекта используется параметр `--subject` со значением в формате `<тип_субъекта>:<идентификатор>`. Для некоторых типов субъектов в [Yandex Cloud CLI](../../cli/index.md) вместо `--subject` доступны отдельные параметры, в которых достаточно указать имя или идентификатор субъекта без типа. Возможные обозначения субъектов и соответствующие параметры CLI:
          
          #|
          || **Тип субъекта** | **Обозначение субъекта** | **Параметр Yandex Cloud CLI** ||
          || `userAccount`    | `userAccount:<идентификатор_пользователя>` | `--user-account-id` или `--user-yandex-login` ||
          || `serviceAccount` | `serviceAccount:<идентификатор_сервисного_аккаунта>` | `--service-account-id` или `--service-account-name` ||
          || `federatedUser`  | `federatedUser:<идентификатор_пользователя>` | `--user-account-id` ||
          || `group`          | `group:<идентификатор_группы>` | `--group-members` ||
          || `system`         | `system:allAuthenticatedUsers`
          
          (группа `All authenticated users`) | `--all-authenticated-users` ||
          || ^                | `system:allUsers`
          
          (группа `All users`) | — ||
          || ^                | `system:group:organization:<идентификатор_организации>:users`
          
          (группа `All users in organization X`) | `--organization-users` ||
          || ^                | `system:group:federation:<идентификатор_федерации>:users`
          
          (группа `All users in federation N`) | `--federation-users` ||
          || ^                | `system:group:userpool:<идентификатор_пула>:users`
          
          (группа `All users in userpool P`) | — ||
          |#

          {% endcut %}

- REST API {#api}

  {% note alert %}

  Метод `setAccessBindings` перезаписывает права доступа к ресурсу. Все текущие роли на ресурс будут удалены.

  {% endnote %}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. Воспользуйтесь методом [Cluster.SetAccessBindings](../api-ref/Cluster/setAccessBindings.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://trino.api.cloud.yandex.net/managed-trino/v1/clusters/<идентификатор_кластера>:setAccessBindings' \
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

      * `accessBindings.roleId` — назначаемая [роль](../security.md#roles-list), например `managed-trino.editor`.
      * `accessBindings.subject.id` — идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.
      * `accessBindings.subject.type` — тип субъекта, которому назначается роль.

          {% cut "Обозначения субъектов" %}

          Для обозначения субъекта используется комбинация типа и уникального идентификатора в полях запроса `subject.type` и `subject.id`. Возможные комбинации:
          
          #|
          || **subject.type** | **subject.id** ||
          || `userAccount`    | `<идентификатор_пользователя>` ||
          || `serviceAccount` | `<идентификатор_сервисного_аккаунта>` ||
          || `federatedUser`  | `<идентификатор_пользователя>` ||
          || `group`          | `<идентификатор_группы>` ||
          || `system`         | `allAuthenticatedUsers`
          
          (группа `All authenticated users`) ||
          || ^                | `allUsers`
          
          (группа `All users`) ||
          || ^                | `group:organization:<идентификатор_организации>:users`
          
          (группа `All users in organization X`) ||
          || ^                | `group:federation:<идентификатор_федерации>:users`
          
          (группа `All users in federation N`) ||
          || ^                | `group:userpool:<идентификатор_пула>:users`
          
          (группа `All users in userpool P`) ||
          |#

          {% endcut %}

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/setAccessBindings.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  {% note alert %}

  Вызов `ClusterService.SetAccessBindings` полностью перезаписывает права доступа к ресурсу. Все текущие роли на ресурс будут удалены.

  {% endnote %}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
  1. Воспользуйтесь вызовом [ClusterService.SetAccessBindings](../api-ref/grpc/Cluster/setAccessBindings.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/cluster_service.proto \
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
        trino.api.cloud.yandex.net:443 \
        yandex.cloud.trino.v1.ClusterService.SetAccessBindings
      ```

      Где:

      * `resource_id` — идентификатор кластера.
      * `accessBindings.roleId` — назначаемая [роль](../security.md#roles-list), например `managed-trino.editor`.
      * `accessBindings.subject.id` — идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.
      * `accessBindings.subject.type` — тип субъекта, которому назначается роль.

          {% cut "Обозначения субъектов" %}

          Для обозначения субъекта используется комбинация типа и уникального идентификатора в полях запроса `subject.type` и `subject.id`. Возможные комбинации:
          
          #|
          || **subject.type** | **subject.id** ||
          || `userAccount`    | `<идентификатор_пользователя>` ||
          || `serviceAccount` | `<идентификатор_сервисного_аккаунта>` ||
          || `federatedUser`  | `<идентификатор_пользователя>` ||
          || `group`          | `<идентификатор_группы>` ||
          || `system`         | `allAuthenticatedUsers`
          
          (группа `All authenticated users`) ||
          || ^                | `allUsers`
          
          (группа `All users`) ||
          || ^                | `group:organization:<идентификатор_организации>:users`
          
          (группа `All users in organization X`) ||
          || ^                | `group:federation:<идентификатор_федерации>:users`
          
          (группа `All users in federation N`) ||
          || ^                | `group:userpool:<идентификатор_пула>:users`
          
          (группа `All users in userpool P`) ||
          |#

          {% endcut %}

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/setAccessBindings.md#yandex.cloud.operation.Operation).

{% endlist %}

## Отозвать роль {#remove-access-binding}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите список ролей, назначенных на кластер, выполнив команду:

      ```bash
      yc managed-trino cluster list-access-bindings <имя_или_идентификатор_кластера>
      ```

  1. Посмотрите описание команды CLI для отзыва роли на кластер:

      ```bash
      yc managed-trino cluster remove-access-binding --help
      ```
  1. Отзовите роль, выполнив команду:

      ```bash
      yc managed-trino cluster remove-access-binding <имя_или_идентификатор_кластера> \
        --role <роль> \
        --subject <тип_субъекта>:<идентификатор_субъекта>
      ```

      Где:

      * `--role` — отзываемая [роль](../security.md#roles-list), например `managed-trino.editor`.
      * `--subject` — обозначение [субъекта](../../iam/concepts/access-control/index.md#subject), у которого отзывается роль.

          Например:

          * `serviceAccount:aje6p030************`,
          * `userAccount:aje8tj79************`,
          * `system:allAuthenticatedUsers`.

          {% cut "Обозначения субъектов" %}

          Для обозначения субъекта используется параметр `--subject` со значением в формате `<тип_субъекта>:<идентификатор>`. Для некоторых типов субъектов в [Yandex Cloud CLI](../../cli/index.md) вместо `--subject` доступны отдельные параметры, в которых достаточно указать имя или идентификатор субъекта без типа. Возможные обозначения субъектов и соответствующие параметры CLI:
          
          #|
          || **Тип субъекта** | **Обозначение субъекта** | **Параметр Yandex Cloud CLI** ||
          || `userAccount`    | `userAccount:<идентификатор_пользователя>` | `--user-account-id` или `--user-yandex-login` ||
          || `serviceAccount` | `serviceAccount:<идентификатор_сервисного_аккаунта>` | `--service-account-id` или `--service-account-name` ||
          || `federatedUser`  | `federatedUser:<идентификатор_пользователя>` | `--user-account-id` ||
          || `group`          | `group:<идентификатор_группы>` | `--group-members` ||
          || `system`         | `system:allAuthenticatedUsers`
          
          (группа `All authenticated users`) | `--all-authenticated-users` ||
          || ^                | `system:allUsers`
          
          (группа `All users`) | — ||
          || ^                | `system:group:organization:<идентификатор_организации>:users`
          
          (группа `All users in organization X`) | `--organization-users` ||
          || ^                | `system:group:federation:<идентификатор_федерации>:users`
          
          (группа `All users in federation N`) | `--federation-users` ||
          || ^                | `system:group:userpool:<идентификатор_пула>:users`
          
          (группа `All users in userpool P`) | — ||
          |#

          {% endcut %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. Воспользуйтесь методом [Cluster.UpdateAccessBindings](../api-ref/Cluster/updateAccessBindings.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://trino.api.cloud.yandex.net/managed-trino/v1/clusters/<идентификатор_кластера>:updateAccessBindings' \
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

      * `access_binding_deltas.roleId` — отзываемая [роль](../security.md#roles-list), например `managed-trino.editor`.
      * `access_binding_deltas.subject.id` — идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), у которого отзывается роль.
      * `access_binding_deltas.subject.type` — тип субъекта, у которого отзывается роль.

          {% cut "Обозначения субъектов" %}

          Для обозначения субъекта используется комбинация типа и уникального идентификатора в полях запроса `subject.type` и `subject.id`. Возможные комбинации:
          
          #|
          || **subject.type** | **subject.id** ||
          || `userAccount`    | `<идентификатор_пользователя>` ||
          || `serviceAccount` | `<идентификатор_сервисного_аккаунта>` ||
          || `federatedUser`  | `<идентификатор_пользователя>` ||
          || `group`          | `<идентификатор_группы>` ||
          || `system`         | `allAuthenticatedUsers`
          
          (группа `All authenticated users`) ||
          || ^                | `allUsers`
          
          (группа `All users`) ||
          || ^                | `group:organization:<идентификатор_организации>:users`
          
          (группа `All users in organization X`) ||
          || ^                | `group:federation:<идентификатор_федерации>:users`
          
          (группа `All users in federation N`) ||
          || ^                | `group:userpool:<идентификатор_пула>:users`
          
          (группа `All users in userpool P`) ||
          |#

          {% endcut %}

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/updateAccessBindings.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
  1. Воспользуйтесь вызовом [ClusterService.UpdateAccessBindings](../api-ref/grpc/Cluster/updateAccessBindings.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/cluster_service.proto \
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
        trino.api.cloud.yandex.net:443 \
        yandex.cloud.trino.v1.ClusterService.UpdateAccessBindings
      ```

      Где:

      * `resource_id` — идентификатор кластера.
      * `access_binding_deltas.roleId` — отзываемая [роль](../security.md#roles-list), например `managed-trino.editor`.
      * `access_binding_deltas.subject.id` — идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), у которого отзывается роль.
      * `access_binding_deltas.subject.type` — тип субъекта, у которого отзывается роль.

          {% cut "Обозначения субъектов" %}

          Для обозначения субъекта используется комбинация типа и уникального идентификатора в полях запроса `subject.type` и `subject.id`. Возможные комбинации:
          
          #|
          || **subject.type** | **subject.id** ||
          || `userAccount`    | `<идентификатор_пользователя>` ||
          || `serviceAccount` | `<идентификатор_сервисного_аккаунта>` ||
          || `federatedUser`  | `<идентификатор_пользователя>` ||
          || `group`          | `<идентификатор_группы>` ||
          || `system`         | `allAuthenticatedUsers`
          
          (группа `All authenticated users`) ||
          || ^                | `allUsers`
          
          (группа `All users`) ||
          || ^                | `group:organization:<идентификатор_организации>:users`
          
          (группа `All users in organization X`) ||
          || ^                | `group:federation:<идентификатор_федерации>:users`
          
          (группа `All users in federation N`) ||
          || ^                | `group:userpool:<идентификатор_пула>:users`
          
          (группа `All users in userpool P`) ||
          |#

          {% endcut %}

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/updateAccessBindings.md#yandex.cloud.operation.Operation).

{% endlist %}

## Примеры {#examples}

### Добавить сервисному аккаунту доступ к управлению кластером {#sa-cluster-control}

Чтобы сервисный аккаунт мог просматривать информацию обо всех кластерах Managed Service for Trino в каталоге, но изменять ресурсы только конкретного кластера, выдайте ему роль `managed-trino.viewer` на каталог и роль `managed-trino.editor` на этот кластер:

{% list tabs group=instructions %}

- CLI {#cli}

  1. Назначьте роль на каталог:

      ```bash
      yc resource-manager folder add-access-binding <имя_или_идентификатор_каталога> \
        --role managed-trino.viewer \
        --subject=serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

  1. Назначьте роли на кластер:

      ```bash
      yc managed-trino cluster add-access-bindings <имя_или_идентификатор_кластера> \
        --access-binding role=managed-trino.editor,subject=serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

  1. Проверьте список ролей, назначенных на кластер:

      ```bash
      yc managed-trino cluster list-access-bindings <имя_или_идентификатор_кластера>
      ```

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. Назначьте роль на каталог:

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders/<идентификатор_каталога>:updateAccessBindings' \
        --data '{
                  "access_binding_deltas": [
                    {
                      "action": "ADD",
                      "access_binding": {
                        "role_id": "managed-trino.viewer",
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

  1. Воспользуйтесь методом [Cluster.UpdateAccessBindings](../api-ref/Cluster/updateAccessBindings.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://trino.api.cloud.yandex.net/managed-trino/v1/clusters/<идентификатор_кластера>:updateAccessBindings' \
        --data '{
                  "access_binding_deltas": [
                    {
                      "action": "ADD",
                      "access_binding": {
                        "role_id": "managed-trino.editor",
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
        --url 'https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders/<идентификатор_каталога>:updateAccessBindings'
      ```

  1. Проверьте список ролей, назначенных на кластер:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://trino.api.cloud.yandex.net/managed-trino/v1/clusters/<идентификатор_кластера>:listAccessBindings'
      ```

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
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
                    "role_id": "managed-trino.viewer",
                    "subject": {
                      "id": "<идентификатор_ссервисного_аккаунта>",
                      "type": "serviceAccount"
                    }
                  }
                }
              ]
            }' \
        resource-manager.api.cloud.yandex.net:443 \
        yandex.cloud.resourcemanager.v1.FolderService.UpdateAccessBindings
      ```

      Где `access_binding_deltas.subject.id` — идентификатор сервисного аккаунта, которому назначается роль.

  1. Назначьте роль на кластер:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "resource_id": "<идентификатор_кластера>",
              "access_binding_deltas": [
                {
                  "action": "ADD",
                  "access_binding": {
                    "role_id": "managed-trino.editor",
                    "subject": {
                      "id": "<идентификатор_ссервисного_аккаунта>",
                      "type": "serviceAccount"
                    }
                  }
                }
              ]
            }' \
        trino.api.cloud.yandex.net:443 \
        yandex.cloud.trino.v1.ClusterService.UpdateAccessBindings
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
        resource-manager.api.cloud.yandex.net:443 \
        yandex.cloud.resourcemanager.v1.FolderService.ListAccessBindings
      ```

  1. Проверьте список ролей, назначенных на кластер:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "resource_id": "<идентификатор_кластера>"
            }' \
        trino.api.cloud.yandex.net:443 \
        yandex.cloud.trino.v1.ClusterService.ListAccessBindings
      ```

{% endlist %}