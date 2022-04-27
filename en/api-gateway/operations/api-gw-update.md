# Updating API gateways

{% list tabs %}

- Management console

   To update an API gateway specification:
   1. In the [management console]({{ link-console-main }}), select the folder where you wish to edit an API gateway.
   1. In the list of services, select **{{ api-gw-name }}**.
   1. In the API gateway's row, click ![image](../../_assets/options.svg) and select **Edit**.
   1. Edit the name, description, or specification of the API gateway.
   1. Click **Save**.

- CLI

   To change the API gateway specification:
   1. Make your changes in the specification file `hello-world.yaml`.
   1. Run the command:

      ```
      yc serverless api-gateway update --id d5dug9gkmu187iojcrtr --spec=hello_world.yaml
      ```

      Where:

      - `id`: ID of the API gateway.
      - `spec`: Updated specification file.

      Result:

      ```
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

- Yandex Cloud Toolkit

   You can edit the name, the description, or the specification of an API gateway using the [Yandex Cloud Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the family of IDEs on the [IntelliJ platform](https://www.jetbrains.com/opensource/idea/) from [JetBrains](https://www.jetbrains.com/).

{% endlist %}
