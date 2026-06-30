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

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../../_tutorials_includes/telegram-bot-serverless/paid-resources.md) %}


## Подготовьте ресурсы {#create-resources}

1. [Скачайте](https://sourcecraft.dev/yandex-cloud-examples/yc-telegram-bot-serverless/browse/sayhello.png?rev=main) изображение для бота.
1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) ему роли `{{ roles-editor }}` и `{{ roles-functions-invoker }}` на ваш каталог.


## Зарегистрируйте Telegram-бота {#create-bot}

{% include [create-bot](../../_tutorials_includes/telegram-bot-serverless/create-bot.md) %}


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

Чтобы Telegram-бот отвечал на команды `/start`, `/help` и отправлял изображение в ответ на любой другой текст, создайте [функцию](../../../functions/concepts/function.md).

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
      bot.start((ctx) => ctx.reply(`Hello. \nMy name Serverless Hello Telegram Bot \nI'm working on Cloud Functions in the Yandex Cloud.`));
      bot.help((ctx) => ctx.reply(`Hello, ${ctx.message.from.username}.\nI can say Hello and nothing more`));
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

      {% include [telegram-bot-package-json](../../_tutorials_includes/telegram-bot-serverless/telegram-bot-package-json.md) %}

  1. Укажите следующие параметры:

      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}** — `nodejs22`;
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** — `index.handler`;
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** — `5`.

  1. Добавьте переменную окружения `BOT_TOKEN`. В поле **{{ ui-key.yacloud.common.value }}** укажите токен Telegram-бота.
  1. Нажмите **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.
  1. Убедитесь, что функция [публичная](../../../functions/operations/function/function-public.md). Для этого на странице **{{ ui-key.yacloud.serverless-functions.item.overview.label_title }}**, в разделе **{{ ui-key.yacloud.common.section-base }}**, переведите переключатель **{{ ui-key.yacloud.serverless-functions.item.overview.label_all-users-invoke }}** в активное состояние.
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

         {% include [telegram-bot-function-bind](../../_tutorials_includes/telegram-bot-serverless/telegram-bot-function-bind.md) %}

      1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.form.button_update-gateway }}**.

    {% endlist %}

1. {% include [telegram-bot-setwebhook](../../_tutorials_includes/telegram-bot-serverless/telegram-bot-setwebhook.md) %}


## Проверьте работу Telegram-бота {#test-bot}

{% include [test-bot](../../_tutorials_includes/telegram-bot-serverless/test-bot.md) %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. [Удалите](../../../functions/operations/function/function-delete.md) функцию.
1. [Удалите](../../../api-gateway/operations/api-gw-delete.md) API-шлюз.
1. [Удалите](../../../storage/operations/buckets/delete.md) бакет.
