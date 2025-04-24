---
title: How to learn the prompt size in tokens
description: Follow this guide to learn how to figure out the size of prompts to {{ gpt-lite }} and {{ gpt-pro }} models in tokens.
---

# Estimating prompt size in tokens

Neural networks work with texts by representing words and sentences as [tokens](../../concepts/yandexgpt/tokens.md).

{{ foundation-models-name }} uses its own tokenizer for text processing. To calculate the token size of a text or prompt to a {{ yagpt-name }} model, use the [Tokenize](../../text-generation/api-ref/Tokenizer/index.md) method of the text generation API or [{{ ml-sdk-full-name }}](../../sdk/index.md).

The token count of the same text may vary from one [model](../../concepts/yandexgpt/models.md) to the next.

## Getting started {#before-begin}

To use the examples:

{% list tabs group=programming_language %}

- SDK {#sdk}

  {% include [sdk-before-begin-ai-langmodel-user](../../../_includes/foundation-models/sdk-before-begin-ai-langmodel-user.md) %}

- cURL {#curl}

  {% include [ai-before-beginning](../../../_includes/foundation-models/yandexgpt/ai-before-beginning.md) %}

  {% include [curl](../../../_includes/curl.md) %}

{% endlist %}

## Calculating prompt size {#evaluate}

The example below estimates the size of a prompt to a {{ yagpt-name }} model.

{% list tabs group=programming_language %}

- SDK {#sdk}

  1. Create a file named `token.py` and paste the following code into it:

      {% include [yandexgpt-tokenize-sdk](../../../_includes/foundation-models/examples/yandexgpt-tokenize-sdk.md) %}

      Where:

      {% note info %}

      {% include [sdk-input-format](../../../_includes/foundation-models/sdk-input-format.md) %}

      {% endnote %}

      * `messages`: Message text.

      {% include [sdk-code-legend](../../../_includes/foundation-models/examples/sdk-code-legend.md) %}

      * `model`: Model version value. To learn more, see [{#T}](../../concepts/yandexgpt/models.md#addressing-models).

  1. Run the created file:

      ```bash
      python3 token.py
      ```

      The request will return a list of all received tokens. 


      
      {% cut "Result" %}

      {% include [token-result](../../../_untranslatable/foundation-models/tokens-result-en.md) %}

      {% endcut %}



- cURL {#curl}

  1. Create a file named `tbody.json` with the request parameters:
  
     ```json
     {
       "modelUri": "gpt://<folder_ID>/yandexgpt",
       "text": "Generative models are managed using prompts. A good prompt should contain the context of your request to the model (instruction) and the actual task the model should complete based on the provided context. The more specific your prompt, the more accurate will be the results returned by the model.\n Apart from the prompt, other request parameters will impact the model's output too. Use Foundation Models Playground available from the management console to test your requests."
     }
     ```
  
     {% include [folder-id](../../../_includes/foundation-models/yandexgpt/folder-id.md) %}
  
  1. Send a request to the model:
  
     ```bash
     export IAM_TOKEN=<IAM_token>
     curl --request POST \
       --header "Authorization: Bearer ${IAM_TOKEN}" \
       --data "@tbody.json" \
       "https://llm.api.cloud.yandex.net/foundationModels/v1/tokenize"
     ```
  
     Where:
  
     * `<IAM_token>`: Value of the [IAM token](../../../iam/concepts/authorization/iam-token.md) you got for your account.
     * `tbody.json`: JSON file with request parameters.
  
     The request will return a list of all received tokens. 


     
     {% cut "Result" %}

     {% include [token-result](../../../_untranslatable/foundation-models/tokens-result-en.md) %}

     {% endcut %}


{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/yandexgpt/tokens.md)
* [{#T}](../../concepts/yandexgpt/index.md)
* Examples of working with {{ ml-sdk-name }} on [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/completions)