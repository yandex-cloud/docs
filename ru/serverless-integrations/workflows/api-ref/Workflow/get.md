---
editable: false
sourcePath: en/_api-ref/serverless/workflows/v1/workflows/api-ref/Workflow/get.md
---

# Workflows Service, REST: Workflow.get
Retrieves specified Workflow.
 

 
## HTTP request {#https-request}
```
GET https://serverless-workflows.{{ api-host }}/workflows/v1/workflow/{workflowId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
workflowId | <p>Required. ID of the Workflow.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "workflow": {
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

      // `workflow.logOptions` includes only one of the fields `logGroupId`, `folderId`
      "logGroupId": "string",
      "folderId": "string",
      // end of the list of possible fields`workflow.logOptions`

    },
    "networkId": "string",
    "serviceAccountId": "string"
  }
}
```

 
Field | Description
--- | ---
workflow | **object**<br><p>Workflow properties.</p> 
workflow.<br>id | **string**<br><p>ID of the Workflow. Generated at creation time.</p> 
workflow.<br>folderId | **string**<br><p>ID of the folder that the Workflow belongs to.</p> 
workflow.<br>specification | **object**<br><p>Specification of the Workflow</p> 
workflow.<br>specification.<br>specYaml | **string**<br><p>Workflow specification in YAML format.</p> 
workflow.<br>createdAt | **string** (date-time)<br><p>Creation timestamp for the Workflow.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
workflow.<br>name | **string**<br><p>Name of the Workflow. The name is unique within the folder.</p> 
workflow.<br>description | **string**<br><p>Description of the Workflow.</p> 
workflow.<br>labels | **object**<br><p>Workflow labels as ``key:value`` pairs.</p> 
workflow.<br>status | **string**<br><p>Status of the Workflow.</p> <ul> <li>CREATING: Workflow is being created.</li> <li>ACTIVE: Workflow is ready for use.</li> <li>UPDATING: Workflow is being updated.</li> <li>DELETING: Workflow is being deleted.</li> <li>ERROR: Workflow failed. The only allowed action is delete.</li> </ul> 
workflow.<br>logOptions | **object**<br><p>Options for logging from the Workflow.</p> 
workflow.<br>logOptions.<br>disabled | **boolean** (boolean)<br><p>Is logging from Workflow disabled.</p> 
workflow.<br>logOptions.<br>minLevel | **string**<br>Minimum logs level.  See [LogLevel.Level] for details.<br><ul> <li> <p>TRACE: Trace log level.</p> <p>Possible use case: verbose logging of some business logic.</p> </li> <li> <p>DEBUG: Debug log level.</p> <p>Possible use case: debugging special cases in application logic.</p> </li> <li> <p>INFO: Info log level.</p> <p>Mostly used for information messages.</p> </li> <li> <p>WARN: Warn log level.</p> <p>May be used to alert about significant events.</p> </li> <li> <p>ERROR: Error log level.</p> <p>May be used to alert about errors in infrastructure, logic, etc.</p> </li> <li> <p>FATAL: Fatal log level.</p> <p>May be used to alert about unrecoverable failures and events.</p> </li> </ul> 
workflow.<br>logOptions.<br>logGroupId | **string** <br>`workflow.logOptions` includes only one of the fields `logGroupId`, `folderId`<br><br><p>ID of the logging group which should be used for Workflows logs.</p> 
workflow.<br>logOptions.<br>folderId | **string** <br>`workflow.logOptions` includes only one of the fields `logGroupId`, `folderId`<br><br><p>ID of the folder which default logging group should be used for Workflows.</p> 
workflow.<br>networkId | **string**<br><p>ID of the VPC network Workflow will be executed in, in order to access private resources.</p> 
workflow.<br>serviceAccountId | **string**<br><p>ID of the Service Account which will be used for resource access in Workflow execution.</p> 