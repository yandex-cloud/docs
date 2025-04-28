The `name` label contains the metric name.

Labels shared by all {{ objstorage-short-name }} metrics:

Label | Value
----|----
service | Service ID: `storage`
resource_id |  [Bucket](../../../storage/concepts/bucket.md) name
resource_type | Resource type: `bucket`

Service metrics:

| Name<br>Type, units | Description |
| --- | --- |
`max_size`<br/>`DGAUGE`, bytes | Maximum bucket size. The metric is available if a maximum size is configured for the bucket.
`object_count`<br/>`DGAUGE`, count | Number of bucket [objects](../../../storage/concepts/object.md). This metric features the `object_type` label containing the object type.<br/>The possible values include:<br/><ul><li>`MultiPart`: Objects uploaded using [multipart](../../../storage/concepts/multipart.md) upload.</li><li>`Parts`: Parts of objects uploaded using multipart upload.</li><li>`Simple`: Objects uploaded using single-part upload.</li></ul>
`rps`<br/>`DGAUGE`, requests per second | Number of requests per second. This metric features the `method` special label containing the operation type.<br/>The possible values include:<br/><ul><li>`GetRequests`: `GET`</li><li>`HeadRequests`: `HEAD`</li><li>`ListRequests`: `LIST`</li><li>`OptionsRequests`: `OPTIONS`</li><li>`PutRequests`: `PUT`</li><li>`PostRequests`: `POST`</li><li>`DeleteRequests`: `DELETE`</li></ul>
`space_usage`<br/>`DGAUGE`, bytes | Storage used.<br/>Special labels:<br/><ul><li>`object_type`: Object type, which can have the following values:<ul><li>`MultiPart`: Objects uploaded using multipart upload.</li><li>`Parts`: Parts of objects uploaded using multipart upload.</li><li>`Simple`: Objects uploaded using single-part upload.</li></ul></li><li>`storage_type`: [Storage class](../../../storage/concepts/storage-class.md). The possible values are:<ul><li>`All`</li><li>`ColdStorage`</li><li>`IceStorage`</li><li>`StandardStorage`</li></ul></ul>
`traffic`<br/>`DGAUGE`, bytes | Traffic size. This metric features the `bytes` special label containing traffic direction relative to the storage.<br/>The possible values include:<br/><ul><li>`BytesDownloaded`: Outbound.</li><li>`BytesUploaded`: Inbound.</li></ul>