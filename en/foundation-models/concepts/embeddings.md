---
title: Text vectorization models
description: In this tutorial, you will learn about text vectorization models available in {{ foundation-models-name }}.
---

# Text vectorization

Computers process all information as numbers. To effectively process texts written in natural languages, AI models convert words, phrases, and sentences into numeric vectors of a fixed size preserving the characteristics of words and relations between them.

The process of converting text into such vectors is called _vectorization_, and the resulting vector is called an _embedding_. Embeddings store information about texts and allow using mathematical methods to process them. You can use embeddings to classify information, compare texts, or search through a knowledge base of your own.

## Models for text vectorization {#yandexgpt-embeddings}

{{ foundation-models-full-name }} provides two text vectorization models.

| **Target** | **URI** | **Output vector size** | **[Operating modes](./index.md#working-mode)** |
|---|---|---|---|
| Vectorization of large source texts, e.g., documentation articles | `emb://<folder_ID>/text-search-doc/latest` | {{ emb-vector }} | Synchronous |
| Vectorization of short texts, such as search queries, requests, etc. | `emb://<folder_ID>/text-search-query/latest` | {{ emb-vector }} | Synchronous |

To use the {{ foundation-models-full-name }} text vectorization models, you need the `ai.languageModels.user` [role](../security/index.md#languageModels-user) or higher for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

## Accessing models {#addressing-models}

You can access text vector representation models in a number of ways.

{% list tabs group=programming_language %}

- SDK {#sdk}

  When working with text vector representation models via [{{ ml-sdk-full-name }}](../sdk/index.md), use one of the following formats:

  * **Model name**, provided as a string.

      ```python
      model = (
        sdk.models.text_embeddings("text-search-doc")
      )
      ```

  * **Model name and version**, provided as strings in the `model_name` and `model_version` fields, respectively.

      ```python
      model = (
        sdk.models.text_embeddings(model_name="text-search-query", model_version="latest")
      )
      ```

  * **Model URI**, provided as a string containing the full [URI](#yandexgpt-embeddings) of the model.

      ```python
      model = (
        sdk.models.text_embeddings("emb://b1gt6g8ht345********/text-search-query/latest")
      )
      ```

- API {#curl}

  To [access](../operations/embeddings/search.md) a model via the [REST API](../embeddings/api-ref/index.md) or [gRPC API](../embeddings/api-ref/grpc/index.md), specify the model's [URI](#yandexgpt-embeddings) containing the [folder ID](../../resource-manager/operations/folder/get-id.md) in the `modelUri` field of the request body. The `/latest` segment indicates the model version and is optional.

  **Example:**

  ```json
  {
    "modelUri":
      emb://b1gt6g8ht345********/text-search-doc/latest
    ...
  }
  ```

  To access the `Latest` version, you do not need to specify the model version explicitly because `Latest` is used by default.

{% endlist %}

## Embedding use case {#example}

This primitive example demonstrates how you can use embeddings to find the closest answer to a question in a knowledge base. The `doc_texts` array contains the source data for vectorization, i.e., the knowledge base, while the `query_text` variable contains the search query. After you get the embeddings, you can calculate the distance between each vector in the knowledge base and the query vector to find the most closely related text.

{% list tabs group=programming_language %}

- SDK {#sdk}

  {% include [search-embedding-sdk](../../_includes/foundation-models/examples/search-embedding-sdk.md) %}

  Where:

  * `<folder_ID>`: ID of the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) in which the [service account](../../iam/concepts/users/service-accounts.md) was created.
  * `<API_key>`: Service account [API key](../../iam/concepts/authorization/api-key.md) required for [authentication in the API](../api-ref/authentication.md).

  Result:

  ```text
  Alexander Sergeyevich Pushkin (May 26 [June 6], 1799, Moscow — January 29 [February 10], 1837, St. Petersburg)
    was a Russian poet, playwright, and novelist, the progenitor of Russian realism,
    a literary critic and theorist, historian, essay writer, and journalist.
  ```

- Python 3 {#python}

  {% include [search-embedding-py](../../_includes/foundation-models/examples/search-embedding-py.md) %}

  Where:

  * `<folder_ID>`: {{ yandex-cloud }} [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) ID.
  * `<IAM_token>`: [IAM token](../../iam/concepts/authorization/iam-token.md) of the account for [authentication with the API](../api-ref/authentication.md).

  Result:

  ```text
  Alexander Sergeyevich Pushkin (May 26 [June 6], 1799, Moscow — January 29 [February 10], 1837, St. Petersburg) was a Russian poet, playwright, and novelist, the progenitor of Russian realism, a literary critic and theorist, historian, essay writer, and journalist.
  ```

{% endlist %}

#### See also {#see-also}

* [Using embeddings to search through the knowledge base](../operations/embeddings/search.md)
* Examples of working with ML SDK on [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/text_embeddings)