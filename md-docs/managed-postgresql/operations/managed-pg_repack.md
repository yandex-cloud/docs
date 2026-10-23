[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for PostgreSQL](../index.md) > [Пошаговые инструкции](index.md) > Базы данных > Перепаковка данных

# Перепаковка данных в Managed Service for PostgreSQL

{% note info %}

Прежде чем выполнять операции, связанные с перепаковкой таблиц и индексов, убедитесь, что в кластере включена возможность перепаковки. При необходимости [включите](update.md#change-additional-settings) эту опцию в настройках кластера.

{% endnote %}

Перепаковка таблиц и индексов устраняет _раздувание данных_ (bloat).


Получить информацию о состоянии таблиц и индексов можно в [консоли управления](https://console.yandex.cloud) на вкладке **Мониторинг** страницы управления кластером или в сервисе [Yandex Monitoring](../../monitoring/index.md).

[Подробнее о мониторинге состояния кластера PostgreSQL](monitoring.md).

## Получить список рекомендуемых к перепаковке объектов {#recomendations-repack}

Получить список рекомендуемых к перепаковке объектов можно только с помощью консоли управления.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](https://console.yandex.cloud/link/managed-postgresql) в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Перепаковка данных**.
  1. На открывшейся странице перейдите на вкладку **Рекомендации**.
    
      На вкладке отображаются рекомендуемые к перепаковке объекты с наибольшим уровнем раздутия.

      Для каждой базы данных отображается не более 10 объектов, а для всего кластера — не более 1000 объектов. В список включены только объекты, у которых процент раздутия выше 5% или размер раздутия больше 1 ГБ. Вы также можете [выполнить перепаковку объектов, которых нет в списке рекомендуемых](#start-repack-not-recommended).

{% endlist %}

### Отсортировать список рекомендуемых к перепаковке объектов {#sort-recomendations-repack}

Чтобы отсортировать рекомендуемые к перепаковке объекты, на вкладке **Рекомендации** выберите:

* В поле **Тип объекта** — тип отображаемого объекта. Доступные варианты: **Таблица**, **Индекс** или **Все** объекты.
* В поле **Топ по** — метрику, по которой отбираются объекты. Доступные варианты: **Размер** раздутых данных (в байтах) или **Процент** раздутых данных от общего размера объекта.
* В поле **База данных** — базу данных, которой принадлежат объекты.

## Получить список активных перепаковок {#active-repack}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](https://console.yandex.cloud/link/managed-postgresql) в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Перепаковка данных**.
  1. На открывшейся странице перейдите на вкладку **Активные перепаковки**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить список активных перепаковок, выполните команду:

  ```bash
  yc managed-postgresql repack list-running \
    --cluster-name=<имя_кластера>
  ```

  Где `--cluster-name` — имя кластера Yandex Managed Service for PostgreSQL. Вместо имени кластера вы можете передать его идентификатор в параметре `--cluster-id`.

  Имя и идентификатор кластера вы можете получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. Воспользуйтесь методом [ManagedRepack.ListRunningRepacks](../api-ref/ManagedRepack/listRunningRepacks.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/<идентификатор_кластера>:managedRepack_list_running'
      ```

      Идентификатор кластера вы можете получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/ManagedRepack/listRunningRepacks.md#yandex.cloud.mdb.postgresql.v1.ListRunningRepacksResponse).

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
  1. Воспользуйтесь вызовом [ManagedRepackService.ListRunningRepacks](../api-ref/grpc/ManagedRepack/listRunningRepacks.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/managed_repack_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>"
            }' \
        mdb.api.cloud.yandex.net:443 \
        yandex.cloud.mdb.postgresql.v1.ManagedRepackService.ListRunningRepacks
      ```
     
      Идентификатор кластера вы можете получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/ManagedRepack/listRunningRepacks.md#yandex.cloud.mdb.postgresql.v1.ListRunningRepacksResponse).

{% endlist %}

## Запустить перепаковку рекомендуемого объекта {#start-repack}

Вы можете запустить перепаковку одного или нескольких объектов. Если объектов несколько, они должны быть одного типа.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](https://console.yandex.cloud/link/managed-postgresql) в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Перепаковка данных**.
  1. На открывшейся странице перейдите на вкладку **Рекомендации**.
  1. Выберите один или несколько объектов для перепаковки и внизу экрана нажмите **Запустить перепаковку**.
  1. Подтвердите запуск перепаковки.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. [Получите](#recomendations-repack) список рекомендуемых к перепаковке объектов.
  1. Выполните команду:
     
     ```bash
     yc managed-postgresql repack launch \
       --cluster-name <имя_кластера> \
       --database <имя_базы_данных> \
       --type <тип_объектов> \
       --target '<схема_1>.<имя_объекта_1>','<имя_объекта_2>',...,'<имя_объекта_n>' \
       --target '<схема_2>.<имя_объекта_1>','<имя_объекта_2>',...,'<имя_объекта_m>'
     ```
     
     Где:
     
     * `--cluster-name` — имя кластера Yandex Managed Service for PostgreSQL.
     
         Вместо имени кластера вы можете передать его идентификатор в параметре `--cluster-id`.
     
         Имя и идентификатор кластера вы можете получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
     * `--database` — имя базы данных, в которой находятся целевые объекты.
     * `--type` — тип объектов, которые вы собираетесь перепаковывать. В одной команде можно передать только объекты одного типа. Возможные значения:
     
         * `table` — таблица.
         * `index` — индекс.
     * `--target` — список объектов в формате `<схема>.<имя_объекта>`. Несколько объектов можно передать через запятую.
     
         Чтобы передать все объекты в схеме, используйте символ подстановки `*`. Например: `public.*`.
     
         В одной команде YC CLI вы можете задать одновременно несколько целей.
     
     {% cut "Пример команды" %}
     
     ```bash
     yc managed-postgresql repack launch \
       --cluster-id c9qbr99vea28******** \
       --database db1 \
       --type table \
       --target 'public.products','customers','employees'
     ```
     
     Результат:
     
     ```text
     running:
       cluster_id: c9qbr99vea28********
       start_time: "2026-10-21T19:08:45Z"
       spec:
         type: REPACK_TYPE_TABLE
         dbname: db1
         targets:
           - schema: public
             name: products,customers,employees
       launch_id: 68d917ca-ebc1-4725-84c7-9a29********
     ```
     
     {% endcut %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. [Получите](#recomendations-repack) список рекомендуемых к перепаковке объектов.
  1. Воспользуйтесь методом [ManagedRepack.LaunchRepack](../api-ref/ManagedRepack/launchRepack.md) и выполните запрос, например с помощью [cURL](https://curl.se/):
     
     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/<идентификатор_кластера>:managedRepack_launch' \
       --data '{
                 "spec": {
                   "type": "<тип_объектов>",
                   "dbname": "<имя_базы_данных>",
                   "targets": [
                     {
                       "schema": "<схема>",
                       "name": "<имя_объекта_1>"
                     },
                     {
                       "schema": "<схема>",
                       "name": "<имя_объекта_2>"
                     },
                     ...
                     {
                       "schema": "<схема>",
                       "name": "<имя_объекта_n>"
                     }
                   ]
                 }
               }'
     ```
     
     Где:
     
     * `<идентификатор_кластера>` — идентификатор кластера Yandex Managed Service for PostgreSQL.
     
         Идентификатор кластера вы можете получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
     * `type` — тип объектов, которые вы собираетесь перепаковывать. В одном запросе можно передать только объекты одного типа. Возможные значения:
     
         * `REPACK_TYPE_TABLE` — таблица.
         * `REPACK_TYPE_INDEX` — индекс.
     * `dbname` — имя базы данных, в которой находятся целевые объекты.
     * `targets` — список целевых объектов:
         * `schema` — схема, к которой относится целевой объект.
         * `name` — имя объекта.
     
             Чтобы указать все объекты в схеме, вместо имени передайте в запросе строку `"allInSchema": true`.
     
     {% cut "Пример запроса" %}
     
     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/c9qbr99vea28********:managedRepack_launch' \
       --data '{
                 "spec": {
                   "type": "REPACK_TYPE_TABLE",
                   "dbname": "db1",
                   "targets": [
                     {
                       "schema": "public",
                       "allInSchema": true
                     }
                   ]
                 }
               }' \
       | jq
     ```
     
     Результат:
     
     ```json
     {
       "running": {
         "clusterId": "c9qbr99vea28********",
         "startTime": "2026-10-21T19:30:33Z",
         "spec": {
           "type": "REPACK_TYPE_TABLE",
           "dbname": "db1",
           "targets": [
             {
               "schema": "public",
               "allInSchema": true
             }
           ]
         },
         "launchId": "14f218d0-63e6-4eb8-9fbc-1fdd********"
       }
     }
     ```
     
     {% endcut %}  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/ManagedRepack/launchRepack.md#yandex.cloud.mdb.postgresql.v1.LaunchRepackResponse).

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
  1. [Получите](#recomendations-repack) список рекомендуемых к перепаковке объектов.
  1. Воспользуйтесь вызовом [ManagedRepackService.LaunchRepack](../api-ref/grpc/ManagedRepack/launchRepack.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):
     
     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/managed_repack_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "spec": {
               "type": "<тип_объектов>",
               "dbname": "<имя_базы_данных>",
               "targets": [
                 {
                   "schema": "<схема>",
                   "name": "<имя_объекта_1>"
                 },
                 {
                   "schema": "<схема>",
                   "name": "<имя_объекта_2>"
                 },
                 ...
                 {
                   "schema": "<схема>",
                   "name": "<имя_объекта_n>"
                 }
               ]
             }
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.postgresql.v1.ManagedRepackService.LaunchRepack
     ```
     
     Где:
     
     * `cluster_id` — идентификатор кластера Yandex Managed Service for PostgreSQL.
     
         Идентификатор кластера вы можете получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
     * `type` — тип объектов, которые вы собираетесь перепаковывать. В одном запросе можно передать только объекты одного типа. Возможные значения:
     
         * `REPACK_TYPE_TABLE` — таблица.
         * `REPACK_TYPE_INDEX` — индекс.
     * `dbname` — имя базы данных, в которой находятся целевые объекты.
     * `targets` — список целевых объектов:
         * `schema` — схема, к которой относится целевой объект.
         * `name` — имя объекта.
     
             Чтобы указать все объекты в схеме, вместо имени передайте в запросе строку `"all_in_schema": true`.
     
     {% cut "Пример вызова" %}
     
     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/managed_repack_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "c9qbr99vea28********",
             "spec": {
               "type": "REPACK_TYPE_TABLE",
               "dbname": "db1",
               "targets": [
                 {
                   "schema": "public",
                   "name": "customers"
                 },
                 {
                   "schema": "public",
                   "name": "employees"
                 },
                 {
                   "schema": "public",
                   "name": "products"
                 }
               ]
             }
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.postgresql.v1.ManagedRepackService.LaunchRepack \
       | jq
     ```
     
     Результат:
     
     ```json
     {
       "running": {
         "clusterId": "c9qbr99vea28********",
         "startTime": "2026-10-22T05:08:24Z",
         "spec": {
           "type": "REPACK_TYPE_TABLE",
           "dbname": "db1",
           "targets": [
             {
               "schema": "public",
               "name": "customers"
             },
             {
               "schema": "public",
               "name": "employees"
             },
             {
               "schema": "public",
               "name": "products"
             }
           ]
         },
         "launchId": "983d1818-63c5-4313-a427-18cb********"
       }
     }
     ```
     
     {% endcut %}
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/ManagedRepack/launchRepack.md#yandex.cloud.mdb.postgresql.v1.LaunchRepackResponse).

{% endlist %}

## Запустить перепаковку объекта, которого нет в списке рекомендуемых {#start-repack-not-recommended}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](https://console.yandex.cloud/link/managed-postgresql) в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Перепаковка данных**.
  1. В правом верхнем углу страницы нажмите кнопку **Запустить перепаковку**.
  1. Выберите тип объекта для перепаковки и укажите одно или несколько имен объектов.
  1. Нажмите кнопку **Запустить перепаковку**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Выполните команду:
  
  ```bash
  yc managed-postgresql repack launch \
    --cluster-name <имя_кластера> \
    --database <имя_базы_данных> \
    --type <тип_объектов> \
    --target '<схема_1>.<имя_объекта_1>','<имя_объекта_2>',...,'<имя_объекта_n>' \
    --target '<схема_2>.<имя_объекта_1>','<имя_объекта_2>',...,'<имя_объекта_m>'
  ```
  
  Где:
  
  * `--cluster-name` — имя кластера Yandex Managed Service for PostgreSQL.
  
      Вместо имени кластера вы можете передать его идентификатор в параметре `--cluster-id`.
  
      Имя и идентификатор кластера вы можете получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  * `--database` — имя базы данных, в которой находятся целевые объекты.
  * `--type` — тип объектов, которые вы собираетесь перепаковывать. В одной команде можно передать только объекты одного типа. Возможные значения:
  
      * `table` — таблица.
      * `index` — индекс.
  * `--target` — список объектов в формате `<схема>.<имя_объекта>`. Несколько объектов можно передать через запятую.
  
      Чтобы передать все объекты в схеме, используйте символ подстановки `*`. Например: `public.*`.
  
      В одной команде YC CLI вы можете задать одновременно несколько целей.
  
  {% cut "Пример команды" %}
  
  ```bash
  yc managed-postgresql repack launch \
    --cluster-id c9qbr99vea28******** \
    --database db1 \
    --type table \
    --target 'public.products','customers','employees'
  ```
  
  Результат:
  
  ```text
  running:
    cluster_id: c9qbr99vea28********
    start_time: "2026-10-21T19:08:45Z"
    spec:
      type: REPACK_TYPE_TABLE
      dbname: db1
      targets:
        - schema: public
          name: products,customers,employees
    launch_id: 68d917ca-ebc1-4725-84c7-9a29********
  ```
  
  {% endcut %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. [Получите](#recomendations-repack) список рекомендуемых к перепаковке объектов.
  1. Воспользуйтесь методом [ManagedRepack.LaunchRepack](../api-ref/ManagedRepack/launchRepack.md) и выполните запрос, например с помощью [cURL](https://curl.se/):
     
     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/<идентификатор_кластера>:managedRepack_launch' \
       --data '{
                 "spec": {
                   "type": "<тип_объектов>",
                   "dbname": "<имя_базы_данных>",
                   "targets": [
                     {
                       "schema": "<схема>",
                       "name": "<имя_объекта_1>"
                     },
                     {
                       "schema": "<схема>",
                       "name": "<имя_объекта_2>"
                     },
                     ...
                     {
                       "schema": "<схема>",
                       "name": "<имя_объекта_n>"
                     }
                   ]
                 }
               }'
     ```
     
     Где:
     
     * `<идентификатор_кластера>` — идентификатор кластера Yandex Managed Service for PostgreSQL.
     
         Идентификатор кластера вы можете получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
     * `type` — тип объектов, которые вы собираетесь перепаковывать. В одном запросе можно передать только объекты одного типа. Возможные значения:
     
         * `REPACK_TYPE_TABLE` — таблица.
         * `REPACK_TYPE_INDEX` — индекс.
     * `dbname` — имя базы данных, в которой находятся целевые объекты.
     * `targets` — список целевых объектов:
         * `schema` — схема, к которой относится целевой объект.
         * `name` — имя объекта.
     
             Чтобы указать все объекты в схеме, вместо имени передайте в запросе строку `"allInSchema": true`.
     
     {% cut "Пример запроса" %}
     
     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/c9qbr99vea28********:managedRepack_launch' \
       --data '{
                 "spec": {
                   "type": "REPACK_TYPE_TABLE",
                   "dbname": "db1",
                   "targets": [
                     {
                       "schema": "public",
                       "allInSchema": true
                     }
                   ]
                 }
               }' \
       | jq
     ```
     
     Результат:
     
     ```json
     {
       "running": {
         "clusterId": "c9qbr99vea28********",
         "startTime": "2026-10-21T19:30:33Z",
         "spec": {
           "type": "REPACK_TYPE_TABLE",
           "dbname": "db1",
           "targets": [
             {
               "schema": "public",
               "allInSchema": true
             }
           ]
         },
         "launchId": "14f218d0-63e6-4eb8-9fbc-1fdd********"
       }
     }
     ```
     
     {% endcut %}  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/ManagedRepack/launchRepack.md#yandex.cloud.mdb.postgresql.v1.LaunchRepackResponse).

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
  1. [Получите](#recomendations-repack) список рекомендуемых к перепаковке объектов.
  1. Воспользуйтесь вызовом [ManagedRepackService.LaunchRepack](../api-ref/grpc/ManagedRepack/launchRepack.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):
     
     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/managed_repack_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "spec": {
               "type": "<тип_объектов>",
               "dbname": "<имя_базы_данных>",
               "targets": [
                 {
                   "schema": "<схема>",
                   "name": "<имя_объекта_1>"
                 },
                 {
                   "schema": "<схема>",
                   "name": "<имя_объекта_2>"
                 },
                 ...
                 {
                   "schema": "<схема>",
                   "name": "<имя_объекта_n>"
                 }
               ]
             }
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.postgresql.v1.ManagedRepackService.LaunchRepack
     ```
     
     Где:
     
     * `cluster_id` — идентификатор кластера Yandex Managed Service for PostgreSQL.
     
         Идентификатор кластера вы можете получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
     * `type` — тип объектов, которые вы собираетесь перепаковывать. В одном запросе можно передать только объекты одного типа. Возможные значения:
     
         * `REPACK_TYPE_TABLE` — таблица.
         * `REPACK_TYPE_INDEX` — индекс.
     * `dbname` — имя базы данных, в которой находятся целевые объекты.
     * `targets` — список целевых объектов:
         * `schema` — схема, к которой относится целевой объект.
         * `name` — имя объекта.
     
             Чтобы указать все объекты в схеме, вместо имени передайте в запросе строку `"all_in_schema": true`.
     
     {% cut "Пример вызова" %}
     
     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/managed_repack_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "c9qbr99vea28********",
             "spec": {
               "type": "REPACK_TYPE_TABLE",
               "dbname": "db1",
               "targets": [
                 {
                   "schema": "public",
                   "name": "customers"
                 },
                 {
                   "schema": "public",
                   "name": "employees"
                 },
                 {
                   "schema": "public",
                   "name": "products"
                 }
               ]
             }
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.postgresql.v1.ManagedRepackService.LaunchRepack \
       | jq
     ```
     
     Результат:
     
     ```json
     {
       "running": {
         "clusterId": "c9qbr99vea28********",
         "startTime": "2026-10-22T05:08:24Z",
         "spec": {
           "type": "REPACK_TYPE_TABLE",
           "dbname": "db1",
           "targets": [
             {
               "schema": "public",
               "name": "customers"
             },
             {
               "schema": "public",
               "name": "employees"
             },
             {
               "schema": "public",
               "name": "products"
             }
           ]
         },
         "launchId": "983d1818-63c5-4313-a427-18cb********"
       }
     }
     ```
     
     {% endcut %}  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/ManagedRepack/launchRepack.md#yandex.cloud.mdb.postgresql.v1.LaunchRepackResponse).

{% endlist %}

## Остановить перепаковку {#cancel-repack}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](https://console.yandex.cloud/link/managed-postgresql) в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Перепаковка данных**.
  1. На открывшейся странице перейдите на вкладку **Активные перепаковки**.
  1. В строке нужной перепаковки нажмите на значок ![icon](../../_assets/console-icons/ellipsis.svg) и выберите пункт **Отменить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. [Получите](#active-repack) список активных перепаковок.
  1. Выполните команду:

      ```bash
      yc managed-postgresql repack terminate \
        --cluster-name <имя_кластера> \
        --launch-id <идентификатор_запуска>
      ```

      Где:
      * `--cluster-name` — имя кластера Yandex Managed Service for PostgreSQL. Вместо имени кластера вы можете передать его идентификатор в параметре `--cluster-id`.
            
          Имя и идентификатор кластера вы можете получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
      * `--launch-id` — [идентификатор](#active-repack) запуска перепаковки, которую вы хотите остановить.

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. [Получите](#active-repack) список активных перепаковок.
  1. Воспользуйтесь методом [ManagedRepack.TerminateRepack](../api-ref/ManagedRepack/terminateRepack.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/<идентификатор_кластера>:managedRepack_terminate' \
        --data '{
                  "launchId": "<идентификатор_запуска>"
                }'
      ```

      Где:
      * `<идентификатор_кластера>` — идентификатор кластера, вы можете получить его со [списком кластеров в каталоге](cluster-list.md#list-clusters).
      * `launchId` — [идентификатор](#active-repack) запуска перепаковки, которую вы хотите остановить.
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/ManagedRepack/terminateRepack.md#google.protobuf.Empty).

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
  1. [Получите](#active-repack) список активных перепаковок.
  1. Воспользуйтесь вызовом [ManagedRepackService.TerminateRepack](../api-ref/grpc/ManagedRepack/terminateRepack.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/managed_repack_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>",
              "launch_id": "<идентификатор_запуска>"
            }' \
        mdb.api.cloud.yandex.net:443 \
        yandex.cloud.mdb.postgresql.v1.ManagedRepackService.TerminateRepack
      ```

      Где:
      * `cluster_id` — идентификатор кластера, вы можете получить его со [списком кластеров в каталоге](cluster-list.md#list-clusters).
      * `launch_id` — [идентификатор](#active-repack) запуска перепаковки, которую вы хотите остановить.
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/ManagedRepack/terminateRepack.md#google.protobuf.Empty).

{% endlist %}

## Посмотреть логи активной перепаковки {#log-repack}

Посмотреть логи активной перепаковки можно только с помощью консоли управления.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](https://console.yandex.cloud/link/managed-postgresql) в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Перепаковка данных**.
  1. На открывшейся странице перейдите на вкладку **Активные перепаковки**.
  1. В строке нужной перепаковки нажмите на значок ![icon](../../_assets/console-icons/ellipsis.svg) и выберите пункт **Посмотреть логи**.

      На открывшейся странице будут отображены логи `REPACK` за период времени с начала перепаковки до текущего времени. Чтобы посмотреть подробную информацию о событии, нажмите на интересующую запись в списке.

{% endlist %}

Чтобы посмотреть логи завершенных перепаковок, воспользуйтесь инструкцией [Просмотр логов кластера PostgreSQL](cluster-logs.md).