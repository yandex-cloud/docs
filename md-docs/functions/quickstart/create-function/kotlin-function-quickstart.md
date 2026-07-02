[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Functions](../../index.md) > [Начало работы](../index.md) > [Создание функции](index.md) > Kotlin

# Создание функции на Kotlin

Создайте и выполните [функцию](../../concepts/function.md) на Kotlin, которая приветствует пользователя.

## Перед началом работы {#before-begin}

[Создайте каталог](../../../resource-manager/operations/folder/create.md) в Yandex Cloud.

## Создайте функцию {#create-func}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите создать функцию.
    1. Перейдите в сервис **Cloud Functions**.
    1. Нажмите кнопку **Создать функцию**.
    1. Введите имя функции — `kotlin-function`.
    1. Нажмите кнопку **Создать**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы создать функцию, выполните команду:

    ```bash
    yc serverless function create --name=kotlin-function
    ```

    Результат:

    ```text
    id: d4eek526ai42********
    folder_id: b1gt6g8ht345********
    created_at: "2024-12-19T20:02:56.039Z"
    name: kotlin-function
    http_invoke_url: https://functions.yandexcloud.net/d4eek526ai42********
    status: ACTIVE
    ```

- API {#api}

    Создать функцию можно с помощью метода API [create](../../functions/api-ref/Function/create.md).


{% endlist %}

## Создайте первую версию функции {#create-first-version}

Чтобы создать [версию](../../concepts/function.md#version) функции, вы можете воспользоваться одним из [форматов загрузки кода](../../concepts/function.md#upload). Для примера будет использован ZIP-архив.

{% note warning %}

Файл больше 3,5 МБ необходимо [загружать через Object Storage](../../../storage/operations/objects/upload.md). Подробнее об ограничениях читайте в разделе [Квоты и лимиты в Cloud Functions](../../concepts/limits.md).

{% endnote %}

### Подготовьте ZIP-архив с кодом функции {#create-zip}

1. Сохраните следующий код в файл с названием `Handler.kt`:

    ```kotlin
    data class Request(
        val httpMethod: String?,
        val headers: Map<String, String> = mapOf(),
        val body: String = ""
    )

    data class Response(
        val statusCode: Int,
        val body: String
    )

    fun handle(request: Request): Response {
        return Response(200, "Hello World!")
    }
    ```

1. Добавьте файл `Handler.kt` в ZIP-архив `hello-kotlin.zip`.

### Создайте версию функции {#create-version}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится функция.
    1. Перейдите в сервис **Cloud Functions**.
    1. Выберите функцию `kotlin-function`.
    1. В разделе **Последняя версия** нажмите кнопку **Создать в редакторе**.
    1. Выберите среду выполнения `Kotlin 2.0`.
    1. Отключите опцию **Добавить файлы с примерами кода** и нажмите кнопку **Продолжить**.
    1. Задайте параметры версии:
        * **Источник кода** — `ZIP-архив`.
        * **Файл** — прикрепите файл `hello-kotlin.zip`.
        * **Точка входа** — `Handler`.
        * **Таймаут** — `3`.
        * **Память** — `128 МБ`.
        * **Сервисный аккаунт** — `Не выбрано`.
    1. Нажмите кнопку **Сохранить изменения**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы создать версию функции, выполните команду:

    ```bash
    yc serverless function version create \
      --function-name=kotlin-function \
      --runtime kotlin20 \
      --entrypoint Handler \
      --memory 128m \
      --execution-timeout 3s \
      --source-path ./hello-kotlin.zip
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
    done (10s)
    id: d4ektme8jo2d********
    function_id: d4e9arrf01oh********
    created_at: "2024-12-19T20:22:15.942Z"
    runtime: kotlin20
    entrypoint: Handler
    resources:
      memory: "134217728"
    execution_timeout: 3s
    image_size: "4096"
    status: ACTIVE
    tags:
      - $latest
    log_options:
      folder_id: b1gt6g8ht345********
    concurrency: "1"
    ```

- API {#api}

    Создать версию функции можно с помощью метода API [createVersion](../../functions/api-ref/Function/createVersion.md).


{% endlist %}

## Вызовите функцию {#invoke}

{% note info %}

Чтобы любой пользователь мог вызывать функцию, необходимо [сделать ее публичной](../../operations/function/function-public.md). Подробнее о правах читайте в разделе [Управление доступом в Cloud Functions](../../security/index.md).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится функция.
    1. Перейдите в сервис **Cloud Functions**.
    1. Выберите функцию.
    1. Перейдите на вкладку ![CirclePlay](../../../_assets/console-icons/circle-play.svg) **Тестирование**.
    1. В поле **Тег версии** выберите `$latest`, чтобы вызвать последнюю версию функции.
    1. В поле **Шаблон данных** выберите `Без шаблона`.
    1. В поле **Входные данные** введите:

       ```
       {}
       ```
    1. Нажмите кнопку ![PlayFill](../../../_assets/console-icons/play-fill.svg) **Запустить тест**.
    1. В разделе **Результат тестирования**, в поле **Состояние функции**, будет показан статус тестирования. **Важно**: максимальное время выполнения функции до [таймаута](../../operations/function/version-manage.md) (включая начальную инициализацию при первом запуске) — 10 минут.
    1. В поле **Ответ функции** появится результат выполнения функции:

       ```
       {
           "statusCode": 200,
           "body": "Hello World!"
       }
       ```

- CLI {#cli}

    Чтобы вызвать функцию, выполните команду:

    ```
    yc serverless function invoke <идентификатор_функции> -d '{}'
    ```

    Результат:

    ```
    {"statusCode":200,"body":"Hello World!"}
    ```

    По умолчанию вызывается версия функции с тегом `$latest`.

- HTTPS {#https}

    Ссылку для вызова функции можно найти на вкладке **Обзор**, в поле **Ссылка для вызова**.

    Для обеспечения безопасности функцию можно вызвать только по протоколу HTTPS. Вызовите ее как обычный HTTPS-запрос, вставив ссылку в адресную строку браузера и добавив в URL параметр `name`:

    ```
    https://functions.yandexcloud.net/<идентификатор_функции>
    ```

    На странице появится ответ:

    ```
    Hello World!
    ```


{% endlist %}

## Что дальше {#what-is-next}

- Прочитайте, какой должна быть структура функции для вызова разными способами (HTTP, CLI), в разделе [Вызов функции в Cloud Functions](../../concepts/function-invoke.md).
- Ознакомьтесь с [концепциями сервиса](../../concepts/index.md).
- Посмотрите, что можно делать с функциями и версиями в [пошаговых инструкциях](../../operations/index.md).