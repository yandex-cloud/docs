# Получить информацию о функции

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Выберите сервис **{{ sf-name }}**.
    1. На панели слева выберите ![image](../../../_assets/functions/functions.svg) **Функции**.
    1. Выберите функцию.
    1. На странице **Обзор** отобразится подробная информация о функции.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    {% include [note](../../../_includes/functions/function-list-note.md) %}

    Чтобы получить подробную информацию о функции, выполните команду:

    ```
    yc serverless function get <идентификатор_функции>
    ```
    Результат:
    ```
    id: d4e155orh3nu********
	folder_id: b1gc1t4cb638********
	created_at: "2020-10-09T11:53:19.815Z"
	name: test-function
	log_group_id: ckg9ndpthgnu********
	http_invoke_url: https://functions.yandexcloud.net/d4e155orh3nu********
	status: ACTIVE
    ```

- API

    Чтобы получить подробную информацию о функции, воспользуйтесь методом REST API [get](../../functions/api-ref/Function/get.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/Get](../../functions/api-ref/grpc/function_service.md#Get).

- {{ yandex-cloud }} Toolkit

    Получить подробную информацию о функции можно с помощью [плагина {{ yandex-cloud }} Toolkit](https://github.com/yandex-cloud/ide-plugin-jetbrains) для семейства IDE на [платформе IntelliJ](https://www.jetbrains.com/ru-ru/opensource/idea/) от [JetBrains](https://www.jetbrains.com/).

{% endlist %}
