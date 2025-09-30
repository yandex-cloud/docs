---
title: How to send a request to a {{ ml-platform-full-name }} node
description: Follow this guide to send a request to a node.
---

# Sending a request to a node

{% include [models-node-request](../../../_includes/datasphere/models-node-request.md) %}

Requests to the node can be submitted by users and [service accounts](../../../iam/concepts/users/service-accounts.md) with the minimum project role of `{{ roles-datasphere-project-developer }}`. The service account must reside in the same folder as the node.

{% list tabs %}

- {{ ml-platform-full-name }} interface

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

- gRPC API

  ```bash
  grpcurl \
     --header "x-node-id: <node_ID>" \
     --header "Authorization: Bearer <IAM_token>" \
     --header "x-folder-id: <folder_ID>" \
     --data '<input_variables>' \
     {{ ds-node-endpoint }}:443
  ```
  
  Where:
  
  * `<node_ID`: Node ID.
  * `<IAM_token>`: [IAM token](../../../iam/concepts/authorization/iam-token.md) used for authentication.
  * `<folder_ID>`: ID of the folder where the project and node were created.
  * `<input_variables>`: Object in `{"a":2,"b":3}` format where keys match input variables.
  
  The successful response will return an object:
  
  ```json
  {
     "output": {
        <output_variables>
     }
  }
  ```

  Where `<output_variables>` is the object where keys match output variables.

- REST API

  You can use [cURL](https://curl.se) to send REST requests.
  
  ```bash
  curl \
     --header "x-node-id: <node_ID>" \
     --header "Authorization: Bearer <IAM_token>" \
     --header "x-folder-id: <folder_ID>" \
     --request <method> \
     --data '<input_variables>' \
     https://{{ ds-node-endpoint }}/
  ```
  
  Where:
  
  * `<node_ID>`: Node ID.
  * `<IAM_token>`: IAM token used for authentication.
  * `<folder_ID>`: ID of the folder where the project and node were created.
  * `<request_type>`: Type of HTTP request.
  * `<input_variables>`: Object in `{"a":2,"b":3}` format where keys match input variables.
  
  The response returns a JSON object with output variables.

{% endlist %}