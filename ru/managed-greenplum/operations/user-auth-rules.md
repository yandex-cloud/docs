# Правила аутентификации пользователей

Правила [аутентификации пользователей](../concepts/user-authentication.md) определяют, какие пользователи и с каких адресов могут подключаться к кластеру и к каким базам данных они могут получить доступ.

Вы можете:

* [Получить список правил](#list-rules).
* [Добавить правило](#add-rules).
* [Изменить правило](#edit-rules).
* [Изменить приоритет правила](#replace-rule).
* [Удалить правило](#delete-rule).

{% note warning %}

Приоритет правил определяется порядком строк: правила читаются сверху вниз и применяется первое подходящее. Если по первому подходящему правилу аутентификация не прошла, последующие не рассматриваются.

{% endnote %}

## Получить список правил {#list-rules}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.greenplum.label_user-auth }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Посмотрите описание команды для получения списка правил:

        ```bash
        {{ yc-mdb-gp }} hba-rules list --help
        ```

    1. Получите список правил:

        ```bash
        {{ yc-mdb-gp }} hba-rules list --cluster-id <идентификатор_кластера>
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        Результат:

        ```bash
        +----------+-----------------+-----+-------+-------------------------------------------+-------------+
        | PRIORITY | CONNECTION TYPE | DB  | USER  |                  ADDRESS                  | AUTH METHOD |
        +----------+-----------------+-----+-------+-------------------------------------------+-------------+
        |        1 | HOST            | db1 | user1 | rc1a-no8u9mlr********.mdb.yandexcloud.net | MD5         |
        +----------+-----------------+-----+-------+-------------------------------------------+-------------+
        ```

- REST API {#api}   

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [HBARule.List](../api-ref/HBARule/list.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<идентификатор_кластера>/hbaRules'
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/HBARule/list.md#yandex.cloud.mdb.greenplum.v1.ListHBARulesResponse).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [HBARuleService.List](../api-ref/grpc/HBARule/list.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/hba_rule_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.HBARuleService.List
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/HBARule/list.md#yandex.cloud.mdb.greenplum.v1.ListHBARulesResponse).

{% endlist %}          

## Добавить правило {#add-rules}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.greenplum.label_user-auth }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.greenplum.cluster.user-auth.action_edit-rules }}**.
    1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.greenplum.cluster.user-auth.action_add-rule }}** и задайте его параметры:

        {% include [auth-user-rule-settings](../../_includes/mdb/mgp/auth-user-rule-settings.md) %}

    1. Чтобы добавить еще одно правило, нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.greenplum.cluster.user-auth.action_add-rule }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

    {% note info %}

    В конец списка автоматически добавляется правило по умолчанию, которое разрешает аутентификацию всем пользователям во всех базах и со всех хостов с помощью метода `md5` (по паролю).

    {% endnote %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Посмотрите описание команды для добавления правила:

        ```bash
        {{ yc-mdb-gp }} hba-rules create --help
        ```

    1. Добавьте правило:

        ```bash
        {{ yc-mdb-gp }} hba-rules create <приоритет_правила> \
            --cluster-id <идентификатор_кластера> \
            --conn-type <тип_соединения> \
            --database <имя_базы_данных> \
            --user <имя_пользователя> \
            --address <адрес> \
            --auth-method <метод_аутентификации>
        ```

        Где:

        * `conn-type` — тип соединения. Возможные значения: `host`, `hostssl`, `hostnossl`.
        * `address` — FQDN хоста или диапазон IP-адресов в нотации CIDR, с которых будет выполняться подключение к базе данных.
        * `auth-method` — метод аутентификации. Возможные значения: `md5`, `reject`.

        Подробнее о параметрах см. в разделе [Настройки правил аутентификации](../../managed-greenplum/concepts/user-authentication.md#auth-settings).

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}   

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [HBARule.Create](../api-ref/HBARule/create.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<идентификатор_кластера>/hbaRules' \
            --data '{
                        "hbaRule": {
                            "priority": "<приоритет_правила>",
                            "connectionType": "<тип_соединения>",
                            "database": "<имя_базы_данных>",
                            "user": "<имя_пользователя>",
                            "address": "<адрес>",
                            "authMethod": "<метод_аутентификации>"
                        }
                    }'
        ```

        Где:

        * `connectionType` — тип соединения. Возможные значения: `HOST`, `HOSTSSL`, `HOSTNOSSL`.
        * `address` — FQDN хоста или диапазон IP-адресов в нотации CIDR, с которых будет выполняться подключение к базе данных.
        * `authMethod` — метод аутентификации. Возможные значения: `MD5`, `REJECT`.

        Подробнее о параметрах см. в разделе [Настройки правил аутентификации](../../managed-greenplum/concepts/user-authentication.md#auth-settings).

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/HBARule/create.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [HBARuleService.Create](../api-ref/grpc/HBARule/create.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/hba_rule_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "hba_rule": {
                        "priority": "<приоритет_правила>",
                        "connection_type": "<тип_соединения>",
                        "database": "<имя_базы_данных>",
                        "user": "<имя_пользователя>",
                        "address": "<адрес>",
                        "auth_method": "<метод_аутентификации>"
                    }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.HBARuleService.Create
        ```

        Где:

        * `connection_type` — тип соединения. Возможные значения: `HOST`, `HOSTSSL`, `HOSTNOSSL`.
        * `address` — FQDN хоста или диапазон IP-адресов в нотации CIDR, с которых будет выполняться подключение к базе данных.
        * `auth_method` — метод аутентификации. Возможные значения: `MD5`, `REJECT`.

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/HBARule/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить правило {#edit-rules}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.greenplum.label_user-auth }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.greenplum.cluster.user-auth.action_edit-rules }}** и измените параметры правил:

        {% include [auth-user-rule-settings](../../_includes/mdb/mgp/auth-user-rule-settings.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Посмотрите описание команды для изменения правила:

        ```bash
        {{ yc-mdb-gp }} hba-rules update --help
        ```

    1. Измените правило:

        ```bash
        {{ yc-mdb-gp }} hba-rules update <приоритет_правила> \
            --cluster-id <идентификатор_кластера> \
            --conn-type <тип_соединения> \
            --database <имя_базы_данных> \
            --user <имя_пользователя> \
            --address <адрес> \
            --auth-method <метод_аутентификации>
        ```

        Где:

        * `conn-type` — тип соединения. Возможные значения: `host`, `hostssl`, `hostnossl`.
        * `address` — FQDN хоста или диапазон IP-адресов в нотации CIDR, с которых будет выполняться подключение к базе данных.
        * `auth-method` — метод аутентификации. Возможные значения: `md5`, `reject`.

        Подробнее о параметрах см. в разделе [Настройки правил аутентификации](../../managed-greenplum/concepts/user-authentication.md#auth-settings).

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        Приоритет правила можно узнать, [запросив список всех правил для кластера](#list-rules).

- REST API {#api}   

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [HBARule.Update](../api-ref/HBARule/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<идентификатор_кластера>/hbaRules' \
            --data '{
                        "hbaRule": {
                            "priority": "<приоритет_правила>",
                            "connectionType": "<тип_соединения>",
                            "database": "<имя_базы_данных>",
                            "user": "<имя_пользователя>",
                            "address": "<адрес>",
                            "authMethod": "<метод_аутентификации>"
                        }
                    }'
        ```

        Где:

        * `connectionType` — тип соединения. Возможные значения: `HOST`, `HOSTSSL`, `HOSTNOSSL`.
        * `address` — FQDN хоста или диапазон IP-адресов в нотации CIDR, с которых будет выполняться подключение к базе данных.
        * `authMethod` — метод аутентификации. Возможные значения: `MD5`, `REJECT`.

        Подробнее о параметрах см. в разделе [Настройки правил аутентификации](../../managed-greenplum/concepts/user-authentication.md#auth-settings).

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        Приоритет правила можно узнать, [запросив список всех правил для кластера](#list-rules).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/HBARule/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [HBARuleService.Update](../api-ref/grpc/HBARule/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/hba_rule_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "hba_rule": {
                        "priority": "<приоритет_правила>",
                        "connection_type": "<тип_соединения>",
                        "database": "<имя_базы_данных>",
                        "user": "<имя_пользователя>",
                        "address": "<адрес>",
                        "auth_method": "<метод_аутентификации>"
                    }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.HBARuleService.Update
        ```

        Где:

        * `connection_type` — тип соединения. Возможные значения: `HOST`, `HOSTSSL`, `HOSTNOSSL`.
        * `address` — FQDN хоста или диапазон IP-адресов в нотации CIDR, с которых будет выполняться подключение к базе данных.
        * `auth_method` — метод аутентификации. Возможные значения: `MD5`, `REJECT`.

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        Приоритет правила можно узнать, [запросив список всех правил для кластера](#list-rules).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/HBARule/update.md#yandex.cloud.operation.Operation).    

{% endlist %}

## Изменить приоритет правила {#replace-rule}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.greenplum.label_user-auth }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.greenplum.cluster.user-auth.action_edit-rules }}**.
    1. Нажмите на значок ![image](../../_assets/console-icons/grip.svg) для нужного правила и переместите его выше или ниже.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Удалить правило {#delete-rule}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.greenplum.label_user-auth }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.greenplum.cluster.user-auth.action_edit-rules }}**.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) для нужного правила и выберите пункт **{{ ui-key.yacloud.common.delete }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Посмотрите описание команды для удаления правила:

        ```bash
        {{ yc-mdb-gp }} hba-rules delete --help
        ```

    1. Удалите правило:

       ```bash
        {{ yc-mdb-gp }} hba-rules delete <приоритет_правила> \
            --cluster-id <идентификатор_кластера>
        ```    

    Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    Приоритет правила можно узнать, [запросив список всех правил для кластера](#list-rules).

- REST API {#api}   

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [HBARule.Delete](../api-ref/HBARule/delete.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request DELETE \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<идентификатор_кластера>/hbaRule/<приоритет_правила>'
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        Приоритет правила можно узнать, [запросив список всех правил для кластера](#list-rules).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/HBARule/delete.md#yandex.cloud.operation.Operation). 

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [HBARuleService.Delete](../api-ref/grpc/HBARule/delete.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/hba_rule_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "priority": "<приоритет_правила>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.HBARuleService.Delete
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        Приоритет правила можно узнать, [запросив список всех правил для кластера](#list-rules).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/HBARule/delete.md#yandex.cloud.operation.Operation).      

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
