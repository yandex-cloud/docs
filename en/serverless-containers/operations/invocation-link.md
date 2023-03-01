# Getting an invocation link

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with your container.
   1. Select **{{ serverless-containers-name }}**.
   1. Select the container. The invocation link is in the **Link to invoke** field.

- CLI

   To get an invocation link, run the following command:

   ```
   yc serverless container get <container_name>
   ```

   Result:

   ```
   id: flh7r96juaqq********
   folder_id: aoek6qrs8tjh********
   created_at: "2021-08-17T07:53:10.219Z"
   name: my-beta-container
   description: my beta container description
   url: https://flh7r96juaqq********.containers.cloud-preprod.yandex.net/
   status: ACTIVE
   ```

   You will find the invocation link in the `url` field.

- API

   To get a link to call a container, use the [get](../containers/api-ref/Container/get.md) API method.

{% endlist %}