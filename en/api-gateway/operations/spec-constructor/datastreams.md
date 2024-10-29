---
title: Adding the {{ yds-full-name }} extension
description: Follow this guide to add the {{ yds-full-name }} extension using the specification constructor.
---

# Adding the x-yc-apigateway-integration:cloud_datastreams extension

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) in which you created or want to create an [API gateway](../../concepts/index.md).
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
   1. Select an API gateway or click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}** to create a new one.
   1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** field, click ![image](../../../_assets/api-gateway/spec-constructor/cloud-datastreams.svg).
   1. Specify the following in the field:

      {% include [common-spec-constructor](../../../_includes/api-gateway/common-spec-constructor.md) %}

      * (Optional) **Service account**: Service account used for authorization when performing {{ yds-name }} [stream](../../../data-streams/concepts/glossary.md#stream-concepts) operations. If you do not have a service account, [create](../../../iam/operations/sa/create.md) one.
      * **Operation**: Operation in progress.
      * **{{ yds-name }} stream name**: {{ yds-name }} data stream name.
      * (Optional) **Record content type**: Record content type. If the value is `body`, only the request body will be written to the stream. If the value is `request`, the whole request in JSON format will be written to the stream. The default value is `body`.
      * (Optional) **Segment key**: [Segment key](../../../data-streams/concepts/partition-keys.md). If not specified, a random segment will be written to.
   1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [constructor-result](../../../_includes/api-gateway/constructor-result.md) %}

## See also {#see-also}

* [x-yc-apigateway-integration:cloud_datastreams extension](../../concepts/extensions/datastreams.md)
