# Retraining models

_The feature is at the [Preview](../../overview/concepts/launch-stages.md) stage._

You can improve the quality of machine translations in a specific domain by using your own data to train the model. This will not degrade the quality of translations of everyday language.

### What data is required for retraining {#data}

For retraining, you need a [TMX](https://en.wikipedia.org/wiki/Translation_Memory_eXchange) file with source and target segments. For any significant effect, you need dozens of thousands of such segments.

{% note warning %}

The texts you use for training should match the target knowledge domain as closely as possible (such as legal documents, medicine, or oil and gas). If you provide texts on multiple domains, this may decrease the result quality.

{% endnote %}

### How to retrain a model {#how}

[Submit a request]({{ link-console-support }}) to technical support. Specify your cloud details and attach the TMX file. The model will be retrained within around two weeks.

To use a model, enter its ID in the `model` parameter when sending a request.

### Who will have access to the received model {#security}

{{ yandex-cloud }} does not use transmitted data to train its own models. The obtained model will only be available for the folder specified in the application.

### How retraining is charged {#pricing}

During the [Preview stage](../../overview/concepts/launch-stages.md), the training feature is provided free of charge. The cost of translations created using the obtained models is in line with the [current rates](../pricing.md).
