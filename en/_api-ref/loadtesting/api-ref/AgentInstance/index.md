---
editable: false
---

# Load Testing API, REST: AgentInstance methods

## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "computeInstanceUpdatedAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "serviceAccountId": "string",
  "presetId": "string",
  "yandexTankVersion": "string",
  "status": "string",
  "errors": [
    "string"
  ],
  "currentJob": "string",
  "computeInstanceId": "string",
  "agentVersion": {
    "id": "string",
    "status": "string",
    "revision": "string",
    "description": "string",
    "statusComment": "string"
  }
}
```
 
Field | Description
--- | ---
id | **string**
folderId | **string**
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
computeInstanceUpdatedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**
description | **string**
labels | **object**
serviceAccountId | **string**
presetId | **string**
yandexTankVersion | **string**
status | **string**<br><p>Current status: current job, errors, Status</p> 
errors[] | **string**
currentJob | **string**
computeInstanceId | **string**<br><p>Compute Instance Id and status</p> 
agentVersion | **object**
agentVersion.<br>id | **string**
agentVersion.<br>status | **string**
agentVersion.<br>revision | **string** (int64)
agentVersion.<br>description | **string**
agentVersion.<br>statusComment | **string**

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates the agent instance in specified folder
[delete](delete.md) | Deletes the specified agent instance
[get](get.md) | Returns the specified agent instance
[list](list.md) | Retrieves the list of agent instances in the specified folder
[restart](restart.md) | Restarts the specified agent instance.
[start](start.md) | Starts the specified agent instance.
[stop](stop.md) | Stops the specified agent instance.
[upgradeImage](upgradeImage.md) | Upgrades the specified agent instance to the latest agent image.