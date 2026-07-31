# Управление базами данных в {{ mmg-name }}

Вы можете добавлять и удалять базы данных, а также просматривать информацию о них.

## Получить список баз данных в кластере {#list-db}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/storedoc) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.mongodb.cluster.switch_databases }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список баз данных в кластере, выполните команду:

  ```bash
  {{ yc-mdb-mg }} database list
     --cluster-name <имя_кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Database.List](../api-ref/Database/list.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<идентификатор_кластера>/databases'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Database/list.md#yandex.cloud.mdb.mongodb.v1.ListDatabasesResponse).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [DatabaseService.List](../api-ref/grpc/Database/list.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/database_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.mongodb.v1.DatabaseService.List
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Database/list.md#yandex.cloud.mdb.mongodb.v1.ListDatabasesResponse).

{% endlist %}


## Получить информацию о базе данных {#get-db}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить информацию о конкретной базе данных:

    1. Посмотрите описание команды CLI для получения информации о базе данных:

        ```bash
        {{ yc-mdb-mg }} database get --help
        ```

    1. Получите информацию о базе данных, выполнив команду:

        ```bash
        {{ yc-mdb-mg }} database get <имя_БД> \
          --cluster-id=<идентификатор_кластера>
        ```

        Имя базы данных можно получить со [списком баз данных](#list-db) в кластере, а идентификатор кластера — со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Database.Get](../api-ref/Database/get.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<идентификатор_кластера>/databases/<имя_БД>'
        ```

        Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге, а имя базы данных — со [списком баз данных](#list-db) в кластере.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Database/get.md#yandex.cloud.mdb.mongodb.v1.Database).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Воспользуйтесь вызовом [DatabaseService.Get](../api-ref/grpc/Database/get.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/database_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "database_name": "<имя_БД>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mongodb.v1.DatabaseService.Get
        ```

        Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге, а имя базы данных — со [списком баз данных](#list-db) в кластере.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Database/get.md#yandex.cloud.mdb.mongodb.v1.Database).

{% endlist %}


## Создать базу данных {#add-db}

{% include [1000 DBs limit](../../_includes/mdb/1000dbnote.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/storedoc) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера.
  1. Выберите вкладку **{{ ui-key.yacloud.mongodb.cluster.switch_databases }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.databases.action_add-database }}**.
  1. Введите имя для базы данных и нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup-add-db_button_add }}**.

      {% include [db-name-limits](../../_includes/mdb/mmg/note-info-db-name-limits.md) %}

  1. [Назначьте роли](cluster-users.md#updateuser), разрешающие доступ к созданной базе данных, нужным пользователям кластера.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать базу данных в кластере, выполните команду:

  ```bash
  {{ yc-mdb-mg }} database create <имя_БД> \
    --cluster-name <имя_кластера> \
    --deletion-protection=<защитить_БД_от_удаления>
  ```

  Где:

  * `<имя_БД>` — имя базы данных.
    
    {% include [db-name-limits](../../_includes/mdb/mmg/note-info-db-name-limits.md) %}

  * `--cluster-name` — имя кластера, которое можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  * `--deletion-protection` — защита базы данных от непреднамеренного удаления: `true` или `false`. По умолчанию значение не задано, и для базы данных используется значение соответствующей настройки кластера. Если защита включена (`true`), удалить базу данных нельзя.

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        Инструкция по созданию такого файла приведена в разделе [Создание кластера](cluster-create.md).

    1. Добавьте ресурс `yandex_mdb_mongodb_database`:

        ```hcl
        resource "yandex_mdb_mongodb_database" "<имя_БД>" {
          cluster_id          = "<идентификатор_кластера>"
          name                = "<имя_БД>"
          deletion_protection = <защитить_БД_от_удаления>
        }
        ```

        Где:

        * `cluster_id` — идентификатор кластера, который можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
        * `name` — имя базы данных.
          
          {% include [db-name-limits](../../_includes/mdb/mmg/note-info-db-name-limits.md) %}

        * `--deletion-protection` — защита базы данных от непреднамеренного удаления: `true` или `false`. По умолчанию значение не задано, и для базы данных используется значение соответствующей настройки кластера. Если защита включена (`true`), удалить базу данных нельзя.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее читайте в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_mongodb_database).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Database.Create](../api-ref/Database/create.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<идентификатор_кластера>/databases' \
       --data '{
                 "databaseSpec": {
                   "name": "<имя_БД>",
                   "deletionProtection": <защитить_БД_от_удаления>
                 }
               }'
     ```

     Где:
     
     * `<идентификатор_кластера>` — идентификатор кластера, который можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
     * `databaseSpec.name` — имя базы данных.
       
       {% include [db-name-limits](../../_includes/mdb/mmg/note-info-db-name-limits.md) %}
     
     * `databaseSpec.deletionProtection` — защита базы данных от непреднамеренного удаления: `true` или `false`. По умолчанию значение не задано, и для базы данных используется значение соответствующей настройки кластера. Если защита включена (`true`), удалить базу данных нельзя.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Database/create.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [DatabaseService.Create](../api-ref/grpc/Database/create.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/database_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "database_spec": {
               "name": "<имя_БД>",
               "deletion_protection": <защитить_БД_от_удаления>
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.mongodb.v1.DatabaseService.Create
     ```

     Где:
     
     * `cluster_id` — идентификатор кластера, который можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
     * `database_spec.name` — имя базы данных.
       
       {% include [db-name-limits](../../_includes/mdb/mmg/note-info-db-name-limits.md) %}
     
     * `database_spec.deletion_protection` — защита базы данных от непреднамеренного удаления: `true` или `false`. По умолчанию значение не задано, и для базы данных используется значение соответствующей настройки кластера. Если защита включена (`true`), удалить базу данных нельзя.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Database/create.md#yandex.cloud.operation.Operation).

{% endlist %}

После создания базы данных [выдайте разрешение](cluster-users.md#updateuser) на доступ к ней нужным пользователям кластера.

## Изменить настройки базы данных {#update-db}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить настройки базы данных, выполните команду:

  ```bash
  {{ yc-mdb-mg }} database update <имя_БД> \
     --cluster-name <имя_кластера> \
     --deletion-protection=<защитить_БД_от_удаления>
  ```

  Где:

  * `<имя_БД>` — имя базы данных, которое можно запросить со [списком баз данных в кластере](#list-db).
  * `--cluster-name` — имя кластера, которое можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  * `--deletion-protection` — защита базы данных от непреднамеренного удаления: `true` или `false`. По умолчанию значение не задано, и для базы данных используется значение соответствующей настройки кластера. Если защита включена (`true`), удалить базу данных нельзя.

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      Инструкция по созданию такого файла приведена в разделе [Создание кластера](cluster-create.md).

  1. Найдите ресурс `yandex_mdb_mongodb_database`.
  1. Чтобы включить или отключить защиту пользователя от непреднамеренного удаления, измените значение поля `deletion_protection`:

      ```hcl
      resource "yandex_mdb_mongodb_database" "<имя_БД>" {
        ...
        deletion_protection = <защитить_БД_от_удаления>
        ...
      }
      ```

      Где `deletion_protection` — защита базы данных от непреднамеренного удаления: `true` или `false`. По умолчанию значение не задано, и для базы данных используется значение соответствующей настройки кластера. Если защита включена (`true`), удалить базу данных нельзя.

  1. Проверьте корректность настроек.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее читайте в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_mongodb_database).

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
        --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<идентификатор_кластера>/databases/<имя_БД>' \
        --data '{
                  "updateMask": "deletionProtection",
                  "deletionProtection": <защитить_БД_от_удаления>
                }'
      ```

      Где:

      * `<идентификатор_кластера>` — имя кластера, которое можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
      * `<имя_БД>` — имя базы данных, которое можно запросить со [списком баз данных в кластере](#list-db).
      * `updateMask` — перечень изменяемых параметров в одну строку через запятую.
      * `deletionProtection` — защита базы данных от непреднамеренного удаления: `true` или `false`. По умолчанию значение не задано, и для базы данных используется значение соответствующей настройки кластера. Если защита включена (`true`), удалить базу данных нельзя.

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
        -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/database_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>",
              "database_name": "<имя_БД>",
              "update_mask": {
                "paths": [
                  "deletion_protection"
                ]
              },
              "deletion_protection": <защитить_БД_от_удаления>
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.mongodb.v1.DatabaseService.Update
      ```

     Где:

     * `cluster_id` — идентификатор кластера, который можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
     * `database_name` — имя базы данных, которое можно запросить со [списком баз данных в кластере](#list-db).
     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.
     * `deletion_protection` — защита базы данных от непреднамеренного удаления: `true` или `false`. По умолчанию значение не задано, и для базы данных используется значение соответствующей настройки кластера. Если защита включена (`true`), удалить базу данных нельзя.
     
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Database/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Удалить базу данных {#remove-db}

{% note info %}

Перед удалением базы данных [отключите ее защиту от удаления](#update-db).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/storedoc) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mongodb.cluster.switch_databases }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужной БД и выберите пункт **{{ ui-key.yacloud.mdb.cluster.databases.button_action-remove }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить базу данных, выполните команду:

  ```bash
  {{ yc-mdb-mg }} database delete <имя_БД>
     --cluster-name <имя_кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        Инструкция по созданию такого файла приведена в разделе [Создание кластера](cluster-create.md).

    1. Удалите ресурс `yandex_mdb_mongodb_database` с именем удаляемой базы данных.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее читайте в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_mongodb_database).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Database.Delete](../api-ref/Database/delete.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<идентификатор_кластера>/databases/<имя_БД>'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя БД — со [списком БД в кластере](#list-db).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Database/delete.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [DatabaseService.Delete](../api-ref/grpc/Database/delete.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/database_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "database_name": "<имя_БД>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.mongodb.v1.DatabaseService.Delete
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя БД — со [списком БД в кластере](#list-db).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Database/delete.md#yandex.cloud.operation.Operation).

{% endlist %}

{% note warning %}

Прежде чем создать новую базу с тем же именем, дождитесь завершения операции удаления, иначе будет восстановлена удаляемая база. Статус операции можно получить вместе со [списком операций в кластере](cluster-list.md#list-operations).

{% endnote %}
