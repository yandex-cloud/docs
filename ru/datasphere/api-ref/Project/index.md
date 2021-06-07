---
editable: false
---

# Project
A set of methods for managing Project resources.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "settings": {
    "serviceAccountId": "string",
    "subnetId": "string",
    "dataProcClusterId": "string",
    "commitMode": "string"
  }
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the project.</p> 
folderId | **string**<br><p>ID of the folder that the project belongs to.</p> 
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the project. 1-63 characters long.</p> 
description | **string**<br><p>Description of the project. 0-256 characters long.</p> 
settings | **object**<br><p>Settings of the project.</p> 
settings.<br>serviceAccountId | **string**<br><p>ID of the service account, on whose behalf all operations with clusters will be performed.</p> 
settings.<br>subnetId | **string**<br><p>ID of the subnet where the DataProc cluster resides. Currently only subnets created in the availability zone ru-central1-a are supported.</p> 
settings.<br>dataProcClusterId | **string**<br><p>ID of the DataProc cluster.</p> 
settings.<br>commitMode | **string**<br><p>Commit mode that is assigned to the project.</p> <ul> <li>STANDARD: Commit happens after the execution of a cell or group of cells or after completion with an error.</li> <li>AUTO: Commit happens periodically. Also, automatic saving of state occurs when switching to another type of computing resource.</li> </ul> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a project in the specified folder.
[delete](delete.md) | Deletes the specified project.
[get](get.md) | Returns the specified project.
[list](list.md) | Lists projects for the specified folder.
[open](open.md) | Opens the specified project.
[update](update.md) | Updates the specified project.