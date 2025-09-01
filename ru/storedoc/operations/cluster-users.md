---
title: Управление пользователями {{ SD }} в {{ mmg-full-name }}
description: Из статьи вы узнаете, как добавлять и удалять пользователей, а также управлять их индивидуальными настройками в сервисе по управлению базами данных {{ SD }}.
---

# Управление пользователями {{ SD }}

Вы можете добавлять и удалять пользователей, а также управлять их индивидуальными настройками и правами доступа к базам данных.

## Получить список пользователей {#list-users}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **Yandex StoreDoc**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_users }}**.
  
- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы получить список пользователей кластера, выполните команду:
  
  ```
  {{ yc-mdb-mg }} user list \
    --cluster-name <имя_кластера>
  ```
  
  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  
- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.List](../api-ref/User/list.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<идентификатор_кластера>/users'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/list.md#yandex.cloud.mdb.mongodb.v1.ListUsersResponse).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [UserService.List](../api-ref/grpc/User/list.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.mongodb.v1.UserService.List
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/list.md#yandex.cloud.mdb.mongodb.v1.ListUsersResponse).

{% endlist %}

## Создать пользователя {#adduser}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **Yandex StoreDoc**.

  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_users }}**.

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.action_add-user }}**.

  1. Введите имя пользователя БД и пароль.

      {% include [user-name-and-password-limits](../../_includes/mdb/mmg/note-info-user-name-and-pass-limits.md) %}

  1. Настройте [роли](../concepts/users-and-roles.md) пользователя:

     1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.button_add-database }}** и выберите БД, в которой вы хотите выдать роль.
     1. Добавьте роли с помощью кнопки ![image](../../_assets/console-icons/plus.svg).

     Вы можете выдать пользователю несколько ролей в разных базах данных.

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.popup-add_button_add }}**.

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы создать пользователя в кластере:
  
  1. Посмотрите описание команды CLI для создания пользователя:
  
     ```
     {{ yc-mdb-mg }} user create --help
     ```
  
  1. Укажите свойства пользователя в команде создания:
     ```
     {{ yc-mdb-mg }} user create <имя_пользователя> \
       --cluster-name <имя_кластера> \
       --password <пароль_для_пользователя> \
       --permission database=<имя_БД>,role=<роль>,role=<другая_роль>,... \
       --permission database=<имя_другой_БД>,role=<роль>,...
     ```
  
     {% include [user-name-and-password-limits](../../_includes/mdb/mmg/note-info-user-name-and-pass-limits.md) %}

     Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Добавьте ресурс `yandex_mdb_mongodb_user`:

        ```hcl
        resource "yandex_mdb_mongodb_user" "<имя_пользователя>" {
          cluster_id = <идентификатор_кластера>
          name       = "<имя_пользователя>"
          password   = "<пароль>"
          permission {
            database_name = "<имя_БД>"
            roles         = [ "<список_ролей_пользователя>" ]
          }
        }
        ```

        Где `database_name` — имя БД, к которой предоставляется доступ.

        {% include [user-name-and-password-limits](../../_includes/mdb/mmg/note-info-user-name-and-pass-limits.md) %}

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_mongodb_user).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.Create](../api-ref/User/create.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<идентификатор_кластера>/users' \
       --data '{
                 "userSpec": {
                   "name": "<имя_пользователя>",
                   "password": "<пароль_пользователя>",
                   "permissions": [
                     {
                       "databaseName": "<имя_БД>",
                       "roles": [
                        "<роль_1>", "<роль_2>", ..., "<роль_N>"
                       ]
                     }
                   ]
                 }
               }'
     ```

     Где `userSpec` — настройки нового пользователя БД:

     * `name` — имя пользователя.
     * `password` — пароль пользователя.

       {% include [user-name-and-password-limits](../../_includes/mdb/mmg/note-info-user-name-and-pass-limits.md) %}

     * `permissions` — настройки разрешений пользователя:

       * `databaseName` — имя базы данных, к которой пользователь получает доступ.
       * `roles` — массив ролей пользователя. Каждая роль представлена в виде отдельной строки в массиве. Список доступных значений см. в разделе [Пользователи и роли](../concepts/users-and-roles.md).

       Для каждой базы данных добавьте отдельный элемент с настройками разрешений в массив `permissions`.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/create.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [UserService.Create](../api-ref/grpc/User/create.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "user_spec": {
               "name": "<имя_пользователя>",
               "password": "<пароль_пользователя>",
               "permissions": [
                 {
                   "database_name": "<имя_БД>",
                   "roles": [
                      "<роль_1>", "<роль_2>", ..., "<роль_N>"
                   ]   
                 }
               ]
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.mongodb.v1.UserService.Create
     ```

     Где `user_spec` — настройки нового пользователя БД:

     * `name` — имя пользователя.
     * `password` — пароль пользователя.

          {% include [user-name-and-password-limits](../../_includes/mdb/mmg/note-info-user-name-and-pass-limits.md) %}

     * `permissions` — настройки разрешений пользователя:

       * `database_name` — имя базы данных, к которой пользователь получает доступ.
       * `roles` — массив ролей пользователя. Каждая роль представлена в виде отдельной строки в массиве. Список доступных значений см. в разделе [Пользователи и роли](../concepts/users-and-roles.md).

       Для каждой базы данных добавьте отдельный элемент с настройками разрешений в массив `permissions`.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить пользователя {#updateuser}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **Yandex StoreDoc**.

  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_users }}**.

  1. Чтобы изменить пароль пользователя, нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного пользователя и выберите пункт **{{ ui-key.yacloud.mdb.cluster.users.button_action-password }}**.

     {% include [password-limits](../../_includes/mdb/mch/note-info-password-limits.md) %}

  1. Чтобы изменить [роли](../concepts/users-and-roles.md) пользователя:

     1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного пользователя и выберите пункт **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
     1. Чтобы добавить роль, нажмите ![image](../../_assets/console-icons/plus.svg) напротив нужной БД и выберите роль.
     1. Чтобы удалить роль, нажмите на значок ![image](../../_assets/console-icons/xmark.svg) возле названия роли.

  1. Нажмите **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы изменить пароль или список ролей пользователя:
  
  1. Посмотрите описание команды CLI для изменения пользователя:
  
     ```
     {{ yc-mdb-mg }} user update --help
     ```
  
  1. Укажите свойства пользователя в команде изменения:
     ```
     {{ yc-mdb-mg }} user update <имя_пользователя> \
       --cluster-name <имя_кластера> \
       --password <пароль_для_пользователя> \
       --permission database=<имя_БД>,role=<роль>,role=<другая_роль>,... \
       --permission database=<имя_другой_БД>,role=<роль>,...
     ```
  
     {% include [password-limits](../../_includes/mdb/mch/note-info-password-limits.md) %}

  Чтобы добавить пользователю доступ к базе данных с определенным набором ролей:

  1. Посмотрите описание команды CLI для выдачи прав пользователю:
  
     ```
     {{ yc-mdb-mg }} user grant-permission --help
     ```
  
  1. Укажите свойства пользователя в команде выдачи прав:

     ```bash
     {{ yc-mdb-mg }} user grant-permission <имя_пользователя> \
       --cluster-name <имя_кластера> \
       --database <имя_БД> \
       --role <набор_ролей_через_запятую>
     ```

  Чтобы отозвать доступ у пользователя к базе данных:

  1. Посмотрите описание команды CLI для отзыва прав пользователя:
  
     ```
     {{ yc-mdb-mg }} user revoke-permission --help
     ```
  
  1. Укажите свойства пользователя в команде отзыва прав:

     ```bash
     {{ yc-mdb-mg }} user revoke-permission <имя_пользователя> \
       --cluster-name <имя_кластера> \
       --database <имя_БД>
     ```

      Эта команда полностью закрывает пользователю доступ к указанной базе данных.

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), имя базы данных — со [списком баз данных в кластере](databases.md#list-db), имя пользователя — со [списком пользователей в кластере](cluster-users.md#list-users).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Найдите ресурс `yandex_mdb_mongodb_user`.
    1. Измените значение поля `password` и значения полей в блоке `permission`:

        ```hcl
        resource "yandex_mdb_mongodb_user" "<имя_пользователя>" {
          cluster_id = <идентификатор_кластера>
          name       = "<имя_пользователя>"
          password   = "<новый_пароль>"
          permission {
            database_name = "<имя_БД>"
            roles         = [ "<новый_список_ролей_пользователя>" ]
          }
        }
        ```

        {% include [password-limits](../../_includes/mdb/mch/note-info-password-limits.md) %}

    1. Проверьте корректность настроек.
  
        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_mongodb_user).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.Update](../api-ref/User/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>' \
       --data '{
                "updateMask": "password,permissions.databaseName,permissions.roles",
                "password": "<пароль_пользователя>",
                "permissions": [
                  {
                    "databaseName": "<имя_БД>",
                    "roles": [
                      "<роль_1>", "<роль_2>", ..., "<роль_N>"
                    ]
                  }
                ]
              }'
     ```                

     Где:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.
     * `password` — пароль пользователя.

        {% include [user-name-and-password-limits](../../_includes/mdb/mmg/note-info-user-name-and-pass-limits.md) %}

     * `permissions` — настройки разрешений пользователя:

       * `database_name` — имя базы данных, к которой пользователь получает доступ.
       * `roles` — массив ролей пользователя. Каждая роль представлена в виде отдельной строки в массиве. Список доступных значений см. в разделе [Пользователи и роли](../concepts/users-and-roles.md).
 
     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](#list-users).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [UserService.Update](../api-ref/grpc/User/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "user_name": "<имя_пользователя>",
             "update_mask": {
               "paths": [
                 "password",
                 "permissions.database_name",
                 "permissions.roles"
               ]
             },
             "password": "<пароль_пользователя>",
             "permissions": [
               {
                 "database_name": "<имя_БД>",
                 "roles": [
                   "<роль_1>", "<роль_2>", ..., "<роль_N>"
                 ]
               }
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.mongodb.v1.UserService.Update
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в одну строку через запятую.
     * `password` — пароль пользователя.

        {% include [user-name-and-password-limits](../../_includes/mdb/mmg/note-info-user-name-and-pass-limits.md) %}

     * `permissions` — настройки разрешений пользователя:

       * `database_name` — имя базы данных, к которой пользователь получает доступ.
       * `roles` — массив ролей пользователя. Каждая роль представлена в виде отдельной строки в массиве. Список доступных значений см. в разделе [Пользователи и роли](../concepts/users-and-roles.md).

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](#list-users).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation). 

{% endlist %}

## Удалить пользователя {#removeuser}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **Yandex StoreDoc**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_users }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного пользователя и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.
  
- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы удалить пользователя, выполните команду:
  
  ```
  {{ yc-mdb-mg }} user delete <имя_пользователя> \
    --cluster-name <имя_кластера>
  ```
  
  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Удалите ресурс `yandex_mdb_mongodb_user` с описанием нужного пользователя.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_mongodb_user).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.Delete](../api-ref/User/delete.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](#list-users).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/delete.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [UserService.Delete](../api-ref/grpc/User/delete.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "user_name": "<имя_пользователя>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.mongodb.v1.UserService.Delete
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](#list-users).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/delete.md#yandex.cloud.operation.Operation).

{% endlist %}

{% include [user-ro](../../_includes/mdb/mmg-user-examples.md) %}
