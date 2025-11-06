1. In the **Transport** field, select a transport method for communicating with the MCP server. Available types:

    {% include [transportation-methods](./transportation-methods.md) %}

1. In the **URL** field, specify a URL for accessing the MCP server, e.g., `https://mcp.example.com`.
1. In the **Authorization type** field, specify the authentication data to provide in requests:

    * `Access token`: To provide the access token in the request authorization header.

        To add additional headers to the request, click ![plus](../../../_assets/console-icons/plus.svg) **Add header**.
    * `Without authorization`: To skip authentication.
1. Click **Connect**.
1. {% include [create-server-console-choose-tools](./create-server-console-choose-tools.md) %}