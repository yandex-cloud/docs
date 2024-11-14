# Разработка пользовательской интеграции в {{ api-gw-name }}


С помощью serverless-технологий можно создать собственную интеграцию с сервисами {{ yandex-cloud }}.

Пользовательская интеграция представляет собой [функцию](../../functions/concepts/function.md) {{ sf-full-name }} или [контейнер](../../serverless-containers/concepts/container.md) {{ serverless-containers-full-name }}, которые предназначены для решения типовой задачи.

Функция или контейнер могут быть сконфигурированы в спецификации [API-шлюза](../../api-gateway/concepts/) {{ api-gw-name }} по стандарту [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification) для выполнения определенных HTTP-запросов.

Разработайте функцию-интеграцию с {{ ydb-full-name }} для работы с [СУБД {{ ydb-short-name }}](../../ydb/concepts/#ydb). Функция будет взаимодействовать с {{ ydb-name }} и обрабатывать внешние HTTP-запросы через API-шлюз с использованием [HTTP API](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/Welcome.html), совместимого с [Amazon DynamoDB](https://aws.amazon.com/ru/dynamodb/). Язык кода функции — TypeScript, среда выполнения — Node.js 16.

Интеграция будет применена для реализации [CRUD](https://ru.wikipedia.org/wiki/CRUD) API для работы с базой данных фильмов, развернутой в {{ ydb-name }}.

Чтобы развернуть проект:
1. [Настройте окружение](#setup-environment).
1. [Скачайте проект с интеграцией](#download-project).
1. [Скомпилируйте функцию](#compile-function).
1. [Загрузите файл функции в бакет](#upload-to-bucket).
1. [Подготовьте конфигурацию ресурсов для интеграции](#prepare-configuration).
1. [Разверните ресурсы для интеграции](#deploy-resources).
1. [Проверьте работу созданного CRUD API](#test-api).

Если созданные ресурсы больше не нужны, [удалите](#clear-out) их.

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость ресурсов для интеграции входят:
* Плата за объем хранилища, занятый данными, количество операций с данными и исходящий трафик (см. [тарифы {{ objstorage-full-name }}](../../storage/pricing.md)).
* Плата за операции с {{ ydb-short-name }} и хранение данных (см. [тарифы {{ ydb-name }} в бессерверном режиме](../../ydb/pricing/serverless.md)).
* Плата за количество вызовов функции, вычислительные ресурсы, выделенные для выполнения функции, и исходящий трафик (см. [тарифы {{ sf-name }}](../../functions/pricing.md)).
* Плата за количество запросов к API-шлюзу и исходящий трафик (см. [тарифы {{ api-gw-name }}](../../api-gateway/pricing.md)).

## Настройте окружение {#setup-environment}

{% list tabs group=operating_system %}

- Windows {#windows}

  1. [Установите утилиту WSL](https://docs.microsoft.com/ru-ru/windows/wsl/install) для использования окружения Linux.
  1. Запустите подсистему Linux (по умолчанию — Ubuntu).
  1. Настройте окружение так, как описано в инструкции для операционной системы Linux.

- Linux {#linux}

  {% note info %}

  Если вы используете дистрибутив, отличный от Ubuntu, установите указанные утилиты с помощью команд вашего пакетного менеджера.

  {% endnote %}

  1. Последовательно установите следующие утилиты с помощью команд в терминале:
     * [Curl](https://curl.se/) и [Git](https://git-scm.com/):

       ```bash
       sudo apt-get install curl git -y
       ```

     * [WebStorm](https://www.jetbrains.com/ru-ru/webstorm/) или другая [среда разработки с поддержкой TypeScript](https://ru.wikipedia.org/wiki/TypeScript#IDE_и_поддержка_редакторов):

       ```bash
       sudo snap install webstorm --classic
       ```

     * [Node.js](https://nodejs.org/ru/) не ниже версии `16.9.1`:

       ```bash
       curl --silent --location https://deb.nodesource.com/setup_16.x | sudo -E bash
       sudo apt-get install nodejs
       node -v
       npm -v
       ```

     * [TypeScript](https://www.typescriptlang.org/):

       ```bash
       sudo npm install -g typescript
       ```

     * [{{ yandex-cloud }} CLI](../../cli/quickstart.md):

       ```bash
       curl https://{{ s3-storage-host-cli }}{{ yc-install-path }} | bash
       exec -l $SHELL
       yc version
       ```

     * [AWS CLI](https://aws.amazon.com/ru/cli/):

       ```bash
       curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" --output "awscliv2.zip"
       unzip awscliv2.zip
       sudo ./aws/install
       ```



  1. [Установите](../../tutorials/infrastructure-management/terraform-quickstart.md#from-yc-mirror) {{ TF }} не ниже версии `1.0.8`.


  1. [Создайте](../../cli/operations/profile/profile-create.md#interactive-create) профиль {{ yandex-cloud }} CLI с базовыми параметрами.
  1. [Настройте](../../ydb/docapi/tools/aws-setup.md) AWS CLI.

- macOS {#macos}

  1. Последовательно установите следующие утилиты с помощью команд в терминале:
     * [Homebrew](https://brew.sh):

       ```bash
       /bin/bash -c "$(curl --fail --silent --show-error --location https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
       ```

     * [Curl](https://curl.se/) и [Git](https://git-scm.com/):

       ```bash
       brew install curl git
       ```

     * [WebStorm](https://www.jetbrains.com/ru-ru/webstorm/) или другая [среда разработки с поддержкой TypeScript](https://ru.wikipedia.org/wiki/TypeScript#IDE_и_поддержка_редакторов):

       ```bash
       brew install --cask webstorm
       ```

     * [Node.js](https://nodejs.org/ru/) не ниже версии `16.9.1`:

       ```bash
       brew install node
       node -v
       npm -v
       ```

     * [TypeScript](https://www.typescriptlang.org/):

       ```bash
       npm install -g typescript
       ```

     * [{{ yandex-cloud }} CLI](../../cli/quickstart.md):

       ```bash
       curl https://{{ s3-storage-host-cli }}{{ yc-install-path }} | bash
       exec -l $SHELL
       yc version
       ```

     * [AWS CLI](https://aws.amazon.com/ru/cli/):

       ```bash
       curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" --output "AWSCLIV2.pkg"
       sudo installer -pkg AWSCLIV2.pkg -target /
       ```



  1. [Установите](../../tutorials/infrastructure-management/terraform-quickstart.md#from-yc-mirror) {{ TF }} не ниже версии `1.0.8`.


  1. [Создайте](../../cli/operations/profile/profile-create.md#interactive-create) профиль с базовыми параметрами.
  1. [Настройте](../../ydb/docapi/tools/aws-setup.md) AWS CLI.

{% endlist %}

## Скачайте проект с интеграцией {#download-project}

Склонируйте репозиторий с проектом для интеграции:

```bash
git clone https://github.com/yandex-cloud-examples/yc-serverless-apigw-dynamodb-connector.git
```

В директории `src` находятся исходные файлы для создания функции:
* [event.ts](https://github.com/yandex-cloud-examples/yc-serverless-apigw-dynamodb-connector/blob/main/src/event.ts) — код интерфейса `Event`, описывающий [структуру запроса](../../api-gateway/concepts/extensions/cloud-functions.md#request_v1), и интерфейса `RequestContext`, описывающий контекст запроса.
* [dynamodb.ts](https://github.com/yandex-cloud-examples/yc-serverless-apigw-dynamodb-connector/blob/main/src/dynamodb.ts) — код обработки вызова функции и основных команд.
* [iam.ts](https://github.com/yandex-cloud-examples/yc-serverless-apigw-dynamodb-connector/blob/main/src/iam.ts) — код получения [IAM-токенов](../../iam/concepts/authorization/iam-token.md), необходимых для авторизации при запросах к {{ ydb-short-name }}.

При вызове функции в файле [dynamodb.ts](https://github.com/yandex-cloud-examples/yc-serverless-apigw-dynamodb-connector/blob/main/src/dynamodb.ts) в поле `requestContext.apiGateway.operationContext` объекта `event` передается контекст операции.

Контекст операции определяется в параметре [`context`](../../api-gateway/concepts/extensions/cloud-functions.md#parameters) в спецификации [API-шлюза](../../api-gateway/concepts/), вызывающего функцию-интеграцию.

{% note info %}

При интеграции с помощью [контейнера](../../serverless-containers/concepts/container.md) контекст операции передается через специальный заголовок [`X-Yc-ApiGateway-Operation-Context`](../../api-gateway/concepts/extensions/containers.md#parameters).

{% endnote %}

В файле [event.ts](https://github.com/yandex-cloud-examples/yc-serverless-apigw-dynamodb-connector/blob/main/src/event.ts) определены интерфейсы для основных команд Amazon DynamoDB и их параметров, которые будут реализованы в данной интеграции. Это нужно для спецификации формата контекста операции и работы с ним внутри функции.

## Скомпилируйте функцию {#compile-function}

1. Откройте терминал и перейдите в корневую директорию проекта:

   ```bash
   cd <путь_к_корневой_директории_проекта>
   ```

1. Установите необходимые проекту зависимости:

   ```bash
   npm ci
   ```

1. Выполните компиляцию и сборку кода функции:

   ```bash
   npm run build
   ```

1. Упакуйте собранный код функции в ZIP-архив:
  
   ```bash
   npm run package
   ```

## Загрузите файл функции в бакет {#upload-to-bucket}

1. [Создайте](../../storage/operations/buckets/create.md) бакет с публичным доступом. Сохраните имя бакета, оно потребуется в дальнейшем.
1. [Загрузите](../../storage/operations/objects/upload.md) в бакет ZIP-архив `apigw-dynamodb-connector-0.0.1.zip` с кодом функции из директории `build`.

## Подготовьте конфигурацию ресурсов для интеграции {#prepare-configuration}

Для развертывания CRUD API с помощью функции-интеграции будет использоваться инструмент [{{ TF }}](https://www.terraform.io).

Специальный [{{ TF }}-модуль](https://github.com/yandex-cloud-examples/yc-serverless-ydb-api), разработанный для этого примера интеграции, упрощает процесс конфигурации ресурсов {{ yandex-cloud }}. Создаваемые {{ TF }} ресурсы:
* Бессерверная база данных {{ ydb-short-name }}.
* Функция-интеграция.
* Сервисный аккаунт для доступа функции к базе данных.
* API-шлюз.

Чтобы подготовить конфигурационные файлы для {{ TF }}:
1. Узнайте имя активного профиля (`ACTIVE`) интерфейса командной строки {{ yandex-cloud }} CLI. В терминале выполните команду:

   ```bash
   yc config profile list
   ```

1. Получите параметры активного профиля:

   ```bash
   yc config profile get <имя_профиля>
   ```

   Сохраните полученные параметры:
   * `token` — [OAuth-токен](../../iam/concepts/authorization/oauth-token.md).
   * `cloud-id` — идентификатор [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud).
   * `folder-id` — идентификатор [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder).
1. Создайте директорию `crud-api` и перейдите в нее:

   ```bash
   mkdir crud-api
   cd crud-api
   ```

   В дальнейшем все команды {{ TF }} выполняйте в директории `crud-api`.
1. Создайте файл `main.tf` и скопируйте в него конфигурацию {{ TF }}-модуля. Укажите параметры создаваемых ресурсов:
   * `cloud_id` — идентификатор облака.
   * `folder_id` — идентификатор каталога.
   * `oauth_token` — OAuth-токен.
   * `database_connector_bucket` — имя бакета с функцией-интеграцией.

   ```hcl
   locals {
     cloud_id    = "<идентификатор_облака>"
     folder_id   = "<идентификатор_каталога>"
     oauth_token = "<OAuth-токен>"
     zone        = "{{ region-id }}-d"
   }

   module "crud-api" {
     source = "github.com/yandex-cloud-examples/yc-serverless-ydb-api"

     folder_id                 = local.folder_id
     api_name                  = "movies-api"
     database_name             = "movies-db"
     service_account_name      = "movies-api-service-account"
     region                    = "region-id"
     openapi_spec              = "api.yaml"
     table_specs               = ["file://table.json"]
     database_connector_bucket = "<имя_бакета_с_функцией-интеграцией>"
     database_connector_object = "apigw-dynamodb-connector-0.0.1.zip"
   }

   terraform {
     required_providers {
       yandex = {
         source = "yandex-cloud/yandex"
       }
       null   = {
         source = "registry.terraform.io/hashicorp/null"
       }
     }
     required_version = ">= 0.13"
   }

   provider "yandex" {
     token     = local.oauth_token
     cloud_id  = local.cloud_id
     folder_id = local.folder_id
     zone      = local.zone
   }

   output "crud_api_domain" {
     value = module.crud-api.api_gateway_domain
   }
   ```

1. Создайте файл `table.json` и скопируйте в него спецификацию схемы таблицы создаваемой {{ ydb-short-name }}:

   ```json
   {
     "TableName": "movie",
     "KeySchema": [
       {
         "AttributeName": "id",
         "KeyType": "HASH"
       }
     ],
     "AttributeDefinitions": [
       {
         "AttributeName": "id",
         "AttributeType": "S"
       },
       {
         "AttributeName": "title",
         "AttributeType": "S"
       },
       {
         "AttributeName": "year",
         "AttributeType": "N"
       }
     ]
   }
   ```

1. Создайте файл `api.yaml` и скопируйте в него OpenAPI-спецификацию создаваемого API-шлюза:

   ```yaml
   openapi: "3.0.0"
   info:
     version: 1.0.0
     title: Movies API
   x-yc-apigateway:
     service_account_id: ${SERVICE_ACCOUNT_ID}

   paths:
     /movies:
       post:
         description: Create movie
         operationId: createMovie
         requestBody:
           description: Movie to create
           required: true
           content:
             application/json:
               schema:
                 $ref: '#/components/schemas/Movie'
         responses:
           '200':
             description: Created or updated movie
             content:
               application/json:
                 schema:
                   $ref: '#/components/schemas/Movie'
           default:
             description: error
             content:
               application/json:
                 schema:
                   $ref: '#/components/schemas/Error'
         x-yc-apigateway-integration:
           type: cloud_functions
           function_id: ${FUNCTION_ID}
           context:
             command: PutItem
             endpoint: ${DATABASE_ENDPOINT}
             tableName: movie
       get:
         description: Get movies
         operationId: getMovies
         parameters:
           - name: from
             in: query
             description: Identifier from which will be queried movies in ascending order
             required: true
             schema:
               type: string
           - name: limit
             in: query
             description: Maximum number of movies in response
             required: false
             schema:
               type: number
               default: 10
         responses:
           '200':
            description: Movies
             content:
               application/json:
                 schema:
                   type: array
                   items:
                     $ref: '#/components/schemas/Movie'
           default:
             description: error
             content:
               application/json:
                 schema:
                   $ref: '#/components/schemas/Error'
         x-yc-apigateway-integration:
           type: cloud_functions
           function_id: ${FUNCTION_ID}
           context:
             command: Scan
             endpoint: ${DATABASE_ENDPOINT}
             tableName: movie
             limit: '{limit}'
             exclusiveStartKey: '{"id": "{from}"}'
     /movies/{movieId}:
       parameters:
         - name: movieId
           in: path
           description: Identifier of movie
           required: true
           schema:
             type: string
       get:
         description: Get movie by id
         operationId: getMovieById
         responses:
           '200':
             description: Movie
             content:
               application/json:
                 schema:
                   $ref: '#/components/schemas/Movie'
           default:
             description: error
             content:
               application/json:
                 schema:
                   $ref: '#/components/schemas/Error'
         x-yc-apigateway-integration:
           type: cloud_functions
           function_id: ${FUNCTION_ID}
           context:
             command: GetItem
             endpoint: ${DATABASE_ENDPOINT}
             tableName: movie
             key: '{"id": "{movieId}"}'
       put:
         description: Update movie by id
         operationId: updateMovieById
         requestBody:
           description: Movie or attributes to update
           required: true
           content:
             application/json:
               schema:
                 $ref: '#/components/schemas/Movie'
         responses:
           '200':
             description: Updated movie
             content:
               application/json:
                 schema:
                   $ref: '#/components/schemas/Movie'
           default:
             description: error
             content:
               application/json:
                 schema:
                   $ref: '#/components/schemas/Error'
         x-yc-apigateway-integration:
           type: cloud_functions
           function_id: ${FUNCTION_ID}
           context:
             command: UpdateItem
             endpoint: ${DATABASE_ENDPOINT}
             tableName: movie
             key: '{"id": "{movieId}"}'
       delete:
         description: Delete movie by id
         operationId: deleteMovieById
         responses:
           '200':
             description: Deleted movie
             content:
               application/json:
                 schema:
                   $ref: '#/components/schemas/Movie'
           default:
             description: error
             content:
               application/json:
                 schema:
                   $ref: '#/components/schemas/Error'
         x-yc-apigateway-integration:
           type: cloud_functions
           function_id: ${FUNCTION_ID}
           context:
             command: DeleteItem
             endpoint: ${DATABASE_ENDPOINT}
             tableName: movie
             key: '{"id": "{movieId}"}'
   components:
     schemas:
       Movie:
         type: object
         required:
           - id
           - title
           - year
         properties:
           id:
             type: string
           title:
             type: string
           year:
             type: integer

       Error:
         type: object
         required:
           - message
         properties:
           message:
             type: string
   ```

## Разверните ресурсы для интеграции {#deploy-resources}

1. Инициализируйте {{ TF }}. В терминале выполните команду:

   ```bash
   terraform init
   ```

1. Разверните облачные ресурсы:

   ```bash
   terraform apply
   ```

1. Подтвердите создание ресурсов: введите в терминале `yes` и нажмите **Enter**.

   В выводе команды в переменной `crud_api_domain` будет указан доменный адрес созданного CRUD API. Сохраните этот адрес, он потребуется в дальнейшем.

   Проверить созданные ресурсы можно в [консоли управления]({{ link-console-main }}).

## Проверьте работу созданного CRUD API {#test-api}

Для проверки работы созданного CRUD API выполните следующие HTTP-запросы:
1. Добавьте информацию о фильме. В терминале выполните команду:

   ```bash
   curl \
     --location \
     --request POST 'https://<доменный_адрес_CRUD_API>/movies' \
     --header 'Content-Type: application/json' \
     --data-raw '{
       "id": "301",
       "title": "The Matrix",
       "year": 1999
     }'
   ```

1. Получите информацию о фильме:

   ```bash
   curl \
     --location \
     --request GET 'https://<доменный_адрес_CRUD_API>/movies/301'
   ```

1. Измените информацию о фильме:

   ```bash
   curl \
     --location \
     --request PUT 'https://<доменный_адрес_CRUD_API>/movies/301' \
     --header 'Content-Type: application/json' \
     --data-raw '{
       "title": "Матрица"
     }'
   ```

1. Добавьте информацию о другом фильме:

   ```bash
   curl \
     --location \
     --request POST 'https://<доменный_адрес_CRUD_API>/movies' \
     --header 'Content-Type: application/json' \
     --data-raw '{
       "id": "299",
       "title": "The Matrix Reloaded",
       "year": 2003
     }'
   ```

1. Получите список фильмов:

   ```bash
   curl \
     --location \
     --request GET 'https://<доменный_адрес_CRUD_API>/movies?from=1&limit=5'
   ```

1. Удалите информацию об одном из фильмов:

   ```bash
   curl \
     --location \
     --request DELETE 'https://<доменный_адрес_CRUD_API>/movies/301' \
     --data-raw ''
   ```

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
* Удалите ресурсы, созданные с помощью {{ TF }}. В терминале выполните команду:

  ```bash
  terraform destroy
  ```

  Подтвердите удаление ресурсов: введите в терминале `yes` и нажмите **Enter**.
* [Удалите](../../storage/operations/buckets/delete.md) бакет с файлом функции.