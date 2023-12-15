Чтобы контейнер получил доступ к [секрету](../../lockbox/concepts/secret.md), в настройках контейнера нужно указать [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), у которого есть роли:
* `lockbox.payloadViewer` на секрет ([как назначить права доступа на секрет](../../lockbox/operations/secret-access.md));
* `kms.keys.encrypterDecrypter` на ключ шифрования, если секрет создан с использованием ключа {{ kms-full-name }} ([как назначить права доступа на ключ шифрования](../../kms/operations/key-access.md)).

Секрет {{ lockbox-short-name }}, который передается в контейнер, кешируется в {{ serverless-containers-name }}. После того как сервисный аккаунт потеряет доступ к секрету, контейнер может хранить его до 5 минут.

При передаче секретов {{ lockbox-name }} создается новая ревизия контейнера. В существующую ревизию секреты передать нельзя.

{% list tabs %}

- Консоль управления
    
    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
    1. Откройте сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
    1. Выберите контейнер, в который хотите передать секрет.
    1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-containers.label_editor }}**.
    1. В открывшемся окне, в блоке **{{ ui-key.yacloud.serverless-containers.section_image }}**, в поле **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret }}**, укажите:
        * имя переменной окружения, в которой будет храниться секрет;
        * идентификатор секрета;
        * идентификатор версии секрета;
        * неконфиденциальный идентификатор ключа.
    1. Нажмите **{{ ui-key.yacloud.serverless-functions.item.editor.button_add-environment-variable }}**. Можно передать несколько секретов в контейнер.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**. Будет создана новая ревизия контейнера с указанными секретами.
    
- CLI

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    Чтобы передать секреты {{ lockbox-name }} в контейнер, выполните команду:

    {% note warning %}

    Если в прошлую ревизию уже были переданы секреты, они перезапишутся.

    {% endnote %}

    ```
    yc serverless container revision deploy \
       --container-name test \
       --image {{ registry }}/crpp35a1s2d3********/repository:tag \
       --cores 1 \
       --memory 1GB \
       --service-account-id bfbtfcp0o9i8******** \
       --secret environment-variable=KEY,id=fc3q4aq3w5e6********,version-id=fc3gvvz4x5c6********,key=key-id
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

  Чтобы передать секрет {{ lockbox-name }} в контейнер, воспользуйтесь методом REST API [deployRevision](../../serverless-containers/containers/api-ref/Container/deployRevision.md) для ресурса [Container](../../serverless-containers/containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/DeployRevision](../../serverless-containers/containers/api-ref/grpc/container_service.md#deployRevision).

{% endlist %}