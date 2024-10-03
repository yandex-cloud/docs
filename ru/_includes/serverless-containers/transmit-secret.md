Чтобы контейнер получил доступ к [секрету](../../lockbox/concepts/secret.md), в настройках контейнера нужно указать [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), у которого есть роли:
* `lockbox.payloadViewer` на секрет ([как назначить права доступа к секрету](../../lockbox/operations/secret-access.md));
* `kms.keys.encrypterDecrypter` на ключ шифрования, если секрет создан с использованием ключа {{ kms-full-name }} ([как назначить права доступа к ключу шифрования](../../kms/operations/key-access.md)).

Секрет {{ lockbox-short-name }}, который передается в контейнер, кешируется в {{ serverless-containers-name }}. После того как сервисный аккаунт потеряет доступ к секрету, контейнер может хранить его до 5 минут.

При передаче секретов {{ lockbox-name }} создается новая ревизия контейнера. В существующую ревизию секреты передать нельзя.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
    1. Откройте сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
    1. Выберите контейнер, в который хотите передать секрет.
    1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-containers.label_editor }}**.
    1. В открывшемся окне, в блоке **{{ ui-key.yacloud.serverless-containers.section_image }}**, в поле **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret }}**, укажите:
        * имя переменной окружения, в которой будет храниться секрет;
        * идентификатор секрета;
        * идентификатор версии секрета;
        * ключ одной из пар ключ-значение в версии секрета.
    1. Нажмите **{{ ui-key.yacloud.serverless-functions.item.editor.button_add-environment-variable }}**.

        В контейнер можно передать несколько секретов. Для этого еще раз нажмите **{{ ui-key.yacloud.serverless-functions.item.editor.button_add-environment-variable }}**.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**. Будет создана новая ревизия контейнера с указанными секретами.
    
- CLI {#cli}

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    Чтобы передать секреты {{ lockbox-name }} в контейнер, выполните команду:

    {% note warning %}

    Если в прошлую ревизию уже были переданы секреты, они перезапишутся.

    {% endnote %}

    ```bash
    yc serverless container revision deploy \
       --container-name test \
       --image {{ registry }}/<идентификатор_реестра>/repository:tag \
       --cores 1 \
       --memory 1GB \
       --service-account-id <идентификатор_сервисного_аккаунта> \
       --secret environment-variable=<имя_переменной_окружения>,id=<идентификатор_секрета>,version-id=<идентификатор_версии_секрета>,key=<ключ_секрета>
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
        * `key` — ключ одной из пар ключ-значение в версии секрета.
      
      В контейнер можно передать несколько секретов. Для этого укажите параметр `--secret` необходимое количество раз.

- {{ TF }} {#tf}

    {% include [terraform-install](../../_includes/terraform-install.md) %}

    1. Откройте файл конфигурации {{ TF }} и добавьте к описанию функции блок `secrets`:

        ```hcl
        resource "yandex_serverless_container" "test-container" {
          name               = "<имя_контейнера>"
          memory             = <объем_памяти>
          service_account_id = "<идентификатор_сервисного_аккаунта>"
          secrets {
            id                   = "<идентификатор_секрета>"
            version_id           = "идентификатор_версии_секрета>"
            key                  = "<ключ_секрета_1>"
            environment_variable = "<имя_переменной_окружения_1>"
          }
          secrets {
            id                   = "<идентификатор_секрета>"
            version_id           = "<идентификатор_версии_секрета>"
            key                  = "<ключ_секрета_2>"
            environment_variable = "<имя_переменной_окружения_2>"
          }
          image {
            url = "<URL_Docker-образа>"
          }
        }
        ```

        Где:
          * `secrets` — блок с настройками секрета. Содержит параметры:
            * `id` — идентификатор секрета. Обязательный параметр.
            * `version_id` — идентификатор версии секрета. Обязательный параметр.
            * `key` — ключ одной из пар ключ-значение в версии секрета, который будет храниться в переменной окружения. Обязательный параметр.
            * `environment_variable` — имя переменной окружения, в которой будет храниться секрет. Обязательный параметр.
        
        Более подробную информацию о параметрах ресурса `yandex_serverless_container` см. в [документации провайдера]({{ tf-provider-resources-link }}/serverless_container).
 
    1. Примените изменения:

        {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

    Проверить изменение функции и ее настройки можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Чтобы передать секрет {{ lockbox-name }} в контейнер, воспользуйтесь методом REST API [deployRevision](../../serverless-containers/containers/api-ref/Container/deployRevision.md) для ресурса [Container](../../serverless-containers/containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/DeployRevision](../../serverless-containers/containers/api-ref/grpc/container_service.md#deployRevision).

{% endlist %}