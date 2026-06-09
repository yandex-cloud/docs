# Создание функции на .NET Core

Создайте и выполните [функцию](../../concepts/function.md) на .NET Core, которая приветствует пользователя.

## Перед началом работы {#before-begin}

[Создайте каталог](../../../resource-manager/operations/folder/create.md) в Yandex Cloud.

## Создайте функцию {#create-func}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите создать функцию.
    1. Перейдите в сервис **Cloud Functions**.
    1. Нажмите кнопку **Создать функцию**.
    1. Введите имя функции — `dotnet-function`.
    1. Нажмите кнопку **Создать**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы создать функцию, выполните команду:

    ```bash
    yc serverless function create --name=dotnet-function
    ```

    Результат:

    ```text
    id: b09bhaokchn9********
    folder_id: aoek49ghmknn********
    created_at: "2019-06-14T10:03:37.475Z"
    name: dotnet-function
    log_group_id: eolm8aoq9vcp********
    http_invoke_url: https://functions.yandexcloud.net/b09bhaokchn9********
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

1. Сохраните следующий код в файл с названием `Handler.cs`:

    ```csharp
    using System;
    using System.Collections.Generic;

    namespace Function;

    public class Request
    {
        public Dictionary<string, string> queryStringParameters { get; set; }
    }

    public class Response
    {
        public Response(int statusCode, Dictionary<string, string> headers, bool isBase64Encoded, string body)
        {
            StatusCode = statusCode;
            Headers = headers;
            IsBase64Encoded = isBase64Encoded;
            Body = body;
        }

        public int StatusCode { get; set; }
        public Dictionary<string, string> Headers { get; set; }
        public bool IsBase64Encoded { get; set; }
        public string Body { get; set; }
    }

    public class Handler
    {
        public Response FunctionHandler(Request request)
        {
            var headers = new Dictionary<string, string>();
            headers.Add("Content-Type", "text/plain");

            string name = request.queryStringParameters["name"];
            return new Response(200, headers, false, string.Format("Hello, {0}!", name));
        }
    }
    ```

1. Добавьте файл `Handler.cs` в ZIP-архив `hello-dotnet.zip`.

    {% note info %}
    
    При создании ZIP-архива на macOS с помощью контекстного меню Finder в архив автоматически добавляется служебная папка `__MACOSX`, которая может вызвать ошибки при сборке функций. Чтобы удалить папку из ZIP-архива, в командной строке перейдите в каталог, в котором расположен архив, и выполните команду:
    
    ```bash
    zip -d <имя_архива>.zip "__MACOSX/*"
    ```
    
    {% endnote %}

### Создайте версию функции {#create-version}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится функция.
    1. Перейдите в сервис **Cloud Functions**.
    1. Выберите функцию `dotnet-function`.
    1. В разделе **Последняя версия** нажмите кнопку **Создать в редакторе**.
    1. Выберите среду выполнения `.NET 8.0`.
    1. Отключите опцию **Добавить файлы с примерами кода** и нажмите кнопку **Продолжить**.
    1. Задайте параметры версии:
        * **Источник кода** — `ZIP-архив`.
        * **Файл** — прикрепите файл `hello-dotnet.zip`.
        * **Точка входа** — `Function.Handler`.
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
      --function-name=dotnet-function \
      --runtime dotnet8.0 \
      --entrypoint Function.Handler \
      --memory 128m \
      --execution-timeout 3s \
      --source-path ./hello-dotnet.zip
    ```

    Где:

    * `--function-name` — имя функции, версию которой вы хотите создать.
    * `--runtime` — среда выполнения.
    * `--entrypoint` — точка входа.
    * `--memory` — объем RAM.
    * `--execution-timeout` — максимальное время выполнения функции до таймаута.
    * `--source-path` — ZIP-архив с кодом функции и необходимыми зависимостями.

    Результат:

    ```text
    done (1s)
    id: d4evvn8obisa********
    function_id: d4elpv8pft63********
    created_at: "2020-08-01T19:09:19.531Z"
    runtime: dotnet8.0
    entrypoint: Function.Handler
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
       {"queryStringParameters": {"name": "Username"}}
       ```
    1. Нажмите кнопку ![PlayFill](../../../_assets/console-icons/play-fill.svg) **Запустить тест**.
    1. В разделе **Результат тестирования**, в поле **Состояние функции**, будет показан статус тестирования. **Важно**: максимальное время выполнения функции до [таймаута](../../operations/function/version-manage.md) (включая начальную инициализацию при первом запуске) — 10 минут.
    1. В поле **Ответ функции** появится результат выполнения функции:
       ```
       {
         "statusCode": 200,
         "headers": {
           "Content-Type": "text/plain"
         },
         "isBase64Encoded": false,
         "body": "Hello, Username!"
       }
       ```

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы вызвать функцию, выполните команду:

    ```
    yc serverless function invoke <идентификатор_функции> -d '{"queryStringParameters": {"name": "Username"}}'
    ```

    Результат:

    ```
    {"statusCode":200,"headers":{"Content-Type":"text/plain"},"isBase64Encoded":false,"body":"Hello, Username!"}
    ```

    По умолчанию вызывается версия функции с тегом `$latest`.

- HTTPS {#https}

	Ссылку для вызова функции можно найти на вкладке **Обзор**, в поле **Ссылка для вызова**.

	Для обеспечения безопасности функцию можно вызвать только по протоколу HTTPS. Вызовите ее как обычный HTTPS-запрос, вставив ссылку в адресную строку браузера и добавив в URL параметр `name`:

	```
	https://functions.yandexcloud.net/<идентификатор_функции>?name=Username
	```

	На странице появится ответ:

	```
	Hello, Username!
	```


{% endlist %}

## Что дальше {#what-is-next}

- Прочитайте, какой должна быть структура функции для вызова разными способами (HTTP, CLI), в разделе [Вызов функции в Cloud Functions](../../concepts/function-invoke.md).
- Ознакомьтесь с [концепциями сервиса](../../concepts/index.md).
- Посмотрите, что можно делать с функциями и версиями в [пошаговых инструкциях](../../operations/index.md).