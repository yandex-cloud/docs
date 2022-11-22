## Вызовите функцию {#invoke}

{% note info %}

Чтобы любой пользователь мог вызывать функцию, необходимо [сделать ее публичной](../../functions/operations/function-public.md). Подробнее о правах читайте в разделе [{#T}](../../functions/security/index.md).

{% endnote %}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Выберите сервис **{{ sf-name }}**.
    1. Выберите функцию.
    1. Перейдите на вкладку **Тестирование**.
    1. В поле **Тег версии** укажите ```$latest```, чтобы вызвать последнюю версию функции.
    1. В поле **Шаблон данных** выберите **Без шаблона**.
    1. В поле **Входные данные** введите:
		```
		{"queryStringParameters": {"name": "Username"}}
		```
    1. Нажмите кнопку **Запустить тест**.
    1. В разделе **Результат тестирования**, в поле **Состояние функции**, будет показан статус тестирования. **Важно**: максимальное время выполнения функции до [таймаута](../../functions/operations/function/version-manage.md#version-create) (включая начальную инициализацию при первом запуске) — 10 минут.
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

- CLI

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    Чтобы вызвать функцию, выполните команду:

    ```
    yc serverless function invoke <идентификатор функции> -d '{"queryStringParameters": {"name": "Username"}}'
    ```

    Результат:

    ```
    {"statusCode":200,"headers":{"Content-Type":"text/plain"},"isBase64Encoded":false,"body":"Hello, Username!"}
    ```

    По умолчанию вызывается версия функции с тегом `$latest`.

- HTTPS

	Ссылку для вызова функции можно найти на вкладке **Обзор**, в поле **Ссылка для вызова**.

	Для обеспечения безопасности функцию можно вызвать только по протоколу HTTPS. Вызовите ее как обычный HTTPS-запрос, вставив ссылку в адресную строку браузера и добавив в URL параметр `name`:

	```
	{{ sf-url }}/b09bhaokchn9pnbrlseb?name=Username
	```

	На странице появится ответ:

	```
	Hello, Username!
	```

- {{ yandex-cloud }} Toolkit

    Вызвать функцию можно с помощью [плагина {{ yandex-cloud }} Toolkit](https://github.com/yandex-cloud/ide-plugin-jetbrains) для семейства IDE на [платформе IntelliJ](https://www.jetbrains.com/ru-ru/opensource/idea/) от [JetBrains](https://www.jetbrains.com/).

{% endlist %}
