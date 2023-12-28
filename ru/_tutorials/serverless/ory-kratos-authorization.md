# Авторизация с помощью функции {{ sf-name }} в сервисе Ory Kratos

В этом руководстве вы развернете [приложение {{ cloud-apps-full-name }}](../../cloud-apps/kratos.md) для аутентификации, авторизации и управления учетными записями пользователей, основанное на [Ory Kratos](https://www.ory.sh/docs/kratos/ory-kratos-intro). Также вы напишете [функцию](../../functions/concepts/function.md) {{ sf-name }}, которая вызывает развернутый сервис для авторизации запросов и передает в него сессионный ключ, полученный от Ory Kratos после успешной аутентификации. В конце вы подключите созданную функцию к API Gateway в качестве авторайзера.

Чтобы развернуть инфраструктуру:

1. [Подготовьте окружение](#prepare).
1. [Скачайте и соберите проект](#download-project).
1. [Создайте сервисные аккаунты](#create-sa).
1. [Разверните Identity Server based on Ory Kratos](#deploy-kratos).
1. [Создайте функцию авторизации](#create-function).
1. [Создайте API-шлюз](#create-api-gw).
1. [Проверьте результат](#check).

Если созданные ресурсы больше не нужны, [удалите](#clear-out) их.

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за постоянно запущенные виртуальные машины (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за вычислительные ресурсы, объем хранилища и резервных копий для кластера {{ PG }} (см. [тарифы {{ mpg-full-name }}](../../managed-postgresql/pricing.md));
* плата за объем входящего трафика, обработанного балансировщиком, и количество сетевых балансировщиков (см. [тарифы {{ network-load-balancer-full-name }}](../../network-load-balancer/pricing.md));
* плата за количество вызовов функции, вычислительные ресурсы, выделенные для выполнения функции, и исходящий трафик (см. [тарифы {{ sf-full-name }}](../../functions/pricing.md));
* плата за количество вызовов контейнера, вычислительные ресурсы, выделенные для выполнения приложения, и исходящий трафик (см. [тарифы {{ serverless-containers-full-name }}](../../serverless-containers/pricing.md));
* плата за хранение и запрос секретов (см. [тарифы {{ lockbox-full-name }}](../../lockbox/pricing.md));
* плата за количество запросов к API-шлюзу и исходящий трафик (см. [тарифы {{ api-gw-full-name }}](../../api-gateway/pricing.md));
* плата за запись и хранение логов (см. [тарифы {{ cloud-logging-full-name }}](../../logging/pricing.md)).

## Подготовьте окружение {#prepare}

1. [Получите](../../compute/operations/images-with-pre-installed-software/operate.md#creating-ssh-keys) пару SSH-ключей для подключения к виртуальной машине.
1. Получите у почтового провайдера данные для подключения к SMTP-серверу: адрес и порт SMTP-сервера, имя пользователя и пароль для доступа к SMTP-серверу. Эти данные будут использоваться для авторизации в сервисе, который отправляет письма.
1. [Создайте](../../vpc/operations/network-create.md) облачную сеть {{ vpc-name }}.

## Скачайте и соберите проект {#download-project}

1. Склонируйте репозиторий с проектом:

   ```bash
   git clone https://github.com/yandex-cloud-examples/yc-serverless-apigw-function-authorizer-kratos.git
   ```

1. Перейдите в папку с файлами проекта: `yc-serverless-apigw-function-authorizer-kratos`.
1. Установите [Node.js](https://nodejs.org/ru/download/package-manager/), выполнив команду:

   ```bash
   curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash - \
   sudo apt-get install -y nodejs
   ```

1. Установите зависимости, выполнив команду:

   ```bash
   npm install
   ```

1. Соберите проект, выполнив команду:

   ```bash
   npm run build
   ```

1. Перейдите в папку `yc-serverless-apigw-function-authorizer-kratos/build` и добавьте файл `index.js` в ZIP-архив `index-js.zip`.

## Создайте сервисные аккаунты {#create-sa}

1. Создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) `sa-for-kratos`, от имени которого будут создаваться ресурсы для Identity Server based on Ory Kratos:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать сервисный аккаунт.
     1. Перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
     1. Введите имя сервисного аккаунта — `sa-for-kratos`.
     1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите роль `{{ roles-admin }}`.
     1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
    
   - CLI

     {% include [cli-install](../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     1. Создайте сервисный аккаунт `sa-for-kratos`:

        ```bash
        yc iam service-account create --name sa-for-kratos
        ```

        Результат:

        ```
        id: nfersamh4sjq********
        folder_id: b1gc1t4cb638********
        created_at: "2023-03-21T10:36:29.726397755Z"
        name: sa-for-kratos
        ```

        Сохраните идентификатор сервисного аккаунта `sa-for-kratos` (`id`) и каталога, в котором его создали (`folder_id`).

     1. Назначьте сервисному аккаунту роль `{{ roles-admin }}` на каталог:

        ```bash
        yc resource-manager folder add-access-binding <идентификатор_каталога> \
          --role {{ roles-admin }} \
          --subject serviceAccount:<идентификатор_сервисного_аккаунта>
        ```

        Результат:

        ```
        done (1s)
        ```

   - {{ TF }}

     
     {% include [terraform-install](../../_includes/terraform-install.md) %}


     1. Опишите в конфигурационном файле параметры сервисного аккаунта:

        ```hcl
        resource "yandex_iam_service_account" "sa-for-kratos" {
          name        = "sa-for-kratos"
          folder_id   = "<идентификатор_каталога>"
        }

        resource "yandex_resourcemanager_folder_iam_member" "{{ roles-admin }}" {
          folder_id = "<идентификатор_каталога>"
          role      = "{{ roles-admin }}"
          member    = "serviceAccount:${yandex_iam_service_account.sa-for-kratos id}"
        }
        ```

        Где:

        * `name` — имя сервисного аккаунта. Обязательный параметр.
        * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md). Необязательный параметр. По умолчанию будет использовано значение, указанное в настройках провайдера.
        * `role` — назначаемая роль.

        Более подробную информацию о параметрах ресурса `yandex_iam_service_account` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/iam_service_account).

     1. Проверьте корректность конфигурационных файлов.

        1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
        1. Выполните проверку с помощью команды:

           ```bash
           terraform plan
           ```

        Если конфигурация описана верно, в терминале отобразится информация о сервисном аккаунте. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

     1. Разверните облачные ресурсы.

        1. Если в конфигурации нет ошибок, выполните команду:

           ```bash
           terraform apply
           ```

        1. Подтвердите создание сервисного аккаунта: введите в терминал слово `yes` и нажмите **Enter**.

           После этого будет создан сервисный аккаунт. Проверить появление сервисного аккаунта можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

           ```bash
           yc iam service-account list
           ```

   - API

     Чтобы создать сервисный аккаунт, воспользуйтесь методом [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/service_account_service.md#Create).

     Чтобы назначить сервисному аккаунту роль `{{ roles-admin }}` на каталог, воспользуйтесь методом [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/service_account_service.md#SetAccessBindings).

   {% endlist %}

1. Таким же образом создайте сервисный аккаунт `sa-func-authorizer` с ролью `{{ roles-functions-invoker }}`, от имени которого будет вызываться функция.

## Разверните Identity Server based on Ory Kratos {#deploy-kratos}

Разверните приложение Identity Server based on Ory Kratos с помощью сервиса {{ cloud-apps-full-name }}.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите развернуть приложение.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-apps }}**.
  1. На панели слева выберите **{{ ui-key.yacloud.cloud-apps.label_marketplace }}**.
  1. Выберите `Identity Server based on Ory Kratos` и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
  1. Укажите:

     * Имя приложения.
     * Сервисный аккаунт `sa-for-kratos`.
     * Идентификатор [облачной сети](../../vpc/concepts/network.md#network), которую [создали ранее](#prepare).
     * CIDR [подсетей](../../vpc/concepts/network.md#subnet) в [зонах доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-a`, `{{ region-id }}-b` и `{{ region-id }}-c`. Подсети автоматически создадутся в указанной облачной сети во время установки приложения.
     * Количество виртуальных машин для Ory Kratos API.
     * Имя пользователя, которое будет использоваться для доступа на виртуальные машины по SSH.
     * Публичный SSH-ключ, [который получили ранее](#prepare).
     * Имя и пароль пользователя для доступа к БД. Их необходимо придумать самостоятельно. Длина пароля должна быть не меньше 8 символов.
     * Пароль доступа к приватному Ory Kratos API. Его необходимо придумать самостоятельно.
     * Адрес и порт SMTP-сервера, имя пользователя и пароль для доступа к SMTP-серверу, [которые получили ранее](#prepare).
     * Имя и адрес отправителя, которые будут указаны в письмах от Identity Server based on Ory Kratos.

  1. Нажмите кнопку **{{ ui-key.yacloud.cloud-apps.button_install }}** и дождитесь, пока приложение установится.
  1. Сохраните ссылку для входа в приложение:

     1. Выберите созданное приложение.
     1. В разделе **{{ ui-key.yacloud.cloud-apps.section_resources }}** выберите созданный API-шлюз.
     1. Сохраните значение поля **{{ ui-key.yacloud.serverless-functions.gateways.overview.label_domain }}** из раздела **{{ ui-key.yacloud.serverless-functions.gateways.overview.section_base }}**.

        По путям `/public`, `/admin` и `/ui` доступны публичный, приватный API и пользовательский интерфейс соответственно.

{% endlist %}

## Создайте функцию авторизации {#create-function}

Создайте функцию, которая будет вызывать Identity Server based on Ory Kratos для авторизации пользователя.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать функцию.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**
  1. Создайте функцию:

     1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
     1. Введите имя функции — `kratos-authorizer`.
     1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

  1. Создайте версию функции:

     1. Выберите среду выполнения `Node.js`, отключите опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** и нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
     1. Укажите способ загрузки `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}` и выберите архив `index-js.zip`, который создали на этапе [сборки проекта](#download-project).
     1. Укажите точку входа `index.js`.
     1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}** укажите:

        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** — `5`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}** — `128 {{ ui-key.yacloud.common.units.label_megabyte }}`.
        * **{{ ui-key.yacloud.forms.label_service-account-select }}** — `sa-func-authorizer`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}**:

          * `KRATOS_API_BASE_PATH` — `https://<служебный_домен_API-шлюза>/public`, где `<служебный_домен_API-шлюза>` — служебный домен API-шлюза, который вы сохранили на шаге [Разверните Identity Server based on Ory Kratos](#deploy-kratos).

      1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI

  1. Создайте функцию `kratos-authorizer`:

     ```bash
     yc serverless function create --name=kratos-authorizer
     ```

     Результат:

     ```
     id: b09bhaokchn9pn******
     folder_id: aoek49ghmknnpj******
     created_at: "2023-03-21T10:03:37.475Z"
     name: kratos-authorizer
     log_group_id: eolm8aoq9vcpps******
     http_invoke_url: https://{{ sf-url }}/b09bhaokchn9pn******
     status: ACTIVE
     ```

  1. Создайте версию функции `kratos-authorizer`:

     ```bash
     yc serverless function version create \
       --function-name kratos-authorizer \
       --memory=128m \
       --execution-timeout=5s \
       --runtime=nodejs16 \
       --entrypoint=index.js \
       --service-account-id=<идентификатор_сервисного_аккаунта> \
       --environment KRATOS_API_BASE_PATH=https://<служебный_домен_API-шлюза>/public \
       --source-path=./index-js.zip
       ```

       Где:

       * `--function-name` — имя функции, версия которой создается.
       * `--memory` — объем RAM.
       * `--execution-timeout` — максимальное время выполнения функции до таймаута.
       * `--runtime` — среда выполнения.
       * `--entrypoint` — точка входа.
       * `--service-account-id` — идентификатор сервисного аккаунта `sa-func-authorizer`.
       * `--environment` — переменные окружения. `<служебный_домен_API-шлюза>` — служебный домен API-шлюза, который вы сохранили на шаге [Разверните Identity Server based on Ory Kratos](#deploy-kratos).
       * `--source-path` — путь до ZIP-архива `index-js.zip`.

       Результат:

       ```
       done (1s)
       id: d4e6qqlh53nuh5******
       function_id: d4emc80mnp5n96******
       created_at: "2023-03-22T16:49:41.800Z"
       runtime: nodejs16
       entrypoint: index.js
       resources:
         memory: "134217728"
       execution_timeout: 5s
       service_account_id: aje20nhregkcvu******
       image_size: "4096"
       status: ACTIVE
       tags:
         - $latest
       log_group_id: ckgmc3l93cl0lf******
       environment:
         KRATOS_API_BASE_PATH: https://******/public
       log_options:
         folder_id: b1g86q4m5vej8l******
       ```

- {{ TF }}

  1. Опишите в конфигурационном файле параметры функции:

     ```   
     resource "yandex_function" "kratos-authorizer" {
       name               = "kratos-authorizer"
       user_hash          = "first function"
       runtime            = "nodejs16"
       entrypoint         = "index.js"
       memory             = "128"
       execution_timeout  = "5"
       service_account_id = "<идентификатор_сервисного_аккаунта>"
       environment = {
         KRATOS_API_BASE_PATH = https://<служебный_домен_API-шлюза>/public
       }
       content {
         zip_filename = "./index-js.zip"
       }
     }
     ```

     Где:

     * `name` — имя функции.
     * `user_hash` — произвольная строка, определяющая версию функции.
     * `runtime` — [среда выполнения](../../functions/concepts/runtime/index.md) функции.
     * `entrypoint` — точка входа.
     * `memory` — объем памяти в мегабайтах, отведенный для выполнения функции.
     * `execution_timeout` — таймаут выполнения функции.
     * `service_account_id` — идентификатор сервисного аккаунта `sa-func-authorizer`.
     * `environment` — переменные окружения. `<служебный_домен_API-шлюза>` — служебный домен API-шлюза, который вы сохранили на шаге [Разверните Identity Server based on Ory Kratos](#deploy-kratos).
     * `content` — путь до ZIP-архива `index-js.zip` c исходным кодом функции.

     Более подробную информацию о параметрах ресурса `yandex_function` см. в [документации провайдера]({{ tf-provider-resources-link }}/function).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание функции: введите в терминал слово `yes` и нажмите **Enter**.

- API

  Чтобы создать функцию, воспользуйтесь методом [create](../../functions/functions/api-ref/Function/create.md) для ресурса [Function](../../functions/functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/Create](../../functions/functions/api-ref/grpc/function_service.md#Create).

  Чтобы создать версию функцию, воспользуйтесь методом [createVersion](../../functions/functions/api-ref/Function/createVersion.md) для ресурса [Function](../../functions/functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/CreateVersion](../../functions/functions/api-ref/grpc/function_service.md#CreateVersion).

{% endlist %}

## Создайте API-шлюз {#create-api-gw}

Создайте API-шлюз, который будет защищен авторизацией с помощью функции-авторайзера, созданной на предыдущем шаге.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором развернуто приложение Identity Server based on Ory Kratos.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**.
  1. В поле **{{ ui-key.yacloud.serverless-functions.gateways.form.field_name }}** введите `for-kratos-authorization`.
  1. В поле **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** добавьте спецификацию из файла `openapi-example.yaml`, расположенного в папке с проектом:

     ```yaml
     openapi: 3.0.0
     info:
       title: API with Ory Kratos Authorization
       version: 1.0.0

     paths:
       /authorized/api:
         get:
           summary: Authorized operation, needs session cookie from Ory Kratos
           operationId: cookieAuthApi
           security:
             - cookieAuth: [ ]
           x-yc-apigateway-integration:
             type: dummy
             content:
               '*': "Authorized!"
             http_code: 200
             http_headers:
               'Content-Type': "text/plain"
     components:
       securitySchemes:
         cookieAuth:
           type: apiKey
           in: cookie
           name: ory_kratos_session
           x-yc-apigateway-authorizer:
             type: function
             function_id: <идентификатор_функции>
             service_account_id: <идентификатор_сервисного_аккаунта>
       ```

       Где:

       * `function_id` — идентификатор функции `kratos-authorizer`.
       * `service_account_id` — идентификатор сервисного аккаунта `sa-func-authorizer`.

  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.form.button_create-gateway }}**.
  1. Сохраните значение поля **{{ ui-key.yacloud.serverless-functions.gateways.overview.label_domain }}** из раздела **{{ ui-key.yacloud.serverless-functions.gateways.overview.section_base }}**.

- CLI

  1. Сохраните следующую спецификацию в файл `kratos.yaml`:

     ```yaml
     openapi: 3.0.0
     info:
       title: API with Ory Kratos Authorization
       version: 1.0.0

     paths:
       /authorized/api:
         get:
           summary: Authorized operation, needs session cookie from Ory Kratos
           operationId: cookieAuthApi
           security:
             - cookieAuth: [ ]
           x-yc-apigateway-integration:
             type: dummy
             content:
               '*': "Authorized!"
             http_code: 200
             http_headers:
               'Content-Type': "text/plain"
     components:
       securitySchemes:
         cookieAuth:
           type: apiKey
           in: cookie
           name: ory_kratos_session
           x-yc-apigateway-authorizer:
             type: function
             function_id: <идентификатор_функции>
             service_account_id: <идентификатор_сервисного_аккаунта>
       ```

     Где:

     * `function_id` — идентификатор функции `kratos-authorizer`.
     * `service_account_id` — идентификатор сервисного аккаунта `sa-func-authorizer`.

  1. Создайте API-шлюз:

     ```bash
     yc serverless api-gateway create \
       --name for-kratos-authorization \
       --spec=kratos.yaml \
       --description "ory kratos auth"
     ```

     Результат:

     ```bash
     done (41s)
     id: d5delqeel34qjj******
     folder_id: b1g86q4m5vej8l******
     created_at: "2023-03-08T14:07:32.134Z"
     name: for-kratos-authorization
     description: ory kratos auth
     status: ACTIVE
     domain: d5delqeel34qjj******.apigw.yandexcloud.net
     log_group_id: ckg2hdmevnvcng******
     ```

  1. Сохраните значение поля `domain`.

{% endlist %}

## Проверьте результат {#check}

1. В браузере перейдите на страницу тестовой консоли Identity Server based on Ory Kratos по адресу `https://<служебный_домен_API-шлюза>/ui/`, где `<служебный_домен_API-шлюза>` — служебный домен API-шлюза, который вы сохранили на шаге [Разверните Identity Server based on Ory Kratos](#deploy-kratos).
1. Зарегистрируйте пользователя.
1. Выполните вход с учетными данными пользователя: `https://<служебный_домен_API-шлюза>/ui/login`.
1. Откройте консоль разработчика в браузере и скопируйте значение куки с названием `ory_kratos_session`.
1. Обратитесь к API-шлюзу `for-kratos-authorization`:

   ```bash
   curl 'https://<служебный_домен_API-шлюза_for-kratos-authorization>/authorized/api' -H 'Cookie: ory_kratos_session=<значение_куки>'
   ```

   Где `<значение_куки>` — значение куки `ory_kratos_session`, скопированное на предыдущем шаге.

Если в ответе вы получили `Authorized!`, значит, сессия пользователя активна и API был успешно вызван после проверки авторизационной куки.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

* удалите приложение Identity Server based on Ory Kratos;
* [удалите](../../functions/operations/function/function-delete.md) функцию {{ sf-full-name }};
* [удалите](../../api-gateway/operations/api-gw-delete.md) API-шлюз {{ api-gw-full-name }}.
