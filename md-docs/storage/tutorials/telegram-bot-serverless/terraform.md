# Как создать бота в Telegram с помощью Serverless и Terraform


Чтобы [создать бота в Telegram](index.md) с помощью Serverless и Terraform:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Зарегистрируйте Telegram-бота](#create-bot).
1. [Создайте инфраструктуру](#deploy).
1. [Проверьте работу Telegram-бота](#test-bot).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры Telegram-бота входят:
* плата за вызовы [функции](../../../functions/concepts/function.md), вычислительные ресурсы, выделенные для выполнения функции, и исходящий трафик ([тарифы Cloud Functions](../../../functions/pricing.md));
* плата за [хранение данных](../../concepts/bucket.md) в Object Storage, [операции](../../operations/index.md) с ними и исходящий трафик ([тарифы Object Storage](../../pricing.md));
* плата за количество запросов к созданному [API-шлюзу](../../../api-gateway/concepts/index.md) и исходящий трафик ([тарифы Yandex API Gateway](../../../api-gateway/pricing.md)).


## Зарегистрируйте Telegram-бота {#create-bot}

Зарегистрируйте вашего бота в Telegram и получите токен.

1. Для регистрации нового бота запустите бота [BotFather](https://t.me/BotFather) и отправьте команду.

    ```text
    /newbot
    ```

1. В поле `name` укажите имя создаваемого бота, например `Serverless Hello Telegram Bot`. Это имя увидят пользователи при общении с ботом.
1. В поле `username` укажите имя пользователя создаваемого бота, например `ServerlessHelloTelegramBot`. По имени пользователя можно будет найти бота в Telegram. Имя пользователя должно оканчиваться на `...Bot` или `..._bot`.

   В результате вы получите токен. Сохраните его, он потребуется в дальнейшем.

1. Установите иконку для бота — файл `sayhello.png` из сохраненного архива. Отправьте боту BotFather команду:

    ```text
    /setuserpic
    ```


## Создайте инфраструктуру {#deploy}

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

Для создания инфраструктуры с помощью Terraform:
1. [Установите Terraform](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера Yandex Cloud (раздел [Настройте провайдер](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

    {% list tabs group=infrastructure_description %}

    - Готовая конфигурация {#ready}

      1. Клонируйте [репозиторий](https://sourcecraft.dev/yandex-cloud-examples/yc-telegram-bot-serverless) с конфигурационными файлами, необходимым для создания бота, для этого в терминале выполните команду [git](https://git-scm.com/):

          ```bash
          git clone https://git@git.sourcecraft.dev/yandex-cloud-examples/yc-telegram-bot-serverless.git
          ```

      1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
          * `telegram-bot.tf` — конфигурация создаваемой инфраструктуры;
          * `telegram-bot.auto.tfvars` — файл с пользовательскими данными;
          * `telegram-bot-function.tpl` — шаблон для создания функции Yandex Cloud Functions;
          * `telegram-bot-gw-spec.tpl` — шаблон спецификации API-шлюза;
          * `sayhello.png` — изображение для бота;
          * `package.json` — манифест для функции Node.js.

    - Вручную {#manual}

      1. Создайте папку для конфигурационных файлов.

      1. Создайте в папке:

          1. Конфигурационный файл `telegram-bot.tf`:

              {% cut "telegram-bot.tf" %}

              ```hcl
              # Объявление переменных для конфиденциальных параметров
              
              variable "cloud_id" {
                type = string
              }
              
              variable "folder_id" {
                type = string
              }
              
              variable "bucket_name" {
                type = string
              }
              
              variable "bot_token" {
                type      = string
                sensitive = true
              }
              
              # Настройка провайдера
              
              terraform {
                required_providers {
                  yandex = {
                    source = "yandex-cloud/yandex"
                  }
                }
              }
              
              provider "yandex" {
                cloud_id  = var.cloud_id
                folder_id = var.folder_id
              }
              
              # Создание сервисного аккаунта
              
              resource "yandex_iam_service_account" "bot_sa" {
                name        = "telegram-bot-sa"
                description = "Service Account for Telegram bot"
              }
              
              # Назначение роли сервисному аккаунту
              
              resource "yandex_resourcemanager_folder_iam_member" "sa_editor" {
                folder_id = var.folder_id
                role      = "editor"
                member    = "serviceAccount:${yandex_iam_service_account.bot_sa.id}"
              
                depends_on = [yandex_iam_service_account.bot_sa]
              }
              
              resource "yandex_resourcemanager_folder_iam_member" "sa_invoker" {
                folder_id = var.folder_id
                role      = "functions.functionInvoker"
                member    = "serviceAccount:${yandex_iam_service_account.bot_sa.id}"
              
                depends_on = [yandex_iam_service_account.bot_sa]
              }
              
              # Создание статических ключей доступа
              
              resource "yandex_iam_service_account_static_access_key" "bot_sa_key" {
                service_account_id = yandex_iam_service_account.bot_sa.id
                description        = "Static key for bot service account"
              
                depends_on = [
                  yandex_resourcemanager_folder_iam_member.sa_editor
                ]
              }
              
              # Создание бакета
              
              resource "yandex_storage_bucket" "bot_bucket" {
                bucket     = var.bucket_name
                access_key = yandex_iam_service_account_static_access_key.bot_sa_key.access_key
                secret_key = yandex_iam_service_account_static_access_key.bot_sa_key.secret_key
                anonymous_access_flags {
                  read = true
                }
              
                depends_on = [
                  yandex_iam_service_account_static_access_key.bot_sa_key
                ]
              }
              
              # Загрузка картинки в бакет
              
              resource "yandex_storage_object" "sayhello_png" {
                bucket       = yandex_storage_bucket.bot_bucket.bucket
                key          = "sayhello.png"
                source       = "sayhello.png"
                acl          = "public-read"
                access_key   = yandex_iam_service_account_static_access_key.bot_sa_key.access_key
                secret_key   = yandex_iam_service_account_static_access_key.bot_sa_key.secret_key
                content_type = "image/png"
              
                depends_on = [yandex_storage_bucket.bot_bucket]
              }
              
              # Создание zip-архива для функции
              
              data "archive_file" "function" {
                type        = "zip"
                source {
                  content  = templatefile("telegram-bot-function.tpl", {
                    API_GW_URL = yandex_api_gateway.bot_gateway.domain
                  })
                  filename = "index.js"
                }
                source {
                  content  = "${file("package.json")}"
                  filename = "package.json"
                }
                output_path = "function.zip"
              
                depends_on = [yandex_api_gateway.bot_gateway]
              }
              
              # Создание публичной функции
              
              resource "yandex_function" "telegram_bot_function" {
                name               = "fshtb-function"
                description        = "Serverless Telegram bot on Node.js"
                runtime            = "nodejs22"
                entrypoint         = "index.handler"
                memory             = 256
                execution_timeout  = 5
                service_account_id = yandex_iam_service_account.bot_sa.id
              
                environment = {
                  BOT_TOKEN = var.bot_token
                }
              
                content {
                  zip_filename = "function.zip"
                }
              
                user_hash = filesha256("telegram-bot-function.tpl")
              
                depends_on = [
                  yandex_resourcemanager_folder_iam_member.sa_editor,
                  yandex_resourcemanager_folder_iam_member.sa_invoker,
                  data.archive_file.function
                ]
              }
              
              resource "yandex_function_iam_binding" "public_invoker" {
                function_id = yandex_function.telegram_bot_function.id
                role        = "functions.functionInvoker"
                members     = ["system:allUsers"]
              }
              
              # Создание API-шлюза
              
              resource "yandex_api_gateway" "bot_gateway" {
                name        = "forserverless-hello-telegram-bot"
                description = "API gateway for telegram bot"
              
                spec = templatefile("telegram-bot-gw-spec.tpl", {
                  BUCKET_NAME = yandex_storage_bucket.bot_bucket.id
                  OBJECT_NAME = yandex_storage_object.sayhello_png.key
                  SA_ID       = yandex_iam_service_account.bot_sa.id
                })
              }
              ```

              {% endcut %}

          1. Шаблон для создания функции Yandex Cloud Functions `telegram-bot-function.tpl`:

              {% cut "telegram-bot-function.tpl" %}

              ```js
              const { Telegraf } = require('telegraf');
              
              const bot = new Telegraf(process.env.BOT_TOKEN);
              bot.start((ctx) => ctx.reply(`Hello. \nMy name Serverless Hello Telegram Bot \nI'm working on Cloud Function in the Yandex.Cloud.`))
              bot.help((ctx) => ctx.reply(`Hello, ${ctx.message.from.username}.\nI can say Hello and nothing more`))
              bot.on('text', (ctx) => {
                  ctx.replyWithPhoto({url: 'https://${API_GW_URL}/sayhello.png'});
                  ctx.reply(`Hello, ${ctx.message.from.username}`);
              });
              
              module.exports.handler = async function (event, context) {
                  const message = JSON.parse(event.body);
                  await bot.handleUpdate(message);
                  return {
                      statusCode: 200,
                      body: '',
                  };
              }; 
              ```

              {% endcut %}

          1. Шаблон спецификации API-шлюза `telegram-bot-gw-spec.tpl`:

              {% cut "telegram-bot-gw-spec.tpl" %}

              ```yaml
              openapi: 3.0.0
              info:
                title: for-serverless-hello-telegram-bot
                version: 1.0.0
              paths:
                /sayhello.png:
                  get:
                    x-yc-apigateway-integration:
                      type: object-storage
                      bucket: ${BUCKET_NAME}
                      object: ${OBJECT_NAME}
                      presigned_redirect: false
                      service_account: ${SA_ID}
                    operationId: static
              ```

              {% endcut %}

          1. Файл с пользовательскими данными `telegram-bot.auto.tfvars`:

              ```text
              bot_token   = "<токен_Telegram-бота>"
              bucket_name = "<имя_бакета>"
              cloud_id    = "<идентификатор_облака>"
              folder_id   = "<идентификатор_каталога>"
              ```

          1. Манифест для функции Node.js `package.json`:

              ```json
              {
                "name": "ycf-telegram-example",
                "version": "1.0.0",
                "description": "",
                "main": "index.js",
                "scripts": {
                  "test": "echo \"Error: no test specified\" && exit 1"
                },
                "author": "",
                "license": "MIT",
                "dependencies": {
                  "telegraf": "^4.12.0"
                }
              }
              ```

    {% endlist %}

    Подробнее о параметрах используемых ресурсов в Terraform смотрите в документации провайдера:
    * [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account](../../../terraform/resources/iam_service_account.md).
    * Назначение [роли](../../../iam/concepts/access-control/roles.md) сервисному аккаунту — [yandex_resourcemanager_folder_iam_member](../../../terraform/resources/resourcemanager_folder_iam_member.md).
    * [Статический ключ доступа](../../../iam/concepts/authorization/access-key.md) — [yandex_iam_service_account_static_access_key](../../../terraform/resources/iam_service_account_static_access_key.md).
    * [Бакет](../../concepts/bucket.md) — [yandex_storage_bucket](../../../terraform/resources/storage_bucket.md).
    * [Объект](../../concepts/object.md) — [yandex_storage_object](../../../terraform/resources/storage_object.md).
    * [API-шлюз](../../../api-gateway/concepts/index.md) — [yandex_api_gateway](../../../terraform/resources/api_gateway.md).
    * [Функция](../../../functions/concepts/index.md) — [yandex_function](../../../terraform/resources/function.md).
    * Назначение [роли на функцию](../../../functions/security/index.md) — [yandex_function_iam_binding](../../../terraform/resources/function_iam_binding.md).

1. В файле `telegram-bot.auto.tfvars` задайте пользовательские параметры:
   * `bot_token` — токен Telegram-бота.
   * `bucket_name` — имя бакета.
   * `cloud_id` — идентификатор облака.
   * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).

1. Создайте ресурсы:

    1. В терминале перейдите в директорию с конфигурационным файлом.
    1. Проверьте корректность конфигурации с помощью команды:
    
       ```bash
       terraform validate
       ```
    
       Если конфигурация является корректной, появится сообщение:
    
       ```bash
       Success! The configuration is valid.
       ```
    
    1. Выполните команду:
    
       ```bash
       terraform plan
       ```
    
       В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
    1. Примените изменения конфигурации:
    
       ```bash
       terraform apply
       ```
    
    1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

1. Настройте связь между функцией и Telegram-ботом.

    1. Измените спецификацию API-шлюза — после имеющихся строчек кода добавьте секцию `fshtb-function`:

        ```yaml
          /fshtb-function:
            post:
              x-yc-apigateway-integration:
                type: cloud_functions
                function_id: <идентификатор_функции>
              operationId: fshtb-function
        ```
        
        Где `function_id` — идентификатор функции `fshtb-function`.

    1. Примените изменения конфигурации:

        ```bash
        terraform apply
        ```

    1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

    1. В терминале выполните следующую команду: вместо `<токен_бота>` укажите токен Telegram-бота, вместо `<домен_API-шлюза>` — служебный домен API-шлюза:
       
       * Linux, macOS:
       
          ```bash
          curl \
            --request POST \
            --url https://api.telegram.org/bot<токен_бота>/setWebhook \
            --header 'content-type: application/json' \
            --data '{"url": "<домен_API-шлюза>/fshtb-function"}'
          ```
       
       * Windows (cmd):
       
          ```bash
          curl ^
            --request POST ^
            --url https://api.telegram.org/bot<токен_бота>/setWebhook ^
            --header "content-type: application/json" ^
            --data "{\"url\": \"<домен_API-шлюза>/fshtb-function\"}"
          ```
       
       * Windows (PowerShell):
       
          ```powershell
          curl.exe `
            --request POST `
            --url https://api.telegram.org/bot<токен_бота>/setWebhook `
            --header '"content-type: application/json"' `
            --data '"{ \"url\": \"<домен_API-шлюза>/fshtb-function\" }"'
          ```
       
       Результат:
       
       ```json
       {"ok":true,"result":true,"description":"Webhook was set"}
       ```


## Проверьте работу Telegram-бота {#test-bot}

Поговорите с ботом:

1. Откройте Telegram и найдите бота по имени пользователя `username`, созданному ранее.
1. Отправьте в чат сообщение `/start`.

    Бот должен ответить:
    
    ```text
    Hello.
    My name Serverless Hello Telegram Bot
    I'm working on Cloud Functions in the Yandex Cloud.
    ```

1. Отправьте в чат сообщение `/help`.
    
    Бот должен ответить:
    
    ```text
    Hello, <username>.
    I can say Hello and nothing more
    ```

1. Отправьте в чат любое текстовое сообщение. Бот должен в ответ прислать изображение и сообщение: `Hello, <username>`.


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. Откройте конфигурационный файл `telegram-bot.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    1. В терминале перейдите в директорию с конфигурационным файлом.
    1. Проверьте корректность конфигурации с помощью команды:
    
       ```bash
       terraform validate
       ```
    
       Если конфигурация является корректной, появится сообщение:
    
       ```bash
       Success! The configuration is valid.
       ```
    
    1. Выполните команду:
    
       ```bash
       terraform plan
       ```
    
       В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
    1. Примените изменения конфигурации:
    
       ```bash
       terraform apply
       ```
    
    1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.


#### Полезные ссылки {#see-also}

* [Как создать бота в Telegram с помощью Serverless в консоли управления](console.md)