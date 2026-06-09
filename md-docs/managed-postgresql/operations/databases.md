# Управление базами данных в Managed Service for PostgreSQL

Вы можете добавлять, переименовывать и удалять базы данных, а также просматривать информацию о них.

{% note warning %}

Вы не можете управлять базами данных с помощью команд SQL.

{% endnote %}

## Получить список баз данных в кластере {#list-db}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Базы данных**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить список баз данных в кластере, выполните команду:

  ```bash
  yc managed-postgresql database list --cluster-name=<имя_кластера>
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
       --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/<идентификатор_кластера>/databases'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Database/list.md#yandex.cloud.mdb.postgresql.v1.ListDatabasesResponse).

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
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/database_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>"
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.postgresql.v1.DatabaseService.List
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Database/list.md#yandex.cloud.mdb.postgresql.v1.ListDatabasesResponse).

{% endlist %}

## Создать базу данных {#add-db}

{% note info %}

В каждом кластере вы можете создать не более 1000 баз данных.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера.
  1. Если владельцем новой базы данных должен стать еще не существующий пользователь, [создайте его](cluster-users.md#adduser).
  1. Выберите вкладку **Базы данных**.
  1. Нажмите кнопку **Создать базу данных**.
  1. Укажите параметры базы данных:

      * Имя.

        Имя базы может содержать латинские буквы, цифры, подчеркивание и дефис. Максимальная длина имени 63 символа. Имена `postgres`, `template0`, `template1` зарезервированы для собственных нужд Managed Service for PostgreSQL. Создавать базы с этими именами нельзя.

      * Владелец.

      * Защита от удаления.

        Возможные значения:
          - **Как у кластера**.
          - **Включена**.
          - **Выключена**.

      * (Опционально) Шаблон — имя одной из существующих баз, с которой нужно будет скопировать схему данных. На время создания новой базы все подключения к базе-шаблону будут закрыты.

          Подробнее см. в [документации PostgreSQL](https://www.postgresql.org/docs/current/sql-createdatabase.html).

      * Локали сортировки и набора символов.

          PostgreSQL использует локали для поддержки различных языковых стандартов. Выбор локали влияет на:
          
          - Порядок сортировки в запросах с использованием оператора `ORDER BY` или стандартных операторов сравнения текстовых данных.
          - Функции `upper`, `lower`, `initcap`, а также семейство функций `to_char`.
          - Операторы поиска по шаблону (`LIKE`, `ILIKE`, `SIMILAR TO`, регулярные выражения).
          - Возможность использовать индексы с оператором `LIKE`.
          
          По умолчанию используется локаль `C`. При использовании кодировки `C` для текстовых данных с нелатинскими (например, кириллическими) символами возможны ошибки в порядке сортировки данных и отображении данных при поиске по шаблону. Если эта локаль не подходит для корректной обработки таблиц в базе данных, выберите другую из списка. Однако учитывайте, что использование нестандартной локали может снизить скорость выполнения запросов к базе данных.
          
          Подробнее о настройках локали см. в [документации PostgreSQL](https://www.postgresql.org/docs/current/locale.html).
          
          Настройки локали нельзя изменить после создания базы данных. Но вы можете задать локаль сортировки для столбцов при создании и изменении отдельных таблиц. Подробнее читайте в  [документации PostgreSQL](https://www.postgresql.org/docs/current/sql-createtable.html).

  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы создать базу данных в кластере:

  1. Посмотрите описание команды CLI для создания БД:

     ```bash
     yc managed-postgresql database create --help
     ```

  1. Запросите список пользователей кластера, чтобы выбрать владельца новой базы данных:

     ```bash
     yc managed-postgresql user list --cluster-name=<имя_кластера>
     ```

     Если нужного пользователя в списке нет, [создайте его](cluster-users.md#adduser).

  1. Выполните команду создания БД. При необходимости укажите нужные локали сортировки и набора символов (по умолчанию задаются `LC_COLLATE=C` и `LC_CTYPE=C`) и шаблон:

     ```bash
     yc managed-postgresql database create <имя_БД> \
        --cluster-name=<имя_кластера> \
        --owner=<имя_владельца_БД> \
        --lc-collate=<локаль_сортировки> \
        --lc-type=<локаль_набора_символов> \
        --template-db=<имя_БД-шаблона>
     ```

     Имя базы может содержать латинские буквы, цифры, подчеркивание и дефис. Максимальная длина имени 63 символа. Имена `postgres`, `template0`, `template1` зарезервированы для собственных нужд Managed Service for PostgreSQL. Создавать базы с этими именами нельзя.

     Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

     Managed Service for PostgreSQL запустит операцию создания базы данных.

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации базы данных кластера Managed Service for PostgreSQL см. в [документации провайдера Terraform](../../terraform/resources/mdb_postgresql_database.md).

    1. Добавьте ресурс `yandex_mdb_postgresql_database`. При необходимости укажите нужные локали сортировки и набора символов (по умолчанию задаются `LC_COLLATE=C` и `LC_CTYPE=C`) и шаблон:

        ```hcl
        resource "yandex_mdb_postgresql_database" "<имя_БД>" {
          cluster_id  = "<идентификатор_кластера>"
          name        = "<имя_БД>"
          owner       = "<имя_владельца_БД>"
          lc_collate  = "<локаль_сортировки>"
          lc_type     = "<локаль_набора_символов>"
          template_db = "<имя_БД-шаблона>"
          deletion_protection = <защита_от_удаления>
        }
        ```

        Где:
          * `owner` — имя пользователя-владельца, который должен быть задан в ресурсе `yandex_mdb_postgresql_user`.
          * `deletion_protection` — защита БД от удаления: `true`, `false` или `unspecified` (наследует значение от кластера). Значение по умолчанию — `unspecified`.

        Имя базы может содержать латинские буквы, цифры, подчеркивание и дефис. Максимальная длина имени 63 символа. Имена `postgres`, `template0`, `template1` зарезервированы для собственных нужд Managed Service for PostgreSQL. Создавать базы с этими именами нельзя.

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

  {% note warning %}

  После создания БД не меняйте ее владельца в параметре `owner` — это приведет к пересозданию БД и потере данных.

  {% endnote %}

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
       --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/<идентификатор_кластера>/databases' \
       --data '{
                 "databaseSpec": {
                   "name": "<имя_БД>",
                   "owner": "<имя_владельца_БД>",
                   "lcCollate": "<локаль_сортировки>",
                   "lcCtype": "<локаль_набора_символов>",
                   "extensions": [
                     {
                       "name": "<имя_расширения>"
                     }
                   ],
                   "deletionProtection": <защита_от_удаления>
                 }
               }'
     ```

     Где `databaseSpec` — объект, содержащий настройки новой БД. Имеет следующую структуру:

     * `name` — имя БД.

       Имя базы может содержать латинские буквы, цифры, подчеркивание и дефис. Максимальная длина имени 63 символа. Имена `postgres`, `template0`, `template1` зарезервированы для собственных нужд Managed Service for PostgreSQL. Создавать базы с этими именами нельзя.

     * `owner` — имя владельца БД.
     * `lcCollate` — локаль сортировки. Значение по умолчанию — `C`.
     * `lcCtype` — локаль набора символов. Значение по умолчанию — `C`.
     * `extensions` — массив расширений БД. Один элемент массива содержит настройки для одного расширения и имеет следующую структуру:

       * `extensions.name` — имя расширения;

       Указывайте имя в соответствии со [списком поддерживаемых расширений и утилит PostgreSQL](extensions/cluster-extensions.md#postgresql).

     * `deletionProtection` — защита БД от удаления: `true`, `false` или `unspecified` (наследует значение от кластера). Значение по умолчанию — `unspecified`.

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
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/database_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "database_spec": {
               "name": "<имя_БД>",
               "owner": "<имя_владельца_БД>",
               "lc_collate": "<локаль_сортировки>",
               "lc_ctype": "<локаль_набора_символов>",
               "extensions": [
                 {
                   "name": "<имя_расширения>"
                 }
               ],
               "deletion_protection": <защита_от_удаления>
             }
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.postgresql.v1.DatabaseService.Create
     ```

     Где `database_spec` — параметры новой БД:

     * `name` — имя БД.

       Имя базы может содержать латинские буквы, цифры, подчеркивание и дефис. Максимальная длина имени 63 символа. Имена `postgres`, `template0`, `template1` зарезервированы для собственных нужд Managed Service for PostgreSQL. Создавать базы с этими именами нельзя.

     * `owner` — имя владельца БД.
     * `lc_collate` — локаль сортировки. Значение по умолчанию — `C`.
     * `lc_ctype` — локаль набора символов. Значение по умолчанию — `C`.
     * `extensions` — массив расширений БД. Один элемент массива содержит настройки для одного расширения и имеет следующую структуру:

       * `extensions.name` — имя расширения;

       Указывайте имя в соответствии со [списком поддерживаемых расширений и утилит PostgreSQL](extensions/cluster-extensions.md#postgresql).

     * `deletion_protection` — защита БД от удаления: `true`, `false` или `unspecified` (наследует значение от кластера). Значение по умолчанию — `unspecified`.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Database/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Переименовать базу данных {#rename-db}

{% list tabs group=instructions %}

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

      Полный список доступных для изменения полей конфигурации базы данных кластера Managed Service for PostgreSQL см. в [документации провайдера Terraform](../../terraform/resources/mdb_postgresql_database.md).

  1. Найдите ресурс `yandex_mdb_postgresql_database` нужной базы данных.
  1. Измените значение поля `name`:

      ```hcl
      resource "yandex_mdb_postgresql_database" "<имя_базы данных>" {
        ...
        name     = "<новое_имя_базы_данных>"
        ...
      }
      ```

      Имя базы может содержать латинские буквы, цифры, подчеркивание и дефис. Максимальная длина имени 63 символа. Имена `postgres`, `template0`, `template1` зарезервированы для собственных нужд Managed Service for PostgreSQL. Создавать базы с этими именами нельзя.

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

  1. Воспользуйтесь методом [Database.Update](../api-ref/Database/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

     {% note warning %}
     
     Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
     
     {% endnote %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/<идентификатор_кластера>/databases/<прежнее_имя_БД>' \
       --data '{
                 "updateMask": "newDatabaseName",
                 "newDatabaseName": "<новое_имя_БД>"
               }'
     ```

     Где:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

       В данном случае передается только один параметр.

     * `newDatabaseName` — новое имя БД.

       Имя базы может содержать латинские буквы, цифры, подчеркивание и дефис. Максимальная длина имени 63 символа. Имена `postgres`, `template0`, `template1` зарезервированы для собственных нужд Managed Service for PostgreSQL. Создавать базы с этими именами нельзя.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя БД — со [списком БД в кластере](#list-db).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Database/update.md#yandex.cloud.operation.Operation).

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
  1. Воспользуйтесь вызовом [DatabaseService.Update](../api-ref/grpc/Database/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

     {% note warning %}
     
     Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask` (в виде массива строк `paths[]`).
     
     {% cut "Формат перечисления настроек" %}
     
     ```yaml
     "update_mask": {
         "paths": [
             "<настройка_1>",
             "<настройка_2>",
             ...
             "<настройка_N>"
         ]
     }
     ```
     
     {% endcut %}
     
     {% endnote %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/database_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "database_name": "<прежнее_имя_БД>",
             "update_mask": {
               "paths": [
                 "new_database_name"
               ]
             },
             "new_database_name": "<новое_имя_БД>"
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.postgresql.v1.DatabaseService.Update
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

       В данном случае передается только один параметр.

     * `new_database_name` — новое имя БД.

       Имя базы может содержать латинские буквы, цифры, подчеркивание и дефис. Максимальная длина имени 63 символа. Имена `postgres`, `template0`, `template1` зарезервированы для собственных нужд Managed Service for PostgreSQL. Создавать базы с этими именами нельзя.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя БД — со [списком БД в кластере](#list-db).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Database/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Настроить защиту от удаления {#update-db-deletion-protection}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Базы данных**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужной БД и выберите пункт **Настроить**.
  1. Выберите нужное значение в поле **Защита от удаления**.
  1. Нажмите кнопку **Сохранить**.

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

  1. Найдите ресурс `yandex_mdb_postgresql_database` нужной БД.

  1. Добавьте параметр `deletion_protection`. Доступные значения: `true`, `false` или `unspecified` (наследует значение от кластера). Значение по умолчанию — `unspecified`.

        ```hcl
        resource "yandex_mdb_postgresql_database" "<имя_базы_данных>" {
          ...
          deletion_protection = <защита_от_удаления>
          ...
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

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Воспользуйтесь методом [Database.Update](../api-ref/Database/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

     {% note warning %}
     
     Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
     
     {% endnote %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/<идентификатор_кластера>/databases/<имя_БД>' \
       --data '{
                 "updateMask": "deletionProtection",
                 "deletionProtection": <защита_от_удаления>
               }'
     ```

     Где:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

       В данном случае передается только один параметр.

     * `deletionProtection` — защита БД от удаления: `true`, `false` или `unspecified` (наследует значение от кластера). Значение по умолчанию — `unspecified`.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя БД — со [списком БД в кластере](#list-db).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Database/update.md#yandex.cloud.operation.Operation).

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
  1. Воспользуйтесь вызовом [DatabaseService.Update](../api-ref/grpc/Database/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

     {% note warning %}
     
     Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask` (в виде массива строк `paths[]`).
     
     {% cut "Формат перечисления настроек" %}
     
     ```yaml
     "update_mask": {
         "paths": [
             "<настройка_1>",
             "<настройка_2>",
             ...
             "<настройка_N>"
         ]
     }
     ```
     
     {% endcut %}
     
     {% endnote %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/database_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "database_name": "<имя_БД>",
             "update_mask": {
               "paths": [
                 "deletion_protection"
               ]
             },
             "deletion_protection": <защита_от_удаления>
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.postgresql.v1.DatabaseService.Update
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

       В данном случае передается только один параметр.

     * `deletion_protection` — защита БД от удаления: `true`, `false` или `unspecified` (наследует значение от кластера). Значение по умолчанию — `unspecified`.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя БД — со [списком БД в кластере](#list-db).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Database/update.md#yandex.cloud.operation.Operation).

{% endlist %}

{% note warning %}

Защита от удаления действует только на уровне конкретной БД. При удалении кластера будут удалены все БД, в том числе защищенные от удаления.

{% endnote %}

## Удалить базу данных {#remove-db}

БД может быть защищена от удаления. Чтобы удалить такую БД, сперва [снимите защиту](#update-db-deletion-protection).

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы удалить базу данных:
  1. Перейдите в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Базы данных**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужной БД, выберите пункт **Удалить** и подтвердите удаление.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы удалить базу данных, выполните команду:

  ```bash
  yc managed-postgresql database delete <имя_БД> \
     --cluster-name <имя_кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

- Terraform {#tf}

  Чтобы удалить базу данных:
  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

     Полный список доступных для изменения полей конфигурации базы данных кластера Managed Service for PostgreSQL см. в [документации провайдера Terraform](../../terraform/resources/mdb_postgresql_database.md).

  1. Удалите ресурс `yandex_mdb_postgresql_database` с именем удаляемой базы данных.

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

  1. Воспользуйтесь методом [Database.Delete](../api-ref/Database/delete.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/<идентификатор_кластера>/databases/<имя_БД>'
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
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/database_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "database_name": "<имя_БД>"
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.postgresql.v1.DatabaseService.Delete
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя БД — со [списком БД в кластере](#list-db).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Database/delete.md#yandex.cloud.operation.Operation).

{% endlist %}

{% note warning %}

Прежде чем создать новую базу с тем же именем, дождитесь завершения операции удаления, иначе будет восстановлена удаляемая база. Статус операции можно получить вместе со [списком операций в кластере](cluster-list.md#list-operations).

{% endnote %}