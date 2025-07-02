---
title: Adding sending emails with {{ postbox-short-name }} to a {{ sw-name }} workflow
description: Follow this guide to add sending emails with {{ postbox-full-name }} to a {{ sw-full-name }} workflow using the workflow step constructor.
---

# Sending emails with {{ postbox-full-name }}

{% list tabs %}

- Management console {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. From the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** section on the left side of the screen, drag the ![postbox-icon](../../../../_assets/postbox-icon.svg) **{{ postbox-short-name }}** element to the relevant workflow location in the constructor window.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. In the workflow schema window, click the new **{{ postbox-short-name }}** section to select it.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.postbox_properties_from_address_view_spec_layout_title }}** field, enter the {{ postbox-full-name }} address that will send the emails.

          {% note info %}

          Make sure the [service account](../../../../iam/concepts/users/service-accounts.md) specified in the workflow settings and the address specified in this field reside in the same [folder](../../../../resource-manager/concepts/resources-hierarchy.md#folder).
 
          {% endnote %}

      1. Under **{{ ui-key.yc-serverless-workflows.dynamic-forms.postbox_properties_to_addresses_view_spec_layout_title }}**, select:

          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.postbox_properties_to_addresses_properties_address_array_view_spec_layout_title }}` to specify recipient addresses one by one using ![plus](../../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-serverless-workflows.dynamic-forms.postbox_properties_to_addresses_properties_address_array_view_spec_item_label }}**.
          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.postbox_properties_to_addresses_properties_raw_string_view_spec_layout_title }}` to specify recipient addresses as a comma-separated list.

      1. Optionally, under **{{ ui-key.yc-serverless-workflows.dynamic-forms.postbox_properties_cc_to_addresses_view_spec_layout_title }}**, select:

          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.postbox_properties_cc_to_addresses_properties_address_array_view_spec_layout_title }}` to specify BCC recipient addresses one by one using ![plus](../../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-serverless-workflows.dynamic-forms.postbox_properties_cc_to_addresses_properties_address_array_view_spec_item_label }}**.
          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.postbox_properties_cc_to_addresses_properties_raw_string_view_spec_layout_title }}` to specify BCC recipient addresses as a comma-separated list.

      1. Under **{{ ui-key.yc-serverless-workflows.dynamic-forms.postbox_properties_message_view_spec_layout_title }}**, add the content of the message to send. Select:

          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.postbox_properties_message_properties_simple_properties_body_text_view_spec_layout_title }}` to set the email content using the form:

              1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.postbox_properties_message_properties_simple_properties_subject_view_spec_layout_title }}** field, specify the message title.
              1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.postbox_properties_message_properties_simple_properties_body_html_view_spec_layout_title }}** field, specify the message text to display in email clients with HTML support.
              1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.postbox_properties_message_properties_simple_view_spec_layout_title }}** field, specify the message text to display in email clients without HTML support.
              1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.postbox_properties_message_properties_simple_properties_charset_view_spec_layout_title }}** field, select the message encoding.

          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.postbox_properties_message_properties_raw_view_spec_layout_title }}` to set the email content as a template. For more information, see the [{{ postbox-name }} documentation](../../../../postbox/aws-compatible-api/api-ref/send-email.md).

      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}

{% endlist %}

## See also {#see-also}

* [YaWL specification](../../../concepts/workflows/yawl/integration/postbox.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
