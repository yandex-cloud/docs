{% list tabs %}

- Консоль управления

	1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите посмотреть список функций.
	1. Выберите сервис **{{ sf-name }}**.
	1. На панели слева выберите ![image](../../_assets/functions/functions.svg) **Функции**.

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
	| b097d9ous3gep99khe83 | my-beta-function   | aoek49ghmknnpj1ll45e | ACTIVE |
	+----------------------+--------------------+----------------------+--------+
	```

- API

	Получить список функций можно с помощью метода API [list](../../functions/functions/api-ref/Function/list.md).

- {{ yandex-cloud }} Toolkit

    Получить список функций можно с помощью [плагина {{ yandex-cloud }} Toolkit](https://github.com/yandex-cloud/ide-plugin-jetbrains) для семейства IDE на [платформе IntelliJ](https://www.jetbrains.com/ru-ru/opensource/idea/) от [JetBrains](https://www.jetbrains.com/).

{% endlist %}
