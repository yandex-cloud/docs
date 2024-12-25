---
title: How to implement search using embeddings
description: Following this guide to learn how to use {{ foundation-models-full-name }} text vector representation models to enable search over a knowledge base using embeddings.
---

# Using embeddings to search through the knowledge base

[Embeddings](../../concepts/embeddings.md) make it possible to search a knowledge base for the most relevant answer to your question.

## Getting started {#before-begin}

To use the examples:

{% list tabs group=programming_language %}

- SDK {#sdk}

  {% include [sdk-before-begin-ai-langmodel-user](../../../_includes/foundation-models/sdk-before-begin-ai-langmodel-user.md) %}

- Python 3 {#python}

  1. [Create](../../../iam/operations/sa/create.md) a service account and [assign](../../../iam/operations/sa/assign-role-for-sa.md) the `ai.languageModels.user` [role](../../security/index.md#languageModels-user) to it.
  1. [Get an IAM token](../../../iam/operations/iam-token/create-for-sa.md) for your service account.

{% endlist %}

## Run the search {#search}

In the example, the `doc_texts` array contains the source data for vectorization, i.e., the knowledge base, while the `query_text` variable contains the search query text. After you get the embeddings, it is time to calculate the distance between each vector in the knowledge base and the query vector to find the most closely related text in the knowledge base.

{% list tabs group=programming_language %}

- SDK {#sdk}

  1. Create a file named `search-knowledge-base.py` and paste the following code into it:

      {% include [search-embedding-sdk](../../../_includes/foundation-models/examples/search-embedding-sdk.md) %}

      Where:

      {% include [sdk-code-legend](../../../_includes/foundation-models/examples/sdk-code-legend.md) %}

  1. Run the created file:

      ```bash
      python3 search-knowledge-base.py
      ```

      Result:

      ```text
      Alexander Sergeyevich Pushkin (May 26 [June 6], 1799, Moscow — January 29 [February 10], 1837, St. Petersburg) was a Russian poet, playwright, and novelist, the progenitor of Russian realism, a literary critic and theorist, historian, essay writer, and journalist.
        
        
      ```

- Python 3 {#python}

  1. Create a file named `search-knowledge-base.py` and paste the following code into it:

      {% include [search-embedding-py](../../../_includes/foundation-models/examples/search-embedding-py.md) %}

      Where:

      * `<folder_ID>`: {{ yandex-cloud }} [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) ID.
      * `<IAM_token>`: Service account [IAM token](../../../iam/concepts/authorization/iam-token.md) you got earlier required for [authentication in the API](../../api-ref/authentication.md).

  1. Run the created file:

      ```bash
      python3 search-knowledge-base.py
      ```

      Result:

      ```text
      Alexander Sergeyevich Pushkin (May 26 [June 6], 1799, Moscow — January 29 [February 10], 1837, St. Petersburg) was a Russian poet, playwright, and novelist, the progenitor of Russian realism, a literary critic and theorist, historian, essay writer, and journalist.
      ```

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/embeddings.md)
* Examples of working with ML SDK on [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/text_embeddings)