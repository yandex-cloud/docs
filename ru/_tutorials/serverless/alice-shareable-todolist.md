# Разработка навыка Алисы и сайта с авторизацией


В этом руководстве вы разработаете [навык Алисы](https://yandex.ru/dev/dialogs/alice/doc/ru/about) и развернете веб-приложение, которое позволит создавать, читать и редактировать списки дел с помощью Алисы, а также делиться списками с другими пользователями на сайте.

Данные проекта хранятся в бакете [{{ objstorage-full-name }}](../../storage/) и базе данных [{{ ydb-full-name }}](../../ydb/). Функции [{{ sf-full-name }}](../../functions/) обрабатывают запросы, а [{{ api-gw-full-name }}](../../api-gateway/) обеспечивает взаимодействие сервисов.


<iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplv75t2gtff4pps5fx2?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

[Смотреть видео на YouTube](https://www.youtube.com/watch?v=PMWMDTBKFAc).



Чтобы развернуть проект:

1. [Подготовьте облако к работе](#before-begin).
1. [Настройте окружение](#prepare).
1. [Создайте ресурсы](#create-resources).
1. [Задайте переменные проекта](#set-variables).
1. [Разверните проект](#deploy).
1. [Зарегистрируйте навык Алисы](#register-skill).
1. [Проверьте работу навыка](#test-skill).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}



### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за количество вызовов функций, вычислительные ресурсы, выделенные для выполнения функций, и исходящий трафик (см. [тарифы {{ sf-full-name }}](../../functions/pricing.md));
* плата за операции с {{ ydb-short-name }} и хранение данных (см. [тарифы {{ ydb-full-name }}](../../ydb/pricing/serverless.md));
* плата за хранение данных в бакете (см. [тарифы {{ objstorage-full-name }}](../../storage/pricing.md));
* плата за количество запросов к созданному API-шлюзу и исходящий трафик (см. [тарифы {{ api-gw-full-name }}](../../api-gateway/pricing.md));
* плата за запись и хранение данных в лог-группе (см. [тарифы {{ cloud-logging-full-name }}](../../logging/pricing.md)).



## Настройте окружение {#prepare}

{% list tabs group=operating_system %}

- Windows {#windows}

  1. [Установите подсистему Windows Subsystem for Linux (WSL)](https://docs.microsoft.com/ru-ru/windows/wsl/install) для использования Linux.
  1. Запустите WSL (по умолчанию — Ubuntu).
  1. Настройте окружение так, как описано в инструкции для операционной системы Linux.

- Linux {#linux}

  {% note info %}

  Если вы используете дистрибутив, отличный от Ubuntu, установите указанные программы с помощью команд вашего пакетного менеджера.

  {% endnote %}

  1. Клонируйте репозиторий [yc-serverless-alice-shareable-todolist](https://github.com/yandex-cloud-examples/yc-serverless-alice-shareable-todolist):

     ```bash
     git clone https://github.com/yandex-cloud-examples/yc-serverless-alice-shareable-todolist.git
     ```

  1. Установите и настройте следующие программы:

     * [{{ yandex-cloud }} CLI](../../cli/quickstart.md)
     * [{{ ydb-short-name }} CLI](https://ydb.tech/docs/{{ lang }}/reference/ydb-cli/install)
     * [Командный интерпретатор Bash](http://www.gnu.org/software/bash/)
     * [AWS CLI](../../storage/tools/aws-cli.md)
     * [Утилита jq](https://stedolan.github.io/jq/download/)
     * [Node.js](https://nodejs.org/en/download/package-manager/)
     * [Пакетный менеджер npm](https://{{ lang }}.wikipedia.org/wiki/Npm)
     * [{{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md)
     * [Язык программирования Go](https://go.dev/doc/install)

  1. (Опционально) Для доработки проекта дополнительно установите:

     * [Утилиту go-swagger](https://goswagger.io/go-swagger/install/)
     * [Утилиту api-spec-converter](https://www.npmjs.com/package/api-spec-converter)

{% endlist %}


## Создайте ресурсы {#create-resources}

### Создайте бакет {#create-bucket}

Создайте [бакет](../../storage/concepts/bucket.md) для хранения статических данных:

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [create-public-bucket](../_tutorials_includes/create-public-bucket.md) %}

{% endlist %}


### Создайте API-шлюз {#create-api-gw}

Создайте [API-шлюз](../../api-gateway/concepts/index.md) для взаимодействия сервисов:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы выполняете руководство.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. Нажмите **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** введите `gate-1`.
  1. Нажмите **{{ ui-key.yacloud.serverless-functions.gateways.form.button_create-gateway }}**.
  1. Дождитесь, когда статус API-шлюза изменится на `Active`.
  1. Выберите созданный API-шлюз.
  1. Найдите поля **{{ ui-key.yacloud.common.id }}** и **{{ ui-key.yacloud.serverless-functions.gateways.overview.label_domain }}** и сохраните их значения. Они понадобятся при настройке навыка.

{% endlist %}


### Создайте базу данных {#db-create}

Создайте базу данных {{ ydb-short-name }} в [режиме Serverless](../../ydb/concepts/serverless-and-dedicated.md#serverless):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создали бакет.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
  1. Нажмите **{{ ui-key.yacloud.ydb.databases.button_create }}**.
  1. Введите **{{ ui-key.yacloud.ydb.forms.label_field_name }}** базы. Требования к имени:

      {% include [name-format](../../_includes/name-format.md) %}

  1. В блоке **{{ ui-key.yacloud.ydb.forms.label_field_database-type }}** выберите `{{ ui-key.yacloud.ydb.forms.label_serverless-type }}`.
  1. Нажмите **{{ ui-key.yacloud.ydb.forms.button_create-database }}**.
  1. Дождитесь, когда статус базы данных изменится на `Running`.
  1. Выберите созданную БД.
  1. В блоке **{{ ui-key.yacloud.ydb.overview.section_connection }}** найдите поле **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** и сохраните его значение. Оно понадобится при создании функций.

{% endlist %}


### Создайте приложение {#create-app}

[Создайте](https://yandex.ru/dev/id/doc/ru/register-client) приложение в сервисе {{ yandex-oauth }}:

{% list tabs %}

- Интерфейс {{ yandex-oauth }}

  1. Перейдите на [сайт сервиса]({{ ya-oauth-url }}) и авторизуйтесь.
  1. Нажмите **Создать приложение**.
  1. Выберите подходящее имя приложения и загрузите иконку.
  1. В разделе **Для каких платформ нужно приложение** выберите `Веб-сервисы` и нажмите **Сохранить и продолжить**.
  1. В разделе **Платформы приложения** в поле **Redirect URI** укажите следующие URL:

      * `https://social.yandex.net/broker/redirect`;
      * `<служебный_домен_API-шлюза>/receive-token`.

      Поле **Suggest Hostname** оставьте пустым.

  1. Нажмите **Сохранить и продолжить**.
  1. В разделе **Доступ к данным** выберите `Доступ к портрету пользователя` и нажмите **Сохранить и продолжить**.
  1. В разделе **Почта для связи** укажите адрес своей почты и нажмите **Сохранить и продолжить**.
  1. Проверьте данные и нажмите **Всё верно, создать приложение**.

  Подробнее о возможностях сервиса {{ yandex-oauth }} читайте в [документации](https://yandex.ru/dev/oauth/doc/dg/tasks/register-client.html).

{% endlist %}

## Задайте переменные проекта {#set-variables}

Сконфигурируйте проект с помощью значений, которые получили при создании ресурсов.

### Создайте файл секретов {#set-variables-secure-config}

Создайте файл `secure-config.json` с секретами:

{% list tabs group=programming_language %}

- Bash {#bash}

  1. Чтобы создать файл из шаблона `secure-config-template.json`, в папке с файлами проекта `yc-serverless-alice-shareable-todolist` выполните команду:

      ```bash
      cp secure-config-template.json secure-config.json
      ```

  1. Откройте файл `secure-config.json` с помощью редактора `nano`:

      ```bash
      nano secure-config.json
      ```

  1. Подставьте в файл значения переменных:

      * `oauth_secret` — пароль приложения (**Client secret**), зарегистрированного в [Яндекс OAuth](https://oauth.yandex.ru/).
      * `hash` — случайная строка длиной 64 байта, закодированная с помощью base64, например `qrJagO5NVwOj0FeTmgYSwUN+XXkiQJMWifvrklF53wT55q80Xk8vmEB3kxhtpDnA1WDC893Z9Bh6QcqK********`. Сгенерировать случайное значение можно в терминале с помощью команды `openssl rand -base64 64 | tr -d '\n'`.
      * `block` — случайная строка длиной 32 байта, закодированная с помощью base64, например `uwk0duFgn2nYyfu2VzJe+MnWKWQrfKaiZijI********`. Сгенерировать случайное значение можно в терминале с помощью команды `openssl rand -base64 32 | tr -d '\n'`.

      Сгенерировать случайные значения можно с помощью сайта [generate.plus](https://generate.plus/en/base64).

{% endlist %}


### Создайте файл конфигурации {#set-variables-variables}

Создайте файл `variables.json` с конфигурацией для развертывания проекта:

{% list tabs group=programming_language %}

- Bash {#bash}

  1. Чтобы создать файл из шаблона `variables-template.json`, в папке с файлами проекта выполните команду:

      ```bash
      cp variables-template.json variables.json
      ```

  1. Откройте файл `variables.json` с помощью редактора `nano`:

      ```bash
      nano variables.json
      ```

  1. Подставьте в файл значения переменных:

      * `folder-id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md) в облаке.
      * `domain` — служебный домен API-шлюза `gate-1` без `https://`. Например `d5dbo25bol8n********.apigw.yandexcloud.net`.
      * `oauth-client-id` — значение поля **ClientID** приложения, зарегистрированного в [{{ yandex-oauth }}]({{ ya-oauth-url }}).
      * `database` — размещение базы данных: вторая часть сохраненного ранее значения поля **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** (часть после вхождения `/?database=`). Например, `/{{ region-id }}/r1gra875baom********/g5n22e7ejfr1********`.
      * `database-endpoint` — первая часть сохраненного ранее значения поля **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** (часть после вхождения `grpcs://` и до вхождения `/?database=`). Например, `ydb.serverless.yandexcloud.net:2135`.
      * `yc-profile` — [название профиля](../../cli/operations/profile/profile-list.md) {{ yandex-cloud }} CLI.
      * `secure-config-path` — путь к [файлу секретов](#set-variables-secure-config) `secure-config.json`.
      * `storage-bucket` — имя созданного бакета для хранения статических данных.
      * `gateway-id` — идентификатор API-шлюза `gate-1`.

{% endlist %}

## Разверните проект {#deploy}

Перенесите файлы проекта в {{ yandex-cloud }} и обновите конфигурацию.


### Примените схему данных {#deploy-schema}

Чтобы создать таблицы в базе данных, в папке с файлами проекта выполните команду:

{% list tabs group=programming_language %}

- Bash {#bash}

  ```bash
  ./upload_ydb_schema.sh
  ```

{% endlist %}


### Получите OAuth-токен {#get-oauth-token}

Получите [OAuth-токен](../../iam/concepts/authorization/oauth-token.md):

1. Перейдите в сервис [{{ yandex-oauth }}]({{ link-cloud-oauth }}). Перед выдачей токена сервис может запросить доступ к данным.
1. Сохраните полученный токен, он понадобится для загрузки кода.


### Загрузите код бэкенда в {{ sf-name }} {#deploy-backend}

Используйте {{ TF }} для автоматизации действий. Перед использованием [проинициализируйте его](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).

{% list tabs group=instructions %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. В папке с конфигурационным файлом `app.tf` выполните команду:

      ```bash
      terraform init
      ```

      {% note info %}

      В случае ошибки инициализации провайдера {{ TF }} вида `permission denied` выполните команду `sudo chown $(whoami) ~/yc-serverless-alice-shareable-todolist` для изменения прав доступа текущего пользователя к папке проекта.

      {% endnote %}

  1. После успешной инициализации создайте ресурсы, передав значение OAuth-токена для авторизации в {{ yandex-cloud }}:

      ```bash
      terraform apply -var-file ./variables.json -var yc-token=<OAuth-токен>
      ```

      {{ TF }} автоматически создаст или обновит требуемые ресурсы.

{% endlist %}


### Загрузите код фронтенда в {{ objstorage-name }} {#deploy-frontend}

Чтобы развернуть веб-приложение фронтенда, скомпилируйте статические файлы и загрузите их в {{ objstorage-name }}.

{% list tabs group=programming_language %}

- Bash {#bash}

  1. Перед компиляцией статических файлов убедитесь, что у вас [установлен](#prepare) Node.js и пакетный менеджер npm.
  1. Перейдите в папку `yc-serverless-alice-shareable-todolist/frontend` и выполните команду:

      ```bash
      npm run build
      ```

      Если в процессе компиляции возникает ошибка:

      * `ERR_OSSL_EVP_UNSUPPORTED`, создайте переменную `NODE_OPTIONS`:

         ```bash
         export NODE_OPTIONS=--openssl-legacy-provider
         ```
      * `npm ERR! Could not resolve dependency`, выполните команду:

          ```bash
          npm install --legacy-peer-deps && npm install --force
          ```

      Результат:

      ```text
      > todolist@0.1.0 build
      > react-scripts build

      Creating an optimized production build...
      Compiled successfully.

      File sizes after gzip:

        75.93 KB  build/static/js/2.84be0fca.chunk.js
        23.26 KB  build/static/css/2.ef9168ec.chunk.css
        2.63 KB   build/static/js/main.d9e069c9.chunk.js
        776 B     build/static/js/runtime-main.676997b0.js
        402 B     build/static/css/main.e5cbab88.chunk.css

      The project was built assuming it is hosted at /.
      You can control this with the homepage field in your package.json.

      The build folder is ready to be deployed.
      You may serve it with a static server:

        npm install -g serve
        serve -s build
      ```

  1. Чтобы загрузить файлы в {{ objstorage-name }}, выполните команду:

      ```bash
      cd ../
      ./upload_static.sh
      ```

      Результат:

      ```text
      ./upload_static.sh
      upload: frontend/build/robots.txt to s3://frontent-statics/robots.txt
      upload: frontend/build/manifest.json to s3://frontent-statics/manifest.json
      upload: frontend/build/static/css/main.e5cbab88.chunk.css.map to s3://frontent-statics/static/css/main.e5cbab88.chunk.css.map
      upload: frontend/build/index.html to s3://frontent-statics/index.html
      upload: frontend/build/asset-manifest.json to s3://frontent-statics/asset-manifest.json
      upload: frontend/build/static/js/2.84be0fca.chunk.js.LICENSE.txt to s3://frontent-statics/static/js/2.84be0fca.chunk.js.LICENSE.txt
      upload: frontend/build/static/css/main.e5cbab88.chunk.css to s3://frontent-statics/static/css/main.e5cbab88.chunk.css
      upload: frontend/build/static/js/main.d9e069c9.chunk.js to s3://frontent-statics/static/js/main.d9e069c9.chunk.js
      upload: frontend/build/static/js/2.84be0fca.chunk.js to s3://frontent-statics/static/js/2.84be0fca.chunk.js
      upload: frontend/build/static/js/runtime-main.676997b0.js to s3://frontent-statics/static/js/runtime-main.676997b0.js
      upload: frontend/build/static/js/runtime-main.676997b0.js.map to s3://frontent-statics/static/js/runtime-main.676997b0.js.map
      upload: frontend/build/static/js/main.d9e069c9.chunk.js.map to s3://frontent-statics/static/js/main.d9e069c9.chunk.js.map
      upload: frontend/build/static/css/2.ef9168ec.chunk.css to s3://frontent-statics/static/css/2.ef9168ec.chunk.css
      upload: frontend/build/static/css/2.ef9168ec.chunk.css.map to s3://frontent-statics/static/css/2.ef9168ec.chunk.css.map
      upload: frontend/build/static/js/2.84be0fca.chunk.js.map to s3://frontent-statics/static/js/2.84be0fca.chunk.js.map
      ```

{% endlist %}


### Обновите конфигурацию API-шлюза {#deploy-gateway}

Чтобы загрузить актуальную спецификацию в {{ api-gw-name }}, выполните команду:

{% list tabs group=programming_language %}

- Bash {#bash}

  ```bash
  ./update_gateway.sh
  ```

  Результат:

  ```text
  done (2s)
  id: d5dsj4st2g81********
  folder_id: b1g86q4m5vej********
  created_at: "2024-10-22T16:01:54.777Z"
  name: gate-1
  status: ACTIVE
  domain: {{ api-host-apigw }}
  connectivity:
    network_id: enp3srbi9u49********
  log_options:
    folder_id: b1g86q4m5vej********
  execution_timeout: 300s
  ```

{% endlist %}


## Зарегистрируйте навык Алисы {#register-skill}

### Создайте диалог {#create-dialog}

{% list tabs %}

- Консоль сервиса Яндекс Диалоги

  1. Перейдите в [Яндекс Диалоги](https://dialogs.yandex.ru/) и авторизуйтесь в консоли.
  1. Нажмите **Создать диалог** и выберите тип диалога `Навык`.
  1. В поле **Имя навыка** укажите `Списки дел`.
  1. В поле **Backend** включите опцию **Функция в Яндекс Облаке** и выберите из списка функцию `todolist-alice`, которую вы ранее создали в сервисе {{ sf-name }}.
  1. Включите опцию **Использовать хранилище данных в навыке**.
  1. Заполните обязательные поля в разделе **Публикация в каталоге**. Остальные параметры задайте по своим предпочтениям. Например, можно задать разные словоформы для активации навыка, выбрать голос или тип доступа к навыку.
  1. Нажмите **Сохранить** внизу страницы.

  Подробнее см. в [документации](https://yandex.ru/dev/dialogs/alice/doc/publish.html) сервиса Яндекс Диалоги.

{% endlist %}


### Настройте авторизацию в Алисе {#configure-authorization}

{% list tabs %}

- Консоль сервиса Яндекс Диалоги

  1. Перейдите на вкладку **Связка аккаунтов**.
  1. Введите:

      * **Идентификатор приложения** — значение поля `ClientID` приложения, зарегистрированного в [{{ yandex-oauth }}]({{ ya-oauth-url }}).
      * **Секрет приложения** — значение поля `Client secret` приложения, зарегистрированного в [{{ yandex-oauth }}]({{ ya-oauth-url }}).
      * **URL авторизации** — `{{ ya-oauth-url }}/authorize`.
      * **URL для получения токена** — `{{ ya-oauth-url }}/token`.
      * **URL для обновления токена** — `{{ ya-oauth-url }}/token`.

  1. Нажмите **Сохранить**.

  Подробнее о протоколе OAuth 2.0 читайте в [RFC 6749](https://datatracker.ietf.org/doc/html/rfc6749).

{% endlist %}


### Добавьте интенты {#add-intents}

{% list tabs %}

- Консоль сервиса Яндекс Диалоги

  1. Перейдите на вкладку **Настройки**.
  1. Перейдите на вкладку **Интенты** и нажмите **Создать**.
  1. Добавьте интенты для каждого действия, возможного в диалоге. Разработанные интенты находятся в папке `yc-serverless-alice-shareable-todolist/intents` проекта.
  1. Введите:

      * **Название** — произвольное имя, которое будет отображаться в интерфейсе.
      * **ID** — идентификатор интента, равный имени файла в папке `intents`.
      * **Грамматика** — текст грамматики, равный содержимому файла в папке `intents`.

  1. Нажмите **Сохранить**.
  1. Чтобы завершить создание диалога, в правой части страницы нажмите **На модерацию**.

  Подробнее об интентах см. в [документации Навыков Алисы](https://yandex.ru/dev/dialogs/alice/doc/nlu-docpage/).

{% endlist %}


## Проверьте работу навыка {#test-skill}

Для отладки навыка используйте вкладку **Тестирование** в консоли [Яндекс Диалогов](https://dialogs.yandex.ru/developer) или одну из [поверхностей](https://yandex.ru/dev/dialogs/alice/doc/surfaces.html), выбранных при проектировании навыка.

{% list tabs %}

- В консоли сервиса Яндекс Диалоги

  Перейдите на вкладку **Тестирование**. В левой части отображается чат с Алисой, в правой — протокол взаимодействия в формате JSON.

  Пример диалога:

  ```text
  Давайте я помогу вам со списками!

    Алиса, привет. Создай список Продукты

  Готово, создала список "продукты"

    Добавь молоко в Продукты

  Готово, добавила "молоко" в "продукты"

    Добавь хлеб

  В какой список записать "хлеб"?

    Продукты

  Готово, добавила "хлеб" в "продукты"

    Добавь яйца

  В какой список записать "яйца"?

    Продукты

  Готово, добавила "яйца" в "продукты"

    Алиса, перечисли список Продукты

  продукты:
  1. молоко
  2. хлеб
  3. яйца
  ```

- На поверхности

  Чтобы начать диалог, используйте любое поддерживаемое [Алисой](https://yandex.ru/alice) устройство или сервис.

- На сайте

  В браузере перейдите по адресу, который указан в поле **{{ ui-key.yacloud.serverless-functions.gateways.overview.label_domain }}** API-шлюза `gate-1`, и авторизуйтесь. Откроется страница **Мои списки**. При переходе в любой из списков можно добавить или удалить пункты, а также предоставить доступ к списку другим пользователям.

{% endlist %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

* [Удалите](../../storage/operations/buckets/delete.md) бакет.
* [Удалите](../../ydb/operations/manage-databases.md#delete-db) базу данных.
* [Удалите](../../functions/operations/function/function-delete.md) функции.
* [Удалите](../../api-gateway/operations/api-gw-delete.md) API-шлюз.
* [Удалите](../../logging/operations/delete-group.md) лог-группу.
