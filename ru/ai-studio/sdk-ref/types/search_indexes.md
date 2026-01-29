---
sourcePath: en/_sdk-ref/sdk-ref/types/search_indexes.md
---
# Search index types

## *class* yandex\_ai\_studio\_sdk.\_search\_indexes.file.**SearchIndexFile**{#yandex_ai_studio_sdk._search_indexes.file.SearchIndexFile}

This class represents a file associated with a search index.

**search\_index\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._search_indexes.file.SearchIndexFile.search_index_id}

the unique identifier for the search index

**created\_by**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._search_indexes.file.SearchIndexFile.created_by}

the identifier of the user or system that created the file

**created\_at**\: *datetime*{#yandex_ai_studio_sdk._search_indexes.file.SearchIndexFile.created_at}

the timestamp when the file was created

**id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._search_indexes.file.SearchIndexFile.id}

## *class* yandex\_ai\_studio\_sdk.\_search\_indexes.index\_type.**BaseSearchIndexType**{#yandex_ai_studio_sdk._search_indexes.index_type.BaseSearchIndexType}

A class for search index types.

**chunking\_strategy**\: *[BaseIndexChunkingStrategy](#yandex_ai_studio_sdk._search_indexes.chunking_strategy.BaseIndexChunkingStrategy) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_ai_studio_sdk._search_indexes.index_type.BaseSearchIndexType.chunking_strategy}

the strategy used for chunking the index

## *class* yandex\_ai\_studio\_sdk.\_search\_indexes.index\_type.**TextSearchIndexType**{#yandex_ai_studio_sdk._search_indexes.index_type.TextSearchIndexType}

A class which represents a text search index type.

**chunking\_strategy**\: *[BaseIndexChunkingStrategy](#yandex_ai_studio_sdk._search_indexes.chunking_strategy.BaseIndexChunkingStrategy) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_ai_studio_sdk._search_indexes.index_type.TextSearchIndexType.chunking_strategy}

the strategy used for chunking the index

## *class* yandex\_ai\_studio\_sdk.\_search\_indexes.index\_type.**VectorSearchIndexType**{#yandex_ai_studio_sdk._search_indexes.index_type.VectorSearchIndexType}

A class which represents a vector search index type.

**doc\_embedder\_uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_ai_studio_sdk._search_indexes.index_type.VectorSearchIndexType.doc_embedder_uri}

URI for the document embedder

**query\_embedder\_uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_ai_studio_sdk._search_indexes.index_type.VectorSearchIndexType.query_embedder_uri}

URI for the query embedder

