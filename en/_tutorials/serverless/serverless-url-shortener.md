# URL shortener


This tool accepts user requests via a public [API gateway](../../api-gateway/concepts/index.md): [{{ api-gw-full-name }}](../../api-gateway/). The user receives an HTML page with a URL input field from a [hosting](../../storage/concepts/hosting.md) service. The [{{ sf-full-name }}](../../functions/) [function](../../functions/concepts/function.md) sends the entered URL for storage to a [{{ ydb-full-name }}](../../ydb/) [serverless database](../../ydb/concepts/serverless-and-dedicated.md#serverless), shortens it, and returns it to the user. When the user follows the shortened URL, the function retrieves the full URL from the database and performs a redirect.

You can create the infrastructure for your URL shortener using one of these tools:
