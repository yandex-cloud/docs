# Making a container public

To allow any user to invoke a container without providing an authorization header, make the container public.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with your container.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
  1. Select the container you want to make public.
  1. On the **{{ ui-key.yacloud.common.overview }}** tab, enable **{{ ui-key.yacloud.serverless-containers.label_public-container }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To make a container public, run this command:

    ```bash
    yc serverless container allow-unauthenticated-invoke <container_name>
    ```

    Result:

    ```text
    done (1s)
    ```

- API {#api}

  To make a container public, use the [setAccessBindings](../containers/api-ref/Container/setAccessBindings.md) REST API method for the [Container](../containers/api-ref/Container/index.md) resource or the [ContainerService/SetAccessBindings](../containers/api-ref/grpc/Container/setAccessBindings.md) gRPC API call.

  **Request example**

  To use this example, install [cURL](https://curl.haxx.se) and [authenticate](../api-ref/containers/authentication.md) with the API.

  1. Create a file named `body.json` with the following request body:

      ```json
      {
        "accessBindings": [
          {
            "roleId": "serverless-containers.containerInvoker",
            "subject": {
              "id": "allUsers",
              "type": "system"
            }
          }
        ]
      }
      ```

      Where:
      * `roleId`: Role to assign. The `serverless-containers.containerInvoker` role allows you to invoke a container.
      * `id`: Subject getting the role. `allUsers` stands for any user and requires no authentication.
      * `type`: Type of the subject getting the role. `system` stands for a [public group](../../iam/concepts/access-control/public-group.md).

  1. Run the request, specifying the IAM token, path to the `body.json` file, and container ID:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer <IAM_token>" \
          --data "@<body.json_file_path>" \
          https://serverless-containers.api.cloud.yandex.net/containers/v1/containers/<container_ID>:setAccessBindings
      ```

      Result:

      ```json
      {
       "done": false,
       "metadata": {
        "@type": "type.googleapis.com/yandex.cloud.access.SetAccessBindingsMetadata",
        "resourceId": "bba8dkc667bj********"
       },
       "id": "bbaoi3jn8plq********",
       "description": "operationSetAccessBindings",
       "createdAt": "2023-12-22T10:30:58.348672821Z",
       "createdBy": "aje07l4q4vmo********",
       "modifiedAt": "2023-12-22T10:30:58.348672821Z"
      }
      ```

  1. Make sure the role is assigned. To do this, run the request, specifying the IAM token and container ID:

      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer <IAM_token>" \
          https://serverless-containers.api.cloud.yandex.net/containers/v1/containers/<container_ID>:listAccessBindings
      ```

      Result:

      ```json
      {
       "accessBindings": [
        {
         "subject": {
          "id": "allUsers",
          "type": "system"
         },
         "roleId": "serverless.containers.invoker"
        }
       ]
      }
      ```

{% endlist %}
