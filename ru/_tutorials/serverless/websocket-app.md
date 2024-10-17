# Создание интерактивного serverless-приложения с использованием WebSocket



В этом руководстве вы развернете онлайн-игру, реализованную на Node.js с использованием WebSocket. 

Статические ресурсы игры будут храниться в бакете {{ objstorage-name }}, данные игры — в базах данных {{ ydb-name }}. Данные будут передаваться в потоке {{ yds-name }} и обрабатываться функциями {{ sf-name }}. Для передачи сообщений между компонентами приложения используется очередь {{ message-queue-name }}. Секреты безопасно доставляются в приложение с помощью сервиса {{ lockbox-name }}. API-шлюз {{ api-gw-name }} будет принимать запросы от пользователей и перенаправлять их в функции {{ sf-name }}.

Для авторизации пользователей игры используется интеграция с Telegram.

Чтобы создать онлайн-игру:

1. [Подготовьте окружение](#prepare).
1. [Создайте базы данных {{ ydb-full-name }}](#create-ydb-database).
1. [Создайте поток данных {{ yds-full-name }}](#yds-create).
1. [Создайте секрет {{ lockbox-full-name }}](#secrets-create).
1. [Разверните проект](#app-deploy).
1. [Создайте ключи доступа для сервисных аккаунтов](#create-extra-sa-keys).
1. [Создайте новую версию секрета и разверните проект еще раз](#update-and-deploy).
1. [Создайте API-шлюз {{ api-gw-full-name }}](#apigw-create).
1. [Подключите домен к Telegram-боту](#api-gw-connect).
1. [Протестируйте приложение](#test-api).

Если созданные ресурсы больше не нужны, [удалите](#clear-out) их.

## Перед началом работы {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для данного руководства входят:

* плата за операции с данными и за объем хранимых данных (см. [тарифы {{ ydb-full-name }}](../../ydb/pricing/serverless.md));
* плата за использование потока данных (см. [тарифы {{ yds-full-name }}](../../data-streams/pricing.md));
* плата за хранение секрета (см. [тарифы {{ lockbox-full-name }}](../../lockbox/pricing.md));
* плата за хранение данных и операции с данными (см. [тарифы {{ objstorage-full-name }}](../../storage/pricing.md));
* плата за запросы к созданным API-шлюзам и исходящий трафик (см. [тарифы {{ api-gw-full-name }}](../../api-gateway/pricing.md));
* плата за запросы к очередям и исходящий трафик (см. [тарифы {{ message-queue-full-name }}](../../message-queue/pricing.md));
* плата за вызовы функций и вычислительные ресурсы, выделенные для выполнения функций (см. [тарифы {{ sf-full-name }}](../../functions/pricing.md)).

## Подготовьте окружение {#prepare}

{% list tabs group=operating_system %}

- Windows {#windows}

  1. [Установите утилиту WSL](https://docs.microsoft.com/ru-ru/windows/wsl/install) для использования окружения Linux.
  1. Запустите подсистему Linux (по умолчанию — Ubuntu).
  1. Далее настройте окружение так, как описано в этой инструкции для операционной системы Linux.

- Linux {#linux}

  {% note info %}

  Если вы используете дистрибутив, отличный от Ubuntu, установите указанные утилиты с помощью команд вашего пакетного менеджера.

  {% endnote %}

  1. Последовательно установите следующие утилиты с помощью команд в терминале:

     * [WebStorm](https://www.jetbrains.com/ru-ru/webstorm/) или [IntelliJ IDEA Community Edition](https://www.jetbrains.com/ru-ru/idea/).
       ```bash
       sudo snap install webstorm --classic
       ```

     * [Curl](https://curl.se/) и [Git](https://git-scm.com/):

       ```bash
       sudo apt-get install curl git -y
       ```

     * Утилиту [jq](https://stedolan.github.io/jq/download/):
       ```bash
       sudo apt-get install jq
       ```

     * [{{ yandex-cloud }} CLI](../../cli/quickstart.md):

       ```bash
       curl https://{{ s3-storage-host-cli }}{{ yc-install-path }} | bash
       exec -l $SHELL
       yc version
       ```

     * [AWS CLI](https://aws.amazon.com/ru/cli/):

       ```bash
       curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" --output "AWSCLIV2.pkg"
       sudo installer -pkg AWSCLIV2.pkg -target /
       ```

     * [YDB CLI](https://ydb.tech/docs/ru/reference/ydb-cli/install):

       ```bash
       curl --silent --show-error --location https://storage.yandexcloud.net/yandexcloud-ydb/install.sh | bash
       ```

     * [Node.js](https://nodejs.org/ru/) версии `16.16.0`:

       ```bash
       sudo apt-get install curl
       curl --silent --location https://deb.nodesource.com/setup_16.x | sudo -E bash
       sudo apt-get install nodejs
       node -v
       npm -v
       ```

     * [TypeScript](https://www.typescriptlang.org/):

       ```bash
       sudo npm install -g typescript
       ```


  1. [Создайте](../../cli/operations/profile/profile-create.md#interactive-create) профиль {{ yandex-cloud }} CLI с базовыми параметрами.

- macOS {#macos}

  1. Последовательно установите следующие утилиты с помощью команд в терминале:
     * [Homebrew](https://brew.sh):

       ```bash
       /bin/bash -c "$(curl --fail --silent --show-error --location https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
       ```

     * [WebStorm](https://www.jetbrains.com/ru-ru/webstorm/) или [IntelliJ IDEA Community Edition](https://www.jetbrains.com/ru-ru/idea/).
       ```bash
       brew install --cask webstorm
       ```

     * [Curl](https://curl.se/) и [Git](https://git-scm.com/):

       ```bash
       brew install curl git
       ```

     * Утилиту [jq](https://stedolan.github.io/jq/download/):
       ```bash
       brew install jq
       ```

     * [{{ yandex-cloud }} CLI](../../cli/quickstart.md):

       ```bash
       curl https://{{ s3-storage-host-cli }}{{ yc-install-path }} | bash
       exec -l $SHELL
       yc version
       ```

     * [AWS CLI](https://aws.amazon.com/ru/cli/):

       ```bash
       curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" --output "AWSCLIV2.pkg"
       sudo installer -pkg AWSCLIV2.pkg -target /
       ```

     * [YDB CLI](https://ydb.tech/docs/ru/reference/ydb-cli/install):

       ```bash
       curl --silent --show-error --location https://storage.yandexcloud.net/yandexcloud-ydb/install.sh | bash
       ```

     * [Node.js](https://nodejs.org/ru/) версии `16.16.0`:

       ```bash
       brew install node@16
       brew install nvm
       node -v
       npm -v
       ```

       Если вы используете zsh, выполните:
       ```bash
       echo 'export NVM_DIR=~/.nvm' >> ~/.zshrc
       echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"' >> ~/.zshrc
       source ~/.zshrc
       ```

     * [TypeScript](https://www.typescriptlang.org/):

       ```bash
       npm install -g typescript
       ```

  1. [Создайте](../../cli/operations/profile/profile-create.md#interactive-create) профиль {{ yandex-cloud }} CLI с базовыми параметрами.

{% endlist %}

### Скачайте проект {#download-project}

Клонируйте [репозиторий](https://github.com/yandex-cloud-examples/yc-serverless-game) `yc-serverless-game`:

```bash
git clone https://github.com/yandex-cloud-examples/yc-serverless-game.git
```

### Зарегистрируйте Telegram-бота {#create-bot}

Зарегистрируйте вашего бота в Telegram и получите токен.

1. Чтобы зарегистрировать нового бота, запустите бота [BotFather](https://t.me/BotFather) и отправьте команду:

    ```
    /newbot
    ```

1. В поле `name` укажите имя создаваемого бота, например `Serverless Game With WebSockets`. Это имя увидят пользователи при общении с ботом.

1. В поле `username` укажите имя пользователя для создаваемого бота, например `ServerlessGameWithWebSocketsBot`. По имени пользователя можно будет найти бота в Telegram. Имя пользователя должно оканчиваться на `...Bot` или `..._bot`.

1. В ответном сообщении вы получите адрес `t.me/ServerlessGameWithWebSocketsBot` и токен.

1. Сохраните имя пользователя в переменную `TG_BOT_LOGIN`:

    ```bash
    echo "export TG_BOT_LOGIN=<имя_пользователя_для_бота>" >> ~/.bashrc && . ~/.bashrc
    echo $TG_BOT_LOGIN
    ```

1. Сохраните токен в переменную `TG_BOT_TOKEN`:

    ```bash
    echo "export TG_BOT_TOKEN=<токен>" >> ~/.bashrc && . ~/.bashrc
    echo $TG_BOT_TOKEN
    ```

### Получите токен доступа {#create-token}

{% list tabs group=authentication %}

- Федеративный аккаунт {#federated-account}

  Получите IAM-токен и сохраните его в переменную `YC_IAM_TOKEN:`

  ```bash
  echo "export YC_IAM_TOKEN=$(yc iam create-token)" >> ~/.bashrc && . ~/.bashrc
  echo $YC_IAM_TOKEN
  ```

- Аккаунт на Яндексе {#yandex-account}

  Получите OAUTH-токен и сохраните его в переменную `OAUTH_TOKEN`:

  ```bash
  echo "export OAUTH_TOKEN=$(yc config get token)" >> ~/.bashrc && . ~/.bashrc
  echo $OAUTH_TOKEN
  ```

{% endlist %}

### Создайте сервисный аккаунт {#setup-sa}

1. Создайте сервисный аккаунт с именем `sls-deploy` и сохраните его имя в переменную `SERVICE_ACCOUNT_GAME`:

    ```bash
    export SERVICE_ACCOUNT_GAME=$(yc iam service-account create --name sls-deploy \
      --description "service account for serverless game" \
      --format json | jq -r .)
    
    echo $SERVICE_ACCOUNT_GAME
    ```

1. В выводе команды, в строке `id`, будет указан идентификатор сервисного аккаунта. Сохраните его в переменную `SERVICE_ACCOUNT_GAME_ID`:

   ```bash
   echo "export SERVICE_ACCOUNT_GAME_ID=<идентификатор_сервисного_аккаунта>" >> ~/.bashrc && . ~/.bashrc
   ```

1. Назначьте сервисному аккаунту роль `{{ roles-editor }}`:

   ```bash
   echo "export YC_FOLDER_ID=$(yc config get folder-id)" >> ~/.bashrc && . ~/.bashrc
   echo $YC_FOLDER_ID
   
   echo "export YC_CLOUD_ID=$(yc config get cloud-id)" >> ~/.bashrc && . ~/.bashrc
   echo $YC_CLOUD_ID
   
   yc resource-manager folder add-access-binding $YC_FOLDER_ID \
   --subject serviceAccount:$SERVICE_ACCOUNT_GAME_ID \
   --role {{ roles-editor }}
   ```

1. Создайте авторизованный ключ для сервисного аккаунта:

   ```bash
   yc iam key create \
     --service-account-name sls-deploy \
     --output sls-deploy.sa
   
   echo "export SA_KEY_FILE=$PWD/sls-deploy.sa" >> ~/.bashrc && . ~/.bashrc
   echo $SA_KEY_FILE
   ```

1. Создайте статический ключ доступа для сервисного аккаунта:

    ```bash
    yc iam access-key create --service-account-id $SERVICE_ACCOUNT_GAME_ID
    ```

    Результат:
    
    ```
    access_key:
        id: ajeibet3219********
        service_account_id: ajehr1tv2eo1********
        created_at: "2023-03-13T10:20:58.471421425Z"
        key_id: YCAS33CT2mPCVFh3K********
    secret: YCNhBcdvfDdssIuBa-FDl6zZz0MSky********
    ```

1. Сохраните идентификатор ключа `key_id` в переменную `AWS_ACCESS_KEY_ID` и секретный ключ `secret` — в переменную `AWS_SECRET_ACCESS_KEY`:

    ```bash
    echo "export AWS_ACCESS_KEY_ID=<идентификатор_ключа>" >> ~/.bashrc && . ~/.bashrc
    echo $AWS_ACCESS_KEY_ID
    
    echo "export AWS_SECRET_ACCESS_KEY=<секретный_ключ>" >> ~/.bashrc && . ~/.bashrc
    echo $AWS_SECRET_ACCESS_KEY
    ```

1. Настройте AWS CLI:

   ```bash
   aws configure
   ```

   Введите следующие параметры:
   
   * `AWS Access Key ID` — идентификатор ключа доступа `key_id` сервисного аккаунта, полученный ранее.
   * `AWS Secret Access Key` — секретный ключ `secret` сервисного аккаунта, полученный ранее.
   * `Default region name` — используйте значение `{{ region-id }}`.
   * `Default output format` — оставьте пустым.

1. Проверьте конфигурацию:

   ```bash
   echo $AWS_ACCESS_KEY_ID
   echo $AWS_SECRET_ACCESS_KEY
   aws configure list
   ```

## Создайте базы данных {{ ydb-name }} {#create-ydb-database}

Создайте базу данных с именем `game-data` для хранения данных игры и базу данных с именем `data-streams` для потока {{ yds-name }}.

1. Создайте базу данных в режиме serverless с именем `game-data`:
   
    ```bash
    yc ydb database create game-data --serverless
    ```

    Результат:
    
    ```
    done (8s)
    id: etn0ejcvmjm4********
    folder_id: b1geoelk7fld********
    created_at: "2023-03-30T15:01:19Z"
    name: game-data
    status: PROVISIONING
    endpoint: grpcs://ydb.serverless.yandexcloud.net:2135/?database=/{{ region-id }}/b1gia87mbaom********/etn0ejcvmjm4********
    serverless_database:
      storage_size_limit: "53687091200"
    location_id: {{ region-id }}
    ...
    ```

1. Сохраните в переменной `YDB_ENDPOINT` значение `endpoint` из вывода предыдущей команды. В нашем примере оно равняется `grpcs://ydb.serverless.yandexcloud.net:2135`.

    ```bash
    echo "export YDB_ENDPOINT=<эндпоинт_Document_API_БД>" >> ~/.bashrc && . ~/.bashrc
    echo $YDB_ENDPOINT
    ```

1. Сохраните в переменной `YDB_DATABASE` значение `database` из вывода предыдущей команды. В нашем примере оно равняется `/{{ region-id }}/b1gia87mbaom********/etn0ejcvmjm4********`.

    ```bash
    echo "export YDB_DATABASE=<имя_таблицы>" >> ~/.bashrc && . ~/.bashrc
    echo $YDB_DATABASE
    ```

1. Создайте базу данных в режиме serverless с именем `data-streams`:

    ```bash
    yc ydb database create data-streams --serverless
    ```

    Результат:
    
    ```
    done (7s)
    id: etn16k0e1757********
    folder_id: b1geoelk7fld********
    created_at: "2023-03-30T15:02:44Z"
    name: data-streams
    status: PROVISIONING
    endpoint: grpcs://ydb.serverless.yandexcloud.net:2135/?database=/{{ region-id }}/b1gia87mbaom********/etn16k0e1757********
    serverless_database:
      storage_size_limit: "53687091200"
    location_id: {{ region-id }}
    ```

1. Сохраните  в переменной `YDB_DATA_STREAMS_ENDPOINT` значение `endpoint` из вывода предыдущей команды. В нашем примере оно равняется `grpcs://ydb.serverless.yandexcloud.net:2135`.

    ```bash
    echo "export YDB_DATA_STREAMS_ENDPOINT=<эндпоинт_Document_API_БД>" >> ~/.bashrc && . ~/.bashrc
    echo $YDB_DATA_STREAMS_ENDPOINT
    ```

1. Сохраните в переменной `YDB_DATA_STREAMS_DATABASE` значение `database` из вывода предыдущей команды. В нашем примере оно равняется `/{{ region-id }}/b1gia87mbaom********/etn16k0e1757********`.

    ```bash
    echo "export YDB_DATA_STREAMS_DATABASE=<имя_таблицы>" >> ~/.bashrc && . ~/.bashrc
    echo $YDB_DATA_STREAMS_DATABASE
    ```

1. Проверьте, что все сделано верно:

   ```bash
   ydb \
     --endpoint $YDB_ENDPOINT \
     --database $YDB_DATABASE \
     --sa-key-file $SA_KEY_FILE \
   discovery whoami \
     --groups
   ```

   Результат:
   
   ```text
   User SID: ajeien4d11sc043********
   
   Group SIDs:
   all-users@well-known
   ```

### Создайте таблицу {#ydb-table-create}

1. Перейдите в папку `files` внутри каталога `yc-serverless-game`.

1. Создайте таблицу, используя файл `db-example.sql`:

    ```bash
    ydb \
      --endpoint $YDB_ENDPOINT \
      --database $YDB_DATABASE \
      --sa-key-file $SA_KEY_FILE \
    scripting yql --file db-example.sql
    ```

1. Добавьте запись для начальной конфигурации:

    ```bash
    ydb \
      --endpoint $YDB_ENDPOINT \
      --database $YDB_DATABASE \
      --sa-key-file $SA_KEY_FILE \
    scripting yql --file db-update.sql
    ```

1. Проверьте результат выполнения:
    
    ```bash
    ydb \
      --endpoint $YDB_ENDPOINT \
      --database $YDB_DATABASE \
      --sa-key-file $SA_KEY_FILE \
    scheme describe Config
    ```

    Результат:
    
    ```
    Columns:
    ┌────────────────────┬─────────┬────────┬─────┐
    | Name               | Type    | Family | Key |
    ├────────────────────┼─────────┼────────┼─────┤
    | name               | Utf8?   |        | K0  |
    | grid_cell_size     | Uint32? |        |     |
    | max_active_players | Uint8?  |        |     |
    | max_inactive_sec   | Int32?  |        |     |
    | player_size        | Uint32? |        |     |
    | transport          | Utf8?   |        |     |
    | world_size_x       | Uint32? |        |     |
    | world_size_y       | Uint32? |        |     |
    └────────────────────┴─────────┴────────┴─────┘
    
    Storage settings:
    Store large values in "external blobs": false
    
    Column families:
    ┌─────────┬──────┬─────────────┬────────────────┐
    | Name    | Data | Compression | Keep in memory |
    ├─────────┼──────┼─────────────┼────────────────┤
    | default |      | None        |                |
    └─────────┴──────┴─────────────┴────────────────┘
    
    Auto partitioning settings:
    Partitioning by size: true
    Partitioning by load: false
    Preferred partition size (Mb): 2048
    Min partitions count: 1
    ```

## Создайте поток данных {{ yds-name }} {#yds-create}

{% list tabs group=instructions %}

- AWS CLI {#cli}
  
  ```bash
  echo $YDB_DATA_STREAMS_DATABASE
  
  aws kinesis create-stream \
    --endpoint https://yds.serverless.yandexcloud.net \
    --stream-name $YDB_DATA_STREAMS_DATABASE/notify-state-change \
    --shard-count 1
  ```

{% endlist %}

## Создайте секрет {{ lockbox-name }} {#secrets-create}

1. Создайте секрет с именем `game-secrets` и передайте в него значения переменных `YDB_ENDPOINT` и `YDB_DATABASE`:

    ```bash
    yc lockbox secret create --name game-secrets \
      --description "The secrets for the serverless game" \
      --payload "[{'key': 'ydb_endpoint', 'text_value': $YDB_ENDPOINT},{'key': 'ydb_db', 'text_value': $YDB_DATABASE}]"
    ```

1. Сохраните идентификатор созданного секрета в переменную `LOCKBOX_SECRET_ID`:

    ```bash
    echo "export LOCKBOX_SECRET_ID=$(jq -r <<<  \
    "$(yc lockbox secret list --format json | jq '.[]' -c | grep game-secrets)" .id)"  \
    >> ~/.bashrc && . ~/.bashrc
    
    echo $LOCKBOX_SECRET_ID
    ```

1. Передайте в секрет значение переменной `TG_BOT_TOKEN`:

    ```bash
    yc lockbox secret add-version --id $LOCKBOX_SECRET_ID \
    --payload "[{'key': 'tg_bot_token', 'text_value': '$TG_BOT_TOKEN'}]"
    ```

1. Передайте в секрет ключи, значения которых мы получим позже. Пока задайте им значения, равными `null`.

    ```bash
    yc lockbox secret add-version --id $LOCKBOX_SECRET_ID \
    --payload "[{'key': 'ymq_writer_key_id', 'text_value': 'null'},\
    {'key': 'ymq_writer_key_secret', 'text_value': 'null'},\
    {'key': 'ymq_capture_queue_url', 'text_value': 'null'},\
    {'key': 'yds_writer_key_id', 'text_value': 'null'},\
    {'key': 'yds_writer_key_secret', 'text_value': 'null'},\
    {'key': 'yds_state_change_stream', 'text_value': 'notify-state-change'},\
    {'key': 'yds_state_change_database', 'text_value': '$YDB_DATA_STREAMS_DATABASE'}]"
    ```

## Разверните проект {#app-deploy}

1. Перейдите в папку `files` внутри каталога `yc-serverless-game`.

1. Измените конфигурацию для {{ objstorage-name }}. Так как имя бакета должно быть уникальным, замените имя бакета на собственное в следующих файлах:

    * файл `serverless.yaml`:
       
        ```yaml
        sls-game-files:
          type: yc::ObjectStorageBucket
        ```
    
    * файл `upload-to-s3.ts` внутри папки `scripts`:
        
        ```ts
        Bucket: 'sls-game-files',
        ```

        Например, вместо `sls-game-files` укажите `sls-game-files-example`.

1. Задайте переменную `APP_ENV` для сборки проекта:

    ```bash
    echo "export APP_ENV=production" >> ~/.bashrc && . ~/.bashrc
    echo $APP_ENV
    ```

1. Соберите и разверните проект. В корне каталога `yc-serverless-game` последовательно выполните следующие команды:

    ```bash
    nvm use
    nvm install
    npm ci
    
    npm run build
    npm run deploy
    ```

При развертывании проекта в вашем рабочем каталоге будут созданы следующие ресурсы:

* Функции {{ sf-name }}:

  * `get-state`
  * `get-config`
  * `move`
  * `capture`
  * `state-change`
  * `login`
  * `auth`
  * `ws-connect`
  * `ws-message`
  * `ws-disconnect`

* Сервисные аккаунты:

  * `functions-sa` с ролью `editor`
  * `triggers-sa` с ролью `serverless.functions.invoker`
  * `yds-reader-sa` с ролью `yds.admin`
  * `yds-writer-sa` с ролью `yds.writer`
  * `ymq-reader-sa` с ролью `ymq.reader`
  * `ymq-writer-sa` с ролью `ymq.writer`
  * `apigw-s3-viewer` с ролью `storage.viewer`
  * `apigw-fn-caller` с ролью `serverless.functions.invoker`

* Бакет {{ objstorage-name }} с именем, которое вы указали в файле `serverless.yaml`

* Очередь {{ message-queue-name }} — `capturing-queue`

## Создайте ключи доступа для сервисных аккаунтов {#create-extra-sa-keys}

При развертывании проекта создались следующие сервисные аккаунты:
* `yds-writer-sa` с ролью `yds.writer` для записи в поток {{ yds-name }};
* `ymq-writer-sa` с ролью `ymq.writer` для записи в очередь {{ message-queue-name }}.

1. Создайте статический ключ доступа для сервисного аккаунта `yds-writer-sa`:

   ```bash
   echo "export YDS_WRITER_SA_ID=$(jq -r <<<  \
   "$(yc iam service-account list --format json | jq '.[]' -c | grep yds-writer-sa)" .id)"  \
   >> ~/.bashrc && . ~/.bashrc
   
   yc iam access-key create --service-account-id $YDS_WRITER_SA_ID
   ```

   Результат:
   
   ```text
   access_key:
       id: ajeibet32197********
       service_account_id: ajehr6tv2eoo********
       created_at: "2023-03-13T10:20:58.471421425Z"
       key_id: YCASD3CT9mPCVFh3K********
   secret: YCNhBcdvfDdssIuBa-FDl6zZz0MSky********
   ```

1. Скопируйте значение идентификатора ключа `key_id` и сохраните в переменную `YDS_WRITER_KEY_ID`:

   ```bash
   echo "export YDS_WRITER_KEY_ID=<идентификатора_ключа>" >> ~/.bashrc && . ~/.bashrc
   echo $YDS_WRITER_KEY_ID
   ```
1. Скопируйте значение секрета `secret` и сохраните в переменную `YDS_WRITER_KEY_SECRET`:

   ```bash
   echo "export YDS_WRITER_KEY_SECRET=<секрет>" >> ~/.bashrc && . ~/.bashrc
   echo $YDS_WRITER_KEY_SECRET
   ```

1. Создайте статический ключ доступа для сервисного аккаунта `ymq-writer-sa`:

   ```bash
   echo "export YMQ_WRITER_SA_ID=$(jq -r <<<  \
   "$(yc iam service-account list --format json | jq '.[]' -c | grep ymq-writer-sa)" .id)"  \
   >> ~/.bashrc && . ~/.bashrc
   
   yc iam access-key create --service-account-id $YMQ_WRITER_SA_ID
   ```

1. Скопируйте идентификатора ключа `key_id` и сохраните в переменную `YMQ_WRITER_KEY_ID`:

   ```bash
   echo "export YMQ_WRITER_KEY_ID=<идентификатор_ключа>" >> ~/.bashrc && . ~/.bashrc

   echo $YMQ_WRITER_KEY_ID
   ```

1. Скопируйте значение секрета `secret` и сохраните в переменную `YMQ_WRITER_KEY_SECRET`:

   ```bash
   echo "export YMQ_WRITER_KEY_SECRET=<секрет>" >> ~/.bashrc && . ~/.bashrc
   echo $YMQ_WRITER_KEY_SECRET
   ```

## Создайте новую версию секрета и разверните проект еще раз {#secrets-update}

1. Передайте новые значения в секрет `game-secrets`:

    1. В [консоли управления]({{ link-console-main }}) выберите ваш рабочий каталог.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
    1. Выберите очередь `capturing-queue`.
    1. Скопируйте значение из поля **{{ ui-key.yacloud.ymq.queue.overview.label_url }}** и сохраните его в переменную `YMQ_CAPTURE_QUEUE_URL`:

       ```bash
       echo "export YMQ_CAPTURE_QUEUE_URL=<URL>" >> ~/.bashrc && . ~/.bashrc
       ```

    1. Проверьте значения переменных, которые нужно будет передать в секрет:
       
       ```bash
       echo $LOCKBOX_SECRET_ID
       echo $YMQ_WRITER_KEY_ID
       echo $YMQ_WRITER_KEY_SECRET
       echo $YDS_WRITER_KEY_ID
       echo $YDS_WRITER_KEY_SECRET
       echo $YMQ_CAPTURE_QUEUE_URL
       ```

    1. Передайте значения в секрет:

       ```bash
       yc lockbox secret add-version --id $LOCKBOX_SECRET_ID \
       --payload "[{'key': 'ymq_writer_key_id', 'text_value': '$YMQ_WRITER_KEY_ID'},\
       {'key': 'ymq_writer_key_secret', 'text_value': '$YMQ_WRITER_KEY_SECRET'},\
       {'key': 'ymq_capture_queue_url', 'text_value': '$YMQ_CAPTURE_QUEUE_URL'},\
       {'key': 'yds_writer_key_id', 'text_value': '$YDS_WRITER_KEY_ID'},\
       {'key': 'yds_writer_key_secret', 'text_value': '$YDS_WRITER_KEY_SECRET'}]"
       ```

1. Перейдите в корень каталога `yc-serverless-game` и еще раз разверните проект:

    ```bash
    npm run deploy
    ```

## Создайте API-шлюз {{ api-gw-name }} {#apigw-create}

При развертывании проекта создались следующие сервисные аккаунты:
* `apigw-s3-viewer` с ролью `storage.viewer` для чтения объектов из бакета {{ objstorage-name }}.
* `apigw-fn-caller` с ролью `{{ roles-functions-invoker }}` для вызова функций {{ sf-name }}.

1. Сохраните идентификаторы сервисных аккаунтов `apigw-s3-viewer` и `apigw-fn-caller` в переменные `APIGW_S3_VIEWER_ID` и `APIGW_FN_CALLER_ID`:

    ```bash
    echo "export APIGW_S3_VIEWER_ID=$(jq -r <<<  \
    "$(yc iam service-account list --format json | jq '.[]' -c | grep apigw-s3-viewer)" .id)"  \
    >> ~/.bashrc && . ~/.bashrc
    
    echo "export APIGW_FN_CALLER_ID=$(jq -r <<<  \
    "$(yc iam service-account list --format json | jq '.[]' -c | grep apigw-fn-caller)" .id)"  \
    >> ~/.bashrc && . ~/.bashrc
    ```

1. Внесите изменения в спецификацию API-шлюза. Перейдите в папку `files` внутри каталога `yc-serverless-game` и выполните команду:

    ```bash
    cp apigw-example.yml apigw.yml
    ```

1. Получите идентификаторы ресурсов, созданных ранее:

    ```bash
    echo $APIGW_S3_VIEWER_ID
    echo $APIGW_FN_CALLER_ID
    
    yc storage bucket list
    yc serverless function list
    ```

1. Внесите в файл `apigw.yml` следующие изменения:

   1. Во всех строках `bucket: serverless-game-files` замените название бакета на ваше.
   1. Во всех строках `service_account_id: <sa-id-for-object-storage>` замените `<sa-id-for-object-storage>` на значение переменной `$APIGW_S3_VIEWER_ID`.
   1. Во всех строках `service_account_id: <sa-id-for-functions>` замените `<sa-id-for-functions>` на значение переменной` $APIGW_FN_CALLER_ID`.
   1. В строке `58` замените `<yandex-cloud-nodejs-dev-get-state-function-id>` на значение идентификатора функции `yandex-cloud-nodejs-dev-get-state`.
   1. В строке `65` замените `<yandex-cloud-nodejs-dev-get-config-function-id>` на значение идентификатора функции `yandex-cloud-nodejs-dev-get-config`.
   1. В строке `72` замените `<yandex-cloud-nodejs-dev-move-function-id>` на значение идентификатора функции `yandex-cloud-nodejs-dev-move`.
   1. В строке `79` замените `<yandex-cloud-nodejs-dev-login-function-id>` на значение идентификатора функции `yandex-cloud-nodejs-dev-login`.
   1. В строке `101` замените `<yandex-cloud-nodejs-dev-ws-message-function-id>` на значение идентификатора функции `yandex-cloud-nodejs-dev-ws-message`.
   1. В строке `106` замените `<yandex-cloud-nodejs-dev-ws-connect-function-id>` на значение идентификатора функции `yandex-cloud-nodejs-dev-ws-connect`.
   1. В строке `111` замените `<yandex-cloud-nodejs-dev-ws-disconnect-function-id>` на значение идентификатора функции `yandex-cloud-nodejs-dev-ws-disconnect`.
   1. В строке `118` замените `<yandex-cloud-nodejs-dev-auth-function-id>` на значение идентификатора функции `yandex-cloud-nodejs-dev-auth`.

1. Разверните экземпляр {{ api-gw-name }}:

    ```bash
    yc serverless api-gateway create \
      --name serverless-game-api \
      --spec=apigw.yml \
      --description "for serverless-game-api"
    ```

    Если вы допустили ошибку в спецификации API-шлюза, внесите правки и выполните команду:

    ```bash
    yc serverless api-gateway update \
      --name serverless-game-api \
      --spec=apigw.yml 
    ```

## Подключите домен к Telegram-боту {#api-gw-connect}

1. Выполните команду: 

   ```bash
   yc serverless api-gateway get --name serverless-game-api
   ```

1. Скопируйте служебный домен API-шлюза. Он находится в выводе предыдущей команды, в поле `domain`.

1. В Telegram найдите [BotFather](https://t.me/BotFather) и введите команду `/setdomain`.
1. Выберите из списка своего бота и отправьте служебный домен API-шлюза. Перед доменом добавьте `https://`. Например, если служебный домен API-шлюза — `d5d920bqkitf********.apigw.yandexcloud.net`, URL будет `https://d5d920bqkitf********.apigw.yandexcloud.net`.

## Протестируйте приложение {#test-app}

Перейдите по ссылке, которую отправили Telegram-боту, авторизуйтесь и откройте игру.

В игре доступна статистика игроков. Если служебный домен API-шлюза — `d5d920bqkitf********.apigw.yandexcloud.net`, тогда по адресу `https://d5d920bqkitf********.apigw.yandexcloud.net/stats.html` будет доступна страница со статистикой всех игроков.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
* [удалите](../../ydb/operations/manage-databases.md#delete-db) базы данных {{ ydb-name }};
* [удалите](../../data-streams/operations/manage-streams.md#delete-data-stream) поток данных {{ yds-name }};
* [удалите](../../lockbox/operations/secret-delete.md) секрет {{ lockbox-name }};
* [удалите все объекты из бакета](../../storage/operations/objects/delete.md) и [удалите пустой бакет](../../storage/operations/buckets/delete.md) {{ objstorage-name }};
* [удалите](../../api-gateway/operations/api-gw-delete.md) API-шлюз {{ api-gw-name }};
* [удалите](../../functions/operations/function/function-delete.md) функции {{ sf-name }}.
* [удалите](../../message-queue/operations/message-queue-delete-queue.md) очередь {{ message-queue-name }}.
