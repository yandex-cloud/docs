# {{ yagpt-full-name }} models

{{ yagpt-full-name }} provides access to large generative text neural networks. These are: {{ gpt-lite }}, a common one that is suitable for real-time task solving; {{ gpt-pro }}, a large one, based on {{ yagpt-name }} 3, which provides more accurate answers to complex questions; and a special model for summarizing, based on {{ gpt-lite }}.

If out-of-the-box models are not enough, you can [fine-tune](../../tutorials/yagpt-tuning) {{ gpt-pro }} in [{{ ml-platform-full-name }}]({{ link-datasphere-main }}) for it to better respond to your requests.

To [access](../../operations/yandexgpt/create-prompt.md) your model via the API, under `modelUri`, specify its [URI](https://en.wikipedia.org/wiki/URI) which contains the [folder ID](../../../resource-manager/operations/folder/get-id.md). The `/latest` option specifies the version of the model to invoke and is optional.

## {{ yagpt-full-name }} generation models {#yandexgpt-generation}

| Model | {{ yagpt-name}} generation | URI | Operation mode |
|---|---|---|---|
| {{ gpt-pro }} | 3 | `gpt://<folder_ID>/yandexgpt/latest` | [Asynchronous, synchronous](../index.md#working-mode) |
| {{ gpt-lite }} | 2 | `gpt://<folder_ID>/yandexgpt-lite/latest` | Asynchronous, synchronous |
| Summary | 2 | `gpt://<folder_ID>/summarization/latest` | Asynchronous, synchronous |
| Model fine-tuned in {{ ml-platform-full-name}} | 3 | `ds://<fine_tuned_model_ID>` | Synchronous |

Modified models share usage [quotas](../limits.md#quotas) with their basic models.

## Fine-tuning capabilities {#tuning-abilities}

{% include [tuning-abilities](../../../_includes/yandexgpt/tuning-abilities.md) %}
