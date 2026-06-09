# Создание функции на PHP

Создайте и выполните [функцию](../../concepts/function.md) на PHP, которая приветствует пользователя.

## Перед началом работы {#before-begin}

[Создайте каталог](../../../resource-manager/operations/folder/create.md) в {{ yandex-cloud }}.

## Создайте функцию {#create-func}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать функцию.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
    1. Введите имя функции — `php-function`.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы создать функцию, выполните команду:

    ```bash
    yc serverless function create --name=php-function
    ```

    Результат:

    ```text
    id: b09bhaokchn9********
    folder_id: aoek49ghmknn********
    created_at: "2019-06-14T10:03:37.475Z"
    name: php-function
    log_group_id: eolm8aoq9vcp********
    http_invoke_url: https://{{ sf-url }}/b09bhaokchn9********
    status: ACTIVE
    ```

- API {#api}

    Создать функцию можно с помощью метода API [create](../../functions/api-ref/Function/create.md).


{% endlist %}

## Создайте первую версию функции {#create-first-version}

Чтобы создать [версию](../../concepts/function.md#version) функции, вы можете воспользоваться одним из [форматов загрузки кода](../../concepts/function.md#upload). Для примера будет использован ZIP-архив.

{% note warning %}

Файл больше 3,5 МБ необходимо [загружать через {{ objstorage-short-name }}](../../../storage/operations/objects/upload.md). Подробнее об ограничениях читайте в разделе [{#T}](../../concepts/limits.md).

{% endnote %}

### Подготовьте ZIP-архив с кодом функции {#create-zip}

1. Сохраните следующий код в файл с названием `hello.php`:
    ```php
    <?php

    function handler () {
        $resp =  'Hello, World!';
        return [
            'statusCode' => 200,
            'body' => json_encode($resp),
        ];
    }

    ?>
    ```

1. Добавьте файл `hello.php` в ZIP-архив `hello-php.zip`.

### Создайте версию функции {#create-version}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Выберите функцию `php-function`.
    1. В разделе **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-latest-version }}** нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.overview.button_editor-create }}**.
    1. Выберите среду выполнения `{{ php-full-ver }}`.
    1. Отключите опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** и нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
    1. Задайте параметры версии:
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_code-source }}** — `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_file }}** — прикрепите файл `hello-php.zip`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** — `hello.handler`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** — `3`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}** — `128 {{ ui-key.yacloud.common.units.label_megabyte }}`.
        * **{{ ui-key.yacloud.forms.label_service-account-select }}** — `{{ ui-key.yacloud.component.service-account-select.label_no-service-account }}`.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы создать версию функции, выполните команду:

    ```bash
    yc serverless function version create \
      --function-name=php-function \
      --runtime {{ php-cli-ver }} \
      --entrypoint hello.handler \
      --memory 128m \
      --execution-timeout 3s \
      --source-path ./hello-php.zip
    ```

    Где:

    * `--function-name` — имя функции, версию которой вы хотите создать.
    * `--runtime` — среда выполнения.
    * `--entrypoint` — точка входа, указывается в формате `<имя_файла_с_функцией>.<имя_обработчика>`.
    * `--memory` — объем RAM.
    * `--execution-timeout` — максимальное время выполнения функции до таймаута.
    * `--source-path` — ZIP-архив c кодом функции и необходимыми зависимостями.

    Результат:

    ```text
    done (1s)
    id: d4evvn8obisa********
    function_id: d4elpv8pft63********
    created_at: "2020-08-01T19:09:19.531Z"
    runtime: {{ php-cli-ver }}
    entrypoint: hello.handler
    resources:
        memory: "134217728"
    execution_timeout: 3s
    image_size: "4096"
    status: ACTIVE
    tags:
    - $latest
    log_group_id: ckg3qh8h363p********
    ```

- API {#api}

    Создать версию функции можно с помощью метода API [createVersion](../../functions/api-ref/Function/createVersion.md).


{% endlist %}

## Вызовите функцию {#invoke}

{% note info %}

Чтобы любой пользователь мог вызывать функцию, необходимо [сделать ее публичной](../../operations/function/function-public.md). Подробнее о правах читайте в разделе [{#T}](../../security/index.md).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Выберите функцию.
    1. Перейдите на вкладку ![CirclePlay](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}**.
    1. В поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_tag }}** выберите `$latest`, чтобы вызвать последнюю версию функции.
    1. В поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_payload-template }}** выберите `{{ ui-key.yacloud.serverless-functions.item.testing.value_empty }}`.
    1. Нажмите кнопку ![PlayFill](../../../_assets/console-icons/play-fill.svg) **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}**.
    1. В разделе **{{ ui-key.yacloud.serverless-functions.item.testing.label_title-test-result }}**, в поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_execution-result }}**, будет показан статус тестирования. **Важно**: максимальное время выполнения функции до [таймаута](../../operations/function/version-manage.md) (включая начальную инициализацию при первом запуске) — 10 минут.
    1. В поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_function-output }}** появится результат выполнения функции.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы вызвать функцию, выполните команду:

    ```
    yc serverless function invoke <идентификатор_функции>
    ```

    По умолчанию вызывается версия функции с тегом `$latest`.


- HTTPS {#https}

	Ссылку для вызова функции можно найти на вкладке **{{ ui-key.yacloud.common.overview }}**, в поле **{{ ui-key.yacloud.serverless-functions.item.overview.label_invoke-link }}**.

	Для обеспечения безопасности функцию можно вызвать только по протоколу HTTPS. Вызовите ее как обычный HTTPS-запрос, вставив ссылку в адресную строку браузера:

	```
	https://{{ sf-url }}/<идентификатор_функции>
	```

	На странице появится ответ:

	```
	Hello, World!
	```


{% endlist %}

## Что дальше {#what-is-next}

- Прочитайте, какой должна быть структура функции для вызова разными способами (HTTP, CLI), в разделе [{#T}](../../concepts/function-invoke.md).
- Ознакомьтесь с [концепциями сервиса](../../concepts/index.md).
- Посмотрите, что можно делать с функциями и версиями в [пошаговых инструкциях](../../operations/index.md).