---
title: Adding the Swagger UI extension
description: Follow this guide to add the Swagger UI extension using the specification constructor.
---

# Adding the x-yc-apigateway-integration:swagger extension

{% list tabs %}

- Management console

    1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) in which you created or want to create an [API gateway](../../concepts/index.md).
    1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. Select an API gateway or click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}** to create a new one.
    1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** field, click ![swagger](../../../_assets/api-gateway/spec-constructor/swagger.svg) and do the following in the window that opens:

        1. In the **{{ ui-key.yc-serverless-apigw.dynamic-forms.path_name }}** field, specify the relative path to the integration you want to add to the {{ api-gw-name }} URL. Remember to wrap variables in braces, e.g., `/docs/{document_id}`. For more information, see the [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification) specification.
        1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [constructor-result](../../../_includes/api-gateway/constructor-result.md) %}

## See also {#see-also}

* [x-yc-apigateway-integration:swagger extension](../../concepts/extensions/swagger.md)