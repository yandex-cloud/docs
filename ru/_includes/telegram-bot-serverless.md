# Как создать бота в Telegram

С помощью serverless-технологий можно создать Telegram-бота, который будет отвечать на сообщения в чате.

{% if lang == "ru" %}
@[youtube](C2Ahit2EBo0)
{% endif %}

Чтобы создать бота:
1. [Подготовьте окружение](#start).
1. [Зарегистрируйте Telegram-бота](#create-bot).
1. [Опубликуйте изображение для бота](#image-publish).
1. [Создайте API-шлюз](#create-gateway).
1. [Создайте функцию](#create-function).
1. [Настройте связь между функцией и Telegram-ботом](#function-bind-bot).
1. [Проверьте работу Telegram-бота](#test-bot).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте окружение {#start}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}

1. [Скачайте](https://storage.yandexcloud.net/doc-files/telegrambot.zip) архив с файлами, необходимыми для создания бота.
1. [Создайте](../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../iam/operations/sa/assign-role-for-sa.md) ему роли `editor` и `serverless.functions.invoker` на ваш каталог. 

{% if product == "yandex-cloud" %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки Telegram-бота входит:
* плата за количество вызовов функции, вычислительные ресурсы, выделенные для выполнения функции, и исходящий трафик (см. [тарифы {{ sf-name }}](../functions/pricing.md));
* плата за объем хранилища, занятый данными, количество операций с данными и исходящий трафик (см. [тарифы {{ objstorage-name }}](../storage/pricing.md));
* плата за количество запросов к созданному API-шлюзу и исходящий трафик (см. [тарифы {{ api-gw-full-name }}](../api-gateway/pricing.md)).

{% endif %}

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

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать [бакет](../storage/concepts/bucket.md).
  1. Выберите сервис **{{ objstorage-short-name }}**.
  1. Нажмите кнопку **Создать бакет**.
  1. На странице создания бакета:
      1. Введите имя бакета, например `for-serverless-hello-telegram-bot`. Сохраните имя бакета, оно потребуется в дальнейшем.
      1. Укажите настройки бакета:
         * **Макс. размер** — `1 ГБ`.
         * **Доступ на чтение объектов** — `Публичный`.
         * **Класс хранилища** — `Стандартное`.
      1. Нажмите кнопку **Создать бакет**.

{% endlist %}

### Загрузите изображение в бакет {#upload-image}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится ранее созданный бакет.
  1. Выберите сервис **{{ objstorage-short-name }}**.
  1. Выберите ранее созданный бакет.
  1. Нажмите **Загрузить**.
  1. В появившемся окне выберите файл `sayhello.png` из сохраненного архива и нажмите кнопку **Открыть**. Консоль управления отобразит файл, выбранный для загрузки.
  1. Нажмите **Загрузить**.

{% endlist %}

### Получите ссылку на загруженное изображение {#get-image-link}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится ранее созданный бакет.
  1. Выберите сервис **{{ objstorage-short-name }}**.
  1. Выберите ранее созданный бакет.
  1. Выберите файл `sayhello.png`.
  1. Нажмите кнопку **Получить ссылку**.
  1. Проверьте доступность изображения по ссылке в браузере.

{% endlist %}

## Создайте API-шлюз {#create-gateway}

Создайте и сконфигурируйте [API-шлюз](../api-gateway/concepts/index.md).

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать API-шлюз.
  1. Выберите сервис **{{ api-gw-name }}**.
  1. Нажмите кнопку **Создать API-шлюз**.
  1. Введите имя шлюза — `for-serverless-hello-telegram-bot`.
  1. Очистите содержимое поля **Спецификация** и вставьте в него следующий код. В поле `bucket` укажите имя бакета. В поле `service_account_id` укажите [идентификатор сервисного аккаунта](../iam/operations/sa/get-id.md).

      ```yml
      openapi: 3.0.0
      info:
        title: for-serverless-hello-telegram-bot
        version: 1.0.0
      paths:
        /sayhello.png:
          get:
            x-yc-apigateway-integration:
              type: object-storage
              bucket: <имя бакета>
              object: sayhello.png
              presigned_redirect: false
              service_account_id: <идентификатор сервисного аккаунта>
            operationId: static
      ```

  1. Нажмите кнопку **Создать**.
  1. Выберите созданный API-шлюз. Сохраните значение поля **Служебный домен** из раздела **Общая информация**, оно потребуется в дальнейшем.

{% endlist %}

## Создайте функцию {#create-function}

Чтобы Telegram-бот отвечал на команды `/start`, `/help` и отправлял изображение в ответ на любой другой текст, создайте [функцию](../functions/concepts/function.md).

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать функцию.
  1. Выберите сервис **{{ sf-name }}**
  1. Нажмите кнопку **Создать функцию**.
  1. Введите имя функции — `fshtb-function`.
  1. Нажмите кнопку **Создать**.
  1. В блоке **Редактор** выберите среду выполнения `Node.js` и нажмите **Продолжить**.
  1. В блоке **Код функции** очистите содержимое файла `index.js` и вставьте в него следующий код. Вместо `<домен API-шлюза>` укажите служебный домен API-шлюза.

      ```javascript
      const { Telegraf } = require('telegraf');

      const bot = new Telegraf(process.env.BOT_TOKEN);
      bot.start((ctx) => ctx.reply(`Hello. \nMy name Serverless Hello Telegram Bot \nI'm working on Cloud Function in the Yandex Cloud.`))
      bot.help((ctx) => ctx.reply(`Hello, ${ctx.message.from.username}.\nI can say Hello and nothing more`))
      bot.on('text', (ctx) => {
          ctx.replyWithPhoto('<домен API-шлюза>/sayhello.png');
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

  1. В блоке **Код функции** создайте файл `package.json` и вставьте в него следующий код:

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
          "telegraf": "^3.38.0"
        }
      }
      ```

  1. Укажите:
      * среду выполнения — `nodejs12`;
      * точку входа — `index.handler`;
      * таймаут — `5 секунд`.
  1. Добавьте переменную окружения `BOT_TOKEN`. В поле **Значение** укажите токен Telegram-бота.
  1. Нажмите **Создать версию**.
  1. Убедитесь, что функция [публичная](../functions/operations/function-public.md#public). Для этого на странице **Обзор**, в разделе **Общая информация**, переведите переключатель **Публичная функция** в активное состояние.
  1. Сохраните идентификатор вашей функции, он потребуется в дальнейшем.

{% endlist %}

## Настройте связь между функцией и Telegram-ботом {#function-bind-bot}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Выберите сервис **{{ api-gw-name }}**.
  1. Выберите API-шлюз `for-serverless-hello-telegram-bot`.
  1. Измените спецификацию API-шлюза — после имеющихся строчек кода добавьте секцию `fshtb-function`. В поле `function_id` укажите идентификатор функции `fshtb-function`.

      ```yml
        /fshtb-function:
          post:
            x-yc-apigateway-integration:
              type: cloud-functions
              function_id: <идентификатор функции>
            operationId: fshtb-function
      ```

  1. Нажмите кнопку **Сохранить**.
  1. Выполните запрос, вместо `<токен бота>` укажите токен Telegram-бота, вместо `<домен API-шлюза>` — служебный домен API-шлюза:
      * Linux, macOS:

        ```bash
        curl --request POST --url https://api.telegram.org/bot<токен бота>/setWebhook \
          --header 'content-type: application/json' --data '{"url": "<домен API-шлюза>/fshtb-function"}'
        ```
    
      * Windows (cmd):

        ```bash
        curl --request POST --url https://api.telegram.org/bot<токен бота>/setWebhook ^
          --header "content-type: application/json" --data "{\"url\": \"<домен API-шлюза>/fshtb-function\"}"
        ```

      * Windows (PowerShell):
      
        ```powershell
        curl.exe --request POST --url https://api.telegram.org/bot<токен бота>/setWebhook `
          --header '"content-type: application/json"' --data '"{ \"url\": \"<домен API-шлюза>/fshtb-function\" }"'
        ``` 
      
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

Чтобы перестать платить за созданные ресурсы, удалите их:
1. [Удалите функцию](../functions/operations/function/function-delete.md).
1. [Удалите API-шлюз](../api-gateway/operations/api-gw-delete.md).
1. [Удалите бакет](../storage/operations/buckets/delete.md).
