В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_gateway-broadcast }}**:
* В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_api-gateway }}** выберите API-шлюз.
* В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_gateway-path }}** укажите путь в OpenAPI-спецификации. Через WebSocket-соединения, которые установлены по этому пути, будут отправляться сообщения.
* В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function_service-account }}** выберите [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), от имени которого в WebSocket-соединения будут отправляться сообщения.
