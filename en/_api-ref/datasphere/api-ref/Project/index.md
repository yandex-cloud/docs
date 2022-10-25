---
editable: false
---

# Project
A set of methods for managing Project resources.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "createdById": "string",
  "settings": {
    "serviceAccountId": "string",
    "subnetId": "string",
    "dataProcClusterId": "string",
    "commitMode": "string",
    "securityGroupIds": [
      "string"
    ],
    "earlyAccess": true,
    "ide": "string",
    "defaultFolderId": "string",
    "staleExecTimeoutMode": "string"
  },
  "limits": {
    "maxUnitsPerHour": "integer",
    "maxUnitsPerExecution": "integer"
  },
  "zoneId": "string",
  "communityId": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the project.</p> 
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the project. 1-63 characters long.</p> 
description | **string**<br><p>Description of the project. 0-256 characters long.</p> 
labels | **object**
createdById | **string**
settings | **object**<br><p>Settings of the project.</p> 
settings.<br>serviceAccountId | **string**<br><p>ID of the service account, on whose behalf all operations with clusters will be performed.</p> 
settings.<br>subnetId | **string**<br><p>ID of the subnet where the DataProc cluster resides. Currently only subnets created in the availability zone ru-central1-a are supported.</p> 
settings.<br>dataProcClusterId | **string**<br><p>ID of the DataProc cluster.</p> 
settings.<br>commitMode | **string**<br><p>Commit mode that is assigned to the project.</p> <ul> <li>STANDARD: Commit happens after the execution of a cell or group of cells or after completion with an error.</li> <li>AUTO: Commit happens periodically. Also, automatic saving of state occurs when switching to another type of computing resource.</li> </ul> 
settings.<br>securityGroupIds[] | **string**<br><p>Network interfaces security groups.</p> 
settings.<br>earlyAccess | **boolean** (boolean)<br><p>Is early access preview enabled for the project.</p> 
settings.<br>ide | **string**<br><p>Project IDE.</p> <ul> <li>JUPYTER_LAB: Project running on JupyterLab IDE.</li> </ul> 
settings.<br>defaultFolderId | **string**<br><p>Default project folder ID.</p> 
settings.<br>staleExecTimeoutMode | **string**<br><p>Timeout to automatically stop stale executions.</p> <ul> <li>ONE_HOUR: Setting to automatically stop stale execution after one hour with low consumption.</li> <li>THREE_HOURS: Setting to automatically stop stale execution after three hours with low consumption.</li> <li>NO_TIMEOUT: Setting to never automatically stop stale executions.</li> </ul> 
limits | **object**<br><p>Limits of the project.</p> 
limits.<br>maxUnitsPerHour | **integer** (int64)<br><p>The number of units that can be spent per hour.</p> 
limits.<br>maxUnitsPerExecution | **integer** (int64)<br><p>The number of units that can be spent on the one execution.</p> 
zoneId | **string**<br><p>ID of the zone that the project belongs to.</p> 
communityId | **string**<br><p>ID of the community that the project belongs to.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a project in the specified folder.
[delete](delete.md) | Deletes the specified project.
[execute](execute.md) | Executes code in the specified cell or notebook.
[get](get.md) | Returns the specified project.
[getCellOutputs](getCellOutputs.md) | Returns outputs of the specified cell.
[getStateVariables](getStateVariables.md) | Returns state variables of the specified notebook.
[getUnitBalance](getUnitBalance.md) | Returns the unit balance of the specified project.
[list](list.md) | Lists projects for the specified community.
[listAccessBindings](listAccessBindings.md) | Lists access bindings for the project.
[listResources](listResources.md) | Lists project resources.
[listSharedResources](listSharedResources.md) | Lists shared resources of the project.
[open](open.md) | Opens the specified project.
[setAccessBindings](setAccessBindings.md) | Sets access bindings for the project.
[setUnitBalance](setUnitBalance.md) | Sets the unit balance of the specified project.
[stop](stop.md) | Stops the specified project.
[update](update.md) | Updates the specified project.
[updateAccessBindings](updateAccessBindings.md) | Updates access bindings for the project.