# Управление ревизиями контейнера

Вы можете [создать](#create) ревизию, получить [информацию](#get) о ней или [список ревизий](#list) контейнера, а также [добавить переменные окружения](#revision-env), [передать в контейнер секрет](#lockbox) {{ lockbox-name }} и [указать облачную сеть](#networking), в которой будет исполняться контейнер.

{% include [manage-revision-note](../../_includes/serverless-containers/manage-revision-note.md) %}

Для управления ревизиями контейнера нужны имя или уникальный идентификатор контейнера, которому эта ревизия принадлежит. Чтобы узнать их, [получите список контейнеров](./list.md).

{% include [create-revision-note](../../_includes/serverless-containers/create-revision-note.md) %}

## Создать ревизию {#create}

{% include [create-revision](../../_includes/serverless-containers/create-revision.md) %}

## Получить список ревизий {#list}

{% include [revision-list](../../_includes/serverless-containers/revision-list.md) %}

## Получить информацию о ревизии {#get}

{% include [revision-get](../../_includes/serverless-containers/revision-get.md) %}

## Добавить переменную окружения {#revision-env}

При добавлении переменных окружения создается новая ревизия контейнера. В существующую ревизию переменные окружения добавить нельзя.

{% list tabs %}

- Консоль управления
    
    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
    1. Выберите сервис **{{ serverless-containers-name }}**.
    1. Выберите контейнер, для ревизии которого хотите добавить переменную окружения.
    1. Перейдите на вкладку **Редактор**.
    1. В открывшемся окне, в блоке **Параметры образа**, укажите переменную окружения и нажмите **Добавить**. Можно добавить несколько переменных окружения.
    1. Нажмите кнопку **Создать ревизию**. Будет создана новая ревизия контейнера с указанными переменными окружения.
    
- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы добавить переменные окружения, выполните команду:

    {% note warning %}

    Если в прошлой ревизии уже были переменные окружения, они перезапишутся.

    {% endnote %}

    ```
    yc serverless container revision deploy \
      --container-name <имя_контейнера> \
      --image <URL_Docker-образа> \
      --cores 1 \
      --memory 1GB \
      --service-account-id <идентификатор_сервисного_аккаунта> \
      --environment <переменные_окружения>
    ```

    Где:

    * `--cores` — количество ядер, которые доступны контейнеру.
    * `--memory` — требуемая память. По умолчанию — 128 МБ.
    * `--environment` — переменные окружения в формате `key=value`. Можно указать несколько пар через запятую.

- API

  Добавить переменную окружения в ревизию контейнера можно с помощью метода API [deployRevision](../containers/api-ref/Container/deployRevision.md).

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы добавить переменные окружения:

  1. Откройте файл конфигурации {{ TF }} и для ресурса `yandex_serverless_container` в блок `image` добавьте список `environment` с переменными окружения:

     ```hcl
     ...
     resource "yandex_serverless_container" "test-container" {
       name               = "my-container"
       memory             = 256
       service_account_id = "ajec........34ova"
       image {
           url = "cr.yandex/yc/test-image:v1"
           environment = {
               <ключ> = "<значение>"
           }
       }
     }
     ...
     ```

     Где `--environment` — переменные окружения в формате `key="value"`. Можно указать несколько пар.

	 Более подробную информацию о параметрах ресурса `yandex_serverless_container` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/serverless_container).

  1. Проверьте конфигурацию командой:
     ```
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:
     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:
     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

  Проверить создание переменных окружения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

  ```
  yc serverless container revision get <идентификатор_ревизии>
  ```

{% endlist %}

## Указать облачную сеть {#networking}

{% include [note-preview](../../_includes/note-preview.md) %}

Вы можете указать [облачную сеть](../../vpc/concepts/network.md#network), в которой будет исполняться контейнер.

{% include [network](../../_includes/functions/network.md) %}

Подробнее о [сетевом взаимодействии](../concepts/networking.md) в {{ serverless-containers-name }}.

{% list tabs %}

- Консоль управления
    
    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
    1. Выберите сервис **{{ serverless-containers-name }}**.
    1. Выберите контейнер.
    1. Перейдите на вкладку **Редактор**.
    1. В блоке **Настройки**, в поле **Сеть**, укажите облачную сеть, в которой будет исполняться контейнер.
    1. Нажмите кнопку **Создать ревизию**.

- API

  Указать облачную сеть, в которой будет исполняться контейнер, можно с помощью метода API [deployRevision](../containers/api-ref/Container/deployRevision.md).

{% endlist %}

## Передать секрет {{ lockbox-name }} {#lockbox}

{% include [note-preview-pp](../../_includes/note-preview-pp.md) %}

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
       --image cr.yandex/crpp35**************/repository:tag \
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
