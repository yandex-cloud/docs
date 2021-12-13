# Updating API gateways

{% list tabs %}

- Management console

    To update an API gateway specification:
    1. In the [management console]({{ link-console-main }}), select the folder where you want to update the API gateway.
    1. In the list of services, select **{{ api-gw-name }}**.
    1. In the window that opens, select the API gateway and click ![image](../../_assets/options.svg).
    1. In the menu that opens, click **Edit**.
    1. Edit the name, description, or specification of the API gateway.
    1. Click **Save**.

- CLI

    To change the API gateway specification:

    1. Make your changes in the `hello-world.yaml` specification file.

    1. Run the command with the following parameters:
        - `id`: ID of the API gateway.
        - `spec`: Updated specification file.

        ```
        yc serverless api-gateway update --id d5dug9gkmu187iojcrtr --spec=hello_world.yaml
        
        done (6s)
        id: d5dug9gkmu187iojcrtr
        folder_id: b1g55tflru0ek7omtfu0
        created_at: "2020-06-17T09:20:22.929Z"
        name: hello-world
        description: hello world
        status: ACTIVE
        domain: d5dug9gkmu187iojcpvp.apigw.yandexcloud.net
        log_group_id: ckghq1hm19q7ek5sjnh5
        ```

- API

    You can change the name, description, or specification of an API gateway using the [update](../apigateway/api-ref/ApiGateway/update.md) API method.

- Yandex.Cloud Toolkit

    You can change the name, description, or specification of an API gateway using the [Yandex.Cloud Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the family of IDEs on the [IntelliJ platform](https://www.jetbrains.com/opensource/idea/) from [JetBrains](https://www.jetbrains.com/).

{% endlist %}

