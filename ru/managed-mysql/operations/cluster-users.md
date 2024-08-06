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

- API {#api}

  Чтобы получить список пользователей, воспользуйтесь методом REST API [list](../api-ref/User/list.md) для ресурса [User](../api-ref/User/index.md) или вызовом gRPC API [UserService/List](../api-ref/grpc/user_service.md#List) и передайте в запросе идентификатор кластера в параметре `clusterId`.

  {% include [Получение идентификатора кластера](../../_includes/mdb/mmy/note-api-get-cluster-id.md) %}

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

- API {#api}

  Чтобы создать пользователя, воспользуйтесь методом REST API [create](../api-ref/User/create.md) для ресурса [User](../api-ref/User/index.md) или вызовом gRPC API [UserService/Create](../api-ref/grpc/user_service.md#Create) и передайте в запросе:

  * Идентификатор кластера, в котором вы хотите создать пользователя, в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя пользователя в параметре `userSpec.name`.
  * Пароль пользователя в параметре `userSpec.password`.

      {% include [username-and-password-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

  * Имена баз данных, к которым пользователь должен иметь доступ, в необходимом количестве параметров `userSpec.permissions.databaseName`.
  * [Привилегии пользователя](../concepts/user-rights.md#db-privileges) для каждой из выбранных баз данных в одном или нескольких параметрах `userSpec.permissions.roles`.

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

- API {#api}

  Чтобы изменить пароль пользователя, воспользуйтесь методом REST API [update](../api-ref/User/update.md) для ресурса [User](../api-ref/User/index.md) или вызовом gRPC API [UserService/Update](../api-ref/grpc/user_service.md#Update) и передайте в запросе:

  * Идентификатор кластера, в котором находится пользователь, в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя пользователя в параметре `userName`. Чтобы узнать имя пользователя, [получите список пользователей в кластере](#list-users).
  * Новый пароль пользователя в параметре `password`.

      {% include [password-limits](../../_includes/mdb/mmy/note-info-password-limits.md) %}

  * Список полей конфигурации пользователя, которые необходимо изменить (в данном случае — `password`), в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

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

- API {#api}

  Чтобы изменить настройки пользователя, воспользуйтесь методом REST API [update](../api-ref/User/update.md) для ресурса [User](../api-ref/User/index.md) или вызовом gRPC API [UserService/Update](../api-ref/grpc/user_service.md#Update) и передайте в запросе:

  * Идентификатор кластера, в котором находится пользователь, в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя пользователя в параметре `userName`. Чтобы узнать имя пользователя, [получите список пользователей в кластере](#list-users).
  * Новые значения настроек пользователя.
  * Список полей конфигурации пользователя, которые необходимо изменить, в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

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

- API {#api}

  Чтобы удалить пользователя, воспользуйтесь методом REST API [delete](../api-ref/User/delete.md) для ресурса [User](../api-ref/User/index.md) или вызовом gRPC API [UserService/Delete](../api-ref/grpc/user_service.md#Delete) и передайте в запросе:

  * Идентификатор кластера, в котором находится пользователь, в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя пользователя в параметре `userName`. Чтобы узнать имя пользователя, [получите список пользователей в кластере](#list-users).

{% endlist %}

{% include [user-ro](../../_includes/mdb/mmy-user-examples.md) %}
