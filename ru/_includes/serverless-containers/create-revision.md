Для создания ревизии сделайте Docker-образ публичным или передайте в команде [идентификатор сервисного аккаунта](../../iam/operations/sa/get-id.md), у которого есть права на скачивание образа.

{% list tabs %}

- Консоль управления

	1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
	1. Откройте сервис **{{ serverless-containers-name }}**.
	1. Выберите контейнер, ревизию которого хотите создать.
	1. Перейдите на вкладку **Редактор**.
	1. Укажите параметры ревизии.
	1. Нажмите кнопку **Создать ревизию**.

- CLI

	Чтобы создать ревизию контейнера, выполните команду:

	```
	yc serverless container revision deploy \
	  --container-name <имя_контейнера> \
	  --image <URL_Docker-образа> \
	  --cores 1 \
	  --memory 1GB \
	  --service-account-id <идентификатор_сервисного_аккаунта>
	```

	Где:

    * `--cores` — количество ядер, которые доступны контейнеру.
    * `--memory` — требуемая память. По умолчанию — 128 МБ.

	Результат:

	```
	id: bbajn5q2d74c********
	container_id: bba3fva6ka5g********
	created_at: "2021-07-09T15:04:55.135Z"
	image:
	  image_url: cr.yandex/crpd3cicopk7********/test-container:latest
	  image_digest: sha256:de8e1dce7ceceeafaae122f7670084a1119c961cd9ea1795eae92bd********
	resources:
	  memory: "1073741824"
	  cores: "1"
	execution_timeout: 3s
	service_account_id: ajeqnasj95o7********
	status: ACTIVE
	```

{% endlist %}
