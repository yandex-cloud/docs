# Sending requests to nodes

Send a test request to a node from the {{ ml-platform-name }} interface:
1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **Resources**, select **Node**.
1. Select the node to send a request to.
1. Go to the **Request** tab.
1. Under **Create test request**, in the **Input** field, enter the request input variables in `{"a":2,"b":3}` format and click **Execute**.
1. View the request processing results under **Response**.

{% note info %}

The **Command line requests** section contains sample requests to nodes for the cURL and gRPCurl utilities.

The **Server response** section provides sample code and node response descriptions.

{% endnote %}

To send requests to nodes, you must have the {{ roles-datasphere-user }} or {{ roles-datasphere-admin }} role for the folder where the project and node were created.

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