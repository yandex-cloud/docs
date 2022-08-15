{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your function.
   1. Select **{{ sf-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/functions/functions.svg) **Functions**.
   1. Select the function to get a list of versions for.
   1. Under **Version history**, you can find the list of function versions and their details.

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To get detailed information about a function version by:

   * `ID`, run the command:
      ```
      yc serverless function version get <version ID>
      ```
      Result:
      ```
      id: b09u830mb1n32a7rj0n8
      function_id: b097d9ous3gep99khe83
      created_at: "2019-06-13T09:23:23.383Z"
      runtime: python37
      entrypoint: test.handler
      resources:
        memory: "134217728"
      execution_timeout: 5s
      image_size: "4096"
      status: ACTIVE
      tags:
      - $latest
      log_group_id: eolv6578frac08uh5h6s
      ```

   * `TAGS`, run the command:
      ```
      yc serverless function version get-by-tag --function-name <function name> --tag <tag>
      ```
      Result:
      ```
      id: b09ch6pmpohfc9sogj5f
      function_id: b097d9ous3gep99khe83
      created_at: "2019-06-13T09:12:38.464Z"
      runtime: python37
      entrypoint: test.handler
      resources:
        memory: "134217728"
      execution_timeout: 5s
      image_size: "4096"
      status: ACTIVE
      tags:
      - beta
      log_group_id: eolv6578frac08uh5h6s
      ```

- API

   You can get details of the function version using the [getVersion](../../functions/functions/api-ref/Function/getVersion.md) API method.

- Yandex Cloud Toolkit

   You can get details about a function version using the [Yandex Cloud Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the IDE family on the [IntelliJ platform](https://www.jetbrains.com/opensource/idea/) from [JetBrains](https://www.jetbrains.com/).

{% endlist %}
