---
editable: false
sourcePath: en/_api-ref/serverless/workflows/v1/workflows/api-ref/Workflow/index.md
---

# Workflows Service, REST: Workflow methods
Set of methods for managing Workflows.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "specification": {
    "specYaml": "string"
  },
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "status": "string",
  "logOptions": {
    "disabled": true,
    "minLevel": "string",

    // `logOptions` includes only one of the fields `logGroupId`, `folderId`
    "logGroupId": "string",
    "folderId": "string",
    // end of the list of possible fields`logOptions`

  },
  "networkId": "string",
  "serviceAccountId": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the Workflow. Generated at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the Workflow belongs to.</p> 
specification | **object**<br><p>Specification of the Workflow</p> 
specification.<br>specYaml | **string**<br><p>Workflow specification in YAML format.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp for the Workflow.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the Workflow. The name is unique within the folder.</p> 
description | **string**<br><p>Description of the Workflow.</p> 
labels | **object**<br><p>Workflow labels as ``key:value`` pairs.</p> 
status | **string**<br><p>Status of the Workflow.</p> <ul> <li>CREATING: Workflow is being created.</li> <li>ACTIVE: Workflow is ready for use.</li> <li>UPDATING: Workflow is being updated.</li> <li>DELETING: Workflow is being deleted.</li> <li>ERROR: Workflow failed. The only allowed action is delete.</li> </ul> 
logOptions | **object**<br><p>Options for logging from the Workflow.</p> 
logOptions.<br>disabled | **boolean** (boolean)<br><p>Is logging from Workflow disabled.</p> 
logOptions.<br>minLevel | **string**<br>Minimum logs level.  See [LogLevel.Level] for details.<br><ul> <li> <p>TRACE: Trace log level.</p> <p>Possible use case: verbose logging of some business logic.</p> </li> <li> <p>DEBUG: Debug log level.</p> <p>Possible use case: debugging special cases in application logic.</p> </li> <li> <p>INFO: Info log level.</p> <p>Mostly used for information messages.</p> </li> <li> <p>WARN: Warn log level.</p> <p>May be used to alert about significant events.</p> </li> <li> <p>ERROR: Error log level.</p> <p>May be used to alert about errors in infrastructure, logic, etc.</p> </li> <li> <p>FATAL: Fatal log level.</p> <p>May be used to alert about unrecoverable failures and events.</p> </li> </ul> 
logOptions.<br>logGroupId | **string** <br>`logOptions` includes only one of the fields `logGroupId`, `folderId`<br><br><p>ID of the logging group which should be used for Workflows logs.</p> 
logOptions.<br>folderId | **string** <br>`logOptions` includes only one of the fields `logGroupId`, `folderId`<br><br><p>ID of the folder which default logging group should be used for Workflows.</p> 
networkId | **string**<br><p>ID of the VPC network Workflow will be executed in, in order to access private resources.</p> 
serviceAccountId | **string**<br><p>ID of the Service Account which will be used for resource access in Workflow execution.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates Workflow in specified folder.
[delete](delete.md) | Deletes specified Workflow.
[get](get.md) | Retrieves specified Workflow.
[list](list.md) | Retrieves list of Workflows in specified folder.
[listOperations](listOperations.md) | Lists operations for specified Workflow.
[update](update.md) | Updates specified Workflow.