# Получить ссылку для вызова

{% list tabs %}

- Консоль управления

	1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
	1. Выберите сервис **{{ serverless-containers-name }}**.
	1. Выберите контейнер. Ссылка для вызова будет в поле **Ссылка для вызова**.

- CLI

	Чтобы получить ссылку для вызова, выполните команду:

	```
	yc serverless container get <имя_контейнера>
	```

	Результат:

	```
	id: flh7r96juaqq********
	folder_id: aoek6qrs8tjh********
	created_at: "2021-08-17T07:53:10.219Z"
	name: my-beta-container
	description: my beta container description
	url: https://flh7r96juaqq********.containers.cloud-preprod.yandex.net/
	status: ACTIVE
	```

	Ссылка для вызова будет в поле `url`.

- API

  Получить ссылку для вызова контейнера можно с помощью метода API [get](../containers/api-ref/Container/get.md).

{% endlist %}