# {{ yagpt-full-name }} models

{{ yagpt-full-name }} provides access to large generative models:

* Standard {{ gpt-lite }} suitable for solving tasks in real time.
* Large {{ gpt-pro }} that provides more accurate responses to complex prompts.

If out-of-the-box models are not enough, you can [fine-tune](../../tutorials/yagpt-tuning) {{ gpt-pro }} in [{{ ml-platform-full-name }}]({{ link-datasphere-main }}) for it to better respond to your requests.

To [access](../../operations/yandexgpt/create-prompt.md) your model via the API, under `modelUri`, specify its [URI](https://en.wikipedia.org/wiki/URI) which contains the [folder ID](../../../resource-manager/operations/folder/get-id.md). The `/latest`, `/rc`, and `/deprecated` segments indicate the model version. `/latest` is used by default.

## {{ yagpt-full-name }} generative models {#yandexgpt-generation}

When updating models, {{ yagpt-name }} generations available in [different branches](#model-lifecycle) (`/latest`, `/rc`, and `/deprecated` segments) may change. 

{% note warning %}

The next update of the model in the `Latest` branch is scheduled for December 1, 2024.

{% endnote %}

#|
|| **Model** | **URI** | **{{ yagpt-name }} generation** | **[Operating modes](../index.md#working-mode)** ||
|| **{{ gpt-lite }}** | `gpt://<folder_ID>/yandexgpt-lite/deprecated`
`gpt://<folder_ID>/yandexgpt-lite/latest` 
`gpt://<folder_ID>/yandexgpt-lite/rc`	| 3</br>3</br>4 |  Asynchronous, synchronous ||
|| **{{ gpt-pro }}** | `gpt://<folder_ID>/yandexgpt/deprcecated` 
`gpt://<folder_ID>/yandexgpt/latest` 
`gpt://<folder_ID>/yandexgpt/rc` | 3</br>3</br>4  | Asynchronous, synchronous ||
|| **{{ gpt-pro }} 32k** | `gpt://<folder_ID>/yandexgpt-32k/rc` | 4 | Synchronous^1^ ||
|| **Model fine-tuned in {{ ml-platform-full-name }}** | `ds://<folder_ID>/<fine-tuned_model_ID>` | 3 | Asynchronous, synchronous ||
|#

Modified models share usage [quotas](../limits.md#quotas) with their basic models.

^1^ **{{ gpt-pro }} 32k** features an expanded context and is designed specifically to handle large texts in synchronous mode. In asynchronous mode, the **{{ gpt-pro }}** model supports the same amount of context. 

{% include [release-cycle](../../../_includes/foundation-models/release-cycle.md) %}

## Tuning capabilities {#tuning-abilities}

{% include [tuning-abilities](../../../_includes/foundation-models/yandexgpt/tuning-abilities.md) %}
