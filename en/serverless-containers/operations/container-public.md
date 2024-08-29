# Making a container public

If you want any user to be able to invoke a container without providing the authorization header, make it public.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder with your container.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
   1. Select the container you want to make public.
   1. On the **{{ ui-key.yacloud.common.overview }}** tab, enable **{{ ui-key.yacloud.serverless-containers.label_public-container }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To make a container public, run this command:

   ```
   yc serverless container allow-unauthenticated-invoke <container_name>
   ```

   Result:

   ```
   done (1s)
   ```

- API {#api}

   To make a container public, use the [setAccessBindings](../containers/api-ref/Container/setAccessBindings.md) REST API method for the [Container](../containers/api-ref/Container/index.md) resource or the [ContainerService/SetAccessBindings](../containers/api-ref/grpc/container_service.md#SetAccessBindings) gRPC API call.

   **Sample request**

   To use the example, install [cURL](https://curl.haxx.se) and [authenticate](../api-ref/containers/authentication.md) in the API.

   1. Create a `body.json` file with the following request body:

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
      * `roleId`: Role to be assigned. The `serverless-containers.containerInvoker` role allows you to invoke a container.
      * `id`: Subject to assign the role to. `allUsers`: Any user. No authentication is required.
      * `type`: Type of subject the role is assigned to. `system`: [Public group](../../iam/concepts/access-control/public-group.md).

   1. Run the request stating the IAM token, path to the `body.json` file, and container ID:

      ```bash
      curl -X POST \
          -H "Authorization: Bearer <IAM_token>" \
          -d "@<path_to_body.json_file>" \
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

   1. Make sure the role is assigned. To do this, run the request stating the IAM token and container ID:

      ```bash
      curl -X GET \
          -H "Authorization: Bearer <IAM_token>" \
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
