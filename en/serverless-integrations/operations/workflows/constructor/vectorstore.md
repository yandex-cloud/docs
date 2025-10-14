---
title: Adding interaction with a vector store to a {{ sw-name }} workflow
description: Follow this guide to add interaction with a vector store to your {{ sw-full-name }} workflow using the workflow step constructor.
---

# Interaction with a vector store

{% list tabs %}

- Management console {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. From the **{{ ai-studio-name }}** section on the left side of the screen, drag the ![database](../../../../_assets/console-icons/database.svg) **Vector Store** element to the relevant workflow location in the constructor window.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. In the workflow schema window, click the new **Vector Store** section to select it.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. In the **Vector store ID** field, specify the ID of the vector store to upload your file to.
      1. Under **Source**, select:

          * `Text` for text-based file contents. Specify the file name to save it under.
          * `URL` to specify the public URL to access the file. Specify the file name to save it under.
          * `{{ objstorage-name }}` to specify the {{ objstorage-name }} [bucket](../../../../storage/concepts/bucket.md) containing the file and the file object's name, e.g., `prefix/subprefix/data.json`.

      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}
  1. {% include [integrations-step-add-catch-rule](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-add-catch-rule.md) %}

{% endlist %}

## See also {#see-also}

* [YaWL specification](../../../concepts/workflows/yawl/integration/vectorstore.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
