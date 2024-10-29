Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_gateway-broadcast }}**:
* In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_api-gateway }}** field, select the API gateway.
* In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_gateway-path }}** field, specify the path in the OpenAPI specification. Messages will be sent through WebSocket connections established using this path.
* In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function_service-account }}** field, select the [service account](../../iam/concepts/users/service-accounts.md) to send messages to WebSocket connections.
