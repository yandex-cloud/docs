---
title: Управление пользователями кластера {{ CH }} в {{ mch-full-name }}
description: Из статьи вы узнаете, как управлять пользователями кластера {{ mch-name }}.
---

# Управление пользователями {{ CH }}

{{ mch-name }} позволяет управлять пользователями и их индивидуальными настройками двумя способами:

* С помощью стандартных интерфейсов {{ yandex-cloud }} (консоль управления, CLI, {{ TF }}, [API](../../glossary/rest-api.md)). Способ подходит, если вы хотите добавлять, изменять и удалять пользователей и их индивидуальные настройки, используя возможности сервиса {{ mch-full-name }}.
* С помощью SQL-запросов к кластеру. Способ подходит, если вы хотите использовать уже существующее у вас решение для создания и управления пользователями или если вы используете [RBAC](https://ru.wikipedia.org/wiki/Управление_доступом_на_основе_ролей).

{% note warning %}

В кластере {{ mch-name }} можно одновременно использовать только один способ управления пользователями — с помощью стандартных интерфейсов или SQL-запросов.

{% endnote %}

{% note info %}

При создании кластера {{ CH }} автоматически создаются [служебные пользователи](../concepts/service-users.md) для администрирования и мониторинга работы сервиса.

{% endnote %}

## Управление пользователями через SQL {#sql-user-management}


Чтобы включить управление, выберите опцию **{{ ui-key.yacloud.mdb.forms.database_field_sql-user-management }}** при [создании](cluster-create.md) или [изменении настроек](update.md#SQL-management) кластера.

{% note warning %}

Включенную настройку управления пользователями через SQL невозможно выключить.

{% endnote %}

В кластере с включенным управлением пользователями через SQL:

* Управление пользователями через стандартные интерфейсы {{ yandex-cloud }} (консоль управления, CLI, API, {{ TF }}) недоступно.
* Существующие пользователи и настройки пользователей, созданные с помощью стандартных интерфейсов {{ yandex-cloud }}, будут сохранены.
* Управление пользователями осуществляется с помощью учетной записи `admin`. Пароль для нее задается при выборе опции **{{ ui-key.yacloud.mdb.forms.database_field_sql-user-management }}**.

Подробнее об управлении пользователями через SQL см. в [документации {{ CH }}]({{ ch.docs }}/operations/access-rights).

## Получить список пользователей {#list-users}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_users }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список пользователей кластера, выполните команду:

  ```bash
  {{ yc-mdb-ch }} user list
     --cluster-name=<имя_кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [User.List](../api-ref/User/list.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/users'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/list.md#responses).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [UserService.List](../api-ref/grpc/User/list.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/user_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.UserService.List
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/list.md#yandex.cloud.mdb.clickhouse.v1.ListUsersResponse).

- SQL {#sql}

  1. [Подключитесь](connect/clients.md) к кластеру, используя [учетную запись `admin`](#sql-user-management).
  1. Получите список пользователей:

      ```sql
      SHOW USERS;
      ```

{% endlist %}

## Создать пользователя {#adduser}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_users }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.action_add-user }}**.
  1. Введите имя пользователя базы данных и пароль.

      {% include [user-name-and-password-limits](../../_includes/mdb/mch/note-info-user-name-and-pass-limits.md) %}

  1. Выберите одну или несколько баз данных, к которым должен иметь доступ пользователь:
     1. Нажмите на значок ![image](../../_assets/console-icons/plus.svg) и выберите базу данных из выпадающего списка.
     1. Повторите предыдущий шаг, пока не будут выбраны все требуемые базы данных.
     1. Чтобы удалить базу, добавленную по ошибке, нажмите на значок ![image](../../_assets/console-icons/xmark.svg) справа от имени базы.
  1. Задайте [дополнительные настройки](../concepts/settings-list.md) для пользователя:
     1. Настройте [квоты](../concepts/settings-list.md#quota-settings) в разделе **{{ ui-key.yacloud.mdb.cluster.users.button_advanced-settings }} → Quotas**:
        1. Чтобы добавить квоту, нажмите на значок ![image](../../_assets/console-icons/plus.svg). Вы можете добавить несколько квот, которые будут действовать одновременно.
        1. Чтобы удалить квоту, нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) справа от имени квоты и выберите пункт **{{ ui-key.yacloud.component.mdb.settings.label_delete }}**.
        1. Чтобы изменить квоту, задайте требуемые значения настроек для нее.
     1. Настройте [{{ CH }}](../concepts/settings-list.md#user-level-settings) в разделе **{{ ui-key.yacloud.mdb.cluster.users.button_advanced-settings }} → Settings**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.popup-button_add }}**.

  См. также: [пример создания пользователя с правами «только чтение»](#example-create-readonly-user).

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать пользователя в кластере, выполните команду:

  ```bash
  {{ yc-mdb-ch }} user create <имя_пользователя> \
     --cluster-name=<имя_кластера> \
     --password=<пароль_пользователя> \
     --permissions=<список_БД> \
     --quota=<список_настроек_одной_квоты_для_пользователя> \
     --settings=<список_настроек_{{ CH }}_для_пользователя>
  ```

  Где `--permissions` — список БД, к которым пользователь должен иметь доступ.

  {% include [user-name-and-password-limits](../../_includes/mdb/mch/note-info-user-name-and-pass-limits.md) %}

  Подробнее о [квотах](../concepts/settings-list.md#quota-settings) и [настройках на уровне запроса](../concepts/settings-list.md#user-level-settings) читайте в разделе [{#T}](../concepts/settings-list.md).

  Чтобы задать несколько квот, перечислите их, используя требуемое количество параметров `--quota` в команде:

  ```bash
  {{ yc-mdb-ch }} user create <имя_пользователя> \
     ...
     --quota="<настройки_квоты_0>" \
     --quota="<настройки_квоты_1>" \
     ...
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  См. также: [пример создания пользователя с правами «только чтение»](#example-create-readonly-user).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Добавьте к описанию кластера {{ mch-name }} блок `user`:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
          ...
          user {
            name     = "<имя_пользователя>"
            password = "<пароль>"
            ...
          }
        }
        ```

        {% include [user-name-and-password-limits](../../_includes/mdb/mch/note-info-user-name-and-pass-limits.md) %}

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [User.Create](../api-ref/User/create.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        1. Создайте файл `body.json` и добавьте в него следующее содержимое:

            ```json
            {
              "userSpec": {
                "name": "<имя_пользователя>",
                "password": "<пароль_пользователя>",
                "permissions": [
                  {
                    "databaseName": "<имя_БД>"
                  }
                ],
                "settings": {<настройки_{{ CH }}>},
                "quotas": [
                  {
                    "intervalDuration": "<интервал_для_квоты>",
                    "queries": "<суммарное_количество_запросов>",
                    "errors": "<количество_запросов_с_ошибкой>",
                    "resultRows": "<количество_строк_результата>",
                    "readRows": "<количество_исходных_строк>",
                    "executionTime": "<суммарное_время_выполнения>"
                  },
                  { <аналогичный_набор_настроек_для_квоты_2> },
                  { ... },
                  { <аналогичный_набор_настроек_для_квоты_N> }
                ]
              },
              { <аналогичный_набор_настроек_для_создаваемого_пользователя_2> },
              { ... },
              { <аналогичный_набор_настроек_для_создаваемого_пользователя_N> }
            }
            ```

            Где `userSpec` — массив, содержащий настройки создаваемых пользователей. Один элемент массива содержит настройки для одного пользователя и имеет следующую структуру:

            {% include [rest-user-specs](../../_includes/mdb/mch/api/rest-user-specs.md) %}

            * `settings` — список [настроек {{ CH }}](../concepts/settings-list.md#user-level-settings) для пользователя.

                Настройки задаются в виде пар `ключ: значение`, разделенных запятыми.

            * `quotas` — массив, содержащий [настройки квот](../concepts/settings-list.md#quota-settings). Один элемент массива содержит настройки для одной квоты.

        1. Выполните запрос:

            ```bash
            curl \
              --request POST \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/users' \
              --data '@body.json'
            ```

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/create.md#responses).

    См. также: [пример создания пользователя с правами «только чтение»](#example-create-readonly-user).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [UserService.Create](../api-ref/grpc/User/create.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        1. Создайте файл `body.json` и добавьте в него следующее содержимое:

            ```json
            {
              "cluster_id": "<идентификатор_кластера>",
              "user_spec": {
                "name": "<имя_пользователя>",
                "password": "<пароль_пользователя>",
                "permissions": [
                  {
                    "database_name": "<имя_БД>"
                  }
                ],
                "settings": {<настройки_{{ CH }}>},
                "quotas": [
                  {
                    "interval_duration": "<интервал_для_квоты>",
                    "queries": "<суммарное_количество_запросов>",
                    "errors": "<количество_запросов_с_ошибкой>",
                    "result_rows": "<количество_строк_результата>",
                    "read_rows": "<количество_исходных_строк>",
                    "execution_time": "<суммарное_время_выполнения>"
                  },
                  { <аналогичный_набор_настроек_для_квоты_2> },
                  { ... },
                  { <аналогичный_набор_настроек_для_квоты_N> }
                ]
              },
              { <аналогичный_набор_настроек_для_создаваемого_пользователя_2> },
              { ... },
              { <аналогичный_набор_настроек_для_создаваемого_пользователя_N> }
            }
            ```

            Где `user_spec` — массив, содержащий настройки создаваемых пользователей. Один элемент массива содержит настройки для одного пользователя и имеет следующую структуру:

            * `name` — имя пользователя. Оно может содержать латинские буквы, цифры, дефис и подчеркивание, но должно начинаться с буквы или подчеркивания.
            * `password` — пароль пользователя. Длина пароля от 8 до 128 символов.
            * `permissions` — список БД, к которым пользователь должен иметь доступ.

                Список организован в виде массива параметров `database_name`. Один параметр содержит имя отдельной БД.

            * `settings` — список [настроек {{ CH }}](../concepts/settings-list.md#user-level-settings) для пользователя.

                Настройки задаются в виде пар `ключ: значение`, разделенных запятыми.

            * `quotas` — массив, содержащий [настройки квот](../concepts/settings-list.md#quota-settings). Один элемент массива содержит настройки для одной квоты.

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

        1. Выполните запрос:

            ```bash
            grpcurl \
              -format json \
              -import-path ~/cloudapi/ \
              -import-path ~/cloudapi/third_party/googleapis/ \
              -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/user_service.proto \
              -rpc-header "Authorization: Bearer $IAM_TOKEN" \
              -d @ \
              {{ api-host-mdb }}:{{ port-https }} \
              yandex.cloud.mdb.clickhouse.v1.UserService.Create \
              < body.json
            ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation).

    См. также: [пример создания пользователя с правами «только чтение»](#example-create-readonly-user).

- SQL {#sql}

  1. [Подключитесь](connect/clients.md) к кластеру, используя [учетную запись `admin`](#sql-user-management).
  1. Создайте пользователя:

      ```sql
      CREATE USER <имя_пользователя> IDENTIFIED WITH sha256_password BY '<пароль_пользователя>';
      ```

      {% include [sql-user-name-and-password-limits](../../_includes/mdb/mch/note-sql-info-user-name-and-pass-limits.md) %}

  Подробнее о создании пользователей см. в [документации {{ CH }}]({{ ch.docs }}/sql-reference/statements/create/user/).

{% endlist %}

## Изменить пароль {#updateuser}

Рекомендуется использовать интерфейсы {{ yandex-cloud }}, перечисленные ниже. Не используйте SQL для смены пароля, иначе после [технического обслуживания](../concepts/maintenance.md) пароль может измениться на прежний.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_users }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.cluster.users.button_action-password }}**.
  1. Задайте новый пароль и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.popup-password_button_change }}**.

  {% include [password-limits](../../_includes/mdb/mch/note-info-password-limits.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить пароль пользователя, выполните команду:

  ```bash
  {{ yc-mdb-ch }} user update <имя_пользователя> \
     --cluster-name=<имя_кластера> \
     --password=<новый_пароль>
  ```

  {% include [password-limits](../../_includes/mdb/mch/note-info-password-limits.md) %}

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Найдите в описании кластера {{ mch-name }} блок `user` для нужного пользователя.

    1. Измените значение поля `password`:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
          ...
          user {
            name     = "<имя_пользователя>"
            password = "<новый_пароль>"
            ...
          }
        }
        ```

        {% include [password-limits](../../_includes/mdb/mch/note-info-password-limits.md) %}

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [User.Update](../api-ref/User/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>' \
            --data '{
                      "updateMask": "password",
                      "password": "<новый_пароль>"
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            В данном случае указан только один параметр: `password`.

        * `password` — новый пароль пользователя.

            Длина пароля от 8 до 128 символов.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters). Имя пользователя можно запросить со [списком пользователей в кластере](#list-users).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/update.md#responses).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [UserService.Update](../api-ref/grpc/User/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/user_service.proto \
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
            yandex.cloud.mdb.clickhouse.v1.UserService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            В данном случае указан только один параметр: `password`.

        * `password` — новый пароль пользователя.

            Длина пароля от 8 до 128 символов.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters). Имя пользователя можно запросить со [списком пользователей в кластере](#list-users).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить пароль пользователя admin {#admin-password-change}

Рекомендуется использовать интерфейсы {{ yandex-cloud }}, перечисленные ниже. Не используйте SQL для смены пароля, иначе после [технического обслуживания](../concepts/maintenance.md) пароль может измениться на прежний.

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить пароль пользователя `admin`, выполните команду:

    ```bash
    {{ yc-mdb-ch }} cluster update <имя_или_идентификатор_кластера> \
      --admin-password <новый_пароль_пользователя_admin>
    ```

    {% include [password-limits](../../_includes/mdb/mch/note-info-password-limits.md) %}

    Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    {% note tip %}

    * Для повышения безопасности вместо `--admin-password` используйте параметр `--read-admin-password`: новый пароль нужно будет ввести с клавиатуры, и он не сохранится в истории команд.
    * Чтобы сгенерировать пароль автоматически, используйте параметр `--generate-admin-password`. Ответ на команду будет содержать новый пароль.

    {% endnote %}

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените значение поля `admin_password`:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
          ...
          admin_password = "<пароль_пользователя_admin>"
          ...
        }
        ```

        {% include [password-limits](../../_includes/mdb/mch/note-info-password-limits.md) %}

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mch }}).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "configSpec.adminPassword",
                      "configSpec": {
                        "adminPassword": "<новый_пароль>"
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            В данном случае указан только один параметр: `configSpec.adminPassword`.

        * `configSpec.adminPassword` — новый пароль пользователя.

            Длина пароля от 8 до 128 символов.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#responses).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [
                      "config_spec.admin_password"
                    ]
                  },
                  "config_spec": {
                    "admin_password": "<новый_пароль>"
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            В данном случае указан только один параметр: `config_spec.admin_password`.

        * `config_spec.admin_password` — новый пароль пользователя.

            Длина пароля от 8 до 128 символов.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить настройки пользователя {#update-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_users }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
  1. Настройте права пользователя на доступ к определенным базам данных:
     1. Чтобы предоставить доступ к требуемым базам данных:
        1. Нажмите на значок ![image](../../_assets/console-icons/plus.svg) и выберите базу данных из выпадающего списка.
        1. Повторите предыдущий шаг, пока не будут выбраны все требуемые базы данных.
     1. Чтобы удалить базу, нажмите на значок ![image](../../_assets/console-icons/xmark.svg) справа от имени базы.
  1. Настройте [квоты](../concepts/settings-list.md#quota-settings) для пользователя в разделе **{{ ui-key.yacloud.mdb.cluster.users.button_advanced-settings }} → Quotas**:
     1. Чтобы добавить квоту, нажмите на значок ![image](../../_assets/console-icons/plus.svg). Вы можете добавить несколько квот, которые будут действовать одновременно.
     1. Чтобы удалить квоту, нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) справа от имени квоты и выберите пункт **{{ ui-key.yacloud.component.mdb.settings.label_delete }}**.
     1. Чтобы изменить квоту, задайте требуемые значения настроек для нее.
  1. Измените [настройки {{ CH }}](../concepts/settings-list.md#dbms-user-settings) для пользователя в разделе **{{ ui-key.yacloud.mdb.cluster.users.button_advanced-settings }} → Settings**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.popup-button_save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Из интерфейса командной строки можно изменить настройки пользователя:
  1. Чтобы настроить права пользователя на доступ к определенным базам данных, выполните команду, перечислив список имен баз данных с помощью параметра `--permissions`:

     ```bash
     {{ yc-mdb-ch }} user update <имя_пользователя> \
        --cluster-name=<имя_кластера> \
        --permissions=<список_БД>
     ```

     Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

     Эта команда предоставляет пользователю доступ к базам данных, указанным в списке.

     Чтобы отозвать доступ к определенной базе, исключите ее имя из списка и передайте команде обновленный список.

  1. Чтобы изменить [настройки квот](../concepts/settings-list.md#quota-settings) для пользователя, выполните команду, перечислив список всех квот, с помощью параметров `--quota` (один параметр на каждую квоту):

     ```bash
     {{ yc-mdb-ch }} user update <имя_пользователя> \
        --cluster-name=<имя_кластера> \
        --quota=<настройки_квоты_0_(без_изменений)> \
        --quota=<настройки_квоты_1_(без_изменений)> \
        --quota=<настройки_квоты_2_(с_изменениями)> \
        --quota=<настройки_квоты_3_(без_изменений)> \
        --quota=<настройки_квоты_4_(с_изменениями)> \
        --quota=<настройки_квоты_5_(новая_квота)>
       ...
     ```

     Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

     Эта команда перезаписывает все существующие настройки квот пользователя новыми настройками, набор которых был передан команде.
     Перед выполнением команды убедитесь, что вы включили в этот набор как настройки новых и измененных квот, так и настройки существующих квот, которые не изменялись.

     Чтобы удалить одну или несколько квот пользователя, исключите настройки этих квот из набора и передайте команде обновленный набор параметров `--quota`.

     При задании интервала для квоты допустимо использовать запись с указанием единиц измерения: часов (`h`), минут (`m`), секунд (`s`) и миллисекунд (`ms`). Пример такой записи: `3h20m10s7000ms` (итоговое значение представляется по-прежнему в миллисекундах: `12017000`). Значение интервала должно быть кратно 1000 миллисекунд (значение вида `1s500ms` является некорректным).

  1. Чтобы изменить [настройки {{ CH }}](../concepts/settings-list.md#dbms-user-settings) для пользователя, выполните команду, перечислив измененные настройки с помощью параметра `--settings`:

     ```bash
     {{ yc-mdb-ch }} user update <имя_пользователя> \
        --cluster-name=<имя_кластера> \
        --settings=<список_настроек_{{ CH }}>
     ```

     Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

     Команда изменит только те настройки, которые явно указаны в параметре `--settings`. Например, команда с параметром `--settings="readonly=1"` изменит только настройку `readonly` и не сбросит значения остальных. Этим изменение настроек {{ CH }} отличается от изменения настроек квот.

     С помощью этой команды невозможно удалить сделанную настройку, допустимо только явно присвоить ей значение по умолчанию (оно указано для [каждой настройки](#clickhouse-settings)).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Чтобы настроить права пользователя на доступ к определенным базам данных, добавьте необходимое количество блоков `permission` к описанию пользователя кластера — по одному на каждую базу:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
          ...
          user {
            name     = "<имя_пользователя>"
            password = "<пароль>"
            permission {
              database_name = "<база_данных_1>"
            }
            ...
            permission {
              database_name = "<база_данных_N>"
            }
          }
        }
        ```

        В поле `database_name` укажите имя базы данных, к которой нужно предоставить доступ.

    1. Чтобы изменить [настройки квот](../concepts/settings-list.md#quota-settings) для пользователя, добавьте необходимое количество блоков `quota` к его описанию.

        При описании квот обязательным является только поле `interval_duration`.

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
          ...
          user {
            name     = "<имя_пользователя>"
            password = "<пароль>"
            ...
            quota {
              interval_duration = <длительность_интервала_в_миллисекундах>
              ...
            }
          }
        }
        ```

    1. Чтобы изменить [настройки {{ CH }}](../concepts/settings-list.md#dbms-user-settings) для пользователя, добавьте блок `settings` к его описанию.

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
          ...
          user {
            name     = "<имя_пользователя>"
            password = "<пароль>"
            ...
            settings {
              <настройки_СУБД_для_отдельного_пользователя>
            }
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [User.Update](../api-ref/User/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>' \
            --data '{
                      "updateMask": "<перечень_изменяемых_настроек>",
                      "permissions": [ <обновленный_список_БД> ],
                      "settings": { <настройки_{{ CH }}> },
                      "quotas": [ <обновленный_список_настроек_квот> ]
                    }'
        ```

        Где `updateMask` — перечень изменяемых параметров в одну строку через запятую.

        Укажите нужные параметры, чтобы изменить отдельные категории настроек:

        * Чтобы изменить список БД, к которым пользователь должен иметь доступ, передайте в параметре `permissions` обновленный список БД.

            Список организован в виде массива параметров `databaseName`. Один параметр содержит имя отдельной БД.

            {% note warning %}

            Существующий в кластере список БД будет полностью перезаписан списком, переданным в параметре `permissions`.

            Перед выполнением запроса убедитесь, что вы включили в этот список все нужные БД, в том числе существующие.

            {% endnote %}

        * Чтобы изменить [настройки {{ CH }}](../concepts/settings-list.md#user-level-settings) для пользователя, передайте в параметре `settings` нужные настройки с новыми значениями.

        * Чтобы изменить [настройки квот](../concepts/settings-list.md#quota-settings), передайте в параметре `quotas` обновленный список с настройками квот.

            Список организован в виде массива. Один элемент массива содержит настройки для одной квоты.

            {% note warning %}

            Существующий в кластере список настроек квот будет полностью перезаписан списком, переданным в параметре `quotas`.

            Перед выполнением запроса убедитесь, что вы включили в этот список все нужные настройки квот, в том числе существующие.

            {% endnote %}

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters). Имя пользователя можно запросить со [списком пользователей в кластере](#list-users).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/update.md#responses).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [UserService.Update](../api-ref/grpc/User/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/user_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "user_name": "<имя_пользователя>",
                  "update_mask": {
                    "paths": [
                      <перечень_изменяемых_настроек>
                    ]
                  },
                  "permissions": [ <обновленный_список_БД> ],
                  "settings": { <настройки_{{ CH }}> },
                  "quotas": [ <обновленный_список_настроек_квот> ]
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.UserService.Update
        ```

        Где `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

        Укажите нужные параметры, чтобы изменить отдельные категории настроек:

        * Чтобы изменить список БД, к которым пользователь должен иметь доступ, передайте в параметре `permissions` обновленный список БД.

            Список организован в виде массива параметров `database_name`. Один параметр содержит имя отдельной БД.

            {% note warning %}

            Существующий в кластере список БД будет полностью перезаписан списком, переданным в параметре `permissions`.

            Перед выполнением запроса убедитесь, что вы включили в этот список все нужные БД, в том числе существующие.

            {% endnote %}

        * Чтобы изменить [настройки {{ CH }}](../concepts/settings-list.md#user-level-settings) для пользователя, передайте в параметре `settings` нужные настройки с новыми значениями.

        * Чтобы изменить [настройки квот](../concepts/settings-list.md#quota-settings), передайте в параметре `quotas` обновленный список с настройками квот.

            Список организован в виде массива. Один элемент массива содержит настройки для одной квоты.

            {% note warning %}

            Существующий в кластере список настроек квот будет полностью перезаписан списком, переданным в параметре `quotas`.

            Перед выполнением запроса убедитесь, что вы включили в этот список все нужные настройки квот, в том числе существующие.

            {% endnote %}

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters). Имя пользователя можно запросить со [списком пользователей в кластере](#list-users).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation).

- SQL {#sql}

  1. [Подключитесь](connect/clients.md) к кластеру, используя [учетную запись `admin`](#sql-user-management).
  1. Чтобы изменить набор привилегий и ролей пользователя, используйте запросы [GRANT]({{ ch.docs }}/sql-reference/statements/grant/) и [REVOKE]({{ ch.docs }}/sql-reference/statements/revoke/). Например, выдайте пользователю права на чтение всех объектов в определенной базе данных:

      ```sql
      GRANT SELECT ON <имя_базы_данных>.* TO <имя_пользователя>;
      ```

  1. Чтобы изменить [настройки квот](../concepts/settings-list.md#quota-settings) для пользователя, используйте запросы [CREATE QUOTA]({{ ch.docs }}/sql-reference/statements/create/quota/#create-quota-statement), [ALTER QUOTA]({{ ch.docs }}/sql-reference/statements/alter/quota/#alter-quota-statement) и [DROP QUOTA]({{ ch.docs }}/sql-reference/statements/drop/#drop-quota-statement). Например, ограничьте суммарное количество запросов пользователя за период 15 месяцев:

      ```sql
      CREATE QUOTA <название_квоты> FOR INTERVAL 15 MONTH MAX QUERIES 100 TO <имя_пользователя>;
      ```

  1. Чтобы изменить учетную запись пользователя, используйте запрос [ALTER USER]({{ ch.docs }}/sql-reference/statements/alter/user/). Например для изменения [настроек {{ CH }}](../concepts/settings-list.md#dbms-user-settings) выполните следующую команду, перечислив настройки подлежащие изменению:

      ```sql
      ALTER USER <имя_пользователя> SETTINGS <список_настроек_{{ CH }}>;
      ```

{% endlist %}

## Удалить пользователя {#removeuser}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_users }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить пользователя, выполните команду:

  ```bash
  {{ yc-mdb-ch }} user delete <имя_пользователя> \
     --cluster-name=<имя_кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Удалите из описания кластера {{ mch-name }} блок `user` с описанием нужного пользователя.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [User.Delete](../api-ref/User/delete.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request DELETE \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters). Имя пользователя можно запросить со [списком пользователей в кластере](#list-users).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/delete.md#responses).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [UserService.Delete](../api-ref/grpc/User/delete.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/user_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "user_name": "<имя_пользователя>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.UserService.Delete
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters). Имя пользователя можно запросить со [списком пользователей в кластере](#list-users).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/delete.md#yandex.cloud.operation.Operation).

- SQL {#sql}

  1. [Подключитесь](connect/clients.md) к кластеру, используя [учетную запись `admin`](#sql-user-management).
  1. Удалите пользователя:

      ```sql
      DROP USER <имя_пользователя>;
      ```

  Подробнее об удалении объектов см. в [документации {{ CH }}]({{ ch.docs }}/sql-reference/statements/drop/).

{% endlist %}

## Примеры {#examples}

### Создание пользователя с настройкой «только чтение» {#example-create-readonly-user}

Допустим, нужно добавить в существующий кластер с именем `mych` и идентификатором `{{ cluster-id }}` нового пользователя `ro-user` с паролем `Passw0rd`, причем:
* пользователь должен иметь доступ к базе данных `db1` кластера;
* доступ должен осуществляться в режиме «только чтение» (readonly), без возможности изменения настроек.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на кластер с именем `mych` и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_users }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.action_add-user }}**.
  1. Введите имя пользователя базы данных `ro-user` и пароль `Passw0rd`.
  1. Нажмите на значок ![image](../../_assets/console-icons/plus.svg) и выберите базу данных `db1` из выпадающего списка.
  1. Выберите **{{ ui-key.yacloud.mdb.cluster.users.button_advanced-settings }} → Settings → Readonly**.
  1. В поле **Readonly** укажите значение `1`.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.popup-button_add }}**.

- CLI {#cli}

  Запустите следующую команду:

  ```bash
  {{ yc-mdb-ch }} user create "ro-user" \
     --cluster-name="mych" \
     --password="Passw0rd" \
     --permissions="db1" \
     --settings="readonly=1"
  ```

    После создания пользователя проверьте, что он действительно работает в режиме «только чтение»:
    1. [Подключитесь](connect/clients.md) к кластеру `mych`, используя созданного пользователя `ro-user`.
    1. Попытайтесь изменить какую-нибудь настройку, например, попытайтесь отключить режим «только чтение»:

       ```
       SET readonly=0
       ```

       В результате выполнения команды должно отобразиться сообщение о невозможности изменения настройки в режиме «только чтение»:

       ```
       DB::Exception: Cannot modify 'readonly' setting in readonly mode.
       ```

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Добавьте к описанию кластера блок `user`.

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "mych" {
          name = "mych"

          database {
            name = "db1"
          }

          user {
            name     = "ro-user"
            password = "Passw0rd"
            permission {
              database_name = "db1"
            }
            settings {
              readonly = 1
            }
          }
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

    1. Выполните запрос c помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{{ cluster-id }}/users' \
            --data '{
                      "userSpec": {
                        "name": "ro-user",
                        "password": "Passw0rd",
                        "permissions": [
                          {
                            "databaseName": "db1"
                          }
                        ],
                        "settings": {
                          "readonly": "1"
                        }
                      }
                    }'
        ```

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Выполните запрос с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/user_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "{{ cluster-id }}",
                  "user_spec": {
                    "name": "ro-user",
                    "password": "Passw0rd",
                    "permissions": [
                      {
                        "database_name": "db1"
                      }
                    ],
                    "settings": {
                      "readonly": "1"
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.UserService.Create
        ```

- SQL {#sql}

  1. [Подключитесь](connect/clients.md) к кластеру `mych`, используя [учетную запись `admin`](#sql-user-management).
  1. Создайте пользователя:

      ```sql
      CREATE USER ro-user IDENTIFIED WITH sha256_password BY 'Passw0rd';
      ```

  1. Выдайте пользователю права на чтение всех объектов базы данных `db1`:

      ```sql
      GRANT SELECT ON db1.* TO ro-user;
      ```

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
