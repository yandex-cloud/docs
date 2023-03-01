# Making a container public

If you want any user to be able to invoke a container without providing the authorization header, make it public.

{% list tabs %}

- CLI

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

- API

   You can make a container public using the [setAccessBindings](../../serverless-containers/containers/api-ref/Container/setAccessBindings.md) API method.

{% endlist %}