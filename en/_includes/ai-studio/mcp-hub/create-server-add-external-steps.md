1. In the **{{ ui-key.yacloud.yagpt.YaGPT.McpCallToolForm.transport_q3nD6 }}** field, select a transport method for communicating with the MCP server. Available types:

    {% include [transportation-methods](./transportation-methods.md) %}

1. In the **{{ ui-key.yacloud.yagpt.YaGPT.McpCallToolForm.url_bUhZ1 }}** field, specify the external MCP server URL, e.g., `https://mcp.example.com`.
1. In the **Authorization type** field, specify the authentication data to provide in requests:

    * `{{ ui-key.yacloud.yagpt.YaGPT.McpCallToolForm.mcp-authorization_header_fdGKe }}`: To provide the access token in the request authorization header.

        To add additional headers to the request, click ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.yagpt.YaGPT.McpCallToolForm.add-header_bbBV5 }}**.
    * `{{ ui-key.yacloud.yagpt.YaGPT.McpCallToolForm.mcp-authorization_no-authorization_iqvfQ }}`: To skip authentication.
1. Click **{{ ui-key.yacloud.yagpt.YaGPT.McpCallToolForm.connect_xY9Zw }}**.
1. {% include [create-server-console-choose-tools](./create-server-console-choose-tools.md) %}