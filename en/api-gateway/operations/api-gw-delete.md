# Deleting API gateways

{% list tabs %}

- Management console

    To delete an API gateway:
    1. In the [management console]({{ link-console-main }}), select the folder to delete the API gateway from.
    1. In the list of services, select **{{ api-gw-name }}**.
    1. In the window that opens, select the API gateway and click ![image](../../_assets/options.svg).
    1. In the menu that opens, click **Delete**.
    1. In the window that opens, click **Delete**.

- CLI

    To delete an API gateway, run the command with the following parameters:
    * `id`: ID of the API gateway.

    ```
    yc serverless api-gateway delete --id d5dug9gkmu187iojcpvp
    done (18s)
    ```

- API

    You can delete an API gateway using the [delete](../apigateway/api-ref/ApiGateway/delete.md) API method.

- Yandex.Cloud Toolkit

    You can delete an API gateway using the [Yandex.Cloud Toolkit plugin]{% if lang == "ru" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains){% endif %}{% if lang == "en" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md){% endif %} for the family of IDEs on the [IntelliJ platform]{% if lang == "ru" %}(https://www.jetbrains.com/ru-ru/opensource/idea/){% endif %}{% if lang == "en" %}(https://www.jetbrains.com/opensource/idea/){% endif %} from [JetBrains](https://www.jetbrains.com/).

{% endlist %}

