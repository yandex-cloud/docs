# Управление базами данных в Sharded PostgreSQL

Вы можете добавлять и удалять базы данных, а также просматривать информацию о них.

## Получить список баз данных в кластере {#list-db}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **Yandex Managed Service for Sharded&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Базы данных**.

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Воспользуйтесь методом [Database.List](../api-ref/Database/list.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://mdb.api.cloud.yandex.net/managed-spqr/v1/clusters/<идентификатор_кластера>/databases'
     ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Database/list.md#yandex.cloud.mdb.spqr.v1.ListDatabasesResponse).

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
  1. Воспользуйтесь вызовом [DatabaseService.List](../api-ref/grpc/Database/list.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/database_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>"
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.spqr.v1.DatabaseService.List
     ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Database/list.md#yandex.cloud.mdb.spqr.v1.ListDatabasesResponse).

{% endlist %}

## Получить информацию о базе данных {#get-db}

{% list tabs group=instructions %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Воспользуйтесь методом [Database.Get](../api-ref/Database/get.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://mdb.api.cloud.yandex.net/managed-spqr/v1/clusters/<идентификатор_кластера>/databases/<имя_БД>'
     ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Database/get.md#yandex.cloud.mdb.spqr.v1.Database).

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
  1. Воспользуйтесь вызовом [DatabaseService.Get](../api-ref/grpc/Database/get.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/database_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "database_name": "<имя_БД>"
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.spqr.v1.DatabaseService.Get
     ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Database/get.md#yandex.cloud.mdb.spqr.v1.Database).

{% endlist %}

## Создать базу данных {#add-db}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **Yandex Managed Service for Sharded&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Базы данных**.
  1. Нажмите кнопку **Создать базу данных**.
  1. Укажите параметры базы данных:

      * Имя.

        Имя БД может содержать латинские буквы, цифры, подчеркивание и дефис. Максимальная длина имени 63 символа. Имена `postgres`, `template0`, `template1` зарезервированы. Создать БД с этими именами нельзя.

      * Защита от удаления.

        Возможные значения:
          - **Как у кластера**
          - **Включена**
          - **Выключена**

  1. Нажмите кнопку **Создать**.

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Воспользуйтесь методом [Database.Create](../api-ref/Database/create.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://mdb.api.cloud.yandex.net/managed-spqr/v1/clusters/<идентификатор_кластера>/databases' \
       --data '{
                 "databaseSpec": {
                   "name": "<имя_БД>",
                   "deletionProtection": "<защитить_БД_от_удаления>"
                 }
               }'
     ```

     Где `databaseSpec` — параметры новой БД:

     * `name` — имя БД.

       Имя БД может содержать латинские буквы, цифры, подчеркивание и дефис. Максимальная длина имени 63 символа. Имена `postgres`, `template0`, `template1` зарезервированы. Создать БД с этими именами нельзя.

     * `deletionProtection` — защита БД от удаления: `true` или `false`.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Database/create.md#yandex.cloud.operation.Operation).

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
  1. Воспользуйтесь вызовом [DatabaseService.Create](../api-ref/grpc/Database/create.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/database_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "database_spec": {
               "name": "<имя_БД>",
               "deletion_protection": "<защитить_БД_от_удаления>"
             }
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.spqr.v1.DatabaseService.Create
     ```

     Где `database_spec` — параметры новой БД:

     * `name` — имя БД.

       Имя БД может содержать латинские буквы, цифры, подчеркивание и дефис. Максимальная длина имени 63 символа. Имена `postgres`, `template0`, `template1` зарезервированы. Создать БД с этими именами нельзя.

     * `deletion_protection` — защита БД от удаления: `true` или `false`.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Database/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Удалить базу данных {#remove-db}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы удалить базу данных:
  1. Перейдите в сервис **Yandex Managed Service for Sharded&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Базы данных**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужной БД, выберите пункт **Удалить** и подтвердите удаление.

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Воспользуйтесь методом [Database.Delete](../api-ref/Database/delete.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://mdb.api.cloud.yandex.net/managed-spqr/v1/clusters/<идентификатор_кластера>/databases/<имя_БД>'
     ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Database/delete.md#yandex.cloud.operation.Operation).

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
  1. Воспользуйтесь вызовом [DatabaseService.Delete](../api-ref/grpc/Database/delete.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/database_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "database_name": "<имя_БД>"
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.spqr.v1.DatabaseService.Delete
     ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Database/delete.md#yandex.cloud.operation.Operation).

{% endlist %}