{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder containing the function.
    1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/curly-brackets-function.svg) **{{ ui-key.yacloud.serverless-functions.switch_list }}**.
    1. Select the function for which you want to get the list of versions.
    1. Under **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-history }}**, you will see the list of function versions and their details.

- CLI {#cli}

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    To find out the name or ID of a function version, get the [list of function versions](../../functions/operations/function/version-list.md) in the folder.

    To get detailed information about a function version by:

    * `ID`, run this command:
        ```
        yc serverless function version get <version_ID>
        ```
        Result:
      
        ```
        id: b09u830mb1n3********
        function_id: b097d9ous3ge********
        created_at: "2023-08-22T09:23:23.383Z"
        runtime: python311
        entrypoint: test.handler
        resources:
          memory: "134217728"
        execution_timeout: 5s
        image_size: "4096"
        status: ACTIVE
        tags:
        - $latest
        log_group_id: eolv6578frac********
        ```

    * `TAGS`, run this command:
        ```
        yc serverless function version get-by-tag --function-name <function_name> --tag <tag>
        ```
        Result:
      
        ```
        id: b09ch6pmpohf********
        function_id: b097d9ous3ge********
        created_at: "2023-08-22T09:12:38.464Z"
        runtime: python311
        entrypoint: test.handler
        resources:
          memory: "134217728"
        execution_timeout: 5s
        image_size: "4096"
        status: ACTIVE
        tags:
        - beta
        log_group_id: eolv6578frac********
        ```

- API {#api}

    To get detailed information about a function version, use the [getVersion](../../functions/functions/api-ref/Function/getVersion.md) REST API method for the [Function](../../functions/functions/api-ref/Function/index.md) resource or the [FunctionsService/GetVersion](../../functions/functions/api-ref/grpc/Function/getVersion.md) gRPC API call.


{% endlist %}
