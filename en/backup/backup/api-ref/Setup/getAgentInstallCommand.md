---
editable: false
apiPlayground:
  - url: https://backup.{{ api-host }}/backup/v1/setup/getAgentInstallCommand
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field.
          type: string
        type:
          description: |-
            **enum** (AgentInstallCommandType)
            Required field.
            - `AGENT_INSTALL_BASH_EXTERNAL_VM`
            - `AGENT_INSTALL_BASH_EXTERNAL_SERVER`
          type: string
          enum:
            - AGENT_INSTALL_COMMAND_TYPE_UNSPECIFIED
            - AGENT_INSTALL_BASH_EXTERNAL_VM
            - AGENT_INSTALL_BASH_EXTERNAL_SERVER
        policyIds:
          description: '**string**'
          type: array
          items:
            type: string
      required:
        - folderId
        - type
      additionalProperties: false
    definitions: null
---

# Cloud Backup API, REST: Setup.GetAgentInstallCommand

## HTTP request

```
POST https://backup.{{ api-host }}/backup/v1/setup/getAgentInstallCommand
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