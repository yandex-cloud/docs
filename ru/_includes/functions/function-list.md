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

- Yandex Cloud Toolkit

    Получить список функций можно с помощью [плагина Yandex Cloud Toolkit]{% if lang == "ru" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains){% endif %}{% if lang == "en" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md){% endif %} для семейства IDE на [платформе IntelliJ]{% if lang == "ru" %}(https://www.jetbrains.com/ru-ru/opensource/idea/){% endif %}{% if lang == "en" %}(https://www.jetbrains.com/opensource/idea/){% endif %} от [JetBrains](https://www.jetbrains.com/).

{% endlist %}
