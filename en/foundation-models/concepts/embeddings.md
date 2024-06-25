# Text vectorization

Computers process all information as numbers. To effectively process texts written in natural languages, AI models convert words, phrases, and sentences into numeric vectors of a fixed size preserving the characteristics of words and relations between them.

The process of converting text into such vectors is called _vectorization_, and the resulting vector is called an _embedding_. Embeddings store information about texts and allow using mathematical methods to process them. You can use embeddings to classify information, compare texts, or search through a knowledge base of your own.

## Models for text vectorization {#yandexgpt-embeddings}

{{ foundation-models-full-name }} provides two text vectorization models. You can access the model's API via its [URI](https://en.wikipedia.org/wiki/URI) which contains the [folder ID](../../resource-manager/operations/folder/get-id.md). The `/latest` segment specifies the model version and is optional.

| Purpose | Output vector size | Operation mode | URI |
|---|---|---|---|
| Vectorization of large source texts, e.g., documentation articles | {{ emb-vector }} | Synchronous | `emb://<folder_ID>/text-search-doc/latest` |
| Vectorization of short texts, such as search queries, requests, etc. | {{ emb-vector }} | Synchronous | `emb://<folder_ID>/text-search-query/latest` |

## Embedding use case {#example}

This primitive example demonstrates how you can use embeddings to find the closest answer to a question in a knowledge base. The `docs_text` array contains the source data for vectorization (knowledge base); `query_text` contains a search query. After you get the embeddings, you can calculate the distance between each vector in the knowledge base and the query vector to find the most closely related text.

{% list tabs group=programming_language %}

- Python 3 {#python}

   ```python
   import requests
   import numpy as np
   from scipy.spatial.distance import cdist

   FOLDER_ID = "<folder_ID>"
   IAM_TOKEN = "<IAM_token>"

   doc_uri = f"emb://{FOLDER_ID}/text-search-doc/latest"
   query_uri = f"emb://{FOLDER_ID}/text-search-query/latest"

   embed_url = "https://llm.api.cloud.yandex.net:443/foundationModels/v1/textEmbedding"
   headers = {"Content-Type": "application/json", "Authorization": f"Bearer {IAM_TOKEN}", "x-folder-id": f"{FOLDER_ID}"}

   doc_texts = [
     """Alexander Sergeyevich Pushkin (May 26 [June 6], 1799, Moscow — January 29 [February 10], 1837, St. Petersburg) was a Russian poet, playwright, and novelist, the progenitor of Russian realism, a literary critic and theorist, historian, essay writer, and journalist.""",
     """Matricaria is a genus of annual flowering plants of the aster (composite) family. According to the today's classification, it includes around 70 species of low-rise fragrant herbs that blossom from the first year of life."""
   ]

   query_text = "when is Pushkin's birthday?"

   def get_embedding(text: str, text_type: str = "doc") -> np.array:
       query_data = {
           "modelUri": doc_uri if text_type == "doc" else query_uri,
           "text": text,
       }

       return np.array(
           requests.post(embed_url, json=query_data, headers=headers).json()["embedding"]
       )


   query_embedding = get_embedding(query_text, text_type="query")
   docs_embedding = [get_embedding(doc_text) for doc_text in doc_texts]

   # Calculating cosine distance
   dist = cdist(query_embedding[None, :], docs_embedding, metric="cosine")

   # Calculating cosine similarity
   sim = 1 - dist

   # most similar doc text
   print(doc_texts[np.argmax(sim)])
   ```

   Where:

   * `<folder_ID>`: {{ yandex-cloud }} folder ID.
   * `<IAM_token>`: [IAM token](../../iam/concepts/authorization/iam-token.md) of the account used for [authentication in the API](../api-ref/authentication.md).

   Result:

   ```text
   Alexander Sergeyevich Pushkin (May 26 [June 6], 1799, Moscow — January 29 [February 10], 1837, St. Petersburg) was a Russian poet, playwright, and novelist, the progenitor of Russian realism, a literary critic and theorist, historian, essay writer, and journalist.
   ```

{% endlist %}