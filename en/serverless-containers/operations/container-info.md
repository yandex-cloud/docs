# Getting information about a container

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with your container.
   1. Select **{{ serverless-containers-name }}**.
   1. On the left-hand panel, select **Containers**.
   1. Select the container.
   1. The **Overview** page shows the container details.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   {% include [note](../../_includes/serverless-containers/sc-list-note.md) %}

   To get detailed information about a container, run this command:

   ```
   yc serverless container get <container_ID>
   ```
   Result:
   ```
   id: bba0hq6q1prb********
   folder_id: b1gtmgn9gbvm********
   created_at: "2023-01-17T11:52:56.800Z"
   name: test
   url: https://bba0hq6q1prb********.containers.yandexcloud.net/
   status: ACTIVE
   ```

- API

   To get detailed information about a container, use the [get](../containers/api-ref/Container/get.md) REST API method for the [Container](../containers/api-ref/Container/index.md) resource or the [ContainerService/Get](../containers/api-ref/grpc/container_service.md#Get) gRPC API call.

{% endlist %}