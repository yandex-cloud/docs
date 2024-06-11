# Управление базами данных в {{ mpg-name }}

Вы можете добавлять, переименовывать и удалять базы данных, а также просматривать информацию о них.

{% include [db-sql](../../_includes/mdb/mdb-db-sql-limits.md) %}

## Получить список баз данных в кластере {#list-db}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_databases }}**.


- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список баз данных в кластере, выполните команду:

  ```bash
  {{ yc-mdb-pg }} database list --cluster-name=<имя_кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).


- API {#api}

  Чтобы получить список баз данных в кластере, воспользуйтесь методом REST API [list](../api-ref/Database/list.md) для ресурса [Database](../api-ref/Database/index.md) или вызовом gRPC API [DatabaseService/List](../api-ref/grpc/database_service.md#List) и передайте в запросе идентификатор кластера в параметре `clusterId`.

  Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

## Создать базу данных {#add-db}

{% include [1000 DBs limit](../../_includes/mdb/1000dbnote.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера.
  1. Если владельцем новой базы данных должен стать еще не существующий пользователь, [создайте его](cluster-users.md#adduser).
  1. Выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_databases }}**.
  1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.mdb.cluster.databases.action_add-database }}**.
  1. Укажите параметры базы данных:

      * Имя.

        {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

      * Владелец.

      * Защита от удаления.

        Возможные значения:
          - **Как у кластера**.
          - **Включена**.
          - **Выключена**.
          
      * (Опционально) Шаблон — имя одной из существующих баз, с которой нужно будет скопировать схему данных. На время создания новой базы все подключения к базе-шаблону будут закрыты.

          Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/sql-createdatabase.html).

      * Локали сортировки и набора символов.

          {% include [postgresql-locale](../../_includes/mdb/mpg-locale-settings.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup-add-db_button_add }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать базу данных в кластере:

  1. Посмотрите описание команды CLI для создания БД:

     ```bash
     {{ yc-mdb-pg }} database create --help
     ```

  1. Запросите список пользователей кластера, чтобы выбрать владельца новой базы данных:

     ```bash
     {{ yc-mdb-pg }} user list --cluster-name=<имя_кластера>
     ```

     Если нужного пользователя в списке нет, [создайте его](cluster-users.md#adduser).

  1. Выполните команду создания БД. При необходимости укажите нужные локали сортировки и набора символов (по умолчанию задаются `LC_COLLATE=C` и `LC_CTYPE=C`) и шаблон:

     ```bash
     {{ yc-mdb-pg }} database create <имя_БД> \
        --cluster-name=<имя_кластера> \
        --owner=<имя_пользователя-владельца> \
        --lc-collate=<локаль_сортировки> \
        --lc-type=<локаль_набора_символов> \
        --template-db=<имя_БД-шаблона>
     ```

     {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

     Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

     {{ mpg-short-name }} запустит операцию создания базы данных.

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации базы данных кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_postgresql_database).

    1. Добавьте ресурс `yandex_mdb_postgresql_database`. При необходимости укажите нужные локали сортировки и набора символов (по умолчанию задаются `LC_COLLATE=C` и `LC_CTYPE=C`) и шаблон:
  
        ```hcl
        resource "yandex_mdb_postgresql_database" "<имя_БД>" {
          cluster_id  = "<идентификатор_кластера>"
          name        = "<имя_БД>"
          owner       = "<имя_пользователя-владельца>"
          lc_collate  = "<локаль_сортировки>"
          lc_type     = "<локаль_набора_символов>"
          template_db = "<имя_БД-шаблона>"
          deletion_protection = <защита_от_удаления>
        }
        ```

        Где:
          * `owner` — имя пользователя-владельца, который должен быть задан в ресурсе `yandex_mdb_postgresql_user`.
          * `deletion_protection` — защита БД от удаления: `true`, `false` или `unspecified` (наследует значение от кластера). Значение по умолчанию — `unspecified`.

        {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

    1. Проверьте корректность настроек.
  
        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
    1. Подтвердите изменение ресурсов.
  
        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  {% note warning %}

  После создания БД не меняйте ее владельца в параметре `owner` — это приведет к пересозданию БД и потере данных.

  {% endnote %}

- API {#api}

  Чтобы создать базу данных в кластере, воспользуйтесь методом REST API [create](../api-ref/Database/create.md) для ресурса [Database](../api-ref/Database/index.md) или вызовом gRPC API [DatabaseService/Create](../api-ref/grpc/database_service.md#Create) и передайте в запросе:

  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Настройки новой базы в параметре `databaseSpec`.
  * Тип защиты от удаления в параметре `deletionProtection`. Возможные значения — `true`, `false`. Значение по умолчанию — `unspecified` (наследует значение от кластера).

     {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

{% endlist %}

## Переименовать базу данных {#rename-db}

{% list tabs group=instructions %}

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

      Полный список доступных для изменения полей конфигурации базы данных кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_postgresql_database).

  1. Найдите ресурс `yandex_mdb_postgresql_database` нужной базы данных.
  1. Измените значение поля `name`:

      ```hcl
      resource "yandex_mdb_postgresql_database" "<имя_базы данных>" {
        ...
        name     = "<новое_имя_базы_данных>"
        ...
      }
      ```

      {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

    Чтобы переименовать базу данных в кластере, воспользуйтесь методом REST API [update](../api-ref/Database/update.md) для ресурса [Database](../api-ref/Database/index.md) или вызовом gRPC API [DatabaseService/Update](../api-ref/grpc/database_service.md#Update) и передайте в запросе:

    * Идентификатор кластера, в котором находится база данных, в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Имя базы данных в параметре `databaseName`. Чтобы узнать имя базы, [получите список баз данных в кластере](#list-db).
    * Новое имя базы данных в параметре `newDatabaseName`.

        {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

    * Список полей конфигурации базы данных, подлежащих изменению (в данном случае — `newDatabaseName`), в параметре `updateMask`.

    {% include [Сброс настроек изменяемого объекта](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Настроить защиту от удаления {#update-db-deletion-protection}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_databases }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужной БД и выберите пункт **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
  1. Выберите нужное значение в поле **{{ ui-key.yacloud.mdb.forms.label_deletion-protection }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- {{ TF }} {#tf}
  
  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры. 

  1. Найдите ресурс `yandex_mdb_postgresql_database` нужной БД.
  
  1. Добавьте параметр `deletion_protection`. Доступные значения: `true`, `false` или `unspecified` (наследует значение от кластера). Значение по умолчанию — `unspecified`.

        ```hcl
        resource "yandex_mdb_postgresql_database" "<имя_базы_данных>" {
          ...
          deletion_protection = <защита_от_удаления>
          ...
        }
        ```
  
  1. Проверьте корректность настроек.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

  Чтобы настроить защиту от удаления БД, воспользуйтесь методом REST API [update](../api-ref/Database/update.md) для ресурса [Database](../api-ref/Database/index.md) или вызовом gRPC API [DatabaseService/Update](../api-ref/grpc/database_service.md#Update) и передайте в запросе:
  
  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя БД в параметре `databaseName`. Чтобы узнать имя БД, [получите список БД в кластере](#list-db).
  * Параметр `updateMask` со значением `deletionProtection`.
  * Новое значение параметра `deletionProtection`. Возможные значения — `true`, `false`. Значение по умолчанию — `unspecified` (наследует значение от кластера).

{% endlist %}

## Удалить базу данных {#remove-db}

БД может быть защищена от удаления. Чтобы удалить такую БД, сперва [снимите защиту](#update-db-deletion-protection).

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы удалить базу данных:
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_databases }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужной БД, выберите пункт **{{ ui-key.yacloud.mdb.cluster.databases.button_action-remove }}** и подтвердите удаление.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить базу данных, выполните команду:

  ```bash
  {{ yc-mdb-pg }} database delete <имя_БД> \
     --cluster-name <имя_кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

- {{ TF }} {#tf}
  
  Чтобы удалить базу данных:
  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  
     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

     Полный список доступных для изменения полей конфигурации базы данных кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_postgresql_database).

  1. Удалите ресурс `yandex_mdb_postgresql_database` с именем удаляемой базы данных.
  
  1. Проверьте корректность настроек.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

  Чтобы удалить базу данных, воспользуйтесь методом REST API [delete](../api-ref/Database/delete.md) для ресурса [Database](../api-ref/Database/index.md) или вызовом gRPC API [DatabaseService/Delete](../api-ref/grpc/database_service.md#Delete) и передайте в запросе:
  
  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя удаляемой базы данных в параметре `databaseName`. Чтобы узнать имя базы данных, [получите список баз данных в кластере](#list-db).

{% endlist %}

{% note warning %}

Прежде чем создать новую базу с тем же именем, дождитесь завершения операции удаления, иначе будет восстановлена удаляемая база. Статус операции можно получить вместе со [списком операций в кластере](cluster-list.md#list-operations).

{% endnote %}
