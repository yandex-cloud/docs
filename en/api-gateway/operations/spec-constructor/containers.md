---
title: Adding the {{ serverless-containers-full-name }} extension
description: Follow this guide to add the {{ serverless-containers-full-name }} extension using the specification constructor.
---

# Adding the x-yc-apigateway-integration:serverless_containers extension

{% list tabs %}

- Management console

    1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) in which you created or want to create an [API gateway](../../concepts/index.md).
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. Select an API gateway or click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}** to create a new one.
    1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** field, click ![image](../../../_assets/api-gateway/spec-constructor/serverless-containers.svg).
    1. Specify the following in the field:

        {% include [common-spec-constructor](../../../_includes/api-gateway/common-spec-constructor.md) %}

        * Optionally, **{{ ui-key.yc-serverless-apigw.dynamic-forms.service_account_id_name }}**: Service account for authorization when accessing a container. If you do not have a service account, [create](../../../iam/operations/sa/create.md) one.
        * **{{ ui-key.yc-serverless-apigw.dynamic-forms.serverless_containers_container_id_name }}**: Container ID. To find out the ID, [get information about the container](../../../serverless-containers/operations/container-info.md).
    1. Optionally, paste or upload operation context, i.e., any object in YAML or JSON format.
    1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [constructor-result](../../../_includes/api-gateway/constructor-result.md) %}

## See also {#see-also}

* [x-yc-apigateway-integration:serverless_containers extension](../../concepts/extensions/containers.md)