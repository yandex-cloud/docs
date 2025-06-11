---
title: Adding an HTTP request to {{ sw-name }}
description: Follow this guide to add an HTTP request to a specified endpoint in {{ sw-full-name }} using the workflow step constructor.
---

# HTTP request

{% list tabs %}

- Management console {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. From the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** section on the left side of the screen, drag the ![ArrowShapeRightToLine](../../../../_assets/console-icons/arrow-shape-right-to-line.svg) **{{ ui-key.yacloud.common.label_http }}** element to desired workflow location in the constructor window.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. In the workflow schema window, click the added **{{ ui-key.yacloud.common.label_http }}** block to select it.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. In the **Method** field, select the HTTP request method: `OPTIONS`, `GET`, `HEAD`, `POST`, `PUT`, `PATCH`, `DELETE`, or `TRACE`.
      1. In the **URL** field, specify the request URL.
      1. Optionally, in the **Request's query parameters** field, click ![plus](../../../../_assets/console-icons/plus.svg) **Add parameter** to add the required query parameters in `<Name>`:`<Value>` format.
      1. Optionally, in the **Request headers** field, click ![plus](../../../../_assets/console-icons/plus.svg) **Add header** to add the required headers in `<Name>`:`<Value>` format.
      1. Optionally, in the **Request body** field, set the request body.
      1. Optionally, enable **Use service account** to automatically add to the request a header containing the [IAM token](../../../../iam/concepts/authorization/iam-token.md) of the service account specified in the workflow settings.
      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}

{% endlist %}

## See also {#see-also}

* [YaWL specification](../../../concepts/workflows/yawl/integration/httpcall.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
