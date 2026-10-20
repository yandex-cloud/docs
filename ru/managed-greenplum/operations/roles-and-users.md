---
title: Управление ролями и пользователями кластера {{ mgp-full-name }}
description: Из статьи вы узнаете, как управлять пользователями, ролями и их привилегиями в кластере {{ mgp-name }}.
---

# Управление ролями и пользователями

С помощью интерфейсов {{ yandex-cloud }} и команд SQL вы можете добавлять и удалять пользователей и роли, а также изменять их настройки.

SQL предоставляет дополнительные возможности, недоступные в интерфейсах {{ yandex-cloud }}:

* объединять роли в группы и изменять состав групп;
* назначать и отзывать привилегии ролей;
* задавать настройки СУБД на уровне роли.

Подробнее о командах SQL читайте в [документации {{ GP }}]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-sql_commands-sql_ref.html).

Подробнее о пользователях и ролях читайте в разделе [{#T}](../concepts/cluster-users.md).

## Получить список пользователей и ролей {#list}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список пользователей и ролей кластера, выполните команду:

    ```bash
    {{ yc-mdb-gp }} users list --cluster-id <идентификатор_кластера>
    ```

    {% include [cluster-name-as-id](../../_includes/mdb/mgp/cluster-name-as-id.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [User.List](../api-ref/User/list.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<идентификатор_кластера>/users'
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/list.md#yandex.cloud.mdb.greenplum.v1.ListUsersResponse).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [UserService.List](../api-ref/grpc/User/list.md) и выполните запрос [ListUsersRequest](../api-ref/grpc/User/list.md#yandex.cloud.mdb.greenplum.v1.ListUsersRequest), например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/user_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.UserService.List
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/list.md#yandex.cloud.mdb.greenplum.v1.ListUsersResponse).

- SQL {#sql}

    Для выполнения операций с помощью SQL [подключитесь к базе данных](connect/index.md) от имени пользователя с ролью `mdb_admin`.

    Запросы к `pg_roles` возвращают пользователей и остальные роли внутри базы данных.

    Выполните команду:

    ```sql
    SELECT rolname FROM pg_roles;
    ```

    Чтобы посмотреть список ролей с их привилегиями, выполните команду:

    ```sql
    SELECT
        rolname,
        rolsuper,
        rolcreatedb,
        rolcreaterole,
        rolinherit,
        rolcanlogin,
        rolconnlimit,
        rolcreaterextgpfd
    FROM pg_roles;
    ```

    Результат:

    ```text
        rolname     | rolsuper | rolcreatedb | rolcreaterole | rolinherit | rolcanlogin | rolconnlimit | rolcreaterextgpfd
    ----------------+----------+-------------+---------------+------------+-------------+--------------+-------------------
     mdb_admin      | f        | f           | f             | t          | f           |           -1 | f
     gpadmin        | t        | t           | t             | t          | t           |           -1 | t
     monitor        | t        | f           | f             | t          | t           |           -1 | f
     user1          | f        | t           | t             | t          | t           |           -1 | t
    ```

    Где:

    * **t** — наличие привилегии.
    * **f** — отсутствие привилегии.

{% endlist %}

## Создать пользователя или роль {#create}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать пользователя или роль кластера, выполните команду:

    ```bash
    {{ yc-mdb-gp }} users create <имя_пользователя> \
        --cluster-id <идентификатор_кластера> \
        --password <пароль> \
        --login=<разрешение_на_вход> \
        --resource-group <имя_ресурсной_группы> \
        --pool-mode <режим_пула> \
        --pool-size <количество_серверных_соединений> \
        --pool-client-idle-timeout <время_ожидания_клиента> \
        --pool-idle-in-transaction-timeout <время_ожидания_клиента_в_транзакции>
    ```

    Где:

    * `--password` — пароль пользователя.
    * `--login` — разрешение на вход в базу данных: `true` или `false`. Значение по умолчанию — `true`. При значении `false` создается роль без возможности авторизации.
    * `--resource-group` — [ресурсная группа](../concepts/resource-groups.md), к которой относятся запросы пользователя.
    * `--pool-mode` — режим пула соединений Odyssey: `session` или `transaction`.
    * `--pool-size` — количество серверных соединений в пуле Odyssey.
    * `--pool-client-idle-timeout` — время неактивности клиентского соединения в секундах, после которого соединение разрывается.
    * `--pool-idle-in-transaction-timeout` — время неактивности клиентского соединения с открытой транзакцией в секундах, после которого соединение разрывается.

    {% include [user-pooler-settings](../../_includes/mdb/mgp/user-pooler-settings.md) %}

    {% include [cluster-name-as-id](../../_includes/mdb/mgp/cluster-name-as-id.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [User.Create](../api-ref/User/create.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<идентификатор_кластера>/users' \
            --data '{
                      "user": {
                        "name": "<имя_пользователя>",
                        "password": "<пароль>",
                        "login": <разрешение_на_вход>,
                        "resourceGroup": "<имя_ресурсной_группы>",
                        "settings": {
                          "poolMode": "<режим_пула>",
                          "poolSize": "<количество_серверных_соединений>",
                          "poolClientIdleTimeout": "<время_ожидания_клиента>",
                          "poolIdleInTransactionTimeout": "<время_ожидания_клиента_в_транзакции>"
                        }
                      }
                    }'
        ```

        Где:

        * `password` — пароль пользователя.
        * `login` — разрешение на вход в базу данных: `true` или `false`. Значение по умолчанию — `true`. При значении `false` создается роль без возможности авторизации.
        * `resourceGroup` — [ресурсная группа](../concepts/resource-groups.md), к которой относятся запросы пользователя.
        * `settings.poolMode` — режим пула соединений Odyssey: `SESSION` или `TRANSACTION`.
        * `settings.poolSize` — количество серверных соединений в пуле Odyssey.
        * `settings.poolClientIdleTimeout` — время неактивности клиентского соединения в секундах, после которого соединение разрывается.
        * `settings.poolIdleInTransactionTimeout` — время неактивности клиентского соединения с открытой транзакцией в секундах, после которого соединение разрывается.

        {% include [user-pooler-settings](../../_includes/mdb/mgp/user-pooler-settings.md) %}

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/create.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [UserService.Create](../api-ref/grpc/User/create.md) и выполните запрос [CreateUserRequest](../api-ref/grpc/User/create.md#yandex.cloud.mdb.greenplum.v1.CreateUserRequest), например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/user_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "user": {
                      "name": "<имя_пользователя>",
                      "password": "<пароль>",
                      "login": <разрешение_на_вход>,
                      "resource_group": "<имя_ресурсной_группы>",
                      "settings": {
                        "pool_mode": "<режим_пула>",
                        "pool_size": "<количество_серверных_соединений>",
                        "pool_client_idle_timeout": "<время_ожидания_клиента>",
                        "pool_idle_in_transaction_timeout": "<время_ожидания_клиента_в_транзакции>"
                      }
                    }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.UserService.Create
        ```

        Где:

        * `password` — пароль пользователя.
        * `login` — разрешение на вход в базу данных: `true` или `false`. Значение по умолчанию — `true`. При значении `false` создается роль без возможности авторизации.
        * `resource_group` — [ресурсная группа](../concepts/resource-groups.md), к которой относятся запросы пользователя.
        * `settings.pool_mode` — режим пула соединений Odyssey: `SESSION` или `TRANSACTION`.
        * `settings.pool_size` — количество серверных соединений в пуле Odyssey.
        * `settings.pool_client_idle_timeout` — время неактивности клиентского соединения в секундах, после которого соединение разрывается.
        * `settings.pool_idle_in_transaction_timeout` — время неактивности клиентского соединения с открытой транзакцией в секундах, после которого соединение разрывается.

        {% include [user-pooler-settings](../../_includes/mdb/mgp/user-pooler-settings.md) %}

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation).

- SQL {#sql}

    Для выполнения операций с помощью SQL [подключитесь к базе данных](connect/index.md) от имени пользователя с ролью `mdb_admin`.

    Выполните команду:

    ```sql
    CREATE ROLE <имя_роли> <список_атрибутов>;
    ```

    Чтобы создать пользователя, добавьте роли атрибут `LOGIN`.

    Доступные атрибуты читайте в разделе [{#T}](../concepts/cluster-users.md#attributes).

{% endlist %}

## Изменить пароль {#password}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить пароль пользователя, выполните команду:

    ```bash
    {{ yc-mdb-gp }} users update <имя_пользователя> \
        --cluster-id <идентификатор_кластера> \
        --password <новый_пароль>
    ```

    {% include [cluster-name-as-id](../../_includes/mdb/mgp/cluster-name-as-id.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [User.Update](../api-ref/User/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>' \
            --data '{
                      "updateMask": "password",
                      "user": {
                        "name": "<имя_пользователя>",
                        "password": "<новый_пароль>"
                      }
                    }'
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [UserService.Update](../api-ref/grpc/User/update.md) и выполните запрос [UpdateUserRequest](../api-ref/grpc/User/update.md#yandex.cloud.mdb.greenplum.v1.UpdateUserRequest), например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/user_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "update_mask": {
                      "paths": [
                        "password"
                      ]
                    },
                    "user": {
                      "name": "<имя_пользователя>",
                      "password": "<новый_пароль>"
                    }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.UserService.Update
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation).

- SQL {#sql}

    Для выполнения операций с помощью SQL [подключитесь к базе данных](connect/index.md) от имени пользователя с ролью `mdb_admin`.

    Чтобы изменить пароль пользователя, выполните команду:

    ```sql
    ALTER ROLE <имя_пользователя> PASSWORD '<новый_пароль>';
    ```

{% endlist %}

## Изменить настройки пользователя или роли {#attributes}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить настройки пользователя или роли, выполните команду:

    ```bash
    {{ yc-mdb-gp }} users update <имя_пользователя> \
        --cluster-id <идентификатор_кластера> \
        --login=<разрешение_на_вход> \
        --resource-group <имя_ресурсной_группы> \
        --pool-mode <режим_пула> \
        --pool-size <количество_серверных_соединений> \
        --pool-client-idle-timeout <время_ожидания_клиента> \
        --pool-idle-in-transaction-timeout <время_ожидания_клиента_в_транзакции>
    ```

    Укажите только параметры, значения которых нужно изменить.

    Где:

    * `--login` — разрешение на вход в базу данных: `true` или `false`.
    * `--resource-group` — [ресурсная группа](../concepts/resource-groups.md), к которой относятся запросы пользователя.
    * `--pool-mode` — режим пула соединений Odyssey: `session` или `transaction`.
    * `--pool-size` — количество серверных соединений в пуле Odyssey.
    * `--pool-client-idle-timeout` — время неактивности клиентского соединения в секундах, после которого соединение разрывается.
    * `--pool-idle-in-transaction-timeout` — время неактивности клиентского соединения с открытой транзакцией в секундах, после которого соединение разрывается.

    Чтобы сбросить настройку Odyssey и использовать значение уровня кластера, передайте соответствующий параметр без значения.

    {% include [cluster-name-as-id](../../_includes/mdb/mgp/cluster-name-as-id.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [User.Update](../api-ref/User/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>' \
            --data '{
                      "updateMask": "login,resourceGroup,settings.poolMode,settings.poolSize,settings.poolClientIdleTimeout,settings.poolIdleInTransactionTimeout",
                      "user": {
                        "name": "<имя_пользователя>",
                        "login": <разрешение_на_вход>,
                        "resourceGroup": "<имя_ресурсной_группы>",
                        "settings": {
                          "poolMode": "<режим_пула>",
                          "poolSize": "<количество_серверных_соединений>",
                          "poolClientIdleTimeout": "<время_ожидания_клиента>",
                          "poolIdleInTransactionTimeout": "<время_ожидания_клиента_в_транзакции>"
                        }
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых полей в одну строку через запятую.
        * `login` — разрешение на вход в базу данных: `true` или `false`.
        * `resourceGroup` — [ресурсная группа](../concepts/resource-groups.md), к которой относятся запросы пользователя.
        * `settings` — настройки Odyssey на уровне пользователя:

            * `poolMode` — режим пула соединений: `SESSION` или `TRANSACTION`;
            * `poolSize` — количество серверных соединений в пуле;
            * `poolClientIdleTimeout` — время неактивности клиентского соединения в секундах, после которого соединение разрывается;
            * `poolIdleInTransactionTimeout` — время неактивности клиентского соединения с открытой транзакцией в секундах, после которого соединение разрывается.

        Чтобы сбросить настройку Odyssey и использовать значение уровня кластера, укажите соответствующее поле в `updateMask`, но не передавайте его значение в объекте `settings`.

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [UserService.Update](../api-ref/grpc/User/update.md) и выполните запрос [UpdateUserRequest](../api-ref/grpc/User/update.md#yandex.cloud.mdb.greenplum.v1.UpdateUserRequest), например с помощью {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/user_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "update_mask": {
                      "paths": [
                        "login",
                        "resource_group",
                        "settings.pool_mode",
                        "settings.pool_size",
                        "settings.pool_client_idle_timeout",
                        "settings.pool_idle_in_transaction_timeout"
                      ]
                    },
                    "user": {
                      "name": "<имя_пользователя>",
                      "login": <разрешение_на_вход>,
                      "resource_group": "<имя_ресурсной_группы>",
                      "settings": {
                        "pool_mode": "<режим_пула>",
                        "pool_size": "<количество_серверных_соединений>",
                        "pool_client_idle_timeout": "<время_ожидания_клиента>",
                        "pool_idle_in_transaction_timeout": "<время_ожидания_клиента_в_транзакции>"
                      }
                    }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.UserService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых полей в виде массива строк `paths[]`.
        * `login` — разрешение на вход в базу данных: `true` или `false`.
        * `resource_group` — [ресурсная группа](../concepts/resource-groups.md), к которой относятся запросы пользователя.
        * `settings` — настройки Odyssey на уровне пользователя:

            * `pool_mode` — режим пула соединений: `SESSION` или `TRANSACTION`;
            * `pool_size` — количество серверных соединений в пуле;
            * `pool_client_idle_timeout` — время неактивности клиентского соединения в секундах, после которого соединение разрывается;
            * `pool_idle_in_transaction_timeout` — время неактивности клиентского соединения с открытой транзакцией в секундах, после которого соединение разрывается.

        Чтобы сбросить настройку Odyssey и использовать значение уровня кластера, укажите соответствующее поле в `update_mask.paths`, но не передавайте его значение в объекте `settings`.

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation).

- SQL {#sql}

    С помощью SQL можно изменить атрибуты роли и задать для нее настройки СУБД.

    Для выполнения операций с помощью SQL [подключитесь к базе данных](connect/index.md) от имени пользователя с ролью `mdb_admin`.

    Чтобы изменить атрибуты роли, выполните команду:

    ```sql
    ALTER ROLE <имя_роли> <список_атрибутов>;
    ```

    Доступные атрибуты читайте в разделе [{#T}](../concepts/cluster-users.md#attributes).

{% endlist %}

## Изменить состав групповой роли {#group-roles}

Для выполнения операций с помощью SQL [подключитесь к базе данных](connect/index.md) от имени пользователя с ролью `mdb_admin`.

Чтобы добавить роль в состав групповой роли, выполните команду:

```sql
GRANT <имя_групповой_роли> TO <список_ролей_через_запятую>;
```

Имена пользователей и ролей можно получить со [списком пользователей и ролей в кластере](#list).

Атрибуты `LOGIN`, `SUPERUSER`, `CREATEDB`, `CREATEROLE`, `CREATEEXTTABLE` и `RESOURCE QUEUE` не наследуются. Чтобы воспользоваться всеми атрибутами групповой роли, от имени роли, входящей в ее состав, выполните команду:

```sql
SET ROLE <имя_групповой_роли>;
```

Чтобы удалить роль из состава групповой роли, выполните команду:

```sql
REVOKE <имя_групповой_роли> FROM <список_ролей_через_запятую>;
```

## Настроить привилегии роли {#privileges}

{% list tabs group=instructions %}

- SQL {#sql}

    Для выполнения операций с помощью SQL [подключитесь к базе данных](connect/index.md) от имени пользователя с ролью `mdb_admin`.

    Чтобы выдать привилегии роли, выполните команду:

    ```sql
    GRANT <список_привилегий_через_запятую> ON <имя_объекта> TO <имя_роли>;
    ```

    Доступные привилегии читайте в разделе [{#T}](../concepts/cluster-users.md#privileges).

    Чтобы отозвать привилегии у роли, выполните команду:

    ```sql
    REVOKE <список_привилегий_через_запятую> ON <имя_объекта> FROM <имя_роли>;
    ```

    Вместо перечисления всех привилегий объекта используйте `ALL PRIVILEGES`.

    Чтобы отозвать все привилегии всех объектов роли, выполните команду:

    ```sql
    DROP OWNED BY <имя_роли>;
    ```

{% endlist %}

## Удалить пользователя или роль {#remove}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы удалить пользователя кластера, выполните команду:

    ```bash
    {{ yc-mdb-gp }} users delete <имя_пользователя> \
        --cluster-id <идентификатор_кластера>
    ```

    {% include [cluster-name-as-id](../../_includes/mdb/mgp/cluster-name-as-id.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [User.Delete](../api-ref/User/delete.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request DELETE \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>'
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей кластера](#list).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/delete.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [UserService.Delete](../api-ref/grpc/User/delete.md) и выполните запрос [DeleteUserRequest](../api-ref/grpc/User/delete.md#yandex.cloud.mdb.greenplum.v1.DeleteUserRequest), например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/user_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "user_name": "<имя_пользователя>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.UserService.Delete
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей кластера](#list).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/delete.md#yandex.cloud.operation.Operation).

- SQL {#sql}

    Для выполнения операций с помощью SQL [подключитесь к базе данных](connect/index.md) от имени пользователя с ролью `mdb_admin`.

    Перед удалением роли удалите все объекты, которыми она владеет, или переназначьте их права собственности и отзовите все привилегии для других объектов.

    Выполните команду:

    ```sql
    DROP ROLE <имя_роли>;
    ```

{% endlist %}

## Примеры {#examples}

### Создание роли {#role-creation}

Создайте роль с тестовыми характеристиками:

* С именем `greenplum_user`.
* С атрибутами `CREATEDB` и `CREATEROLE`.
* С возможностью авторизации в системе с защищенным паролем `password123`.

Выполните команду:

```sql
CREATE ROLE greenplum_user CREATEDB CREATEROLE LOGIN ENCRYPTED PASSWORD 'password123';
```

Проверьте, что новая роль с заданными атрибутами появилась в списке:

```sql
SELECT
    rolname,
    rolsuper,
    rolcreatedb,
    rolcreaterole,
    rolinherit,
    rolcanlogin,
    rolconnlimit,
    rolcreaterextgpfd
FROM pg_roles;
```

### Применение настроек Odyssey для пользователя {#user-pool-settings}

Допустим, в кластере `mygp` есть база данных `db1`. Нужно создать пользователя `pool_user` с паролем `SecretPassword`, задать для него транзакционный режим пула размером 20 соединений и разрешить подключения с IP-адреса `172.20.143.89`.

1. Создайте пользователя:

    ```bash
    {{ yc-mdb-gp }} users create pool_user \
        --cluster-name mygp \
        --password "SecretPassword" \
        --pool-mode transaction \
        --pool-size 20
    ```

1. [Добавьте правило аутентификации](user-auth-rules.md#add-rules), указав в параметре `--user` имя пользователя:

    ```bash
    {{ yc-mdb-gp }} hba-rules create 1 \
        --cluster-name mygp \
        --conn-type hostssl \
        --database db1 \
        --user pool_user \
        --address 172.20.143.89/32 \
        --auth-method md5
    ```

В обеих командах указано имя `pool_user`, поэтому настройки Odyssey применяются к подключениям этого пользователя.

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
