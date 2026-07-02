[Документация Yandex Cloud](../../index.md) > [Yandex MPP Analytics for PostgreSQL](../index.md) > [Пошаговые инструкции](index.md) > Пользователи и сессии > Правила аутентификации пользователей

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

    1. Перейдите на [страницу каталога](https://console.yandex.cloud).
    1. Перейдите в сервис **Yandex MPP Analytics for&nbsp;PostgreSQL**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/persons.svg) **Аутентификация пользователей**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    1. Посмотрите описание команды для получения списка правил:

        ```bash
        yc managed-greenplum hba-rules list --help
        ```

    1. Получите список правил:

        ```bash
        yc managed-greenplum hba-rules list --cluster-id <идентификатор_кластера>
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

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [HBARule.List](../api-ref/HBARule/list.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://mdb.api.cloud.yandex.net/managed-greenplum/v1/clusters/<идентификатор_кластера>/hbaRules'
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/HBARule/list.md#yandex.cloud.mdb.greenplum.v1.ListHBARulesResponse).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Воспользуйтесь вызовом [HBARuleService.List](../api-ref/grpc/HBARule/list.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.greenplum.v1.HBARuleService.List
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/HBARule/list.md#yandex.cloud.mdb.greenplum.v1.ListHBARulesResponse).

{% endlist %}          

## Добавить правило {#add-rules}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога](https://console.yandex.cloud).
    1. Перейдите в сервис **Yandex MPP Analytics for&nbsp;PostgreSQL**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/persons.svg) **Аутентификация пользователей**.
    1. Нажмите кнопку **Редактировать правила**.
    1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **Добавить правило** и задайте его параметры:

        * **Тип** — тип соединения.
        * **База данных** — имя базы данных, к которой выполняется подключение. Указание системных баз данных запрещено.
        * **Пользователь** — имя пользователя или группы пользователей базы данных. Указание системных пользователей запрещено.
        * **Адрес (CIDR/FQDN)** — FQDN хоста или диапазон IP-адресов в нотации CIDR, с которых будет выполняться подключение к базе данных.
        * **Метод** — метод аутентификации.
        
        Подробнее о параметрах читайте в разделе [Настройки правил аутентификации](../concepts/user-authentication.md#auth-settings).

    1. Чтобы добавить еще одно правило, нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **Добавить правило**.
    1. Нажмите кнопку **Сохранить**.

    {% note info %}

    В конец списка автоматически добавляется правило по умолчанию, которое разрешает аутентификацию всем пользователям во всех базах и со всех хостов с помощью метода `md5` (по паролю).

    {% endnote %}

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    1. Посмотрите описание команды для добавления правила:

        ```bash
        yc managed-greenplum hba-rules create --help
        ```

    1. Добавьте правило:

        ```bash
        yc managed-greenplum hba-rules create <приоритет_правила> \
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

        Подробнее о параметрах читайте в разделе [Настройки правил аутентификации](../concepts/user-authentication.md#auth-settings).

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}   

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [HBARule.Create](../api-ref/HBARule/create.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://mdb.api.cloud.yandex.net/managed-greenplum/v1/clusters/<идентификатор_кластера>/hbaRules' \
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

        Подробнее о параметрах читайте в разделе [Настройки правил аутентификации](../concepts/user-authentication.md#auth-settings).

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/HBARule/create.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Воспользуйтесь вызовом [HBARuleService.Create](../api-ref/grpc/HBARule/create.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
            mdb.api.cloud.yandex.net:443 \
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

    1. Перейдите на [страницу каталога](https://console.yandex.cloud).
    1. Перейдите в сервис **Yandex MPP Analytics for&nbsp;PostgreSQL**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/persons.svg) **Аутентификация пользователей**.
    1. Нажмите кнопку **Редактировать правила** и измените параметры правил:

        * **Тип** — тип соединения.
        * **База данных** — имя базы данных, к которой выполняется подключение. Указание системных баз данных запрещено.
        * **Пользователь** — имя пользователя или группы пользователей базы данных. Указание системных пользователей запрещено.
        * **Адрес (CIDR/FQDN)** — FQDN хоста или диапазон IP-адресов в нотации CIDR, с которых будет выполняться подключение к базе данных.
        * **Метод** — метод аутентификации.
        
        Подробнее о параметрах читайте в разделе [Настройки правил аутентификации](../concepts/user-authentication.md#auth-settings).

    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    1. Посмотрите описание команды для изменения правила:

        ```bash
        yc managed-greenplum hba-rules update --help
        ```

    1. Измените правило:

        ```bash
        yc managed-greenplum hba-rules update <приоритет_правила> \
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

        Подробнее о параметрах читайте в разделе [Настройки правил аутентификации](../concepts/user-authentication.md#auth-settings).

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        Приоритет правила можно узнать, [запросив список всех правил для кластера](#list-rules).

- REST API {#api}   

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [HBARule.Update](../api-ref/HBARule/update.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://mdb.api.cloud.yandex.net/managed-greenplum/v1/clusters/<идентификатор_кластера>/hbaRules' \
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

        Подробнее о параметрах читайте в разделе [Настройки правил аутентификации](../concepts/user-authentication.md#auth-settings).

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        Приоритет правила можно узнать, [запросив список всех правил для кластера](#list-rules).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/HBARule/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Воспользуйтесь вызовом [HBARuleService.Update](../api-ref/grpc/HBARule/update.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
            mdb.api.cloud.yandex.net:443 \
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

    1. Перейдите на [страницу каталога](https://console.yandex.cloud).
    1. Перейдите в сервис **Yandex MPP Analytics for&nbsp;PostgreSQL**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/persons.svg) **Аутентификация пользователей**.
    1. Нажмите кнопку **Редактировать правила**.
    1. Нажмите на значок ![image](../../_assets/console-icons/grip.svg) для нужного правила и переместите его выше или ниже.
    1. Нажмите кнопку **Сохранить**.

{% endlist %}

## Удалить правило {#delete-rule}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога](https://console.yandex.cloud).
    1. Перейдите в сервис **Yandex MPP Analytics for&nbsp;PostgreSQL**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/persons.svg) **Аутентификация пользователей**.
    1. Нажмите кнопку **Редактировать правила**.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) для нужного правила и выберите пункт **Удалить**.
    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    1. Посмотрите описание команды для удаления правила:

        ```bash
        yc managed-greenplum hba-rules delete --help
        ```

    1. Удалите правило:

       ```bash
        yc managed-greenplum hba-rules delete <приоритет_правила> \
            --cluster-id <идентификатор_кластера>
        ```    

    Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    Приоритет правила можно узнать, [запросив список всех правил для кластера](#list-rules).

- REST API {#api}   

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [HBARule.Delete](../api-ref/HBARule/delete.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request DELETE \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://mdb.api.cloud.yandex.net/managed-greenplum/v1/clusters/<идентификатор_кластера>/hbaRule/<приоритет_правила>'
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        Приоритет правила можно узнать, [запросив список всех правил для кластера](#list-rules).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/HBARule/delete.md#yandex.cloud.operation.Operation). 

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Воспользуйтесь вызовом [HBARuleService.Delete](../api-ref/grpc/HBARule/delete.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.greenplum.v1.HBARuleService.Delete
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        Приоритет правила можно узнать, [запросив список всех правил для кластера](#list-rules).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/HBARule/delete.md#yandex.cloud.operation.Operation).      

{% endlist %}