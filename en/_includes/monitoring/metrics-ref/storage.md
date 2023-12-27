Common labels for all {{ objstorage-short-name }} metrics:

| Label | Value |
----|----
| service | Service ID: `storage` |
| resource_id | [Bucket](../../../storage/concepts/bucket.md) name |
| resource_type | Resource type: `bucket` |

Service metrics:

| Name<br>Type, units | Description |
| --- | --- |
| `max_size`<br/>`DGAUGE`, bytes | Maximum bucket size. The metric is available if the bucket settings has a limit on the maximum size specified. |
| `object_count`<br/>`DGAUGE`, number | Number of bucket [objects](../../../storage/concepts/object.md). Special `object_type` label: Type of the object.<br/>The possible values include:<br/><ul><li>`MultiPart`: Objects uploaded [in parts](../../../storage/concepts/multipart.md) (multipart uploads).</li><li>`Parts`: Parts of objects uploaded in parts.</li><li>`Simple`: Objects uploaded without being split into parts.</li></ul> |
| `rps`<br/>`DGAUGE`, requests/s | Number of requests per second. Special `method` label: Operation type.<br/>The possible values include:<br/><ul><li>`GetRequests`: `GET`</li><li>`HeadRequests`: `HEAD`</li><li>`ListRequests`: `LIST`</li><li>`OptionsRequests`: `OPTIONS`</li><li>`PutRequests`: `PUT`</li><li>`PostRequests`: `POST`</li><li>`DeleteRequests`: `DELETE`</li></ul> |
| `space_usage`<br/>`DGAUGE`, bytes | Storage used.<br/>Special labels:<br/><ul><li>`object_type`: Type of the object. The possible values include:<ul><li>`MultiPart`: Objects uploaded in parts (multipart uploads).</li><li>`Parts`: Parts of objects uploaded in parts.</li><li>`Simple`: Objects uploaded without being split into parts.</li></ul></li><li>`storage_type`: [Storage class](../../../storage/concepts/storage-class.md). The possible values include:<ul><li>`All`: All classes</li><li>`ColdStorage`: Cold</li><li>`IceStorage`: Ice</li><li>`StandardStorage`: Standard</li></ul></ul> |
| `traffic`<br/>`DGAUGE`, bytes | Amount of traffic. Special `bytes` label: Traffic direction relative to the storage.<br/>The possible values include:<br/><ul><li>`BytesDownloaded`: Outgoing</li><li>`BytesUploaded`: Incoming</li></ul> |