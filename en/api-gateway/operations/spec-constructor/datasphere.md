---
title: Adding the {{ ml-platform-full-name }} extension
description: Follow this guide to add the {{ ml-platform-full-name }} extension using the specification constructor.
---

# Adding the x-yc-apigateway-integration:cloud_datasphere extension

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) in which you created or want to create an [API gateway](../../concepts/index.md).
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
   1. Select an API gateway or click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}** to create a new one.
   1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** field, click ![image](../../../_assets/api-gateway/spec-constructor/cloud-datasphere.svg).
   1. Specify the following in the field:

      {% include [common-spec-constructor](../../../_includes/api-gateway/common-spec-constructor.md) %}

      * (Optional) **Service account**: Service account for authorization when calling the {{ ml-platform-name }} [node](../../../datasphere/concepts/deploy/index.md#node). If you do not have a service account, [create](../../../iam/operations/sa/create.md) one.
      * **Folder**: Folder containing the {{ ml-platform-name }} [project](../../../datasphere/concepts/project.md) you created and the node you deployed.
      * **Node ID**: {{ ml-platform-name }} node ID.
   1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [constructor-result](../../../_includes/api-gateway/constructor-result.md) %}

## See also {#see-also}

* [x-yc-apigateway-integration:cloud_datasphere extension](../../concepts/extensions/datasphere.md)
