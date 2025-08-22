---
sourcePath: en/_sdk-ref/sdk-ref/types/search_indexes.md
---
# Search index types

## *class* yandex\_cloud\_ml\_sdk.\_search\_indexes.file.**SearchIndexFile**{#yandex_cloud_ml_sdk._search_indexes.file.SearchIndexFile}

SearchIndexFile(id: ‘str’, \_sdk: ‘BaseSDK’, search\_index\_id: ‘str’, created\_by: ‘str’, created\_at: ‘datetime’)

**search\_index\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_indexes.file.SearchIndexFile.search_index_id}

**created\_by**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_indexes.file.SearchIndexFile.created_by}

**created\_at**\: *datetime*{#yandex_cloud_ml_sdk._search_indexes.file.SearchIndexFile.created_at}

**id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_indexes.file.SearchIndexFile.id}

## *class* yandex\_cloud\_ml\_sdk.\_search\_indexes.index\_type.**BaseSearchIndexType**{#yandex_cloud_ml_sdk._search_indexes.index_type.BaseSearchIndexType}

BaseSearchIndexType(chunking\_strategy: ‘BaseIndexChunkingStrategy | None’ = None)

**chunking\_strategy**\: *[BaseIndexChunkingStrategy](#yandex_cloud_ml_sdk._search_indexes.chunking_strategy.BaseIndexChunkingStrategy) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._search_indexes.index_type.BaseSearchIndexType.chunking_strategy}

## *class* yandex\_cloud\_ml\_sdk.\_search\_indexes.index\_type.**TextSearchIndexType**{#yandex_cloud_ml_sdk._search_indexes.index_type.TextSearchIndexType}

TextSearchIndexType(chunking\_strategy: ‘BaseIndexChunkingStrategy | None’ = None)

**chunking\_strategy**\: *[BaseIndexChunkingStrategy](#yandex_cloud_ml_sdk._search_indexes.chunking_strategy.BaseIndexChunkingStrategy) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._search_indexes.index_type.TextSearchIndexType.chunking_strategy}

## *class* yandex\_cloud\_ml\_sdk.\_search\_indexes.index\_type.**VectorSearchIndexType**{#yandex_cloud_ml_sdk._search_indexes.index_type.VectorSearchIndexType}

VectorSearchIndexType(chunking\_strategy: ‘BaseIndexChunkingStrategy | None’ = None, doc\_embedder\_uri: ‘str | None’ = None, query\_embedder\_uri: ‘str | None’ = None)

**doc\_embedder\_uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._search_indexes.index_type.VectorSearchIndexType.doc_embedder_uri}

**query\_embedder\_uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._search_indexes.index_type.VectorSearchIndexType.query_embedder_uri}

