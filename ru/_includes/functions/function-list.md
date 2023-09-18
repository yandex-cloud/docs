{% list tabs %}

- Консоль управления

	1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите посмотреть список функций.
	1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
	1. На панели слева выберите ![image](../../_assets/functions/functions.svg) **{{ ui-key.yacloud.serverless-functions.switch_list }}**.

- CLI

	{% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

	Чтобы получить список функций, выполните команду:

	```
	yc serverless function list
	```

	Результат:

	```
	+----------------------+--------------------+----------------------+--------+
	|          ID          |        NAME        |      FOLDER ID       | STATUS |
	+----------------------+--------------------+----------------------+--------+
	| b097d9ous3ge******** | my-beta-function   | aoek49ghmknn******** | ACTIVE |
	+----------------------+--------------------+----------------------+--------+
	```

- API

	Чтобы получить список функций, воспользуйтесь методом REST API [list](../../functions/functions/api-ref/Function/list.md) для ресурса [Function](../../functions/functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionsService/List](../../functions/functions/api-ref/grpc/function_service.md#List).


- {{ yandex-cloud }} Toolkit

    Получить список функций можно с помощью [плагина {{ yandex-cloud }} Toolkit](https://github.com/yandex-cloud/ide-plugin-jetbrains) для семейства IDE на [платформе IntelliJ](https://www.jetbrains.com/ru-ru/opensource/idea/) от [JetBrains](https://www.jetbrains.com/).


{% endlist %}
