Instead of {{ mcp-hub-name }}, you can use the {{ responses-api }} to access an external MCP server from an AI agent. Do this by simply specifying the server URL and the [API key](../../../iam/concepts/authorization/api-key.md) with `yc.serverless.mcpGateways.invoke` as the specified [scope](../../../iam/concepts/authorization/api-key.md#scoped-api-keys).

{% cut "Example of connecting an MCP server via the {{ responses-api }}:" %}

```python
from openai import OpenAI

# Creating a client
client = openai.OpenAI(
    api_key="<API_key>",
    base_url="https://rest-assistant.{{ api-host }}/v1",
    project="<folder_ID>"
)
# Example of calling the MCP via the {{ responses-api }}
response = client.responses.create(
    model="gpt://<folder_ID>/yandexgpt",
    input=[
        {
            "role": "user",
            "content": "Find a client named John Doe in your CRM"
        }
    ],
    # MCP tools, available models
    tools=[
        {
            "server_label": "crm_lookup",
            "server_url": "<MCP_server_URL>",
            "type": "mcp",
            "metadata": {
                "description": "Client search in CRM by name"
            }
        }
    ]
)

print(response.output_text)
```

{% endcut %}