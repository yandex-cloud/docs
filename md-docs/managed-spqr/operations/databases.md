[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Sharded PostgreSQL](../index.md) > [Пошаговые инструкции](index.md) > Управление базами данных

# Управление базами данных в Sharded PostgreSQL

Вы можете добавлять и удалять базы данных, а также просматривать информацию о них.

## Получить список баз данных в кластере {#list-db}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](https://console.yandex.cloud/link/managed-spqr) в сервис **Yandex Managed Service for Sharded&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Базы данных**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить список баз данных в кластере, выполните команду:

  ```bash
  yc managed-sharded-postgresql database list \
     --cluster-id <идентификатор_кластера>
  ```

  Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

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

     Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

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

     Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Database/list.md#yandex.cloud.mdb.spqr.v1.ListDatabasesResponse).

{% endlist %}

## Получить информацию о базе данных {#get-db}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить информацию о базе данных, выполните команду:

  ```bash
  yc managed-sharded-postgresql database get <имя_БД> \
     --cluster-id <идентификатор_кластера>
  ```

  Имя базы данных можно получить со [списком баз данных](#list-db) в кластере, а идентификатор кластера — со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
  
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

     Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

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

     Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Database/get.md#yandex.cloud.mdb.spqr.v1.Database).

{% endlist %}

## Создать базу данных {#add-db}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](https://console.yandex.cloud/link/managed-spqr) в сервис **Yandex Managed Service for Sharded&nbsp;PostgreSQL**.
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

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы создать базу данных в кластере:

  1. Посмотрите описание команды CLI для создания базы данных:

      ```bash
      yc managed-sharded-postgresql database create --help
      ```
  
  1. Создайте базу данных, выполнив команду:

      ```bash
      yc managed-sharded-postgresql database create <имя_БД> \
         --cluster-id <идентификатор_кластера>
      ```

      Где: 

      * `<имя_БД>` — имя новой базы данных.

        Имя БД может содержать латинские буквы, цифры, подчеркивание и дефис. Максимальная длина имени 63 символа. Имена `postgres`, `template0`, `template1` зарезервированы. Создать БД с этими именами нельзя.
      
      * `--cluster-id` — идентификатор кластера, который можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.


- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

      О том, как создать такой файл, в разделе [Создание кластера Sharded PostgreSQL](cluster-create.md).

  1. Добавьте ресурс `yandex_mdb_sharded_postgresql_database`:

      ```hcl
      resource "yandex_mdb_sharded_postgresql_database" "<локальное_имя_БД>" {
        cluster_id = <идентификатор_кластера>
        name       = "<имя_БД>"
      }
      ```

      Где:
      
      * `cluster_id` — идентификатор кластера, который можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

      * `name` — имя базы данных.
        
        Имя БД может содержать латинские буквы, цифры, подчеркивание и дефис. Максимальная длина имени 63 символа. Имена `postgres`, `template0`, `template1` зарезервированы. Создать БД с этими именами нельзя.
      
      Подробнее о ресурсе `yandex_mdb_sharded_postgresql_database` в [документации провайдера Terraform](../../terraform/resources/mdb_sharded_postgresql_database.md).

  1. Проверьте корректность настроек.

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Подтвердите изменение ресурсов.

      1. Выполните команду для просмотра планируемых изменений:
      
         ```bash
         terraform plan
         ```
      
         Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
      
      1. Если вас устраивают планируемые изменения, внесите их:
      
         1. Выполните команду:
      
            ```bash
            terraform apply
            ```
      
         1. Подтвердите изменение ресурсов.
         1. Дождитесь завершения операции.


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

     Где: 

     * `<идентификатор_кластера>` — идентификатор кластера, который можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
     * `databaseSpec` — параметры новой БД:

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

     Где:

     * `cluster_id` — идентификатор кластера, который можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
     * `database_spec` — параметры новой БД:

       * `name` — имя БД.

         Имя БД может содержать латинские буквы, цифры, подчеркивание и дефис. Максимальная длина имени 63 символа. Имена `postgres`, `template0`, `template1` зарезервированы. Создать БД с этими именами нельзя.

       * `deletion_protection` — защита БД от удаления: `true` или `false`.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Database/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Удалить базу данных {#remove-db}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы удалить базу данных:
  1. [Перейдите](https://console.yandex.cloud/link/managed-spqr) в сервис **Yandex Managed Service for Sharded&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Базы данных**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужной БД, выберите пункт **Удалить** и подтвердите удаление.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы удалить базу данных, выполните команду:

  ```bash
  yc managed-sharded-postgresql database delete <имя_БД> \
     --cluster-id <идентификатор_кластера>
  ```

  Имя базы данных можно получить со [списком баз данных](#list-db) в кластере, а идентификатор кластера — со [списком кластеров](cluster-list.md#list-clusters) в каталоге.


- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

      О том, как создать такой файл, в разделе [Создание кластера Sharded PostgreSQL](cluster-create.md).

  1. Удалите ресурс `yandex_mdb_sharded_postgresql_database` с описанием базы данных, которую вы хотите удалить.

  1. Проверьте корректность настроек.

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Подтвердите изменение ресурсов.

      1. Выполните команду для просмотра планируемых изменений:
      
         ```bash
         terraform plan
         ```
      
         Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
      
      1. Если вас устраивают планируемые изменения, внесите их:
      
         1. Выполните команду:
      
            ```bash
            terraform apply
            ```
      
         1. Подтвердите изменение ресурсов.
         1. Дождитесь завершения операции.


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

     Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

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

     Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Database/delete.md#yandex.cloud.operation.Operation).

{% endlist %}