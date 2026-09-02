# Управление базами данных в {{ mmy-name }}

Вы можете добавлять и удалять базы данных, просматривать информацию о них, а также управлять некоторыми настройками баз данных с помощью интерфейсов {{ mmy-name }}.

{% include [db-sql](../../_includes/mdb/mmy-db-sql-limits.md) %}

## Получить список баз данных в кластере {#list-db}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-mysql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.mysql.cluster.switch_databases }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список баз данных в кластере, выполните команду:

  ```bash
  {{ yc-mdb-my }} database list \
     --cluster-name=<имя_кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Database.list](../api-ref/Database/list.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>/databases'
      ```

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Database/list.md#yandex.cloud.mdb.mysql.v1.ListDatabasesResponse).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [DatabaseService/List](../api-ref/grpc/Database/list.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/database_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>"
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.mysql.v1.DatabaseService.List
      ```

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Database/list.md#yandex.cloud.mdb.mysql.v1.ListDatabasesResponse).

- SQL {#sql}

  Чтобы получить список всех пользовательских баз данных в кластере {{ MY }}:

  1. [Выдайте права](grant.md) `mdb_admin` пользователю, от имени которого вы будете подключаться к базе данных.

  1. [Подключитесь к базе данных](connect/clients.md).

  1. Получите список баз данных и их пользователей:

      ```sql
      SELECT db, user FROM mysql.v_db;
      ```

      Пример результата:

      ```sql
      +-----+-------+
      | Db  | User  |
      +-----+-------+
      | db1 | user1 |
      | db2 | user1 |
      | db2 | user2 |
      | db3 | user3 |
      +-----+-------+
      ```

      Чтобы вывести более подробную информацию о базах данных, используйте запрос:

      ```sql
      SELECT * FROM mysql.v_db;
      ```

{% endlist %}

## Создать базу данных {#add-db}

{% include [note-db-limit](../../_includes/mdb/mmy/note-db-limit.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-mysql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Нажмите на имя нужного кластера.
  1. Если владельцем новой базы данных должен стать еще не существующий пользователь, [создайте его](cluster-users.md#adduser).
  1. Выберите вкладку **{{ ui-key.yacloud.mysql.cluster.switch_databases }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.databases.action_add-database }}**.
  1. Укажите параметры базы данных:

     * Имя.

       {% include [db-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}

     * Защита от непреднамеренного удаления. Возможные значения:
        - **Как у кластера**.
        - **Включена**.
        - **Выключена**.

        {% include [deletion-protection-db](../../_includes/mdb/deletion-protection-db.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup-add-db_button_add }}**.
  1. [Выдайте привилегии](grant.md#grant-privilege) на доступ к созданной базе данных нужным пользователям кластера.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать базу данных в кластере:

  1. Посмотрите описание команды CLI для создания БД:

     ```bash
      {{ yc-mdb-my }} database create --help
     ```

  1. Выполните команду создания БД:

      ```bash
      {{ yc-mdb-my }} database create <имя_БД> \
        --cluster-name=<имя_кластера> \
        --deletion-protection=<защита_от_удаления>
      ```

      {% include [db-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}

      Возможные значения защиты БД от непреднамеренного удаления: `enabled`, `disabled` или `inherited` (наследует значение от кластера). Значение по умолчанию — `disabled`.

      {% include [deletion-protection-db](../../_includes/mdb/deletion-protection-db.md) %}

      Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

      {{ mmy-short-name }} запустит операцию создания базы данных.

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      Как создать такой файл описано в разделе [Создание кластера](cluster-create.md).

  1. Добавьте ресурс `yandex_mdb_mysql_database_v2`:

      ```hcl
      resource "yandex_mdb_mysql_database_v2" "<имя_БД>" {
        cluster_id               = "<идентификатор_кластера>"
        name                     = "<имя_БД>"
        deletion_protection_mode = "<защита_от_удаления>"
      }
      ```

      {% include [db-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}

      Возможные значения защиты базы данных от непреднамеренного удаления:

      * `DELETION_PROTECTION_MODE_ENABLED` — включена;
      * `DELETION_PROTECTION_MODE_DISABLED` (по умолчанию) — выключена;
      * `DELETION_PROTECTION_MODE_INHERITED` — наследует значение от кластера.

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее о параметрах ресурса `yandex_mdb_mysql_database_v2` смотрите в [документации провайдера]({{ tf-provider-resources-link }}/mdb_mysql_database_v2).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Database.create](../api-ref/Database/create.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>/databases' \
          --data '{
                    "databaseSpec": {
                      "name": "<имя_БД>",
                      "deletionProtectionMode": "<защита_от_удаления>"
                    }
                  }'
      ```

      {% include [database-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}

      Возможные значения защиты базы данных от непреднамеренного удаления:

      * `DELETION_PROTECTION_MODE_ENABLED` — включена;
      * `DELETION_PROTECTION_MODE_DISABLED` (по умолчанию) — выключена;
      * `DELETION_PROTECTION_MODE_INHERITED` — наследует значение от кластера.

      {% include [deletion-protection-db](../../_includes/mdb/deletion-protection-db.md) %}

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Database/create.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [DatabaseService/Create](../api-ref/grpc/Database/create.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/database_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "database_spec": {
                  "name": "<имя_БД>",
                  "deletion_protection_mode": "<защита_от_удаления>"
                }
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.DatabaseService.Create
      ```

      {% include [database-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}

      Возможные значения защиты базы данных от непреднамеренного удаления:

      * `DELETION_PROTECTION_MODE_ENABLED` — включена;
      * `DELETION_PROTECTION_MODE_DISABLED` (по умолчанию) — выключена;
      * `DELETION_PROTECTION_MODE_INHERITED` — наследует значение от кластера.

      {% include [deletion-protection-db](../../_includes/mdb/deletion-protection-db.md) %}

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Database/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Настроить защиту от удаления {#update-db-deletion-protection}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-mysql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_databases }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужной БД и выберите пункт **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
  1. Выберите нужное значение в поле **{{ ui-key.yacloud.mdb.forms.label_deletion-protection }}**.

     {% include [deletion-protection-db](../../_includes/mdb/deletion-protection-db.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы настроить защиту от удаления базы данных, выполните команду:

  ```bash
  {{ yc-mdb-my }} database update <имя_БД> \
    --cluster-name=<имя_кластера> \
    --deletion-protection=<защита_от_удаления>
  ```

  Возможные значения защиты БД от непреднамеренного удаления: `enabled`, `disabled` или `inherited` (наследует значение от кластера). Значение по умолчанию — `disabled`.

  {% include [deletion-protection-db](../../_includes/mdb/deletion-protection-db.md) %}

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

  1. Найдите ресурс `yandex_mdb_mysql_database_v2` нужной БД.

  1. Добавьте параметр `deletion_protection_mode`. Возможные значения:

      * `DELETION_PROTECTION_MODE_ENABLED` — защита от удаления включена;
      * `DELETION_PROTECTION_MODE_DISABLED` (по умолчанию) — защита от удаления выключена;
      * `DELETION_PROTECTION_MODE_INHERITED` — наследует значение от кластера.

      ```hcl
      resource "yandex_mdb_mysql_database_v2" "<имя_базы_данных>" {
        ...
        deletion_protection_mode = "<защита_от_удаления>"
        ...
      }
      ```

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее о параметрах ресурса `yandex_mdb_mysql_database_v2` смотрите в [документации провайдера]({{ tf-provider-resources-link }}/mdb_mysql_database_v2).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Database.Update](../api-ref/Database/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>/databases/<имя_БД>' \
       --data '{
                 "updateMask": "deletionProtectionMode",
                 "deletionProtectionMode": "<защита_от_удаления>"
               }'
     ```

     Где:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

       В данном случае передается только один параметр.

     * `deletionProtectionMode` — защита базы данных от непреднамеренного удаления:
        * `DELETION_PROTECTION_MODE_ENABLED` — включена;
        * `DELETION_PROTECTION_MODE_DISABLED` (по умолчанию) — выключена;
        * `DELETION_PROTECTION_MODE_INHERITED` — наследует значение от кластера.

        {% include [deletion-protection-db](../../_includes/mdb/deletion-protection-db.md) %}

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя БД — со [списком БД в кластере](#list-db).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Database/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [DatabaseService.Update](../api-ref/grpc/Database/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/database_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "database_name": "<имя_БД>",
             "update_mask": {
               "paths": [
                 "deletion_protection_mode"
               ]
             },
             "deletion_protection_mode": "<защита_от_удаления>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.mysql.v1.DatabaseService.Update
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

       В данном случае передается только один параметр.

     * `deletion_protection_mode` — защита базы данных от непреднамеренного удаления:
        * `DELETION_PROTECTION_MODE_ENABLED` — включена;
        * `DELETION_PROTECTION_MODE_DISABLED` (по умолчанию) — выключена;
        * `DELETION_PROTECTION_MODE_INHERITED` — наследует значение от кластера.

        {% include [deletion-protection-db](../../_includes/mdb/deletion-protection-db.md) %}

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя БД — со [списком БД в кластере](#list-db).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Database/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Установить режим SQL {#sql-mode}

Вы можете задать или изменить значение настройки [sql_mode](../concepts/settings-list.md#setting-sql-mode), которая определяет режим SQL для базы данных. Эта операция вызовет перезапуск хостов кластера.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-mysql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}** нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}**.
  1. В списке настроек найдите параметр **sql_mode**.
  1. Задайте набор режимов SQL с помощью выпадающего списка. Чтобы вернуть настройки по умолчанию, нажмите кнопку **{{ ui-key.yacloud.component.mdb.settings.button_reset }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.component.mdb.settings.popup_settings-submit }}** в диалоговом окне настроек СУБД.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Задайте нужные режимы SQL в значении параметра `--set`, например:

  ```bash
  {{ yc-mdb-my }} cluster update-config \
    --name <имя_кластера> \
    --set '"sql_mode=NO_KEY_OPTIONS,NO_TABLE_OPTIONS"'
  ```

  Обратите внимание на кавычки: значением параметра должна стать вся строка, включая часть `sql_mode=`.

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        Как создать такой файл описано в разделе [Создание кластера](./cluster-create.md).

    1. Задайте нужные режимы SQL в значении параметра `sql_mode` блока `mysql_config`, например:

        ```hcl
        resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
          ...
          mysql_config = {
            sql_mode = "<список_режимов_SQL>"
            ...
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее о параметрах ресурса yandex_mdb_mysql_cluster смотрите в [документации провайдера]({{ tf-provider-resources-link }}/mdb_mysql_cluster#mysql-config).

    {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

      ```bash
      curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>' \
          --data '{
                    "updateMask": "configSpec.mysqlConfig_<версия_{{ MY }}>",
                    "configSpec": {
                      "mysqlConfig_<версия_{{ MY }}>": {
                        "sqlMode": [
                          "<режим_SQL_1>", "<режим_SQL_2>", ..., "<режим_SQL_N>"
                        ]
                      }
                    }
                  }'
      ```

      Где:

      * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

          В данном случае передается только один параметр.

      * `configSpec.mysqlConfig_<версия_{{ MY }}>.sqlMode` — список режимов SQL. Доступные режимы приведены в документации {{ MY }}:

          * [для версии 5.7](https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html#sql-mode-setting);
          * [для версии 8.0](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-setting).

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

      {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "update_mask": {
                  "paths": [
                    "config_spec.mysql_config_<версия_{{ MY }}>"
                  ]
                },
                "config_spec": {
                  "mysql_config_<версия_{{ MY }}>": {
                    "sql_mode": [
                      "<режим_SQL_1>", "<режим_SQL_2>", ..., "<режим_SQL_N>"
                    ]
                  }
                }
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.Update
      ```

      Где:

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

          В данном случае передается только один параметр.

      * `config_spec.mysql_config_<версия_{{ MY }}>.sql_mode` — список режимов SQL. Доступные режимы приведены в документации {{ MY }}:

          * [для версии 5.7](https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html#sql-mode-setting);
          * [для версии 8.0](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-setting).

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить набор символов и правила их сравнения {#charset-collate}

Чтобы установить настройки символов (`CHARACTER SET`, `COLLATE`) для базы данных:

1. [Подключитесь](./connect/index.md) к базе данных с помощью учетной записи ее владельца или пользователя с привилегией `ALTER` для этой базы данных.
1. Выполните запрос [ALTER DATABASE](https://dev.mysql.com/doc/refman/5.7/en/charset-database.html):

   ```sql
   ALTER DATABASE <имя_БД> CHARACTER SET = 'utf8mb4' COLLATE = 'utf8mb4_unicode_ci';
   ```

1. Чтобы настройки изменились не только для самой базы данных, но и для таблиц в ней, сконвертируйте таблицы с теми же настройками:

   ```sql
   ALTER TABLE <имя_БД>.<имя_таблицы> CONVERT TO CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';
   ```

## Удалить базу данных {#remove-db}

{% note info %}

Перед удалением базы данных [отключите ее защиту от удаления](#update-db-deletion-protection).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-mysql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mysql.cluster.switch_databases }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужной БД и выберите пункт **{{ ui-key.yacloud.mdb.cluster.databases.button_action-remove }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить базу данных, выполните команду:

  ```bash
   {{ yc-mdb-my }} database delete <имя_БД> --cluster-name=<имя_кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      Как создать такой файл описано в разделе [Создание кластера](cluster-create.md).

  1. Удалите ресурс `yandex_mdb_mysql_database_v2` с именем удаляемой базы данных.

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее о параметрах ресурса `yandex_mdb_mysql_database_v2` смотрите в [документации провайдера]({{ tf-provider-resources-link }}/mdb_mysql_database_v2).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Database.delete](../api-ref/Database/delete.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request DELETE \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>/databases/<имя_БД>'
      ```

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя БД — со [списком БД в кластере](#list-db).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Database/delete.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [DatabaseService/Delete](../api-ref/grpc/Database/delete.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/database_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "database_name": "<имя_БД>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.DatabaseService.Delete
      ```

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя БД — со [списком БД в кластере](#list-db).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Database/create.md#yandex.cloud.operation.Operation).

{% endlist %}

{% note warning %}

Прежде чем создать новую базу с тем же именем, дождитесь завершения операции удаления, иначе будет восстановлена удаляемая база. Статус операции можно получить вместе со [списком операций в кластере](cluster-list.md#list-operations).

{% endnote %}
