## Вызовите функцию {#invoke}

{% note info %}

Чтобы любой пользователь мог вызывать функцию, необходимо [сделать ее публичной](../../functions/operations/function/function-public.md). Подробнее о правах читайте в разделе [{#T}](../../functions/security/index.md).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Выберите функцию.
    1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}**.
    1. В поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_tag }}** укажите `$latest`, чтобы вызвать последнюю версию функции.
    1. В поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_payload-template }}** выберите `{{ ui-key.yacloud.serverless-functions.item.testing.value_empty }}`.
    1. В поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_payload }}** введите:
       ```
       {"queryStringParameters": {"name": "Username"}}
       ```
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}**.
    1. В разделе **{{ ui-key.yacloud.serverless-functions.item.testing.label_title-test-result }}**, в поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_execution-result }}**, будет показан статус тестирования. **Важно**: максимальное время выполнения функции до [таймаута](../../functions/operations/function/version-manage.md) (включая начальную инициализацию при первом запуске) — 10 минут.
    1. В поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_function-output }}** появится результат выполнения функции:
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

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

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

	Ссылку для вызова функции можно найти на вкладке **{{ ui-key.yacloud.common.overview }}**, в поле **{{ ui-key.yacloud.serverless-functions.item.overview.label_invoke-link }}**.

	Для обеспечения безопасности функцию можно вызвать только по протоколу HTTPS. Вызовите ее как обычный HTTPS-запрос, вставив ссылку в адресную строку браузера и добавив в URL параметр `name`:

	```
	https://{{ sf-url }}/<идентификатор_функции>?name=Username
	```

	На странице появится ответ:

	```
	Hello, Username!
	```


- {{ yandex-cloud }} Toolkit {#yc-toolkit}

    Вызвать функцию можно с помощью [плагина {{ yandex-cloud }} Toolkit](https://github.com/yandex-cloud/ide-plugin-jetbrains) для семейства IDE на [платформе IntelliJ](https://www.jetbrains.com/ru-ru/opensource/idea/) от [JetBrains](https://www.jetbrains.com/).


{% endlist %}
