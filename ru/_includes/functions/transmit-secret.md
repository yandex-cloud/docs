Чтобы функция получила доступ к [секрету](../../lockbox/concepts/secret.md), в ее параметрах нужно указать [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), у которого есть роли:
* `{{ roles-lockbox-payloadviewer }}` на секрет ([как назначить права доступа на секрет](../../lockbox/operations/secret-access.md));
* `kms.keys.encrypterDecrypter` на ключ шифрования, если секрет создан с использованием ключа {{ kms-full-name }} ([как назначить права доступа на ключ шифрования](../../kms/operations/key-access.md)).

Секрет {{ lockbox-short-name }}, который передается в функцию, кешируется в {{ sf-name }}. После того как сервисный аккаунт потеряет доступ к секрету, функция может хранить его до 5 минут.

При передаче секретов создается новая версия функции. В существующую версию секреты передать нельзя.

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Откройте сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Выберите функцию, в которую хотите передать секрет {{ lockbox-name }}.
    1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}**.
    1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}** укажите:
        * в поле **{{ ui-key.yacloud.forms.label_service-account-select }}** — сервисный аккаунт, у которого есть роль `{{ roles-lockbox-payloadviewer }}`;
        * в поле **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret }}**:
            * имя переменной окружения, в которой будет храниться секрет;
            * идентификатор секрета;
            * идентификатор версии секрета;
            * неконфиденциальный идентификатор ключа.
    1. Нажмите **{{ ui-key.yacloud.serverless-functions.item.editor.button_add-environment-variable }}**. Можно передать несколько секретов в функцию.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**. Будет создана новая версия функции с указанными секретами.

- CLI

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    Чтобы передать секрет {{ lockbox-name }} в функцию, выполните команду:

    {% note warning %}

    Если в прошлую версию функции уже были переданы секреты, они перезапишутся.

    {% endnote %}

    ```
    yc serverless function version create \
      --function-name=test \
      --runtime nodejs16 \
      --entrypoint index.main \
      --memory 128m \
      --execution-timeout 5s \
      --source-version-id vfdsdeqa1s2d3******** \
      --service-account-id bfbtfcp0o9i8******** \
      --secret environment-variable=KEY,id=fc3q4aq3w5e6********,version-id=fc3gvvz4x5c6********,key=key-id
    ```

    Где:

    * `--function-name` — имя функции.
    * `--runtime` — среда выполнения.
    * `--entrypoint` — точка входа, указывается в формате `<имя_файла_с_функцией>`.`<имя_обработчика>`.
    * `--memory` — объем RAM.
    * `--execution-timeout` — максимальное время выполнения функции до таймаута.
    * `--source-version-id` — идентификатор версии функции, код которой вы хотите скопировать.
    * `--service-account-id` — идентификатор сервисного аккаунта, у которого есть роль `{{ roles-lockbox-payloadviewer }}`.
    * `--secret`:
        * `environment-variable` — имя переменной окружения, в которой будет храниться секрет;
        * `id` — идентификатор секрета;
        * `version-id` — идентификатор версии секрета;
        * `key` — неконфиденциальный идентификатор ключа.

- {{ TF }}

    {% include [terraform-install](../../_includes/terraform-install.md) %}

    1. Откройте файл конфигурации {{ TF }} и добавьте к описанию функции блок `secrets`:

        ```hcl
        resource "yandex_function" "test-function" {
          name               = "test-function"
          description        = "Test function"
          user_hash          = "first-function"
          runtime            = "python37"
          entrypoint         = "main"
          memory             = "128"
          execution_timeout  = "10"
          service_account_id = "<идентификатор_сервисного_аккаунта>"
          tags               = ["my_tag"]
          secrets {
            id                   = "<идентификатор_секрета>"
            version_id           = "<идентификатор_версии_секрета>"
            key                  = "<ключ_секрета_1>"
            environment_variable = "<имя_переменной_окружения_1>"
          }
          secrets {
            id                   = "<идентификатор_секрета>"
            version_id           = "<идентификатор_версии_секрета>"
            key                  = "<ключ_секрета_2>"
            environment_variable = "<имя_переменной_окружения_2>"
          }
          
          content {
            zip_filename = "<путь_к_ZIP-архиву>"
          }
        }
        ```

        Где:

        * `secrets` — блок с настройками секрета. Содержит параметры:
          * `id` — идентификатор секрета. Обязательный параметр.
          * `version_id` — идентификатор версии секрета. Обязательный параметр.
          * `key` — неконфиденциальный идентификатор ключа, который будет храниться в переменной окружения. Обязательный параметр.
          * `environment_variable` — имя переменной окружения, в которой будет храниться секрет. Обязательный параметр.

    1. Примените изменения:

        {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

    Проверить изменение функции и ее настройки можно в [консоли управления]({{ link-console-main }}).

- API

    Чтобы передать секрет {{ lockbox-name }} в функцию, воспользуйтесь методом REST API [createVersion](../../functions/functions/api-ref/Function/createVersion.md) для ресурса [Function](../../functions/functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionsService/CreateVersion](../../functions/functions/api-ref/grpc/function_service.md#CreateVersion).

{% endlist %}