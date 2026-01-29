---
sourcePath: en/_sdk-ref/sdk-ref/sync/tools.md
---
# Tools domain

## *class* yandex\_ai\_studio\_sdk.\_tools.domain.**Tools**{#yandex_ai_studio_sdk._tools.domain.Tools}

Class for tools functionality.

Tools are specialized utilities that extend the capabilities of language models and AI assistants by providing access to external functions, data sources, and computational resources. They enable models to perform actions beyond text generation, such as searching through knowledge bases, executing custom functions, and processing structured data.

This class serves as the foundation for tool management in both synchronous and asynchronous contexts, providing a unified interface for tools. For more information see the description of members of this class.

Tools are particularly useful in:

- **AI Assistants**\: Extending conversational agents with external capabilities like web search, database queries, or API calls
- **Completions**\: Enabling language models to invoke functions during text generation for dynamic content creation and problem-solving

The tools framework supports both streaming and non-streaming operations, making it suitable for real-time applications and batch processing scenarios.

*property* **function**\: *[FunctionToolsTypeT](../types/other.md#yandex_ai_studio_sdk._tools.function.FunctionToolsTypeT)*{#yandex_ai_studio_sdk._tools.domain.Tools.function}

Get the function sub-domain for creating function tools.

**generative\_search**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *description*, *site=Undefined*, *host=Undefined*, *url=Undefined*, *enable\_nrfm\_docs=Undefined*, *search\_filters=Undefined*){#yandex_ai_studio_sdk._tools.domain.Tools.generative_search}

Creates GeberativeSearch tool which provide access to generative search by [Search API](https://yandex.cloud/docs/search-api) for LLMs.

Not to be confused with **sdk.search\_api.generative**. Tools domain is for creating tools for using in LLMs/Assistants and search\_api domain is for using Search API directly.

To learn more about parameters and their formats and possible values, refer to [generative search documentation](https://yandex.cloud/docs/search-api/concepts/generative-response#body)

NB: All of the **site**, **host**, **url** parameters are mutually exclusive.

#|
|| Parameters | 

- **site** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – parameter for limiting search to specific location or list of sites.
- **host** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – parameter for limiting search to specific location or list of hosts.
- **url** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – parameter for limiting search to specific location or list of URLs.
- **enable\_nrfm\_docs** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – tells to backend to include or not to include pages, which are not available via direct clicks from given sites/hosts/urls to search result.
- **search\_filters** ([*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*DateFilterType*](../types/search_api.md#yandex_ai_studio_sdk._search_api.generative.config.DateFilterType) *\|* [*FormatFilterType*](../types/search_api.md#yandex_ai_studio_sdk._search_api.generative.config.FormatFilterType) *\|* [*LangFilterType*](../types/search_api.md#yandex_ai_studio_sdk._search_api.generative.config.LangFilterType)*] \|* [*DateFilterType*](../types/search_api.md#yandex_ai_studio_sdk._search_api.generative.config.DateFilterType) *\|* [*FormatFilterType*](../types/search_api.md#yandex_ai_studio_sdk._search_api.generative.config.FormatFilterType) *\|* [*LangFilterType*](../types/search_api.md#yandex_ai_studio_sdk._search_api.generative.config.LangFilterType) *\|* [*Undefined*](../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – allows to limit search results with additional filters.
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
|| Return type | [*GenerativeSearchTool*](../types/tools.md#yandex_ai_studio_sdk._tools.generative_search.GenerativeSearchTool) ||
|#

*property* **rephraser**\: *[RephraserFunction](../types/tools.md#yandex_ai_studio_sdk._tools.search_index.rephraser.function.RephraserFunction)*{#yandex_ai_studio_sdk._tools.domain.Tools.rephraser}

Get the rephraser for creating query transformation models.

The rephraser provides access to specialized language models designed to intelligently rewrite and enhance user search queries by incorporating conversational context. This is particularly useful in multi-turn conversations where the latest user message may lack context from previous exchanges.

The rephraser works by: - Analyzing the conversation history and current user query - Reformulating the query to be more specific and contextually complete - Improving search relevance by expanding abbreviated or ambiguous terms - Maintaining semantic intent while adding necessary context

The rephraser returns a factory that can create Rephraser model instances with different configurations, supporting various model types including the default ‘rephraser’ model or custom rephrasing models.

**search\_index**(*indexes*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *max\_num\_results=Undefined*, *rephraser=Undefined*, *call\_strategy=Undefined*){#yandex_ai_studio_sdk._tools.domain.Tools.search_index}

Creates SearchIndexTool (not to be confused with [**SearchIndex**](search_indexes.md#yandex_ai_studio_sdk._search_indexes.search_index.SearchIndex)/[**AsyncSearchIndex**](../async/search_indexes.md#yandex_ai_studio_sdk._search_indexes.search_index.AsyncSearchIndex)).

#|
|| Parameters | 

- **indexes** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseSearchIndex*](../internals/bases.md#yandex_ai_studio_sdk._search_indexes.search_index.BaseSearchIndex) *\|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable)*[*[*BaseSearchIndex*](../internals/bases.md#yandex_ai_studio_sdk._search_indexes.search_index.BaseSearchIndex)*] \|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*]*) – parameter takes [**BaseSearchIndex**](../internals/bases.md#yandex_ai_studio_sdk._search_indexes.search_index.BaseSearchIndex), string with search index id, or a list of this values in any combination.
- **max\_num\_results** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – the maximum number of results to return from the search. Fewer results may be returned if necessary to fit within the prompt’s token limit. This ensures that the combined prompt and search results do not exceed the token constraints.
- **rephraser** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*[True] \| ~yandex\_ai\_studio\_sdk.\_tools.search\_index.rephraser.model.Rephraser \| ~yandex\_ai\_studio\_sdk.\_types.misc.Undefined*) – setting for rephrasing user queries; refer to [**Rephraser**](../types/tools.md#yandex_ai_studio_sdk._tools.search_index.rephraser.model.Rephraser) documentation for details.
- **call\_strategy** ([*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*['always'] \| ~yandex\_ai\_studio\_sdk.\_types.tools.function.FunctionDictType \| ~yandex\_ai\_studio\_sdk.\_tools.search\_index.call\_strategy.CallStrategy \| ~yandex\_ai\_studio\_sdk.\_types.misc.Undefined*) ||
|| Return type | [*SearchIndexTool*](../types/tools.md#yandex_ai_studio_sdk._tools.search_index.tool.SearchIndexTool) ||
|#

## Types

### *class* yandex\_ai\_studio\_sdk.\_tools.tool\_call.**ToolCall**{#yandex_ai_studio_sdk._tools.tool_call.ToolCall}

A tool call returned by models as a result of server-side tool calls.

This class encapsulates the response from language models when they invoke tools during conversation or completion. It contains information about the specific tool that was called, including its unique identifier and the associated function call with parameters and results.

**id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._tools.tool_call.ToolCall.id}

Unique tool call identifier

**function**\: *[FunctionCallTypeT](../types/other.md#yandex_ai_studio_sdk._tools.function_call.FunctionCallTypeT) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._tools.tool_call.ToolCall.function}

Function call associated with this tool call

### *class* yandex\_ai\_studio\_sdk.\_tools.function\_call.**FunctionCall**{#yandex_ai_studio_sdk._tools.function_call.FunctionCall}

Represents a function call returned by models as a result of server-side tool calls.

This class encapsulates the details of a function call that was invoked by the model during processing, including the function name and the arguments passed to it.

**name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._tools.function_call.FunctionCall.name}

Name of the function being called

**arguments**\: *JsonObject*{#yandex_ai_studio_sdk._tools.function_call.FunctionCall.arguments}

Arguments passed to the function