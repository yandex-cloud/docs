Use this REST API [McpGateway.List](../../../ai-studio/mcp-gateway/api-ref/McpGateway/list.md) method to get the list of MCP servers in the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

```bash
curl \
  --request GET \
  --header "Authorization: Bearer $IAM_TOKEN" \
  "https://ai.{{ api-host }}/mcpgateway/v1/mcpGateways?folderId=<folder_ID>"
```

Where `folderId` is the query parameter containing the ID of the folder you want to view the list of MCP servers for.

{% cut "Result" %}

```json
{
"gateways": [
  {
  "logOptions": {
    "disabled": true
  },
  "public": true,
  "id": "db82gpat2rsc********",
  "folderId": "b1gt6g8ht345********",
  "createdAt": "2025-12-18T14:00:39.911359Z",
  "name": "search-api-mcp",
  "status": "ACTIVE",
  "baseDomain": "https://db82gpat2rsc********.58zke0qh.mcpgw.serverless.yandexcloud.net",
  "serviceAccountId": "ajegtlf2q28a********"
  },
  ...
  {
  "logOptions": {
    "disabled": false,
    "minLevel": "INFO",
    "folderId": "b1gt6g8ht345********"
  },
  "public": true,
  "id": "db85571bpn4k********",
  "folderId": "b1gt6g8ht345********",
  "createdAt": "2025-12-18T14:25:37.272591Z",
  "name": "amocrm-mcp",
  "status": "ACTIVE",
  "baseDomain": "https://db85571bpn4k********.gs2td6d8.mcpgw.serverless.yandexcloud.net",
  "networkId": "enpcfncr6uld********",
  "serviceAccountId": "ajegtlf2q28a********"
  }
]
}
```

{% endcut %}