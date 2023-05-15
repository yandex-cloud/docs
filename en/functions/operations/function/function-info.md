# Getting information about a function

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your function.
   1. Select **{{ sf-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/functions/functions.svg) **Functions**.
   1. Select a function.
   1. The **Overview** page shows the function details.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   {% include [note](../../../_includes/functions/function-list-note.md) %}

   To get detailed information about a function, run this command:

   ```
   yc serverless function get <function_ID>
   ```
   Result:
   ```
   id: d4e155orh3nu********
     folder_id: b1gc1t4cb638********
     created_at: "2020-10-09T11:53:19.815Z"
     name: test-function
     log_group_id: ckg9ndpthgnu********
     http_invoke_url: https://functions.yandexcloud.net/d4e155orh3nu********
     status: ACTIVE
   ```

- API

   To get detailed information about a function, use the [get](../../functions/api-ref/Function/get.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/Get](../../functions/api-ref/grpc/function_service.md#Get) gRPC API call.

- {{ yandex-cloud }} Toolkit

   You can learn more about a function using the [{{ yandex-cloud }} Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the IDE family on the [JetBrains](https://www.jetbrains.com/) [IntelliJ platform](https://www.jetbrains.com/opensource/idea/).

{% endlist %}
