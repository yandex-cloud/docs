# Retraining models

_The function is at the [Preview stage](../../overview/concepts/launch-stages.md)._

You can improve the quality of machine translations in a specific field of expertise by using your own data to train the model. This won't degrade the quality of translations of everyday language.

### What data is required for retraining {#data}

For retraining, original-translation segments are required in [TMX format](https://en.wikipedia.org/wiki/Translation_Memory_eXchange). For the effect to have any significance, tens of thousands of such segments are required.

{% note warning %}

Texts should match the target knowledge domain as closely as possible (such as legal documents, medicine, or oil and gas). Mixing subjects leads to worse results.

{% endnote %}

### How to retrain a model {#how}

Fill out a [model retraining request](https://forms.yandex.com/surveys/10018237.51b1f9cea8fdcda757f052e4816e3356c935c3f3/). Enter information about your cloud and attach the TMX file. The model will be retrained within approximately 2 weeks. The model ID will be sent to the email address specified in the application.

To use a model, enter its ID in the `model` parameter when sending a request.

### Who will have access to the received model {#security}

{{ yandex-cloud }} doesn't use transmitted data to train its own models. The resulting model will only be available for the folder specified in the application.

### How is retraining charged {#pricing}

During the [Preview stage](../../overview/concepts/launch-stages.md) the training functionality is provided free of charge. The cost of translations made using the received models corresponds to the [current rates](../pricing.md).
