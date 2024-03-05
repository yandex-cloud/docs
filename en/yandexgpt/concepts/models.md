# {{ yagpt-full-name }} models

{% include notitle [preview-stage](../../_includes/yandexgpt/preview.md) %}

{{ yagpt-full-name }} provides access to two large generative neural networks: the standard {{ yagpt-name }} Lite model suitable for real-time tasks, and the larger {{ yagpt-name }} model for more accurate responses to sophisticated queries.

If the standard models are not enough, you can [fine-tune](../tutorials/yagpt-tuning) {{ yagpt-name }} Lite in [{{ ml-platform-full-name }}]({{ link-datasphere-main }}) for it to better respond to your requests.

You can access the model's API via its [URI](https://en.wikipedia.org/wiki/URI) which contains the [folder ID](../../resource-manager/operations/folder/get-id.md). The `/latest` option specifies the version of the model to invoke and is optional.

## {{ yagpt-full-name }} generation models {#yandexgpt-generation}

| Model | URI | Operation mode |
|---|---|---|
| {{ yagpt-name }} | `gpt://<folder_ID>/yandexgpt/latest` | [Asynchronous, synchronous](./index.md#working-mode) ^1^ |
| {{ yagpt-name }} Lite | `gpt://<folder_ID>/yandexgpt-lite/latest` | Asynchronous, synchronous |
| Summary | `gpt://<folder_ID>/summarization/latest` | Asynchronous, synchronous |
| Model fine-tuned in {{ ml-platform-full-name}} | `ds://<fine_tuned_model_ID>` | Synchronous |

Summary models and models tuned in {{ ml-platform-full-name}} run on {{ yagpt-name }} Lite and share usage [quotas](./limits.md#quotas).

## Fine-tuning capabilities {#tuning-abilities}

{% include [tuning-abilities](../../_includes/yandexgpt/tuning-abilities.md) %}
