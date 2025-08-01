# Поисковые индексы

Вы можете загружать для AI-ассистента, созданного с помощью {{ assistant-api }}, документы с дополнительной информацией. Поисковые индексы помогают ориентироваться в загруженных документах, чтобы при генерации ответов языковая модель могла использовать эту информацию.

В {{ assistant-api }} доступны следующие типы поиска: {#search-types}

* _Текстовый_ поиск или поиск по ключевым словам — это традиционный вид поиска, при котором каждое слово разбивается на части, и эти части ищутся в документе. Чем больше частей искомого слова или фразы найдено в тексте, тем более релевантным будет результат. Например, при запросе `свет` текстовый поиск найдет фрагменты, содержащие слова `светящийся` и `освещение`, но не `лампочка`.
* _Векторный_ или смысловой поиск позволяет находить в тексте синонимы и близкие по значению слова и фразы. В результатах векторного поиска слова `свет` будут содержаться не только однокоренные слова, но и близкие по смыслу: `лампочка`, `люстра` или `солнце`.
* _Гибридный_ поиск комбинирует текстовый и векторный поиск. При создании гибридного поискового индекса вы можете настроить, какой из типов поиска будет оказывать большее влияние на результаты.

{% note tip %}

При создании базы знаний для AI-ассистента используйте векторный или гибридный тип поиска.

Если в первую очередь вам важно точное совпадение ключевых слов, создайте текстовый или гибридный поисковый индекс.

{% endnote %}

При создании поискового индекса загруженные файлы разбиваются на чанки (chunks) — фрагменты текста от нескольких строк до нескольких абзацев, а текстовые символы преобразуются в [токены](../yandexgpt/tokens.md). Когда пользователь задает вопрос, ассистент ищет релевантную информацию и добавляет в контекст запроса найденные чанки. При разбиении информации на чанки не учитывается смысл, поэтому текст может быть разделен, например, в середине предложения. Тогда контекст окажется неполным. Чтобы уменьшить потери информации из-за разрыва контекста, при разбиении данных на чанки используют _перекрытие_. Оно позволяет сохранить часть информации одновременно в двух соседних чанках. Чем больше размер чанков, тем больше контекста получит модель для генерации ответа, но тем медленнее и дороже будет обработка запроса. При создании поискового индекса вы можете использовать [дообученую модель эмбеддингов](../../operations/tuning/create-embeddings.md).

Размер чанков и перекрытия, политика токенизации и другие настройки влияют на качество поиска. Не существует универсальных параметров, работающих одинаково на всех типах данных, поэтому параметры для оптимального поиска необходимо отдельно подбирать для каждого случая. 

## Текстовые поисковые индексы {#text-search}

При работе с текстовым поисковым индексом вы можете настроить размер чанка и размер перекрытия чанков в [группе параметров](../../searchindex/api-ref/grpc/SearchIndex/create.md#yandex.cloud.ai.assistants.v1.searchindex.StaticChunkingStrategy) `StaticChunkingStrategy`. Размеры указываются в токенах, в текстовом поиске один токен равен одному символу.

На качество текстового поиска также влияют параметры [политики токенизации](../../searchindex/api-ref/grpc/SearchIndex/create.md#yandex.cloud.ai.assistants.v1.searchindex.NgramTokenizer) `NgramTokenizer`. С ее помощью вы можете задать минимальный и максимальный размер перекрывающих последовательностей символов, на которые разбивается искомая строка, и управлять частичным совпадением в результатах поиска.

Пример создания текстового поискового индекса для одного файла:

{% list tabs group=programming_language %}

- SDK {#sdk}

  ```python
  from yandex_cloud_ml_sdk import YCloudML
  from yandex_cloud_ml_sdk import search_indexes
  
  file = sdk.files.upload("<путь_к_файлу>")
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
   -H "Authorization: Bearer <IAM-токен>" \
   -d @ \
   {{ api-host-llm }}:443 yandex.cloud.ai.assistants.v1.SearchIndexService.Create <<EOM
     {
      "folder_id": "<идентификатор_каталога>",
      "file_ids": [ "<идентификатор_файла>" ],
      "name": "название_индекса",
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

## Векторные поисковые индексы {#vector-search}

При создании векторного индекса модель [эмбеддинга](../embeddings.md) создает из чанков векторы, которые хранят смысл текстового фрагмента. Как и в текстовом поиске, вы можете указать размер чанка и размер перекрытия чанков в токенах. Учитывайте, что в векторном поиске токены, как правило, содержат больше одного символа.

Также вы можете переопределить модели эмбеддингов для запросов и ответов. По умолчанию используются модели эмбеддингов {{ foundation-models-name }}. [Дообученные](../../operations/tuning/create-embeddings.md) модели эмбеддингов позволят улучшить качество векторного поиска на специфичных доменах.

Пример создания векторного поиска для одного файла:

{% list tabs group=programming_language %}

- SDK {#sdk}

  ```python
  from yandex_cloud_ml_sdk import YCloudML
  from yandex_cloud_ml_sdk import search_indexes
  
  file = sdk.files.upload("<путь_к_файлу>")
  operation = sdk.search_indexes.create_deferred(
      files,
      index_type=VectorSearchIndexType(
          doc_embedder_uri="emb://<идентификатор_каталога>/text-search-doc/latest",
          query_embedder_uri="emb://<идентификатор_каталога>/text-search-query/latest",
          chunking_strategy=StaticIndexChunkingStrategy(
              max_chunk_size_tokens=700,
              chunk_overlap_tokens=300,
          )
  )
  ```

- API {#api}

  ```json
  grpcurl \
   -H "Authorization: Bearer <IAM-токен>" \
   -d @ \
   {{ api-host-llm }}:443 yandex.cloud.ai.assistants.v1.SearchIndexService.Create <<EOM
     {
      "folder_id": "<идентификатор_каталога>",
      "file_ids": [ "<идентификатор_файла>" ],
      "name": "название_индекса",
      "vector_search_index": {
        "doc_embedder_uri": "emb://<идентификатор_каталога>/text-search-doc/latest",
        "query_embedder_uri": "emb://<идентификатор_каталога>/text-search-query/latest",
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

## Гибридный поиск {#hybrid-search}

Гибридный поисковый индекс состоит из текстового и векторного индексов и содержит дополнительные настройки для согласования результатов поиска. Вы можете задавать политики чанкования для каждого типа индексов отдельно, однако скорее всего это не приведет к оптимальным результатам. Задавайте настройки политики чанкования в гибридном поиске глобально, чтобы содержание чанков для текстового и векторного индексов совпадали. В этом случае деление на чанки будет основано на токенах векторного индекса. 

Итоговые результаты гибридного поиска будут зависеть от стратегии комбинирования результатов каждого индекса. [Параметр](../../searchindex/api-ref/grpc/SearchIndex/create.md#yandex.cloud.ai.assistants.v1.searchindex.CombinationStrategy) `combination_strategy` позволяет выбрать один из двух способ объединения результатов текстового и векторного индексов:

* `rrf_combination` ([Reciprocal Rank Fusion](https://plg.uwaterloo.ca/~gvcormac/cormacksigir09-rrf.pdf), RRF) — метод объединения, придающий большее значение элементам, занимающим высшие позиции в каждом из индексов.
* `mean_combination` — метод объединения на основе среднего значения. На выбор доступны среднее арифметическое, среднее геометрическое и среднее гармоническое. Дополнительно можно указать веса каждого индекса: первое значение будет задавать вес текстового поиска, второе — векторного. Сумма весов должна быть равна 1. По умолчанию используется среднее арифметическое.

Системы оценки качества текстового и векторного поиска различаются. Чтобы правильно интерпретировать результаты поиска, необходимо нормализовать эти оценки. Вы можете выбрать тип нормализации с помощью [параметра](../../searchindex/api-ref/grpc/SearchIndex/create.md#yandex.cloud.ai.assistants.v1.searchindex.HybridSearchIndex) `normalization_strategy`:

* `MIN_MAX` — [минимально-максимальная нормализация](https://en.wikipedia.org/wiki/Feature_scaling#Rescaling_(min-max_normalization)), нормализованные результаты находятся в диапазоне от 0 до 1. При использовании минимально-максимальной нормализации усиливается разница между лучшими и худшими оценками результатов поиска. По умолчанию используется нормализация `MIN_MAX`.
* `L2` — [L2-нормализация](https://en.wikipedia.org/wiki/Cosine_similarity#L2-normalized_Euclidean_distance) на основе Евклидовых расстояний. L2-нормализация сглаживает влияние лучших и худших оценок на общие результаты поиска.

{% note tip %}

При создании поискового индекса для AI-ассистента на основе документации наилучшие результаты показывает гибридный поиск со стратегией комбинирования RRF. При этом тип нормализации не оказывает принципиальное влияние на итоговый результат, поскольку метод RRF нормализует результаты.

Использование одной политики чанкования для текстового и векторного поиска также повышает качество поиска.

{% endnote %}

Пример создания гибридного поиска для одного файла:

{% list tabs group=programming_language %}

- SDK {#sdk}

  ```python
  from yandex_cloud_ml_sdk import YCloudML
  from yandex_cloud_ml_sdk import search_indexes
  
  file = sdk.files.upload("<путь_к_файлу>")
  operation = sdk.search_indexes.create_deferred(
      files,
      index_type=HybridSearchIndexType(
        # Используйте глобальные параметры, чтобы размеры чанков двух индексов совпадали
        chunking_strategy=StaticIndexChunkingStrategy(
            max_chunk_size_tokens=700,
            chunk_overlap_tokens=300
            ),
        vector_search_index=VectorSearchIndexType(
            doc_embedder_uri="emb://<идентификатор_каталога>/text-search-doc/latest",
            query_embedder_uri="emb://<идентификатор_каталога>/text-search-query/latest"
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
   -H "Authorization: Bearer <IAM-токен>" \
   -d @ \
   {{ api-host-llm }}:443 yandex.cloud.ai.assistants.v1.SearchIndexService.Create <<EOM
     {
      "folder_id": "<идентификатор_каталога>",
      "file_ids": [ "<идентификатор_файла>" ],
      "name": "название_индекса",
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
          "doc_embedder_uri": "emb://<идентификатор_каталога>/text-search-doc/latest",
          "query_embedder_uri": "emb://<идентификатор_каталога>/text-search-query/latest",
        }
      }
     }
  ```

{% endlist %}


## Примеры использования {#eamples}

* [{#T}](../../operations/assistant/create-with-searchindex.md)
* Примеры работы с {{ ml-sdk-name }} на [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/assistants)

#### См. также {#see-also}

[{#T}](../../operations/tuning/create-embeddings.md)
