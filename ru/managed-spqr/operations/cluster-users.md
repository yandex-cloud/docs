---
title: Управление пользователями в {{ SPQR }}
description: Из статьи вы узнаете, как добавлять и удалять пользователей в {{ SPQR }}, а также управлять их индивидуальными настройками.
---

# Управление пользователями в {{ SPQR }}

Вы можете добавлять и удалять пользователей, а также управлять их индивидуальными настройками.

## Получить список пользователей {#list-users}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-spqr) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.spqr.cluster.switch_users }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список пользователей кластера, выполните команду:

  ```bash
  yc managed-sharded-postgresql user list \
       --cluster-name <имя_кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).


- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.List](../api-ref/User/list.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<идентификатор_кластера>/users'
     ```

     {% include [cluster-id-standard](../../_includes/managed-spqr/cluster-id-standard.md) %}

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/list.md#yandex.cloud.mdb.spqr.v1.ListUsersResponse).

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
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.UserService.List
     ```

     {% include [cluster-id-standard](../../_includes/managed-spqr/cluster-id-standard.md) %}

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/list.md#yandex.cloud.mdb.spqr.v1.ListUsersResponse).

{% endlist %}

## Получить информацию о пользователе {#get-user}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить информацию о пользователе кластера, выполните команду:

  ```bash
  yc managed-sharded-postgresql user get <имя_пользователя> \
       --cluster-name <имя_кластера>
  ```

  Имя пользователя можно запросить со [списком пользователей в кластере](#list-users).

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).


- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.Get](../api-ref/User/get.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>'
     ```

     {% include [cluster-id-standard](../../_includes/managed-spqr/cluster-id-standard.md) %}

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/get.md#yandex.cloud.mdb.spqr.v1.User).

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
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "user_name": "<имя_пользователя>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.UserService.Get
     ```

     {% include [cluster-id-standard](../../_includes/managed-spqr/cluster-id-standard.md) %}

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/get.md#yandex.cloud.mdb.spqr.v1.User).

{% endlist %}

## Создать пользователя {#add-user}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-spqr) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.spqr.cluster.switch_users }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.action_add-user }}**.
  1. Введите имя пользователя базы данных.

     {% include [user-name-limits](../../_includes/mdb/mspqr/console/user-name-limits.md) %}

  1. Введите пароль. Длина пароля — от 8 до 128 символов.

  1. Задайте максимальное количество подключений пользователя к БД.

  1. Задайте количество повторных попыток соединения [роутера](../concepts/index.md#router) с [шардами](../concepts/index.md#shard).

  1. Выберите один или несколько грантов, которые будут назначены пользователю.

     Возможные значения:
     - **reader**
     - **writer**
     - **admin**
     - **transfer**

  1. Выберите тип защиты от удаления.

     Возможные значения:
     - **{{ ui-key.yacloud.mdb.dialogs.action_deletion-protection-like-in-cluster }}**
     - **{{ ui-key.yacloud.mdb.dialogs.action_deletion-protection-enabled }}**
     - **{{ ui-key.yacloud.mdb.dialogs.action_deletion-protection-disabled }}**

  1. Выберите одну или несколько баз данных, к которым должен иметь доступ пользователь:
     1. В поле **{{ ui-key.yacloud.mdb.dialogs.popup_field_permissions }}** нажмите значок ![image](../../_assets/console-icons/plus.svg) справа от выпадающего списка.
     1. Выберите базу данных из выпадающего списка.
     1. Повторите два предыдущих шага, пока не будут выбраны все требуемые базы данных.
     1. Чтобы удалить базу, добавленную по ошибке, нажмите значок ![image](../../_assets/console-icons/xmark.svg) справа от имени базы.

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.popup-button_add }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать пользователя в кластере, выполните команду:

  ```bash
  yc managed-sharded-postgresql user create <имя_пользователя> \
     --cluster-name <имя_кластера> \
     --password=<пароль> \
     --permissions=<список_баз_данных> \
     --grants=<список_грантов>
     --connection-limit=<максимальное_количество_соединений> \
     --connection-retries=<максимальное_количество_повторных_попыток_соединения>
  ```

  Где:

  * `cluster-name` — имя кластера.
  * `password` — пароль для пользователя. Длина пароля — от 8 до 128 символов.
  * `permissions` — список баз, к которым пользователь должен иметь доступ.
  * `grants` — список грантов, которые будут назначены пользователю. Возможные значения:
    * `reader`
    * `writer`
    * `admin`
    * `transfer`.
  * `connection-limit` — максимальное количество подключений пользователя к БД.
  * `connection-retries` — количество повторных попыток соединения [роутера](../concepts/index.md#router) с [шардами](../concepts/index.md#shard).

  {% include [user-name-limits](../../_includes/mdb/mspqr/console/user-name-limits.md) %}

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).


- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     Инструкцию по созданию такого файла читайте в разделе [Создание кластера](cluster-create.md).

     Полный список доступных для изменения полей конфигурации пользователей кластера {{ mspqr-name }} вы найдете в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_sharded_postgresql_user).

  1. Добавьте ресурс `yandex_mdb_sharded_postgresql_user`:

      ```hcl
      resource "yandex_mdb_sharded_postgresql_user" "my_user" {
        cluster_id = "<идентификатор_кластера>"
        name       = "<имя_пользователя>"
        password   = "<пароль>"
        grants     = [ "<роль1>","<роль2>" ]
        settings   = {
          connection_limit = <максимальное_количество_соединений>
          connection_retries = <максимальное_количество_повторных_попыток_соединения>
        }
        permissions {
          database = "<имя_БД>"
        }
      }
      ```

      Где:

      * `name` — имя пользователя.

          {% include [user-name-limits](../../_includes/mdb/mspqr/console/user-name-limits.md) %}

      * `password` — пароль пользователя. Длина пароля — от 8 до 128 символов.

      * `grants` — список грантов, которые будут назначены пользователю. Возможные значения:
          * `reader`
          * `writer`
          * `admin`
          * `transfer`

      * `settings` — настройки подключения:

          * `connection_limit` — максимальное количество подключений пользователя к БД.
          * `connection_retries` — количество повторных попыток соединения [роутера](../concepts/index.md#router) с [шардами](../concepts/index.md#shard).

      * `permissions` — база данных, к которой должен иметь доступ пользователь. Чтобы дать пользователю доступ к нескольким базам данных, укажите каждую базу данных в отдельном блоке `permissions`.

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}


- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.Create](../api-ref/User/create.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<идентификатор_кластера>/users' \
       --data '{
                 "userSpec": {
                   "name": "<имя_пользователя>",
                   "password": "<пароль_пользователя>",
                   "permissions": [
                     {
                       "databaseName": "<имя_БД>"
                     }
                   ],
                   "settings": {
                     "connectionLimit": "<максимальное_количество_подключений_к_БД>",
                     "connectionRetries": "<количество_попыток_соединения_с_шардами>"
                   },
                   "grants": [
                     "<список_грантов>"
                   ],
                   "deletionProtection": "<защитить_пользователя_от_удаления>"
                 }
               }'
     ```

     Где:

     * {% include [cluster-id](../../_includes/managed-spqr/cluster-id.md) %}
     * `userSpec` — настройки нового пользователя БД:

       * `name` — имя пользователя.

         {% include [user-name-limits](../../_includes/mdb/mspqr/console/user-name-limits.md) %}

       * `password` — пароль пользователя. Длина пароля — от 8 до 128 символов.

       * `permissions` — список баз данных, к которым должен иметь доступ пользователь. Каждый элемент списка содержит параметр `databaseName` — имя БД.

       * `settings` — настройки подключения:

         * `connLimit` — максимальное количество подключений пользователя к БД.
         * `connectionRetries` — количество повторных попыток соединения [роутера](../concepts/index.md#router) с [шардами](../concepts/index.md#shard).

       * `grants` — список грантов, которые будут назначены пользователю. Возможные значения:
         * `reader`
         * `writer`
         * `admin`
         * `transfer`

       * `deletionProtection` — защита пользователя от удаления: `true` или `false`.

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
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/user_service.proto \
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
               "settings": {
                 "connection_limit": "<максимальное_количество_подключений_к_БД>",
                 "connection_retries": "<количество_попыток_соединения_с_шардами>"
               },
               "grants": [
                 "<список_грантов>"
               ],
               "deletion_protection": "<защитить_пользователя_от_удаления>"
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.UserService.Create
     ```

     Где:

     * {% include [cluster-id-cluster](../../_includes/managed-spqr/cluster-id-cluster.md) %}
     * `user_spec` — настройки нового пользователя БД:

       * `name` — имя пользователя.

         {% include [user-name-limits](../../_includes/mdb/mspqr/console/user-name-limits.md) %}

       * `password` — пароль пользователя. Длина пароля — от 8 до 128 символов.

       * `permissions` — список баз данных, к которым должен иметь доступ пользователь. Каждый элемент списка содержит параметр `database_name` — имя БД.

       * `settings` — настройки подключения:

         * `connection_limit` — максимальное количество подключений пользователя к БД.
         * `connection_retries` — количество повторных попыток соединения [роутера](../concepts/index.md#router) с [шардами](../concepts/index.md#shard).

       * `grants` — список грантов, которые будут назначены пользователю. Возможные значения:
         * `reader`
         * `writer`
         * `admin`
         * `transfer`

       * `deletion_protection` — защита пользователя от удаления: `true` или `false`.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить настройки пользователя {#user-update-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-spqr) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.spqr.cluster.switch_users }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного пользователя и выберите пункт **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
  1. Измените максимальное количество подключений пользователя к БД.

  1. Измените количество повторных попыток соединения [роутера](../concepts/index.md#router) с [шардами](../concepts/index.md#shard).

  1. Настройте набор грантов, которые назначены пользователю.

     Возможные значения:
     - **reader**
     - **writer**
     - **admin**
     - **transfer**

  1. Настройте тип защиты от удаления.

     Возможные значения:
     - **{{ ui-key.yacloud.mdb.dialogs.action_deletion-protection-like-in-cluster }}**
     - **{{ ui-key.yacloud.mdb.dialogs.action_deletion-protection-enabled }}**
     - **{{ ui-key.yacloud.mdb.dialogs.action_deletion-protection-disabled }}**

  1. Настройте права пользователя на доступ к базам данных:
     1. Чтобы предоставить доступ к базам данных:
        1. В поле **{{ ui-key.yacloud.mdb.dialogs.popup_field_permissions }}** нажмите значок ![image](../../_assets/console-icons/plus.svg) справа от выпадающего списка.
        1. Выберите базу данных из выпадающего списка.
        1. Повторите два предыдущих шага, пока не будут выбраны все требуемые БД.
     1. Чтобы отозвать доступ к базе данных, нажмите значок ![image](../../_assets/console-icons/xmark.svg) справа от имени БД.

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.popup-button_save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  * Чтобы настроить права пользователя на доступ к определенным базам данных, выполните команду, перечислив список имен баз данных с помощью параметра `--permissions`:

     ```bash
     yc managed-sharded-postgresql user update <имя_пользователя> \
          --cluster-name=<имя_кластера> \
          --permissions=<список_баз_данных>
     ```

     Где:

     * `cluster-name` — имя кластера.
     * `permissions` — список баз, к которым пользователь должен иметь доступ.

     Имя кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

     Чтобы отозвать доступ к определенной базе, исключите ее имя из списка и выполните команду заново.

  * Чтобы изменить список грантов пользователя, выполните команду:

     ```bash
     yc managed-sharded-postgresql user update <имя_пользователя> \
       --cluster-name=<имя_кластера> \
       --grants=<новый_список_грантов>
     ```

     Имя кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

     Чтобы отозвать определенный грант, исключите его из списка и выполните команду заново.

  * Чтобы изменить настройки подключения для пользователя, выполните команду:

     ```bash
     yc managed-sharded-postgresql user update <имя_пользователя> \
       --cluster-name=<имя_кластера> \
       --connection-limit=<максимальное_количество_соединений> \
       --connection-retries=<максимальное_количество_повторных_попыток_соединения>
     ```

     Где:

     * `connection-limit` — максимальное количество подключений пользователя к БД.
     * `connection-retries` — количество повторных попыток соединения [роутера](../concepts/index.md#router) с [шардами](../concepts/index.md#shard).

     Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).


- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     Инструкцию по созданию такого файла читайте в разделе [Создание кластера](cluster-create.md).

     Полный список доступных для изменения полей конфигурации пользователей кластера {{ mspqr-name }} вы найдете в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_sharded_postgresql_user).

  1. Измените параметры в ресурсе `yandex_mdb_sharded_postgresql_user`:

      ```hcl
      resource "yandex_mdb_sharded_postgresql_user" "my_user" {
        ...
        name     = "<имя_пользователя>"
        grants   = [ "<роль1>","<роль2>" ]
        settings = {
          connection_limit = <максимальное_количество_соединений>
          connection_retries = <максимальное_количество_повторных_попыток_соединения>
        }
        permissions {
          database = "<имя_БД>"
        }
      }
      ```

      Где:

      * `name` — имя пользователя.

          {% include [user-name-limits](../../_includes/mdb/mspqr/console/user-name-limits.md) %}

          {% note warning %}

          Изменение имени пользователя в {{ TF }} приводит к удалению текущего пользователя и созданию нового с аналогичными настройками.

          {% endnote %}

      * `grants` — список грантов, которые будут назначены пользователю. Возможные значения:
          * `reader`
          * `writer`
          * `admin`
          * `transfer`

      * `settings` — настройки подключения:

          * `connection_limit` — максимальное количество подключений пользователя к БД.
          * `connection_retries` — количество повторных попыток соединения [роутера](../concepts/index.md#router) с [шардами](../concepts/index.md#shard).

      * `permissions` — база данных, к которой должен иметь доступ пользователь. Чтобы дать пользователю доступ к нескольким базам данных, укажите каждую базу данных в отдельном блоке `permissions`. Чтобы запретить пользователю доступ к определенной базе данных, удалите соответствующий блок `permissions`.

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}


- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.Update](../api-ref/User/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>' \
       --data '{
                 "updateMask": "<перечень_изменяемых_параметров>",
                 "password": "<пароль_пользователя>",
                 "permissions": [
                   {
                     "databaseName": "<имя_БД>"
                   }
                 ],
                 "settings": {
                   "connectionLimit": "<максимальное_количество_подключений_к_БД>",
                   "connectionRetries": "<количество_попыток_соединения_с_шардами>"
                 },
                 "grants": [
                   "<список_грантов>"
                 ],
                 "deletionProtection": "<защитить_пользователя_от_удаления>"
               }'
     ```

     Где:

     * {% include [cluster-id](../../_includes/managed-spqr/cluster-id.md) %}

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

     * `password` — новый пароль. Длина пароля — от 8 до 128 символов.

     * `permissions` — список баз данных, к которым должен иметь доступ пользователь. Каждый элемент списка содержит параметр `databaseName` — имя БД.

     * `settings` — настройки подключения:

       * `connLimit` — максимальное количество подключений пользователя к БД.
       * `connectionRetries` — количество повторных попыток соединения [роутера](../concepts/index.md#router) с [шардами](../concepts/index.md#shard).

     * `grants` — список грантов, которые будут назначены пользователю.

       Возможные значения:
       - `reader`
       - `writer`
       - `admin`
       - `transfer`

     * `deletionProtection` — защита пользователя от удаления: `true` или `false`.

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
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "user_name": "<имя_пользователя>",
             "update_mask": {
               "paths": [
                 "<массив_изменяемых_параметров>"
               ]
             },
             "password": "<пароль_пользователя>",
             "permissions": [
               {
                 "database_name": "<имя_БД>"
               }
             ],
             "settings": {
               "connection_limit": "<максимальное_количество_подключений_к_БД>",
               "connection_retries": "<количество_попыток_соединения_с_шардами>"
             },
             "grants": [
               "<список_грантов>"
             ],
             "deletion_protection": "<защитить_пользователя_от_удаления>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.UserService.Update
     ```

     Где:

     * {% include [cluster-id-cluster](../../_includes/managed-spqr/cluster-id-cluster.md) %}

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

     * `password` — пароль пользователя. Длина пароля — от 8 до 128 символов.

     * `permissions` — список баз данных, к которым должен иметь доступ пользователь. Каждый элемент списка содержит параметр `database_name` — имя БД.

     * `settings` — настройки подключения:

       * `connection_limit` — максимальное количество подключений пользователя к БД.
       * `connection_retries` — количество повторных попыток соединения [роутера](../concepts/index.md#router) с [шардами](../concepts/index.md#shard).

     * `grants` — список грантов, которые будут назначены пользователю.

       Возможные значения:
       - `reader`
       - `writer`
       - `admin`
       - `transfer`

     * `deletion_protection` — защита пользователя от удаления: `true` или `false`.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить пароль пользователя {#user-update-password}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-spqr) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.spqr.cluster.switch_users }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного пользователя и выберите пункт **{{ ui-key.yacloud.mdb.cluster.users.button_action-password }}**.
  1. Введите новый пароль. Длина пароля — от 8 до 128 символов.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.popup-password_button_change }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить пароль пользователя, выполните команду:

  ```bash
  yc managed-sharded-postgresql user update <имя_пользователя> \
       --cluster-name=<имя_кластера> \
       --password=<новый_пароль>
  ```

    Длина пароля — от 8 до 128 символов.

    Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).


- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     Инструкцию по созданию такого файла читайте в разделе [Создание кластера](cluster-create.md).

     Полный список доступных для изменения полей конфигурации пользователей кластера {{ mspqr-name }} вы найдете в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_sharded_postgresql_user).

  1. Измените параметры в ресурсе `yandex_mdb_sharded_postgresql_user`:

      ```hcl
      resource "yandex_mdb_sharded_postgresql_user" "my_user" {
        ...
        password = "<пароль>"
        ...
      }
      ```

      Где `password` — пароль пользователя. Длина пароля — от 8 до 128 символов.

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}


- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.Update](../api-ref/User/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>' \
       --data '{
                 "updateMask": "password",
                 "password": "<новый_пароль>"
               }'
     ```

     Где:

     * {% include [cluster-id](../../_includes/managed-spqr/cluster-id.md) %}
     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

       В данном случае передается только один параметр.

     * `password` — новый пароль. Длина пароля — от 8 до 128 символов.

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
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/user_service.proto \
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
       yandex.cloud.mdb.spqr.v1.UserService.Update
     ```

     Где:

     * {% include [cluster-id-cluster](../../_includes/managed-spqr/cluster-id-cluster.md) %}
     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

       В данном случае передается только один параметр.

     * `password` — новый пароль. Длина пароля — от 8 до 128 символов.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Настроить защиту от удаления {#user-update-deletion-protection}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-spqr) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.spqr.cluster.switch_users }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного пользователя и выберите пункт **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
  1. Измените тип защиты от удаления в поле **{{ ui-key.yacloud.mdb.dialogs.field_deletion_protection }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.popup-button_save }}**.

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.Update](../api-ref/User/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>' \
       --data '{
                 "updateMask": "deletionProtection",
                 "deletionProtection": "<защитить_пользователя_от_удаления>"
               }'
     ```

     Где:

     * {% include [cluster-id](../../_includes/managed-spqr/cluster-id.md) %}
     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

       В данном случае передается только один параметр.

     * `deletionProtection` — защита пользователя от удаления: `true` или `false`.

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
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "user_name": "<имя_пользователя>",
             "update_mask": {
               "paths": [
                 "deletion_protection"
               ]
             },
             "deletion_protection": "<защитить_пользователя_от_удаления>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.UserService.Update
     ```

     Где:

     * {% include [cluster-id-cluster](../../_includes/managed-spqr/cluster-id-cluster.md) %}
     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

       В данном случае передается только один параметр.

     * `deletion_protection` — защита пользователя от удаления: `true` или `false`.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Удалить пользователя {#user-remove}

Пользователь может быть защищен от удаления. Чтобы удалить такого пользователя, сперва [снимите защиту](#user-update-deletion-protection).

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы удалить пользователя:

  1. [Перейдите]({{ link-console-main }}/link/managed-spqr) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.spqr.cluster.switch_users }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного пользователя и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.
  1. Подтвердите удаление.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить пользователя, выполните команду:

  ```bash
  yc managed-sharded-postgresql user delete <имя_пользователя> \
       --cluster-name <имя_кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).


- {{ TF }} {#tf}

  Чтобы удалить пользователя:

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

  1. Удалите из манифеста ресурс `yandex_mdb_sharded_postgresql_user` с описанием пользователя, которого вы хотите удалить.

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}


- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.Delete](../api-ref/User/delete.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>'
     ```

     {% include [cluster-id-standard](../../_includes/managed-spqr/cluster-id-standard.md) %}

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
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "user_name": "<имя_пользователя>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.UserService.Delete
     ```

     {% include [cluster-id-standard](../../_includes/managed-spqr/cluster-id-standard.md) %}

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/delete.md#yandex.cloud.operation.Operation).

{% endlist %}
