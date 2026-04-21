---
title: How to set up an HTTP response in {{ cdn-full-name }}
description: Follow this guide to set up an HTTP response.
---

# Setting up HTTP responses

A CDN resource can return a particular HTTP code and content instead of a standard response to all requests.

HTTP responses can be set up either globally or for a particular URI in [location rules](../../concepts/location-rules.md).

## Setting up a redirect {#redirect}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where your resource is located.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Click the resource name.
  1. Navigate to the **{{ ui-key.yacloud.cdn.label_resource-http-headers }}** tab.
  1. In the top-right corner, click ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Under **{{ ui-key.yacloud.cdn.sections.StaticResponseSection.section_static-response_hGcUL }}**, enable **{{ ui-key.yacloud.cdn.sections.StaticResponseSection.field_static-response-enabled_sPsQU }}**.
  1. In the **{{ ui-key.yacloud.cdn.sections.StaticResponseSection.field_static-response-type_5KyYv }}** field, select `{{ ui-key.yacloud.cdn.sections.StaticResponseSection.option_static-response_redirect_o58we }}`.
  1. Specify a response code.

      {% include [redirect-codes](../../../_includes/cdn/static-response/redirect-codes.md) %}

  1. Specify a URL to redirect user requests to.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- REST API {#rest-api}

  To enable the option, add the `staticResponse` section when using the [create](../../api-ref/Resource/create.md) or [update](../../api-ref/Resource/update.md) method for a [Resource](../../api-ref/Resource/index.md):

  ```json
  "staticResponse": {
    "enabled": "<true_or_false>",
    "code": "string",
    "content": "string"
  }
  ```

  Where:

  * `enabled`: Enabling the option:
      * `true` enables the option.
      * `false` disables the option.

  * `code`: Response code.

      {% include [redirect-codes](../../../_includes/cdn/static-response/redirect-codes.md) %}

  * `content`: Specify a URL to redirect user requests to.

- gRPC API {#grpc-api}

  To enable the option, add the `static_response` section when using the [ResourceService/Create](../../api-ref/grpc/Resource/create.md) or [ResourceService/Update](../../api-ref/grpc/Resource/update.md) call:

  ```json
  "static_response": {
    "enabled": "<true_or_false>",
    "code": "string",
    "content": "string"
  }
  ```

  Where:

  * `enabled`: Enabling the option:
      * `true` enables the option.
      * `false` disables the option.

  * `code`: Response code.

      {% include [redirect-codes](../../../_includes/cdn/static-response/redirect-codes.md) %}

  * `content`: Specify a URL to redirect user requests to.

{% endlist %}

{% include [after-changes-tip](../../../_includes/cdn/after-changes-tip.md) %}


## Setting a response content {#content}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where your resource is located.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Click the resource name.
  1. Navigate to the **{{ ui-key.yacloud.cdn.label_resource-http-headers }}** tab.
  1. In the top-right corner, click ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Under **{{ ui-key.yacloud.cdn.sections.StaticResponseSection.section_static-response_hGcUL }}**, enable **{{ ui-key.yacloud.cdn.sections.StaticResponseSection.field_static-response-enabled_sPsQU }}**.
  1. In the **{{ ui-key.yacloud.cdn.sections.StaticResponseSection.field_static-response-type_5KyYv }}** field, select `{{ ui-key.yacloud.cdn.sections.StaticResponseSection.option_static-response_data_rLo9U }}`.
  1. Specify a response code.

      {% include [content-codes](../../../_includes/cdn/static-response/content-codes.md) %}

  1. Specify JSON, HTML, or plain text you need to return to the client in the response body.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- REST API {#rest-api}

  To enable the option, add the `staticResponse` section when using the [create](../../api-ref/Resource/create.md) or [update](../../api-ref/Resource/update.md) method for a [Resource](../../api-ref/Resource/index.md):

  ```json
  "staticResponse": {
    "enabled": "<true_or_false>",
    "code": "string",
    "content": "string"
  }
  ```

  Where:

  * `enabled`: Enabling the option:
      * `true` enables the option.
      * `false` disables the option.

  * `code`: Response code.

      {% include [content-codes](../../../_includes/cdn/static-response/content-codes.md) %}

  * `content`: JSON, HTML, or plain text you need to return to the client in the response body.

- gRPC API {#grpc-api}

  To enable the option, add the `static_response` section when using the [ResourceService/Create](../../api-ref/grpc/Resource/create.md) or [ResourceService/Update](../../api-ref/grpc/Resource/update.md) call:

  ```json
  "static_response": {
    "enabled": "<true_or_false>",
    "code": "string",
    "content": "string"
  }
  ```

  Where:

  * `enabled`: Enabling the option:
      * `true` enables the option.
      * `false` disables the option.

  * `code`: Response code.

      {% include [content-codes](../../../_includes/cdn/static-response/content-codes.md) %}

  * `content`: JSON, HTML, or plain text you need to return to the client in the response body.

{% endlist %}

{% include [after-changes-tip](../../../_includes/cdn/after-changes-tip.md) %}