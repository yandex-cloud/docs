---
title: Adding the Access over HTTP extension
description: Follow this guide to add the Access over HTTP extension using the specification constructor.
---

# Adding the x-yc-apigateway-integration:http extension

{% list tabs %}

- Management console

    1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) in which you created or want to create an [API gateway](../../concepts/index.md).
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. Select an API gateway or click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}** to create a new one.
    1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** field, click ![image](../../../_assets/api-gateway/spec-constructor/http.svg).
    1. Specify the following in the field:

        {% include [common-spec-constructor](../../../_includes/api-gateway/common-spec-constructor.md) %}

        * **{{ ui-key.yc-serverless-apigw.dynamic-forms.http_url_name }}**: URL to redirect the invocation to. It must be accessible from the internet.
        * Optionally, **{{ ui-key.yc-serverless-apigw.dynamic-forms.http_http_method_for_extension_name }}**: HTTP method to use for the invocation. If you skip this parameter, the method specified in the **{{ ui-key.yc-serverless-apigw.dynamic-forms.http_method_name }}** field will be used.
        * Optionally, **{{ ui-key.yc-serverless-apigw.dynamic-forms.http_headers_name }}**: HTTP headers to provide in the request.

            Enable **{{ ui-key.yc-serverless-apigw.dynamic-forms.http_send_original_headers_name }}**. By default, the HTTP headers of the original request are not provided.

        * Optionally, **{{ ui-key.yc-serverless-apigw.dynamic-forms.http_query_name }}**: Query parameters to provide in the request.

            Enable **{{ ui-key.yc-serverless-apigw.dynamic-forms.http_send_original_query_params_name }}**. By default, the query parameters of the original request are not provided.

        * Optionally, **{{ ui-key.yc-serverless-apigw.dynamic-forms.http_read_timeout_name }}**: Invocation read timeout in seconds.
        * Optionally, **{{ ui-key.yc-serverless-apigw.dynamic-forms.http_connect_timeout_name }}**: Connection timeout for the invocation in seconds.
    1. Optionally, enable **{{ ui-key.yc-serverless-apigw.dynamic-forms.http_omit_empty_headers_name }}**. By default, empty headers are provided.
    1. Optionally, enable **{{ ui-key.yc-serverless-apigw.dynamic-forms.http_omit_empty_query_parameters_name }}**. By default, empty query parameters are provided.
    1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [constructor-result](../../../_includes/api-gateway/constructor-result.md) %}

## See also {#see-also}

* [x-yc-apigateway-integration:http extension](../../concepts/extensions/http.md)
