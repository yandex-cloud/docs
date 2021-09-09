# Разработка Telegram-бота

В этом сценарии вы узнаете, как с помощью serverless-технологий создать Telegram-бота, который будет отвечать на сообщения в чате.

@[youtube](C2Ahit2EBo0)

Чтобы создать бота:
1. [Подготовьте окружение](#start)
1. [Зарегистрируйте Telegram-бота](#create-bot)
1. [Опубликуйте картинку для бота](#image-publish)
1. [Создайте API-шлюз](#create-gateway)
1. [Создайте функцию](#create-function)
1. [Настройте связь между функцией и Telegram-ботом](#function-bind-bot)
1. [Проверьте работу Telegram-бота](#test)

## Подготовьте окружение {#start}

1. [Скачайте](https://storage.yandexcloud.net/doc-files/telegrambot.zip) архив с файлами, необходимыми для создания бота.
1. Если у вас еще нет каталога, [создайте](../resource-manager/operations/folder/create.md) его.
1. [Создайте](../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../iam/operations/sa/assign-role-for-sa.md) ему роли `editor` и `serverless.functions.invoker` на ваш каталог.

## Зарегистрируйте Telegram-бота {#create-bot}

Зарегистрируйте вашего бота в Telegram и получите токен.

1. Для регистрации бота отправьте команду боту [BotFather](https://t.me/BotFather):
    ```
    /newbot
    ```

1. Укажите имя создаваемого бота, например `ServerlessHelloTelegramBot`. Имя должно оканчиваться на `...Bot` или `..._bot`.

   В результате вы получите токен. Сохраните его, он потребуется на следующих шагах.
1. Установите иконку для бота — картинку `sayhello.png` из скачанного архива. Отправьте боту BotFather команду:

    ```
    /setuserpic
    ```

## Опубликуйте картинку для бота {#image-publish}

Чтобы бот отправлял картинку в ответ на сообщения пользователя, создайте бакет в {{ objstorage-name }} и загрузите в него файл `sayhello.png`.

### Создайте бакет в {{ objstorage-name }} {#create-bucket}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{link-console-main}}) выберите каталог, в котором хотите создать [бакет](../storage/concepts/bucket.md).
  1. Откройте сервис **Object Storage**.
  1. Нажмите кнопку **Создать бакет**.
  1. На странице создания бакета:
      1. Введите имя бакета — `for-serverless-hello-telegram-bot`.
      1. Укажите настройки бакета:
         * **Макс. размер** — `1 ГБ`.
         * **Доступ на чтение объектов** — `Публичный`.
         * **Класс хранилища** — `Стандартное`.
      1. Нажмите кнопку **Создать бакет**.

{% endlist %}

### Загрузите картинку в бакет

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{link-console-main}}) выберите каталог, в котором находится бакет `for-serverless-hello-telegram-bot`.
  1. Откройте сервис **Object Storage**.
  1. Выберите бакет `for-serverless-hello-telegram-bot`.
  1. Нажмите **Загрузить**.
  1. В появившемся окне выберите картинку `sayhello.png` и нажмите кнопку **Открыть**. Консоль управления отобразит файл, выбранный для загрузки.
  1. Нажмите **Загрузить**.

{% endlist %}

### Получите ссылку на загруженную картинку

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{link-console-main}}) выберите каталог, в котором находится бакет `for-serverless-hello-telegram-bot`.
  1. Откройте сервис **Object Storage**.
  1. Выберите бакет `for-serverless-hello-telegram-bot`.
  1. Выберите файл `sayhello.png`.
  1. Нажмите кнопку **Получить ссылку**.
  1. Проверьте доступность картинки по ссылке в браузере.

{% endlist %}

## Создайте API-шлюз {#create-gateway}

Создайте и сконфигурируйте [API-шлюз](../api-gateway/concepts/index.md).

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать API-шлюз.
    1. Откройте сервис  **{{ api-gw-name }}**.
    1. Нажмите кнопку **Создать API-шлюз**.
    1. Введите имя шлюза — `for-serverless-hello-telegram-bot`.
    1. Обновите спецификацию. В поле `service_account` укажите идентификатор сервисного аккаунта, который создали ранее:
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
                bucket: for-serverless-hello-telegram-bot
                object: sayhello.png
                presigned_redirect: false
                service_account: <идентификатор сервисного аккаунта>
              operationId: static
        ```
    1. Нажмите кнопку **Создать**.

    Сохраните поле **Служебный домен** из раздела **Общая информация**. Служебный домен API-шлюза понадобится для обращения к картинке `sayhello.png`.

{% endlist %}

## Создайте функцию {#create-function}

Чтобы бот отвечал на команды `/start`, `/help` и отправлял картинку в ответ на любой другой текст, создайте [функцию](../functions/concepts/function.md).

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать функцию.
    1. Откройте сервис **{{ sf-name }}**
    1. Нажмите кнопку **Создать функцию**.
    1. Введите имя функции — `fshtb-function`.
    1. Нажмите кнопку **Создать**.
    1. В блоке **Редактор** выберите среду выполнения `Node.js` и нажмите **Продолжить**.
    1. В блоке **Код функции** очистите содержимое файла `index.js` и вставьте в него следующий код. Вместо `<домен API-шлюза>` укажите служебный домен API-шлюза.

        ```javascript
        const { Telegraf } = require('telegraf');

        const bot = new Telegraf(process.env.BOT_TOKEN);
        bot.start((ctx) => ctx.reply(`Hello. \nMy name Serverless Hello Teleram Bot \nI'm working on Cloud Function in the Yandex.Cloud.`))
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

    1. В блоке **Код функции** создайте файл `package.json` и вставьте в него следующий текст:

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
        * среду выполнения — `node12js`;
        * точку входа — `index.handler`;
        * таймаут — `5 секунд`.
    1. Добавьте переменную окружения `BOT_TOKEN`. В поле **Значение** укажите токен Telegram-бота.
    1. Нажмите **Создать версию**.
    1. Убедитесь, что функция [публичная](../functions/operations/function-public.md#public). Для этого на странице **Обзор**, в разделе **Общая информация**, переведите переключатель **Публичная функция** в активное состояние.
    
    Сохраните идентификатор вашей функции, он потребуется на следующих шагах.

{% endlist %}

## Настройте связь между функцией и Telegram-ботом {#function-bind-bot}

1. В [консоли управления]({{ link-console-main }}) выберите каталог.
1. Откройте сервис **{{ api-gw-name }}**.
1. Выберите API-шлюз `for-serverless-hello-telegram-bot`.
1. Измените спецификацию API-шлюза — добавьте в конец секцию `fshtb-function`. В поле `function_id` укажите идентификатор функции `fshtb-function`.
    ```yml
      /fshtb-function:
        post:
          x-yc-apigateway-integration:
            type: cloud-functions
            function_id: <идентификатор функции>
          operationId: fshtb-function
    ```

1. Нажмите кнопку **Сохранить**.
1. Выполните запрос:
    ```bash
    curl --request POST --url https://api.telegram.org/bot<токен бота>/setWebhook \
    --header 'content-type: application/json' --data '{"url": "<домен API-шлюза>/fshtb-function"}'
    ```

    * `<токен бота>` — токен Telegram-бота.
    * `<домен API-шлюза>` — служебный домен API-шлюза.

    Результат:

    ```
    {"ok":true,"result":true,"description":"Webhook was set"}
    ```

## Проверьте работу Telegram-бота {#test}

Поговорите с ботом:

1. Откройте Telegram и найдите бота.
1. Отправьте в чат сообщение `/start`.

    Бот должен ответить:
    ```text
    Hello.
    My name Serverless Hello Teleram Bot
    I'm working on Cloud Function in the Yandex.Cloud.
    ```

1. Отправьте в чат сообщение `/help`. 
    
    Бот должен ответить:
    ```text
    Hello, <username>.
    I can say Hello and nothing more
    ```

1. Отправьте в чат любое текстовое сообщение. Бот должен в ответ прислать картинку и сообщение: `Hello, <username>`.
