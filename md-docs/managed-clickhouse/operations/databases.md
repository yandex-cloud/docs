[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for ClickHouse®](../index.md) > [Пошаговые инструкции](index.md) > Базы данных > Управление базами данных

# Управление базами данных в Managed Service for ClickHouse®

Managed Service for ClickHouse® позволяет управлять базами данных кластера двумя способами:

* С помощью стандартных интерфейсов Yandex Cloud (CLI, [API](../../glossary/rest-api.md), консоль управления). Способ подходит, если вы хотите создавать и удалять базы данных кластера, используя возможности сервиса Yandex Managed Service for ClickHouse®.
* С помощью SQL-запросов к кластеру. Способ подходит, если вы хотите использовать уже существующее у вас решение для создания и управления базами данных или если вам требуется поддержка MySQL® баз данных в Managed Service for ClickHouse®.

## Управление базами данных через SQL {#sql-database-management}

Чтобы включить управление, выберите опции **Управление пользователями через SQL** и **Управление базами данных через SQL** при [создании](cluster-create.md) или [изменении настроек](update.md#SQL-management) кластера.

В кластере с включенным управлением базами данных через SQL:

* Управление базами данных и [пользователями](cluster-users.md#sql-user-management) через стандартные интерфейсы Yandex Cloud (CLI, API, консоль управления) недоступно.
* Невозможно включить управление пользователями и базами данных с помощью стандартных интерфейсов Yandex Cloud.
* Существующие пользователи, настройки пользователей и базы данных, созданные с помощью стандартных интерфейсов Yandex Cloud, будут сохранены.
* Управление осуществляется с помощью учетной записи `admin`. Пароль для нее задается при выборе опций **Управление пользователями через SQL** и **Управление базами данных через SQL**.

## Получить список баз данных в кластере {#list-db}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
  1. Перейдите в сервис **Managed Service for&nbsp;ClickHouse**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **Базы данных**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить список баз данных в кластере, выполните команду:

  ```bash
  yc managed-clickhouse database list \
     --cluster-name=<имя_кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. Воспользуйтесь методом [Database.List](../api-ref/Database/list.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>/databases'
      ```

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Database/list.md#yandex.cloud.mdb.clickhouse.v1.ListDatabasesResponse).

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
  1. Воспользуйтесь вызовом [DatabaseService.List](../api-ref/grpc/Database/list.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/database_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>"
            }' \
        mdb.api.cloud.yandex.net:443 \
        yandex.cloud.mdb.clickhouse.v1.DatabaseService.List
      ```

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Database/list.md#yandex.cloud.mdb.clickhouse.v1.ListDatabasesResponse).

- SQL {#sql}

  1. [Подключитесь](connect/clients.md) к кластеру, используя [учетную запись `admin`](#sql-database-management).
  1. Получите список баз данных:

      ```sql
      SHOW DATABASES;
      ```

{% endlist %}

## Создать базу данных {#add-db}

{% note info %}

В каждом кластере вы можете создать не более 1000 баз данных.

{% endnote %}

Подробнее о лимитах в разделе [Квоты и лимиты](../concepts/limits.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
  1. Перейдите в сервис **Managed Service for&nbsp;ClickHouse**.
  1. Нажмите на имя нужного кластера.
  1. Выберите вкладку **Базы данных**.
  1. Нажмите кнопку **Создать базу данных**.
  1. Укажите имя базы данных.

      {% note info %}
      
      Имя базы может содержать латинские буквы, цифры и подчеркивание. Максимальная длина имени 63 символа. Запрещено создание базы данных с именем `default`.
      
      {% endnote %}

  1. Выберите движок базы данных: 
      
      * `Atomic` (по умолчанию) — поддерживает неблокирующие операции `DROP TABLE` и `RENAME TABLE`, а также атомарные операции `EXCHANGE TABLES`.
      * `Replicated` — поддерживает репликацию метаданных таблиц между всеми репликами базы данных. При этом набор таблиц и их схемы будут одинаковыми для всех реплик.

        Доступен только в [реплицированных](../concepts/replication.md) кластерах.

      Движок задается при создании базы данных и не может быть изменен для этой базы.

  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Выполните команду создания БД, задав имя новой базы:

  ```bash
  yc managed-clickhouse database create <имя_БД> \
     --cluster-name=<имя_кластера> \
     --engine=<движок_БД>
  ```

  Где:
  * `--cluster-name` — имя кластера базы данных.
  * `--engine` — движок базы данных. Необязательный параметр. Возможные значения:
    * `database-engine-atomic` (по умолчанию) — движок Atomic. Поддерживает неблокирующие операции `DROP TABLE` и `RENAME TABLE`, а также атомарные операции `EXCHANGE TABLES`.
    * `database-engine-replicated` — движок Replicated. Поддерживает репликацию метаданных таблиц между всеми репликами базы данных. При этом набор таблиц и их схемы будут одинаковыми для всех реплик.

      Доступен только в [реплицированных](../concepts/replication.md) кластерах.
                          
    Движок задается при создании базы данных и не может быть изменен для этой базы.

  {% note info %}
  
  Имя базы может содержать латинские буквы, цифры и подчеркивание. Максимальная длина имени 63 символа. Запрещено создание базы данных с именем `default`.
  
  {% endnote %}

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  Managed Service for ClickHouse® запустит операцию создания базы данных.


- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        О том, как создать такой файл, в разделе [Создание кластера](cluster-create.md).

    1. Добавьте ресурс `yandex_mdb_clickhouse_database`:

        ```hcl
        resource "yandex_mdb_clickhouse_database" "<имя_БД>" {
          cluster_id = "<идентификатор_кластера>"
          name       = "<имя_БД>"
          engine     = "<движок_БД>"
        }
        ```

        Где:
        * `cluster_id` — идентификатор кластера базы данных.
        * `name` — имя базы данных.
        * `engine` — движок базы данных. Необязательный параметр. Возможные значения:
          * `atomic` (по умолчанию) — движок Atomic. Поддерживает неблокирующие операции `DROP TABLE` и `RENAME TABLE`, а также атомарные операции `EXCHANGE TABLES`.
          * `replicated` — движок Replicated. Поддерживает репликацию метаданных таблиц между всеми репликами базы данных. При этом набор таблиц и их схемы будут одинаковыми для всех реплик.

            Доступен только в [реплицированных](../concepts/replication.md) кластерах.
                          
          Движок задается при создании базы данных и не может быть изменен для этой базы.

        {% note info %}
        
        Имя базы может содержать латинские буквы, цифры и подчеркивание. Максимальная длина имени 63 символа. Запрещено создание базы данных с именем `default`.
        
        {% endnote %}

        Если кластер создается с помощью Terraform одновременно с созданием БД, то в ресурсе `yandex_mdb_clickhouse_database` вместо идентификатора кластера укажите ссылку на имя создаваемого кластера:

        ```hcl

        resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
          name = "<имя_кластера>"
          ...
        }

        resource "yandex_mdb_clickhouse_database" "<имя_БД>" {
          cluster_id = yandex_mdb_clickhouse_cluster_v2.<имя_кластера>.id
          name       = "<имя_БД>"
        }
        ```

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

    Подробнее в [документации провайдера Terraform](../../terraform/resources/mdb_clickhouse_database.md).


- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. Воспользуйтесь методом [Database.Create](../api-ref/Database/create.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>/databases' \
          --data '{
                    "databaseSpec": {
                      "name": "<имя_базы_данных>",
                      "engine": "<движок_базы_данных>"
                    }
                  }'
      ```

      Где: 

      * `databaseSpec.name` — имя базы данных.

        {% note info %}
        
        Имя базы может содержать латинские буквы, цифры и подчеркивание. Максимальная длина имени 63 символа. Запрещено создание базы данных с именем `default`.
        
        {% endnote %}
        
      * `databaseSpec.engine` — движок базы данных. Возможные значения:
        
        * `DATABASE_ENGINE_ATOMIC` (по умолчанию) — движок Atomic. Поддерживает неблокирующие операции `DROP TABLE` и `RENAME TABLE`, а также атомарные операции `EXCHANGE TABLES`.
        * `DATABASE_ENGINE_REPLICATED` — движок Replicated. Поддерживает репликацию метаданных таблиц между всеми репликами базы данных. При этом набор таблиц и их схемы будут одинаковыми для всех реплик.
                            
          Доступен только в [реплицированных](../concepts/replication.md) кластерах.
        
        * `DATABASE_ENGINE_UNSPECIFIED` — для этого значения будет выбран движок по умолчанию `DATABASE_ENGINE_ATOMIC`.
                            
        Движок задается при создании базы данных и не может быть изменен для этой базы.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

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
  1. Воспользуйтесь вызовом [DatabaseService.Create](../api-ref/grpc/Database/create.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/database_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "database_spec": {
                  "name": "<имя_базы_данных>",
                  "engine": "<движок_базы_данных>"
                }
              }' \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.clickhouse.v1.DatabaseService.Create
      ```

      Где: 

      * `database_spec.name` — имя базы данных.

        {% note info %}
        
        Имя базы может содержать латинские буквы, цифры и подчеркивание. Максимальная длина имени 63 символа. Запрещено создание базы данных с именем `default`.
        
        {% endnote %}
        
      * `database_spec.engine` — движок базы данных. Возможные значения:

        * `DATABASE_ENGINE_ATOMIC` (по умолчанию) — движок Atomic. Поддерживает неблокирующие операции `DROP TABLE` и `RENAME TABLE`, а также атомарные операции `EXCHANGE TABLES`.
        * `DATABASE_ENGINE_REPLICATED` — движок Replicated. Поддерживает репликацию метаданных таблиц между всеми репликами базы данных. При этом набор таблиц и их схемы будут одинаковыми для всех реплик.
                            
          Доступен только в [реплицированных](../concepts/replication.md) кластерах.
        
        * `DATABASE_ENGINE_UNSPECIFIED` — для этого значения будет выбран движок по умолчанию `DATABASE_ENGINE_ATOMIC`.
                            
        Движок задается при создании базы данных и не может быть изменен для этой базы.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Database/create.md#yandex.cloud.operation.Operation).

- SQL {#sql}

  1. [Подключитесь](connect/clients.md) к кластеру, используя [учетную запись `admin`](#sql-database-management).
  1. Создайте базу данных:

      ```sql
      CREATE DATABASE <имя_БД>;
      ```

      {% note info %}
      
      Имя базы может содержать латинские буквы, цифры и подчеркивание. Максимальная длина имени 63 символа. Запрещено создание базы данных с именем `default`.
      
      {% endnote %}

  Подробнее о создании баз данных в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/create/database).

{% endlist %}

## Удалить базу данных {#remove-db}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
  1. Перейдите в сервис **Managed Service for&nbsp;ClickHouse**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Базы данных**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужной БД и выберите пункт **Удалить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы удалить базу данных, выполните команду:

  ```bash
  yc managed-clickhouse database delete <имя_БД> \
     --cluster-name=<имя_кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).


- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        О том, как создать такой файл, в разделе [Создание кластера](cluster-create.md).

    1. Удалите ресурс `yandex_mdb_clickhouse_database` с именем удаляемой базы данных.

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

    Подробнее в [документации провайдера Terraform](../../terraform/resources/mdb_clickhouse_database.md).


- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. Воспользуйтесь методом [Database.Delete](../api-ref/Database/delete.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

      ```bash
      curl \
          --request DELETE \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>/databases/<имя_БД>'
      ```

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя БД — со [списком БД в кластере](#list-db).

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
  1. Воспользуйтесь вызовом [DatabaseService.Delete](../api-ref/grpc/Database/delete.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/database_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "database_name": "<имя_БД>"
              }' \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.clickhouse.v1.DatabaseService.Delete
      ```

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя БД — со [списком БД в кластере](#list-db).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Database/delete.md#yandex.cloud.operation.Operation).

- SQL {#sql}

  1. [Подключитесь](connect/clients.md) к кластеру, используя [учетную запись `admin`](#sql-database-management).
  1. Удалите базу данных:

      ```sql
      DROP DATABASE <имя_БД>;
      ```

  Подробнее об удалении объектов в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/drop).

{% endlist %}

{% note warning %}

Прежде чем создать новую базу с тем же именем, дождитесь завершения операции удаления, иначе будет восстановлена удаляемая база. Статус операции можно получить вместе со [списком операций в кластере](cluster-list.md#list-operations).

{% endnote %}

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._