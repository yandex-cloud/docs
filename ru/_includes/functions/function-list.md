{% list tabs %}

- Консоль управления

	1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите посмотреть список функций.
	1. Откройте сервис **{{ sf-name }}**.
	1. Перейдите на вкладку **Функции**.

- CLI

	{% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

	Получите список функций:

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

{% endlist %}