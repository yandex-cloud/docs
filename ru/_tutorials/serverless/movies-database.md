# Разработка CRUD API для сервиса фильмов

С помощью serverless-технологий можно создать [CRUD]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/CRUD){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Create,_read,_update_and_delete){% endif %} API для сервиса, который хранит данные о фильмах.

Реализация CRUD API использует [контейнер](../../serverless-containers/concepts/container.md) {{ serverless-containers-full-name }}, который предназначен для работы с базой данных фильмов, развернутой в {{ ydb-full-name }}.

Контейнер конфигурируется в спецификации [API-шлюза](../../api-gateway/concepts/index.md) {{ api-gw-full-name }} по стандарту [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification) для выполнения определенных HTTP-запросов.

Контейнер будет взаимодействовать с {{ ydb-name }} и обрабатывать внешние HTTP-запросы через API-шлюз с использованием [HTTP API](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/Welcome.html), совместимого с [Amazon DynamoDB](https://aws.amazon.com/ru/dynamodb/). Язык кода приложения CRUD API — TypeScript, среда выполнения — Node.js 16.

Чтобы развернуть проект:
1. [Настройте окружение](#setup-environment).
1. [Инициализируйте {{ TF }}](#init-terraform).
1. [Создайте базу данных {{ ydb-name }}](#create-database).
1. [Реализуйте CRUD-операции](#implement-operations).
1. [Разработайте REST API](#develop-rest-api).
1. [Проверьте работу созданного CRUD API](#test-api).

Если созданные ресурсы больше не нужны, [удалите](#clear-out) их.

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость ресурсов для работы CRUD API входят:
* Плата за операции с {{ ydb-short-name }} и хранение данных (см. [тарифы {{ ydb-name }} в бессерверном режиме](../../ydb/pricing/serverless.md)).
* Плата за количество вызовов контейнера, вычислительные ресурсы, выделенные для выполнения приложения, и исходящий трафик (см. [тарифы {{ serverless-containers-name }}](../../serverless-containers/pricing.md)).
* Плата за количество запросов к API-шлюзу и исходящий трафик (см. [тарифы {{ api-gw-name }}](../../api-gateway/pricing.md)).

## Настройте окружение {#setup-environment}

{% list tabs %}

- Windows

  1. [Установите утилиту WSL]{% if lang == "ru" %}(https://docs.microsoft.com/ru-ru/windows/wsl/install){% endif %}{% if lang == "en" %}(https://docs.microsoft.com/en-us/windows/wsl/install){% endif %} для использования окружения Linux.
  1. Запустите подсистему Linux (по умолчанию — Ubuntu).
  1. Настройте окружение так, как описано в инструкции для операционной системы Linux.

- Linux

  {% note info %}

  Если вы используете дистрибутив, отличный от Ubuntu, установите указанные утилиты с помощью команд вашего пакетного менеджера.

  {% endnote %}

  1. Последовательно установите следующие утилиты с помощью команд в терминале:
     * [Curl](https://curl.se/) и [Git](https://git-scm.com/):

       ```bash
       sudo apt-get install curl git -y
       ```

     * [WebStorm]{% if lang == "ru" %}(https://www.jetbrains.com/ru-ru/webstorm/){% endif %}{% if lang == "en" %}(https://www.jetbrains.com/webstorm/){% endif %} или другая [среда разработки с поддержкой TypeScript]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/TypeScript#IDE_и_поддержка_редакторов){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/TypeScript#IDE_and_editor_support){% endif %}:

       ```bash
       sudo snap install webstorm --classic
       ```

     * [Node.js]{% if lang == "ru" %}(https://nodejs.org/ru/){% endif %}{% if lang == "en" %}(https://nodejs.org/en/){% endif %} не ниже версии `16.9.1`:

       ```bash
       curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash
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
       curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
       exec -l $SHELL
       yc version
       ```

     * [AWS CLI]{% if lang == "ru" %}(https://aws.amazon.com/ru/cli/){% endif %}{% if lang == "en" %}(https://aws.amazon.com/cli/){% endif %}:

       ```bash
       curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
       unzip awscliv2.zip
       sudo ./aws/install
       ```

     * [Docker](https://www.docker.com/):

       ```bash
       sudo apt-get update
       sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release -y
       curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
       echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
       sudo apt-get update
       sudo apt-get install docker-ce docker-ce-cli containerd.io -y
       sudo docker run hello-world
       ```

     {% if region != "ru" %}

     * [{{ TF }}](https://www.terraform.io/) не ниже версии `1.0.8`:

       ```bash
       sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
       curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
       sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
       sudo apt-get update && sudo apt-get install terraform -y
       terraform version
       ```

     {% endif %}

  {% if region == "ru" %}

  1. [Установите](../../tutorials/infrastructure-management/terraform-quickstart.md#from-yc-mirror) {{ TF }} не ниже версии `1.0.8`.

  {% endif %}

  1. [Создайте](../../cli/operations/profile/profile-create.md#interactive-create) профиль {{ yandex-cloud }} CLI с базовыми параметрами.
  1. [Настройте](../../ydb/docapi/tools/aws-setup.md) AWS CLI.
  1. [Настройте](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user) управление Docker от имени непривилегированного пользователя:

     ```bash
     sudo groupadd docker
     sudo usermod -aG docker $USER
     newgrp docker
     docker run hello-world
     ```

- macOS

  1. Последовательно установите следующие утилиты с помощью команд в терминале:
     * [Homebrew](https://brew.sh):

       ```bash
       /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
       ```

     * [Curl](https://curl.se/) и [Git](https://git-scm.com/):

       ```bash
       brew install curl git
       ```

     * [WebStorm]{% if lang == "ru" %}(https://www.jetbrains.com/ru-ru/webstorm/){% endif %}{% if lang == "en" %}(https://www.jetbrains.com/webstorm/){% endif %} или другая [среда разработки с поддержкой TypeScript]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/TypeScript#IDE_и_поддержка_редакторов){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/TypeScript#IDE_and_editor_support){% endif %}:

       ```bash
       brew install --cask webstorm
       ```

     * [Node.js]{% if lang == "ru" %}(https://nodejs.org/ru/){% endif %}{% if lang == "en" %}(https://nodejs.org/en/){% endif %} не ниже версии `16.9.1`:

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
       curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
       exec -l $SHELL
       yc version
       ```

     * [AWS CLI]{% if lang == "ru" %}(https://aws.amazon.com/ru/cli/){% endif %}{% if lang == "en" %}(https://aws.amazon.com/cli/){% endif %}:

       ```bash
       curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
       sudo installer -pkg AWSCLIV2.pkg -target /
       ```

     * [Docker](https://www.docker.com/):

       ```bash
       brew install --cask docker
       ```

     {% if region != "ru" %}

     * [{{ TF }}](https://www.terraform.io/) не ниже версии `1.0.8`:

       ```bash
       brew tap hashicorp/tap
       brew install hashicorp/tap/terraform
       terraform version
       ```

     {% endif %}

  {% if region == "ru" %}

  1. [Установите](../../tutorials/infrastructure-management/terraform-quickstart.md#from-yc-mirror) {{ TF }} не ниже версии `1.0.8`.

  {% endif %}

  1. [Создайте](../../cli/operations/profile/profile-create.md#interactive-create) профиль с базовыми параметрами.
  1. [Настройте](../../ydb/docapi/tools/aws-setup.md) AWS CLI.

{% endlist %}

## Инициализируйте {{ TF }} {#init-terraform}

1. Склонируйте репозиторий c исходными файлами для проекта CRUD API:

   ```bash
   git clone https://github.com/yandex-cloud-examples/yc-serverless-web-application-movie-website.git
   ```

   Откройте директорию проекта в WebStorm и изучите исходные файлы.
1. Перейдите в директорию `deploy`:

   ```bash
   cd <путь_к_директории_deploy>
   ```

1. Узнайте имя активного профиля (`ACTIVE`) интерфейса командной строки {{ yandex-cloud }} CLI. В терминале выполните команду:

   ```bash
   yc config profile list
   ```

1. Получите параметры активного профиля:

   ```bash
   yc config profile get <имя_профиля>
   ```

1. Скопируйте в файл [provider.tf](https://github.com/yandex-cloud-examples/yc-serverless-web-application-movie-website/blob/main/deploy/provider.tf) полученные параметры:
   * `token` — [OAuth-токен](../../iam/concepts/authorization/oauth-token.md).
   * `cloud-id` — идентификатор [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud).
   * `folder-id` — идентификатор [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder).
1. Экспортируйте идентификатор каталога в переменную окружения:

   ```bash
   export FOLDER_ID=<идентификатор_каталога>
   echo $FOLDER_ID
   ```

1. Выполните команду инициализации {{ TF }}:

   ```bash
   terraform init
   ```

   {% note info %}

   Выполняйте все команды {{ TF }} в директории `deploy`.

   {% endnote %}

## Создайте базу данных {{ ydb-name }} {#create-database}

В проекте используется база данных [{{ ydb-short-name }}]({{ link-cloud-services }}/ydb) в режиме serverless. БД состоит из двух таблиц: `movies` для хранения информации о фильмах и `votes` для хранения оценок пользователей. Каждая запись в таблице содержит идентификатор и конечный набор атрибутов.
1. Конфигурация {{ TF }} для создания БД описана в файле [ydb.tf](https://github.com/yandex-cloud-examples/yc-serverless-web-application-movie-website/blob/main/deploy/ydb.tf). Создайте базу данных:

   ```bash
   terraform apply -target=yandex_ydb_database_serverless.movies_database
   ```

   Подтвердите создание ресурсов: введите в терминале `yes` и нажмите **Enter**.

   В выводе команды будут указаны переменные:
   * `movies_database_document_api_endpoint` — Document API эндпоинт базы данных.
   * `movies_database_path` — относительный путь к базе данных.

   Проверить, что БД `movies-database` успешно создана, можно в [консоли управления]({{ link-console-main }}) или с помощью команды CLI `yc ydb database list`.
1. Экспортируйте в переменные окружения значения `movies_database_document_api_endpoint` и `movies_database_path` из вывода предыдущей команды:

   ```bash
   export DOCUMENT_API_ENDPOINT=<Document_API_эндпоинт_базы_данных>
   echo $DOCUMENT_API_ENDPOINT

   export MOVIES_DATABASE_PATH=<относительный_путь_к_базе_данных>
   echo $MOVIES_DATABASE_PATH
   ```

1. Создайте в БД `movies-database` таблицы `movies` и `votes`:

   ```bash
   aws dynamodb create-table \
     --table-name movies \
     --attribute-definitions \
       AttributeName=id,AttributeType=N \
       AttributeName=title,AttributeType=S \
       AttributeName=type,AttributeType=S \
       AttributeName=original_title,AttributeType=S \
       AttributeName=original_language,AttributeType=S \
       AttributeName=release_date,AttributeType=S \
       AttributeName=poster_path,AttributeType=S \
       AttributeName=popularity,AttributeType=N \
       AttributeName=video,AttributeType=S \
       AttributeName=vote_count,AttributeType=N \
       AttributeName=vote_average,AttributeType=N \
       AttributeName=genres,AttributeType=S \
       AttributeName=backdrop_path,AttributeType=S \
       AttributeName=adult,AttributeType=S \
       AttributeName=overview,AttributeType=S \
     --key-schema \
       AttributeName=id,KeyType=HASH \
     --global-secondary-indexes \
       "[
         {
           \"IndexName\": \"PopularityIndex\",
           \"KeySchema\": [{\"AttributeName\":\"type\",\"KeyType\":\"HASH\"}, {\"AttributeName\":\"popularity\",\"KeyType\":\"RANGE\"}],
           \"Projection\":{
             \"ProjectionType\":\"ALL\"
           }
         }
       ]" \
     --endpoint ${DOCUMENT_API_ENDPOINT}

   aws dynamodb create-table \
     --table-name votes \
     --attribute-definitions \
       AttributeName=id,AttributeType=S \
       AttributeName=user_id,AttributeType=S \
       AttributeName=movie_id,AttributeType=N \
       AttributeName=value,AttributeType=N \
     --key-schema \
       AttributeName=id,KeyType=HASH \
     --global-secondary-indexes \
       "[
         {
           \"IndexName\": \"MovieIndex\",
           \"KeySchema\": [{\"AttributeName\":\"movie_id\",\"KeyType\":\"HASH\"}],
           \"Projection\":{
             \"ProjectionType\":\"ALL\"
           }
         }
       ]" \
     --endpoint ${DOCUMENT_API_ENDPOINT}
   ```

1. Проверьте, что таблицы создались:

   ```bash
   aws dynamodb describe-table \
     --table-name movies \
     --endpoint ${DOCUMENT_API_ENDPOINT}

   aws dynamodb describe-table \
     --table-name votes \
     --endpoint ${DOCUMENT_API_ENDPOINT}
   ```

   Для каждой таблицы поддерживаются два индекса:
   * В таблице `movies` — индекс для быстрого поиска фильма по его идентификатору и индекс для сортировки фильмов по популярности.
   * В таблице `votes` — индекс для поиска оценки пользователя по фильму и индекс для получения всех оценок фильма.

## Реализуйте CRUD-операции {#implement-operations}

Слой для работы с базой данных используется каждый раз, когда необходимо создавать, получать, обновлять или удалять записи. Эти действия называют CRUD-операциями.

Взаимодействие с базой данных через [Document API](../../ydb/docapi/api-ref/) реализовано с помощью библиотеки [AWS SDK for JavaScript v3](https://docs.aws.amazon.com/AWSJavaScriptSDK/v3/latest/index.html):
* В файле [model.ts](https://github.com/yandex-cloud-examples/yc-serverless-web-application-movie-website/blob/main/src/model.ts) через интерфейс TypeScript определены модели фильма `Movie` и оценки `Vote`.
* В файле [repository.ts](https://github.com/yandex-cloud-examples/yc-serverless-web-application-movie-website/blob/main/src/repository.ts) реализованы CRUD-операции для работы с этими сущностями.

При выполнении операций с данными для авторизации используются [IAM-токены](../../iam/concepts/authorization/iam-token.md). Для получения IAM-токена перед выполнением операции вызывается [сервис метаданных](../../serverless-containers/operations/sa.md).

### Cоздайте сервисный аккаунт {#create-sa}

1. Конфигурация {{ TF }} для создания сервисного аккаунта описана в файле [sa.tf](https://github.com/yandex-cloud-examples/yc-serverless-web-application-movie-website/blob/main/deploy/sa.tf). Создайте сервисный аккаунт:

   ```bash
   terraform apply -target=yandex_iam_service_account.movies_api_sa
   ```

   Подтвердите создание ресурсов: введите в терминале `yes` и нажмите **Enter**.
1. В выводе команды, в переменной `movies_api_sa_id`, указан идентификатор созданного сервисного аккаунта. Экспортируйте его в переменную окружения:

   ```bash
   export MOVIES_API_SA_ID=<идентификатор_сервисного_аккаунта>
   echo $MOVIES_API_SA_ID
   ```

1. Назначьте роли сервисному аккаунту:

   ```bash
   yc resource-manager folder add-access-binding ${FOLDER_ID} \
     --role ydb.admin \
     --subject serviceAccount:${MOVIES_API_SA_ID}

   yc resource-manager folder add-access-binding ${FOLDER_ID} \
     --role container-registry.images.puller \
     --subject serviceAccount:${MOVIES_API_SA_ID}

   yc resource-manager folder add-access-binding ${FOLDER_ID} \
     --role serverless.containers.invoker \
     --subject serviceAccount:${MOVIES_API_SA_ID}
   ```

   Где:
   * `role` — назначаемая роль.
   * `subject serviceAccount` — идентификатор сервисного аккаунта.

   Роли назначаются сервисному аккаунту для следующих действий:
   * Вызов контейнера в [{{ serverless-containers-name }}]({{ link-cloud-services }}/serverless-containers).
   * Выполнение операций в [{{ ydb-short-name }}]({{ link-cloud-services }}/ydb).

   Роли назначаются на весь каталог, а не на каждый ресурс в отдельности.

### Скомпилируйте исходный код приложения на TypeScript {#compile-app}

1. Перейдите в корневую директорию репозитория и установите необходимые зависимости:

   ```bash
   cd <путь_к_директории_sls-web-application>
   npm ci
   ```

   После выполнения команды в проекте появится директория `node_modules`, в которой будут находиться все необходимые зависимости.
1. Запустите сборку проекта:

   ```bash
   npm run build
   ```

   После выполнения команды в проекте появится директория `dist`, в которой будут находиться скомпилированные JS-файлы.

## Разработайте REST API {#develop-rest-api}

В файле [openapi/api.yaml](https://github.com/yandex-cloud-examples/yc-serverless-web-application-movie-website/blob/main/openapi/api.yaml) подготовлена спецификация OpenAPI, в которой описаны основные операции для работы с фильмами и оценками.

Для реализации сервиса в соответствии с этой спецификацией используется библиотека [OpenAPI Backend](https://github.com/anttiviljami/openapi-backend) в связке с фреймворком [Express](https://expressjs.com). В файле [app.ts](https://github.com/yandex-cloud-examples/yc-serverless-web-application-movie-website/blob/main/src/app.ts) описаны необходимые классы и маппинг операций, а также запуск HTTP-сервиса.

### Разверните приложение в {{ serverless-containers-name }} {#deploy-container}

Cоберите приложение в виде Docker-образа и запустите его в [{{ serverless-containers-name }}]({{ link-cloud-services }}/serverless-containers):
1. В [спецификации OpenAPI](https://github.com/yandex-cloud-examples/yc-serverless-web-application-movie-website/blob/main/openapi/api.yaml) `api.yaml`, в поле `x-yc-apigateway.service_account_id`, укажите идентификатор сервисного аккаунта, который создали ранее.
1. В файле [container-registry.tf](https://github.com/yandex-cloud-examples/yc-serverless-web-application-movie-website/blob/main/deploy/container-registry.tf) описана конфигурация реестра и репозитория, в которые будет загружаться Docker-образ приложения. Перейдите в директорию `deploy` и создайте ресурсы в [{{ container-registry-full-name }}]({{ link-cloud-services }}/container-registry):

   ```bash
   cd <путь_к_директории_deploy>
   terraform apply -target=yandex_container_registry.default
   terraform apply -target=yandex_container_repository.movies_api_repository
   ```

   Подтвердите создание ресурсов: введите в терминале `yes` и нажмите **Enter**.
1. В выводе команды, в переменной `movies_api_repository_name`, указано название репозитория, в который нужно загрузить Docker-образ. Экспортируйте его в переменную окружения:

   ```bash
   export MOVIES_API_REPOSITORY_NAME=<название_репозитория>
   echo $MOVIES_API_REPOSITORY_NAME
   ```

1. Настройте Docker для работы с созданным репозиторием:

   ```bash
   yc container registry configure-docker
   ```

1. В файле [Dockerfile](https://github.com/yandex-cloud-examples/yc-serverless-web-application-movie-website/blob/main/Dockerfile) описана конфигурация для сборки Docker-образа. Соберите образ и загрузите его в созданный на предыдущем шаге репозиторий:

   ```bash
   docker build -t ${MOVIES_API_REPOSITORY_NAME}:0.0.1 .
   docker push ${MOVIES_API_REPOSITORY_NAME}:0.0.1
   ```

1. Создайте контейнер {{ serverless-containers-name }}:

   ```bash
   yc sls container create \
     --name movies-api-container \
     --folder-id ${FOLDER_ID}
   ```

   Где:
   * `name` — имя контейнера.
   * `folder-id` — идентификатор каталога.
1. В выводе команды указан идентификатор созданного контейнера. Экспортируйте его в переменную окружения:

   ```bash
   export MOVIES_API_CONTAINER_ID=<идентификатор_контейнера>
   echo $MOVIES_API_CONTAINER_ID
   ```

1. Создайте [ревизию](../../serverless-containers/concepts/container.md) контейнера из Docker-образа с версией `0.0.1`:

   ```bash
   yc sls container revisions deploy \
     --folder-id ${FOLDER_ID} \
     --container-id ${MOVIES_API_CONTAINER_ID} \
     --memory 512M \
     --cores 1 \
     --execution-timeout 5s \
     --concurrency 4 \
     --environment AWS_ACCESS_KEY_ID=FAKE_AWS_ACCESS_KEY_ID,AWS_SECRET_ACCESS_KEY=FAKE_AWS_SECRET_ACCESS_KEY,DOCUMENT_API_ENDPOINT=${DOCUMENT_API_ENDPOINT} \
     --service-account-id ${MOVIES_API_SA_ID} \
     --image ${MOVIES_API_REPOSITORY_NAME}:0.0.1
   ```

   Где:
   * `folder-id` — идентификатор каталога.
   * `container-id` — идентификатор контейнера.
   * `memory` — объем памяти, доступный контейнеру.
   * `cores` — количество ядер vCPU, доступное контейнеру.
   * `execution-timeout` — таймаут выполнения.
   * `concurrency` — максимальное число одновременных вызовов контейнера. Если вызовов контейнера больше, чем значение параметра `concurrency`, сервис масштабирует контейнер — запускает его дополнительные экземпляры.
   * `environment` — переменные окружения. Через переменную окружения `DOCUMENT_API_ENDPOINT` в приложение передается Document API эндпоинт базы данных.
   * `service-account-id` — идентификатор сервисного аккаунта.
   * `image` — название репозитория.

### Разверните API в {{ api-gw-name }} {#deploy-api-gw}

1. В [спецификации OpenAPI](https://github.com/yandex-cloud-examples/yc-serverless-web-application-movie-website/blob/main/openapi/api.yaml) `api.yaml` замените переменную `${MOVIES_API_CONTAINER_ID}` на идентификатор созданного контейнера.
1. В файле [api-gateway.tf](https://github.com/yandex-cloud-examples/yc-serverless-web-application-movie-website/blob/main/deploy/api-gateway.tf) описана конфигурация {{ TF }} для создания [API-шлюза](../../api-gateway/concepts/index.md). Разверните API-шлюз:

   ```bash
   terraform apply -target=yandex_api_gateway.movies_api_gateway
   ```

   Подтвердите создание ресурсов: введите в терминале `yes` и нажмите **Enter**.
1. В выводе команды, в переменной `movies_api_gateway_domain`, указано доменное имя API-шлюза. Экспортируйте его в переменную окружения:

   ```bash
   export MOVIES_API_GATEWAY_DOMAIN=<доменное_имя_API-шлюза>
   echo $MOVIES_API_GATEWAY_DOMAIN
   ```

## Проверьте работу созданного CRUD API {#test-api}

Чтобы проверить работу созданного CRUD API, выполните следующие HTTP-запросы с помощью команды `curl`:
1. Получите список фильмов:

   ```bash
   curl "${MOVIES_API_GATEWAY_DOMAIN}/movies?limit=10"
   ```

   В ответе должен прийти пустой список `[]`, так как пока в базе нет данных.
1. Добавьте информацию о фильме:

   ```bash
   curl \
     --location \
     --request POST 'https://${MOVIES_API_GATEWAY_DOMAIN}/movies' \
     --header 'Content-Type: application/json' \
     --data-raw '{
       "id": "301",
       "title": "The Matrix",
       "release_date": 1999
     }'
   ```

1. Получите информацию о фильме:

   ```bash
   curl \
     --location \
     --request GET 'https://${MOVIES_API_GATEWAY_DOMAIN}/movies/301'
   ```

1. Добавьте информацию о другом фильме:

   ```bash
   curl \
     --location \
     --request POST 'https://${MOVIES_API_GATEWAY_DOMAIN}/movies' \
     --header 'Content-Type: application/json' \
     --data-raw '{
       "id": "299",
       "title": "The Matrix Reloaded",
       "release_date": 2003
     }'
   ```

1. Получите список фильмов:

   ```bash
   curl \
     --location \
     --request GET 'https://${MOVIES_API_GATEWAY_DOMAIN}/movies?from=1&limit=5'
   ```

Также вы можете загрузить спецификацию в [Postman](https://www.postman.com) или [SwaggerHub](https://swagger.io/tools/swaggerhub/), добавив в секцию `servers` адрес созданного API-шлюза из переменной `${MOVIES_API_GATEWAY_DOMAIN}`. Это позволит удобно делать вызовы к REST API.

Посмотрите диагностическую информацию о работе контейнера. В [консоли управления]({{ link-console-main }}) перейдите на страницу контейнера. На вкладке **Логи** находятся сообщения о вызовах контейнера, а на вкладке **Мониторинг** — графики вызовов контейнера, среднего времени обработки запроса и количества ошибок.

Логи и графики мониторинга также можно посмотреть на странице API-шлюза.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за ресурсы, созданные с помощью {{ TF }}, удалите их. В терминале выполните команду:

```bash
terraform destroy
```

Подтвердите удаление ресурсов: введите в терминале `yes` и нажмите **Enter**.

#### См. также {#see-also}

* [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md).
* [Справочник {{ TF }}. Провайдер {{ yandex-cloud }}]({{ tf-provider-link }}).
* [Документная таблица](../../ydb/operations/schema.md).
* [Расширение x-yc-apigateway-integration](../../api-gateway/concepts/extensions/containers.md).
* [{#T}](../../serverless-containers/concepts/logs.md).
* [{#T}](../../serverless-containers/operations/monitoring.md).