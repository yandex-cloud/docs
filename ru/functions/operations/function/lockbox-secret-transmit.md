# Передать секреты {{ lockbox-name }} в функцию

{% note info %}

{% include [preview-pp.md](../../../_includes/preview-pp.md) %}

{% endnote %}

[{{ lockbox-name }}](../../../lockbox/) — сервис для хранения секретов. Передать секрет {{ lockbox-name }} в функцию можно в [переменной окружения](../../concepts/runtime/environment-variables.md#env).

Чтобы функция получила доступ к секрету, в ее параметрах нужно указать сервисный аккаунт, у которого есть роль `lockbox.payloadViewer`. [Как создать сервисный аккаунт](../../../iam/operations/sa/create.md).

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

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

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

    Передать секрет {{ lockbox-name }} в функцию можно с помощью метода API [createVersion](../../functions/api-ref/Function/createVersion.md).

{% endlist %}
