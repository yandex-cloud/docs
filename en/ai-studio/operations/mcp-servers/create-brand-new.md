---
title: How to create an MCP server from scratch in {{ mcp-hub-name }}
description: Follow this guide to learn how to create your own MCP servers in {{ mcp-hub-name }} from scratch using the {{ foundation-models-full-name }} interface.
---

# Creating an MCP server in {{ mcp-hub-name }} from scratch

{% include [note-preview](../../../_includes/note-preview.md) %}

In [{{ mcp-hub-name }}](../../concepts/mcp-hub/index.md), you can create new MCP servers from scratch containing tools such as an HTTPS request to an external API, a {{ sf-full-name }} [function](../../../functions/concepts/function.md), or a [workflow](../../../serverless-integrations/concepts/workflows/workflow.md) in {{ sw-full-name }}.

To create a new MCP server:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder for which your account has the `serverless.mcpGateways.editor` [role](../../security/index.md#serverless-mcpGateways-editor) or higher.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_foundation-models }}**.
  1. In the left-hand panel, select ![logo-mcp](../../../_assets/console-icons/logo-mcp.svg) **MCP servers**, and in the window that opens:

      1. Under **Add Method**, select ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **Create**.
      1. Under **Tools**, select the [type](../../concepts/mcp-hub/index.md#brand-new) of tool you want to add to the MCP server: `HTTPS requests`, `{{ sf-name }}`, or `{{ sw-name }}`:

          {% list tabs %}

          - HTTPS requests

            1. In the **Tool name** field, specify a name for the tool you are creating. Follow these naming requirements:

                {% include [name-format](../../../_includes/name-format.md) %}

            1. In the **Instructions for agent** field, enter the required text description for the tool. This description must define conditions for the AI agent to use this tool. For example:

                ```text
                A tool for creating tickets in a corporate task processing system. Use this 
                tool to log customer complaints, support requests, and 
                error reports. When using this tool, set the `queue`, `type`, `priority`, and `summary` parameters. 
                In the `queue` parameter (queue name), always provide the SUPPORT constant. In the `type` parameter (request 
                type), provide one of the following values: bug (error report), complaint (customer complaint), or 
                support-request (request for consultation). In the `priority` parameter, 
                provide one of these values: low, medium, or high. In the 
                `summary` parameter, provide a text describing the gist of the user request in their own words.
                ```
            1. In the **URL** field, specify the endpoint the HTTPS request will be sent to.

                To specify query parameters in a URL, use [OpenAPI](https://www.openapis.org/) syntax. For example: `{{ link-console-main }}/folders/{folder-id}`.
            1. In the **Method** field, select the request method: `Get` or `Post`
            1. Expand the **Advanced** section and specify the authentication data that will be provided in HTTPS requests:

                {% include [create-server-console-auth-params](../../../_includes/ai-studio/mcp-hub/create-server-console-auth-params.md) %}

            1. {% include [create-server-console-tool-params](../../../_includes/ai-studio/mcp-hub/create-server-console-tool-params.md) %}
            1. Under **HTTPS request settings**, configure the HTTPS request settings:

                * Under **Request headers**, specify the names and values ​​of the headers that will be provided in requests.
                * Under **Query parameters**, specify the names and values ​​of the parameters that will be provided in the request.
                * Under **Request body**, review an example of the request you got and adjust it if required.

                    {% include [empty-request-body](../../../_includes/ai-studio/mcp-hub/empty-request-body.md) %}

                    These parameters support templating: their values ​​can be generated dynamically. The templating language is `jq`. For more details, see the [jq guide](https://jqlang.github.io/jq/manual/).

                    For example: The `\(.city)` value of the HTTPS request parameter will be taken from the `city` tool parameter. Beyond that, you can set up authorization using a token you got from the {{ lockbox-name }} secret or the one provided in the tool parameter. To do this, use the `Bearer \(lockboxPayload("<secret_ID>"; "<key_ID>"))` phrase or `Bearer \(.token)` for the `Authorization` header.

          - {{ sf-name }}

            1. In the **Tool name** field, specify a name for the tool you are creating. Follow these naming requirements:

                {% include [name-format](../../../_includes/name-format.md) %}

            1. In the **Instructions for agent** field, enter the required text description for the tool. This description must define conditions for the AI agent to use this tool. For example:

                ```text
                This tool recognizes text in an image transmitted in base64 encoding. In the recognized 
                text, the tool extracts "article":"quantity" pairs and returns them in JSON structure format.
                ```
            1. In the **Function** field, select the {{ sf-name }} [function](../../../functions/concepts/function.md) that will handle the requests.
            1. In the **Authorization type** field, select the authorization method when calling the function:

                * `Service account`: To call a function as a [service account](../../../iam/concepts/users/service-accounts.md) linked to the MCP server.

                    {% note info %}

                    [Assign](../../../iam/operations/sa/assign-role-for-sa.md) the `functions.functionInvoker` role for the required function to the service account linked to the MCP server.

                    {% endnote %}

                * `Without authorization`: To skip authorization if you call a public function.
            1. {% include [create-server-console-tool-params](../../../_includes/ai-studio/mcp-hub/create-server-console-tool-params.md) %}

            {% include [empty-request-body](../../../_includes/ai-studio/mcp-hub/empty-request-body.md) %}

          - {{ sw-name }}

            1. In the **Tool name** field, specify a name for the tool you are creating. Follow these naming requirements:

                {% include [name-format](../../../_includes/name-format.md) %}

            1. In the **Instructions for agent** field, enter the required text description for the tool. This description must define conditions for the AI agent to use this tool. For example:

                ```text
                This tool invokes a workflow to automatically summarize long text. Provides 
                the source text, maximum summation length, and language.
                ```
            1. In the **Workflow** field, select the {{ sw-name }} [workflow](../../../serverless-integrations/concepts/workflows/workflow.md) that will handle requests.
            1. In the **Authorization type** field, select the authorization method when executing the workflow:

                * `Service account`: To execute a workflow under a [service account](../../../iam/concepts/users/service-accounts.md) linked to the MCP server.

                    {% note info %}

                    [Assign](../../../iam/operations/sa/assign-role-for-sa.md) the service account linked to the MCP server the `serverless.workflows.executor` [role](../../../serverless-integrations/security/workflows.md#serverless-workflows-executor) for the {{ yandex-cloud }} [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) containing the required workflow.

                    {% endnote %}

                * `Without authorization`: To skip authorization when executing a workflow.
            1. {% include [create-server-console-tool-params](../../../_includes/ai-studio/mcp-hub/create-server-console-tool-params.md) %}

            {% include [empty-request-body](../../../_includes/ai-studio/mcp-hub/empty-request-body.md) %}

          {% endlist %}

      1. To add an additional instrument to the MCP server, click ![plus](../../../_assets/console-icons/plus.svg) **Add instrument**.

          {% include [server-tool-number-notice](../../../_includes/ai-studio/mcp-hub/server-tool-number-notice.md) %}

      1. Under **Server parameters**:

          1. {% include [create-server-console-general-params-ss1](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss1.md) %}
          1. {% include [create-server-console-general-params-ss2](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss2.md) %}
          1. {% include [create-server-console-general-params-ss3](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss3.md) %}
          1. {% include [create-server-console-general-params-ss4](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss4.md) %}
          1. {% include [create-server-console-general-params-ss5](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss5.md) %}
      1. Click **Add**

{% endlist %}

{% include [server-creation-result-phrase](../../../_includes/ai-studio/mcp-hub/server-creation-result-phrase.md) %}

#### See also {#see-also}

* [{#T}](../../concepts/mcp-hub/index.md)
* [{#T}](./connect-external.md)
* [{#T}](./create-from-template.md)