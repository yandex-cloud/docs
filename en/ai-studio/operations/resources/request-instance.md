---
title: How to send a request to an instance in {{ foundation-models-name }}
description: Follow this guide to send a request to an instance in {{ foundation-models-name }}.
---

# Sending a request to an instance

Follow this guide to send a request to an [instance](../../concepts/generation/dedicated-instance.md) in {{ foundation-models-name }}.

You can [get](get-instance.md) the request code and the model ID in to the [management console]({{ link-console-main }}).


## Getting started {#before-begin}

To use an example:

{% list tabs group=programming_language %}

- SDK {#sdk}

  {% include [sdk-before-begin-ai-langmodel-user](../../../_includes/ai-studio/sdk-before-begin-ai-langmodel-user.md) %}

{% endlist %}


## Send your request {#send-request}

{% list tabs group=programming_language %}

- SDK {#sdk}

  1. Create a file named `test_ml.py` and paste the following code into it:

      ```python
      from yandex_cloud_ml_sdk import YCloudML

      sdk = YCloudML(
          folder_id="<folder_ID>", auth="<API_key_or_IAM_token>"
      )

      model = sdk.chat.completions("<model_ID>", model_version="<version_ID>")
      model = model.configure(temperature=0.3)
      result = model.run(
          [
              {
                  "role": "system",
                  "text": "You are a smart assistant"
              },
              {
                  "role": "user",
                  "text": "Hi! What fields of science did Albert Einstein study?",
              },
          ]
      )

      for alternative in result:
          print(result[0].text)
          # Uncomment the next line to get the full response:
          # print(alternative)
      ```

      Where:

      * `folder_id`: {{ yandex-cloud }} [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) ID.
      * `auth`: Service account [API key](../../../iam/concepts/authorization/api-key.md) or [IAM token](../../../iam/concepts/authorization/iam-token.md) you got earlier for [authentication in the API](../../api-ref/authentication.md).
      * `<model_ID>`: ID of the [dedicated instance model](../../concepts/generation/dedicated-instance.md#models).
      * `model_version`: Model version ID.
      * `temperature`: With a higher temperature, you get more creative and randomized responses from the model. Its values range from `0` to `999999`, inclusive.

  1. Run the file you created:

      ```bash
      python3 test_ml.py
      ```

      Result:

      ```text
      Albert Einstein was an outstanding physicist, whose works in theoretical physics, theoretical mechanics, and philosophy of science became fundamental. He dedicated his career to studying the fundamentals of the universe, including the theory of relativity, both special and general. Additionally, Albert Einstein studied:\n\n* thermodynamics,\n* statistical mechanics,\n* electromagnetism,\n* quantum theory,\n* special relativity, and more.\n\nHis general relativity works found wide recognition and had a profound influence on the development of modern physics.
      ```

{% endlist %}