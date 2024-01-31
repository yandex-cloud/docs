{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder containing your function.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/curly-brackets-function.svg) **{{ ui-key.yacloud.serverless-functions.switch_list }}**.
   1. Select the function to get a list of versions for.
   1. Under **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-history }}**, you can find the list of function versions and their details.

- CLI {#cli}

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   {% include [note](function-list-note.md) %}

   To get a list of function versions, run the following command:

   ```
   yc serverless function version list --function-name <function_name>
   ```

   Result:

   ```
   +----------------------+----------------------+-----------+--------------+---------+---------------------+
   |          ID          |     FUNCTION ID      |  RUNTIME  |  ENTRYPOINT  |  TAGS   |     CREATED AT      |
   +----------------------+----------------------+-----------+--------------+---------+---------------------+
   | b09u830mb1n3******** | b097d9ous3ge******** | python311 | test.handler | $latest | 2023-08-22 09:23:23 |
   | b09ch6pmpohf******** | b097d9ous3ge******** | python311 | test.handler | beta    | 2023-08-22 09:12:38 |
   +----------------------+----------------------+-----------+--------------+---------+---------------------+
   ```

- API {#api}

   To get a list of function versions, use the [listVersions](../../functions/functions/api-ref/Function/listVersions.md) REST API method for the [Function](../../functions/functions/api-ref/Function/index.md) resource or the [FunctionsService/ListVersions](../../functions/functions/api-ref/grpc/function_service.md#ListVersions) gRPC API call.


- {{ yandex-cloud }} Toolkit {#yc-toolkit}

   You can get a list of function versions using the [{{ yandex-cloud }} Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the IDE family on the [JetBrains](https://www.jetbrains.com/) [IntelliJ platform](https://www.jetbrains.com/opensource/idea/).


{% endlist %}
