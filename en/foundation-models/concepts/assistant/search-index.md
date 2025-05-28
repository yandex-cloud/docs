# Search indexes

You can upload documents with additional information for the AI assistant created using {{ assistant-api }}. Search indexes help navigate the uploaded documents so that the language model can use this information when generating responses.

In {{ assistant-api }}, the following search types are available: {#search-types}

* _Text_ search or keyword search. This is a conventional type of search where each word is broken down into parts, and these parts are searched for within the document. The more parts of the searched word or phrase are found in the text, the more relevant the result. For example, when searching for the word `light`, the text search will find fragments containing the words `lighting` and `light bulb`, but not `illumination`.
* _Vector_ or semantic search. It help you find synonyms or other words or phrases close in meaning. The vector search results for `light` will contain not only cognate words, but also words close in meaning, such as `illumination`, `chandelier`, or `sun`.
* _Hybrid_ search. This is a combination of text and vector search types. When creating a hybrid search index, you can configure which type of search will have a greater impact on the results.

{% note tip %}

Use vector or hybrid search types when creating a knowledge base for an AI assistant.

If your top priority is precise keyword matching, create a text or hybrid index.

{% endnote %}

When you create a search index, the uploaded files are split into chunks of text from a few lines to several paragraphs and text characters are converted into [tokens](../yandexgpt/tokens.md). When a user asks a question, the assistant searches for relevant information and adds the chunks it finds to the search query context. When creating information chunks, the semantic meaning is ignored, so the text may be split mid-sentence. In this case, the context will be incomplete. To minimize the loss of information due to broken context, _overlapping_ is used when splitting data into chunks. This way, part of information is retained in two adjacent chunks simultaneously. The larger the chunk size, the more context the model has for generating a response, but the slower and more expensive request processing is. When creating a search index, you can use a [fine-tuned embedding model](../../operations/tuning/create-embeddings.md).

Search quality depends on the chunk size, amount of overlap, tokenization policy, and other settings. There are no one-size-fits-all parameters that work equally well for all data types; you need to set the most optimal search parameters on a case-by-case basis. 

## Text search indexes {#text-search}

When working with a text search index, you can configure the chunk size and amount of overlap in the `StaticChunkingStrategy` [group of parameters](../../searchindex/api-ref/grpc/SearchIndex/create.md#yandex.cloud.ai.assistants.v1.searchindex.StaticChunkingStrategy). These parameters are specified in tokens; in text search, one token equals one character.

The quality of text search is also affected by the `NgramTokenizer` [tokenization policy](../../searchindex/api-ref/grpc/SearchIndex/create.md#yandex.cloud.ai.assistants.v1.searchindex.NgramTokenizer) parameters. With this policy, you can set the minimum and maximum size of overlapping character sequences the search string is split into and manage partial matches in search results.

Here is an example of creating a text search index for a single file:

{% list tabs group=programming_language %}

- SDK {#sdk}

  ```python
  from yandex_cloud_ml_sdk import YCloudML
  from yandex_cloud_ml_sdk import search_indexes
  
  file = sdk.files.upload("<file_path>")
  operation = sdk.search_indexes.create_deferred(
      files,
      index_type=TextSearchIndexType(
          chunking_strategy=StaticIndexChunkingStrategy(
              max_chunk_size_tokens=700,
              chunk_overlap_tokens=300,
          )
      )
  )
  
  ```

- API {#api}

  ```json
  grpcurl \
   -H "Authorization: Bearer <IAM_token>" \
   -d @ \
   {{ api-host-llm }}:443 yandex.cloud.ai.assistants.v1.SearchIndexService.Create <<EOM
     {
      "folder_id": "<folder_ID>",
      "file_ids": [ "<file_ID>" ],
      "name":"index_name",
      "text_search_index": {
        "chunking_strategy": {
          "static_strategy": {
            "max_chunk_size_tokens": "700",
            "chunk_overlap_tokens": "300"
          }
        },
        "ngram_tokenizer": {
          "min_gram": "2",
          "max_gram": "5"
        }
      }
     }
  ```

{% endlist %}

## Vector search indexes {#vector-search}

When creating a vector index, the [embedding](../embeddings.md) model creates vectors from chunks to store the semantic meaning of the text fragment. Same as in text search, you can specify the chunk size and amount of overlap in tokens. Note that, in vector search, tokens typically contain more than one character.

You can also override the embedding models for requests and responses. By default, the {{ foundation-models-name }} embedding models are used. [Fine-tuned](../../operations/tuning/create-embeddings.md) embedding models can improve the quality of vector search in niche domains.

Here is an example of creating a vector search for a single file:

{% list tabs group=programming_language %}

- SDK {#sdk}

  ```python
  from yandex_cloud_ml_sdk import YCloudML
  from yandex_cloud_ml_sdk import search_indexes
  
  file = sdk.files.upload("<file_path>")
  operation = sdk.search_indexes.create_deferred(
      files,
      index_type=VectorSearchIndexType(
          doc_embedder_uri="emb://<folder_ID>/text-search-doc/latest",
          query_embedder_uri="emb://<folder_ID>/text-search-query/latest",
          chunking_strategy=StaticIndexChunkingStrategy(
              max_chunk_size_tokens=700,
              chunk_overlap_tokens=300,
          )
  )
  ```

- API {#api}

  ```json
  grpcurl \
   -H "Authorization: Bearer <IAM_token>" \
   -d @ \
   {{ api-host-llm }}:443 yandex.cloud.ai.assistants.v1.SearchIndexService.Create <<EOM
     {
      "folder_id": "<folder_ID>",
      "file_ids": [ "<file_ID>" ],
      "name":"index_name",
      "vector_search_index": {
        "doc_embedder_uri": "emb://<folder_ID>/text-search-doc/latest",
        "query_embedder_uri": "emb://<folder_ID>/text-search-query/latest",
        "chunking_strategy": {
          "static_strategy": {
            "max_chunk_size_tokens": "700",
            "chunk_overlap_tokens": "300"
          }
        }
      }
     }
  ```

{% endlist %}

## Hybrid search {#hybrid-search}

A hybrid search index consists of a text and vector indexes and contains additional settings for finalizing search results. You can set chunking policies for each type of index separately; however, this is unlikely to yield optimal results. For hybrid search, we recommend setting up a single global chunking policy so that the chunks for the text and vector indexes match. This way, chunking will be based on the vector index tokens. 

The final hybrid search output will depend on the strategy used to combine the results of each index. Use the `combination_strategy` [parameter](../../searchindex/api-ref/grpc/SearchIndex/create.md#yandex.cloud.ai.assistants.v1.searchindex.CombinationStrategy) to select one of these two ways of combining the text and vector index results:

* `rrf_combination` ([Reciprocal Rank Fusion](https://plg.uwaterloo.ca/~gvcormac/cormacksigir09-rrf.pdf), RRF): Combination method where greater weight is given to top-ranking elements from each index.
* `mean_combination`: Combination method based on the average value. The available options are arithmetic mean, geometric mean, and harmonic mean. Additionally, you can specify weights for each index, where the first value will indicate a text search weight, and the second one, vector search weight. The weight sum must equal 1. The default value is an arithmetic mean.

The ways of estimating text and vector search quality are different. To interpret search results correctly, you need to normalize their rankings. You can select normalization type using the `normalization_strategy` [parameter](../../searchindex/api-ref/grpc/SearchIndex/create.md#yandex.cloud.ai.assistants.v1.searchindex.HybridSearchIndex):

* `MIN_MAX`: [Min-max normalization](https://en.wikipedia.org/wiki/Feature_scaling#Rescaling_(min-max_normalization)), where the normalized results fall within the range of 0 to 1. The min-max normalization increases the spread between the highest and lowest search result rankings. By default, the `MIN_MAX` normalization is used.
* `L2`: L2 normalization based on Euclidean distances. The L2 normalization mitigates the impact of the highest and lowest rankings on the overall search results.

{% note tip %}

When creating a search index for an AI assistant based on user guides and help articles, hybrid search with the RRF combination strategy produces the best results. In this case, the normalization type barely affects the final result, as the RRF method normalizes it.

Using a single chunking policy for both text and vector search also improves the search quality.

{% endnote %}

Here is an example of creating a vector search for a single file:

{% list tabs group=programming_language %}

- SDK {#sdk}

  ```python
  from yandex_cloud_ml_sdk import YCloudML
  from yandex_cloud_ml_sdk import search_indexes
  
  file = sdk.files.upload("<file_path>")
  operation = sdk.search_indexes.create_deferred(
      files,
      index_type=HybridSearchIndexType(
        # Use global parameters to make sure the chunk sizes of both indexes match
        chunking_strategy=StaticIndexChunkingStrategy(
            max_chunk_size_tokens=700,
            chunk_overlap_tokens=300
            ),
        vector_search_index=VectorSearchIndexType(
            doc_embedder_uri="emb://<folder_ID>/text-search-doc/latest",
            query_embedder_uri="emb://<folder_ID>/text-search-query/latest"
            ),
        normalization_strategy='L2',
        combination_strategy=ReciprocalRankFusionIndexCombinationStrategy(
          k=60
          )
      )
  )
  ```

- API {#api}

  ```json
  grpcurl \
   -H "Authorization: Bearer <IAM_token>" \
   -d @ \
   {{ api-host-llm }}:443 yandex.cloud.ai.assistants.v1.SearchIndexService.Create <<EOM
     {
      "folder_id": "<folder_ID>",
      "file_ids": [ "<file_ID>" ],
      "name":"index_name",
      "hybrid_search_index": {
        "chunking_strategy": {
          "static_strategy": {
            "max_chunk_size_tokens": "700",
            "chunk_overlap_tokens": "300"
          }
        },
        "normalization_strategy": "L2",
        "combination_strategy": {
          "rrf_combination": {
            "k": "60"
          }
        },
        "vector_search_index": {
          "doc_embedder_uri": "emb://<folder_ID>/text-search-doc/latest",
          "query_embedder_uri": "emb://<folder_ID>/text-search-query/latest",
        }
      }
     }
  ```

{% endlist %}


## Use cases {#eamples}

* [{#T}](../../operations/assistant/create-with-searchindex.md)
* Examples of working with {{ ml-sdk-name }} on [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/assistants)

#### See also {#see-also}

[{#T}](../../operations/tuning/create-embeddings.md)