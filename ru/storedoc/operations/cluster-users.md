---
title: Управление пользователями {{ SD }} в {{ mmg-full-name }}
description: Из статьи вы узнаете, как добавлять и удалять пользователей, а также управлять их индивидуальными настройками в сервисе по управлению базами данных {{ SD }}.
---

# Управление пользователями {{ SD }}

Вы можете добавлять и удалять пользователей, а также управлять их индивидуальными настройками и правами доступа к базам данных.

## Получить список пользователей {#list-users}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/storedoc) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mongodb.cluster.switch_users }}**.
  
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

  1. Воспользуйтесь методом [User.List](../api-ref/User/list.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

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
  1. Воспользуйтесь вызовом [UserService.List](../api-ref/grpc/User/list.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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


## Получить информацию о пользователе {#get-user}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог.
    1. [Перейдите]({{ link-console-main }}/link/storedoc) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mongodb.cluster.switch_users }}**.

        Информация о пользователе доступна в списке пользователей.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить информацию о конкретном пользователе:

    1. Посмотрите описание команды CLI для получения информации о пользователе:

        ```bash
        {{ yc-mdb-mg }} user get --help
        ```

    1. Получите информацию о пользователе, выполнив команду:

        ```bash
        {{ yc-mdb-mg }} user get <имя_пользователя> \
          --cluster-id=<идентификатор_кластера>
        ```

        Имя пользователя можно получить со [списком пользователей](#list-users) в кластере, а идентификатор кластера — со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [User.Get](../api-ref/User/get.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>'
        ```

        Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге, а имя пользователя — со [списком пользователей](#list-users) в кластере.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/get.md#yandex.cloud.mdb.mongodb.v1.User).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [UserService.Get](../api-ref/grpc/User/get.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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
          yandex.cloud.mdb.mongodb.v1.UserService.Get
          ```

        Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге, а имя пользователя — со [списком пользователей](#list-users) в кластере.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/get.md#yandex.cloud.mdb.mongodb.v1.User).

{% endlist %}


## Создать пользователя {#adduser}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/storedoc) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.

  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mongodb.cluster.switch_users }}**.

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.action_add-user }}**.

  
  1. Выберите способ авторизации:

      * **{{ ui-key.yacloud.mongodb.UserAddDialog.label_password_2MQCs }}** — авторизация по имени пользователя и паролю.
        
        Для этого способа авторизации введите имя пользователя и пароль.

        {% include [user-name-and-password-limits](../../_includes/mdb/mmg/note-info-user-name-and-pass-limits.md) %}

      * **{{ ui-key.yacloud.mongodb.UserAddDialog.label_iam_ffBD5 }}** — авторизация с помощью [аккаунта на Яндексе](../../iam/concepts/users/accounts.md#passport), [федеративного](../../iam/concepts/users/accounts.md#saml-federation) или [локального](../../iam/concepts/users/accounts.md#local) аккаунта.

        Для этого способа авторизации выберите аккаунт в поле **{{ ui-key.yacloud.common.user }}**.


  1. Выберите тип защиты пользователя от непреднамеренного удаления. Возможные значения:

     * **Как у кластера**.
     * **Включена**.
     * **Выключена**.

     {% include [deletion-protection-user](../../_includes/mdb/deletion-protection-user.md) %}

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
  
  1. Укажите параметры пользователя в команде создания:
     
     ```
     {{ yc-mdb-mg }} user create <имя_пользователя> \
       --cluster-name <имя_кластера> \
       --password <пароль_пользователя> \
       --permission database=<имя_БД>,role=<роль>,role=<другая_роль>,... \
       --permission database=<имя_другой_БД>,role=<роль>,... \
       --deletion-protection=<защитить_пользователя_от_удаления>
     ```
  
     Где:
     
     * `<имя_пользователя>`, `--password` — имя и пароль пользователя.

       {% include [user-name-and-password-limits](../../_includes/mdb/mmg/note-info-user-name-and-pass-limits.md) %}

     * `--cluster-name` — имя кластера, которое можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
     * `--permission` — разрешения пользователя для доступа к базе данных:
     
       * `database` — имя базы данных, к которой пользователь получает доступ.
         
         Имя базы данных можно запросить со [списком баз данных в кластере](databases.md#list-db).
       
       * `role` — роль пользователя в базе данных. Список доступных значений приведен в разделе [Пользователи и роли](../concepts/users-and-roles.md).
       
         Пользователю можно назначить несколько ролей в базе данных. Для этого каждую роль укажите в отдельном параметре `role`.
      
       Для каждой базы данных, к которой нужно предоставить доступ пользователю, задайте отдельный параметр `--permission`.
     
     * `--deletion-protection` — защита пользователя от непреднамеренного удаления: `true` или `false`. По умолчанию значение не задано, и для пользователя используется значение соответствующей настройки кластера. Если защита включена (`true`), удалить пользователя нельзя.

       {% include [deletion-protection-user](../../_includes/mdb/deletion-protection-user.md) %}

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        Инструкция по созданию такого файла приведена в разделе [Создание кластера](cluster-create.md).

    1. Добавьте ресурс `yandex_mdb_mongodb_user`:

        ```hcl
        resource "yandex_mdb_mongodb_user" "<имя_пользователя>" {
          cluster_id          = <идентификатор_кластера>
          name                = "<имя_пользователя>"
          password            = "<пароль>"
          deletion_protection = <защитить_пользователя_от_удаления>
          permission {
            database_name = "<имя_БД>"
            roles         = [ "<список_ролей_пользователя>" ]
          }
        }
        ```

        Где:
        
        * `cluster_id` — идентификатор кластера, который можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
        * `name`, `password` — имя и пароль пользователя.

          {% include [user-name-and-password-limits](../../_includes/mdb/mmg/note-info-user-name-and-pass-limits.md) %}

        * `deletion_protection` — защита пользователя от непреднамеренного удаления: `true` или `false`. По умолчанию значение не задано, и для пользователя используется значение соответствующей настройки кластера. Если защита включена (`true`), удалить пользователя нельзя.

          {% include [deletion-protection-user](../../_includes/mdb/deletion-protection-user.md) %}

        * `permission` — разрешения пользователя для доступа к базе данных:
          
          * `database_name` — имя базы данных, к которой пользователь получает доступ.
            
            Имя базы данных можно запросить со [списком баз данных в кластере](databases.md#list-db).

          * `roles` — список ролей пользователя в базе данных. Доступные значения приведены в разделе [Пользователи и роли](../concepts/users-and-roles.md).

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее читайте в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_mongodb_user).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.Create](../api-ref/User/create.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

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
                   ],
                   "deletionProtection": <защитить_пользователя_от_удаления>
                 }
               }'
     ```

     Где:

     * `<идентификатор_кластера>` — идентификатор кластера, который можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
     * `userSpec.name`, `userSpec.password` — имя и пароль пользователя.
       
       {% include [user-name-and-password-limits](../../_includes/mdb/mmg/note-info-user-name-and-pass-limits.md) %}

     * `userSpec.permissions` — настройки разрешений пользователя:

       * `databaseName` — имя базы данных, к которой пользователь получает доступ.
         
         Имя базы данных можно запросить со [списком баз данных в кластере](databases.md#list-db).

       * `roles` — массив ролей пользователя. Каждая роль представлена в виде отдельной строки в массиве. Список доступных значений приведен в разделе [Пользователи и роли](../concepts/users-and-roles.md).

       Для каждой базы данных добавьте отдельный элемент с настройками разрешений в массив `permissions`.
     
     * `userSpec.deletionProtection` — защита пользователя от непреднамеренного удаления: `true` или `false`. По умолчанию значение не задано, и для пользователя используется значение соответствующей настройки кластера. Если защита включена (`true`), удалить пользователя нельзя.

       {% include [deletion-protection-user](../../_includes/mdb/deletion-protection-user.md) %}

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/create.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [UserService.Create](../api-ref/grpc/User/create.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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
               ],
               "deletion_protection": <защитить_пользователя_от_удаления>
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.mongodb.v1.UserService.Create
     ```

     Где:
     
     * `cluster_id` — идентификатор кластера, который можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
     * `user_spec.name`, `user_spec.password` — имя и пароль пользователя.

       {% include [user-name-and-password-limits](../../_includes/mdb/mmg/note-info-user-name-and-pass-limits.md) %}

     * `user_spec.permissions` — настройки разрешений пользователя:

       * `database_name` — имя базы данных, к которой пользователь получает доступ.
         
         Имя базы данных можно запросить со [списком баз данных в кластере](databases.md#list-db).
         
       * `roles` — массив ролей пользователя. Каждая роль представлена в виде отдельной строки в массиве. Список доступных значений приведен в разделе [Пользователи и роли](../concepts/users-and-roles.md).

       Для каждой базы данных добавьте отдельный элемент с настройками разрешений в массив `permissions`.

     * `user_spec.deletion_protection` — защита пользователя от непреднамеренного удаления: `true` или `false`. По умолчанию значение не задано, и для пользователя используется значение соответствующей настройки кластера. Если защита включена (`true`), удалить пользователя нельзя.

       {% include [deletion-protection-user](../../_includes/mdb/deletion-protection-user.md) %}

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить настройки пользователя {#updateuser}

{% note info %}

Изменить имя пользователя нельзя.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/storedoc) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.

  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mongodb.cluster.switch_users }}**.

  
  1. Чтобы изменить пароль пользователя, нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного пользователя и выберите пункт **{{ ui-key.yacloud.mdb.cluster.users.button_action-password }}**:
  
     * **{{ ui-key.yacloud.component.password-input.label_button-enter-manually }}** — ввести свой пароль. Длина пароля — от 8 до 128 символов.
     * **{{ ui-key.yacloud.component.password-input.label_button-generate }}** — сгенерировать пароль с помощью сервиса [{{ connection-manager-name }}](cluster-create.md#conn-man).

        Чтобы увидеть новый сгенерированный пароль, на странице кластера выберите вкладку **{{ ui-key.yacloud.mongodb.cluster.switch_users }}** и нажмите **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** в строке нужного пользователя. Откроется страница секрета {{ lockbox-name }}, в котором хранится пароль. Новая версия пароля отмечается как **{{ ui-key.yacloud.lockbox.VersionsTable.label_version-current }}**.

     Для просмотра паролей требуется роль `lockbox.payloadViewer`.


  1. Чтобы настроить защиту пользователя от непреднамеренного удаления:

     1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного пользователя и выберите пункт **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
     1. Выберите нужное значение в поле **{{ ui-key.yacloud.mdb.dialogs.field_deletion_protection }}**.

  1. Чтобы изменить [роли](../concepts/users-and-roles.md) пользователя:

     1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного пользователя и выберите пункт **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
     1. Чтобы добавить роль, нажмите ![image](../../_assets/console-icons/plus.svg) напротив нужной БД и выберите роль.
     1. Чтобы удалить роль, нажмите на значок ![image](../../_assets/console-icons/xmark.svg) возле названия роли.

  1. Нажмите **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы изменить настройки пользователя:
  
  1. Посмотрите описание команды CLI для изменения пользователя:
  
     ```
     {{ yc-mdb-mg }} user update --help
     ```
  
  1. Укажите параметры пользователя в команде изменения:
     
     ```
     {{ yc-mdb-mg }} user update <имя_пользователя> \
       --cluster-name <имя_кластера> \
       --password <пароль_пользователя> \
       --permission database=<имя_БД>,role=<роль>,role=<другая_роль>,... \
       --permission database=<имя_другой_БД>,role=<роль>,... \
       --deletion-protection=<защитить_пользователя_от_удаления>
     ```
  
     Где:
     
     * `<имя_пользователя>` — имя пользователя, которое можно запросить со [списком пользователей в кластере](#list-users).
     * `--cluster-name` — имя кластера, которое можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
     * `--password` — пароль пользователя.

              
       Длина пароля от 8 до 128 символов.
       

     * `--permission` — разрешения пользователя для доступа к базе данных:
     
       * `database` — имя базы данных, к которой пользователь получает доступ.
         
         Имя базы данных можно запросить со [списком баз данных в кластере](databases.md#list-db).
       
       * `role` — роль пользователя в базе данных. Список доступных значений приведен в разделе [Пользователи и роли](../concepts/users-and-roles.md).

         Пользователю можно назначить несколько ролей в базе данных. Для этого каждую роль укажите в отдельном параметре `role`.
      
       Для каждой базы данных, к которой нужно предоставить доступ пользователю, задайте отдельный параметр `--permission`.
     
     * `--deletion-protection` — защита пользователя от непреднамеренного удаления: `true` или `false`. По умолчанию значение не задано, и для пользователя используется значение соответствующей настройки кластера. Если защита включена (`true`), удалить пользователя нельзя.

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

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), имя базы данных — со [списком баз данных в кластере](databases.md#list-db), имя пользователя — со [списком пользователей в кластере](#list-users).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        Инструкция по созданию такого файла приведена в разделе [Создание кластера](cluster-create.md).

    1. Найдите ресурс `yandex_mdb_mongodb_user`.
    1. Чтобы задать новый пароль, измените значение поля `password`:

        ```hcl
        resource "yandex_mdb_mongodb_user" "<имя_пользователя>" {
          ...
          password   = "<новый_пароль>"
          ...
        }
        ```

               
        Длина пароля от 8 до 128 символов.
       

    1. Чтобы настроить разрешения пользователя, измените список ролей в поле `roles`:
        
        ```hcl
        resource "yandex_mdb_mongodb_user" "<имя_пользователя>" {
          ...
          permission {
            database_name = "<имя_БД>"
            roles         = [ "<новый_список_ролей_пользователя>" ]
          }
          ...
        }
        ```

        Список доступных ролей приведен в разделе [Пользователи и роли](../concepts/users-and-roles.md).
    
    1. Чтобы включить или отключить защиту пользователя от непреднамеренного удаления, измените значение поля `deletion_protection`:

        ```hcl
        resource "yandex_mdb_mongodb_user" "<имя_пользователя>" {
          ...
          deletion_protection = <защитить_пользователя_от_удаления>
          ...
        }
        ```

        Где `deletion_protection` — защита пользователя от непреднамеренного удаления: `true` или `false`. По умолчанию значение не задано, и для пользователя используется значение соответствующей настройки кластера. Если защита включена (`true`), удалить пользователя нельзя.

    1. Проверьте корректность настроек.
  
        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее читайте в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_mongodb_user).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.Update](../api-ref/User/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>' \
       --data '{
                "updateMask": "password,permissions.databaseName,permissions.roles,deletionProtection",
                "password": "<пароль_пользователя>",
                "permissions": [
                  {
                    "databaseName": "<имя_БД>",
                    "roles": [
                      "<роль_1>", "<роль_2>", ..., "<роль_N>"
                    ]
                  }
                ],
                "deletionProtection": <защитить_пользователя_от_удаления>
              }'
     ```

     Где:

     * `<идентификатор_кластера>` — идентификатор кластера, который можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
     * `<имя_пользователя>` — имя пользователя, которое можно запросить со [списком пользователей в кластере](#list-users).
     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.
     * `password` — пароль пользователя.

              
       Длина пароля от 8 до 128 символов.
       

     * `permissions` — настройки разрешений пользователя:

       * `databaseName` — имя базы данных, к которой пользователь получает доступ.
         
         Имя базы данных можно запросить со [списком баз данных в кластере](databases.md#list-db).

       * `roles` — массив ролей пользователя. Каждая роль представлена в виде отдельной строки в массиве. Список доступных значений приведен в разделе [Пользователи и роли](../concepts/users-and-roles.md).
     
     * `deletionProtection` — защита пользователя от непреднамеренного удаления: `true` или `false`. По умолчанию значение не задано, и для пользователя используется значение соответствующей настройки кластера. Если защита включена (`true`), удалить пользователя нельзя.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [UserService.Update](../api-ref/grpc/User/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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
                 "permissions.roles",
                 "deletion_protection"
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
             ],
             "deletion_protection": <защитить_пользователя_от_удаления>
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.mongodb.v1.UserService.Update
     ```

     Где:

     * `cluster_id` — идентификатор кластера, который можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
     * `user_name` — имя пользователя, которое можно запросить со [списком пользователей в кластере](#list-users).

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.
     * `password` — пароль пользователя.

              
       Длина пароля от 8 до 128 символов.
       

     * `permissions` — настройки разрешений пользователя:

       * `database_name` — имя базы данных, к которой пользователь получает доступ.
         
         Имя базы данных можно запросить со [списком баз данных в кластере](databases.md#list-db).

       * `roles` — массив ролей пользователя. Каждая роль представлена в виде отдельной строки в массиве. Список доступных значений приведен в разделе [Пользователи и роли](../concepts/users-and-roles.md).
     
     * `deletion_protection` — защита пользователя от непреднамеренного удаления: `true` или `false`. По умолчанию значение не задано, и для пользователя используется значение соответствующей настройки кластера. Если защита включена (`true`), удалить пользователя нельзя.
     
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation). 

{% endlist %}

## Удалить пользователя {#removeuser}

{% note info %}

Перед удалением пользователя [отключите его защиту от удаления](#updateuser).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/storedoc) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mongodb.cluster.switch_users }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного пользователя и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.
  
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

        Инструкция по созданию такого файла приведена в разделе [Создание кластера](cluster-create.md).

    1. Удалите ресурс `yandex_mdb_mongodb_user` с описанием нужного пользователя.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее читайте в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_mongodb_user).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.Delete](../api-ref/User/delete.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

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
  1. Воспользуйтесь вызовом [UserService.Delete](../api-ref/grpc/User/delete.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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
