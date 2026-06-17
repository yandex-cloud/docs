# Передать секрет в Yandex Cloud Functions


{% note info %}

Эта функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}



Чтобы [функция](../../../functions/concepts/function.md) получила доступ к [секрету](../../concepts/secret.md), в ее параметрах нужно указать [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md), у которого есть [роли](../../../iam/concepts/access-control/roles.md):
* `lockbox.payloadViewer` на секрет ([как назначить права доступа к секрету](../secret-access.md)).
* `kms.keys.encrypterDecrypter` на [ключ](../../../kms/concepts/key.md) шифрования, если секрет создан с использованием ключа [Yandex Key Management Service](../../../kms/index.md) ([как назначить права доступа к ключу шифрования](../../../kms/operations/key-access.md)).

Секрет [Yandex Lockbox](../../index.md), который передается в функцию, кешируется в [Yandex Cloud Functions](../../../functions/index.md). После того как сервисный аккаунт потеряет доступ к секрету, функция может хранить его до 5 минут.

При передаче секретов создается новая версия функции. В существующую версию секреты передать нельзя.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится функция.
  1. Перейдите в сервис **Cloud Functions**.
  1. Выберите функцию, в которую хотите передать секрет Yandex Lockbox.
  1. Перейдите на вкладку **Редактор**.
  1. В блоке **Параметры** укажите:
     * В поле **Сервисный аккаунт** — сервисный аккаунт, у которого есть роль `lockbox.payloadViewer`.
     * В поле **Секреты Lockbox**:
       * Имя переменной окружения, в которой будет храниться секрет.
       * Идентификатор секрета.
       * Идентификатор версии секрета.
       * Ключ одной из пар ключ-значение в версии секрета.
  1. Нажмите **Добавить**.

     В функцию можно передать несколько секретов. Для этого еще раз нажмите **Добавить**.
  1. Нажмите кнопку **Сохранить изменения**. Будет создана новая версия функции с указанными секретами.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы передать секрет Yandex Lockbox в функцию, выполните команду:

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
  * `--service-account-id` — идентификатор сервисного аккаунта, у которого есть роль `lockbox.payloadViewer`.
  * `--secret`:
    * `environment-variable` — имя переменной окружения, в которой будет храниться секрет.
    * `id` — идентификатор секрета.
    * `version-id` — идентификатор версии секрета.
    * `key` — ключ одной из пар ключ-значение в версии секрета.

    В функцию можно передать несколько секретов. Для этого укажите параметр `--secret` необходимое количество раз.

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Откройте файл конфигурации Terraform и добавьте к описанию функции блок `secrets`:

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
  
     Подробнее о параметрах ресурса `yandex_function` в [документации провайдера](../../../terraform/resources/function.md).

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
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

  Проверить изменение функции и ее настройки можно в [консоли управления](https://console.yandex.cloud).

- API {#api}

  Чтобы передать секрет Yandex Lockbox в функцию, воспользуйтесь методом REST API [createVersion](../../../functions/functions/api-ref/Function/createVersion.md) для ресурса [Function](../../../functions/functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionsService/CreateVersion](../../../functions/functions/api-ref/grpc/Function/createVersion.md).

{% endlist %}