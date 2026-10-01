# Управление пользователями {{ MY }}

Вы можете добавлять и удалять пользователей, а также управлять их настройками.

{% include [mmy-no-sql-user-rights](../../_includes/mdb/mmy-no-sql-user-rights.md) %}

## Получить список пользователей {#list-users}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-mysql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.mysql.cluster.switch_users }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список пользователей кластера, выполните команду:

  ```bash
  {{ yc-mdb-my }} user list --cluster-name=<имя_кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.list](../api-ref/User/list.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

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
  1. Воспользуйтесь вызовом [UserService/List](../api-ref/grpc/User/list.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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

- SQL {#sql}

  Чтобы получить список всех пользователей в кластере {{ MY }}:

  1. [Выдайте права](grant.md) `mdb_admin` пользователю, от имени которого вы будете подключаться к базе данных.

  1. [Подключитесь к базе данных](connect/clients.md).

  1. Получите список всех пользователей:

      ```sql
      SELECT user FROM mysql.v_user;
      ```

      Пример результата:

      ```sql
      +-------+
      | user  |
      +-------+
      | user1 |
      | user2 |
      | user3 |
      +-------+
      ```

      Чтобы вывести более подробную информацию о пользователях, используйте запрос:

      ```sql
      SELECT * FROM mysql.v_user;
      ```

{% endlist %}

## Создать пользователя {#adduser}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-mysql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mysql.cluster.switch_users }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.action_add-user }}**.

  
  1. Выберите способ аутентификации:
     
     * **{{ ui-key.yacloud.mysql.cluster.label_password_mM9e5 }}** — аутентификация по имени пользователя и паролю.

       1. Введите имя пользователя базы данных.

          {% include [user-name](../../_includes/mdb/mch/note-info-user-name-and-pass-limits.md) %}

       
       1. Выберите, как задать пароль:

          * **{{ ui-key.yacloud.component.password-input.label_button-enter-manually }}** — ввести свой пароль. Длина пароля — от 8 до 128 символов.

          * **{{ ui-key.yacloud.component.password-input.label_button-generate }}** — сгенерировать пароль с помощью сервиса {{ connection-manager-name }}.

          Чтобы увидеть пароль, на странице кластера выберите вкладку **{{ ui-key.yacloud.mysql.cluster.switch_users }}** и нажмите **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** в строке нового пользователя. Откроется страница секрета {{ lockbox-name }}, в котором хранится пароль. Для просмотра паролей требуется роль `lockbox.payloadViewer`.


     * **{{ ui-key.yacloud.mysql.cluster.label_iam_dgBhy }}** — аутентификация с помощью [аккаунта на Яндексе](../../iam/concepts/users/accounts.md#passport), [федеративного аккаунта](../../iam/concepts/users/accounts.md#saml-federation) или [локального пользователя](../../iam/concepts/users/accounts.md#local).

       В поле **{{ ui-key.yacloud.common.user }}** откройте список доступных аккаунтов пользователей и выберите нужный аккаунт. Чтобы найти нужный аккаунт, используйте строку поиска над списком.


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
  1. Выберите тип защиты от удаления. Возможные значения:
     - **Как у кластера**.
     - **Включена**.
     - **Выключена**.

     {% include [deletion-protection-user](../../_includes/mdb/deletion-protection-user.md) %}

  1. (Опционально) В блоке **Дополнительные настройки**: 
      * Задайте [настройки {{ MY }}](../concepts/settings-list.md#dbms-user-settings) для пользователя.
      * В поле **Global permissions** задайте [административные привилегии пользователя](../concepts/settings-list.md#setting-administrative-privileges) на уровне кластера.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.popup-add_button_add }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать пользователя в кластере, выполните команду:

  ```bash
  {{ yc-mdb-my }} user create <имя_пользователя> \
    --cluster-name=<имя_кластера> \
    --password=<пароль_пользователя> \
    --deletion-protection=<защита_от_удаления> \
    --permissions database=<имя_БД>,role=<привилегия_1>,role=<привилегия_2>,...,role=<привилегия_N>
  ```

  Где:

  * `cluster-name` — имя кластера.

  * `password` — пароль для пользователя. Длина пароля — от 8 до 128 символов.

    
    Пароль также можно сгенерировать с помощью сервиса {{ connection-manager-name }}. Для этого вместо `--password=<пароль>` укажите `--generate-password`.

    Чтобы увидеть пароль, в [консоли управления]({{ link-console-main }}) выберите нужный кластер, перейдите на вкладку **{{ ui-key.yacloud.mysql.cluster.switch_users }}** и нажмите **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** в строке нового пользователя. Откроется страница секрета {{ lockbox-name }}, в котором хранится пароль. Для просмотра паролей требуется роль `lockbox.payloadViewer`.


  * `deletion-protection` — защита пользователя от непреднамеренного удаления: `enabled`, `disabled` или `inherited` (наследует значение от кластера). Значение по умолчанию — `disabled`.

    {% include [deletion-protection-user](../../_includes/mdb/deletion-protection-user.md) %}

  * `permissions` — БД, к которой пользователь получает доступ, и привилегии пользователя для этой БД. Список доступных привилегий приведен в разделе [{#T}](../concepts/user-rights.md#db-privileges).

    Для каждой базы данных, к которой пользователю нужен доступ, добавьте отдельный параметр `permissions`.

  {% include [username-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      Как создать такой файл описано в разделе [Создание кластера](./cluster-create.md).

  1. Добавьте ресурс `yandex_mdb_mysql_user_v2`:

      ```hcl
      resource "yandex_mdb_mysql_user_v2" "<имя_пользователя>" {
        cluster_id               = "<идентификатор_кластера>"
        name                     = "<имя_пользователя>"
        password                 = "<пароль>"
        deletion_protection_mode = "<защита_от_удаления>"
        permission {
          database_name = "<имя_БД>"
          roles         = [<список_привилегий>]
        }
        ...
      }
      ```

      Где:

      * `database_name` — имя БД, к которой пользователь должен иметь доступ.
      * `deletion_protection_mode` — защита пользователя от непреднамеренного удаления:

         * `DELETION_PROTECTION_MODE_ENABLED` — включена;
         * `DELETION_PROTECTION_MODE_DISABLED` (по умолчанию) — выключена;
         * `DELETION_PROTECTION_MODE_INHERITED` — наследует значение от кластера.

      * `roles` — список привилегий пользователя по отношению к БД.

      {% include [username-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

      Длина пароля — от 8 до 128 символов.

      
      Пароль также можно сгенерировать с помощью сервиса {{ connection-manager-name }}. Для этого вместо `password = "<пароль>"` укажите `generate_password = true`.

      Чтобы увидеть пароль, в [консоли управления]({{ link-console-main }}) выберите нужный кластер, перейдите на вкладку **{{ ui-key.yacloud.mysql.cluster.switch_users }}** и нажмите **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** в строке нового пользователя. Откроется страница секрета {{ lockbox-name }}, в котором хранится пароль. Для просмотра паролей требуется роль `lockbox.payloadViewer`.


  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее о параметрах ресурса `yandex_mdb_mysql_user_v2` смотрите в [документации провайдера]({{ tf-provider-resources-link }}/mdb_mysql_user_v2).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

      ```json
      {
          "userSpec": {
              "name": "<имя_пользователя>",
              "password": "<пароль_пользователя>",
              "deletionProtectionMode": "<защита_от_удаления>",
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

          {% include [username-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

      * `password` — пароль пользователя. Длина пароля — от 8 до 128 символов.

          
          Пароль также можно сгенерировать с помощью сервиса {{ connection-manager-name }}. Для этого вместо `"password": "<пароль_пользователя>"` укажите `"generatePassword": true`.

          Чтобы увидеть пароль, в [консоли управления]({{ link-console-main }}) выберите созданный кластер, перейдите на вкладку **{{ ui-key.yacloud.mysql.cluster.switch_users }}** и нажмите **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** в строке нужного пользователя. Откроется страница секрета {{ lockbox-name }}, в котором хранится пароль. Для просмотра паролей требуется роль `lockbox.payloadViewer`.


      * `deletionProtectionMode` — защита пользователя от непреднамеренного удаления:

         * `DELETION_PROTECTION_MODE_ENABLED` — включена;
         * `DELETION_PROTECTION_MODE_DISABLED` (по умолчанию) — выключена;
         * `DELETION_PROTECTION_MODE_INHERITED` — наследует значение от кластера.

         {% include [deletion-protection-user](../../_includes/mdb/deletion-protection-user.md) %}

      * `permissions` — настройки разрешений пользователя:

          * `databaseName` — имя базы данных, к которой пользователь получает доступ.
          * `roles` — массив привилегий пользователя. Каждая привилегия представлена в виде отдельной строки в массиве. Список доступных значений приведен в разделе [{#T}](../concepts/user-rights.md#db-privileges).

          Для каждой базы данных добавьте отдельный элемент с настройками разрешений в массив `permissions`.

  1. Воспользуйтесь методом [User.create](../api-ref/User/create.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

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
              "deletion_protection_mode": "<защита_от_удаления>",
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

        {% include [username-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

      * `password` — пароль пользователя. Длина пароля — от 8 до 128 символов.

        
        Пароль также можно сгенерировать с помощью сервиса {{ connection-manager-name }}. Для этого вместо `"password": "<пароль_пользователя>"` укажите `"generate_password": true`.

        Чтобы увидеть пароль, в [консоли управления]({{ link-console-main }}) выберите созданный кластер, перейдите на вкладку **{{ ui-key.yacloud.mysql.cluster.switch_users }}** и нажмите **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** в строке нужного пользователя. Откроется страница секрета {{ lockbox-name }}, в котором хранится пароль. Для просмотра паролей требуется роль `lockbox.payloadViewer`.


      * `deletion_protection_mode` — защита пользователя от непреднамеренного удаления:

         * `DELETION_PROTECTION_MODE_ENABLED` — включена;
         * `DELETION_PROTECTION_MODE_DISABLED` (по умолчанию) — выключена;
         * `DELETION_PROTECTION_MODE_INHERITED` — наследует значение от кластера.

         {% include [deletion-protection-user](../../_includes/mdb/deletion-protection-user.md) %}

      * `permissions` — настройки разрешений пользователя:

          * `database_name` — имя базы данных, к которой пользователь получает доступ.
          * `roles` — массив привилегий пользователя. Каждая привилегия представлена в виде отдельной строки в массиве. Список доступных значений приведен в разделе [{#T}](../concepts/user-rights.md#db-privileges).

          Для каждой базы данных добавьте отдельный элемент с настройками разрешений в массив `permissions`.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Воспользуйтесь вызовом [UserService/Create](../api-ref/grpc/User/create.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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

  1. [Перейдите]({{ link-console-main }}/link/managed-mysql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mysql.cluster.switch_users }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.cluster.users.button_action-password }}**.

  
  1. Выберите, как задать новый пароль:

      * **{{ ui-key.yacloud.component.password-input.label_button-enter-manually }}** — ввести свой пароль. Длина пароля — от 8 до 128 символов.

      * **{{ ui-key.yacloud.component.password-input.label_button-generate }}** — сгенерировать пароль с помощью сервиса {{ connection-manager-name }}.


  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.popup-password_button_change }}**.

  
  Чтобы увидеть новый пароль, на странице кластера выберите вкладку **{{ ui-key.yacloud.mysql.cluster.switch_users }}** и нажмите **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** в строке нужного пользователя. Откроется страница секрета {{ lockbox-name }}, в котором хранится пароль. Новая версия пароля отмечается как **{{ ui-key.yacloud.lockbox.VersionsTable.label_version-current }}**.

  Для просмотра паролей требуется роль `lockbox.payloadViewer`.


- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить пароль пользователя, выполните команду:

  ```bash
  {{ yc-mdb-my }} user update <имя_пользователя> \
    --cluster-name=<имя_кластера> \
    --password=<новый_пароль>
  ```

  Длина пароля — от 8 до 128 символов.

  
  Новый пароль также можно сгенерировать с помощью сервиса {{ connection-manager-name }}. Для этого вместо `--password=<новый_пароль>` укажите `--generate-password`.

  Чтобы увидеть новый пароль, в [консоли управления]({{ link-console-main }}) выберите кластер, перейдите на вкладку **{{ ui-key.yacloud.mysql.cluster.switch_users }}** и нажмите **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** в строке нужного пользователя. Откроется страница секрета {{ lockbox-name }}, в котором хранится пароль. Новая версия пароля отмечается как **{{ ui-key.yacloud.lockbox.VersionsTable.label_version-current }}**.

  Для просмотра паролей требуется роль `lockbox.payloadViewer`.


  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      Как создать такой файл описано в разделе [Создание кластера](./cluster-create.md).

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

      Длина пароля — от 8 до 128 символов.

      
      Новый пароль также можно сгенерировать с помощью сервиса {{ connection-manager-name }}. Для этого вместо `password = "<новый_пароль>"` укажите `generate_password = true`.

      Чтобы увидеть новый пароль, в [консоли управления]({{ link-console-main }}) выберите кластер, перейдите на вкладку **{{ ui-key.yacloud.mysql.cluster.switch_users }}** и нажмите **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** в строке нужного пользователя. Откроется страница секрета {{ lockbox-name }}, в котором хранится пароль. Новая версия пароля отмечается как **{{ ui-key.yacloud.lockbox.VersionsTable.label_version-current }}**.

      {% note info %}

      Если старый пароль был сгенерирован, его нельзя перегенерировать с помощью {{ TF }} из-за ограничений провайдера.

      {% endnote %}


  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее о параметрах ресурса `yandex_mdb_mysql_user_v2` смотрите в [документации провайдера]({{ tf-provider-resources-link }}/mdb_mysql_user_v2).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.update](../api-ref/User/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

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

      * `password` — новый пароль. Длина пароля от 8 до 128 символов.

        
        Пароль также можно сгенерировать с помощью сервиса {{ connection-manager-name }}. Для этого измените содержимое поля `data`:

        ```bash
        {
          "updateMask": "generatePassword",
          "generatePassword": true
        }
        ```

        Чтобы увидеть новый пароль, в [консоли управления]({{ link-console-main }}) выберите кластер, перейдите на вкладку **{{ ui-key.yacloud.mysql.cluster.switch_users }}** и нажмите **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** в строке нужного пользователя. Откроется страница секрета {{ lockbox-name }}, в котором хранится пароль. Новая версия пароля отмечается как **{{ ui-key.yacloud.lockbox.VersionsTable.label_version-current }}**.

        Для просмотра паролей требуется роль `lockbox.payloadViewer`.


      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](#list-users).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [UserService/Update](../api-ref/grpc/User/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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

      * `password` — новый пароль. Длина пароля от 8 до 128 символов.

        
        Пароль также можно сгенерировать с помощью сервиса {{ connection-manager-name }}. Для этого измените содержимое параметра `d`:

        ```bash
        {
          "cluster_id": "<идентификатор_кластера>",
          "user_name": "<имя_пользователя>",
          "update_mask": {
            "paths": [
              "generate_password"
            ]
          },
          "generate_password": true
        }
        ```

        Чтобы увидеть новый пароль, в [консоли управления]({{ link-console-main }}) выберите кластер, перейдите на вкладку **{{ ui-key.yacloud.mysql.cluster.switch_users }}** и нажмите **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** в строке нужного пользователя. Откроется страница секрета {{ lockbox-name }}, в котором хранится пароль. Новая версия пароля отмечается как **{{ ui-key.yacloud.lockbox.VersionsTable.label_version-current }}**.

        Для просмотра паролей требуется роль `lockbox.payloadViewer`


      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](#list-users).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить настройки пользователя {#update-settings}

{% note tip %}

Чтобы изменить права пользователя на доступ к базам данных, воспользуйтесь [инструкцией](grant.md#grant-privilege).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-mysql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mysql.cluster.switch_users }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
  1. Настройте защиту пользователя от непреднамеренного удаления. Для этого выберите нужное значение в поле **{{ ui-key.yacloud.mdb.forms.label_deletion-protection }}**.
  1. Задайте [настройки {{ MY }}](../concepts/settings-list.md#dbms-user-settings) для пользователя.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы задать [настройки {{ MY }}](../concepts/settings-list.md#dbms-user-settings) для пользователя, выполните команду:

  ```bash
  {{ yc-mdb-my }} user update <имя_пользователя> \
    --cluster-name=<имя_кластера> \
    --deletion-protection=<защита_от_удаления> \
    --global-permissions=<список_привилегий> \
    --authentication-plugin=<плагин_аутентификации> \
    --max-questions-per-hour=<максимум_запросов> \
    --max-updates-per-hour=<максимум_запросов_UPDATE> \
    --max-connections-per-hour=<максимум_соединений> \
    --max-user-connections=<максимум_одновременных_соединений>
  ```

  Где:

  * `deletion-protection` — защита пользователя от непреднамеренного удаления: `enabled`, `disabled` или `inherited` (наследует значение от кластера).
  * `global-permissions` — список административных привилегий через запятую.
  * `max-questions-per-hour` — максимальное количество запросов в час.
  * `max-updates-per-hour` — максимальное количество запросов `UPDATE` в час.
  * `max-connections-per-hour` — максимальное количество соединений в час.
  * `max-user-connections` — максимальное количество одновременных соединений.

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      Как создать такой файл описано в разделе [Создание кластера](./cluster-create.md).

  1. Найдите ресурс `yandex_mdb_mysql_user_v2` нужного пользователя.

  1. Чтобы задать ограничения по количеству соединений и запросов, добавьте блок `connection_limits` к его описанию:

      ```hcl
      resource "yandex_mdb_mysql_user_v2" "<имя_пользователя>" {
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

  1. Чтобы настроить плагин аутентификации пользователя, добавьте параметр `authentication_plugin` к его описанию:

      ```hcl
      resource "yandex_mdb_mysql_user_v2" "<имя_пользователя>" {
        ...
        authentication_plugin = "<плагин_аутентификации>"
      }
      ```

  1. Чтобы настроить защиту от непреднамеренного удаления пользователя, добавьте параметр `deletion_protection_mode` к его описанию. Возможные значения:

      * `DELETION_PROTECTION_MODE_ENABLED` — включена;
      * `DELETION_PROTECTION_MODE_DISABLED` (по умолчанию) — выключена;
      * `DELETION_PROTECTION_MODE_INHERITED` — наследует значение от кластера.

      ```hcl
      resource "yandex_mdb_mysql_user_v2" "<имя_пользователя>" {
        ...
        deletion_protection_mode = "<защита_от_удаления>"
      }
      ```

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее о параметрах ресурса `yandex_mdb_mysql_user_v2` смотрите в [документации провайдера]({{ tf-provider-resources-link }}/mdb_mysql_user_v2).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.update](../api-ref/User/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

      ```bash
      curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>' \
          --data '{
                    "updateMask": "globalPermissions,connectionLimits,authenticationPlugin,deletionProtectionMode",
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
                    "authenticationPlugin": "<плагин_аутентификации>",
                    "deletionProtectionMode": "<защита_от_удаления>"
                  }'
      ```

      Где:

      * `updateMask` — перечень изменяемых параметров в одну строку через запятую.
      * `globalPermissions` — массив административных привилегий. Каждая привилегия представлена в виде отдельной строки в массиве. Список доступных значений приведен в [описании метода](../api-ref/User/update.md#yandex.cloud.mdb.mysql.v1.UpdateUserRequest).
      * `connectionLimits` — настройки подключений для пользователя:

          * `maxQuestionsPerHour` — максимальное количество запросов в час;
          * `maxUpdatesPerHour` — максимальное количество запросов `UPDATE` в час;
          * `maxConnectionsPerHour` — максимальное количество соединений в час;
          * `maxUserConnections` — максимальное количество одновременных соединений.

          Минимальное значение для каждой настройки подключений — `0`.

      * `authenticationPlugin` — плагин аутентификации пользователя. Список доступных плагинов приведен в [описании метода](../api-ref/User/update.md#yandex.cloud.mdb.mysql.v1.UpdateUserRequest).
      * `deletionProtectionMode` — защита пользователя от непреднамеренного удаления:
         * `DELETION_PROTECTION_MODE_ENABLED` — включена;
         * `DELETION_PROTECTION_MODE_DISABLED` (по умолчанию) — выключена;
         * `DELETION_PROTECTION_MODE_INHERITED` — наследует значение от кластера.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](#list-users).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [UserService/Update](../api-ref/grpc/User/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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
                    "authentication_plugin",
                    "deletion_protection_mode"
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
                "authentication_plugin": "<плагин_аутентификации>",
                "deletion_protection_mode": "<защита_от_удаления>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.UserService.Update
      ```

      Где:

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.
      * `global_permissions` — массив административных привилегий. Каждая привилегия представлена в виде отдельной строки в массиве. Список доступных значений приведен в [описании метода](../api-ref/grpc/User/update.md#yandex.cloud.mdb.mysql.v1.UpdateUserRequest).
      * `connection_limits` — настройки подключений для пользователя:

          * `max_questions_per_hour` — максимальное количество запросов в час;
          * `max_updates_per_hour` — максимальное количество запросов `UPDATE` в час;
          * `max_connections_per_hour` — максимальное количество соединений в час;
          * `max_user_connections` — максимальное количество одновременных соединений.

          Минимальное значение для каждой настройки подключений — `0`.

      * `authentication_plugin` — плагин аутентификации пользователя. Список доступных плагинов приведен в [описании метода](../api-ref/grpc/User/update.md#yandex.cloud.mdb.mysql.v1.UpdateUserRequest).
      * `deletion_protection_mode` — защита пользователя от непреднамеренного удаления:
         * `DELETION_PROTECTION_MODE_ENABLED` — включена;
         * `DELETION_PROTECTION_MODE_DISABLED` (по умолчанию) — выключена;
         * `DELETION_PROTECTION_MODE_INHERITED` — наследует значение от кластера.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](#list-users).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Удалить пользователя {#removeuser}

{% note info %}

Перед удалением пользователя [отключите его защиту от удаления](#update-settings).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-mysql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mysql.cluster.switch_users }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить пользователя, выполните команду:

  ```bash
  {{ yc-mdb-my }} user delete <имя_пользователя> --cluster-name=<имя_кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      Как создать такой файл описано в разделе [Создание кластера](cluster-create.md).

  1. Удалите ресурс `yandex_mdb_mysql_user_v2` с описанием нужного пользователя.

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее о параметрах ресурса `yandex_mdb_mysql_user_v2` смотрите в [документации провайдера]({{ tf-provider-resources-link }}/mdb_mysql_user_v2).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [User.delete](../api-ref/User/delete.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

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
  1. Воспользуйтесь вызовом [UserService/Delete](../api-ref/grpc/User/delete.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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
