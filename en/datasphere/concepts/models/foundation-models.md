# Foundation models in {{ ml-platform-name }}

{{ ml-platform-full-name }} enables you to use foundation models to meet your objectives and tune them on your own data if needed. Tuning is based on the *Fine-tuning* method with results stored in {{ ml-platform-name }}.

The following foundation models are currently available in {{ ml-platform-name }}:

* [{{ gpt-pro }} basic model](../../../foundation-models/concepts/yandexgpt/index.md).
* [Classifiers based on {{ yagpt-name }}](../../../foundation-models/concepts/classifier/index.md).
* [{{ yandexart-name }} generative model](../../../foundation-models/concepts/yandexart/index.md).
* Open source code models:
  * Large [Mistral](https://mistral.ai/) language model.
  * [Saiga/Mistral](https://huggingface.co/IlyaGusev/saiga_mistral_7b_lora): Fine-tuned Russian version of Mistral.

{% note info %}

Foundation model tuning is at the [Preview](../../../overview/concepts/launch-stages.md) stage.

{% endnote %}

## Models available for tuning {#available-models}

In the **[Foundation models]({{ link-datasphere-main }}/foundation-models/)** section you can find models deployed in {{ yandex-cloud }}. You can use them in {{ ml-platform-name }} as is or tune them on your own data to make model responses more tailored to your specific tasks.

The following models are available for tuning:

* [{{ gpt-pro }} basic model](#tuning-abilities).
* [Classifiers based on {{ yagpt-name }}](#classifier-training).

You can access the tuned models from the {{ ml-platform-name }} project and through the [{{ foundation-models-full-name }} API](../../../foundation-models/api-ref/authentication.md).

In the {{ ml-platform-name }} interface, create a new fine-tuned foundation model, set the tuning rate, and upload the data. Tuning will take some time.

## Data required for {{ gpt-pro }} tuning {#yagpt-tuning}

{% include [logging](../../../_includes/foundation-models/yandexgpt/logging-disclaimer.md) %}

{% include [fine-tuning-file-requirements](../../../_includes/datasphere/fine-tuning-file-requirements.md) %}

### {{ gpt-pro }} tuning capabilities {#tuning-abilities}

{% include [tuning-abilities](../../../_includes/foundation-models/yandexgpt/tuning-abilities.md) %}

## Data for classifier tuning based on {{ yagpt-name }} {#classifier-training}

For classifier tuning based on {{ yagpt-name }}, prepare a [UTF-8](https://en.wikipedia.org/wiki/UTF-8) encoded file in [JSON Lines](https://jsonlines.org/) format with examples of texts and their classifications. The data structure in the examples will depend on the type of classification for which the model is trained.

{% include [classifier-training](../../../_includes/datasphere/classifier-training.md) %}

## Requests to fine-tuned models {#requests}

You can send requests to a fine-tuned model through the {{ ml-platform-name }} Playground interface or the [{{ foundation-models-name }}](../../../foundation-models/concepts/api.md) API from {{ ml-platform-name }} and other applications. Requests to Playground are made on behalf of the user. Playground is not yet available for open source models.

To make API requests, add the user or service account you are going to use for requests to the list of {{ ml-platform-name }} project members. The account must have the `ai.languageModels.user` role.

#### See also {#see-also}

* [{#T}](tuned-models.md)
* [{#T}](../../tutorials/yagpt-tuning.md)
* [{#T}](../../tutorials/yagpt-tuning-classifier.md)
