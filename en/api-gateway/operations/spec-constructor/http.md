---
title: "Adding the HTTP Access extension"
description: "Follow this guide to add the HTTP Access extension using the specification constructor."
---

# Adding the x-yc-apigateway-integration:http extension

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) in which you created or want to create an [API gateway](../../concepts/index.md).
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
   1. Select an API gateway or click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}** to create a new one.
   1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** field, click ![image](../../../_assets/api-gateway/spec-constructor/http.svg).
   1. Specify the following in the field:

      {% include [common-spec-constructor](../../../_includes/api-gateway/common-spec-constructor.md) %}

      * **URL**: URL to redirect the invocation to. It must be accessible from the internet.
      * (Optional) **Method**: HTTP method to be used for the invocation. If you skip this parameter, the method specified in the **HTTP method** field will be used.
      * (Optional) **HTTP headers**: HTTP headers to be provided in the request.

         Enable the **Send HTTP headers of the original request** option. By default, the HTTP headers of the original request are not sent.

      * (Optional) **Query parameters**: Query parameters to be provided in the request.

         Enable the **Send query parameters of the original request** option. By default, the query parameters of the original request are not sent.

      * (Optional) **Read timeout**: Invocation read timeout in seconds.
      * (Optional) **Connection timeout**: Connection timeout for the invocation in seconds.
   1. (Optional) Enable the **Do not send empty headers** option. By default, empty headers are sent.
   1. (Optional) Enable the **Do not send empty query parameters**. By default, empty query parameters are sent.
   1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [constructor-result](../../../_includes/api-gateway/constructor-result.md) %}

## See also {#see-also}

* [x-yc-apigateway-integration:http extension](../../concepts/extensions/http.md)
