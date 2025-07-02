---
title: Adding the {{ objstorage-full-name }} extension
description: Follow this guide to add the {{ objstorage-full-name }} extension using the specification constructor.
---

# Adding the x-yc-apigateway-integration:object_storage extension

{% list tabs %}

- Management console

    1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) in which you created or want to create an [API gateway](../../concepts/index.md).
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. Select an API gateway or click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}** to create a new one.
    1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** field, click ![image](../../../_assets/api-gateway/spec-constructor/object-storage.svg).
    1. Specify the following in the field:

        {% include [common-spec-constructor](../../../_includes/api-gateway/common-spec-constructor.md) %}

        * Optionally, **{{ ui-key.yc-serverless-apigw.dynamic-forms.service_account_id_name }}**: Service account for authorization when accessing {{ objstorage-name }}.
        * **{{ ui-key.yc-serverless-apigw.dynamic-forms.object_storage_bucket_name }}**: [Bucket](../../../storage/concepts/bucket.md) name.
        * **{{ ui-key.yc-serverless-apigw.dynamic-forms.object_storage_filename_name }}**: [Object](../../../storage/concepts/object.md) name.
        * Optionally, **{{ ui-key.yc-serverless-apigw.dynamic-forms.object_storage_error_object_filename_name }}**: Object name to return if a 4xx HTTP error code is received instead of the specified object name.
    1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [constructor-result](../../../_includes/api-gateway/constructor-result.md) %}

## See also {#see-also}

* [x-yc-apigateway-integration:object_storage extension](../../concepts/extensions/object-storage.md)
