Instead of {{ mcp-hub-name }}, you can use the Responses API to access an external MCP server from an AI agent. To do this, simply specify the server URL and the [API key](../../../iam/concepts/authorization/api-key.md).

{% cut "Example of connecting an MCP server via the Responses API:" %}

```python
from openai import OpenAI

# Creating a client
client = openai.OpenAI(
    api_key="<API_key>",
    base_url="https://{{ api-host-llm }}/v1",
    project="<folder_ID>"
)
# Example of calling the MCP via the Responses API
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
            "name": "crm_lookup",
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