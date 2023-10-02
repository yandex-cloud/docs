---
title: "Получить ссылку для вызова"
description: "Следуя данной инструкции, вы сможете получить ссылку для вызова."
---

# Получить ссылку для вызова

{% list tabs %}

- Консоль управления

	1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
	1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
	1. Выберите контейнер. Ссылка для вызова будет в поле **{{ ui-key.yacloud.serverless-containers.label_url }}**.

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
	url: https://flh7r96juaqq********.{{ serverless-containers-host }}/
	status: ACTIVE
	```

	Ссылка для вызова будет в поле `url`.

- API

  Чтобы получить ссылку для вызова контейнера, воспользуйтесь методом REST API [get](../containers/api-ref/Container/get.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/Get](../containers/api-ref/grpc/container_service.md#Get).

{% endlist %}