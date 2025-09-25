---
sourcePath: en/_sdk-ref/sdk-ref/sync/tools.md
---
# Tools domain

## *class* yandex\_cloud\_ml\_sdk.\_tools.domain.**Tools**{#yandex_cloud_ml_sdk._tools.domain.Tools}

*property* **function**\: *[FunctionToolsTypeT](../types/other.md#yandex_cloud_ml_sdk._tools.function.FunctionToolsTypeT)*{#yandex_cloud_ml_sdk._tools.domain.Tools.function}

**generative\_search**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *description*, *site=Undefined*, *host=Undefined*, *url=Undefined*, *enable\_nrfm\_docs=Undefined*, *search\_filters=Undefined*){#yandex_cloud_ml_sdk._tools.domain.Tools.generative_search}

Creates GeberativeSearch tool which provide access to generative search by [Search API](https://yandex.cloud/docs/search-api) for LLMs.

Not to be confused with **sdk.search\_api.generative**. Tools domain is for creating tools for using in LLMs/Assistants and search\_api domain is for using Search API directly.

To learn more about parameters and their formats and possible values, refer to [generative search documentation](https://yandex.cloud/docs/search-api/concepts/generative-response#body)

NB: All of the **site**, **host**, **url** parameters are mutually exclusive.

#|
|| Parameters | 

- **site** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – parameter for limiting search to specific location or list of sites.
- **host** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – parameter for limiting search to specific location or list of hosts.
- **url** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – parameter for limiting search to specific location or list of URLs.
- **enable\_nrfm\_docs** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – tells to backend to include or not to include pages, which are not available via direct clicks from given sites/hosts/urls to search result.
- **search\_filters** ([*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*DateFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.DateFilterType) *\|* [*FormatFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.FormatFilterType) *\|* [*LangFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.LangFilterType)*] \|* [*DateFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.DateFilterType) *\|* [*FormatFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.FormatFilterType) *\|* [*LangFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.LangFilterType) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – allows to limit search results with additional filters.
```python
>>> date_filter = {'date': '<20250101'}
>>> format_filter = {'format': 'doc'}
>>> lang_filter = {'lang': 'ru'}
>>> tool = sdk.tools.generative_search(
...     search_filters=[date_filter, format_filter, lang_filter],
...     description="description when model should call a tool"
... )
```

- **description** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) ||
|| Return type | [*GenerativeSearchTool*](../types/tools.md#yandex_cloud_ml_sdk._tools.generative_search.GenerativeSearchTool) ||
|#

*property* **rephraser**\: *[RephraserFunction](../types/tools.md#yandex_cloud_ml_sdk._tools.search_index.rephraser.function.RephraserFunction)*{#yandex_cloud_ml_sdk._tools.domain.Tools.rephraser}

**search\_index**(*indexes*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *max\_num\_results=Undefined*, *rephraser=Undefined*, *call\_strategy=Undefined*){#yandex_cloud_ml_sdk._tools.domain.Tools.search_index}

Creates SearchIndexTool (not to be confused with [**SearchIndex**](search_indexes.md#yandex_cloud_ml_sdk._search_indexes.search_index.SearchIndex)/[**AsyncSearchIndex**](../async/search_indexes.md#yandex_cloud_ml_sdk._search_indexes.search_index.AsyncSearchIndex)).

#|
|| Parameters | 

- **indexes** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseSearchIndex*](../internals/bases.md#yandex_cloud_ml_sdk._search_indexes.search_index.BaseSearchIndex) *\|* [*Iterable*](https://docs.python.org/3/library/typing.html#typing.Iterable)*[*[*BaseSearchIndex*](../internals/bases.md#yandex_cloud_ml_sdk._search_indexes.search_index.BaseSearchIndex)*] \|* [*Iterable*](https://docs.python.org/3/library/typing.html#typing.Iterable)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*]*) – parameter takes [**BaseSearchIndex**](../internals/bases.md#yandex_cloud_ml_sdk._search_indexes.search_index.BaseSearchIndex), string with search index id, or a list of this values in any combination.
- **max\_num\_results** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the maximum number of results to return from the search. Fewer results may be returned if necessary to fit within the prompt’s token limit. This ensures that the combined prompt and search results do not exceed the token constraints.
- **rephraser** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*[True] \| ~yandex\_cloud\_ml\_sdk.\_tools.search\_index.rephraser.model.Rephraser \| ~yandex\_cloud\_ml\_sdk.\_types.misc.Undefined*) – setting for rephrasing user queries; refer to [**Rephraser**](../types/tools.md#yandex_cloud_ml_sdk._tools.search_index.rephraser.model.Rephraser) documentation for details.
- **call\_strategy** ([*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*['always'] \| ~yandex\_cloud\_ml\_sdk.\_types.tools.function.FunctionDictType \| ~yandex\_cloud\_ml\_sdk.\_tools.search\_index.call\_strategy.CallStrategy \| ~yandex\_cloud\_ml\_sdk.\_types.misc.Undefined*) ||
|| Return type | [*SearchIndexTool*](../types/tools.md#yandex_cloud_ml_sdk._tools.search_index.tool.SearchIndexTool) ||
|#

## Types

### *class* yandex\_cloud\_ml\_sdk.\_tools.tool\_call.**ToolCall**{#yandex_cloud_ml_sdk._tools.tool_call.ToolCall}

**id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._tools.tool_call.ToolCall.id}

**function**\: *[FunctionCallTypeT](../types/other.md#yandex_cloud_ml_sdk._tools.function_call.FunctionCallTypeT) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._tools.tool_call.ToolCall.function}

### *class* yandex\_cloud\_ml\_sdk.\_tools.function\_call.**FunctionCall**{#yandex_cloud_ml_sdk._tools.function_call.FunctionCall}

**name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._tools.function_call.FunctionCall.name}

**arguments**\: *JsonObject*{#yandex_cloud_ml_sdk._tools.function_call.FunctionCall.arguments}