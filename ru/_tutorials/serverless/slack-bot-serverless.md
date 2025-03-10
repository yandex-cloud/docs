# Как создать чат-бот для Slack


В этом руководстве вы узнаете, как с помощью serverless-технологий создать [бота](../../glossary/chat-bot.md) для Slack, который будет выполнять команды в чате и отвечать на сообщения пользователей.


<iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvy5flbqdb4t6rbaum?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

[Смотреть видео на YouTube](https://www.youtube.com/watch?v=VmqFGYAPN_4).



Чтобы создать бота:

1. [Подготовьте окружение](#prepare).
1. [Создайте приложение и подключите его к {{ yandex-cloud }}](#app).
1. [Получите Token и Secret для приложения](#env).
1. [Создайте функции](#create-functions).
1. [Отредактируйте API-шлюз](#edit-api-gw).
1. [Добавьте команды в Slack](#commands).
1. [Проверьте работу Slack-бота](#test).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки чат-бота входят:

* плата за использование API-шлюза (см. тарифы [{{ api-gw-full-name }}](../../api-gateway/pricing.md));
* плата за использование функций (см. тарифы [{{ sf-full-name }}](../../functions/pricing.md)).

## Подготовьте окружение {#prepare}

1. [Скачайте](https://{{ s3-storage-host }}/doc-files/slackbot.zip) архив с файлами, необходимыми для создания бота.
1. Если у вас еще нет каталога, [создайте](../../resource-manager/operations/folder/create.md) его.
1. [Создайте](../../iam/operations/sa/create.md#create-sa) сервисный аккаунт с именем `sa-slack` и [назначьте](../../iam/operations/roles/grant.md#cloud-or-folder) ему роль `{{ roles-editor }}` на ваш каталог.

## Создайте приложение и подключите его к {{ yandex-cloud }} {#app}

### Зарегистрируйте Slack-приложение {#create-app}

1. Авторизуйтесь в [Slack](https://slack.com/). Чтобы создать бота, у вас должны быть права на управление рабочим пространством.
1. Создайте [приложение](https://api.slack.com/apps):

   1. Нажмите кнопку **Create an App**.
   1. Выберите **From scratch**.
   1. В поле **App Name** введите имя приложения: `ServerlessBotApp`.
   1. Выберите доступное рабочее пространство и нажмите **Create App**.

1. Выдайте разрешения приложению `ServerlessBotApp`:

   1. В меню управления приложением выберите пункт **Features** → **OAuth & Permissions**.
   1. В разделе **Scopes** → **Bot Token Scopes** нажмите кнопку **Add an OAuth Scope** и добавьте разрешения: `chat:write`, `commands`, `im:history`.

1. Установите приложение: в меню управления приложением выберите пункт **Settings** → **Install App** и нажмите **Install to Workspace** → **Allow**.

### Настройте связь между Slack и {{ yandex-cloud }} {#connect-app}

1. [Создайте](../../functions/operations/function/function-create.md) функцию с именем `for-slack-bot-challenge`. Убедитесь, что она [приватная](../../functions/operations/function/function-private.md).
1. [Создайте](../../functions/operations/function/version-manage.md) версию функции:

   1. Укажите следующие параметры:

      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}** — `python312`.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** — `index.handler`.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** — `5`.
      * **{{ ui-key.yacloud.forms.label_service-account-select }}** — созданный [ранее](#prepare) сервисный аккаунт `sa-slack`.

   1. Создайте файл `index.py` и вставьте в него содержимое файла `0_for-slack-bot-challenge.py` из [архива](#prepare).

1. [Создайте](../../api-gateway/operations/api-gw-create.md) API-шлюз:

   1. Укажите имя `for-slack-bot`.
   1. В поле **{{ ui-key.yacloud.serverless-functions.gateways.overview.section_spec }}** добавьте в параметр `paths` конфигурацию метода `POST`:

      ```yaml
      paths:
        /:
          get:
            x-yc-apigateway-integration:
              type: dummy
              content:
                '*': Hello, World!
              http_code: 200
              http_headers:
                Content-Type: text/plain
          post:
            x-yc-apigateway-integration:
              type: cloud_functions
              function_id: <идентификатор_функции>
              service_account_id: <идентификатор_сервисного_аккаунта>
              operationId: slack-challenge
         ```

         Где:

         * `function_id` — идентификатор функции `for-slack-bot-challenge`.
         * `service_account_id` — идентификатор сервисного аккаунта `sa-slack`.

### Проверьте связь между Slack и {{ yandex-cloud }} {#connect-test}

1. Скопируйте служебный домен API-шлюза `for-slack-bot`.
1. Выберите [приложение](https://api.slack.com/apps) `ServerlessBotApp`.
1. В меню управления приложением выберите пункт **Features** → **Event Subscriptions**.
1. Включите опцию **Enable Events**.
1. В поле **Request URL** вставьте адрес API-шлюза и дождитесь появления записи `Verified`.
1. В разделе **Subscribe to bot events** нажмите кнопку **Add Bot User Event** и выберите событие `message.im`.
1. Нажмите кнопку **Save Changes**.

## Получите Token и Secret для приложения {#env}

Выберите [приложение](https://api.slack.com/apps) `ServerlessBotApp`:

1. В меню управления приложением выберите пункт **Settings** → **Basic Information**.
1. Скопируйте значение поля **Signing Secret** из раздела **App Credentials**: оно будет использоваться для переменной окружения `SLACK_SIGNING_SECRET`.
1. В меню управления приложением выберите пункт **Features** → **OAuth & Permissions**.
1. В разделе **OAuth Tokens for Your Workspace** скопируйте значение поля **Bot User OAuth Token**: оно будет использоваться для переменной окружения `SLACK_BOT_TOKEN`.

## Создайте функции {#create-functions}

С помощью функций можно настраивать реакции бота на действия пользователей в чате. В руководстве будут созданы функции:

* Для [обмена сообщениями](#message-func) между ботом и пользователем.
* Для [получения реакции](#command-func) бота в ответ на простую команду.

### Функция для обмена сообщениями {#message-func}

1. [Создайте](../../functions/operations/function/function-create.md) функцию с именем `for-slack-bot-small-talk`. Убедитесь, что она [приватная](../../functions/operations/function/function-private.md).

1. [Создайте](../../functions/operations/function/version-manage.md) версию функции:

   1. Укажите следующие параметры:

      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}** — `python312`.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** — `index.handler`.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** — `5`.
      * **{{ ui-key.yacloud.forms.label_service-account-select }}** — созданный [ранее](#prepare) сервисный аккаунт `sa-slack`.

   1. Создайте файл `requirements.txt` и укажите в нем библиотеки:

      ```text
      slack_sdk
      slack_bolt
      boto3
      ```

   1. Создайте файл `index.py` и вставьте в него содержимое файла `1_for-slack-bot-small-talk.py` из [архива](#prepare).

   1. Добавьте [переменные окружения](#env):
      * `SLACK_BOT_TOKEN`.
      * `SLACK_SIGNING_SECRET`.

### Функция для реагирования на команду {#command-func}

1. [Создайте](../../functions/operations/function/function-create.md) функцию с именем `for-slack-bot-hello-from-serverless`. Убедитесь, что она [приватная](../../functions/operations/function/function-private.md).

1. [Создайте](../../functions/operations/function/version-manage.md) версию функции:

   1. Укажите следующие параметры:

      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}** — `python312`.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** — `index.handler`.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** — `5`.
      * **{{ ui-key.yacloud.forms.label_service-account-select }}** — созданный [ранее](#prepare) сервисный аккаунт `sa-slack`.

   1. Создайте файл `requirements.txt` и укажите в нем библиотеки:

      ```text
      slack_sdk
      slack_bolt
      boto3
      ```

   1. Создайте файл `index.py` и вставьте в него содержимое файла `2_for-slack-bot-hello-from-serverless.py` из [архива](#prepare).
   1. Добавьте [переменные окружения](#env):
      * `SLACK_BOT_TOKEN`.
      * `SLACK_SIGNING_SECRET`.

## Отредактируйте API-шлюз {#edit-api-gw}

Чтобы бот начал отвечать на сообщения пользователей, созданные функции необходимо связать с приложением. Для этого [отредактируйте](../../api-gateway/operations/api-gw-update.md) спецификацию API-шлюза `for-slack-bot` и добавьте в параметр `paths` конфигурации метода `POST`:

```yaml
  /:
    post:
      x-yc-apigateway-integration:
        type: cloud_functions
        function_id: <идентификатор_функции_1>
        service_account_id: <идентификатор_сервисного_аккаунта>
        operationId: small-talk
  /hello-from-serverless:
    post:
      x-yc-apigateway-integration:
        type: cloud_functions
        function_id: <идентификатор_функции_2>
        service_account_id: <идентификатор_сервисного_аккаунта>
        operationId: hello-from-serverless
```

Где:

* `service_account_id` — идентификатор сервисного аккаунта `sa-slack`.
* `<идентификатор_функции_1>` — идентификатор функции `for-slack-bot-small-talk`.
* `<идентификатор_функции_2>` — идентификатор функции `for-slack-bot-hello-from-serverless`.

## Добавьте команду в Slack {#commands}

С помощью [команд](https://api.slack.com/interactivity/slash-commands) можно настраивать действия бота в чате. Команды начинаются с символа `/`, и их список всегда виден пользователю.

{% note info %}

Команда не будет работать, если для нее не настроен соответствующий метод в [API-шлюзе](#edit-api-gw).

{% endnote %}

1. Выберите [приложение](https://api.slack.com/apps) `ServerlessBotApp`.
1. В меню управления приложением выберите пункт **Features** → **Slash Commands** и нажмите **Create New Command**.
1. Добавьте команду для функции `for-slack-bot-hello-from-serverless`:

   * В поле **Command** введите `/hello-from-serverless`.
   * В поле **Request URL** вставьте адрес `url` из спецификации API-шлюза `for-slack-bot`, дополнив его адресом команды `/hello-from-serverless`.
   * В поле **Short descriptions** введите любое краткое описание команды.
   * Нажмите **Save**.

1. Переустановите приложение: в меню управления приложением выберите пункт **Settings** → **Install App** и нажмите **Reinstall to Workspace** → **Allow**.
1. Включите отправку сообщений: в меню управления приложением выберите пункт **Features** → **App Home** и в разделе **Show Tabs** включите опцию **Allow users to send Slash commands and messages from the messages tab**.

## Проверьте работу Slack-бота {#test}

Откройте клиент Slack и в разделе **Apps** выберите чат с ботом `ServerlessBotApp`.

1. Чтобы проверить функцию `for-slack-bot-small-talk`:
   * Отправьте в чат сообщение `:wave:`. Бот должен ответить: `Hi there, @<username>!`.
   * Отправьте в чат сообщение `knock knock`. Бот должен ответить: `Who's there?`.
1. Чтобы проверить функцию `for-slack-bot-hello-from-serverless`, отправьте в чат команду `/hello-from-serverless`. Бот должен ответить: `Thanks!`.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

* [удалите API-шлюз](../../api-gateway/operations/api-gw-delete.md);
* [удалите функции](../../functions/operations/function/function-delete.md).