**chunking\_strategy**\: *[BaseIndexChunkingStrategy](#yandex_ai_studio_sdk._search_indexes.chunking_strategy.BaseIndexChunkingStrategy) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_ai_studio_sdk._search_indexes.index_type.VectorSearchIndexType.chunking_strategy}

the strategy used for chunking the index

## *class* yandex\_ai\_studio\_sdk.\_search\_indexes.index\_type.**HybridSearchIndexType**{#yandex_ai_studio_sdk._search_indexes.index_type.HybridSearchIndexType}

A class which represents a hybrid search index type combining text and vector search indices.

**text\_search\_index**\: *[TextSearchIndexType](#yandex_ai_studio_sdk._search_indexes.index_type.TextSearchIndexType) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_ai_studio_sdk._search_indexes.index_type.HybridSearchIndexType.text_search_index}

the text search index associated with the hybrid index

**vector\_search\_index**\: *[VectorSearchIndexType](#yandex_ai_studio_sdk._search_indexes.index_type.VectorSearchIndexType) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_ai_studio_sdk._search_indexes.index_type.HybridSearchIndexType.vector_search_index}

the vector search index associated with the hybrid index

**normalization\_strategy**\: *[IndexNormalizationStrategy](#yandex_ai_studio_sdk._search_indexes.normalization_strategy.IndexNormalizationStrategy) | [str](https://docs.python.org/3/library/stdtypes.html#str) | [int](https://docs.python.org/3/library/functions.html#int) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_ai_studio_sdk._search_indexes.index_type.HybridSearchIndexType.normalization_strategy}

the strategy for normalizing index results

**combination\_strategy**\: *[BaseIndexCombinationStrategy](#yandex_ai_studio_sdk._search_indexes.combination_strategy.BaseIndexCombinationStrategy) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_ai_studio_sdk._search_indexes.index_type.HybridSearchIndexType.combination_strategy}

the strategy for combining results from different indices

**chunking\_strategy**\: *[BaseIndexChunkingStrategy](#yandex_ai_studio_sdk._search_indexes.chunking_strategy.BaseIndexChunkingStrategy) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_ai_studio_sdk._search_indexes.index_type.HybridSearchIndexType.chunking_strategy}

the strategy used for chunking the index

## *class* yandex\_ai\_studio\_sdk.\_search\_indexes.chunking\_strategy.**BaseIndexChunkingStrategy**{#yandex_ai_studio_sdk._search_indexes.chunking_strategy.BaseIndexChunkingStrategy}

A class for an index chunking strategy, from which all other strategies are inherited.

## *class* yandex\_ai\_studio\_sdk.\_search\_indexes.chunking\_strategy.**StaticIndexChunkingStrategy**{#yandex_ai_studio_sdk._search_indexes.chunking_strategy.StaticIndexChunkingStrategy}

This class implements a static chunking strategy (i.e. a specific strategy with specific properties).

It is characterized by maximum chunk size and overlap in tokens.

**max\_chunk\_size\_tokens**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._search_indexes.chunking_strategy.StaticIndexChunkingStrategy.max_chunk_size_tokens}

the maximum size of each chunk in tokens

**chunk\_overlap\_tokens**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._search_indexes.chunking_strategy.StaticIndexChunkingStrategy.chunk_overlap_tokens}

the number of overlapping tokens between consecutive chunks

## *class* yandex\_ai\_studio\_sdk.\_search\_indexes.combination\_strategy.**BaseIndexCombinationStrategy**{#yandex_ai_studio_sdk._search_indexes.combination_strategy.BaseIndexCombinationStrategy}

A class for index combination strategies.

## *class* yandex\_ai\_studio\_sdk.\_search\_indexes.combination\_strategy.**MeanIndexEvaluationTechnique**{#yandex_ai_studio_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique}

A class with enumeration for mean index evaluation techniques.

**MEAN\_EVALUATION\_TECHNIQUE\_UNSPECIFIED** = *0*{#yandex_ai_studio_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique.MEAN_EVALUATION_TECHNIQUE_UNSPECIFIED}

an unspecified mean evaluation technique

**ARITHMETIC** = *1*{#yandex_ai_studio_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique.ARITHMETIC}

the arithmetic mean, calculated as the sum of values divided by the count of values

**GEOMETRIC** = *2*{#yandex_ai_studio_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique.GEOMETRIC}

the geometric mean, calculated as the n-th root of the product of n values

**HARMONIC** = *3*{#yandex_ai_studio_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique.HARMONIC}

the harmonic mean, calculated as the reciprocal of the arithmetic mean of the reciprocals of the values

**\_\_new\_\_**(*value*){#yandex_ai_studio_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique.__new__i}

**conjugate**(){#yandex_ai_studio_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique.conjugate}

Returns self, the complex conjugate of any int.

**bit\_length**(){#yandex_ai_studio_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**bit\_count**(){#yandex_ai_studio_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**as\_integer\_ratio**(){#yandex_ai_studio_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique.as_integer_ratio}

Return a pair of integers, whose ratio is equal to the original int.

The ratio is in lowest terms and has a positive denominator.

```python
>>> (10).as_integer_ratio()
(10, 1)
>>> (-10).as_integer_ratio()
(-10, 1)
>>> (0).as_integer_ratio()
(0, 1)
```

**is\_integer**(){#yandex_ai_studio_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

**real**{#yandex_ai_studio_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique.real}

the real part of a complex number

**imag**{#yandex_ai_studio_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique.imag}

the imaginary part of a complex number

**numerator**{#yandex_ai_studio_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique.numerator}

the numerator of a rational number in lowest terms

**denominator**{#yandex_ai_studio_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique.denominator}

the denominator of a rational number in lowest terms

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_ai_studio_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique.__init__i}

## *class* yandex\_ai\_studio\_sdk.\_search\_indexes.combination\_strategy.**MeanIndexCombinationStrategy**{#yandex_ai_studio_sdk._search_indexes.combination_strategy.MeanIndexCombinationStrategy}

A class which contains mean index combination strategy with evaluation technique and weights.

**mean\_evaluation\_technique**\: *[MeanIndexEvaluationTechnique](#yandex_ai_studio_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._search_indexes.combination_strategy.MeanIndexCombinationStrategy.mean_evaluation_technique}

the technique used for mean evaluation

**weights**\: *[Collection](https://docs.python.org/3/library/collections.abc.html#collections.abc.Collection)[[float](https://docs.python.org/3/library/functions.html#float)] | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._search_indexes.combination_strategy.MeanIndexCombinationStrategy.weights}

the weights associated with the evaluation technique

**\_\_init\_\_**(*mean\_evaluation\_technique*, *weights*){#yandex_ai_studio_sdk._search_indexes.combination_strategy.MeanIndexCombinationStrategy.__init__i}

#|
|| Parameters | 

- **mean\_evaluation\_technique** ([*MeanIndexEvaluationTechnique*](#yandex_ai_studio_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique) *\| None*)
- **weights** ([*Collection*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Collection)*[*[*float*](https://docs.python.org/3/library/functions.html#float)*] \| None*) ||
|| Return type | None ||
|#

## *class* yandex\_ai\_studio\_sdk.\_search\_indexes.combination\_strategy.**ReciprocalRankFusionIndexCombinationStrategy**{#yandex_ai_studio_sdk._search_indexes.combination_strategy.ReciprocalRankFusionIndexCombinationStrategy}

A class which describes reciprocal rank fusion index combination strategy. Reciprocal rank fusion is a method for combining multiple result sets with different relevance indicators into a single result set.

**k**\: *[int](https://docs.python.org/3/library/functions.html#int) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_ai_studio_sdk._search_indexes.combination_strategy.ReciprocalRankFusionIndexCombinationStrategy.k}

the parameter k for RRFscore. Default is 60.

**\_\_init\_\_**(*k=None*){#yandex_ai_studio_sdk._search_indexes.combination_strategy.ReciprocalRankFusionIndexCombinationStrategy.__init__i}

#|
|| Parameters | **k** ([*int*](https://docs.python.org/3/library/functions.html#int) *\| None*) ||
|| Return type | None ||
|#

## *class* yandex\_ai\_studio\_sdk.\_search\_indexes.normalization\_strategy.**IndexNormalizationStrategy**{#yandex_ai_studio_sdk._search_indexes.normalization_strategy.IndexNormalizationStrategy}

Enumeration for index normalization strategies.

This class defines the various normalization strategies that can be applied to an index.

**NORMALIZATION\_STRATEGY\_UNSPECIFIED** = *0*{#yandex_ai_studio_sdk._search_indexes.normalization_strategy.IndexNormalizationStrategy.NORMALIZATION_STRATEGY_UNSPECIFIED}

indicates that no normalization strategy has been specified

**MIN\_MAX** = *1*{#yandex_ai_studio_sdk._search_indexes.normalization_strategy.IndexNormalizationStrategy.MIN_MAX}

represents the Min-Max normalization strategy

**L2** = *2*{#yandex_ai_studio_sdk._search_indexes.normalization_strategy.IndexNormalizationStrategy.L2}

represents the L2 normalization strategy

**\_\_new\_\_**(*value*){#yandex_ai_studio_sdk._search_indexes.normalization_strategy.IndexNormalizationStrategy.__new__i}

**conjugate**(){#yandex_ai_studio_sdk._search_indexes.normalization_strategy.IndexNormalizationStrategy.conjugate}

Returns self, the complex conjugate of any int.

**bit\_length**(){#yandex_ai_studio_sdk._search_indexes.normalization_strategy.IndexNormalizationStrategy.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**bit\_count**(){#yandex_ai_studio_sdk._search_indexes.normalization_strategy.IndexNormalizationStrategy.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**as\_integer\_ratio**(){#yandex_ai_studio_sdk._search_indexes.normalization_strategy.IndexNormalizationStrategy.as_integer_ratio}

Return a pair of integers, whose ratio is equal to the original int.

The ratio is in lowest terms and has a positive denominator.

```python
>>> (10).as_integer_ratio()
(10, 1)
>>> (-10).as_integer_ratio()
(-10, 1)
>>> (0).as_integer_ratio()
(0, 1)
```

**is\_integer**(){#yandex_ai_studio_sdk._search_indexes.normalization_strategy.IndexNormalizationStrategy.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

**real**{#yandex_ai_studio_sdk._search_indexes.normalization_strategy.IndexNormalizationStrategy.real}

the real part of a complex number

**imag**{#yandex_ai_studio_sdk._search_indexes.normalization_strategy.IndexNormalizationStrategy.imag}

the imaginary part of a complex number

**numerator**{#yandex_ai_studio_sdk._search_indexes.normalization_strategy.IndexNormalizationStrategy.numerator}

the numerator of a rational number in lowest terms

**denominator**{#yandex_ai_studio_sdk._search_indexes.normalization_strategy.IndexNormalizationStrategy.denominator}

the denominator of a rational number in lowest terms

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_ai_studio_sdk._search_indexes.normalization_strategy.IndexNormalizationStrategy.__init__i}