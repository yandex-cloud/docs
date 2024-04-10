# {{ yagpt-full-name }} models

{% include notitle [preview-stage](../../_includes/yandexgpt/preview.md) %}

{{ yagpt-full-name }} provides access to two large generative neural networks: the standard {{ gpt-lite }} suitable for real-time tasks, and the big {{ yagpt-name }} for more accurate responses to sophisticated requests.

If out-of-the-box models are not enough, you can [fine-tune](../tutorials/yagpt-tuning) {{ gpt-lite }} in [{{ ml-platform-full-name }}]({{ link-datasphere-main }}) for it to better respond to your requests.

To [access](../operations/create-prompt.md) your model via the API, under `modelUri`, specify its [URI](https://en.wikipedia.org/wiki/URI) which contains the [folder ID](../../resource-manager/operations/folder/get-id.md). The `/latest` option specifies the version of the model to invoke and is optional.

## {{ yagpt-full-name }} generation models {#yandexgpt-generation}

| Model | URI | Operation mode |
|---|---|---|
| {{ gpt-pro }} | `gpt://<folder_ID>/yandexgpt/latest` | [Asynchronous, synchronous](./index.md#working-mode) |
| {{ gpt-lite }} | `gpt://<folder_ID>/yandexgpt-lite/latest` | Asynchronous, synchronous |
| Summary | `gpt://<folder_ID>/summarization/latest` | Asynchronous, synchronous |
| Model fine-tuned in {{ ml-platform-full-name}} | `ds://<fine_tuned_model_ID>` | Synchronous |

Summary models are powered by {{ gpt-lite }}. Models fine-tuned in {{ ml-platform-full-name }} are powered by {{ gpt-pro }}. Modified model share usage [quotas](./limits.md#quotas) with their basic models.

## Fine-tuning capabilities {#tuning-abilities}

{% include [tuning-abilities](../../_includes/yandexgpt/tuning-abilities.md) %}
