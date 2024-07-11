---
title: "Adding the {{ message-queue-full-name }} extension"
description: "Follow this guide to add the {{ message-queue-full-name }} extension using the specification constructor."
---

# Adding the x-yc-apigateway-integration:cloud_ymq extension

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) in which you created or want to create an [API gateway](../../concepts/index.md).
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
   1. Select an API gateway or click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}** to create a new one.
   1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** field, click ![image](../../../_assets/api-gateway/spec-constructor/cloud-ymq.svg).
   1. Specify the following in the field:

      {% include [common-spec-constructor](../../../_includes/api-gateway/common-spec-constructor.md) %}

      * (Optional) **Service account**: Service account for authorization when accessing the [message queue](../../../message-queue/concepts/queue.md). If you do not have a service account, [create](../../../iam/operations/sa/create.md) one.
      * **Queue address**: Message queue address.
      * **Folder**: Folder containing the message queue.
      * (Optional) **Type of message content**: Message content type. If the value is `body`, only the request body will be written to the queue. If the value is `request`, the whole request in JSON format will be written to the queue. The default value is `body`.
      * (Optional) **Delay**: Time in seconds during which the message will be hidden when enqueued.
   1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [constructor-result](../../../_includes/api-gateway/constructor-result.md) %}

## See also {#see-also}

* [x-yc-apigateway-integration:cloud_ymq extension](../../concepts/extensions/ymq.md)
