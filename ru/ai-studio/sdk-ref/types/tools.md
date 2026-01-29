---
sourcePath: en/_sdk-ref/sdk-ref/types/tools.md
---
# Tools

## Search index tool

### *class* yandex\_ai\_studio\_sdk.\_tools.search\_index.tool.**SearchIndexTool**{#yandex_ai_studio_sdk._tools.search_index.tool.SearchIndexTool}

Tool for working with search indexes.

A SearchIndexTool represents an executable tool that provides instructions on how to apply and interact with search indexes, as opposed to a SearchIndex which represents the data/resource itself — actual search index data and provides methods for managing the index (adding files, updating metadata, etc.). A SearchIndexTool encapsulates the configuration and behavior for performing search operations across one or more search indexes.

**search\_index\_ids**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[str](https://docs.python.org/3/library/stdtypes.html#str)*]... ,{#yandex_ai_studio_sdk._tools.search_index.tool.SearchIndexTool.search_index_ids}

Tuple of search index IDs to use with this tool

**max\_num\_results**\: *[int](https://docs.python.org/3/library/functions.html#int) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_ai_studio_sdk._tools.search_index.tool.SearchIndexTool.max_num_results}

Maximum number of results to return from search, optional

**rephraser**\: *[Rephraser](#yandex_ai_studio_sdk._tools.search_index.rephraser.model.Rephraser) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_ai_studio_sdk._tools.search_index.tool.SearchIndexTool.rephraser}

Rephraser instance for query rephrasing, optional

**call\_strategy**\: *[CallStrategy](#yandex_ai_studio_sdk._tools.search_index.call_strategy.CallStrategy) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_ai_studio_sdk._tools.search_index.tool.SearchIndexTool.call_strategy}

Strategy for calling the search index, optional

### *class* yandex\_ai\_studio\_sdk.\_tools.search\_index.rephraser.function.**RephraserFunction**{#yandex_ai_studio_sdk._tools.search_index.rephraser.function.RephraserFunction}

Function for creating Rephraser object, which incapsulating rephrasing settings.

**\_\_call\_\_**(*model\_name*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *model\_version='latest'*){#yandex_ai_studio_sdk._tools.search_index.rephraser.function.RephraserFunction.__call__i}

Creates a Rephraser object, which incapsulating rephrasing settings.

#|
|| Parameters | 

- **model\_name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*[True] \| ~yandex\_ai\_studio\_sdk.\_tools.search\_index.rephraser.model.Rephraser*) – Model ID used for model uri definition in a resulting Rephraser object. It is handled differently depending on the type and format of the input value:
- If **model\_name** includes **\://** substring, it would be used unchanged.
- Otherwise if **model\_name** is a string, it would be used in **gpt://<folder\_id>/<model\_name>/<model\_version>** template.
- If **model\_name** is a True, it would be transformed into default value **gpt://<folder\_id>/rephraser/<model\_version>**
- If **model\_name** is a Rephraser object, it would returned unchanged.

- **model\_version** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – **<model\_version>** value for model uri template, refer to model\_name parameter documentation for details. ||
|| Returns | Rephraser object, which incapsulating rephrasing settings ||
|| Return type | [*Rephraser*](#yandex_ai_studio_sdk._tools.search_index.rephraser.model.Rephraser) ||
|#

### *class* yandex\_ai\_studio\_sdk.\_tools.search\_index.rephraser.model.**Rephraser**{#yandex_ai_studio_sdk._tools.search_index.rephraser.model.Rephraser}

Class for incapsulating rephraser settings.

Used to rewrite the last user message for search, incorporating context from the previous conversation.

For usage search index tool with and without rephraser example see ([sync SDK](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/blob/master/examples/sync/assistants/rephraser.py)/[async SDK](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/blob/master/examples/async/assistants/rephraser.py)).

*property* **config**\: *[ConfigTypeT](other.md#yandex_ai_studio_sdk._types.model_config.ConfigTypeT)*{#yandex_ai_studio_sdk._tools.search_index.rephraser.model.Rephraser.config}

**configure**(*\*\*kwargs*){#yandex_ai_studio_sdk._tools.search_index.rephraser.model.Rephraser.configure}

#|
|| Return type | Self ||
|#

*property* **fine\_tuned**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._tools.search_index.rephraser.model.Rephraser.fine_tuned}

*property* **name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._tools.search_index.rephraser.model.Rephraser.name}

*property* **owner**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._tools.search_index.rephraser.model.Rephraser.owner}

*property* **uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._tools.search_index.rephraser.model.Rephraser.uri}

*property* **version**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._tools.search_index.rephraser.model.Rephraser.version}

### *class* yandex\_ai\_studio\_sdk.\_tools.search\_index.call\_strategy.**CallStrategy**{#yandex_ai_studio_sdk._tools.search_index.call_strategy.CallStrategy}

Represents call strategy for search index tools.

The call strategy determines when a tool should be called: - ‘always’: call the tool on every request - function dict: call based on function instruction

*property* **value**\: *[Literal](https://docs.python.org/3/library/typing.html#typing.Literal)['always'] | [FunctionDictType](message.md#yandex_ai_studio_sdk._types.tools.function.FunctionDictType)*{#yandex_ai_studio_sdk._tools.search_index.call_strategy.CallStrategy.value}

Get the current call strategy value.

## Function tool

### *class* yandex\_ai\_studio\_sdk.\_tools.tool.**FunctionTool**{#yandex_ai_studio_sdk._tools.tool.FunctionTool}

A function tool that can be called by AI models.

This class represents a callable function that can be used by AI models for function calling capabilities. It encapsulates the function’s metadata including its name, description, parameter schema, and validation settings.

The function tool can be used with both completions and assistants APIs, providing a unified interface for defining external functions that models can invoke during conversations or completion requests.

**name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._tools.tool.FunctionTool.name}

Name of the function

**description**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._tools.tool.FunctionTool.description}

Optional function description

**parameters**\: *JsonSchemaType*{#yandex_ai_studio_sdk._tools.tool.FunctionTool.parameters}

Function parameters schema

**strict**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._tools.tool.FunctionTool.strict}

Whether to enforce strict parameter validation

## Generative search tool

### *class* yandex\_ai\_studio\_sdk.\_tools.generative\_search.**GenerativeSearchTool**{#yandex_ai_studio_sdk._tools.generative_search.GenerativeSearchTool}

A generative search tool that can be called by LLMs/Assistants models.

To learn more about generative search itself, refer to [generative search documentation](https://yandex.cloud/docs/search-api/concepts/generative-response#body)

Objects of this class could be used in any place which requires [**BaseTool**](../internals/bases.md#yandex_ai_studio_sdk._tools.tool.BaseTool) instance, but not every place/feature supports all of the tool types.

**description**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)* = *''*{#yandex_ai_studio_sdk._tools.generative_search.GenerativeSearchTool.description}

Description of tool instance which also instructs model when to call it.

**enable\_nrfm\_docs**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_ai_studio_sdk._tools.generative_search.GenerativeSearchTool.enable_nrfm_docs}

tells to backend to include or not to include pages, which are not available via direct clicks from given sites/hosts/urls to search result.

**fix\_misspell**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_ai_studio_sdk._tools.generative_search.GenerativeSearchTool.fix_misspell}

tells to backend to fix or not to fix misspels in queries.

**host**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[str](https://docs.python.org/3/library/stdtypes.html#str), ...] | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_ai_studio_sdk._tools.generative_search.GenerativeSearchTool.host}

Parameter for limiting search to specific location or list of hosts.

**search\_filters**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[FilterType](search_api.md#yandex_ai_studio_sdk._search_api.generative.result.yandex_ai_studio_sdk._search_api.generative.config.FilterType), ...] | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_ai_studio_sdk._tools.generative_search.GenerativeSearchTool.search_filters}

allows to limit search results with additional filters.

**site**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[str](https://docs.python.org/3/library/stdtypes.html#str), ...] | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_ai_studio_sdk._tools.generative_search.GenerativeSearchTool.site}

Parameter for limiting search to specific location or list of sites.

**url**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[str](https://docs.python.org/3/library/stdtypes.html#str), ...] | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_ai_studio_sdk._tools.generative_search.GenerativeSearchTool.url}

Parameter for limiting search to specific location or list of urls.