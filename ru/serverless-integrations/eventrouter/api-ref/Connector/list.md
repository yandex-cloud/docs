---
editable: false
sourcePath: en/_api-ref/serverless/eventrouter/v1/eventrouter/api-ref/Connector/list.md
---

# EventRouter Service, REST: Connector.list
Retrieves the list of connectors in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://serverless-eventrouter.{{ api-host }}/eventrouter/v1/connectors
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
busId | <p>ID of the bus to list connectors in.</p> 
folderId | <p>ID of the folder to list connectors in.</p> 
pageSize | <p>The maximum number of results per response.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the ``next_page_token`` returned by a previous list request.</p> 
filter | <p>Supported fields for filter: name created_at</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "connectors": [
    {
      "id": "string",
      "busId": "string",
      "folderId": "string",
      "cloudId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "source": {

        // `connectors[].source` includes only one of the fields `dataStream`, `messageQueue`
        "dataStream": {
          "database": "string",
          "streamName": "string",
          "consumer": "string",
          "serviceAccountId": "string"
        },
        "messageQueue": {
          "queueArn": "string",
          "serviceAccountId": "string",
          "visibilityTimeout": "string",
          "batchSize": "string",
          "pollingTimeout": "string"
        },
        // end of the list of possible fields`connectors[].source`

      },
      "deletionProtection": true,
      "status": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
connectors[] | **object**<br><p>List of connectors.</p> 
connectors[].<br>id | **string**<br><p>ID of the connector.</p> 
connectors[].<br>busId | **string**<br><p>ID of the bus that the connector belongs to.</p> 
connectors[].<br>folderId | **string**<br><p>ID of the folder that the connector resides in.</p> 
connectors[].<br>cloudId | **string**<br><p>ID of the cloud that the connector resides in.</p> 
connectors[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
connectors[].<br>name | **string**<br><p>Name of the connector.</p> 
connectors[].<br>description | **string**<br><p>Description of the connector.</p> 
connectors[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> 
connectors[].<br>source | **object**<br><p>Source of the connector.</p> 
connectors[].<br>source.<br>dataStream | **object** <br>`connectors[].source` includes only one of the fields `dataStream`, `messageQueue`<br>
connectors[].<br>source.<br>dataStream.<br>database | **string**<br><p>Required. Stream database. example: /ru-central1/aoegtvhtp8ob********/cc8004q4lbo6********</p> 
connectors[].<br>source.<br>dataStream.<br>streamName | **string**<br><p>Required. Stream name, absolute or relative.</p> 
connectors[].<br>source.<br>dataStream.<br>consumer | **string**<br><p>Required. Consumer name.</p> 
connectors[].<br>source.<br>dataStream.<br>serviceAccountId | **string**<br><p>Required. Service account which has read permission on the stream.</p> 
connectors[].<br>source.<br>messageQueue | **object** <br>`connectors[].source` includes only one of the fields `dataStream`, `messageQueue`<br>
connectors[].<br>source.<br>messageQueue.<br>queueArn | **string**<br><p>Required. Queue ARN. Example: yrn:yc:ymq:ru-central1:aoe***:test</p> 
connectors[].<br>source.<br>messageQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has read access to the queue.</p> <p>The maximum string length in characters is 50.</p> 
connectors[].<br>source.<br>messageQueue.<br>visibilityTimeout | **string**<br><p>Queue visibility timeout override.</p> <p>The maximum value is 43200 seconds.</p> 
connectors[].<br>source.<br>messageQueue.<br>batchSize | **string** (int64)<br><p>Batch size for polling.</p> <p>The maximum value is 10.</p> 
connectors[].<br>source.<br>messageQueue.<br>pollingTimeout | **string**<br><p>Queue polling timeout.</p> <p>The maximum value is 20 seconds.</p> 
connectors[].<br>deletionProtection | **boolean** (boolean)<br><p>Deletion protection.</p> 
connectors[].<br>status | **string**<br><p>Status of the connector.</p> <p>Status of the connector.</p> <ul> <li>STOPPED: disabled by user</li> <li>RESOURCE_NOT_FOUND: source does not exist</li> <li>PERMISSION_DENIED: service account does not have read permission on source</li> <li>SUBJECT_NOT_FOUND: service account not found</li> </ul> 
nextPageToken | **string**<br><p>Token for getting the next page of the list of results.</p> 