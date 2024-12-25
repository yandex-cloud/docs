---
title: How to learn prompt size in tokens
description: Follow this guide to learn how to figure the size of prompts to {{ yagpt-full-name }} models in tokens.
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

{% endlist %}

## Calculating prompt size {#evaluate}

The example below estimates the size of a prompt to a {{ yagpt-name }} model. The prompt context is set in the `messages` variable.

{% list tabs group=programming_language %}

- SDK {#sdk}

  1. Create a file named `tokenize.py` and paste the following code into it:

      {% include [yandexgpt-tokenize-sdk](../../../_includes/foundation-models/examples/yandexgpt-tokenize-sdk.md) %}

      Where:

      {% include [the-messages-parameter](../../../_includes/foundation-models/yandexgpt/the-messages-parameter.md) %}

      {% include [sdk-code-legend](../../../_includes/foundation-models/examples/sdk-code-legend.md) %}

  1. Run the created file:

      ```bash
      python3 tokenize.py
      ```

      {% cut "The result of a prompt is a list of tokens obtained by the tokenizer:" %}

      ```text
      {"tokens":
        [{"id":"1","text":"\u003cs\u003e","special":true},
        {"id":"6010","text":"▁Gener","special":false},
        {"id":"1748","text":"ative","special":false},
        {"id":"7789","text":"▁models","special":false},
        {"id":"642","text":"▁are","special":false},
        {"id":"15994","text":"▁managed","special":false},
        {"id":"1772","text":"▁using","special":false},
        {"id":"80536","text":"▁prompts","special":false},
        {"id":"125820","text":".","special":false},
        {"id":"379","text":"▁A","special":false},
        {"id":"1967","text":"▁good","special":false},
        {"id":"19099","text":"▁prompt","special":false},
        {"id":"1696","text":"▁should","special":false},
        {"id":"11195","text":"▁contain","special":false},
        {"id":"292","text":"▁the","special":false},
        {"id":"7210","text":"▁context","special":false},
        {"id":"346","text":"▁of","special":false},
        {"id":"736","text":"▁your","special":false},
        {"id":"4104","text":"▁request","special":false},
        {"id":"342","text":"▁to","special":false},
        {"id":"292","text":"▁the","special":false},
        {"id":"2718","text":"▁model","special":false},
        {"id":"355","text":"▁(","special":false},
        {"id":"105793","text":"instruction","special":false},
        {"id":"125855","text":")","special":false},
        {"id":"353","text":"▁and","special":false},
        {"id":"292","text":"▁the","special":false},
        {"id":"9944","text":"▁actual","special":false},
        {"id":"7430","text":"▁task","special":false},
        {"id":"292","text":"▁the","special":false},
        {"id":"2718","text":"▁model","special":false},
        {"id":"1696","text":"▁should","special":false},
        {"id":"7052","text":"▁complete","special":false},
        {"id":"4078","text":"▁based","special":false},
        {"id":"447","text":"▁on","special":false},
        {"id":"292","text":"▁the","special":false},
        {"id":"6645","text":"▁provided","special":false},
        {"id":"7210","text":"▁context","special":false},
        {"id":"125820","text":".","special":false},
        {"id":"671","text":"▁The","special":false},
        {"id":"1002","text":"▁more","special":false},
        {"id":"4864","text":"▁specific","special":false},
        {"id":"736","text":"▁your","special":false},
        {"id":"19099","text":"▁prompt","special":false},
        {"id":"125827","text":",","special":false},
        {"id":"292","text":"▁the","special":false},
        {"id":"1002","text":"▁more","special":false},
        {"id":"16452","text":"▁accurate","special":false},
        {"id":"912","text":"▁will","special":false},
        {"id":"460","text":"▁be","special":false},
        {"id":"292","text":"▁the","special":false},
        {"id":"4168","text":"▁results","special":false},
        {"id":"13462","text":"▁returned","special":false},
        {"id":"711","text":"▁by","special":false},
        {"id":"292","text":"▁the","special":false},
        {"id":"2718","text":"▁model","special":false},
        {"id":"125820","text":".","special":false}],
      "modelVersion":"23.10.2024"
      }
      ```

      {% endcut %}

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/yandexgpt/tokens.md)
* [{#T}](../../concepts/yandexgpt/index.md)
* Examples of working with ML SDK on [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/completions)