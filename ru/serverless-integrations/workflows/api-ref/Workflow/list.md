---
editable: false
sourcePath: en/_api-ref/serverless/workflows/v1/workflows/api-ref/Workflow/list.md
---

# Workflows Service, REST: Workflow.list
Retrieves list of Workflows in specified folder.
 

 
## HTTP request {#https-request}
```
GET https://serverless-workflows.{{ api-host }}/workflows/v1/workflow
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list Workflows in.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than ``pageSize``, the service returns a <a href="/docs/functions/workflows/api-ref/Workflow/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>Default value: 100.</p> 
pageToken | <p>Page token. To get the next page of results, set ``pageToken`` to the <a href="/docs/functions/workflows/api-ref/Workflow/list#responses">nextPageToken</a> returned by a previous list request.</p> 
filter | <p>A filter expression that filters functions listed in the response.</p> <p>The expression must specify:</p> <ol> <li>The field name. Currently filtering can only be applied to following fields: name, created_at.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z]([-a-z0-9]{0,61}[a-z0-9])?``. Example of a filter: ``name=my-workflow``.</li> </ol> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "workflows": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "status": "string",
      "logOptions": {
        "disabled": true,
        "minLevel": "string",

        // `workflows[].logOptions` includes only one of the fields `logGroupId`, `folderId`
        "logGroupId": "string",
        "folderId": "string",
        // end of the list of possible fields`workflows[].logOptions`

      },
      "networkId": "string",
      "serviceAccountId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
workflows[] | **object**<br><p>List of Workflows.</p> 
workflows[].<br>id | **string**<br><p>ID of the Workflow. Generated at creation time.</p> 
workflows[].<br>folderId | **string**<br><p>ID of the folder that the Workflow belongs to.</p> 
workflows[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp for the Workflow.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
workflows[].<br>name | **string**<br><p>Name of the Workflow. The name is unique within the folder.</p> 
workflows[].<br>description | **string**<br><p>Description of the Workflow.</p> 
workflows[].<br>labels | **object**<br><p>Workflow labels as ``key:value`` pairs.</p> 
workflows[].<br>status | **string**<br><p>Status of the Workflow.</p> <ul> <li>CREATING: Workflow is being created.</li> <li>ACTIVE: Workflow is ready for use.</li> <li>UPDATING: Workflow is being updated.</li> <li>DELETING: Workflow is being deleted.</li> <li>ERROR: Workflow failed. The only allowed action is delete.</li> </ul> 
workflows[].<br>logOptions | **object**<br><p>Options for logging from the Workflow.</p> 
workflows[].<br>logOptions.<br>disabled | **boolean** (boolean)<br><p>Is logging from Workflow disabled.</p> 
workflows[].<br>logOptions.<br>minLevel | **string**<br>Minimum logs level.  See [LogLevel.Level] for details.<br><ul> <li> <p>TRACE: Trace log level.</p> <p>Possible use case: verbose logging of some business logic.</p> </li> <li> <p>DEBUG: Debug log level.</p> <p>Possible use case: debugging special cases in application logic.</p> </li> <li> <p>INFO: Info log level.</p> <p>Mostly used for information messages.</p> </li> <li> <p>WARN: Warn log level.</p> <p>May be used to alert about significant events.</p> </li> <li> <p>ERROR: Error log level.</p> <p>May be used to alert about errors in infrastructure, logic, etc.</p> </li> <li> <p>FATAL: Fatal log level.</p> <p>May be used to alert about unrecoverable failures and events.</p> </li> </ul> 
workflows[].<br>logOptions.<br>logGroupId | **string** <br>`workflows[].logOptions` includes only one of the fields `logGroupId`, `folderId`<br><br><p>ID of the logging group which should be used for Workflows logs.</p> 
workflows[].<br>logOptions.<br>folderId | **string** <br>`workflows[].logOptions` includes only one of the fields `logGroupId`, `folderId`<br><br><p>ID of the folder which default logging group should be used for Workflows.</p> 
workflows[].<br>networkId | **string**<br><p>ID of the VPC network Workflow will be executed in, in order to access private resources.</p> 
workflows[].<br>serviceAccountId | **string**<br><p>ID of the Service Account which will be used for resources access in Workflow execution.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/functions/workflows/api-ref/Workflow/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/functions/workflows/api-ref/Workflow/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 