# {{ yagpt-full-name }} models

{{ yagpt-full-name }} provides access to large generative models:

* Standard {{ gpt-lite }} suitable for solving tasks in real time.
* Large {{ gpt-pro }} based on {{ yagpt-name }} 3 that provides more accurate responses to complex prompts.
* Special summary model based on {{ gpt-lite }}.

If out-of-the-box models are not enough, you can [fine-tune](../../tutorials/yagpt-tuning) {{ gpt-pro }} in [{{ ml-platform-full-name }}]({{ link-datasphere-main }}) for it to better respond to your requests.

To [access](../../operations/yandexgpt/create-prompt.md) your model via the API, under `modelUri`, specify its [URI](https://en.wikipedia.org/wiki/URI) which contains the [folder ID](../../../resource-manager/operations/folder/get-id.md). The `/latest`, `/rc`, and `/deprecated` segments indicate the model version. `/latest` is used by default.

## {{ yagpt-full-name }} generative models {#yandexgpt-generation}

{% note info %}

When updating models, {{ yagpt-name }} generations available in different branches (`/latest`, `/rc`, and `/deprecated`) may change.

{% endnote %}

#|
|| **Model** | **URI** | **{{ yagpt-name }} generation** | **[Operating modes](../index.md#working-mode)** ||
|| **{{ gpt-lite }}**</br>(until June 24, 2024) | `gpt://<folder_ID>/yandexgpt-lite/deprecated`</br>`gpt://<folder_ID>/yandexgpt-lite/latest`</br>`gpt://<folder_ID>/yandexgpt-lite/rc` | 2</br>2</br>3 | Asynchronous, synchronous ||
|| **{{ gpt-lite }}**</br>(after June 24, 2024) | `gpt://<folder_ID>/yandexgpt-lite/deprecated`</br>`gpt://<folder_ID>/yandexgpt-lite/latest`</br>`gpt://<folder_ID>/yandexgpt-lite/rc` | 2</br>3</br>3 | Asynchronous, synchronous ||
|| **{{ gpt-pro }}** | `gpt://<folder_ID>/yandexgpt/latest` | 3 | Asynchronous, synchronous ||
|| **Summary** | `gpt://<folder_ID>/summarization/latest` | 2 | Asynchronous, synchronous ||
|| **Model fine-tuned in {{ ml-platform-full-name }}** | `ds://<fine-tuned_model_ID>` | 3 | Asynchronous, synchronous ||
|#

Modified models share usage [quotas](../limits.md#quotas) with their basic models.

## Fine-tuning capabilities {#tuning-abilities}

{% include [tuning-abilities](../../../_includes/foundation-models/yandexgpt/tuning-abilities.md) %}
