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

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Database.list](../api-ref/Database/list.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>/databases'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Database/list.md#responses).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [DatabaseService/List](../api-ref/grpc/Database/list.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/database_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.DatabaseService.List
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Database/list.mdDatabasesResponse).

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
        --owner=<имя_владельца_БД> \
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
          owner       = "<имя_владельца_БД>"
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

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Database.create](../api-ref/Database/create.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>/databases' \
       --data '{
                 "databaseSpec": {
                   "name": "<имя_БД>",
                   "owner": "<имя_владельца_БД>",
                   "lcCollate": "<локаль_сортировки>",
                   "lcCtype": "<локаль_набора_символов>",
                   "extensions": [
                     {
                       "name": "<имя_расширения>",
                       "version": "<версия_расширения>"
                     }
                   ],
                   "deletionProtection": <защита_от_удаления:_true_или_false>
                 }
               }'
     ```

     Где `databaseSpec` — объект, содержащий настройки новой БД. Имеет следующую структуру:

     * `name` — имя БД.

       {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

     * `owner` — имя владельца БД.
     * `lcCollate` — локаль сортировки. Значение по умолчанию — `C`.
     * `lcCtype` — локаль набора символов. Значение по умолчанию — `C`.
     * `extensions` — массив расширений БД. Один элемент массива содержит настройки для одного расширения и имеет следующую структуру:

       * `extensions.name` — имя расширения;
       * `extensions.version` — версия расширения.

       Указывайте имя и версию в соответствии со [списком поддерживаемых расширений и утилит {{ PG }}](extensions/cluster-extensions.md#postgresql).

     * `deletionProtection` — защита от удаления БД.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Database/create.md#responses).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [DatabaseService/Create](../api-ref/grpc/Database/create.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/database_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "database_spec": {
               "name": "<имя_БД>",
               "owner": "<имя_владельца_БД>",
               "lc_collate": "<локаль_сортировки>",
               "lc_ctype": "<локаль_набора_символов>",
               "extensions": [
                 {
                   "name": "<имя_расширения>",
                   "version": "<версия_расширения>"
                 }
               ],
               "deletion_protection": <защита_от_удаления:_true_или_false>
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.DatabaseService.Create
     ```

     Где `databaseSpec` — объект, содержащий настройки новой БД. Имеет следующую структуру:

     * `name` — имя БД.

       {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

     * `owner` — имя владельца БД.
     * `lc_collate` — локаль сортировки. Значение по умолчанию — `C`.
     * `lc_ctype` — локаль набора символов. Значение по умолчанию — `C`.
     * `extensions` — массив расширений БД. Один элемент массива содержит настройки для одного расширения и имеет следующую структуру:

       * `extensions.name` — имя расширения;
       * `extensions.version` — версия расширения.

       Указывайте имя и версию в соответствии со [списком поддерживаемых расширений и утилит {{ PG }}](extensions/cluster-extensions.md#postgresql).

     * `deletion_protection` — защита от удаления БД.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Database/create.md#yandex.cloud.operation.Operation).

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

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Database.update](../api-ref/Database/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>/databases/<прежнее_имя_БД>' \
       --data '{
                 "updateMask": "newDatabaseName",
                 "newDatabaseName": "<новое_имя_БД>"
               }'
     ```

     Где:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

       В данном случае передается только один параметр.

     * `newDatabaseName` — новое имя БД.

       {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя БД — со [списком БД в кластере](#list-db).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Database/update.md#responses).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [DatabaseService/Update](../api-ref/grpc/Database/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/database_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "database_name": "<прежнее_имя_БД>",
             "update_mask": {
               "paths": [
                 "new_database_name"
               ]
             },
             "new_database_name": "<новое_имя_БД>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.DatabaseService.Update
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

       В данном случае передается только один параметр.

     * `new_database_name` — новое имя БД.

       {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя БД — со [списком БД в кластере](#list-db).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Database/create.md#yandex.cloud.operation.Operation1).

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

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Database.update](../api-ref/Database/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>/databases/<имя_БД>' \
       --data '{
                 "updateMask": "deletionProtection",
                 "deletionProtection": <защита_от_удаления:_true_или_false>
               }'
     ```

     Где:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

       В данном случае передается только один параметр.

     * `deletionProtection` — защита от удаления БД.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя БД — со [списком БД в кластере](#list-db).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Database/update.md#responses).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [DatabaseService/Update](../api-ref/grpc/Database/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/database_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "database_name": "<имя_БД>",
             "update_mask": {
               "paths": [
                 "deletion_protection"
               ]
             },
             "deletion_protection": <защита_от_удаления:_true_или_false>
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.DatabaseService.Update
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

       В данном случае передается только один параметр.

     * `deletion_protection` — защита от удаления БД.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя БД — со [списком БД в кластере](#list-db).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Database/create.md#yandex.cloud.operation.Operation1).

{% endlist %}

{% note warning %}

Защита от удаления действует только на уровне конкретной БД. При удалении кластера будут удалены все БД, в том числе защищенные от удаления.

{% endnote %}

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

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Database.delete](../api-ref/Database/delete.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>/databases/<имя_БД>'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя БД — со [списком БД в кластере](#list-db).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Database/delete.md#responses).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [DatabaseService/Delete](../api-ref/grpc/Database/delete.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/database_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "database_name": "<имя_БД>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.DatabaseService.Delete
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя БД — со [списком БД в кластере](#list-db).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Database/create.md#yandex.cloud.operation.Operation2).

{% endlist %}

{% note warning %}

Прежде чем создать новую базу с тем же именем, дождитесь завершения операции удаления, иначе будет восстановлена удаляемая база. Статус операции можно получить вместе со [списком операций в кластере](cluster-list.md#list-operations).

{% endnote %}
