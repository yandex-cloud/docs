# Передать секреты Yandex Lockbox в контейнер

{% note info %}

{% include [preview-pp.md](../../_includes/preview-pp.md) %}

{% endnote %}

[{{ lockbox-name }}](../../lockbox/) — сервис для хранения секретов. Передать секрет {{ lockbox-name }} в контейнер можно в [переменной окружения](../concepts/runtime.md#environment-variables).

Чтобы контейнер получил доступ к секрету, в настройках контейнера нужно указать сервисный аккаунт, у которого есть роль `lockbox.payloadViewer`. [Как создать сервисный аккаунт](../../iam/operations/sa/create.md).

При передаче секретов {{ lockbox-name }} создается новая ревизия контейнера. В существующую ревизию секреты передать нельзя.

{% list tabs %}

- Консоль управления
    
    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
    1. Откройте сервис **{{ serverless-containers-name }}**.
    1. Выберите контейнер, в который хотите передать секрет.
    1. Перейдите на вкладку **Редактор**.
    1. В открывшемся окне, в блоке **Параметры образа**, в поле **Секрет {{ lockbox-name }}**, укажите:
        * имя переменной окружения, в которой будет храниться секрет;
        * идентификатор секрета;
        * идентификатор версии секрета;
        * неконфиденциальный идентификатор ключа.
    1. Нажмите **Добавить**. Можно передать несколько секретов в контейнер.
    1. Нажмите кнопку **Создать ревизию**. Будет создана новая ревизия контейнера с указанными секретами.
    
- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы передать секреты {{ lockbox-name }} в контейнер, выполните команду:

    {% note warning %}

    Если в прошлую ревизию уже были переданы секреты, они перезапишутся.

    {% endnote %}

    ```
    yc serverless container revision deploy \
       --container-name test \
       --image {{ registry }}/crpp35**************/repository:tag \
       --cores 1 \
       --memory 1GB \
       --service-account-id bfbtfc************** \
       --secret environment-variable=KEY,id=fc3q4a**************,version-id=fc3gvv**************,key=key-id
    ```

    Где:

    * `--container-name` — имя контейнера.
    * `--image` — URL Docker-образа.
    * `--cores` — количество ядер, которые доступны контейнеру.
    * `--memory` — требуемая память. По умолчанию — 128 МБ.
    * `--service-account-id` — идентификатор сервисного аккаунта, у которого есть роль `lockbox.payloadViewer`.
    * `--secret`:
        * `environment-variable` — имя переменной окружения, в которой будет храниться секрет;
        * `id` — идентификатор секрета;
        * `version-id` — идентификатор версии секрета;
        * `key` — неконфиденциальный идентификатор ключа.

- API

  Передать секрет {{ lockbox-name }} в контейнер можно с помощью метода API [deployRevision](../containers/api-ref/Container/deployRevision.md).

{% endlist %}