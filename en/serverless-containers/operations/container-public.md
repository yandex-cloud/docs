# Making a container public

If you want any user to be able to invoke a container without providing the authorization header, make it public.

{% list tabs group=instructions %}

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

{% endlist %}