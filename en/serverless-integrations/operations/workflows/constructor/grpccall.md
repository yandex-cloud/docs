---
title: Adding a gRPC call to a {{ sw-name }} workflow
description: Follow this guide to add a gRPC call of a given endpoint to a {{ sw-full-name }} workflow using the workflow step constructor.
---

# gRPC call

{% list tabs %}

- Management console {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. From the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** section on the left side of the screen, drag the ![ArrowRightToSquare](../../../../_assets/console-icons/arrow-right-to-square.svg) **{{ ui-key.yc-serverless-workflows.dynamic-forms.grpc_integration_title }}** element to the relevant workflow location in the constructor window.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. In the workflow schema window, click the new **{{ ui-key.yc-serverless-workflows.dynamic-forms.grpc_integration_title }}** section to select it.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.grpc_properties_endpoint_view_spec_layout_title }}** field, enter the server address.
      1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.grpc_properties_method_view_spec_layout_title }}** field, specify the gRPC method.
      1. Optionally, enable **{{ ui-key.yc-serverless-workflows.dynamic-forms.grpc_properties_use_service_account_view_spec_layout_title }}** to automatically add to the request a header containing the [IAM token](../../../../iam/concepts/authorization/iam-token.md) of the service account specified in the workflow settings.
      1. Optionally, in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.grpc_properties_headers_view_spec_layout_title }}** field, click ![plus](../../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-serverless-workflows.dynamic-forms.grpc_properties_headers_view_spec_item_label }}** to add the required headers in `<Name>`:`<Value>` format.
      1. Optionally, set the gRPC request body in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.grpc_properties_body_view_spec_layout_title }}** field.
      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}

{% endlist %}

## See also {#see-also}

* [YaWL specification](../../../concepts/workflows/yawl/integration/grpccall.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
