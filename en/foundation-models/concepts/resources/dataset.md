---
title: What a dataset is in {{ foundation-models-full-name }}
description: In this article, you will learn what datasets are in {{ foundation-models-name }} and how they are used to fine-tune models.
---

# Datasets

In {{ foundation-models-full-name }}, datasets store sets of model [tuning](../tuning/index.md) data. You can create datasets in the management console, via API, and [{{ ml-sdk-full-name }}](../../sdk/index.md).

All datasets are created based on [UTF-8](https://{{ lang }}.wikipedia.org/wiki/UTF-8)-encoded [JSON Lines](https://jsonlines.org/) files. Dataset contents format depends on the type of dataset. You can create datasets of the following types:

* Text generation: `TextToTextGeneration`.
* Multi-label classification: `TextClassificationMultilabel`.
* Binary and multi-class classification: `TextClassificationMulticlass`.
* Embedding tuning pairs: `TextEmbeddingPairParams`.
* Embedding tuning triplets: `TextEmbeddingTripletParams`.

## Text generation datasets {#generating}

Text generation datasets contain a guide, an example question and an answer to it. Each line contains a separate example in JSON format:

```json
{"request": [{"role": "system", "text": "<guide>"}, {"role": "user", "text": "<Question>"}], "response": "<Answer>"}
{"request": [{"role": "system", "text": "<guide>"}, {"role": "user", "text": "<Question>"}], "response": "<Answer>"}
{"request": [{"role": "system", "text": "<guide>"}, {"role": "user", "text": "<Question>"}], "response": "<Answer>"}
```

You will need text generation datasets to fine-tune {{ gpt-lite }} and {{ llama }} 8B^1^ [models](../yandexgpt/models.md). To fine-tune a text generation model, prepare a file with examples of at least ten prompts and reference responses. The maximum prompt length is 8,000 [tokens](../yandexgpt/tokens.md); the maximum reference response length is 2,000 tokens. The maximum length of a prompt and reference must not exceed 8,000 tokens.

Example of the contents of a text generation model tuning dataset:

{% include [fine-tuning-file-requirements](../../../_includes/datasphere/fine-tuning-file-requirements.md) %}

## Text classification datasets {#classifier}

When creating datasets for text classification, try to give meaningful names to classes. 

The following limits apply when tuning a classifier model based on {{ yagpt-name }}:

| Type of limitation | Minimum value | Maximum value |
|---|---|---|
| Number of examples per dataset | 100 | 50,000 |
| Number of classes | 1 | 100 |
| Number of same class examples per dataset| 1 | — |
| Class name length, in characters | — | 100 |
| Number of [tokens](../yandexgpt/tokens.md) in the text of the request to classify | — | 8,000 |

We recommend tuning models on datasets containing at least 1,000 examples and at least 100 examples for each class.

### Binary and multi-class classification {#multiclass}

Multi-class and binary classification datasets should contain examples of texts and their classification. Each line contains a separate example in JSON format. Each example can only be assigned to one class.

```json
{"text":"<text_1>","<class_1>":0,"<class_2>":0,"<class_3>":1}
{"text":"<text_2>","<class_1>":1,"<class_2>":0,"<class_3>":0}
{"text":"<text_3>","<class_1>":0,"<class_2>":1,"<class_3>":0}
{"text":"<text_4>","<class_1>":0,"<class_2>":0,"<class_3>":1}
```

{% include [binary](../../../_includes/foundation-models/classifier/binary-example.md) %}

{% include [multiclass](../../../_includes/foundation-models/classifier/multiclass-example.md) %}

### Multi-label classification {#multilable}

Multi-label classification datasets should contain examples of texts and their classification. Each text can belong to more than one class at the same time. Each dataset line contains a separate example in JSON format.

```json
{"text":"<text_1>","<class_1>":0,"<class_2>":0,"<class_3>":1}
{"text":"<text_2>","<class_1>":1,"<class_2>":0,"<class_3>":1}
{"text":"<text_3>","<class_1>":1,"<class_2>":1,"<class_3>":0}
```

{% include [multiclass](../../../_includes/foundation-models/classifier/multilable-example.md) %}


^1^ {{ meta-disclaimer }}

#### See also {#see-also}

* [{#T}](../../operations/resources/create-dataset-gpt.md)
* [{#T}](../../operations/resources/create-dataset-classifier.md)
* [{#T}](../../operations/tuning/create.md)
* [{#T}](../../operations/tuning/tune-classifiers.md)
* [{#T}](../../tutorials/models-fine-tuning.md)