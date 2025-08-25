---
sourcePath: en/_sdk-ref/sdk-ref/types/search_api.md
---
# Search API

*typeddict* yandex\_cloud\_ml\_sdk.\_search\_api.generative.config.**DateFilterType**{#yandex_cloud_ml_sdk._search_api.generative.config.DateFilterType}

Date filter dict type for generative search.

Example:

```python
>>> filter_ = {'date': '>20240125'}
```

#|
|| Required Keys | 

- **date** ([**str**](https://docs.python.org/3/library/stdtypes.html#str)) ||
|#

*typeddict* yandex\_cloud\_ml\_sdk.\_search\_api.generative.config.**FormatFilterType**{#yandex_cloud_ml_sdk._search_api.generative.config.FormatFilterType}

Format filter dict type for generative search.

Example:

```python
>>> filter_ = {'format': 'xlsx'}
```

#|
|| Required Keys | 

- **format** ([**str**](https://docs.python.org/3/library/stdtypes.html#str)) ||
|#

*typeddict* yandex\_cloud\_ml\_sdk.\_search\_api.generative.config.**LangFilterType**{#yandex_cloud_ml_sdk._search_api.generative.config.LangFilterType}

Language filter dict type for generative search.

Example:

```python
>>> filter_ = {'lang': 'ru'}
```

#|
|| Required Keys | 

- **lang** ([**str**](https://docs.python.org/3/library/stdtypes.html#str)) ||
|#

yandex\_cloud\_ml\_sdk.\_search\_api.generative.config.**format\_to\_proto**(*format\_*){#yandex_cloud_ml_sdk._search_api.generative.config.format_to_proto}

#|
|| Parameters | **format\_** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) ||
|| Return type | <google.protobuf.internal.enum\_type\_wrapper.EnumTypeWrapper object at 0x7f1ec7c6bf80> ||
|#

## *class* yandex\_cloud\_ml\_sdk.\_search\_api.generative.config.**GenerativeSearchConfig**{#yandex_cloud_ml_sdk._search_api.generative.config.GenerativeSearchConfig}

GenerativeSearchConfig(site: ‘tuple[str, …] | None’ = None, host: ‘tuple[str, …] | None’ = None, url: ‘tuple[str, …] | None’ = None, fix\_misspell: ‘bool | None’ = None, enable\_nrfm\_docs: ‘bool | None’ = None, search\_filters: ‘tuple[FilterType] | None’ = None)

**site**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[str](https://docs.python.org/3/library/stdtypes.html#str), ...] | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._search_api.generative.config.GenerativeSearchConfig.site}

**host**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[str](https://docs.python.org/3/library/stdtypes.html#str), ...] | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._search_api.generative.config.GenerativeSearchConfig.host}

**url**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[str](https://docs.python.org/3/library/stdtypes.html#str), ...] | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._search_api.generative.config.GenerativeSearchConfig.url}

**fix\_misspell**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._search_api.generative.config.GenerativeSearchConfig.fix_misspell}

**enable\_nrfm\_docs**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._search_api.generative.config.GenerativeSearchConfig.enable_nrfm_docs}

**search\_filters**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[DateFilterType](#yandex_cloud_ml_sdk._search_api.generative.config.DateFilterType) | [FormatFilterType](#yandex_cloud_ml_sdk._search_api.generative.config.FormatFilterType) | [LangFilterType](#yandex_cloud_ml_sdk._search_api.generative.config.LangFilterType)] | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._search_api.generative.config.GenerativeSearchConfig.search_filters}

## *class* yandex\_cloud\_ml\_sdk.\_search\_api.generative.result.**SearchSource**{#yandex_cloud_ml_sdk._search_api.generative.result.SearchSource}

Source document found for user query.

Might be used or not used in generative answer itself.

**url**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_api.generative.result.SearchSource.url}

Url of the document

**title**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_api.generative.result.SearchSource.title}

Title of the document

**used**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._search_api.generative.result.SearchSource.used}

Has this source been used in generative answer or not

## *class* yandex\_cloud\_ml\_sdk.\_search\_api.generative.result.**SearchQuery**{#yandex_cloud_ml_sdk._search_api.generative.result.SearchQuery}

SearchQuery(text: ‘str’, req\_id: ‘str’)

**text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_api.generative.result.SearchQuery.text}

Text of the search query

**req\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_api.generative.result.SearchQuery.req_id}

Request id

## *class* yandex\_cloud\_ml\_sdk.\_search\_api.generative.result.**GenerativeSearchResult**{#yandex_cloud_ml_sdk._search_api.generative.result.GenerativeSearchResult}

GenerativeSearchResult(role: ‘str’, text: ‘str’, fixed\_misspell\_query: ‘str | None’, is\_answer\_rejected: ‘bool’, is\_bullet\_answer: ‘bool’, sources: ‘tuple[SearchSource, …]’, search\_queries: ‘tuple[SearchQuery, …]’)

**text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_api.generative.result.GenerativeSearchResult.text}

Generative answer itself. Note that footnootes like **[N]** in the text refers to **GenerativeSearchResult.sources[N]** source.

**role**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_api.generative.result.GenerativeSearchResult.role}

Message sender role; in case of the generative search, model always answers with the “assistant” role.

**fixed\_misspell\_query**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._search_api.generative.result.GenerativeSearchResult.fixed_misspell_query}

Fixed query string in case of query was fixed

**is\_answer\_rejected**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._search_api.generative.result.GenerativeSearchResult.is_answer_rejected}

Anwer was rejected by some reasons, probably because of the ethics constrictions

**is\_bullet\_answer**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._search_api.generative.result.GenerativeSearchResult.is_bullet_answer}

Model was unable to give good answer and returned bulleted list with some info.

**sources**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[SearchSource](#yandex_cloud_ml_sdk._search_api.generative.result.SearchSource)*]... ,{#yandex_cloud_ml_sdk._search_api.generative.result.GenerativeSearchResult.sources}

List of documents found by user query; every element number matches with footnotes in the **.text** attribute.

**search\_queries**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[SearchQuery](#yandex_cloud_ml_sdk._search_api.generative.result.SearchQuery)*]... ,{#yandex_cloud_ml_sdk._search_api.generative.result.GenerativeSearchResult.search_queries}

List of search queries sent to model

*property* **content**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_api.generative.result.GenerativeSearchResult.content}

Alias to **GenerativeSearchResult.text**.

Only to add some compatibility with raw Search API answer which have “content” field in protobufs and REST answers unlike other parts of this SDK.