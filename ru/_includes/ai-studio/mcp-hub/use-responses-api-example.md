Вместо {{ mcp-hub-name }} для обращения к внешнему MCP-серверу из AI-агента вы можете использовать {{ responses-api }}. Для этого достаточно просто указать URL-адрес сервера и [API-ключ](../../../iam/concepts/authorization/api-key.md).

{% cut "Пример подключения MCP-сервера через {{ responses-api }}:" %}

```python
from openai import OpenAI

# Создаем клиента
client = openai.OpenAI(
    api_key="<API-ключ>",
    base_url="https://rest-assistant.{{ api-host }}/v1",
    project="<идентификатор_каталога>"
)
# Пример вызова MCP через {{ responses-api }}
response = client.responses.create(
    model="gpt://<идентификатор_каталога>/yandexgpt",
    input=[
        {
            "role": "user",
            "content": "Найди клиента с именем Иван Иванов в CRM"
        }
    ],
    # MCP-инструменты, доступные модели
    tools=[
        {
            "server_label": "crm_lookup",
            "server_url": "<URL_MCP-сервера>",
            "type": "mcp",
            "metadata": {
                "description": "Поиск клиента в CRM по имени"
            }
        }
    ]
)

print(response.output_text)
```

{% endcut %}