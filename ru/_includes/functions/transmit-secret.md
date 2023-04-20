Чтобы функция получила доступ к [секрету](../../lockbox/concepts/secret.md), в ее параметрах нужно указать [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), у которого есть роли:
* `lockbox.payloadViewer` на секрет ([как назначить права доступа на секрет](../../lockbox/operations/secret-access.md));
* `kms.keys.encrypterDecrypter` на ключ шифрования, если секрет создан с использованием ключа {{ kms-full-name }} ([как назначить права доступа на ключ шифрования](../../kms/operations/key-access.md)).

При передаче секретов создается новая версия функции. В существующую версию секреты передать нельзя.

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Откройте сервис **{{ sf-name }}**.
    1. Выберите функцию, в которую хотите передать секрет {{ lockbox-name }}.
    1. Перейдите на вкладку **Редактор**.
    1. В блоке **Параметры** укажите:
        * в поле **Сервисный аккаунт** — сервисный аккаунт, у которого есть роль `lockbox.payloadViewer`;
        * в поле **Секрет {{ lockbox-name }}**:
            * имя переменной окружения, в которой будет храниться секрет;
            * идентификатор секрета;
            * идентификатор версии секрета;
            * неконфиденциальный идентификатор ключа.
    1. Нажмите **Добавить**. Можно передать несколько секретов в функцию.
    1. Нажмите кнопку **Создать версию**. Будет создана новая версия функции с указанными секретами.

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
      --source-version-id vfdsde*************** \
      --service-account-id bfbtfc************** \
      --secret environment-variable=KEY,id=fc3q4a**************,version-id=fc3gvv**************,key=key-id
    ```

    Где:

    * `--function-name` — имя функции.
    * `--runtime` — среда выполнения.
    * `--entrypoint` — точка входа, указывается в формате <имя файла с функцией>.<имя обработчика>.
    * `--memory` — объем RAM.
    * `--execution-timeout` — максимальное время выполнения функции до таймаута.
    * `--source-version-id` — идентификатор версии функции, код которой вы хотите скопировать.
    * `--service-account-id` — идентификатор сервисного аккаунта, у которого есть роль `lockbox.payloadViewer`.
    * `--secret`:
        * `environment-variable` — имя переменной окружения, в которой будет храниться секрет;
        * `id` — идентификатор секрета;
        * `version-id` — идентификатор версии секрета;
        * `key` — неконфиденциальный идентификатор ключа.

- API

    Чтобы передать секрет {{ lockbox-name }} в функцию, воспользуйтесь методом REST API [createVersion](../../functions/functions/api-ref/Function/createVersion.md) для ресурса [Function](../../functions/functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionsService/CreateVersion](../../functions/functions/api-ref/grpc/function_service.md#CreateVersion).

{% endlist %}