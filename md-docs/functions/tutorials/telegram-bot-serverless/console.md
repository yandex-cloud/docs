# Как создать бота в Telegram с помощью Serverless в консоли управления


Чтобы [создать бота в Telegram](index.md) с помощью Serverless в консоли управления {{ yandex-cloud }}:

1. [Подготовьте облако к работе](#before-begin).
1. [Подготовьте ресурсы](#create-resources).
1. [Зарегистрируйте Telegram-бота](#create-bot).
1. [Опубликуйте изображение для бота](#image-publish).
1. [Создайте API-шлюз](#create-gateway).
1. [Создайте функцию](#create-function).
1. [Настройте связь между функцией и Telegram-ботом](#function-bind-bot).
1. [Проверьте работу Telegram-бота](#test-bot).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры Telegram-бота входят:
* плата за вызовы [функции](../../concepts/function.md), вычислительные ресурсы, выделенные для выполнения функции, и исходящий трафик (см. [тарифы {{ sf-name }}](../../pricing.md));
* плата за [хранение данных](../../../storage/concepts/bucket.md) в {{ objstorage-name }}, [операции](../../../storage/operations/index.md) с ними и исходящий трафик (см. [тарифы {{ objstorage-name }}](../../../storage/pricing.md));
* плата за количество запросов к созданному [API-шлюзу](../../../api-gateway/concepts/index.md) и исходящий трафик (см. [тарифы {{ api-gw-full-name }}](../../../api-gateway/pricing.md)).


## Подготовьте ресурсы {#create-resources}

1. [Скачайте](https://sourcecraft.dev/yandex-cloud-examples/yc-telegram-bot-serverless/browse/sayhello.png?rev=main) изображение для бота.
1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) ему роли `{{ roles-editor }}` и `{{ roles-functions-invoker }}` на ваш каталог.


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


## Опубликуйте изображение для бота {#image-publish}

Чтобы бот отправлял изображение в ответ на сообщения пользователя, создайте бакет в {{ objstorage-name }} и загрузите в него файл `sayhello.png` из сохраненного архива.


### Создайте бакет в {{ objstorage-name }} {#create-bucket}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать [бакет](../../../storage/concepts/bucket.md).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. На странице создания бакета:

      1. Введите имя бакета. Сохраните имя бакета, оно потребуется в дальнейшем.
      1. Укажите настройки бакета:

          * **{{ ui-key.yacloud.storage.bucket.settings.field_size-limit }}** — `1 {{ ui-key.yacloud_portal.common.units.label_gigabyte }}`;
          * **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}** — `{{ ui-key.yacloud.storage.bucket.settings.access_value_public }}`;
          * **{{ ui-key.yacloud.storage.bucket.settings.field_class }}** — `{{ ui-key.yacloud.storage.value_standard }}`.

      1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

{% endlist %}


### Загрузите изображение в бакет {#upload-image}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится ранее созданный бакет.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Выберите ранее созданный бакет.
  1. Нажмите **{{ ui-key.yacloud.storage.bucket.button_upload }}**.
  1. В появившемся окне выберите файл `sayhello.png` из сохраненного архива. Консоль управления отобразит файл, выбранный для загрузки.
  1. Нажмите **{{ ui-key.yacloud.storage.button_upload }}**.

{% endlist %}


### Получите ссылку на загруженное изображение {#get-image-link}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится ранее созданный бакет.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Выберите ранее созданный бакет.
  1. Выберите файл `sayhello.png`.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.file.button_generate }}**.
  1. Проверьте доступность изображения по ссылке в браузере.

{% endlist %}


## Создайте API-шлюз {#create-gateway}

Для взаимодействия бота с функцией создайте и сконфигурируйте [API-шлюз](../../../api-gateway/concepts/index.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать API-шлюз.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**.
  1. Введите имя шлюза — `for-serverless-hello-telegram-bot`.
  1. Очистите содержимое поля **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** и вставьте в него следующий код:

      ```yaml
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
      * `service_account_id` — [идентификатор сервисного аккаунта](../../../iam/operations/sa/get-id.md), созданного ранее при [подготовке ресурсов](#create-resources).

  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.form.button_create-gateway }}**.
  1. Выберите созданный API-шлюз. Сохраните значение поля **{{ ui-key.yacloud.serverless-functions.gateways.overview.label_domain }}**, оно потребуется при создании функции.

{% endlist %}


## Создайте функцию {#create-function}

Чтобы Telegram-бот отвечал на команды `/start`, `/help` и отправлял изображение в ответ на любой другой текст, создайте [функцию](../../concepts/function.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать функцию.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
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

      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}** — `nodejs22`;
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** — `index.handler`;
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** — `5`.

  1. Добавьте переменную окружения `BOT_TOKEN`. В поле **{{ ui-key.yacloud.common.value }}** укажите токен Telegram-бота.
  1. Нажмите **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.
  1. Убедитесь, что функция [публичная](../../operations/function/function-public.md). Для этого на странице **{{ ui-key.yacloud.serverless-functions.item.overview.label_title }}**, в разделе **{{ ui-key.yacloud.common.section-base }}**, переведите переключатель **{{ ui-key.yacloud.serverless-functions.item.overview.label_all-users-invoke }}** в активное состояние.
  1. Сохраните идентификатор вашей функции, он потребуется в дальнейшем.

{% endlist %}


## Настройте связь между функцией и Telegram-ботом {#function-bind-bot}

1. Измените спецификацию API-шлюза:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог.
      1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
      1. Выберите API-шлюз `for-serverless-hello-telegram-bot`.
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

      1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.form.button_update-gateway }}**.

    {% endlist %}

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
   
   ```text
   {"ok":true,"result":true,"description":"Webhook was set"}
   ```

    Где:

    * `<токен_бота>` — токен Telegram-бота.
    * `<домен_API-шлюза>` — служебный домен API-шлюза.

    Результат:

    ```bash
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
1. [Удалите](../../operations/function/function-delete.md) функцию.
1. [Удалите](../../../api-gateway/operations/api-gw-delete.md) API-шлюз.
1. [Удалите](../../../storage/operations/buckets/delete.md) бакет.


#### См. также {#see-also}

* [{#T}](terraform.md)