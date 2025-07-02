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

        * Optionally, **{{ ui-key.yc-serverless-apigw.dynamic-forms.service_account_id_name }}**: Service account used for authorization when performing {{ yds-name }} [stream](../../../data-streams/concepts/glossary.md#stream-concepts) operations. If you do not have a service account, [create](../../../iam/operations/sa/create.md) one.
        * **{{ ui-key.yc-serverless-apigw.dynamic-forms.cloud_datastreams_action_name }}**: Operation in progress.
        * **{{ ui-key.yc-serverless-apigw.dynamic-forms.cloud_datastreams_stream_name_name }}**: Name of the {{ yds-name }} stream.
        * Optionally, **{{ ui-key.yc-serverless-apigw.dynamic-forms.cloud_datastreams_payload_format_type_name }}**: It determines what is to be written. If the value is `body`, only the request body will be written to the stream. If the value is `request`, the whole request in JSON format will be written to the stream. The default value is `body`.
        * Optionally, **{{ ui-key.yc-serverless-apigw.dynamic-forms.cloud_datastreams_partition_key_name }}**: [Segment key](../../../data-streams/concepts/partition-keys.md). If it is not specified, data will be written to a random segment.
    1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [constructor-result](../../../_includes/api-gateway/constructor-result.md) %}

## See also {#see-also}

* [x-yc-apigateway-integration:cloud_datastreams extension](../../concepts/extensions/datastreams.md)
