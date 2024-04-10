# Foundation models in {{ ml-platform-name }}

{{ ml-platform-full-name }} enables you to use foundation models to meet your objectives and tune them on your own data if needed. Tuning is based on the *Fine-tuning* method with results stored in {{ ml-platform-name }}.

{% note info %}

Foundation model tuning is at the [Preview](../../../overview/concepts/launch-stages.md) stage.

{% endnote %}

## Models available for tuning {#available-models}

[In the **Foundation models** section]({{ link-datasphere-main }}/foundation-models/ygpt), you can find models deployed in {{ yandex-cloud }}. You can use them in {{ ml-platform-name }} as is or tune them on your own data to make model responses more tailored to your specific tasks.

The {{ gpt-pro }} model is now available for tuning. You can access the tuned model from the {{ ml-platform-name }} project and through the [{{ yagpt-full-name }} service API](../../../yandexgpt/api-ref/authentication.md).

{% note warning %}

{{ gpt-lite }}-based models (created before March 25, 2024) will cease to operate on April 29, 2024.

{% endnote %}

## Data required for {{ gpt-pro }} tuning {#yagpt-tuning}

{% include [fine-tuning-file-requirements](../../../_includes/datasphere/fine-tuning-file-requirements.md) %}

In the {{ ml-platform-name }} interface, create a new fine-tuned foundation model, enter instructions for the model, set the tuning rate, and upload your data. Fine-tuning will take a while.

## Fine-tuning capabilities {#tuning-abilities}

{% include [tuning-abilities](../../../_includes/yandexgpt/tuning-abilities.md) %}

## Requests to a fine-tuned model {#requests}

You can send requests to a fine-tuned model through the {{ ml-platform-name }} Playground interface or the [API v1](../../../yandexgpt/api-ref/v1/) from {{ ml-platform-name }} and other applications in synchronous mode. In Playground, requests are made on behalf of a user with the model access flag set. You can send requests through Playground to the original or fine-tuned model to compare the results.

To make API requests, add a user account or service account you are going to use to submit requests to the list of {{ ml-platform-name }} project members. The account must have the `ai.languageModels.user` role.
