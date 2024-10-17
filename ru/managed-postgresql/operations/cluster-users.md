---
title: Управление пользователями кластера {{ PG }} в {{ mpg-full-name }}
description: Из статьи вы узнаете, как добавлять и удалять пользователей, а также управлять их индивидуальными настройками в сервисе по управлению базами данных {{ PG }}.
---

# Управление пользователями {{ PG }}

Вы можете добавлять и удалять пользователей, а также управлять их индивидуальными настройками.

{% note warning %}

С помощью команд SQL вы можете назначать пользователям привилегии, но не можете добавлять и изменять пользователей. Подробнее см. в разделе [Назначение привилегий и ролей пользователям](grant.md).

{% endnote %}

## Получить список пользователей {#list-users}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_users }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список пользователей кластера, выполните команду:

  ```
  {{ yc-mdb-pg }} user list \
       --cluster-name <имя_кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.list](../api-ref/User/list.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>/users'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/list.md#responses).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [UserService/List](../api-ref/grpc/User/list.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.UserService.List
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/list.mdUsersResponse).

{% endlist %}

## Создать пользователя {#adduser}

{% include [public-privilege](../../_includes/mdb/mpg/public-privilege.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_users }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.action_add-user }}**.
  1. Введите имя пользователя базы данных и пароль.

      {% include [user-name-and-password-limits](../../_includes/mdb/mpg/note-info-user-name-and-pass-limits.md) %}

  1. Выберите тип защиты от удаления.

     Возможные значения:
     - **Как у кластера**.
     - **Включена**.
     - **Выключена**.
  1. Выберите одну или несколько баз данных, к которым должен иметь доступ пользователь:
     1. В поле **{{ ui-key.yacloud.mdb.dialogs.popup_field_permissions }}** нажмите значок ![image](../../_assets/console-icons/plus.svg) справа от выпадающего списка.
     1. Выберите базу данных из выпадающего списка.
     1. Повторите два предыдущих шага, пока не будут выбраны все требуемые базы данных.
     1. Чтобы удалить базу, добавленную по ошибке, нажмите значок ![image](../../_assets/console-icons/xmark.svg) справа от имени базы.
  1. Задайте [настройки СУБД](../concepts/settings-list.md#dbms-user-settings) для пользователя.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать пользователя в кластере, выполните команду:

  ```
  {{ yc-mdb-pg }} user create <имя_пользователя> \
     --cluster-name <имя_кластера> \
     --password=<пароль> \
     --permissions=<список_баз> \
     --conn-limit=<максимальное_количество_соединений>
  ```

  Где:

  * `cluster-name` — имя кластера.
  * `password` — пароль для пользователя.
  * `permissions` — список баз, к которым пользователь должен иметь доступ.
  * `conn-limit` — максимальное количество соединений для пользователя.

  В этой команде указаны только основные настройки пользователя.

  {% include [user-name-and-password-limits](../../_includes/mdb/mpg/note-info-user-name-and-pass-limits.md) %}

  Чтобы задать настройки СУБД для пользователя, воспользуйтесь параметрами, описанными в разделе [Пользовательские настройки](../concepts/settings-list.md#dbms-user-settings).

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

     Полный список доступных для изменения полей конфигурации пользователей кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_postgresql_user).

  1. Добавьте ресурс `yandex_mdb_postgresql_user`:

      ```hcl
      resource "yandex_mdb_postgresql_user" "<имя_пользователя>" {
        cluster_id = "<идентификатор_кластера>"
        name       = "<имя_пользователя>"
        password   = "<пароль>"
        grants     = [ "<роль1>","<роль2>" ]
        login      = <разрешение_на_вход_в_БД>
        conn_limit = <максимальное_количество_соединений>
        deletion_protection = <защита_от_удаления>
        settings   = {
          <настройки_БД>
        }
        permission {
          database_name = "<имя_БД>"
        }
      }
      ```

      Где:
        * `login` — разрешение на вход в БД: `true` или `false`.
        * `deletion_protection` — защита пользователя от удаления: `true`, `false` или `unspecified` (наследует значение от кластера). Значение по умолчанию — `unspecified`.

      {% include [user-name-and-password-limits](../../_includes/mdb/mpg/note-info-user-name-and-pass-limits.md) %}

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.create](../api-ref/User/create.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>/users' \
       --data '{
                 "userSpec": {
                   "name": "<имя_пользователя>",
                   "password": "<пароль_пользователя>",
                   "permissions": [
                     {
                       "databaseName": "<имя_БД>"
                     }
                   ],
                   "connLimit": "<максимальное_количество_подключений_к_БД>",
                   "deletionProtection": <защита_от_удаления:_true_или_false>
                 }
               }'
     ```

     Где `userSpec` — настройки нового пользователя БД:

     * `name` — имя пользователя.
     * `password` — пароль пользователя.

       {% include [username-and-password-limits](../../_includes/mdb/mpg/note-info-user-name-and-pass-limits.md) %}

     * `permissions.databaseName` — массив баз данных, к которым должен иметь доступ пользователь. Каждый элемент массива соответствует отдельной БД.
     * `connLimit` — максимальное количество подключений к БД для пользователя.
     * `deletionProtection` — защита от удаления БД.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/create.md#responses).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [UserService/Create](../api-ref/grpc/User/create.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "user_spec": {
               "name": "<имя_пользователя>",
               "password": "<пароль_пользователя>",
               "permissions": [
                 {
                   "database_name": "<имя_БД>"
                 }
               ],
               "conn_limit": "<максимальное_количество_подключений_к_БД>",
               "deletion_protection": <защита_от_удаления:_true_или_false>
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.UserService.Create
     ```

     Где `user_spec` — настройки нового пользователя БД:

     * `name` — имя пользователя.
     * `password` — пароль пользователя.

       {% include [username-and-password-limits](../../_includes/mdb/mpg/note-info-user-name-and-pass-limits.md) %}

     * `permissions.database_name` — массив баз данных, к которым должен иметь доступ пользователь. Каждый элемент массива соответствует отдельной БД.
     * `conn_limit` — максимальное количество подключений к БД для пользователя.
     * `deletion_protection` — защита от удаления БД.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation).

{% endlist %}

{% note info %}

Сразу после создания пользователь получает только привилегию `CONNECT` для выбранных баз данных, и не может выполнять никакие операции с базами данных. Чтобы дать пользователю доступ к базам, [назначьте](grant.md) ему нужные привилегии или роли.

{% endnote %}

## Изменить пароль {#updateuser}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_users }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.cluster.users.button_action-password }}**.
  1. Задайте новый пароль и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.popup-password_button_change }}**.

  {% include [password-limits](../../_includes/mdb/mpg/note-info-password-limits.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить пароль пользователя, выполните команду:

  ```
  {{ yc-mdb-pg }} user update <имя_пользователя> \
       --cluster-name=<имя_кластера> \
       --password=<новый_пароль>
  ```

  {% include [password-limits](../../_includes/mdb/mpg/note-info-password-limits.md) %}

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

      Полный список доступных для изменения полей конфигурации пользователей кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_postgresql_user).

  1. Найдите ресурс `yandex_mdb_postgresql_user` нужного пользователя.
  1. Измените значение поля `password`:

      ```hcl
      resource "yandex_mdb_postgresql_user" "<имя_пользователя>" {
        ...
        name     = "<имя_пользователя>"
        password = "<новый_пароль>"
        ...
      }
      ```

      {% include [password-limits](../../_includes/mdb/mpg/note-info-password-limits.md) %}

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.update](../api-ref/User/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>' \
       --data '{
                 "updateMask": "password",
                 "password": "<новый_пароль>"
               }'
     ```

     Где:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

       В данном случае передается только один параметр.

     * `password` — новый пароль.

       {% include [password-limits](../../_includes/mdb/mpg/note-info-password-limits.md) %}

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](#list-users).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/update.md#responses).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [UserService/Update](../api-ref/grpc/User/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "user_name": "<имя_пользователя>",
             "update_mask": {
               "paths": [
                 "password"
               ]
             },
             "password": "<новый_пароль>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.UserService.Update
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

       В данном случае передается только один параметр.

     * `password` — новый пароль.

       {% include [password-limits](../../_includes/mdb/mpg/note-info-password-limits.md) %}

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](#list-users).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation1).

{% endlist %}

## Изменить настройки пользователя {#update-settings}

{% note info %}

Привилегии и роли {{ PG }} не затрагиваются этими настройками и настраиваются отдельно.

О том, как задать привилегии и роли для пользователя, читайте в разделе [Назначение привилегий и ролей пользователям](grant.md).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_users }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
  1. Настройте права пользователя на доступ к определенным базам данных:
     1. Чтобы предоставить доступ к требуемым базам данных:
        1. В поле **{{ ui-key.yacloud.mdb.dialogs.popup_field_permissions }}** нажмите значок ![image](../../_assets/console-icons/plus.svg) справа от выпадающего списка.
        1. Выберите базу данных из выпадающего списка.
        1. Повторите два предыдущих шага, пока не будут выбраны все требуемые базы данных.
     1. Чтобы отозвать доступ к определенной базе, нажмите значок ![image](../../_assets/console-icons/xmark.svg) справа от имени базы.
  1. Нажмите **{{ ui-key.yacloud.mdb.dialogs.button_advanced-settings }}**, чтобы изменить максимальное допустимое количество соединений пользователя (**Conn limit**), возможность подключения к кластеру (**Login**) или другие [настройки {{ PG }}](../concepts/settings-list.md#dbms-user-settings).
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Из интерфейса командной строки можно изменить настройки пользователя:

  1. Чтобы настроить права пользователя на доступ к определенным базам данных, выполните команду, перечислив список имен баз данных с помощью параметра `--permissions`:

     ```
     {{ yc-mdb-pg }} user update <имя_пользователя> \
          --cluster-name=<имя_кластера> \
          --permissions=<список_баз>
     ```

     Где:

     * `cluster-name` — имя кластера.
     * `permissions` — список баз, к которым пользователь должен иметь доступ.

     Имя кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

     Эта команда предоставляет пользователю доступ к базам данных, указанным в списке.

     Чтобы отозвать доступ к определенной базе, исключите ее имя из списка и передайте команде обновленный список.

  1. Чтобы изменить [настройки {{ PG }}](../concepts/settings-list.md#dbms-user-settings) для пользователя, передайте параметры, отвечающие за требуемые настройки, в команде:

     ```
     {{ yc-mdb-pg }} user update <имя_пользователя> \
          --cluster-name=<имя_кластера> \
          --<настройка_1>=<значение_1> \
          --<настройка_2>=<значение_2> \
          --<настройка_3>=<список_значений> \
          ...
     ```

     Чтобы изменить лимит подключений пользователя, используйте параметр `--conn-limit`.

     Имя кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации пользователей кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_postgresql_user).

    1. Чтобы выдать пользователю права на доступ к определенным базам данных:
        1. Найдите ресурс `yandex_mdb_postgresql_user` нужного пользователя.
        1. Добавьте блоки `permission` с именами нужных баз данных:

            ```hcl
            resource "yandex_mdb_postgresql_user" "<имя_пользователя>" {
              ...
              name = "<имя_пользователя>"
              permission {
                database_name = "<имя_БД>"
              }
              permission {
                database_name = "<имя_БД>"
              }
              ...
            }
            ```

    1. Чтобы отозвать у пользователя права на доступ к определенной базе, удалите блок `permission` с ее именем из конфигурационного файла.

    1. Чтобы изменить [настройки {{ PG }}](../concepts/settings-list.md#dbms-user-settings) для пользователя, передайте параметры, отвечающие за требуемые настройки, в блоке `settings`:

        ```hcl
        resource "yandex_mdb_postgresql_user" "<имя_пользователя>" {
          ...
          name     = "<имя_пользователя>"
          settings = {
            <настройки_БД>
          }
          ...
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.update](../api-ref/User/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>' \
       --data '{
                 "updateMask": "settings",
                 "settings": {
                   <набор_настроек>
                 }
               }'
     ```

     Где:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

       В данном случае передается только один параметр.

     * `settings` — новые настройки. Доступный набор настроек см. в [описании метода](../api-ref/User/update.md#body_params) и в разделе [{#T}](../concepts/settings-list.md#dbms-user-settings).

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](#list-users).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/update.md#responses).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [UserService/Update](../api-ref/grpc/User/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "user_name": "<имя_пользователя>",
             "update_mask": {
               "paths": [
                 "settings"
               ]
             },
             "settings": {
               <набор_настроек>
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.UserService.Update
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

       В данном случае передается только один параметр.

     * `settings` — новые настройки. Доступный набор настроек см. в [описании метода](../api-ref/grpc/user_service.md#UserSettings3 и в разделе [{#T}](../concepts/settings-list.md#dbms-user-settings).

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](#list-users).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation1).

{% endlist %}

## Настроить защиту от удаления {#update-user-deletion-protection}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_users }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
  1. Настройте защиту от удаления пользователя. Для этого выберите нужное значение в поле **{{ ui-key.yacloud.mdb.forms.label_deletion-protection }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

    1. Найдите ресурс `yandex_mdb_postgresql_user` нужного пользователя.

    1. Добавьте параметр `deletion_protection`. Возможные значения: `true`, `false` или `unspecified` (наследует значение от кластера). Значение по умолчанию — `unspecified`.

        ```hcl
        resource "yandex_mdb_postgresql_user" "<имя_пользователя>" {
          ...
          deletion_protection = <защита_от_удаления>
          ...
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.update](../api-ref/User/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>' \
       --data '{
                 "updateMask": "deletionProtection",
                 "deletionProtection": <защита_от_удаления:_true_или_false>
                 }
               }'
     ```

     Где:

     Где:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

       В данном случае передается только один параметр.

     * `deletionProtection` — защита от удаления БД.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](#list-users).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/update.md#responses).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [UserService/Update](../api-ref/grpc/User/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "user_name": "<имя_пользователя>",
             "update_mask": {
               "paths": [
                 "deletion_protection"
               ]
             },
             "deletion_protection": <защита_от_удаления:_true_или_false>
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.UserService.Update
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

       В данном случае передается только один параметр.

     * `deletion_protection` — защита от удаления БД.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](#list-users).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation1).

{% endlist %}

{% note warning %}

Защита от удаления действует только на уровне конкретного пользователя. При удалении кластера будут удалены все пользователи, в том числе защищенные от удаления.

{% endnote %}

## Удалить пользователя {#removeuser}

Пользователь может быть защищен от удаления. Чтобы удалить такого пользователя, сперва [снимите защиту](#update-user-deletion-protection).

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы удалить пользователя:

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_users }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.
  1. Подтвердите удаление.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить пользователя, выполните команду:

  ```
  {{ yc-mdb-pg }} user delete <имя_пользователя> \
       --cluster-name <имя_кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

- {{ TF }} {#tf}

  Чтобы удалить пользователя:

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

     Полный список доступных для изменения полей конфигурации кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).

  1. Удалите ресурс `yandex_mdb_postgresql_user` с описанием нужного пользователя.

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.delete](../api-ref/User/delete.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](#list-users).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/delete.md#responses).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [UserService/Delete](../api-ref/grpc/User/delete.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "user_name": "<имя_пользователя>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.UserService.Delete
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](#list-users).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation2).

{% endlist %}

{% include [user-ro](../../_includes/mdb/mpg-user-examples.md) %}
