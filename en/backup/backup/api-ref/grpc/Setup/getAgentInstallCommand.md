---
editable: false
---

# Cloud Backup API, gRPC: SetupService.GetAgentInstallCommand

## gRPC request

**rpc GetAgentInstallCommand ([GetAgentInstallCommandRequest](#yandex.cloud.backup.v1.GetAgentInstallCommandRequest)) returns ([GetAgentInstallCommandResponse](#yandex.cloud.backup.v1.GetAgentInstallCommandResponse))**

## GetAgentInstallCommandRequest {#yandex.cloud.backup.v1.GetAgentInstallCommandRequest}

```json
{
  "folder_id": "string",
  "type": "AgentInstallCommandType",
  "policy_ids": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ||
|| type | enum **AgentInstallCommandType**

Required field.

- `AGENT_INSTALL_BASH_EXTERNAL_VM`
- `AGENT_INSTALL_BASH_EXTERNAL_SERVER` ||
|| policy_ids[] | **string** ||
|#

## GetAgentInstallCommandResponse {#yandex.cloud.backup.v1.GetAgentInstallCommandResponse}

```json
{
  "command": "string"
}
```

#|
||Field | Description ||
|| command | **string** ||
|#