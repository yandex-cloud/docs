---
title: How to send a request to an alias in {{ ml-platform-full-name }}
description: Follow this guide to send a request to an alias.
---

# Sending a request to an alias

{% include [models-node-request](../../../_includes/datasphere/models-node-request.md) %}

All users logged into {{ yandex-cloud }} can send requests to a public alias. To send a request to a private alias, the following roles are required:

* For users, the minimum role in the project is `{{ roles-datasphere-project-developer }}`.
* Service accounts need the `{{ roles-datasphere-project-developer }}` role in the project; or else the service account must reside in the folder specified when creating the alias.

{% list tabs %}

- {{ ml-platform-full-name }} interface

  The type of a request to an [alias](../../concepts/deploy/index.md#alias) depends on your [node](../../concepts/deploy/index.md#node). You can send a test request in the interface if you expect the response to contain simple data, such as numbers or string variables.
  
  1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
  1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, select **{{ ui-key.yc-ui-datasphere.common.alias }}**.
  1. Select the alias to send the request to.
  1. Go to the **{{ ui-key.yc-ui-datasphere.node-page.tab.request }}** tab.
  1. Under **{{ ui-key.yc-ui-datasphere.node-page.request.create-test-request }}**:
     * In the **Method** field, select the request type.
     * In the **{{ ui-key.yc-ui-datasphere.common.input }}** field, enter the request input variables in `{"a":2,"b":3}` format and click **{{ ui-key.yc-ui-datasphere.common.execute }}**.
  1. View the request processing results under **{{ ui-key.yc-ui-datasphere.common.response }}**.
  
  {% note info %}
  
  The **{{ ui-key.yc-ui-datasphere.node-page.request.curl }}** section contains examples of requests to an alias for `cURL` and `gRPCurl`.
  
  {% endnote %}

- gRPC API

  You can use [gRPCurl](https://github.com/fullstorydev/grpcurl) to make gRPC calls.
  
  ```bash
  grpcurl \
     --header "x-node-alias: datasphere.user.<alias_name>" \
     --header "Authorization: Bearer <IAM_token>" \
     --header "x-folder-id: <folder_ID>" \
     --data '<input_variables>' \
     {{ ds-node-endpoint }}:443
  ```
  
  Where:
  
  * `<alias_name>`: Alias name.
  * `<IAM_token>`: [IAM token](../../../iam/concepts/authorization/iam-token.md) used for authentication.
  * `<folder_ID>`: ID of the folder where the project and the alias were created.
  * `<input_variables>`: Object in `{"a":2,"b":3}` format where keys match input variables.
  
  The successful response will return an object:
  
  ```json
  {
     "output": {
        <output_variables>
     }
  }
  ```

- REST API

  You can use [cURL](https://curl.se) to send REST requests.
  
  ```bash
  curl \
     --header "x-node-alias: datasphere.user.<alias_name>" \
     --header "Authorization: Bearer <IAM_token>" \
     --header "x-folder-id: <folder_ID>" \
     --request <request_type> \
     --data '<input_variables>' \
     https://{{ ds-node-endpoint }}/
  ```
  
  Where:
  
  * `<alias_name>`: Alias name.
  * `<IAM_token>`: IAM token used for authentication.
  * `<folder_ID>`: ID of the folder where the project and the alias were created.
  * `<request_type>`: Type of HTTP request.
  * `<input_variables>`: Object in `{"a":2,"b":3}` format where keys match input variables.
  
  The response returns a JSON object with output variables.

{% endlist %}