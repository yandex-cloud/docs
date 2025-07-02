---
title: Adding invoking a {{ serverless-containers-name }} container to a {{ sw-name }} workflow
description: Follow this guide to add invoking a {{ serverless-containers-full-name }} container to a {{ sw-full-name }} workflow using the workflow step constructor.
---

# Invoking a container {{ serverless-containers-full-name }}

{% list tabs %}

- Management console {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. From the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** section on the left side of the screen, drag the ![serverless-container-icon](../../../../_assets/serverless-container-icon.svg) **{{ serverless-containers-short-name }}** element to the relevant workflow location in the constructor window.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. In the workflow schema window, click the new **{{ serverless-containers-short-name }}** section to select it.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.containers_integration_properties_serverless_container_view_spec_layout_title }}** field, select the container to invoke during this step.
      1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.containers_integration_properties_http_method_view_spec_layout_title }}** field, select the HTTP request method.
      1. Optionally, specify the HTTP request path in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.containers_integration_properties_path_view_spec_layout_title }}** field.
      1. Optionally, in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.containers_integration_properties_query_view_spec_layout_title }}** field, click ![plus](../../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-serverless-workflows.dynamic-forms.containers_integration_properties_query_view_spec_item_label }}** to add a query parameter in `<Parameter_name>`:`<Parameter_value>` format to the HTTP request.

          To add multiple query parameters, click ![plus](../../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-serverless-workflows.dynamic-forms.containers_integration_properties_query_view_spec_item_label }}** as many times as needed.

          To remove the query parameter you do not need, click ![trash-bin](../../../../_assets/console-icons/trash-bin.svg) in the same row.
      1. Optionally, in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.containers_integration_properties_headers_view_spec_layout_title }}** field, click ![plus](../../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-serverless-workflows.dynamic-forms.containers_integration_properties_headers_view_spec_item_label }}** to add a header in `<Header_name>`:`<Header_value>` format to the HTTP request.

          To add multiple headers, click ![plus](../../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-serverless-workflows.dynamic-forms.containers_integration_properties_headers_view_spec_item_label }}** as many times as needed.

          To remove the header you do not need, click ![trash-bin](../../../../_assets/console-icons/trash-bin.svg) in the same row.
      1. Optionally, specify the HTTP request body in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.containers_integration_properties_body_view_spec_layout_title }}** field.
      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}

{% endlist %}

## See also {#see-also}

* [YaWL specification](../../../concepts/workflows/yawl/integration/containercall.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
