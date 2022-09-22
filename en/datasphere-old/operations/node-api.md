# Requests to nodes created from a cell with Python code

To send requests to nodes, you must have the {{ roles-datasphere-user }} or {{ roles-datasphere-admin }} role for the folder where the project and node were created.

{% include [datasphere-api-auth](../../_includes/datasphere/datasphere-api-auth.md) %}

## Sample gRPC API requests

```bash
grpcurl -H "Authorization: Bearer <iam_token>" \
  -d '{
  "folder_id": "<folder_id>",
  "node_id": "<node_id>",
  "input": { <input_variables> } \
  }' \
  datasphere.{{ api-host }}:443
yandex.cloud.datasphere.v1.NodeService/Execute
```

* `<iam_token>`: The IAM token used for authentication.
* `<folder_id>`: The ID of the folder where you created the project and node.
* `<node_id>`: The Node ID.
* `<input_variables>`: The object in which keys correspond to your input variables.

In a successful response, the object is returned:

```
{
   "output": {
      <output_variables>
   }
}
```

* `output_variables`: The object in which keys correspond to output variables.

## Sample REST API requests

You can use the [cURL](https://curl.se) utility to send REST requests.

```bash
curl https://datasphere.{{ api-host }}/datasphere/v1/nodes/<node_id>:execute \
   -X POST \
   -H "Authorization: Bearer <iam_token>"
   -d '{
      "folder_id": "<folder_id>",
      "node_id": "<node_id>",
      "input": { <input_variables> }
   }'
```

* `<iam_token>`: The IAM token used for authentication.
* `<folder_id>`: The ID of the folder where you created the project and node.
* `<node_id>`: The Node ID.
* `<input_variables>`: The object in which keys correspond to your input variables.

The response returns a JSON object with output variables.