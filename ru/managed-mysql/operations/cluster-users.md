# Управление пользователями {{ MY }}

Вы можете добавлять и удалять пользователей, а также управлять их настройками.

{% include [mmy-no-sql-user-rights](../../_includes/mdb/mmy-no-sql-user-rights.md) %}

## Получить список пользователей {#list-users}

{% list tabs %}

- Консоль управления
  
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mmy-name }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку ![image-users](../../_assets/mdb/user.svg) **Пользователи**.

- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы получить список пользователей кластера, выполните команду:
  
  ```
  {{ yc-mdb-my }} user list --cluster-name=<имя кластера>
  ```
  
  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

- API

  Воспользуйтесь методом API [list](../api-ref/User/list.md) и передайте в запросе идентификатор кластера в параметре `clusterId`.

  {% include [Получение идентификатора кластера](../../_includes/mdb/mmy/note-api-get-cluster-id.md) %}

{% endlist %}

## Добавить пользователя {#adduser}

{% list tabs %}

- Консоль управления
  
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mmy-name }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image-users](../../_assets/mdb/user.svg) **Пользователи**.
  1. Нажмите кнопку **Добавить**.
  1. Введите имя пользователя базы данных и пароль.

      {% include [user-name-and-passwords-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

  1. Выберите одну или несколько баз данных, к которым должен иметь доступ пользователь:
      1. Нажмите кнопку **Добавить базу данных**.
      1. Выберите нужную базу данных из выпадающего списка.
      1. Повторите два предыдущих шага, пока не будут выбраны все требуемые базы данных.
      1. Чтобы удалить базу, добавленную по ошибке, наведите курсор на строку с именем базы и нажмите значок ![image](../../_assets/cross.svg) в конце строки.
  1. Настройте [привилегии пользователя](../concepts/user-rights.md#db-privileges) для каждой из выбранных баз данных:
      1. Нажмите значок ![image](../../_assets/plus-sign.svg) в столбце **Роли**.
      1. Выберите привилегию, которую вы хотите добавить пользователю из выпадающего списка.
      1. Повторите два предыдущих шага, пока не будут добавлены все требуемые привилегии.
  1. Чтобы отозвать привилегию, выданную по ошибке, нажмите значок ![image](../../_assets/cross.svg) справа от ее имени.
  1. При необходимости задайте [настройки {{ MY }} и административные привилегии](../concepts/settings-list.md#dbms-user-settings) для пользователя.
  1. Нажмите кнопку **Добавить**.

- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы создать пользователя в кластере, выполните команду:
  
  ```
  {{ yc-mdb-my }} user create <имя пользователя> \
    --cluster-name=<имя кластера> \
    --password=<пароль пользователя> \
    --permissions=<список баз, к которым пользователь должен иметь доступ>
  ```

  {% include [user-name-and-passwords-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).  

- {{ TF }}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](./cluster-create.md).

  1. Добавьте ресурс `yandex_mdb_mysql_user`:

      ```hcl
      resource "yandex_mdb_mysql_user" "<имя пользователя>" {
        cluster_id = "<идентификатор кластера>"
        name       = "<имя пользователя>"
        password   = "<пароль>"
        permission {
          database_name = "<имя БД, к которой пользователь должен иметь доступ>"
          roles         = [<список привилегий пользователя по отношению к БД>]
        }
        ...
      }
      ```

      {% include [user-name-and-passwords-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-link }}/mdb_mysql_user).

- API

  Воспользуйтесь методом API [create](../api-ref/User/create.md) и передайте в запросе:

  * Идентификатор кластера, в котором вы хотите создать пользователя, в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя пользователя в параметре `userSpec.name`.
  * Пароль пользователя в параметре `userSpec.password`.

      {% include [username-and-password-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

  * Имена баз данных, к которым пользователь должен иметь доступ, в необходимом количестве параметров `userSpec.permissions.databaseName`.
  * [Привилегии пользователя](../concepts/user-rights.md#db-privileges) для каждой из выбранных баз данных в одном или нескольких параметрах `userSpec.permissions.roles`.

{% endlist %}

## Изменить пароль {#updateuser}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mmy-name }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image-users](../../_assets/mdb/user.svg) **Пользователи**.
  1. Нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите пункт **Изменить пароль**.
  1. Задайте новый пароль и нажмите кнопку **Изменить**.

  {% include [passwords-limits](../../_includes/mdb/mmy/note-info-password-limits.md) %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить пароль пользователя, выполните команду:

  ```
  {{ yc-mdb-my }} user update <имя пользователя> \
    --cluster-name=<имя кластера> \
    --password=<новый пароль>
  ```

  {% include [passwords-limits](../../_includes/mdb/mmy/note-info-password-limits.md) %}

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

- {{ TF }}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](./cluster-create.md).

  1. Найдите ресурс `yandex_mdb_mysql_user` нужного пользователя.

  1. Измените значение поля `password`:

      ```hcl
      resource "yandex_mdb_mysql_user" "<имя пользователя>" {
        cluster_id = "<идентификатор кластера>"
        name       = "<имя пользователя>"
        password   = "<новый пароль>"
        ...
      }
      ```

     {% include [passwords-limits](../../_includes/mdb/mmy/note-info-password-limits.md) %}

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-link }}/mdb_mysql_user).

- API

  Воспользуйтесь методом API [update](../api-ref/User/update.md) и передайте в запросе:

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

{% list tabs %}

- Консоль управления
  
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mmy-name }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image-users](../../_assets/mdb/user.svg) **Пользователи**.
  1. Нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите пункт **Настроить**.
  1. Задайте [настройки {{ MY }}](../concepts/settings-list.md#dbms-user-settings) для пользователя.
  1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы задать [настройки {{ MY }}](../concepts/settings-list.md#dbms-user-settings) для пользователя, выполните команду:

  ```
  {{ yc-mdb-my }} user update <имя пользователя> \
    --cluster-name=<имя кластера> \
    --global-permissions=<список административных привилегий через запятую> \
    --authentication-plugin=<плагин аутентификации> \
    --max-questions-per-hour=<максимальное количество запросов в час> \
    --max-updates-per-hour=<максимальное количество запросов UPDATE в час> \
    --max-connections-per-hour=<максимальное количество соединений в час> \
    --max-user-connections=<максимальное количество одновременных соединений>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

- {{ TF }}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](./cluster-create.md).

  1. Найдите ресурс `yandex_mdb_mysql_user` нужного пользователя.

  1. Чтобы задать ограничения по количеству соединений и запросов, добавьте блок `connection_limits` к его описанию:

      ```hcl
      resource "yandex_mdb_mysql_user" "<имя пользователя>" {
        ...
        connection_limits {
          max_questions_per_hour   = <максимальное количество запросов в час>
          max_updates_per_hour     = <максимальное количество запросов UPDATE час>
          max_connections_per_hour = <максимальное количество соединений в час>
          max_user_connections     = <максимальное количество одновременных единений>
          ...
        }
      }
      ```

  1. Чтобы настроить плагин аутентификации пользователя, добавьте блок `authentication_plugin` к его описанию:

      ```hcl
      resource "yandex_mdb_mysql_user" "<имя пользователя>" {
        ...
        authentication_plugin = "<плагин аутентификации>"
      }
      ```

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-link }}/mdb_mysql_user).

- API

  Воспользуйтесь методом API [update](../api-ref/User/update.md) и передайте в запросе:
  
  * Идентификатор кластера, в котором находится пользователь, в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя пользователя в параметре `userName`. Чтобы узнать имя пользователя, [получите список пользователей в кластере](#list-users).
  * Новые значения настроек пользователя.
  * Список полей конфигурации пользователя, которые необходимо изменить, в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Удалить пользователя {#removeuser}

{% list tabs %}

- Консоль управления
  
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mmy-name }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image-users](../../_assets/mdb/user.svg) **Пользователи**.
  1. Нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите пункт **Удалить**.

- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы удалить пользователя, выполните команду:
  
  ```
  {{ yc-mdb-my }} user delete <имя пользователя> --cluster-name=<имя кластера>
  ```
  
  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

- {{ TF }}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

  1. Удалите ресурс `yandex_mdb_mysql_user` с описанием нужного пользователя.

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-link }}/mdb_mysql_user).

- API

  Воспользуйтесь методом API [delete](../api-ref/User/delete.md) и передайте в запросе:
  * Идентификатор кластера, в котором находится пользователь, в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя пользователя в параметре `userName`. Чтобы узнать имя пользователя, [получите список пользователей в кластере](#list-users).

{% endlist %}

{% include [user-ro](../../_includes/mdb/mmy-user-examples.md) %}
