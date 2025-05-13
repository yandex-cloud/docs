---
title: What a dataset is in {{ foundation-models-full-name }}
description: In this article, you will learn what datasets are in {{ foundation-models-name }} and how they are used to fine-tune models.
---

# Datasets

In {{ foundation-models-full-name }}, datasets store sets of data you need to [tune](../tuning/index.md) and run models in batch mode. You can [create](../../operations/resources/create-dataset.md) datasets in the management console, via API, and [{{ ml-sdk-full-name }}](../../sdk/index.md).

All datasets are created based on [UTF-8](https://{{ lang }}.wikipedia.org/wiki/UTF-8)-encoded [JSON Lines](https://jsonlines.org/) files. Dataset contents structure depends on the type of dataset. You can create datasets of the following types:

{% include [dataset-types](../../../_includes/foundation-models/dataset-types.md) %}

To get the current list of available dataset types, run this query:

```bash
grpcurl \
  -H "Authorization: Bearer <IAM_token>" \
  llm.api.cloud.yandex.net:443 yandex.cloud.ai.dataset.v1.DatasetService.ListTypes 
```

## Text generation datasets {#generating}

{{ foundation-models-name }} allows you to create two types of text generation datasets.

### Text generation requests {#text-requests}

Datasets with only the texts of requests in them can be used to run text generation models in [batch mode](../index.md#working-mode). Each line contains a separate JSON request to initiate text generation. A request can contain either a single message with the `user` role or a dialogue with `user` and `assistant` roles, and, optionally, also an instruction for the model:

```json
{"request": [{"role": "user", "text": "<Question>"}]}
{"request": [{"role": "system", "text": "<instruction>"}, {"role": "user", "text": "<Question>"}]}
{"request": [{"role": "system", "text": "<instruction>"}, {"role": "user", "text": "<Replica_1>"}, {"role": "assistant", "text": "<Replica_2>"}, {"role": "user", "text": "<Replica_3>"}, {"role": "assistant", "text": "<Replica_4>"}]}
```

### Text generation requests and responses {#text-complitions-requests}

Datasets with questions and answers are used to fine-tune models. The response is also returned in this format when accessing models in batch mode. Each line contains a separate example in JSON format:

```json
{"request": [{"role": "user", "text": "<Question>"}], "response": "<Response>"}
{"request": [{"role": "system", "text": "<instruction>"}, {"role": "user", "text": "<Question>"}], "response": "<Answer>"}
{"request": [{"role": "system", "text": "<instruction>"}, {"role": "user", "text": "<Replica_1>"}, {"role": "assistant", "text": "<Replica_2>"}, {"role": "user", "text": "<Replica_3>"}, {"role": "assistant", "text": "<Replica_4>"}], "response": "<Response>"}
```

{% note tip %}

When fine-tuning models, use the same instruction for each tuning example and use it when accessing the fine-tuned model. This improves fine-tuning efficiency.

{% endnote %}

The training dataset must include at least ten prompts and reference responses. The maximum prompt length is 8,000 [tokens](../yandexgpt/tokens.md); the maximum reference response length is 2,000 tokens. The maximum length of a prompt and response must not exceed 8,000 tokens.

Example of the contents of a text generation model tuning dataset:

{% include [fine-tuning-file-example](../../../_includes/datasphere/fine-tuning-file-requirements.md) %}

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


## Vision language datasets {#vlm-datasets}

You need vision language datasets when working with [multimodal models](../multimodal/index.md) in batch mode. {{ foundation-models-name }} supports two types of datasets.

### Request datasets {#vlm-requests}

Request datasets for vision language models contain request texts and Base64-encoded images. Each line contains a separate example in JSON format.

```json
{"request": [{"role": "user", "text": "<Question>"}, {"image": "<base64-encoded_image>"}]}
```

### Response datasets {#vlm-response}

Response datasets for vision language models contain request texts, Base64-encoded images, and a generated response for each request. Each line contains a separate example in JSON format.

```json
{"request": [{"role": "user", "text": "<Question>"}, {"image": "<base64-encoded_image>"}], "response": "Response"}
```

#### Use cases {#examples}

* [{#T}](../../operations/resources/create-dataset-gpt.md)
* [{#T}](../../operations/resources/create-dataset-classifier.md)
* [{#T}](../../operations/tuning/create.md)
* [{#T}](../../operations/tuning/tune-classifiers.md)
* [{#T}](../../tutorials/models-fine-tuning.md)