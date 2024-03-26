# Model tuning

_The feature is at the [Preview](../../overview/concepts/launch-stages.md) stage._

You can improve the quality of machine translations in a specific domain by using your own data to train the model. This will not degrade the quality of translations of everyday language.

### What data is required for tuning {#data}

For tuning, you need a [ТМХ](https://en.wikipedia.org/wiki/Translation_Memory_eXchange) file with source and target segments. For a meaningful effect, you need at least 15,000 of such segments. If you want to translate just some specific terms, we recommend using [glossaries](glossary.md).

{% note warning %}

The texts you use for tuning should match the target knowledge domain as closely as possible (such as legal documents, medicine, or oil and gas). If you provide texts on multiple domains, this may decrease the result quality.

{% endnote %}

### How to tune a model {#how}

[Submit a request]({{ link-console-support }}) to technical support. {{ yandex-cloud }} specialists will send you a guide on model tuning in {{ ml-platform-full-name }}.

To use a model, enter its ID in the `model` parameter when sending a request.

### Who will have access to the obtained model {#security}

{{ yandex-cloud }} does not use transmitted data to train its own models. The obtained model will only be available for the folder specified in the support request.

### How tuning is charged {#pricing}

At the [Preview stage](../../overview/concepts/launch-stages.md), the tuning feature is provided free of charge. The cost of translations created using the obtained models is per the [current rates](../pricing.md).
