[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Functions](../../index.md) > [Начало работы](../index.md) > [Создание функции](index.md) > Java

# Создание функции на Java

Создайте и выполните [функцию](../../concepts/function.md) на Java, которая приветствует пользователя.

## Перед началом работы {#before-begin}

[Создайте каталог](../../../resource-manager/operations/folder/create.md) в Yandex Cloud.

## Создайте функцию {#create-func}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите создать функцию.
    1. Перейдите в сервис **Cloud Functions**.
    1. Нажмите кнопку **Создать функцию**.
    1. Введите имя функции — `java-function`.
    1. Нажмите кнопку **Создать**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы создать функцию, выполните команду:

    ```bash
    yc serverless function create --name=java-function
    ```

    Результат:

    ```text
    id: b09bhaokchn9********
    folder_id: aoek49ghmknn********
    created_at: "2019-06-14T10:03:37.475Z"
    name: java-function
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

1. Сохраните следующий код в файл с названием `Handler.java`:

    ```java
    import java.util.HashMap;
    import java.util.Map;
    import java.util.function.Function;

    class Request {
        Map<String, String> queryStringParameters;
    }

    class Response {
        private int statusCode;
        private Map<String, String> headers;
        private Boolean isBase64Encoded;
        private String body;

        public Response(int statusCode, Map<String, String> headers, Boolean isBase64Encoded, String body) {
            this.statusCode = statusCode;
            this.headers = headers;
            this.isBase64Encoded = isBase64Encoded;
            this.body = body;
        }
    }

    public class Handler implements Function<Request, Response> {
        private Integer statusCode = 200;
        private Boolean isBase64Encoded = false;

        @Override
        public Response apply(Request request) {
            Map<String, String> headers = new HashMap<>();
            headers.put("Content-Type", "text/plain");

            String name = request.queryStringParameters.get("name");
            return new Response(statusCode, headers, isBase64Encoded, String.format("Hello, %s!", name));
        }
    }
    ```

1. Добавьте файл `Handler.java` в ZIP-архив `hello-java.zip`.

### Создайте версию функции {#create-version}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится функция.
    1. Перейдите в сервис **Cloud Functions**.
    1. Выберите функцию `java-function`.
    1. В разделе **Последняя версия** нажмите кнопку **Создать в редакторе**.
    1. Выберите среду выполнения `Java 21`.
    1. Отключите опцию **Добавить файлы с примерами кода** и нажмите кнопку **Продолжить**.
    1. Задайте параметры версии:
        * **Источник кода** — `ZIP-архив`.
        * **Файл** — прикрепите файл `hello-java.zip`.
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
      --function-name=java-function \
      --runtime java21 \
      --entrypoint Handler \
      --memory 128m \
      --execution-timeout 3s \
      --source-path ./hello-java.zip
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
    runtime: java21
    entrypoint: Handler
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