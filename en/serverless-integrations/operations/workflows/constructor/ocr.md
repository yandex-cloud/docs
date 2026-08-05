---
title: Adding text recognition in images to {{ sw-name }}
description: Follow this guide to add image text recognition to a workflow in {{ sw-full-name }} using the workflow step constructor.
---

# Text recognition in images

{% include [templating-note](../../../../_includes/serverless-integrations/templating-note.md) %}

{% list tabs %}

- Management console {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. From the **{{ ai-studio-name }}** section on the left side of the screen, drag the **OCR** element to relevant workflow location in the constructor window.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. In the workflow schema window, click the new **OCR** section to select it.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. In the **File format** field, select the format of the image file you want to recognize text from.
      1. In the **Languages** field, select the languages for text recognition.
      1. In the **Model** field, select a recognition model.
      1. Under **Source**, select:

          * `URL` to specify the image file public URL.
          * `{{ objstorage-name }}` to specify an {{ objstorage-name }} [bucket](../../../../storage/concepts/bucket.md) storing the image file and the file object's name, e.g., `prefix/subprefix/data.png`.
          * `Yandex Disk` to specify a path to an image file on Yandex Disk and, optionally, a shared disk [label]({{ link-yadisk-doc }}reference/content_shd#query).

              To authenticate in Yandex Disk, under **OAuth token**, specify the [app OAUth token]({{ link-yadisk-doc }}concepts/quickstart#oauth) or {{ lockbox-full-name }} [secret](../../../../lockbox/concepts/secret.md) that stores the token. Select:

              * `Lockbox` to store the OAuth token in a secret; in the **Secret** section, select the secret, its [version](../../../../lockbox/concepts/secret.md#version), and the key used to store the OAuth token.

                  If you do not have a {{ lockbox-name }} secret, click **{{ ui-key.yacloud.common.create }}** to create it.
                
              * `Text` to store the OAuth token in the specification as text; enter the OAuth token in the **Value** field.

                  {% note warning %}

                  It is not safe to store your OAuth token in the specification in plain text.

                  {% endnote %}

          * `Base64` to specify a Base64-encoded image.

      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}
  1. {% include [integrations-step-add-catch-rule](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-add-catch-rule.md) %}

{% endlist %}

## Useful links {#see-also}

* [YaWL specification](../../../concepts/workflows/yawl/integration/ocr.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
