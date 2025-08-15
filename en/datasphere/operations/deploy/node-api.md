---
title: How to send a request to a node in {{ ml-platform-full-name }}
description: Follow this guide to send a request to a node.
---

# Sending a request to a node

Send a test request to a [node](../../concepts/deploy/index.md#node) from the {{ ml-platform-name }} interface:
1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, select **{{ ui-key.yc-ui-datasphere.resources.node }}**.
1. Select the node to send the request to.
1. Go to the **{{ ui-key.yc-ui-datasphere.node-page.tab.request }}** tab.
1. Under **{{ ui-key.yc-ui-datasphere.node-page.request.create-test-request }}**, in the **{{ ui-key.yc-ui-datasphere.common.input }}** field, enter the request input variables in `{"a":2,"b":3}` format and click **{{ ui-key.yc-ui-datasphere.common.execute }}**.
1. View the request processing results under **{{ ui-key.yc-ui-datasphere.common.response }}**.

{% note info %}

The **{{ ui-key.yc-ui-datasphere.node-page.request.curl }}** section contains examples of requests to a node for `cURL` and `gRPCurl`.

The **{{ ui-key.yc-ui-datasphere.node-page.request.server-response }}** section provides sample code and node response descriptions.

{% endnote %}

To send requests to nodes, you need the `{{ roles-datasphere-user }}` or `{{ roles-datasphere-admin }}` [role](../../security/index.md) for the folder where the project and node were created.

## Example of a gRPC API call {#grpc-call-example}

```bash
grpcurl \
  -H "Authorization: Bearer <IAM_token>" \
  -d '{
  "folder_id": "<folder_ID>",
  "node_id": "<node_ID>",
  "input": { <input_variables> } \
  }' \
  datasphere.{{ api-host }}:443
yandex.cloud.datasphere.v1.NodeService/Execute
```

Where:

* `<IAM_token>`: [IAM token](../../../iam/concepts/authorization/iam-token.md) used for authentication.
* `<folder_ID>`: ID of the folder where the project and node were created.
* `<node_ID>: Node ID.
* `<input_variables>`: Object where keys match input variables.

The successful response will return an object:

```json
{
   "output": {
      <output_variables>
   }
}
```

Where `<output_variables>` is the object where keys match output variables.

## Example of a REST API request {#rest-query-example}

You can use [cURL](https://curl.se) to send REST requests.

```bash
curl https://datasphere.{{ api-host }}/datasphere/v1/nodes/<node_ID>:execute \
   --request POST \
   --header "Authorization: Bearer <IAM_token>"
   --data '{
      "folder_id": "<folder_ID>",
      "node_id": "<node_ID>",
      "input": { <input_variables> }
   }'
```

Where:

* `<IAM_token>`: IAM token used for authentication.
* `<folder_ID>`: ID of the folder where the project and node were created.
* `<node_ID>`: Node ID.
* `<input_variables>`: Object where keys match input variables.

The response returns a JSON object with output variables.
