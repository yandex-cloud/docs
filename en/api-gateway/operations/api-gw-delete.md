# Deleting API gateways

{% list tabs %}

- Management console

   To delete an API gateway:
   1. In the [management console]({{ link-console-main }}), select the folder where you wish to delete an API gateway.
   1. In the list of services, select **{{ api-gw-name }}**.
   1. In the API gateway's row, click ![image](../../_assets/options.svg) and select **Delete**.
   1. In the window that opens, click **Delete**.

- CLI

   To delete an API gateway, run the command below:

   ```
   yc serverless api-gateway delete --id <API gateway ID>
   ```

   Where:

   * `id`: ID of the API gateway.

   Result:

   ```
   done (18s)
   ```

- API

   You can delete an API gateway using the [delete](../apigateway/api-ref/ApiGateway/delete.md) API method.

- Yandex Cloud Toolkit

   You can delete an API gateway using the [Yandex Cloud Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the family of IDEs on the [IntelliJ platform](https://www.jetbrains.com/opensource/idea/) from [JetBrains](https://www.jetbrains.com/).

{% endlist %}
