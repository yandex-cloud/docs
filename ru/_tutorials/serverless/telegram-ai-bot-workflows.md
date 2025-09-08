# Как создать бота в Telegram с поддержкой AI-агента с помощью {{ sw-full-name }}


С помощью serverless-технологий можно создать [бота](../../glossary/chat-bot.md) для Telegram с поддержкой [модели генерации текста](../../foundation-models/concepts/generation/models.md) на базе сервиса [{{ foundation-models-full-name }}](../../foundation-models/).

В этом руководстве вы создадите бота для подбора фильмов на основании предпочтений пользователя. Для этого вы организуете хранение данных в [{{ objstorage-full-name }}](../../storage/) и [{{ lockbox-full-name }}](../../lockbox/), настроите логику бота в [{{ sw-full-name }}](../../serverless-integrations/) и вебхук с помощью [{{ api-gw-full-name }}](../../api-gateway/).

Чтобы создать бота:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Зарегистрируйте Telegram-бота](#create-bot).
1. [Создайте секрет](#create-secret).
1. [Создайте бакет](#create-bucket).
1. [Создайте сервисные аккаунты](#create-sa).
1. [Настройте рабочий процесс](#config-workflow).
1. [Настройте API-шлюз](#config-api-gateway).
1. [Настройте вебхук для бота](#config-webhook).
1. [Проверьте работу бота](#check-result).
1. [Настройте агент под вашу задачу](#customize).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки Telegram-бота входят:

* плата за генерацию текста (см. [тарифы {{ foundation-models-full-name }}](../../foundation-models/pricing.md));
* плата за хранение секрета и запросы к нему (см. [тарифы {{ lockbox-full-name }}](../../lockbox/pricing.md));
* плата за объем хранилища, занятый данными, количество операций с данными и исходящий трафик (см. [тарифы {{ objstorage-full-name }}](../../storage/pricing.md));
* плата за количество запросов к созданному API-шлюзу и исходящий трафик (см. [тарифы {{ api-gw-full-name }}](../../api-gateway/pricing.md));
* плата за получение и хранение логов (см. [тарифы {{ cloud-logging-full-name }}](../../logging/pricing.md)).


## Зарегистрируйте Telegram-бота {#create-bot}

Зарегистрируйте вашего бота в Telegram и получите токен.

1. Для регистрации нового бота запустите бота [BotFather](https://t.me/BotFather) и отправьте команду:

    ```text
    /newbot
    ```

1. Укажите имя создаваемого бота, например `Serverless AI Telegram Bot`. Это имя увидят пользователи при общении с ботом.
1. Укажите имя пользователя создаваемого бота, например `ServerlessAITelegramBot`. По имени пользователя можно будет найти бота в Telegram. Имя пользователя должно оканчиваться на `...Bot` или `..._bot`.

    В результате вы получите токен. Сохраните его, он потребуется в дальнейшем.


## Создайте секрет {#create-secret}

Создайте [секрет](../../lockbox/concepts/secret.md), в котором будет храниться токен для доступа к API Telegram.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы будете создавать инфраструктуру.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. Нажмите **{{ ui-key.yacloud.lockbox.button_create-secret }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** введите имя секрета.
  1. Выберите тип секрета `{{ ui-key.yacloud.lockbox.forms.title_secret-type-custom }}`.
  1. В поле **{{ ui-key.yacloud.lockbox.forms.label_key }}** введите `token`.
  1. В поле **{{ ui-key.yacloud.lockbox.forms.label_value }}** укажите токен бота, полученный при его [создании](#create-bot).
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания секрета:

      ```bash
      yc lockbox secret create --help
      ```

  1. Создайте секрет:

      ```bash
      yc lockbox secret create \
        --name tg-bot-token \
        --payload '[{"key":"token","text_value":"<токен_бота>"}]'
      ```

      Где:

      * `--name` — имя секрета.
      * `--payload` — содержимое секрета в виде массива формата YAML или JSON:

          * `key` — ключ секрета.
          * `text_value` — значение секрета. Укажите токен, полученный при [создании бота](#create-bot).

      Результат:

      ```text
      id: e6qf05v4ftms********
      folder_id: b1g681qpemb4********
      created_at: "2025-08-20T12:26:02.961Z"
      name: tg-bot-token
      status: ACTIVE
      current_version:
        id: e6q768pl3vrf********
        secret_id: e6qf05v4ftms********
        created_at: "2025-08-20T12:26:02.961Z"
        status: ACTIVE
        payload_entry_keys:
          - token
      ```

- API {#api}

  Чтобы создать секрет, воспользуйтесь методом REST API [Create](../../lockbox/api-ref/Secret/create.md) для ресурса [Secret](../../lockbox/api-ref/Secret/index.md) или вызовом gRPC API [SecretService/Create](../../lockbox/api-ref/grpc/Secret/create.md).

{% endlist %}


## Создайте бакет {#create-bucket}

Создайте [бакет](../../storage/concepts/bucket.md) для хранения истории чата с ботом.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. На панели сверху нажмите **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. Введите имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).
  1. Укажите максимальный размер бакета `5 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. Нажмите **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

- {{ yandex-cloud }} CLI {#cli}

  1. Посмотрите описание команды CLI для создания бакета:

      ```bash
      yc storage bucket create --help
      ```

  1. Создайте бакет в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

      ```bash
      yc storage bucket create \
        --name <имя_бакета> \
        --default-storage-class standard \
        --max-size 5368709120
      ```

      Где:

      * `--name` — имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).
      * `--default-storage-class` — [класс хранилища](../../storage/concepts/storage-class.md).
      * `--max-size` — максимальный размер бакета в байтах.

      Результат:

      ```text
      name: bot-history-storage
      folder_id: b1g681qpemb4********
      anonymous_access_flags: {}
      default_storage_class: STANDARD
      versioning: VERSIONING_DISABLED
      max_size: "5368709120"
      created_at: "2025-08-20T12:23:21.361186Z"
      resource_id: e3erbgk1qmih********
      ```

- AWS CLI {#aws-cli}

  {% include [aws-cli-install](../../_includes/aws-cli-install.md) %}

  Чтобы создать бакет, [назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту, через который работает AWS CLI, [роль](../../storage/security/#storage-editor) `storage.editor`.

  В терминале выполните команду:

  ```bash
  aws s3api create-bucket \
    --endpoint-url=https://{{ s3-storage-host }} \
    --bucket <имя_бакета>
  ```

  Где:

  * `--endpoint-url` — эндпоинт {{ objstorage-name }}.
  * `--bucket` — имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).

- API {#api}

  Чтобы создать бакет, воспользуйтесь методом REST API [Create](../../storage/api-ref/Bucket/create.md) для ресурса [Bucket](../../storage/api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Create](../../storage/api-ref/grpc/Bucket/create.md) или методом S3 API [create](../../storage/s3/api-ref/bucket/create.md).

{% endlist %}


## Создайте сервисные аккаунты {#create-sa}

Cоздайте два [сервисных аккаунта](../../iam/concepts/users/service-accounts.md):

* `sa-apigw` — от его имени будет запускаться [рабочий процесс](../../serverless-integrations/concepts/workflows/workflow.md) {{ sw-name }};
* `sa-workflows` — от его имени будут выполняться шаги рабочего процесса.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя сервисного аккаунта `sa-apigw`.
  1. Нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите [роль](../../iam/roles-reference.md) `serverless.workflows.executor`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

  Аналогичным образом создайте сервисный аккаунт с именем `sa-workflows` и назначьте ему роли:

  * `storage.uploader`
  * `storage.viewer`
  * `{{ roles-lockbox-payloadviewer }}`
  * `{{ roles-yagpt-user }}`

- {{ yandex-cloud }} CLI {#cli}

  1. Посмотрите описание команды CLI для создания сервисного аккаунта:

      ```bash
      yc iam service-account create --help
      ```

  1. Создайте сервисные аккаунты:

      ```bash
      yc iam service-account create --name sa-apigw
      yc iam service-account create --name sa-workflows
      ```

      Где `--name` — имя сервисного аккаунта.

      Результат:

      ```text
      id: ajeu2s3k358j********
      folder_id: b1g681qpemb4********
      created_at: "2025-08-20T12:18:37.599632350Z"
      name: sa-apigw

      id: ajersnus6rb2********
      folder_id: b1g681qpemb4********
      created_at: "2025-08-20T12:18:41.869376672Z"
      name: sa-workflows
      ```

  1. Сохраните идентификаторы сервисных аккаунтов и идентификатор каталога в переменные:

      ```bash
      APIGW_SA=$(yc iam service-account get --name sa-apigw --format json | jq -r .id)
      WF_SA=$(yc iam service-account get --name sa-workflows --format json | jq -r .id)
      FOLDER_ID=$(yc config get folder-id)
      ```

  1. Посмотрите описание команды CLI для назначения [роли](../../iam/roles-reference.md) на каталог:

      ```bash
      yc resource-manager folder add-access-binding --help
      ```

  1. Назначьте сервисным аккаунтам роли на каталог:

      ```bash
      yc resource-manager folder add-access-binding \
        --id $FOLDER_ID \
        --role serverless.workflows.executor \
        --subject serviceAccount:$APIGW_SA

      yc resource-manager folder add-access-binding \
        --id $FOLDER_ID \
        --role storage.uploader \
        --subject serviceAccount:$WF_SA

      yc resource-manager folder add-access-binding \
        --id $FOLDER_ID \
        --role storage.viewer \
        --subject serviceAccount:$WF_SA

      yc resource-manager folder add-access-binding \
        --id $FOLDER_ID \
        --role {{ roles-lockbox-payloadviewer }} \
        --subject serviceAccount:$WF_SA

      yc resource-manager folder add-access-binding \
        --id $FOLDER_ID \
        --role {{ roles-yagpt-user }} \
        --subject serviceAccount:$WF_SA
      ```

      Где:

      * `--id` — идентификатор каталога.
      * `--role` — роль.
      * `--subject` — идентификатор сервисного аккаунта.

      Результат:

      ```text
      effective_deltas:
        - action: ADD
          access_binding:
            role_id: serverless.workflows.executor
            subject:
              id: ajeu2s3k358j********
              type: serviceAccount
      ...
      effective_deltas:
        - action: ADD
          access_binding:
            role_id: {{ roles-yagpt-user }}
            subject:
              id: ajersnus6rb2********
              type: serviceAccount
      ```

- API {#api}

  Создайте сервисные аккаунты:

  * `sa-apigw` с ролью `serverless.workflows.executor`.
  * `sa-workflows` с ролями:

      * `storage.uploader`
      * `storage.viewer`
      * `{{ roles-lockbox-payloadviewer }}`
      * `{{ roles-yagpt-user }}`

  Чтобы создать сервисный аккаунт, воспользуйтесь методом REST API [Create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).

  Чтобы назначить роль сервисному аккаунту, воспользуйтесь методом REST API [updateAccessBindings](../../iam/api-ref/ServiceAccount/updateAccessBindings.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/UpdateAccessBindings](../../iam/api-ref/grpc/ServiceAccount/updateAccessBindings.md).

{% endlist %}


## Настройте рабочий процесс {#config-workflow}

Настройте рабочий процесс, который обеспечит чтение и сохранение истории чата, вызов AI-агента и отправку ответов в Telegram.


### Подготовьте YaWL-спецификацию {#prepare-spec-wf}

Сохраните [YaWL-спецификацию](../../serverless-integrations/concepts/workflows/yawl/index.md) рабочего процесса в YAML-файле, например `yawl-spec.yaml`:

```yaml
yawl: '0.1'
start: do_work
steps:
  do_work:
    parallel:
      branches:

        # Ветка, отправляющая «typing», чтобы чат ожил быстрее
        send_typing_action:
          start: send_typing_action
          steps:
            send_typing_action:
              httpCall:
                url: >-
                  https://api.telegram.org/bot\(lockboxPayload("<идентификатор_секрета>"; "token"))/sendChatAction
                method: POST
                headers:
                  Content-Type: application/json
                body: |
                  \({
                    chat_id: .input.message.chat.id,
                    action: "typing"
                  })

        # Основная логика
        handle_update:
          start: get_history
          steps:
            get_history:
              objectStorage:
                bucket: <имя_бакета>
                object: history/\(.input.message.chat.id).json
                get:
                  contentType: JSON
                output: '\({history: .Content})'
                next: call_ai
                catch:
                  - errorList:
                      - STEP_INVALID_ARGUMENT # файла нет или не JSON -> инициализируем
                    errorListMode: INCLUDE
                    output: '\({history: []})'
                    next: call_ai

            call_ai:
              aiAgent:
                agentConfig:
                  role: Ты консультант по подбору фильмов
                  goal: >-
                    Помочь пользователю выбрать фильм по его предпочтениям.
                    При первом обращении попроси несколько любимых фильмов
                    (по одной в строке). Дальше используй их для рекомендаций
                    и задавай уточняющие вопросы.
                  backstory: >-
                    История предыдущего общения (формат JSON-массив объектов {role,message}):
                    "\(.history)"
                  model:
                    name: yandexgpt
                tasks:
                  - description: \(.input.message.text)
                    result: Ответ в Markdown для отправки в Telegram.
                output: '\({reply: .Result})'
                next: send_reply

            send_reply:
              telegramBot:
                token: \(lockboxPayload("<идентификатор_секрета>"; "token"))
                sendMessage:
                  chatId: \(.input.message.chat.id)
                  text: \(.reply)
                  replyTo: \(.input.message.message_id)
                  parseMode: MARKDOWN
                next: save_history

            save_history:
              objectStorage:
                bucket: <имя_бакета>
                object: history/\(.input.message.chat.id).json
                put:
                  contentType: JSON
                  content: >-
                    \(
                      .history +
                      [
                        {role:"user", message:.input.message.text},
                        {role:"assistant", message:.reply}
                      ]
                    )
```

Где:

* `<имя_бакета>` — имя бакета, [созданного ранее](#create-bucket).
* `<идентификатор_секрета>` — идентификатор секрета, [созданного ранее](#create-secret).

В примере используется текстовая модель {{ gpt-pro }} (`name: yandexgpt`). Вы можете использовать [другую модель](../../foundation-models/concepts/generation/models.md#generation), доступную в синхронном режиме в сервисе {{ foundation-models-name }}.


### Создайте рабочий процесс {#create-workflow}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
  1. В правом верхнем углу нажмите **{{ ui-key.yacloud.serverless-workflows.button_create-workflow }}**.
  1. Выберите способ `{{ ui-key.yacloud.serverless-workflows.spec-editor-type_label_text-editor }}`.
  1. В редакторе кода вставьте текст подготовленной ранее YaWL-спецификации рабочего процесса.
  1. Раскройте блок **{{ ui-key.yacloud.serverless-workflows.label_additional-parameters }}**:

      1. Введите имя рабочего процесса. Требования к имени:

          {% include [name-format](../../_includes/name-format.md) %}

      1. Выберите сервисный аккаунт `sa-workflows`.
      1. В блоке **{{ ui-key.yacloud.logging.label_title }}** отключите опцию **{{ ui-key.yacloud.logging.field_logging }}**, если не хотите платить за хранение логов.

  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- {{ yandex-cloud }} CLI {#cli}

  1. Посмотрите описание команды CLI для создания рабочего процесса:

      ```bash
      yc serverless workflow create --help
      ```

  1. Создайте рабочий процесс:

      ```bash
      yc serverless workflow create \
        --yaml-spec <файл_спецификации> \
        --name <имя_рабочего_процесса> \
        --service-account-id $WF_SA
      ```

      Где:

      * `--yaml-spec` — путь к файлу с YaWL-спецификацией рабочего процесса, подготовленной ранее. Например: `./yawl-spec.yaml`.
      * `--name` — имя рабочего процесса. Требования к имени:

          {% include [name-format](../../_includes/name-format.md) %}

      * `--service-account-id` — идентификатор сервисного аккаунта `sa-workflows`.

      Результат:

      ```text
      id: dfqjl5hh5p90********
      folder_id: b1g681qpemb4********
      specification:
        spec_yaml: "yawl: ..."
      created_at: "2025-03-11T09:27:51.691990Z"
      name: my-workflow
      status: ACTIVE
      log_options: {}
      service_account_id: aje4tpd9coa********
      ```

- API {#api}

  Чтобы создать рабочий процесс, воспользуйтесь методом REST API [Create](../../serverless-integrations/workflows/api-ref/Workflow/create.md) для ресурса [Workflows](../../serverless-integrations/workflows/api-ref/Workflow/index.md) или вызовом gRPC API [Workflow/Create](../../serverless-integrations/workflows/api-ref/grpc/Workflow/create.md).

{% endlist %}


## Настройте API-шлюз {#config-api-gateway}

Настройте [API-шлюз](../../api-gateway/concepts/index.md) в качестве вебхука Telegram.


### Подготовьте спецификацию API {#prepare-spec-api}

Сохраните спецификацию API по стандарту [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification) в YAML-файле, например `api-spec.yaml`:

```yaml
openapi: 3.0.0
info:
  title: Telegram Webhook → Workflows
  version: 1.0.0
paths:
  /handle:
    post:
      x-yc-apigateway-integration:
        type: http
        method: POST
        service_account_id: <идентификатор_сервисного_аккаунта>  # сервисный аккаунт sa-apigw
        url: https://serverless-workflows.api.cloud.yandex.net/workflows/v1/execution/start
      requestBody:
        description: Telegram update passthrough to Workflows
        content:
          application/json:
            schema:
              x-yc-schema-mapping:
                type: static
                template:
                  workflowId: <идентификатор_рабочего_процесса>  # ваш рабочий процесс
                  input:
                    inputJson: ${.|tojson}  # весь апдейт Telegram как input
```

Где:

* `<идентификатор_сервисного_аккаунта>` — идентификатор сервисного аккаунта `sa-apigw`.
* `<идентификатор_рабочего_процесса>` — идентификатор рабочего процесса, созданного на [предыдущем шаге](#create-workflow).


### Создайте API-шлюз {#create-api-gw}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. Нажмите **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** введите имя API-шлюза. Требования к имени:

      {% include [name-format](../../_includes/name-format.md) %}

  1. В блок **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** вставьте текст спецификации OpenAPI, подготовленной ранее.
  1. В блоке **{{ ui-key.yacloud.logging.label_title }}** отключите опцию **{{ ui-key.yacloud.logging.field_logging }}**, если не хотите платить за хранение логов.
  1. Нажмите **{{ ui-key.yacloud.serverless-functions.gateways.form.button_create-gateway }}**.
  1. Дождитесь создания API-шлюза и выберите его.
  1. Сохраните значение поля **{{ ui-key.yacloud.serverless-functions.gateways.overview.label_domain }}** — оно понадобится на следующем шаге.

- {{ yandex-cloud }} CLI {#cli}

  1. Посмотрите описание команды CLI для создания API-шлюза:

      ```bash
      {{ yc-serverless }} api-gateway create --help
      ```

  1. Создайте API-шлюз:

      ```bash
      {{ yc-serverless }} api-gateway create \
        --name <имя_API-шлюза> \
        --spec=<путь_к_файлу_спецификации>
      ```

      Где:

      * `--name` — имя API-шлюза. Требования к имени:

          {% include [name-format](../../_includes/name-format.md) %}

      * `--spec` — путь к созданному ранее файлу со спецификацией.

      Результат:

      ```text
      id: d5d63uh1h26g********
      folder_id: b1g681qpemb4********
      created_at: "2025-06-14T10:23:19.682Z"
      name: ai-bot-gw
      status: ACTIVE
      domain: d5d63uh1h26g********.********.apigw.yandexcloud.net
      connectivity: {}
      log_options:
        folder_id: b1g681qpemb4********
      execution_timeout: 300s
      ```

  1. Сохраните значение поля `domain` — оно понадобится на следующем шаге.

- API {#api}

  Чтобы создать API-шлюз, воспользуйтесь методом REST API [Create](../../api-gateway/apigateway/api-ref/ApiGateway/create.md) для ресурса [ApiGateway](../../api-gateway/apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/Create](../../api-gateway/apigateway/api-ref/grpc/ApiGateway/create.md).

{% endlist %}


## Настройте вебхук для бота {#config-webhook}

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните команду:

  ```bash
  curl -s "https://api.telegram.org/bot<токен_бота>/setWebhook" \
    -d "url=<служебный_домен>/handle"
  ```

  Где:

  * `<токен_бота>` — токен, полученный при [создании бота](#create-bot).
  * `<служебный_домен>` — служебный домен API-шлюза, полученный при его [создании](#create-api-gw).

  Например:

  ```bash
  curl -s "https://api.telegram.org/bot1357246809:AAFhSteLniAw71g8jx6K5kTErO3********/setWebhook" \
    -d "url=https://d5d0jdhgrro2********.********.apigw.yandexcloud.net/handle"
  ```

  Результат:

  ```text
  {"ok":true,"result":true,"description":"Webhook was set"}
  ```

{% endlist %}


## Проверьте работу бота {#check-result}

1. Найдите бота в Telegram по имени пользователя бота, созданного [ранее](#create-bot).
1. Нажмите **СТАРТ**, чтобы начать чат.
1. Отправьте боту список из нескольких фильмов — по одному названию в строке.

    Например:

    ```text
    Фильм 1
    Фильм 2
    Фильм 3
    ```

    Ответ бота:

    ```text
    Здравствуйте! Спасибо за ваши предпочтения. На основе ваших любимых фильмов я могу предложить вам следующие кинокартины:
    ...
    Какой из предложенных фильмов вас заинтересовал? Или, может быть, у вас есть ещё какие-то предпочтения, которые вы хотели бы учесть?
    ```


#### Что дальше {#what-is-next}

Попробуйте изменить YaWL-спецификацию рабочего процесса под вашу задачу. Например, измените запрос к текстовой модели:

```yaml
...
call_ai:
  aiAgent:
    agentConfig:
      role: Ты консультант по подбору музыкальных исполнителей
      goal: >-
        Помочь пользователю выбрать музыку по его предпочтениям.
        При первом обращении попроси несколько любимых
        групп, музыкантов, композиторов, жанров (по одному в строке).
        Дальше используй их для рекомендаций и задавай уточняющие вопросы.
```

Также вы можете добавить текст или файлы в качестве источников информации. Подробнее см. [описание интеграционного шага AIAgent](../../serverless-integrations/concepts/workflows/yawl/integration/aiagent.md).


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

* [Удалите](../../api-gateway/operations/api-gw-delete.md) API-шлюз.
* [Удалите](../../serverless-integrations/operations/workflows/workflow/delete.md) рабочий процесс.
* [Удалите](../../storage/operations/buckets/delete.md) бакет.
* [Удалите](../../lockbox/operations/secret-delete.md) секрет.
* Если вы оставляли включенной опцию записи логов рабочего процесса или API-шлюза, [удалите](../../logging/operations/delete-group.md) лог-группу.