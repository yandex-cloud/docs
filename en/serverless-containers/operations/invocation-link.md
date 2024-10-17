---
title: Getting an invocation link
description: Follow this guide to get an invocation link.
---

# Getting an invocation link

{% list tabs group=instructions %}

- Management console {#console}

	1. In the [management console]({{ link-console-main }}), select the folder with your container.
	1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
	1. Select the container. You will find the invocation link in the **{{ ui-key.yacloud.serverless-containers.label_url }}** field.

- CLI {#cli}

	To get an invocation link, run the following command:

	```bash
	yc serverless container get <container_name>
	```

	Result:

	```bash
	id: flh7r96juaqq********
	folder_id: aoek6qrs8tjh********
	created_at: "2021-08-17T07:53:10.219Z"
	name: my-beta-container
	description: my beta container description
	url: https://flh7r96juaqq********.{{ serverless-containers-host }}/
	status: ACTIVE
	```

	You will find the invocation link in the `url` field.

- API {#api}

  To get a container invocation link, use the [get](../containers/api-ref/Container/get.md) REST API method for the [Container](../containers/api-ref/Container/index.md) resource or the [ContainerService/Get](../containers/api-ref/grpc/Container/get.md) gRPC API call.

{% endlist %}