# Управление доступом к кластеру Yandex StoreDoc

Вы можете предоставить пользователю или сервисному аккаунту [роль](../security/index.md) для доступа к конкретному [кластеру](../concepts/index.md).

Таким образом, вы можете гранулярно назначать разные роли на конкретные кластеры для разных пользователей и сервисных аккаунтов.


## Получить список ролей, назначенных на кластер {#list-access-bindings}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Получите список кластеров в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию, выполнив команду:

      ```bash
      yc managed-mongodb cluster list
      ```

  1. Получите список ролей, назначенных на кластер, выполнив команду:

      ```bash
      yc managed-mongodb cluster list-access-bindings <имя_или_идентификатор_кластера>
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
        --url 'https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/<идентификатор_кластера>:listAccessBindings'
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
        -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "resource_id": "<идентификатор_кластера>"
            }' \
        mdb.api.cloud.yandex.net:443 \
        yandex.cloud.mdb.mongodb.v1.ClusterService.ListAccessBindings
      ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listAccessBindings.md#yandex.cloud.access.ListAccessBindingsResponse).

{% endlist %}


## Назначить роль {#add-access-binding}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для назначения роли на кластер:

      ```bash
      yc managed-mongodb cluster add-access-binding --help
      ```

  1. Назначьте роль, выполнив команду:

      ```bash
      yc managed-mongodb cluster add-access-binding <имя_или_идентификатор_кластера> \
        --role <роль> \
        --subject <тип_субъекта>:<идентификатор_субъекта>
      ```

      Где:

      * `--role` — назначаемая [роль](../security/index.md#roles-list), например `managed-mongodb.editor`.
      * `--subject` — тип и идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль, в формате: `<тип_субъекта>:<идентификатор_субъекта>`.

          Например:

          * `serviceAccount:aje6p030************`,
          * `userAccount:aje8tj79************`,
          * `system:allAuthenticatedUsers`.

          Допустимые типы субъектов:
          
          * `userAccount` — [аккаунт на Яндексе](../../iam/concepts/users/accounts.md#passport), добавленный в Yandex Cloud, или аккаунт из [пула пользователей](../../organization/concepts/user-pools.md).
          * `serviceAccount` — [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), созданный в Yandex Cloud.
          * `federatedUser` — аккаунт пользователя [федерации удостоверений](../../organization/concepts/add-federation.md).
          * `system` — [публичная группа](../../iam/concepts/access-control/public-group.md) пользователей.
          
              Допустимые значения идентификатора субъекта:
          
              * `allAuthenticatedUsers` — [все пользователи, прошедшие аутентификацию](../../iam/concepts/access-control/public-group.md#allAuthenticatedUsers).
              * `allUsers` — [любой пользователь](../../iam/concepts/access-control/public-group.md#allUsers), прохождение аутентификации не требуется.
              * `group:organization:<идентификатор_организации>:users` — все пользователи указанной [организации](../../organization/concepts/organization.md).
              * `group:federation:<идентификатор_федерации>:users` — все пользователи указанной федерации удостоверений.
          
          Подробнее о типах субъектов см. в разделе [Субъект, которому назначается роль](../../iam/concepts/access-control/index.md#subject).

  1. Проверьте список ролей, назначенных на кластер, выполнив команду:

      ```bash
      yc managed-mongodb cluster list-access-bindings <имя_или_идентификатор_кластера>
      ```

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл с описанием кластера Yandex StoreDoc.
  
      О том, как создать такой файл, см. в разделе [Создание кластера Yandex StoreDoc](cluster-create.md).
  
  1. Добавьте описание ресурса:
    
      ```hcl
      resource "yandex_mdb_mongodb_cluster_iam_binding" "<локальное_имя_ресурса>" {
        cluster_id = "<идентификатор_кластера>"
        role       = "<роль>"
        members    = ["<тип_субъекта>:<идентификатор_субъекта>"]
      }
      ```

      Где:

      * `cluster_id` — идентификатор кластера.
      * `role` — назначаемая [роль](../security/index.md#roles-list), например `managed-mongodb.editor`.
      * `members` — массив типов и идентификаторов [субъектов](../../iam/concepts/access-control/index.md#subject), которым назначается роль, в формате: `<тип_субъекта>:<идентификатор_субъекта>`.
    
        Например:
        
        * `serviceAccount:${yandex_iam_service_account.mmg_sa.id}`,
        * `userAccount:ajerq94vab34********`,
        * `system:allAuthenticatedUsers`.

        Допустимые типы субъектов:
        
        * `userAccount` — [аккаунт на Яндексе](../../iam/concepts/users/accounts.md#passport), добавленный в Yandex Cloud, или аккаунт из [пула пользователей](../../organization/concepts/user-pools.md).
        * `serviceAccount` — [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), созданный в Yandex Cloud.
        * `federatedUser` — аккаунт пользователя [федерации удостоверений](../../organization/concepts/add-federation.md).
        * `system` — [публичная группа](../../iam/concepts/access-control/public-group.md) пользователей.
        
            Допустимые значения идентификатора субъекта:
        
            * `allAuthenticatedUsers` — [все пользователи, прошедшие аутентификацию](../../iam/concepts/access-control/public-group.md#allAuthenticatedUsers).
            * `allUsers` — [любой пользователь](../../iam/concepts/access-control/public-group.md#allUsers), прохождение аутентификации не требуется.
            * `group:organization:<идентификатор_организации>:users` — все пользователи указанной [организации](../../organization/concepts/organization.md).
            * `group:federation:<идентификатор_федерации>:users` — все пользователи указанной федерации удостоверений.
        
        Подробнее о типах субъектов см. в разделе [Субъект, которому назначается роль](../../iam/concepts/access-control/index.md#subject).

  1. Проверьте корректность конфигурационных файлов.

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Подтвердите изменение ресурсов.

      1. Выполните команду для просмотра планируемых изменений:
      
         ```bash
         terraform plan
         ```
      
         Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
      
      1. Если вас устраивают планируемые изменения, внесите их:
         1. Выполните команду:
      
            ```bash
            terraform apply
            ```
      
         1. Подтвердите изменение ресурсов.
         1. Дождитесь завершения операции.
      
      Подробнее см. в [документации провайдера Terraform](../../terraform/resources/mdb_mongodb_cluster_iam_binding.md).

  1. Проверьте список ролей, назначенных на кластер, выполнив команду [CLI](../../cli/index.md):
    
      ```bash
      yc managed-mongodb cluster list-access-bindings <имя_или_идентификатор_кластера>
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
        --url 'https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/<идентификатор_кластера>:updateAccessBindings' \
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

      * `access_binding_deltas.roleId` — назначаемая [роль](../security/index.md#roles-list), например `managed-mongodb.editor`.
      * `access_binding_deltas.subject.id` — идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.
      * `access_binding_deltas.subject.type` — тип субъекта, которому назначается роль.

          Допустимые типы субъектов:
          
          * `userAccount` — [аккаунт на Яндексе](../../iam/concepts/users/accounts.md#passport), добавленный в Yandex Cloud, или аккаунт из [пула пользователей](../../organization/concepts/user-pools.md).
          * `serviceAccount` — [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), созданный в Yandex Cloud.
          * `federatedUser` — аккаунт пользователя [федерации удостоверений](../../organization/concepts/add-federation.md).
          * `system` — [публичная группа](../../iam/concepts/access-control/public-group.md) пользователей.
          
              Допустимые значения идентификатора субъекта:
          
              * `allAuthenticatedUsers` — [все пользователи, прошедшие аутентификацию](../../iam/concepts/access-control/public-group.md#allAuthenticatedUsers).
              * `allUsers` — [любой пользователь](../../iam/concepts/access-control/public-group.md#allUsers), прохождение аутентификации не требуется.
              * `group:organization:<идентификатор_организации>:users` — все пользователи указанной [организации](../../organization/concepts/organization.md).
              * `group:federation:<идентификатор_федерации>:users` — все пользователи указанной федерации удостоверений.
          
          Подробнее о типах субъектов см. в разделе [Субъект, которому назначается роль](../../iam/concepts/access-control/index.md#subject).

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
        -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
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
        mdb.api.cloud.yandex.net:443 \
        yandex.cloud.mdb.mongodb.v1.ClusterService.UpdateAccessBindings
      ```

      Где:

      * `resource_id` — идентификатор кластера.
      * `access_binding_deltas.roleId` — назначаемая [роль](../security/index.md#roles-list), например `managed-mongodb.editor`.
      * `access_binding_deltas.subject.id` — идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.
      * `access_binding_deltas.subject.type` — тип субъекта, которому назначается роль.

          Допустимые типы субъектов:
          
          * `userAccount` — [аккаунт на Яндексе](../../iam/concepts/users/accounts.md#passport), добавленный в Yandex Cloud, или аккаунт из [пула пользователей](../../organization/concepts/user-pools.md).
          * `serviceAccount` — [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), созданный в Yandex Cloud.
          * `federatedUser` — аккаунт пользователя [федерации удостоверений](../../organization/concepts/add-federation.md).
          * `system` — [публичная группа](../../iam/concepts/access-control/public-group.md) пользователей.
          
              Допустимые значения идентификатора субъекта:
          
              * `allAuthenticatedUsers` — [все пользователи, прошедшие аутентификацию](../../iam/concepts/access-control/public-group.md#allAuthenticatedUsers).
              * `allUsers` — [любой пользователь](../../iam/concepts/access-control/public-group.md#allUsers), прохождение аутентификации не требуется.
              * `group:organization:<идентификатор_организации>:users` — все пользователи указанной [организации](../../organization/concepts/organization.md).
              * `group:federation:<идентификатор_федерации>:users` — все пользователи указанной федерации удостоверений.
          
          Подробнее о типах субъектов см. в разделе [Субъект, которому назначается роль](../../iam/concepts/access-control/index.md#subject).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/updateAccessBindings.md#yandex.cloud.operation.Operation).

{% endlist %}

## Назначить несколько ролей {#set-access-bindings}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  {% note alert %}

  Команда `set-access-bindings` удаляет все назначенные на кластер роли и задает новые.

  {% endnote %}

  1. Посмотрите список ролей, назначенных на кластер, выполнив команду:

      ```bash
      yc managed-mongodb cluster list-access-bindings <имя_или_идентификатор_кластера>
      ```

  1. Посмотрите описание команды CLI для назначения ролей на кластер:

      ```bash
      yc managed-mongodb cluster set-access-bindings --help
      ```

  1. Назначьте роли, выполнив команду:

      ```bash
      yc managed-mongodb cluster set-access-bindings <имя_или_идентификатор_кластера> \
        --access-binding role=<роль>,subject=<тип_субъекта>:<идентификатор_субъекта_1> \
        --access-binding role=<роль>,subject=<тип_субъекта>:<идентификатор_субъекта_2>
      ```

      Где `--access-binding` — назначает роль субъекту. Вы можете назначить несколько ролей одновременно, описав каждую в отдельном параметре `--access-binding`.

      * `role` — назначаемая [роль](../security/index.md#roles-list), например `managed-mongodb.editor`.
      * `subject` — тип и идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль, в формате: `<тип_субъекта>:<идентификатор_субъекта>`.

          Например:

          * `serviceAccount:aje6p030************`,
          * `userAccount:aje8tj79************`,
          * `system:allAuthenticatedUsers`.

          Допустимые типы субъектов:
          
          * `userAccount` — [аккаунт на Яндексе](../../iam/concepts/users/accounts.md#passport), добавленный в Yandex Cloud, или аккаунт из [пула пользователей](../../organization/concepts/user-pools.md).
          * `serviceAccount` — [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), созданный в Yandex Cloud.
          * `federatedUser` — аккаунт пользователя [федерации удостоверений](../../organization/concepts/add-federation.md).
          * `system` — [публичная группа](../../iam/concepts/access-control/public-group.md) пользователей.
          
              Допустимые значения идентификатора субъекта:
          
              * `allAuthenticatedUsers` — [все пользователи, прошедшие аутентификацию](../../iam/concepts/access-control/public-group.md#allAuthenticatedUsers).
              * `allUsers` — [любой пользователь](../../iam/concepts/access-control/public-group.md#allUsers), прохождение аутентификации не требуется.
              * `group:organization:<идентификатор_организации>:users` — все пользователи указанной [организации](../../organization/concepts/organization.md).
              * `group:federation:<идентификатор_федерации>:users` — все пользователи указанной федерации удостоверений.
          
          Подробнее о типах субъектов см. в разделе [Субъект, которому назначается роль](../../iam/concepts/access-control/index.md#subject).

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.
  
      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

  1. Добавьте описание ресурсов:
    
      ```hcl
      resource "yandex_mdb_mongodb_cluster_iam_binding" "<локальное_имя_ресурса_1>" {
        cluster_id = "<идентификатор_кластера>"
        role       = "<роль_1>"
        members    = ["<тип_субъекта>:<идентификатор_субъекта>"]
      }

      resource "yandex_mdb_mongodb_cluster_iam_binding" "<локальное_имя_ресурса_2>" {
        cluster_id = "<идентификатор_кластера>"
        role       = "<роль_2>"
        members    = ["<тип_субъекта>:<идентификатор_субъекта>"]
      }
      ```

      Где:

      * `cluster_id` — идентификатор кластера.
      * `role` — назначаемая [роль](../security/index.md#roles-list), например `managed-mongodb.editor`.
      * `members` — массив типов и идентификаторов [субъектов](../../iam/concepts/access-control/index.md#subject), которым назначается роль, в формате: `<тип_субъекта>:<идентификатор_субъекта>`.
    
        Например:
        
        * `serviceAccount:${yandex_iam_service_account.mmg_sa.id}`,
        * `userAccount:ajerq94vab34********`,
        * `system:allAuthenticatedUsers`.

        Допустимые типы субъектов:
        
        * `userAccount` — [аккаунт на Яндексе](../../iam/concepts/users/accounts.md#passport), добавленный в Yandex Cloud, или аккаунт из [пула пользователей](../../organization/concepts/user-pools.md).
        * `serviceAccount` — [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), созданный в Yandex Cloud.
        * `federatedUser` — аккаунт пользователя [федерации удостоверений](../../organization/concepts/add-federation.md).
        * `system` — [публичная группа](../../iam/concepts/access-control/public-group.md) пользователей.
        
            Допустимые значения идентификатора субъекта:
        
            * `allAuthenticatedUsers` — [все пользователи, прошедшие аутентификацию](../../iam/concepts/access-control/public-group.md#allAuthenticatedUsers).
            * `allUsers` — [любой пользователь](../../iam/concepts/access-control/public-group.md#allUsers), прохождение аутентификации не требуется.
            * `group:organization:<идентификатор_организации>:users` — все пользователи указанной [организации](../../organization/concepts/organization.md).
            * `group:federation:<идентификатор_федерации>:users` — все пользователи указанной федерации удостоверений.
        
        Подробнее о типах субъектов см. в разделе [Субъект, которому назначается роль](../../iam/concepts/access-control/index.md#subject).

  1. Проверьте корректность конфигурационных файлов.

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Подтвердите изменение ресурсов.

      1. Выполните команду для просмотра планируемых изменений:
      
         ```bash
         terraform plan
         ```
      
         Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
      
      1. Если вас устраивают планируемые изменения, внесите их:
         1. Выполните команду:
      
            ```bash
            terraform apply
            ```
      
         1. Подтвердите изменение ресурсов.
         1. Дождитесь завершения операции.
      
      Подробнее см. в [документации провайдера Terraform](../../terraform/resources/mdb_mongodb_cluster_iam_binding.md).

  1. Проверьте список ролей, назначенных на кластер, выполнив команду [CLI](../../cli/index.md):
    
      ```bash
      yc managed-mongodb cluster list-access-bindings <имя_или_идентификатор_кластера>
      ```

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
        --url 'https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/<идентификатор_кластера>:setAccessBindings' \
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

      * `accessBindings.roleId` — назначаемая [роль](../security/index.md#roles-list), например `managed-mongodb.editor`.
      * `accessBindings.subject.id` — идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.
      * `accessBindings.subject.type` — тип субъекта, которому назначается роль.

          Допустимые типы субъектов:
          
          * `userAccount` — [аккаунт на Яндексе](../../iam/concepts/users/accounts.md#passport), добавленный в Yandex Cloud, или аккаунт из [пула пользователей](../../organization/concepts/user-pools.md).
          * `serviceAccount` — [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), созданный в Yandex Cloud.
          * `federatedUser` — аккаунт пользователя [федерации удостоверений](../../organization/concepts/add-federation.md).
          * `system` — [публичная группа](../../iam/concepts/access-control/public-group.md) пользователей.
          
              Допустимые значения идентификатора субъекта:
          
              * `allAuthenticatedUsers` — [все пользователи, прошедшие аутентификацию](../../iam/concepts/access-control/public-group.md#allAuthenticatedUsers).
              * `allUsers` — [любой пользователь](../../iam/concepts/access-control/public-group.md#allUsers), прохождение аутентификации не требуется.
              * `group:organization:<идентификатор_организации>:users` — все пользователи указанной [организации](../../organization/concepts/organization.md).
              * `group:federation:<идентификатор_федерации>:users` — все пользователи указанной федерации удостоверений.
          
          Подробнее о типах субъектов см. в разделе [Субъект, которому назначается роль](../../iam/concepts/access-control/index.md#subject).

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
        -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
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
        mdb.api.cloud.yandex.net:443 \
        yandex.cloud.mdb.mongodb.v1.ClusterService.SetAccessBindings
      ```

      Где:

      * `resource_id` — идентификатор кластера.
      * `accessBindings.roleId` — назначаемая [роль](../security/index.md#roles-list), например `managed-mongodb.editor`.
      * `accessBindings.subject.id` — идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.
      * `accessBindings.subject.type` — тип субъекта, которому назначается роль.

          Допустимые типы субъектов:
          
          * `userAccount` — [аккаунт на Яндексе](../../iam/concepts/users/accounts.md#passport), добавленный в Yandex Cloud, или аккаунт из [пула пользователей](../../organization/concepts/user-pools.md).
          * `serviceAccount` — [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), созданный в Yandex Cloud.
          * `federatedUser` — аккаунт пользователя [федерации удостоверений](../../organization/concepts/add-federation.md).
          * `system` — [публичная группа](../../iam/concepts/access-control/public-group.md) пользователей.
          
              Допустимые значения идентификатора субъекта:
          
              * `allAuthenticatedUsers` — [все пользователи, прошедшие аутентификацию](../../iam/concepts/access-control/public-group.md#allAuthenticatedUsers).
              * `allUsers` — [любой пользователь](../../iam/concepts/access-control/public-group.md#allUsers), прохождение аутентификации не требуется.
              * `group:organization:<идентификатор_организации>:users` — все пользователи указанной [организации](../../organization/concepts/organization.md).
              * `group:federation:<идентификатор_федерации>:users` — все пользователи указанной федерации удостоверений.
          
          Подробнее о типах субъектов см. в разделе [Субъект, которому назначается роль](../../iam/concepts/access-control/index.md#subject).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/setAccessBindings.md#yandex.cloud.operation.Operation).

{% endlist %}

## Отозвать роль {#remove-access-binding}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите список ролей, назначенных на кластер, выполнив команду:

      ```bash
      yc managed-mongodb cluster list-access-bindings <имя_или_идентификатор_кластера>
      ```

  1. Посмотрите описание команды CLI для отзыва роли на кластер:

      ```bash
      yc managed-mongodb cluster remove-access-binding --help
      ```
  1. Отзовите роль, выполнив команду:

      ```bash
      yc managed-mongodb cluster remove-access-binding <имя_или_идентификатор_кластера> \
        --role <роль> \
        --subject <тип_субъекта>:<идентификатор_субъекта>
      ```

      Где:

      * `--role` — отзываемая [роль](../security/index.md#roles-list), например `managed-mongodb.editor`.
      * `--subject` — тип и идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначена роль, в формате: `<тип_субъекта>:<идентификатор_субъекта>`.

          Например:

          * `serviceAccount:aje6p030************`,
          * `userAccount:aje8tj79************`,
          * `system:allAuthenticatedUsers`.

          Допустимые типы субъектов:
          
          * `userAccount` — [аккаунт на Яндексе](../../iam/concepts/users/accounts.md#passport), добавленный в Yandex Cloud, или аккаунт из [пула пользователей](../../organization/concepts/user-pools.md).
          * `serviceAccount` — [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), созданный в Yandex Cloud.
          * `federatedUser` — аккаунт пользователя [федерации удостоверений](../../organization/concepts/add-federation.md).
          * `system` — [публичная группа](../../iam/concepts/access-control/public-group.md) пользователей.
          
              Допустимые значения идентификатора субъекта:
          
              * `allAuthenticatedUsers` — [все пользователи, прошедшие аутентификацию](../../iam/concepts/access-control/public-group.md#allAuthenticatedUsers).
              * `allUsers` — [любой пользователь](../../iam/concepts/access-control/public-group.md#allUsers), прохождение аутентификации не требуется.
              * `group:organization:<идентификатор_организации>:users` — все пользователи указанной [организации](../../organization/concepts/organization.md).
              * `group:federation:<идентификатор_федерации>:users` — все пользователи указанной федерации удостоверений.
          
          Подробнее о типах субъектов см. в разделе [Субъект, которому назначается роль](../../iam/concepts/access-control/index.md#subject).

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.
  
      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

  1. Найдите описание ресурса с ролью, которую вы хотите отозвать, и удалите его:
    
      ```hcl
      resource "yandex_mdb_mongodb_cluster_iam_binding" "<локальное_имя_ресурса>" {
        cluster_id = "<идентификатор_кластера>"
        role       = "<роль>"
        members    = ["<тип_субъекта>:<идентификатор_субъекта>"]
      }
      ```

  1. Проверьте корректность конфигурационных файлов.

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Подтвердите изменение ресурсов.

      1. Выполните команду для просмотра планируемых изменений:
      
         ```bash
         terraform plan
         ```
      
         Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
      
      1. Если вас устраивают планируемые изменения, внесите их:
         1. Выполните команду:
      
            ```bash
            terraform apply
            ```
      
         1. Подтвердите изменение ресурсов.
         1. Дождитесь завершения операции.
      
      Подробнее см. в [документации провайдера Terraform](../../terraform/resources/mdb_mongodb_cluster_iam_binding.md).

  1. Проверьте список ролей, назначенных на кластер, выполнив команду [CLI](../../cli/index.md):
    
      ```bash
      yc managed-mongodb cluster list-access-bindings <имя_или_идентификатор_кластера>
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
        --url 'https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/<идентификатор_кластера>:updateAccessBindings' \
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

      * `access_binding_deltas.roleId` — назначаемая [роль](../security/index.md#roles-list), например `managed-mongodb.editor`.
      * `access_binding_deltas.subject.id` — идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.
      * `access_binding_deltas.subject.type` — тип субъекта, которому назначается роль.

          Допустимые типы субъектов:
          
          * `userAccount` — [аккаунт на Яндексе](../../iam/concepts/users/accounts.md#passport), добавленный в Yandex Cloud, или аккаунт из [пула пользователей](../../organization/concepts/user-pools.md).
          * `serviceAccount` — [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), созданный в Yandex Cloud.
          * `federatedUser` — аккаунт пользователя [федерации удостоверений](../../organization/concepts/add-federation.md).
          * `system` — [публичная группа](../../iam/concepts/access-control/public-group.md) пользователей.
          
              Допустимые значения идентификатора субъекта:
          
              * `allAuthenticatedUsers` — [все пользователи, прошедшие аутентификацию](../../iam/concepts/access-control/public-group.md#allAuthenticatedUsers).
              * `allUsers` — [любой пользователь](../../iam/concepts/access-control/public-group.md#allUsers), прохождение аутентификации не требуется.
              * `group:organization:<идентификатор_организации>:users` — все пользователи указанной [организации](../../organization/concepts/organization.md).
              * `group:federation:<идентификатор_федерации>:users` — все пользователи указанной федерации удостоверений.
          
          Подробнее о типах субъектов см. в разделе [Субъект, которому назначается роль](../../iam/concepts/access-control/index.md#subject).

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
        -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
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
        mdb.api.cloud.yandex.net:443 \
        yandex.cloud.mdb.mongodb.v1.ClusterService.UpdateAccessBindings
      ```

      Где:

      * `resource_id` — идентификатор кластера.
      * `access_binding_deltas.roleId` — назначаемая [роль](../security/index.md#roles-list), например `managed-mongodb.editor`.
      * `access_binding_deltas.subject.id` — идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.
      * `access_binding_deltas.subject.type` — тип субъекта, которому назначается роль.

          Допустимые типы субъектов:
          
          * `userAccount` — [аккаунт на Яндексе](../../iam/concepts/users/accounts.md#passport), добавленный в Yandex Cloud, или аккаунт из [пула пользователей](../../organization/concepts/user-pools.md).
          * `serviceAccount` — [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), созданный в Yandex Cloud.
          * `federatedUser` — аккаунт пользователя [федерации удостоверений](../../organization/concepts/add-federation.md).
          * `system` — [публичная группа](../../iam/concepts/access-control/public-group.md) пользователей.
          
              Допустимые значения идентификатора субъекта:
          
              * `allAuthenticatedUsers` — [все пользователи, прошедшие аутентификацию](../../iam/concepts/access-control/public-group.md#allAuthenticatedUsers).
              * `allUsers` — [любой пользователь](../../iam/concepts/access-control/public-group.md#allUsers), прохождение аутентификации не требуется.
              * `group:organization:<идентификатор_организации>:users` — все пользователи указанной [организации](../../organization/concepts/organization.md).
              * `group:federation:<идентификатор_федерации>:users` — все пользователи указанной федерации удостоверений.
          
          Подробнее о типах субъектов см. в разделе [Субъект, которому назначается роль](../../iam/concepts/access-control/index.md#subject).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/updateAccessBindings.md#yandex.cloud.operation.Operation).

{% endlist %}

## Примеры {#examples}

### Добавить сервисному аккаунту доступ к управлению кластером {#sa-cluster-control}

Чтобы сервисный аккаунт мог просматривать информацию обо всех кластерах Yandex StoreDoc в каталоге, но изменять ресурсы только конкретного кластера, выдайте ему роль `managed-mongodb.viewer` на каталог и роль `managed-mongodb.editor` на этот кластер:

{% list tabs group=instructions %}

- CLI {#cli}

  1. Назначьте роль на каталог:

      ```bash
      yc resource-manager folder add-access-binding <имя_или_идентификатор_каталога> \
        --role managed-mongodb.viewer \
        --subject=serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

  1. Назначьте роли на кластер:

      ```bash
      yc managed-mongodb cluster add-access-bindings <имя_или_идентификатор_кластера> \
        --access-binding role=managed-mongodb.editor,subject=serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

  1. Проверьте список ролей, назначенных на кластер:

      ```bash
      yc managed-mongodb cluster list-access-bindings <имя_или_идентификатор_кластера>
      ```

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

  1. Добавьте описание ресурсов:

      ```hcl
      resource "yandex_resourcemanager_folder_iam_member" "mmg-viewer-account-iam" {
        folder_id   = "<идентификатор_каталога>"
        role        = "managed-mongodb.viewer"
        member      = "serviceAccount:<идентификатор_сервисного_аккаунта>"
      }

      resource "yandex_mdb_mongodb_cluster_iam_binding" "mmg-cluster-editor" {
        cluster_id = "<идентификатор_кластера>"
        role       = "managed-mongodb.editor"
        members    = ["serviceAccount:<идентификатор_сервисного_аккаунта>"]
      }
      ```

  1. Проверьте корректность конфигурационных файлов.

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Подтвердите изменение ресурсов.

      1. Выполните команду для просмотра планируемых изменений:
      
         ```bash
         terraform plan
         ```
      
         Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
      
      1. Если вас устраивают планируемые изменения, внесите их:
         1. Выполните команду:
      
            ```bash
            terraform apply
            ```
      
         1. Подтвердите изменение ресурсов.
         1. Дождитесь завершения операции.

  1. Проверьте список ролей, назначенных на кластер, выполнив команду [CLI](../../cli/index.md):

      ```bash
      yc managed-mongodb cluster list-access-bindings <имя_или_идентификатор_кластера>
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
                        "role_id": "managed-mongodb.viewer",
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
        --url 'https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/<идентификатор_кластера>:updateAccessBindings' \
        --data '{
                  "access_binding_deltas": [
                    {
                      "action": "ADD",
                      "access_binding": {
                        "role_id": "managed-mongodb.editor",
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
        --url 'https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/<идентификатор_кластера>:listAccessBindings'
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
                    "role_id": "managed-mongodb.viewer",
                    "subject": {
                      "id": "<идентификатор_сервисного_аккаунта>",
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
        -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "resource_id": "<идентификатор_кластера>",
              "access_binding_deltas": [
                {
                  "action": "ADD",
                  "access_binding": {
                    "role_id": "managed-mongodb.editor",
                    "subject": {
                      "id": "<идентификатор_сервисного_аккаунта>",
                      "type": "serviceAccount"
                    }
                  }
                }
              ]
            }' \
        mdb.api.cloud.yandex.net:443 \
        yandex.cloud.mdb.mongodb.v1.ClusterService.UpdateAccessBindings
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
        -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "resource_id": "<идентификатор_кластера>"
            }' \
        mdb.api.cloud.yandex.net:443 \
        yandex.cloud.mdb.mongodb.v1.ClusterService.ListAccessBindings
      ```

{% endlist %}