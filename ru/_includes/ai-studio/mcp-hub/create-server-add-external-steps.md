1. В поле **{{ ui-key.yacloud.yagpt.YaGPT.McpCallToolForm.transport_q3nD6 }}** выберите тип транспортного механизма, который будет использоваться для взаимодействия с MCP-сервером. Доступные типы:

    {% include [transportation-methods](./transportation-methods.md) %}

1. В поле **{{ ui-key.yacloud.yagpt.YaGPT.McpCallToolForm.url_bUhZ1 }}** укажите URL, по которому доступен внешний MCP-сервер. Например: `https://mcp.example.com`.
1. В поле **Тип авторизации** укажите аутентификационные данные, которые будут передаваться в запросах:

    * `{{ ui-key.yacloud.yagpt.YaGPT.McpCallToolForm.mcp-authorization_header_fdGKe }}` — чтобы передавать токен доступа в заголовке авторизации запроса.

        Чтобы добавить в запрос дополнительные заголовки, нажмите кнопку ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.yagpt.YaGPT.McpCallToolForm.add-header_bbBV5 }}**.
    * `{{ ui-key.yacloud.yagpt.YaGPT.McpCallToolForm.mcp-authorization_no-authorization_iqvfQ }}` — чтобы не использовать аутентификацию.
1. Нажмите кнопку **{{ ui-key.yacloud.yagpt.YaGPT.McpCallToolForm.connect_xY9Zw }}**.
1. {% include [create-server-console-choose-tools](./create-server-console-choose-tools.md) %}