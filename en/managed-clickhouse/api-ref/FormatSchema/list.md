---
editable: false
sourcePath: en/_api-ref/mdb/clickhouse/v1/api-ref/FormatSchema/list.md
---

# Managed Service for ClickHouse API, REST: FormatSchema.list
Returns a list of format schemas in a cluster.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}/formatSchemas
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ClickHouse cluster ID.</p> <p>To get a ClickHouse cluster ID, use the <a href="/docs/managed-clickhouse/api-ref/Cluster/list">list</a> method.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of the results is larger than <a href="/docs/managed-clickhouse/api-ref/FormatSchema/list#query_params">pageSize</a>, the service returns <a href="/docs/managed-clickhouse/api-ref/FormatSchema/list#responses">nextPageToken</a>. You can use it to get the next page of the results in subsequent requests of a format schema list.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/managed-clickhouse/api-ref/FormatSchema/list#query_params">pageToken</a> to the <a href="/docs/managed-clickhouse/api-ref/FormatSchema/list#responses">nextPageToken</a> returned by the previous format schema list request.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "formatSchemas": [
    {
      "name": "string",
      "clusterId": "string",
      "type": "string",
      "uri": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
formatSchemas[] | **object**<br><p>List of format schemas.</p> 
formatSchemas[].<br>name | **string**<br><p>Format schema name.</p> 
formatSchemas[].<br>clusterId | **string**<br><p>ClickHouse cluster ID.</p> 
formatSchemas[].<br>type | **string**<br><p>Schema type. Possible values are the following:</p> <ul> <li>FORMAT_SCHEMA_TYPE_PROTOBUF - <a href="https://protobuf.dev/">Protobuf</a> data format (including <a href="https://clickhouse.com/docs/en/interfaces/formats#protobufsingle">ProtobufSingle</a>).</li> <li>FORMAT_SCHEMA_TYPE_CAPNPROTO - <a href="https://capnproto.org/">Cap'n Proto</a> data format.</li> </ul> 
formatSchemas[].<br>uri | **string**<br><p>Link to the file of a format schema in Yandex Object Storage. Managed Service for ClickHouse works only with format schemas imported to Object Storage.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results when requesting the format schema list. If the number of the results is larger than <a href="/docs/managed-clickhouse/api-ref/FormatSchema/list#query_params">pageSize</a>, use the <a href="/docs/managed-clickhouse/api-ref/FormatSchema/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-clickhouse/api-ref/FormatSchema/list#query_params">pageToken</a> parameter in the next request. Each subsequent request will have its own <a href="/docs/managed-clickhouse/api-ref/FormatSchema/list#responses">nextPageToken</a> to continue paging through the results.</p> 