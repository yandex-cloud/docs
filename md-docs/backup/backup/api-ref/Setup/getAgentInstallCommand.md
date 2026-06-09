# Cloud Backup API, REST: Setup.GetAgentInstallCommand

## HTTP request

```
POST https://backup.api.cloud.yandex.net/backup/v1/setup/getAgentInstallCommand
```

## Body parameters {#yandex.cloud.backup.v1.GetAgentInstallCommandRequest}

```json
{
  "folderId": "string",
  "type": "string",
  "policyIds": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ||
|| type | **enum** (AgentInstallCommandType)

Required field.

- `AGENT_INSTALL_BASH_EXTERNAL_VM`
- `AGENT_INSTALL_BASH_EXTERNAL_SERVER` ||
|| policyIds[] | **string** ||
|#

## Response {#yandex.cloud.backup.v1.GetAgentInstallCommandResponse}

**HTTP Code: 200 - OK**

```json
{
  "command": "string"
}
```

#|
||Field | Description ||
|| command | **string** ||
|#