# Управление пользователями {{ MY }}

Вы можете добавлять и удалять пользователей, а также управлять их настройками.

{% include [mmy-no-sql-user-rights](../../_includes/mdb/mmy-no-sql-user-rights.md) %}

## Получить список пользователей {#list-users}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку ![image-users](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mysql.cluster.switch_users }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список пользователей кластера, выполните команду:

  ```
  {{ yc-mdb-my }} user list --cluster-name=<имя_кластера>
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
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>/users'
      ```

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/list.md#yandex.cloud.mdb.mysql.v1.ListUsersResponse).

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
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/user_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.UserService.List
      ```

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/list.md#yandex.cloud.mdb.mysql.v1.ListUsersResponse).

{% endlist %}

## Создать пользователя {#adduser}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image-users](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mysql.cluster.switch_users }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.action_add-user }}**.
  1. Введите имя пользователя базы данных и пароль.

      {% include [user-name-and-passwords-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

  1. Выберите одну или несколько баз данных, к которым должен иметь доступ пользователь:
      1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.button_add-database }}**.
      1. Выберите нужную базу данных из выпадающего списка.
      1. Повторите два предыдущих шага, пока не будут выбраны все требуемые базы данных.
      1. Чтобы удалить базу, добавленную по ошибке, наведите курсор на строку с именем базы и нажмите значок ![image](../../_assets/console-icons/xmark.svg) в конце строки.
  1. Настройте [привилегии пользователя](../concepts/user-rights.md#db-privileges) для каждой из выбранных баз данных:
      1. Нажмите значок ![image](../../_assets/console-icons/plus.svg) в столбце **{{ ui-key.yacloud.mdb.dialogs.popup_field_roles }}**.
      1. Выберите привилегию, которую вы хотите добавить пользователю из выпадающего списка.
      1. Повторите два предыдущих шага, пока не будут добавлены все требуемые привилегии.
  1. Чтобы отозвать привилегию, выданную по ошибке, нажмите значок ![image](../../_assets/console-icons/xmark.svg) справа от ее имени.
  1. При необходимости задайте [настройки {{ MY }} и административные привилегии](../concepts/settings-list.md#dbms-user-settings) для пользователя.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.popup-add_button_add }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать пользователя в кластере, выполните команду:

  ```
  {{ yc-mdb-my }} user create <имя_пользователя> \
    --cluster-name=<имя_кластера> \
    --password=<пароль_пользователя> \
    --permissions=<список_БД>
  ```

  Где `permissions` — список БД, к которым пользователь должен иметь доступ.

  {% include [user-name-and-passwords-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](./cluster-create.md).

  1. Добавьте ресурс `yandex_mdb_mysql_user`:

      ```hcl
      resource "yandex_mdb_mysql_user" "<имя_пользователя>" {
        cluster_id = "<идентификатор_кластера>"
        name       = "<имя_пользователя>"
        password   = "<пароль>"
        permission {
          database_name = "<имя_БД>"
          roles         = [<список_привилегий>]
        }
        ...
      }
      ```

      Где:

      * `database_name` — имя БД, к которой пользователь должен иметь доступ.
      * `roles` — список привилегий пользователя по отношению к БД.

      {% include [user-name-and-passwords-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_mysql_user).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

      ```json
      {
          "userSpec": {
              "name": "<имя_пользователя>",
              "password": "<пароль_пользователя>",
              "permissions": [
                  {
                      "databaseName": "<имя_БД>",
                      "roles": [
                          "<привилегия_1>", "<привилегия_2>", ..., "<привилегия_N>"
                      ]
                  }
              ]
          }
      }'
      ```

      Где `userSpec` — настройки нового пользователя БД:

      * `name` — имя пользователя.
      * `password` — пароль пользователя.

          {% include [username-and-password-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

      * `permissions` — настройки разрешений пользователя:

          * `databaseName` — имя базы данных, к которой пользователь получает доступ.
          * `roles` — массив привилегий пользователя. Каждая привилегия представлена в виде отдельной строки в массиве. Список доступных значений см. в разделе [{#T}](../concepts/user-rights.md#db-privileges).

          Для каждой базы данных добавьте отдельный элемент с настройками разрешений в массив `permissions`.

  1. Воспользуйтесь методом [User.create](../api-ref/User/create.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>/users' \
          --data "@body.json"
      ```

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/create.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

      ```json
      {
          "cluster_id": "<идентификатор_кластера>",
          "user_spec": {
              "name": "<имя_пользователя>",
              "password": "<пароль_пользователя>",
              "permissions": [
                  {
                      "database_name": "<имя_БД>",
                      "roles": [
                          "<привилегия_1>", "<привилегия_2>", ..., "<привилегия_N>"
                      ]
                  }
              ]
          }
      }
      ```

      Где `user_spec` — настройки нового пользователя БД:

      * `name` — имя пользователя.
      * `password` — пароль пользователя.

          {% include [username-and-password-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

      * `permissions` — настройки разрешений пользователя:

          * `database_name` — имя базы данных, к которой пользователь получает доступ.
          * `roles` — массив привилегий пользователя. Каждая привилегия представлена в виде отдельной строки в массиве. Список доступных значений см. в разделе [{#T}](../concepts/user-rights.md#db-privileges).

          Для каждой базы данных добавьте отдельный элемент с настройками разрешений в массив `permissions`.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Воспользуйтесь вызовом [UserService/Create](../api-ref/grpc/User/create.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/user_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.UserService.Create \
          < body.json
      ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить пароль {#updateuser}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image-users](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mysql.cluster.switch_users }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.cluster.users.button_action-password }}**.
  1. Задайте новый пароль и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.popup-password_button_change }}**.

  {% include [passwords-limits](../../_includes/mdb/mmy/note-info-password-limits.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить пароль пользователя, выполните команду:

  ```
  {{ yc-mdb-my }} user update <имя_пользователя> \
    --cluster-name=<имя_кластера> \
    --password=<новый_пароль>
  ```

  {% include [passwords-limits](../../_includes/mdb/mmy/note-info-password-limits.md) %}

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](./cluster-create.md).

  1. Найдите ресурс `yandex_mdb_mysql_user` нужного пользователя.

  1. Измените значение поля `password`:

      ```hcl
      resource "yandex_mdb_mysql_user" "<имя_пользователя>" {
        cluster_id = "<идентификатор_кластера>"
        name       = "<имя_пользователя>"
        password   = "<новый_пароль>"
        ...
      }
      ```

     {% include [passwords-limits](../../_includes/mdb/mmy/note-info-password-limits.md) %}

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_mysql_user).

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
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>' \
          --data '{
                    "updateMask": "password",
                    "password": "<новый_пароль>"
                  }'
      ```

      Где:

      * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

          В данном случае передается только один параметр.

      * `password` — новый пароль.

          {% include [password-limits](../../_includes/mdb/mmy/note-info-password-limits.md) %}

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](#list-users).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/update.md#yandex.cloud.operation.Operation).

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
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/user_service.proto \
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
          yandex.cloud.mdb.mysql.v1.UserService.Update
      ```

      Где:

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

          В данном случае передается только один параметр.

      * `password` — новый пароль.

          {% include [password-limits](../../_includes/mdb/mmy/note-info-password-limits.md) %}

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](#list-users).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить настройки пользователя {#update-settings}

{% note tip %}

Чтобы изменить права пользователя на доступ к базам данных, воспользуйтесь [инструкцией](grant.md#grant-privilege).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image-users](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mysql.cluster.switch_users }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
  1. Задайте [настройки {{ MY }}](../concepts/settings-list.md#dbms-user-settings) для пользователя.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы задать [настройки {{ MY }}](../concepts/settings-list.md#dbms-user-settings) для пользователя, выполните команду:

  ```
  {{ yc-mdb-my }} user update <имя_пользователя> \
    --cluster-name=<имя_кластера> \
    --global-permissions=<список_привилегий> \
    --authentication-plugin=<плагин_аутентификации> \
    --max-questions-per-hour=<максимум_запросов> \
    --max-updates-per-hour=<максимум_запросов_UPDATE> \
    --max-connections-per-hour=<максимум_соединений> \
    --max-user-connections=<максимум_одновременных_соединений>
  ```

  Где:

  * `global-permissions` — список административных привилегий через запятую.
  * `max-questions-per-hour` — максимальное количество запросов в час.
  * `max-updates-per-hour` — максимальное количество запросов `UPDATE` в час.
  * `max-connections-per-hour` — максимальное количество соединений в час.
  * `max-user-connections` — максимальное количество одновременных соединений.

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](./cluster-create.md).

  1. Найдите ресурс `yandex_mdb_mysql_user` нужного пользователя.

  1. Чтобы задать ограничения по количеству соединений и запросов, добавьте блок `connection_limits` к его описанию:

      ```hcl
      resource "yandex_mdb_mysql_user" "<имя_пользователя>" {
        ...
        connection_limits {
          max_questions_per_hour   = <максимум_запросов>
          max_updates_per_hour     = <максимум_запросов_UPDATE>
          max_connections_per_hour = <максимум_соединений>
          max_user_connections     = <максимум_одновременных_соединений>
          ...
        }
      }
      ```

      Где:

      * `max-questions-per-hour` — максимальное количество запросов в час.
      * `max-updates-per-hour` — максимальное количество запросов `UPDATE` в час.
      * `max-connections-per-hour` — максимальное количество соединений в час.
      * `max-user-connections` — максимальное количество одновременных соединений.

  1. Чтобы настроить плагин аутентификации пользователя, добавьте блок `authentication_plugin` к его описанию:

      ```hcl
      resource "yandex_mdb_mysql_user" "<имя_пользователя>" {
        ...
        authentication_plugin = "<плагин_аутентификации>"
      }
      ```

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_mysql_user).

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
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>' \
          --data '{
                    "updateMask": "globalPermissions,connectionLimits,authenticationPlugin",
                    "globalPermissions": [
                      "<административная_привилегия_1>",
                      "<административная_привилегия_2>",
                      ...,
                      "<административная_привилегия_N>"
                    ],
                    "connectionLimits": {
                      "maxQuestionsPerHour": "<максимум_запросов>",
                      "maxUpdatesPerHour": "<максимум_запросов_UPDATE>",
                      "maxConnectionsPerHour": "<максимум_соединений>",
                      "maxUserConnections": "<максимум_одновременных_соединений>"
                    },
                    "authenticationPlugin": "<плагин_аутентификации>"
                  }'
      ```

      Где:

      * `updateMask` — перечень изменяемых параметров в одну строку через запятую.
      * `globalPermissions` — массив административных привилегий. Каждая привилегия представлена в виде отдельной строки в массиве. Список доступных значений см. в [описании метода](../api-ref/User/update.md#yandex.cloud.mdb.mysql.v1.UpdateUserRequest).
      * `connectionLimits` — настройки подключений для пользователя:

          * `maxQuestionsPerHour` — максимальное количество запросов в час;
          * `maxUpdatesPerHour` — максимальное количество запросов `UPDATE` в час;
          * `maxConnectionsPerHour` — максимальное количество соединений в час;
          * `maxUserConnections` — максимальное количество одновременных соединений.

          Минимальное значение для каждой настройки подключений — `0`.

      * `authenticationPlugin` — плагин аутентификации пользователя. Список доступных плагинов см. в [описании метода](../api-ref/User/update.md#yandex.cloud.mdb.mysql.v1.UpdateUserRequest).

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](#list-users).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/update.md#yandex.cloud.operation.Operation).

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
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/user_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "user_name": "<имя_пользователя>",
                "update_mask": {
                  "paths": [
                    "global_permissions",
                    "connection_limits",
                    "authentication_plugin"
                  ]
                },
                "global_permissions": [
                  "<административная_привилегия_1>",
                  "<административная_привилегия_2>",
                  ...,
                  "<административная_привилегия_N>"
                ],
                "connection_limits": {
                  "max_questions_per_hour": "<максимум_запросов>",
                  "max_updates_per_hour": "<максимум_запросов_UPDATE>",
                  "max_connections_per_hour": "<максимум_соединений>",
                  "max_user_connections": "<максимум_одновременных_соединений>"
                },
                "authentication_plugin": "<плагин_аутентификации>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.UserService.Update
      ```

      Где:

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.
      * `global_permissions` — массив административных привилегий. Каждая привилегия представлена в виде отдельной строки в массиве. Список доступных значений см. в [описании метода](../api-ref/grpc/User/update.md#yandex.cloud.mdb.mysql.v1.UpdateUserRequest).
      * `connection_limits` — настройки подключений для пользователя:

          * `max_questions_per_hour` — максимальное количество запросов в час;
          * `max_updates_per_hour` — максимальное количество запросов `UPDATE` в час;
          * `max_connections_per_hour` — максимальное количество соединений в час;
          * `max_user_connections` — максимальное количество одновременных соединений.

          Минимальное значение для каждой настройки подключений — `0`.

      * `authentication_plugin` — плагин аутентификации пользователя. Список доступных плагинов см. в [описании метода](../api-ref/grpc/User/update.md#yandex.cloud.mdb.mysql.v1.UpdateUserRequest).

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](#list-users).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Удалить пользователя {#removeuser}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image-users](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mysql.cluster.switch_users }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить пользователя, выполните команду:

  ```
  {{ yc-mdb-my }} user delete <имя_пользователя> --cluster-name=<имя_кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

  1. Удалите ресурс `yandex_mdb_mysql_user` с описанием нужного пользователя.

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_mysql_user).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.delete](../api-ref/User/delete.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request DELETE \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>'
      ```

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](#list-users).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/delete.md#yandex.cloud.operation.Operation).

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
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/user_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "user_name": "<имя_пользователя>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.UserService.Delete
      ```

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](#list-users).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation).

{% endlist %}

{% include [user-ro](../../_includes/mdb/mmy-user-examples.md) %}
