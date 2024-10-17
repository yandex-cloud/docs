---
title: Getting information about a function
description: Follow this guide to get information about a function.
---

# Getting information about a function

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder containing the function.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. In the left-hand panel, select ![image](../../../_assets/console-icons/curly-brackets-function.svg) **{{ ui-key.yacloud.serverless-functions.switch_list }}**.
    1. Select a function.
    1. The **{{ ui-key.yacloud.serverless-functions.item.overview.label_title }}** page will show the function details.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    {% include [note](../../../_includes/functions/function-list-note.md) %}

    To get detailed information about a function, run this command:

    ```bash
    yc serverless function get <function_ID>
    ```
    Result:
    ```json
    id: d4e155orh3nu********
	folder_id: b1gc1t4cb638********
	created_at: "2020-10-09T11:53:19.815Z"
	name: test-function
	log_group_id: ckg9ndpthgnu********
	http_invoke_url: https://{{ sf-url }}/d4e155orh3nu********
	status: ACTIVE
    ```

- API {#api}

    To get detailed information about a function, use the [get](../../functions/api-ref/Function/get.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/Get](../../functions/api-ref/grpc/Function/get.md) gRPC API call.


- {{ yandex-cloud }} Toolkit {#yc-toolkit}

    You can get more information on a function using the [{{ yandex-cloud }} Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the IDE family on the [JetBrains](https://www.jetbrains.com/) [IntelliJ platform](https://www.jetbrains.com/opensource/idea/).


{% endlist %}
