# Передать секреты {{ lockbox-name }} в функцию

{% note info %}

Эта функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}

[{{ lockbox-name }}](../../../lockbox/index.md) — сервис для хранения секретов. Передать секрет {{ lockbox-name }} в функцию можно в [переменной окружения](../../concepts/runtime/environment-variables.md#env).

Чтобы [функция](../../concepts/function.md) получила доступ к [секрету](../../../lockbox/concepts/secret.md), в ее параметрах нужно указать [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md), у которого есть [роли](../../../iam/concepts/access-control/roles.md):
* `{{ roles-lockbox-payloadviewer }}` на секрет ([как назначить права доступа к секрету](../../../lockbox/operations/secret-access.md)).
* `kms.keys.encrypterDecrypter` на [ключ](../../../kms/concepts/key.md) шифрования, если секрет создан с использованием ключа [{{ kms-full-name }}](../../../kms/index.md) ([как назначить права доступа к ключу шифрования](../../../kms/operations/key-access.md)).

Секрет [{{ lockbox-full-name }}](../../../lockbox/index.md), который передается в функцию, кешируется в [{{ sf-full-name }}](../../index.md). После того как сервисный аккаунт потеряет доступ к секрету, функция может хранить его до 5 минут.

При передаче секретов создается новая версия функции. В существующую версию секреты передать нельзя.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится функция.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Выберите функцию, в которую хотите передать секрет {{ lockbox-name }}.
  1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}**.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}** укажите:
     * В поле **{{ ui-key.yacloud.forms.label_service-account-select }}** — сервисный аккаунт, у которого есть роль `{{ roles-lockbox-payloadviewer }}`.
     * В поле **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret }}**:
       * Имя переменной окружения, в которой будет храниться секрет.
       * Идентификатор секрета.
       * Идентификатор версии секрета.
       * Ключ одной из пар ключ-значение в версии секрета.
  1. Нажмите **{{ ui-key.yacloud.serverless-functions.item.editor.button_add-environment-variable }}**.

     В функцию можно передать несколько секретов. Для этого еще раз нажмите **{{ ui-key.yacloud.serverless-functions.item.editor.button_add-environment-variable }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**. Будет создана новая версия функции с указанными секретами.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы передать секрет {{ lockbox-name }} в функцию, выполните команду:

  {% note warning %}

  Если в прошлую версию функции уже были переданы секреты, они перезапишутся.

  {% endnote %}

  ```bash
  yc serverless function version create \
    --function-name=test \
    --runtime nodejs16 \
    --entrypoint index.main \
    --memory 128m \
    --execution-timeout 5s \
    --source-version-id vfdsdeqa1s2d3******** \
    --service-account-id bfbtfcp0o9i8******** \
    --secret environment-variable=KEY,id=fc3q4aq3w5e6********,version-id=fc3gvvz4x5c6********,key=secret-key
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
    * `environment-variable` — имя переменной окружения, в которой будет храниться секрет.
    * `id` — идентификатор секрета.
    * `version-id` — идентификатор версии секрета.
    * `key` — ключ одной из пар ключ-значение в версии секрета.

    В функцию можно передать несколько секретов. Для этого укажите параметр `--secret` необходимое количество раз.

- {{ TF }} {#tf}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

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
       * `key` — ключ одной из пар ключ-значение в версии секрета, который будет храниться в переменной окружения. Обязательный параметр.
       * `environment_variable` — имя переменной окружения, в которой будет храниться секрет. Обязательный параметр.
  
     Более подробную информацию о параметрах ресурса `yandex_function` см. в [документации провайдера]({{ tf-provider-resources-link }}/function).

  1. Примените изменения:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```
     
     1. Выполните команду:
     
        ```bash
        terraform plan
        ```
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

  Проверить изменение функции и ее настройки можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Чтобы передать секрет {{ lockbox-name }} в функцию, воспользуйтесь методом REST API [createVersion](../../functions/api-ref/Function/createVersion.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionsService/CreateVersion](../../functions/api-ref/grpc/Function/createVersion.md).

{% endlist %}