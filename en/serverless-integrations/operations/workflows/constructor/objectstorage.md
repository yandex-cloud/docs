---
title: Adding interaction with {{ objstorage-name }} objects to a {{ sw-name }} workflow
description: Follow this guide to add interaction with {{ objstorage-full-name }} objects to your {{ sw-full-name }} workflow using the workflow step constructor.
---

# Interacting with {{ objstorage-full-name }} objects

{% list tabs %}

- Management console {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. From the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** section on the left side of the screen, drag the ![object-storage-icon](../../../../_assets/object-storage-icon.svg) **{{ objstorage-name }}** element to the relevant workflow location in the constructor window.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. In the workflow schema window, click the new **{{ objstorage-name }}** section to select it.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.object_storage_properties_bucket_view_spec_layout_title }}** field, select the [bucket](../../../../storage/concepts/bucket.md) containing the objects you will work with as part of your workflow.
      1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.object_storage_properties_object_view_spec_layout_title }}** field, specify the name of the [object](../../../../storage/concepts/object.md) you are going to work with.
      1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.object_storage_properties_action_view_spec_layout_title }}** field, select:

          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.object_storage_properties_action_description_put }}` to add a new object to the bucket.
          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.object_storage_properties_action_description_get }}` to get object content from the bucket.

      1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.object_storage_properties_action_properties_get_properties_content_type_view_spec_layout_title }}** field, select the content type of the target object:

          {% cut "If you are adding an object to the bucket" %}

          * `BINARY`: Object content will be decoded from [Base64](https://{{ lang }}.wikipedia.org/wiki/Base64) format.
          * `TEXT`: Object content will be saved in plain text format.
          * `JSON`: Object text containing JSON will be saved as a [JSON](https://en.wikipedia.org/wiki/JSON) structure.

          {% endcut %}

          {% cut "If you are getting an object from the bucket" %}

          * `BINARY`: Object content will be encoded in [Base64](https://{{ lang }}.wikipedia.org/wiki/Base64) format.
          * `JSON`: Object content will be received as a [JSON](https://en.wikipedia.org/wiki/JSON) structure.
          * `TEXT`: Object content will be received in plain text format.
          * `EXCEL`: Object content will be converted into an array of pages, where each page is an array of string arrays. Supported formats: `XLAM`, `XLSM`, `XLSX`, `XLTM`, and `XLTX`.
          * `CSV`: Object content will be converted into an array of string arrays by dividing the strings based on the following separators: comma (`,`) and line break.

          {% endcut %}

      1. If you are adding an object to the bucket, specify the content of the new object in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.object_storage_properties_action_properties_put_properties_content_view_spec_layout_title }}** field.
      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}

{% endlist %}

## See also {#see-also}

* [YaWL specification](../../../concepts/workflows/yawl/integration/objectstorage.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
