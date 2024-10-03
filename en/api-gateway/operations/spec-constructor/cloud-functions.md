---
title: Adding the {{ sf-full-name }} extension
description: Follow this guide to add the {{ sf-full-name }} extension using the specification constructor.
---

# Adding the x-yc-apigateway-integration:cloud_functions extension

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) in which you created or want to create an [API gateway](../../concepts/index.md).
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
   1. Select an API gateway or click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}** to create a new one.
   1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** field, click ![image](../../../_assets/api-gateway/spec-constructor/cloud-functions.svg).
   1. Specify the following in the field:

      {% include [common-spec-constructor](../../../_includes/api-gateway/common-spec-constructor.md) %}

      * (Optional) **Service account**: Service account for authorization when accessing the function. If you do not have a service account, [create](../../../iam/operations/sa/create.md) one.
      * (Optional) **Request format version**: Function request format version. The possible values are 0.1 and 1.0. The default version is 0.1.
      * **Function**: [Function](../../../functions/concepts/function.md) name and function [version tag](../../../functions/concepts/function.md#tag).
   1. (Optional) Paste or upload operation context — any object in YAML or JSON format.
   1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [constructor-result](../../../_includes/api-gateway/constructor-result.md) %}

## See also {#see-also}

* [x-yc-apigateway-integration:cloud_functions extension](../../concepts/extensions/cloud-functions.md)
