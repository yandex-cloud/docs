---
title: How to send a request to an alias in {{ ml-platform-full-name }}
description: Follow this guide to send a request to an alias.
---

# Sending a request to an alias

The type of a request to an [alias](../../concepts/deploy/index.md#alias) depends on your [node](../../concepts/deploy/index.md#node). You can send a test request in the interface if you expect the response to contain simple data, such as numbers or string variables.

Send the test request to the alias from the {{ ml-platform-name }} interface:

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, select **{{ ui-key.yc-ui-datasphere.common.alias }}**.
1. Select the alias to send the request to.
1. Go to the **{{ ui-key.yc-ui-datasphere.node-page.tab.request }}** tab.
1. Under **{{ ui-key.yc-ui-datasphere.node-page.request.create-test-request }}**:
   * In the **Method** field, select the request type.
   * In the **{{ ui-key.yc-ui-datasphere.common.input }}** field, enter the request input variables in `{"a":2,"b":3}` format and click **{{ ui-key.yc-ui-datasphere.common.execute }}**.
1. View the request processing results under **{{ ui-key.yc-ui-datasphere.common.response }}**.

{% note info %}

The **{{ ui-key.yc-ui-datasphere.node-page.request.curl }}** section contains sample requests to an alias for the cURL and gRPCurl utilities.

{% endnote %}

To send requests to aliases, you must have the `{{ roles-datasphere-user }}` or `{{ roles-datasphere-admin }}` role for the folder where the project and the alias were created.

## Sample gRPC API call {#grpc-call-example}

You can use the [gRPCurl](https://github.com/fullstorydev/grpcurl) utility to make gRPC calls.

```bash
grpcurl \
  -H "Authorization: Bearer <IAM_token>" \
  -d '{
  "folder_id": "<folder_ID>",
  "alias_name": "<alias_name>",
  "input": { <input_variables> } \
  }' \
  datasphere.{{ api-host }}:443
yandex.cloud.datasphere.v1.NodeService/ExecuteAlias
```

Where:

* `<IAM_token>`: [IAM token](../../../iam/concepts/authorization/iam-token.md) used for authentication.
* `<folder_ID>`: ID of the folder where the project and the alias were created.
* `<alias_name>`: Alias name.
* `<input_variables>`: Object in `{"a":2,"b":3}` format where keys are mapped to input variables.

In a successful response, the object is returned:

```json
{
   "output": {
      <output_variables>
   }
}
```

## Sample REST API request {#rest-query-example}

You can use the [cURL](https://curl.se) utility to send REST requests.

```bash
curl \
   --header "x-node-alias: datasphere.user.<alias_name>" \
   --header "Authorization: Bearer <IAM_token>" \
   --header "x-folder-id: <folder_ID>" \
   --request <request_type> \
   --data '<input_variables>' \
   https://node-api.datasphere.yandexcloud.net/
```

Where:

* `<alias_name>`: Alias name.
* `<IAM_token>`: IAM token used for authentication.
* `<folder_ID>`: ID of the folder where the project and the alias were created.
* `<request_type>`: Type of the request to the alias.
* `<input_variables>`: Object in `{"a":2,"b":3}` format where keys are mapped to input variables.

The response returns a JSON object with output variables.
