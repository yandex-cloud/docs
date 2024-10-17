# Развертывание отказоустойчивой архитектуры с прерываемыми виртуальными машинами


В этом руководстве вы создадите [функцию](../../functions/concepts/function.md) [{{ sf-full-name }}](../../functions/) на языке [Node.js](../../functions/lang/nodejs/index.md), которая будет вызываться по расписанию и запускать [прерываемую ВМ](../../compute/concepts/preemptible-vm.md) {{ compute-full-name }}, если ВМ остановлена.

Описанная в руководстве архитектура подходит для [ВМ](../../compute/concepts/vm.md) с некритичной нагрузкой. Архитектура позволяет использовать ценовое преимущество тарифов на прерываемые ВМ и при этом в случае отключения ВМ обеспечивать время простоя не более одной минуты.

Чтобы развернуть отказоустойчивую архитектуру с прерываемой ВМ:
1. [Подготовьте окружение](#prepare).
1. [Подготовьте ZIP-архив с кодом функции](#zip-archive).
1. [Создайте функцию](#func-create).
1. [Создайте триггер](#trigger-create).
1. [Протестируйте работу функции](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:
* Плата за вычислительные ресурсы ВМ (см. [тарифы {{ compute-name }}](../../compute/pricing.md#prices-instance-resources)).
* Плата за [диски](../../compute/concepts/disk.md) ВМ (см. [тарифы {{ compute-name }}](../../compute/pricing.md#prices-storage)).
* Плата за использование динамического или статического [публичного IP-адреса](../../vpc/concepts/address.md#public-addresses) (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md#prices-public-ip)).
* Плата за хранение [секрета](../../lockbox/concepts/secret.md) и запросы к нему (см. [тарифы {{ lockbox-name }}](../../lockbox/pricing.md)).
* Плата за количество вызовов функции, вычислительные ресурсы, выделенные для выполнения функции, и исходящий трафик (см. [тарифы {{ sf-name }}](../../functions/pricing.md)).
* Плата за запись и хранение данных в [лог-группе](../../logging/concepts/log-group.md) (см. [тарифы {{ cloud-logging-full-name }}](../../logging/pricing.md)), если вы используете сервис [{{ cloud-logging-name }}](../../logging/).

## Подготовьте окружение {#prepare}

1. [Создайте](../../iam/operations/sa/create.md) [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), от имени которого будет вызываться функция, и [назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему [роли](../../iam/concepts/access-control/roles.md) `{{ roles-functions-invoker }}` и `{{ roles-lockbox-payloadviewer }}`.
1. [Создайте](../../compute/operations/vm-create/create-preemptible-vm.md#create-preemptible) прерываемую ВМ.

## Создайте секрет {#create-secret}

Создайте [секрет](../../lockbox/quickstart.md) {{ lockbox-name }} для хранения [OAuth-токена](../../iam/concepts/authorization/oauth-token.md).

{% note info %}

Используйте [OAuth-токен](../../iam/concepts/authorization/oauth-token.md), если у вас нет возможности автоматически запрашивать [IAM-токен](../../iam/concepts/authorization/iam-token.md). IAM-токен обновляется чаще, поэтому более безопасен.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать секрет.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.lockbox.button_create-secret }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** введите имя секрета, например `oauth-token`.
  1. В блоке **{{ ui-key.yacloud.lockbox.label_version-dialog-title }}**:
     * В поле **{{ ui-key.yacloud.lockbox.forms.label_key }}** введите `key_token`.
     * В поле **{{ ui-key.yacloud.lockbox.forms.label_value }}** введите значение OAuth-токена, необходимого для авторизации функции.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  Чтобы создать секрет, выполните команду:

  ```bash
  yc lockbox secret create --name oauth-token \
    --payload "[{'key': 'key_token', 'text_value': '<OAuth-токен>'}]"
  ```

  Где `text_value` — значение OAuth-токена, необходимого для авторизации функции.

  Результат:

  ```text
  done (1s)
  id: e6qu9ik259lb********
  folder_id: b1g9d2k0itu4********
  ...
    status: ACTIVE
    payload_entry_keys:
      - key_token
  ```

- {{ TF }} {#tf}

  1. Опишите в конфигурационном файле параметры секрета:

     ```hcl
     resource "yandex_lockbox_secret" "oauth-token" {
       name = "oauth-token"
     }

     resource "yandex_lockbox_secret_version" "my_version" {
       secret_id = yandex_lockbox_secret.my_secret.id
       entries {
         key        = "key_token"
         text_value = "<OAuth-токен>"
       }
     }
     ```

     Где:

     * `name` — имя секрета.
     * `key` — ключ секрета.
     * `text_value` — значение OAuth-токена, необходимого для авторизации функции.

     {% include [secret-version-tf-note](../../_includes/lockbox/secret-version-tf-note.md) %}

     Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:

     * [yandex_lockbox_secret]({{ tf-provider-resources-link }}/lockbox_secret).
     * [yandex_lockbox_secret_version]({{ tf-provider-resources-link }}/lockbox_secret_version).

  1. Проверьте корректность конфигурационных файлов.
     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Разверните облачные ресурсы.
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание секрета: введите в терминал слово `yes` и нажмите **Enter**.

- API {#api}

  Чтобы создать секрет, воспользуйтесь методом REST API [create](../../lockbox/api-ref/Secret/create.md) для ресурса [Secret](../../lockbox/api-ref/Secret/index.md) или вызовом gRPC API [SecretService/Create](../../lockbox/api-ref/grpc/Secret/create.md).

{% endlist %}

## Подготовьте ZIP-архив с кодом функции {#zip-archive}

1. Сохраните следующий код в файл с названием `index.js`:

   ```javascript
   import { serviceClients, Session, cloudApi } from '@yandex-cloud/nodejs-sdk';

   const {
     compute: {
       instance_service: {
         ListInstancesRequest,
         GetInstanceRequest,
         StartInstanceRequest,
       },
       instance: {
         IpVersion,
       },
     },
   } = cloudApi;

   const FOLDER_ID = process.env.FOLDER_ID;
   const INSTANCE_ID = process.env.INSTANCE_ID;
   const OAUTHTOKEN = process.env.OAUTHTOKEN;

   export const handler = async function (event, context) {
     const session = new Session({ oauthToken: OAUTHTOKEN });
     const instanceClient = session.client(serviceClients.InstanceServiceClient);
     const list = await instanceClient.list(ListInstancesRequest.fromPartial({
       folderId: FOLDER_ID,
     }));
     const state = await instanceClient.get(GetInstanceRequest.fromPartial({
       instanceId: INSTANCE_ID,
     }));

     var status = state.status

     if (status == 4){
       const startcommand = await instanceClient.start(StartInstanceRequest.fromPartial({
         instanceId: INSTANCE_ID,
       }));
     }

     return {
       statusCode: 200,
       body: {
         status
       }
     };
   };
   ```

1. Сохраните следующий код в файл с названием `package.json`:

   ```json
   {
     "name": "my-awesome-package",
     "version": "1.0.0",
     "type": "module",
     "dependencies": {
       "@yandex-cloud/nodejs-sdk": "latest"
     }
   }
   ```

1. Добавьте файлы `index.js` и `package.json` в ZIP-архив `function-js.zip`.

## Создайте функцию {#func-create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать функцию.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Создайте функцию:
     1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
     1. В открывшемся окне введите имя функции `function-restart-vms`.
     1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Создайте [версию функции](../../functions/concepts/function.md#version):
     1. Выберите среду выполнения `nodejs18`, отключите опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** и нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
     1. В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}** выберите `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}`.
     1. В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_file }}** нажмите кнопку **Прикрепить файл** и выберите архив `function-js.zip`, который создали ранее.
     1. Укажите точку входа `index.handler`.
     1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}** укажите:
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** — `3`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}** — `128 {{ ui-key.yacloud.common.units.label_megabyte }}`.
        * **{{ ui-key.yacloud.forms.label_service-account-select }}** — выберите созданный ранее сервисный аккаунт с правами на вызов функции.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}**:
          * `FOLDER_ID` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором вы хотите запускать остановленные ВМ.
          * `INSTANCE_ID` — [идентификатор ВМ](../../compute/operations/vm-info/get-info.md#outside-instance), которую вы хотите запускать при прерывании.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret }}**:
          * В поле **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-env-key }}** укажите `OAUTHTOKEN`.
          * В поле **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret-id }}** выберите созданный ранее секрет `oauth-token`.
          * В поле **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-version-id }}** выберите версию секрета.
          * В поле **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret-key }}** выберите имя ключа `key_token`.
        * Если вы не хотите сохранять логи и платить за использование сервиса {{ cloud-logging-name }}, в блоке **{{ ui-key.yacloud.logging.label_title }}**, в поле **{{ ui-key.yacloud.logging.label_destination }}**, выберите `{{ ui-key.yacloud.serverless-functions.item.editor.option_queues-unset }}`, чтобы отключить логирование.
     1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Создайте функцию `function-restart-vms`:

     ```bash
     yc serverless function create --name function-restart-vms
     ```

     Результат:

     ```text
     id: d4ebrmenrr7l********
     folder_id: b1g9d2k0itu4********
     created_at: "2023-10-28T17:26:58.200799757Z"
     name: function-restart-vms
     http_invoke_url: https://functions.yandexcloud.net/d4ebrmenrr7l********
     status: ACTIVE
     ```

  1. Создайте [версию функции](../../functions/concepts/function.md#version) `function-restart-vms`:

     ```bash
     yc serverless function version create \
       --function-name function-restart-vms \
       --memory=128m \
       --execution-timeout=3s \
       --runtime=nodejs18 \
       --entrypoint=index.handler \
       --service-account-id=<идентификатор_сервисного_аккаунта> \
       --environment FOLDER_ID=<идентификатор_каталога>,INSTANCE_ID=<идентификатор_ВМ> \
       --secret name=oauth-token,version-id=<идентификатор_версии_секрета>,key=key_token,environment-variable=OAUTHTOKEN \
       --source-path=./function-js.zip \
       --no-logging
     ```

     Где:
     * `--function-name` — имя функции, версия которой создается.
     * `--memory` — объем RAM.
     * `--execution-timeout` — максимальное время выполнения функции до таймаута.
     * `--runtime` — среда выполнения.
     * `--entrypoint` — точка входа.
     * `--service-account-id` — [идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта с правами на вызов функции.
     * `--environment` — переменные окружения:
       * `FOLDER_ID` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором вы хотите запускать остановленные ВМ.
       * `INSTANCE_ID` — [идентификатор ВМ](../../compute/operations/vm-info/get-info.md#outside-instance), которую вы хотите запускать при прерывании.
     * `--secret` — данные секрета {{ lockbox-name }}:
       * `name` — имя секрета.
       * `version-id` — идентификатор [версии секрета](../../lockbox/concepts/secret.md#version).
       * `key` — ключ секрета.
       * `environment-variable` — переменная окружения, в которой будет храниться секрет.
     * `--source-path` — путь к созданному ранее ZIP-архиву `function-js.zip`.
     * (опционально) `--no-logging` — укажите этот флаг, если вы не хотите сохранять логи и платить за использование сервиса {{ cloud-logging-name }}.

     Результат:

     ```text
     done (16s)
     id: d4etv5f4sjet********
     function_id: d4ebrmenrr7l********
     ...
     log_options:
       disabled: true
       folder_id: b1g9d2k0itu4********
     ```

- {{ TF }} {#tf}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. Опишите в конфигурационном файле параметры функции `function-restart-vms` и ее [версии](../../functions/concepts/function.md#version):

     ```hcl
     resource "yandex_function" "function-restart-vms" {
       name               = "function-restart-vms"
       user_hash          = "first function"
       runtime            = "nodejs18"
       entrypoint         = "index.handler"
       memory             = "128"
       execution_timeout  = "3"
       service_account_id = "<идентификатор_сервисного_аккаунта>"
       folder_id = "<идентификатор_каталога>"
       environment = {
         FOLDER_ID = "<идентификатор_каталога>"
         INSTANCE_ID = "<идентификатор_ВМ>"
       }
       secrets {
         id = "<идентификатор_секрета>"
         version_id = "<идентификатор_версии_секрета>"
         key = "key_token"
         environment_variable = "OAUTHTOKEN"
       }
       content {
         zip_filename = "./function-js.zip"
       }
     }
     ```

     Где:
     * `name` — имя функции.
     * `user_hash` — произвольная строка, определяющая версию функции.
     * `runtime` — [среда выполнения](../../functions/concepts/runtime/index.md) функции.
     * `entrypoint` — точка входа.
     * `memory` — объем памяти в мегабайтах, отведенный для выполнения функции.
     * `execution_timeout` — таймаут выполнения функции.
     * `service_account_id` — [идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта с правами на вызов функции.
     * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором вы создаете функцию.
     * `environment` — переменные окружения:
       * `FOLDER_ID` — идентификатор каталога, в котором вы хотите запускать остановленные ВМ.
       * `INSTANCE_ID` — [идентификатор ВМ](../../compute/operations/vm-info/get-info.md#outside-instance), которую вы хотите запускать при прерывании.
     * `secrets` — данные секрета {{ lockbox-name }}:
       * `id` — идентификатор секрета.
       * `version_id` — идентификатор [версии секрета](../../lockbox/concepts/secret.md#version).
       * `key` — ключ секрета.
       * `environment_variable` — переменная окружения, в которой будет храниться секрет.
     * `zip_filename` — путь к созданному ранее ZIP-архиву `function-js.zip`.

     Более подробную информацию о параметрах ресурса `yandex_function` см. в [документации провайдера]({{ tf-provider-resources-link }}/function).
  1. Проверьте корректность конфигурационных файлов.
     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Разверните облачные ресурсы.
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание функции: введите в терминал слово `yes` и нажмите **Enter**.

        После этого в указанном каталоге будет создана функция `function-restart-vms`. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

        ```bash
        yc serverless function get function-restart-vms
        ```

        Результат:

        ```text
        id: d4ees84gsdsd********
        folder_id: b1g9d2k0itu4********
        created_at: "2023-08-09T10:11:40.740Z"
        name: function-restart-vms
        log_group_id: ckgjitlio5aj********
        http_invoke_url: https://functions.yandexcloud.net/d4ees84gsdsd********
        status: ACTIVE
        ```

- API {#api}

  Чтобы создать функцию, воспользуйтесь методом [create](../../functions/functions/api-ref/Function/create.md) для ресурса [Function](../../functions/functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/Create](../../functions/functions/api-ref/grpc/Function/create.md).

  Чтобы создать версию функцию, воспользуйтесь методом [createVersion](../../functions/functions/api-ref/Function/createVersion.md) для ресурса [Function](../../functions/functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/CreateVersion](../../functions/functions/api-ref/grpc/Function/create.mdVersion).

{% endlist %}

## Создайте триггер {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать [триггер](../../functions/concepts/trigger/index.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:
     * Введите имя триггера — `timer`.
     * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_timer }}`.
     * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}`.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_timer }}** введите `* * ? * * *` или выберите `{{ ui-key.yacloud.common.button_cron-1min }}`.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}** выберите функцию `function-restart-vms` и укажите:
     * [**{{ ui-key.yacloud.serverless-functions.triggers.form.field_function-tag }}**](../../functions/concepts/function.md#tag) — `$latest`.
     * Сервисный аккаунт с правами на вызов функции, который создали ранее.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

  Чтобы создать [триггер](../../functions/concepts/trigger/index.md), который вызывает функцию, выполните команду:

  ```bash
  yc serverless trigger create timer \
    --name timer \
    --cron-expression '* * ? * * *' \
    --invoke-function-name function-restart-vms \
    --invoke-function-service-account-id <идентификатор_сервисного_аккаунта>
  ```

  Где:
  * `--name` — имя триггера.
  * `--cron-expression` — расписание вызова функции в формате [cron-выражения](../../functions/concepts/trigger/timer.md#cron-expression).
  * `--invoke-function-name` — имя вызываемой функции.
  * `--invoke-function-service-account-id` — идентификатор сервисного аккаунта с правами на вызов функции.

  Результат:

  ```text
  id: a1sv54ekvknb********
  folder_id: b1g9d2k0itu4********
  created_at: "2023-08-08T19:46:22.860681482Z"
  ...
        function_tag: $latest
        service_account_id: ajeh2dukocg3********
  status: ACTIVE
  ```

- {{ TF }} {#tf}

  Чтобы создать [триггер](../../functions/concepts/trigger/index.md), который запускает функцию:
  1. Опишите в конфигурационном файле параметры триггера `timer`:

     ```hcl
     resource "yandex_function_trigger" "timer" {
       name        = "timer"
       timer {
         cron_expression = "* * ? * * *"
       }
       function {
         id = "<идентификатор_функции>"
         service_account_id = "<идентификатор_сервисного_аккаунта>"
       }
     }
     ```

     Где:
     * `name` — имя триггера.
     * `cron_expression` — расписание вызова функции в формате [cron-выражения](../../functions/concepts/trigger/timer.md#cron-expression).
     * `id` — идентификатор функции, которую будет запускать триггер.
     * `service_account_id` — идентификатор сервисного аккаунта с правами на вызов функции.

     Более подробную информацию о параметрах ресурсов в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/function_trigger).
  1. Проверьте корректность конфигурационных файлов.
     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Разверните облачные ресурсы.
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

        После этого в указанном каталоге будет создан триггер `timer`. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

        ```bash
        yc serverless trigger get timer
        ```

        Результат:

        ```text
        id: a1s4bvdvmod0********
        folder_id: b1g9d2k0itu4********
        created_at: "2023-08-09T10:19:12.356Z"
        ...
              function_id: d4ebrmenrr7l********
              service_account_id: ajeh2dukocg3********
        status: ACTIVE
        ```

- API {#api}

  Чтобы создать таймер, воспользуйтесь методом REST API [create](../../functions/triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../functions/triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../../functions/triggers/api-ref/grpc/Trigger/create.md).

{% endlist %}

## Протестируйте работу функции {#test}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором создана ваша прерываемая ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. Напротив имени нужной ВМ нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.stop }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.instances.popup-confirm_button_stop }}**. Статус ВМ изменится на `Stopped`.
  1. Проверьте состояние ВМ через 1 минуту или более. Статус ВМ должен измениться на `Running`.

{% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. [Удалите триггер](../../functions/operations/trigger/trigger-delete.md).
1. [Удалите функцию](../../functions/operations/function/function-delete.md).
1. [Удалите секрет](../../lockbox/operations/secret-delete.md).
1. [Удалите ВМ](../../compute/operations/vm-control/vm-delete.md).
1. Если вы записывали логи в лог-группу, [удалите ее](../../logging/operations/delete-group.md).