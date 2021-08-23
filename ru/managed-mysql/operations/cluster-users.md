# Управление пользователями {{ MY }}

Вы можете добавлять и удалять пользователей, а также управлять их настройками.

{% include [mmy-no-sql-user-rights](../../_includes/mdb/mmy-no-sql-user-rights.md) %}

## Получить список пользователей {#list-users}

{% list tabs %}

- Консоль управления
  
  1. Перейдите на страницу каталога и выберите сервис **{{ mmy-name }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **Пользователи**.

- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы получить список пользователей кластера, выполните команду:
  
  ```
  $ {{ yc-mdb-my }} user list
       --cluster-name=<имя кластера>
  ```
  
  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

{% endlist %}

## Добавить пользователя {#adduser}

{% list tabs %}

- Консоль управления
  
  1. Перейдите на страницу каталога и выберите сервис **{{ mmy-name }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Пользователи**.
  1. Нажмите кнопку **Добавить**.
  1. Введите имя пользователя базы данных и пароль (от 8 до 128 символов).
  1. Выберите одну или несколько баз данных, к которым должен иметь доступ пользователь:
      1. Нажмите кнопку **Добавить базу данных**.
      1. Выберите нужную базу данных из выпадающего списка.
      1. Повторите два предыдущих шага, пока не будут выбраны все требуемые базы данных.
      1. Чтобы удалить базу, добавленную по ошибке, наведите курсор на строку с именем базы и нажмите значок ![image](../../_assets/cross.svg) в конце строки.
  1. Настройте [роли пользователя](../concepts/user-rights.md#db-roles) для каждой из выбранных баз данных:
      1. Нажмите значок ![image](../../_assets/plus-sign.svg) в столбце **Роли**.
      1. Выберите роль, которую вы хотите добавить пользователю из выпадающего списка.
      1. Повторите два предыдущих шага, пока не будут добавлены все требуемые роли.
  1. Чтобы отозвать роль, выданную по ошибке, нажмите значок ![image](../../_assets/cross.svg) справа от ее имени.
  1. При необходимости задайте [настройки {{ MY }}](../concepts/settings-list.md#dbms-user-settings) для пользователя.
  1. Нажмите кнопку **Добавить**.

- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы создать пользователя в кластере, выполните команду:
  
  ```
  $ {{ yc-mdb-my }} user create <имя пользователя>
       --cluster-name=<имя кластера>
       --password=<пароль пользователя>
       --permissions=<список баз, к которым пользователь должен иметь доступ>
  ```
  
  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).  

- Terraform

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](./cluster-create.md).

  1. Добавьте к описанию кластера {{ mmy-name }} блок `user`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя кластера>" {
        ...
        user {
          name     = "<имя пользователя>"
          password = "<пароль>"
          permission {
            database_name = "<имя БД, к которой пользователь должен иметь доступ>"
            roles         = [<список ролей пользователя по отношению к БД>]
            ...
          }
          ...
        }
      }
      ```

      {% include [user-name-and-passwords-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmy }}).

{% endlist %}

## Изменить пароль {#updateuser}

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mmy-name }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Пользователи**.
  1. Нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите пункт **Изменить пароль**.
  1. Задайте новый пароль и нажмите кнопку **Изменить**.

  {% include [passwords-limits](../../_includes/mdb/mmy/note-info-password-limits.md) %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить пароль пользователя, выполните команду:

  ```
  $ {{ yc-mdb-my }} user update <имя пользователя>
       --cluster-name=<имя кластера>
       --password=<новый пароль>
  ```

  {% include [passwords-limits](../../_includes/mdb/mmy/note-info-password-limits.md) %}

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

- Terraform

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](./cluster-create.md).

  1. Найдите в описании кластера {{ mmy-name }} блок `user` для нужного пользователя.

  1. Измените значение поля `password`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя кластера>" {
        ...
        user {
          name     = "<имя пользователя>"
          password = "<новый пароль>"
          ...
        }
      }
      ```

     {% include [passwords-limits](../../_includes/mdb/mmy/note-info-password-limits.md) %}

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmy }}).

{% endlist %}


## Изменить настройки пользователя {#update-settings}

{% note tip %}

Чтобы изменить права пользователя на доступ к базам данных, воспользуйтесь [инструкцией](grant.md#grant-role).

{% endnote %}

{% list tabs %}

- Консоль управления
  
  1. Перейдите на страницу каталога и выберите сервис **{{ mmy-name }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Пользователи**.
  1. Нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите пункт **Настроить**.
  1. Задайте [настройки {{ MY }}](../concepts/settings-list.md#dbms-user-settings) для пользователя.
  1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы задать [настройки {{ MY }}](../concepts/settings-list.md#dbms-user-settings) для пользователя, выполните команду:

  ```
  $ {{ yc-mdb-my }} user update <имя пользователя>
       --cluster-name=<имя кластера>
       --global-permissions=<список глобальных привилегий через запятую>
       --authentication-plugin=<плагин аутентификации>
       --max-questions-per-hour=<максимальное количество запросов в час>
       --max-updates-per-hour=<максимальное количество запросов UPDATE в час>
       --max-connections-per-hour=<максимальное количество соединений в час>
       --max-user-connections=<максимальное количество одновременных соединений>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

- Terraform

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](./cluster-create.md).

  1. Найдите в описании кластера {{ mmy-name }} блок `user` для нужного пользователя.

  1. Чтобы задать ограничения по количеству соединений и запросов, добавьте блок `connection_limits` к его описанию:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя кластера>" {
        ...
        user {
          ...
          connection_limits {
            max_questions_per_hour   = <максимальное количество запросов в час>
            max_updates_per_hour     = <максимальное количество запросов UPDATE в час>
            max_connections_per_hour = <максимальное количество соединений в час>
            max_user_connections     = <максимальное количество одновременных соединений>
            ...
          }
        }
      }
      ```

  1. Чтобы настроить плагин аутентификации пользователя, добавьте блок `authentication_plugin` к его описанию:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя кластера>" {
        ...
        user {
          ...
          authentication_plugin = "<плагин аутентификации>"
        }
      }
      ```

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmy }}).

{% endlist %}

## Удалить пользователя {#removeuser}

{% list tabs %}

- Консоль управления
  
  1. Перейдите на страницу каталога и выберите сервис **{{ mmy-name }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Пользователи**.
  1. Нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите пункт **Удалить**.

- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы удалить пользователя, выполните команду:
  
  ```
  $ {{ yc-mdb-my }} user delete <имя пользователя>
       --cluster-name=<имя кластера>
  ```
  
  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

- Terraform

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

  1. Удалите из описания кластера {{ mmy-name  }} блок `user` с описанием нужного пользователя.

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmy }}).

{% endlist %}

{% include [user-ro](../../_includes/mdb/mmy-user-examples.md) %}
