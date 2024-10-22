---
title: Управление правами пользователей MySQL
description: Вы можете управлять правами пользователей MySQL на уровне отдельной базы данных, изменяя привилегии пользователей. Пользователи могут иметь разные наборы привилегий для разных баз данных. Чтобы узнать подробнее про поддерживаемые привилегии, см. описание привилегий.
---
# Управление правами пользователей

Вы можете управлять правами пользователей на уровне отдельной базы данных, изменяя [привилегии пользователей](../concepts/user-rights.md).

{% include [mmy-no-sql-user-rights](../../_includes/mdb/mmy-no-sql-user-rights.md) %}

## Изменить привилегии пользователя {#grant-privilege}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.

  1. Нажмите на имя нужного кластера и выберите вкладку ![image-users](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mysql.cluster.switch_users }}**.

  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.

  1. При необходимости добавьте пользователю нужные базы данных:

     1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.button_add-database }}**.
     1. Выберите базу данных из выпадающего списка.
     1. Повторите два предыдущих шага, пока не будут выбраны все требуемые базы данных.
     1. Чтобы отозвать доступ к определенной базе, удалите ее из перечня, нажав значок ![image](../../_assets/console-icons/xmark.svg) справа от имени базы данных.

  1. Задайте нужные привилегии пользователя для каждой из баз данных пользователя:

     1. Нажмите значок ![image](../../_assets/console-icons/plus.svg) в столбце **{{ ui-key.yacloud.mdb.dialogs.popup_field_roles }}**.
     1. Выберите привилегию, которую вы хотите добавить пользователю из выпадающего списка.
     1. Повторите два предыдущих шага, пока не будут добавлены все требуемые привилегии.

  1. Чтобы отозвать привилегию, нажмите значок ![image](../../_assets/console-icons/xmark.svg) справа от ее имени.
  1. При необходимости задайте [административные привилегии](../concepts/settings-list.md#setting-administrative-privileges) для пользователя.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  * Добавить привилегии пользователю:

      ```bash
      {{ yc-mdb-my }} user grant-permission <имя_пользователя> \
        --cluster-name <имя_кластера> \
        --database <имя_БД> \
        --permissions <набор_привилегий_через_запятую>
      ```

      Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md), имя базы данных — со [списком баз данных в кластере](databases.md#list-db), имя пользователя — со [списком пользователей в кластере](cluster-users.md#list-users).

  * Отозвать привилегии у пользователя:

      ```bash
      {{ yc-mdb-my }} user revoke-permission <имя_пользователя> \
        --cluster-name <имя_кластера> \
        --database <имя_БД> \
        --permissions <набор_привилегий_через_запятую>
      ```

      Чтобы добавить или отозвать привилегию `ALL_PRIVILEGES`, передайте в качестве названия синоним `ALL`.

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

  1. Найдите ресурс `yandex_mdb_mysql_user` нужного пользователя и измените список его привилегий для требуемой БД в параметре `roles`:

      ```hcl
      resource "yandex_mdb_mysql_user" "<имя_пользователя>" {
        cluster_id = "<идентификатор_кластера>"
        name       = "<имя_пользователя>"
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
                    "updateMask": "permissions",
                    "permissions": [
                      {
                        "databaseName": "<имя_БД>",
                        "roles": [
                          "<привилегия_1>", "<привилегия_2>", ..., "<привилегия_N>"
                        ]
                      }
                    ]
                  }'
      ```

      Где:

      * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

          В данном случае передается только один параметр.

      * `permissions` — настройки разрешений пользователя:

          * `databaseName` — имя базы данных, к которой пользователь получает доступ.
          * `roles` — массив привилегий пользователя. Каждая привилегия представлена в виде отдельной строки в массиве. Список доступных значений см. в разделе [Привилегии пользователей в кластере](../concepts/user-rights.md#db-privileges).

          Для каждой базы данных добавьте отдельный элемент с настройками разрешений в массив `permissions`.

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
                    "permissions"
                  ]
                },
                "permissions": [
                  {
                    "database_name": "<имя_БД>",
                    "roles": [
                      "<привилегия_1>", "<привилегия_2>", ..., "<привилегия_N>"
                    ]
                  }
                ]
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.UserService.Update
      ```

      Где:

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

          В данном случае передается только один параметр.

      * `permissions` — настройки разрешений пользователя:

          * `database_name` — имя базы данных, к которой пользователь получает доступ.
          * `roles` — массив привилегий пользователя. Каждая привилегия представлена в виде отдельной строки в массиве. Список доступных значений см. в разделе [Привилегии пользователей в кластере](../concepts/user-rights.md#db-privileges).

          Для каждой базы данных добавьте отдельный элемент с настройками разрешений в массив `permissions`.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](#list-users).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation).

{% endlist %}

{% include [user-ro](../../_includes/mdb/mmy-user-examples.md) %}
