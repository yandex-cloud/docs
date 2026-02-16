```http request
GET http://169.254.169.254/computeMetadata/v1/instance/
  ? alt=<json|text>
  & recursive=<true|false>
  & wait_for_change=<true|false>
  & last_etag=<string>
  & timeout_sec=<int>
Metadata-Flavor: Google
```

Where:
* `alt`: Response format. The default value is `text`.
* `recursive`: If `true`, it returns all values in the tree recursively. The default value is `false`.
* `wait_for_change`: If `true`, this response will be returned only when one of the metadata parameters is modified. The default value is `false`.
* `last_etag`: ETag from the previous response to a similar request. Use if `wait_for_change="true"`.
* `timeout_sec`: Maximum request timeout. Use if `wait_for_change="true"`.

In response, the service will return the current values ​​of the `computeMetadata` folder metadata [keys](../../../compute/concepts/metadata/directories.md#dir-compute).