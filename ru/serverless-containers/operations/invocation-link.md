---
title: Получить ссылку для вызова
description: Следуя данной инструкции, вы сможете получить ссылку для вызова.
---

# Получить ссылку для вызова

{% list tabs group=instructions %}

- Консоль управления {#console}

	1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
	1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
	1. Выберите контейнер. Ссылка для вызова будет в поле **{{ ui-key.yacloud.serverless-containers.label_url }}**.

- CLI {#cli}

	Чтобы получить ссылку для вызова, выполните команду:

	```bash
	yc serverless container get <имя_контейнера>
	```

	Результат:

	```bash
	id: flh7r96juaqq********
	folder_id: aoek6qrs8tjh********
	created_at: "2021-08-17T07:53:10.219Z"
	name: my-beta-container
	description: my beta container description
	url: https://flh7r96juaqq********.{{ serverless-containers-host }}/
	status: ACTIVE
	```

	Ссылка для вызова будет в поле `url`.

- API {#api}

  Чтобы получить ссылку для вызова контейнера, воспользуйтесь методом REST API [get](../containers/api-ref/Container/get.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/Get](../containers/api-ref/grpc/Container/get.md).

{% endlist %}