---
title: Adding the {{ serverless-containers-full-name }} extension
description: Follow this guide to add the {{ serverless-containers-full-name }} extension using the specification constructor.
---

# Adding the x-yc-apigateway-integration:serverless_containers extension

{% list tabs %}

- Management console

    1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) in which you created or want to create an [API gateway](../../concepts/index.md).
    1. [Navigate]({{ link-console-main }}/link/api-gateway) to **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. Select an API gateway or click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}** to create a new one.
    1. Click ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
    1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** field, click ![image](../../../_assets/api-gateway/spec-constructor/serverless-containers.svg).
    1. Specify the following fields:

        {% include [common-spec-constructor](../../../_includes/api-gateway/common-spec-constructor.md) %}

        * Optionally, **{{ ui-key.yc-serverless-apigw.dynamic-forms.service_account_id_name }}**: Service account for authorization when accessing a container. If you do not have a service account, [create](../../../iam/operations/sa/create.md) one.
        * **{{ ui-key.yc-serverless-apigw.dynamic-forms.serverless_containers_properties_container_id_view_spec_layout_title }}**: Container ID. To find out the ID, [get information about the container](../../../serverless-containers/operations/container-info.md).
    1. Optionally, paste or upload operation context, i.e., any object in YAML or JSON format. It is encoded in Base64 and provided to the container in the `X-Yc-ApiGateway-Operation-Context` header. The operation context supports parameter substitution.
    1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [constructor-result](../../../_includes/api-gateway/constructor-result.md) %}

#### Useful links {#see-also}

[x-yc-apigateway-integration:serverless_containers extension](../../concepts/extensions/containers.md)
