---
title: Adding the Static Response extension
description: Follow this guide to add the Static Response extension using the specification constructor.
---

# Adding the x-yc-apigateway-integration:dummy extension

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) in which you created or want to create an [API gateway](../../concepts/index.md).
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
   1. Select an API gateway or click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}** to create a new one.
   1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** field, click ![image](../../../_assets/api-gateway/spec-constructor/dummy.svg).
   1. Specify the following in the field:

      {% include [common-spec-constructor](../../../_includes/api-gateway/common-spec-constructor.md) %}

      * **HTTP response code**: HTTP response code.
      * (Optional) **HTTP headers**: List of headers to be sent in response.
      * **Data**: Data to be sent in response.
   1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [constructor-result](../../../_includes/api-gateway/constructor-result.md) %}

## See also {#see-also}

* [x-yc-apigateway-integration:dummy extension](../../concepts/extensions/dummy.md)