**chunking\_strategy**\: *[BaseIndexChunkingStrategy](#yandex_cloud_ml_sdk._search_indexes.chunking_strategy.BaseIndexChunkingStrategy) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._search_indexes.index_type.VectorSearchIndexType.chunking_strategy}

## *class* yandex\_cloud\_ml\_sdk.\_search\_indexes.index\_type.**HybridSearchIndexType**{#yandex_cloud_ml_sdk._search_indexes.index_type.HybridSearchIndexType}

HybridSearchIndexType(chunking\_strategy: ‘BaseIndexChunkingStrategy | None’ = None, text\_search\_index: ‘TextSearchIndexType | None’ = None, vector\_search\_index: ‘VectorSearchIndexType | None’ = None, normalization\_strategy: ‘IndexNormalizationStrategy | str | int | None’ = None, combination\_strategy: ‘BaseIndexCombinationStrategy | None’ = None)

**text\_search\_index**\: *[TextSearchIndexType](#yandex_cloud_ml_sdk._search_indexes.index_type.TextSearchIndexType) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._search_indexes.index_type.HybridSearchIndexType.text_search_index}

**vector\_search\_index**\: *[VectorSearchIndexType](#yandex_cloud_ml_sdk._search_indexes.index_type.VectorSearchIndexType) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._search_indexes.index_type.HybridSearchIndexType.vector_search_index}

**normalization\_strategy**\: *[IndexNormalizationStrategy](#yandex_cloud_ml_sdk._search_indexes.normalization_strategy.IndexNormalizationStrategy) | [str](https://docs.python.org/3/library/stdtypes.html#str) | [int](https://docs.python.org/3/library/functions.html#int) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._search_indexes.index_type.HybridSearchIndexType.normalization_strategy}

**combination\_strategy**\: *[BaseIndexCombinationStrategy](#yandex_cloud_ml_sdk._search_indexes.combination_strategy.BaseIndexCombinationStrategy) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._search_indexes.index_type.HybridSearchIndexType.combination_strategy}

**chunking\_strategy**\: *[BaseIndexChunkingStrategy](#yandex_cloud_ml_sdk._search_indexes.chunking_strategy.BaseIndexChunkingStrategy) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._search_indexes.index_type.HybridSearchIndexType.chunking_strategy}

## *class* yandex\_cloud\_ml\_sdk.\_search\_indexes.chunking\_strategy.**BaseIndexChunkingStrategy**{#yandex_cloud_ml_sdk._search_indexes.chunking_strategy.BaseIndexChunkingStrategy}

## *class* yandex\_cloud\_ml\_sdk.\_search\_indexes.chunking\_strategy.**StaticIndexChunkingStrategy**{#yandex_cloud_ml_sdk._search_indexes.chunking_strategy.StaticIndexChunkingStrategy}

StaticIndexChunkingStrategy(max\_chunk\_size\_tokens: ‘int’, chunk\_overlap\_tokens: ‘int’)

**max\_chunk\_size\_tokens**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_cloud_ml_sdk._search_indexes.chunking_strategy.StaticIndexChunkingStrategy.max_chunk_size_tokens}

**chunk\_overlap\_tokens**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_cloud_ml_sdk._search_indexes.chunking_strategy.StaticIndexChunkingStrategy.chunk_overlap_tokens}

## *class* yandex\_cloud\_ml\_sdk.\_search\_indexes.combination\_strategy.**BaseIndexCombinationStrategy**{#yandex_cloud_ml_sdk._search_indexes.combination_strategy.BaseIndexCombinationStrategy}

## *class* yandex\_cloud\_ml\_sdk.\_search\_indexes.combination\_strategy.**MeanIndexEvaluationTechnique**{#yandex_cloud_ml_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique}

**MEAN\_EVALUATION\_TECHNIQUE\_UNSPECIFIED** = *0*{#yandex_cloud_ml_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique.MEAN_EVALUATION_TECHNIQUE_UNSPECIFIED}

**ARITHMETIC** = *1*{#yandex_cloud_ml_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique.ARITHMETIC}

**GEOMETRIC** = *2*{#yandex_cloud_ml_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique.GEOMETRIC}

**HARMONIC** = *3*{#yandex_cloud_ml_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique.HARMONIC}

**\_\_new\_\_**(*value*){#yandex_cloud_ml_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique.__new__i}

**conjugate**(){#yandex_cloud_ml_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique.conjugate}

Returns self, the complex conjugate of any int.

**bit\_length**(){#yandex_cloud_ml_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**bit\_count**(){#yandex_cloud_ml_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**as\_integer\_ratio**(){#yandex_cloud_ml_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique.as_integer_ratio}

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

**is\_integer**(){#yandex_cloud_ml_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

**real**{#yandex_cloud_ml_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique.real}

the real part of a complex number

**imag**{#yandex_cloud_ml_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique.imag}

the imaginary part of a complex number

**numerator**{#yandex_cloud_ml_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique.numerator}

the numerator of a rational number in lowest terms

**denominator**{#yandex_cloud_ml_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique.denominator}

the denominator of a rational number in lowest terms

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_cloud_ml_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique.__init__i}

## *class* yandex\_cloud\_ml\_sdk.\_search\_indexes.combination\_strategy.**MeanIndexCombinationStrategy**{#yandex_cloud_ml_sdk._search_indexes.combination_strategy.MeanIndexCombinationStrategy}

MeanIndexCombinationStrategy(mean\_evaluation\_technique: ‘MeanIndexEvaluationTechnique | None’, weights: ‘Collection[float] | None’)

**mean\_evaluation\_technique**\: *[MeanIndexEvaluationTechnique](#yandex_cloud_ml_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_indexes.combination_strategy.MeanIndexCombinationStrategy.mean_evaluation_technique}

**weights**\: *[Collection](https://docs.python.org/3/library/typing.html#typing.Collection)[[float](https://docs.python.org/3/library/functions.html#float)] | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_indexes.combination_strategy.MeanIndexCombinationStrategy.weights}

**\_\_init\_\_**(*mean\_evaluation\_technique*, *weights*){#yandex_cloud_ml_sdk._search_indexes.combination_strategy.MeanIndexCombinationStrategy.__init__i}

#|
|| Parameters | 

- **mean\_evaluation\_technique** ([*MeanIndexEvaluationTechnique*](#yandex_cloud_ml_sdk._search_indexes.combination_strategy.MeanIndexEvaluationTechnique)* \| **None*)
- **weights** ([*Collection*](https://docs.python.org/3/library/typing.html#typing.Collection)*[*[*float*](https://docs.python.org/3/library/functions.html#float)*] **\| **None*) ||
|| Return type | None ||
|#

## *class* yandex\_cloud\_ml\_sdk.\_search\_indexes.combination\_strategy.**ReciprocalRankFusionIndexCombinationStrategy**{#yandex_cloud_ml_sdk._search_indexes.combination_strategy.ReciprocalRankFusionIndexCombinationStrategy}

ReciprocalRankFusionIndexCombinationStrategy(k: ‘int | None’ = None)

**k**\: *[int](https://docs.python.org/3/library/functions.html#int) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._search_indexes.combination_strategy.ReciprocalRankFusionIndexCombinationStrategy.k}

**\_\_init\_\_**(*k=None*){#yandex_cloud_ml_sdk._search_indexes.combination_strategy.ReciprocalRankFusionIndexCombinationStrategy.__init__i}

#|
|| Parameters | **k** ([*int*](https://docs.python.org/3/library/functions.html#int)* \| **None*) ||
|| Return type | None ||
|#

## *class* yandex\_cloud\_ml\_sdk.\_search\_indexes.normalization\_strategy.**IndexNormalizationStrategy**{#yandex_cloud_ml_sdk._search_indexes.normalization_strategy.IndexNormalizationStrategy}

**NORMALIZATION\_STRATEGY\_UNSPECIFIED** = *0*{#yandex_cloud_ml_sdk._search_indexes.normalization_strategy.IndexNormalizationStrategy.NORMALIZATION_STRATEGY_UNSPECIFIED}

**MIN\_MAX** = *1*{#yandex_cloud_ml_sdk._search_indexes.normalization_strategy.IndexNormalizationStrategy.MIN_MAX}

**L2** = *2*{#yandex_cloud_ml_sdk._search_indexes.normalization_strategy.IndexNormalizationStrategy.L2}

**\_\_new\_\_**(*value*){#yandex_cloud_ml_sdk._search_indexes.normalization_strategy.IndexNormalizationStrategy.__new__i}

**conjugate**(){#yandex_cloud_ml_sdk._search_indexes.normalization_strategy.IndexNormalizationStrategy.conjugate}

Returns self, the complex conjugate of any int.

**bit\_length**(){#yandex_cloud_ml_sdk._search_indexes.normalization_strategy.IndexNormalizationStrategy.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**bit\_count**(){#yandex_cloud_ml_sdk._search_indexes.normalization_strategy.IndexNormalizationStrategy.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**as\_integer\_ratio**(){#yandex_cloud_ml_sdk._search_indexes.normalization_strategy.IndexNormalizationStrategy.as_integer_ratio}

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

**is\_integer**(){#yandex_cloud_ml_sdk._search_indexes.normalization_strategy.IndexNormalizationStrategy.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

**real**{#yandex_cloud_ml_sdk._search_indexes.normalization_strategy.IndexNormalizationStrategy.real}

the real part of a complex number

**imag**{#yandex_cloud_ml_sdk._search_indexes.normalization_strategy.IndexNormalizationStrategy.imag}

the imaginary part of a complex number

**numerator**{#yandex_cloud_ml_sdk._search_indexes.normalization_strategy.IndexNormalizationStrategy.numerator}

the numerator of a rational number in lowest terms

**denominator**{#yandex_cloud_ml_sdk._search_indexes.normalization_strategy.IndexNormalizationStrategy.denominator}

the denominator of a rational number in lowest terms

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_cloud_ml_sdk._search_indexes.normalization_strategy.IndexNormalizationStrategy.__init__i}