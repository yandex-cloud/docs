{% list tabs %}

- Консоль управления

	1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать контейнер.
	1. Откройте сервис **{{ serverless-containers-name }}**.
	1. Нажмите кнопку **Создать контейнер**.
	1. Введите имя и описание контейнера. Формат имени:

		{% include [name-format](../../_includes/name-format.md) %}

    1. Нажмите кнопку **Создать**.


- CLI

	{% include [cli-install](../cli-install.md) %}
    
    {% include [default-catalogue](../default-catalogue.md) %}

	Чтобы создать контейнер, выполните команду:

	```
	yc serverless container create --name <имя_контейнера>
	```

	Результат:

	```
	id: bba3fva6ka5g********
	folder_id: b1gqvft7kjk3********
	created_at: "2021-07-09T14:49:00.891Z"
	name: my-beta-container
	url: https://bba3fva6ka5g********.containers.yandexcloud.net/
	status: ACTIVE
	```

{% endlist %}