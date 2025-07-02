---
title: Adding interaction with Yandex Disk files to {{ sw-name }}
description: Follow this guide to add interaction with Yandex Disk files to your {{ sw-full-name }} using the workflow step constructor.
---

# Interaction with Yandex Disk files

{% list tabs %}

- Management console {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. From the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** section on the left side of the screen, drag the ![yadisk-icon](../../../../_assets/yadisk-icon.svg) **{{ ui-key.yc-serverless-workflows.dynamic-forms.disk_integration_title }}** element to the relevant workflow location in the constructor window.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. In the workflow schema window, click the new **{{ ui-key.yc-serverless-workflows.dynamic-forms.disk_integration_title }}** section to select it.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.ydb_document_properties_action_view_spec_layout_title }}** field, select:

          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.disk_properties_action_description_upload }}` to write the file to Yandex Disk.
          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.disk_properties_action_description_download }}` to get the file from Yandex Disk.

      1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.disk_properties_action_properties_download_properties_view_spec_layout_title }}** field, select the file content type:

          {% cut "If you are uploading files to disk" %}

          * `BINARY`: File content will be decoded from [Base64](https://{{ lang }}.wikipedia.org/wiki/Base64) format.
          * `TEXT`: File content will be saved in plain text format.
          * `JSON`: File text containing [JSON](https://en.wikipedia.org/wiki/JSON) will be saved as a JSON structure.

          {% endcut %}

          {% cut "If you are downloading files from disk" %}

          * `BINARY`: File content will be encoded in [Base64](https://{{ lang }}.wikipedia.org/wiki/Base64) format.
          * `JSON`: File content will be received as a [JSON](https://en.wikipedia.org/wiki/JSON) structure.
          * `TEXT`: File content will be received in plain text format.
          * `EXCEL`: File content will be converted into an array of pages, where each page is an array of string arrays. Supported formats: `XLAM`, `XLSM`, `XLSX`, `XLTM`, and `XLTX`.
          * `CSV`: File content will be converted into an array of string arrays by dividing strings based on the following separators: comma (`,`) and line break.

          {% endcut %}

      1. If you are uploading files to disk, specify the content that will be saved to the file in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.disk_properties_action_properties_upload_properties_content_view_spec_layout_title }}** field.
      1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.shared_disk_properties_disk_type_view_spec_layout_title }}** field, select Yandex Disk type:

          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.shared_disk_properties_disk_type_description_private }}`: Disk owned by one user.
          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.shared_disk_properties_disk_type_description_shared }}`: Disk owned by a {{ yandex-360 }} organization.

          If you are using a disk owned by an organization, specify disk ID in the **Shared disk ID** field. The ID is displayed in the address bar after `vd/` in the Yandex Disk interface.

      1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.disk_properties_path_view_spec_layout_title }}** field, specify the path to the target file on Yandex Disk.
      1. Under **{{ ui-key.yc-serverless-workflows.dynamic-forms.disk_properties_oauth_token_view_spec_layout_title }}**, specify the [app OAUth token]({{ link-yadisk-doc }}concepts/quickstart#oauth) or {{ lockbox-full-name }} [secret](../../../../lockbox/concepts/secret.md) that stores the token. Select:

          {% include [oauth](../../../../_includes/serverless-integrations/workflows-constructor/oauth.md) %}

      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}

{% endlist %}

## See also {#see-also}

* [YaWL specification](../../../concepts/workflows/yawl/integration/disk.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
