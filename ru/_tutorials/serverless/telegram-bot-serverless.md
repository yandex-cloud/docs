# Как создать бота в Telegram


С помощью serverless-технологий можно создать [бота](../../glossary/chat-bot.md) для Telegram, который будет отвечать на сообщения в чате.

@[youtube](C2Ahit2EBo0)

Чтобы создать бота:

1. [Подготовьте окружение](#before-begin).
1. [Подготовьте ресурсы](#create-resources).
1. [Зарегистрируйте Telegram-бота](#create-bot).
1. [Опубликуйте изображение для бота](#image-publish).
1. [Создайте API-шлюз](#create-gateway).
1. [Создайте функцию](#create-function).
1. [Настройте связь между функцией и Telegram-ботом](#function-bind-bot).
1. [Проверьте работу Telegram-бота](#test-bot).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки Telegram-бота входят:

* плата за количество вызовов функции, вычислительные ресурсы, выделенные для выполнения функции, и исходящий трафик (см. [тарифы {{ sf-name }}](../../functions/pricing.md));
* плата за объем хранилища, занятый данными, количество операций с данными и исходящий трафик (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md));
* плата за количество запросов к созданному API-шлюзу и исходящий трафик (см. [тарифы {{ api-gw-full-name }}](../../api-gateway/pricing.md)).


## Подготовьте ресурсы {#create-resources}

1. [Скачайте](https://{{ s3-storage-host }}/doc-files/telegrambot.zip) архив с файлами, необходимыми для создания бота.
1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему роли `{{ roles-editor }}` и `{{ roles-functions-invoker }}` на ваш каталог. 

## Зарегистрируйте Telegram-бота {#create-bot}

Зарегистрируйте вашего бота в Telegram и получите токен.

1. Для регистрации нового бота запустите бота [BotFather](https://t.me/BotFather) и отправьте команду:

    ```
    /newbot
    ```

1. В поле `name` укажите имя создаваемого бота, например `Serverless Hello Telegram Bot`. Это имя увидят пользователи при общении с ботом.
1. В поле `username` укажите имя пользователя создаваемого бота, например `ServerlessHelloTelegramBot`. По имени пользователя можно будет найти бота в Telegram. Имя пользователя должно оканчиваться на `...Bot` или `..._bot`.

    В результате вы получите токен. Сохраните его, он потребуется в дальнейшем.

1. Установите иконку для бота — файл `sayhello.png` из сохраненного архива. Отправьте боту BotFather команду:

    ```
    /setuserpic
    ```

## Опубликуйте изображение для бота {#image-publish}

Чтобы бот отправлял изображение в ответ на сообщения пользователя, создайте бакет в {{ objstorage-name }} и загрузите в него файл `sayhello.png` из сохраненного архива.

### Создайте бакет в {{ objstorage-name }} {#create-bucket}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать [бакет](../../storage/concepts/bucket.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. На странице создания бакета:

      1. Введите имя бакета. Сохраните имя бакета, оно потребуется в дальнейшем.
      1. Укажите настройки бакета:

          * **{{ ui-key.yacloud.storage.bucket.settings.field_size-limit }}** — `1 {{ ui-key.yacloud_portal.common.units.label_gigabyte }}`;
          * **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}** — `{{ ui-key.yacloud.storage.bucket.settings.access_value_public }}`;
          * **{{ ui-key.yacloud.storage.bucket.settings.field_class }}** — `{{ ui-key.yacloud.storage.bucket.settings.class_value_standard }}`.

      1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

{% endlist %}

### Загрузите изображение в бакет {#upload-image}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится ранее созданный бакет.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Выберите ранее созданный бакет.
  1. Нажмите **{{ ui-key.yacloud.storage.bucket.button_upload }}**.
  1. В появившемся окне выберите файл `sayhello.png` из сохраненного архива. Консоль управления отобразит файл, выбранный для загрузки.
  1. Нажмите **{{ ui-key.yacloud.storage.button_upload }}**.

{% endlist %}

### Получите ссылку на загруженное изображение {#get-image-link}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится ранее созданный бакет.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Выберите ранее созданный бакет.
  1. Выберите файл `sayhello.png`.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.file.button_generate }}**.
  1. Проверьте доступность изображения по ссылке в браузере.

{% endlist %}

## Создайте API-шлюз {#create-gateway}

Создайте и сконфигурируйте [API-шлюз](../../api-gateway/concepts/index.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать API-шлюз.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**.
  1. Введите имя шлюза — `for-serverless-hello-telegram-bot`.
  1. Очистите содержимое поля **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** и вставьте в него следующий код:

      ```yml
      openapi: 3.0.0
      info:
        title: for-serverless-hello-telegram-bot
        version: 1.0.0
      paths:
        /sayhello.png:
          get:
            x-yc-apigateway-integration:
              type: object_storage
              bucket: <имя_бакета>
              object: sayhello.png
              presigned_redirect: false
              service_account_id: <идентификатор_сервисного_аккаунта>
            operationId: static
      ```
      
      Где:
      * `bucket` — имя бакета;
      * `service_account_id` — [идентификатор сервисного аккаунта](../../iam/operations/sa/get-id.md), созданного ранее при [подготовке ресурсов](#create-resources).

  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.form.button_create-gateway }}**.
  1. Выберите созданный API-шлюз. Сохраните значение поля **{{ ui-key.yacloud.serverless-functions.gateways.overview.label_domain }}**, оно потребуется в дальнейшем.

{% endlist %}

## Создайте функцию {#create-function}

Чтобы Telegram-бот отвечал на команды `/start`, `/help` и отправлял изображение в ответ на любой другой текст, создайте [функцию](../../functions/concepts/function.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать функцию.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
  1. Введите имя функции — `fshtb-function`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}** выберите среду выполнения `Node.js` и нажмите **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-source }}** очистите содержимое файла `index.js` и вставьте в него следующий код. Вместо `<домен_API-шлюза>` укажите служебный домен API-шлюза.

      ```javascript
      const { Telegraf } = require('telegraf');

      const bot = new Telegraf(process.env.BOT_TOKEN);
      bot.start((ctx) => ctx.reply(`Hello. \nMy name Serverless Hello Telegram Bot \nI'm working on Cloud Function in the Yandex Cloud.`))
      bot.help((ctx) => ctx.reply(`Hello, ${ctx.message.from.username}.\nI can say Hello and nothing more`))
      bot.on('text', (ctx) => {
          ctx.replyWithPhoto({url: '<домен_API-шлюза>/sayhello.png'});
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

  1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-source }}** создайте файл `package.json` и вставьте в него следующий код:

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

  1. Укажите следующие параметры:

      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}** — `nodejs16`;
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** — `index.handler`;
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** — `5`.

  1. Добавьте переменную окружения `BOT_TOKEN`. В поле **{{ ui-key.yacloud.common.value }}** укажите токен Telegram-бота.
  1. Нажмите **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.
  1. Убедитесь, что функция [публичная](../../functions/operations/function/function-public.md). Для этого на странице **{{ ui-key.yacloud.serverless-functions.item.overview.label_title }}**, в разделе **{{ ui-key.yacloud.common.section-base }}**, переведите переключатель **{{ ui-key.yacloud.serverless-functions.item.overview.label_all-users-invoke }}** в активное состояние.
  1. Сохраните идентификатор вашей функции, он потребуется в дальнейшем.

{% endlist %}

## Настройте связь между функцией и Telegram-ботом {#function-bind-bot}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. Выберите API-шлюз `for-serverless-hello-telegram-bot`.
  1. Измените спецификацию API-шлюза — после имеющихся строчек кода добавьте секцию `fshtb-function`:

      ```yml
        /fshtb-function:
          post:
            x-yc-apigateway-integration:
              type: cloud_functions
              function_id: <идентификатор_функции>
            operationId: fshtb-function
      ```
      
      Где `function_id` — идентификатор функции `fshtb-function`.

  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.form.button_update-gateway }}**.
  1. Выполните запрос в терминале:

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

      Где:

      * `<токен_бота>` — токен Telegram-бота.
      * `<домен_API-шлюза>` — служебный домен API-шлюза.

      Результат:

      ```bash
      {"ok":true,"result":true,"description":"Webhook was set"}
      ```

{% endlist %}

## Проверьте работу Telegram-бота {#test-bot}

Поговорите с ботом:

1. Откройте Telegram и найдите бота по имени пользователя `username`, созданному ранее.
1. Отправьте в чат сообщение `/start`.

    Бот должен ответить:
    
    ```text
    Hello.
    My name Serverless Hello Telegram Bot
    I'm working on Cloud Function in the Yandex Cloud.
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
* [удалите функцию](../../functions/operations/function/function-delete.md);
* [удалите API-шлюз](../../api-gateway/operations/api-gw-delete.md);
* [удалите бакет](../../storage/operations/buckets/delete.md).
