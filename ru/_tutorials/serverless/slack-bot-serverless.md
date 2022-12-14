# Как создать чат-бот для Slack

В этом сценарии вы узнаете, как с помощью serverless-технологий создать Slack-бота, который будет выполнять команды в чате и отвечать на сообщения пользователей.

@[youtube](VmqFGYAPN_4)

## Подготовьте окружение {#start}

1. [Скачайте](https://storage.yandexcloud.net/doc-files/slackbot.zip) архив с файлами, необходимыми для создания бота.
1. Если у вас еще нет каталога, [создайте](../../resource-manager/operations/folder/create.md) его.
1. [Создайте](../../iam/operations/sa/create.md#create-sa) сервисный аккаунт и [назначьте](../../iam/operations/roles/grant.md#access-to-sa) ему роль `editor` на ваш каталог.

## Создайте приложение и подключите его к {{ yandex-cloud }} {#app}

### Зарегистрируйте Slack-приложение {#create-app}

1. Авторизуйтесь в [Slack](https://slack.com/). Чтобы создать бота, у вас должны быть права на управление рабочим пространством.
1. [Создайте](https://api.slack.com/apps) приложение:
   1. Нажмите кнопку **Create a custom app**.
   1. В поле **Name** введите имя приложения `ServerlessBotApp`.
   1. Выберите доступное рабочее пространство и нажмите **Create app**.
1. Выдайте разрешения приложению `ServerlessBotApp`:
   1. В меню управления приложением выберите пункт **OAuth & Permissions**.
   1. В разделе **Bot Token Scopes** добавьте разрешения: `chat:write`, `commands`, `im:history`.
   1. После обновления разрешений необходимо переустановить приложение: вверху страницы появится уведомление. Чтобы переустановить приложение, перейдите по ссылке в уведомлении и нажмите **Allow**.

### Настройте связь между Slack и {{ yandex-cloud }} {#connect-app}

1. [Создайте](../../api-gateway/operations/api-gw-create.md) API-шлюз с именем `for-slack-bot`.

1. [Создайте](../../functions/operations/function/function-create.md) функцию с именем `for-slack-bot-challenge`. Убедитесь, что она [приватная](../../functions/operations/function/function-private.md).

1. [Создайте](../../functions/operations/function/version-manage.md) версию функции:
   1. Создайте файл `index.py` и вставьте в него содержимое файла `0_for-slack-bot-challenge.py` из [архива](#start).
   1. Укажите:
      * Среду выполнения `python37`.
      * Точку входа `index.handler`.
      * Таймаут 5 секунд.
      * Сервисный аккаунт.
1. [Отредактируйте](../../api-gateway/operations/api-gw-update.md) API-шлюз `for-slack-bot`. Добавьте в параметр `paths` конфигурацию метода `POST`:

   ```
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
           function_id: <ID функции>
           service_account_id: <ID сервисного аккаунта>
         operationId: slack-challenge
   ```

   Параметры:
   * `<ID функции>` — идентификатор функции `for-slack-bot-challenge`.
   * `<ID сервисного аккаунта>` — идентификатор сервисного аккаунта.

### Проверьте связь между Slack и {{ yandex-cloud }} {#connect-test}

1. Скопируйте служебный домен API-шлюза `for-slack-bot`.
1. [Выберите](https://api.slack.com/apps) приложение `ServerlessBotApp`.
1. В меню управления приложением выберите раздел **Event Subscriptions**.
1. Установите **Enable Events** в положение **on**.
1. В поле **Request URL** вставьте адрес API-шлюза и дождитесь появления записи **Verified**.

## Получите Token и Secret для приложения {#env}

[Выберите](https://api.slack.com/apps) приложение `ServerlessBotApp`:
* Значение **Bot User OAuth Token** из раздела **OAuth & Permissions** будет использоваться для переменной окружения `SLACK_BOT_TOKEN`.
* Значение **Signing Secret** из раздела **Basic Information** будет использоваться для переменной окружения `SLACK_SIGNING_SECRET`.

## Создайте базу данных {#create-db}

Ответы на команды и сообщения в чате бот будет брать из {{ ydb-full-name }}. Для этого подготовьте таблицу:
1. [Создайте](../../ydb/quickstart.md#serverless) базу данных с именем `for-slack-bot` в режиме Serverless.
1. В базе `for-slack-bot` [создайте](../../ydb/operations/schema.md#create-table) {{ ydb-short-name }}-таблицу с именем `coffee`:
   1. Перейдите на вкладку **Навигация**.
   1. В правом верхнем углу нажмите кнопку **SQL-запрос**. Откроется страница **Запрос**.
   1. В поле **Запрос** введите:

      ```sql
      CREATE TABLE coffee
      (
        id Utf8,
        name Utf8,
        PRIMARY KEY (id)
      );
      ```

   1. Нажмите кнопку **Выполнить**.
1. [Добавьте](../../ydb/operations/crud.md#web-sql) в таблицу запись. Например, укажите название сорта кофе и id = 1.

## Создайте функции {#create-functions}

С помощью функций можно настраивать реакции бота на действия пользователей в чате. В сценарии будут созданы функции:
* Для обмена сообщениями между ботом и пользователемю.
* Для получения реакции бота в ответ на простую команду;.
* Для выбора ботом ответа на команду из {{ ydb-name }}.

### Функция для обмена сообщениями {#message-func}

1. [Создайте](../../functions/operations/function/function-create.md) функцию с именем `for-slack-bot-small-talk`. Убедитесь, что она [приватная](../../functions/operations/function/function-private.md).

1. [Создайте](../../functions/operations/function/version-manage.md) версию функции:
   1. Создайте файл `requirements.txt` и укажите в нем библиотеки:

      ```text
      slack_sdk
      slack_bolt
      boto3
      ```

   1. Создайте файл `index.py` и вставьте в него содержимое файла `1_for-slack-bot-small-talk.py` из [архива](#start).
   1. Укажите:
      * Среду выполнения `python37`.
      * Точку входа `index.handler`.
      * Таймаут 5 секунд.
      * Сервисный аккаунт.
   1. Добавьте [переменные окружения](#env):
      * `SLACK_BOT_TOKEN`.
      * `SLACK_SIGNING_SECRET`.

### Функция для реагирования на команду {#command-func}

1. [Создайте](../../functions/operations/function/function-create.md) функцию с именем `for-slack-bot-hello-from-serverless`. Убедитесь, что она [приватная](../../functions/operations/function/function-private.md).

1. [Создайте](../../functions/operations/function/version-manage.md) версию функции:
   1. Создайте файл `requirements.txt` и укажите в нем библиотеки:

      ```text
      slack_sdk
      slack_bolt
      boto3
      ```

   1. Создайте файл `index.py` и вставьте в него содержимое файла `2_for-slack-bot-hello-from-serverless.py` из [архива](#start).
   1. Укажите:
      * Среду выполнения `python37`.
      * Точку входа `index.handler`.
      * Таймаут 5 секунд.
      * Сервисный аккаунт.
   1. Добавьте [переменные окружения](#env):
      * `SLACK_BOT_TOKEN`.
      * `SLACK_SIGNING_SECRET`.

### Функция для выбора ответа на команду {#db-func}

1. [Создайте](../../functions/operations/function/function-create.md) функцию с именем `for-slack-bot-what-kind-of-coffee`. Убедитесь, что она [приватная](../../functions/operations/function/function-private.md).

1. [Создайте](../../functions/operations/function/version-manage.md) версию функции:
   1. Создайте файл `requirements.txt` и укажите в нем библиотеки и номер версии **{{ ydb-name }}**:

      ```text
      slack_sdk
      slack_bolt
      boto3
      ydb==0.0.41
      ```

   1. Создайте файл `index.py` и вставьте в него одержимое файла `3_for-slack-bot-what-kind-of-coffee.py` из [архива](#start).
   1. Укажите:
      * Среду выполнения `python37`.
      * Точку входа `index.handler`.
      * Таймаут = 5 секунд.
      * Сервисный аккаунт.
   1. Добавьте [переменные окружения](#env):
      * `SLACK_BOT_TOKEN`.
      * `SLACK_SIGNING_SECRET`.
   1. Добавьте переменные для работы с {{ ydb-name }}:
      * `DATABASE` — значение поля **База данных** из раздела **Обзор** в свойствах базы данных `for-slack-bot`. Например: `/{{ region-id }}/a1bcd23mbaomkfvsleds/etn456khb7jn1ddedfht`.
      * `ENDPOINT` — значение поля **Эндпоинт** из раздела **Обзор** в свойствах базы данных `for-slack-bot`. Например: `grpcs://ydb.serverless.yandexcloud.net:1234`.
      * `USE_METADATA_CREDENTIALS` = 1.

## Отредактируйте API-шлюз {#create-api-gw}

Чтобы бот начал отвечать на сообщения пользователей, созданные функции необходимо связать с приложением. Для этого [отредактируйте](../../api-gateway/operations/api-gw-update.md) API-шлюз `for-slack-bot` и добавьте в параметр `paths` конфигурации метода `POST`:

```
paths:
  /:
    post:
      x-yc-apigateway-integration:
        type: cloud_functions
        function_id: <ID функции_1>
        service_account_id: <ID сервисного аккаунта>
      operationId: slack-challenge
  /hello-from-serverless:
    post:
      x-yc-apigateway-integration:
        type: cloud_functions
        function_id: <ID функции_2> 
        service_account_id: <ID сервисного аккаунта>
       operationId: hello-from-serverless
  /what-kind-of-coffee:
    post:
      x-yc-apigateway-integration:
        type: cloud_functions
        function_id: <ID функции_3>
        service_account_id: <ID сервисного аккаунта>
      operationId: /what-kind-of-coffee
```

Параметры:
* `<ID сервисного аккаунта>` — идентификатор сервисного аккаунта.
* `<ID функции_1>` — идентификатор функции `for-slack-bot-small-talk`.
* `<ID функции_2>` — идентификатор функции `for-slack-bot-hello-from-serverless`.
* `<ID функции_3>` — идентификатор функции `for-slack-bot-what-kind-of-coffee`.

## Добавьте команды в Slack {#commands}

С помощью [команд](https://api.slack.com/interactivity/slash-commands) можно настраивать действия бота в чате. Команды начинаются с символа `/`, и их список всегда виден пользователю.

{% note info %}

Команда не будет работать, если для нее не настроен соответствующий метод в [API-шлюзе](#create-api-gw).

{% endnote %}

1. [Выберите](https://api.slack.com/apps) приложение `ServerlessBotApp`.
1. В меню управления приложением выберите раздел **Slash Commands** и нажмите **Create New Command**.
1. Добавьте команду для функции `for-slack-bot-hello-from-serverless`:
   * В поле **Command** введите `/hello-from-serverless`.
   * В поле **Request URL** вставьте адрес `url` из спецификации API-шлюза `for-slack-bot`, дополнив его адресом команды `/hello-from-serverless`.
   * В поле **Short descriptions** введите любое краткое описание команды.
   * Нажмите **Save**.
1. Добавьте команду для функции `for-slack-bot-what-kind-of-coffee`:
   * В поле **Command** введите `/what-kind-of-coffee`.
   * В поле **Request URL** вставьте адрес `url` из спецификации API-шлюза `for-slack-bot`, дополнив его адресом команды `/what-kind-of-coffee`.
   * В поле **Short descriptions** введите любое краткое описание команды.
   * Нажмите **Save**.
1. После добавления новых команд необходимо переустановить приложение: вверху страницы появится уведомление. Чтобы переустановить приложение, перейдите по ссылке в уведомлении и нажмите **Allow**.

## Протестируйте работу Slack-бота {#test}

Откройте клиент Slack и в разделе **Apps** выберите чат с ботом `ServerlessBotApp`.
1. Чтобы проверить функцию `for-slack-bot-small-talk`:
   * Отправьте в чат сообщение `:wave:`. Бот должен ответить: `Hi there, @<username>!`.
   * Отправьте в чат сообщение `knock knock`. Бот должен ответить: `Who's there?`.
1. Чтобы проверить функцию `for-slack-bot-hello-from-serverless`:
   * Отправьте в чат команду `/hello-from-serverless`. Бот должен ответить: `Thanks!`.
1. Чтобы проверить функцию `for-slack-bot-what-kind-of-coffee`:
   * Отправьте в чат команду `/what-kind-of-coffee`. Бот должен ответить: `Today we use <запись из таблицы coffee>`.