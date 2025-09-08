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

The training dataset must include at least ten prompts and reference responses. The maximum prompt length is 8,000 [tokens](../generation/tokens.md); the maximum reference response length is 2,000 tokens. The maximum length of a prompt and response must not exceed 8,000 tokens.

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
| Number of [tokens](../generation/tokens.md) in the text of the request to classify | — | 8,000 |

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

## Embedding datasets {#embeddings}

Embedding tuning datasets may contain pairs of semantically related texts or triplets with text, semantically related text and unrelated text. Each line contains a separate example in JSON format:

* Pair dataset structure: {#pairs}

  ```json
  {"anchor":"<main_text_1>","positive":"<related_text_1>"}
  {"anchor":"<main_text_2>","positive":"<related_text_2>"}
  ```

* Triplet dataset structure: {#triplets}

  ```json
  {"anchor":"<main_text_1>","positive":"<related_text_1>","negative":"<negative_example_1>"}
  {"anchor":"<main_text_2>","positive":"<related_text_2>","negative":"<negative_example_2>"}
  ```

  **Example of the contents of an embedding tuning triplet dataset**:

  {% include [triplets](../../../_untranslatable/foundation-models/embedding-example.md) %}

  Where:

  * `anchor`: Main text.
  * `positive`: Semantically related text.
  * `negative`: Unrelated text.

 When fine-tuning embedding models for search scenarios, we recommend explicitly specifying whether the text is document text or query text:

  ```json
  {"anchor": "[QUERY] city austin","positive": "[DOCUMENT] Austin is located in the central part of Texas, northeast of San Antonio. The city is traversed by one interstate highway, I-35. Austin ranges in elevation from 88 to 405 meters above sea level.","negative": "[DOCUMENT] Biographical information about Jane Austen's life is scant, with a few surviving letters and biographical notes written by her family members. During her lifetime, Austen may have written up to 3,000 letters, but only 161 remain. Many of these letters were addressed to her elder sister, Cassandra."}
  ```

## Vision language datasets {#vlm-datasets}

You need vision language datasets when working with multimodal models in batch mode. {{ foundation-models-name }} supports two types of datasets.

### Request datasets {#vlm-requests}

Request datasets for vision language models contain request texts and Base64-encoded images. Each line contains a separate example in JSON format.

```json
{"request": [{"role": "user", "content": [{"type": "text", "text": "Question"}, { "type": "image", "image": "Base64 image code"}]}]}
```

### Response datasets {#vlm-response}

Response datasets for vision language models contain request texts, Base64-encoded images, and a generated response for each request. Each line contains a separate example in JSON format.

```json
{"request": [{"role": "user", "content": [{"type": "text", "text": "Question"}, { "type": "image", "image": "Base64 image code"}]}], "response": "this is a picture of a robot"}
```

#### Use cases {#examples}

* [{#T}](../../operations/tuning/create.md)
* [{#T}](../../operations/tuning/tune-classifiers.md)
* [{#T}](../../tutorials/models-fine-tuning.md)
* [{#T}](../../operations/tuning/tune-classifiers.md)
* [{#T}](../../operations/resources/create-dataset-gpt.md)
* [{#T}](../../operations/resources/create-dataset-classifier.md)