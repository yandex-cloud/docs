---
sourcePath: en/_sdk-ref/sdk-ref/internals/bases.md
---
# Base classes

## *class* yandex\_cloud\_ml\_sdk.\_sdk.**BaseSDK**{#yandex_cloud_ml_sdk._sdk.BaseSDK}

The main class that needs to be instantiated to work with SDK.

**tools**\: *[BaseTools](#yandex_cloud_ml_sdk._tools.domain.BaseTools)*{#yandex_cloud_ml_sdk._sdk.BaseSDK.tools}

Domain for creating various tools for assistants and function calling

**models**\: *[BaseModels](#yandex_cloud_ml_sdk._models.BaseModels)*{#yandex_cloud_ml_sdk._sdk.BaseSDK.models}

Domain for working with models (inference and tuning)

**threads**\: *[BaseThreads](#yandex_cloud_ml_sdk._threads.domain.BaseThreads)*{#yandex_cloud_ml_sdk._sdk.BaseSDK.threads}

Domain for working with threads (a part of the Assistants API)

**files**\: *[BaseFiles](#yandex_cloud_ml_sdk._files.domain.BaseFiles)*{#yandex_cloud_ml_sdk._sdk.BaseSDK.files}

Domain for working with files (a part of the Asssistants API)

**assistants**\: *[BaseAssistants](#yandex_cloud_ml_sdk._assistants.domain.BaseAssistants)*{#yandex_cloud_ml_sdk._sdk.BaseSDK.assistants}

Domain for working with assistants (a part of the Assistants API)

**runs**\: *[BaseRuns](#yandex_cloud_ml_sdk._runs.domain.BaseRuns)*{#yandex_cloud_ml_sdk._sdk.BaseSDK.runs}

Domain for working with assistants’ runs (a part of the Assistants API)

**search\_api**\: *[BaseSearchAPIDomain](#yandex_cloud_ml_sdk._search_api.domain.BaseSearchAPIDomain)*{#yandex_cloud_ml_sdk._sdk.BaseSDK.search_api}

Domain for working with [Search API](https://yandex.cloud/docs/search-api)

**search\_indexes**\: *[BaseSearchIndexes](#yandex_cloud_ml_sdk._search_indexes.domain.BaseSearchIndexes)*{#yandex_cloud_ml_sdk._sdk.BaseSDK.search_indexes}

Domain for working with search indexes (a part of the Assistants API)

**datasets**\: *[BaseDatasets](#yandex_cloud_ml_sdk._datasets.domain.BaseDatasets)*{#yandex_cloud_ml_sdk._sdk.BaseSDK.datasets}

Domain for working with datasets

**tuning**\: *[BaseTuning](#yandex_cloud_ml_sdk._tuning.domain.BaseTuning)*{#yandex_cloud_ml_sdk._sdk.BaseSDK.tuning}

Domain for working with tuning

**batch**\: *[BaseBatch](#yandex_cloud_ml_sdk._batch.domain.BaseBatch)*{#yandex_cloud_ml_sdk._sdk.BaseSDK.batch}

Domain for working with batch tasks

**chat**\: *[BaseChat](#yandex_cloud_ml_sdk._chat.BaseChat)*{#yandex_cloud_ml_sdk._sdk.BaseSDK.chat}

Domain for working with [Yandex Cloud OpenAI Compatible API\_BaseSDK\_URL](https://yandex.cloud/docs/ai-studio/concepts/openai-compatibility).

**setup\_default\_logging**(*log\_level='INFO'*, *log\_format='[%(levelname)1.1s %(asctime)s %(name)s:%(lineno)d] %(message)s'*, *date\_format='%Y-%m-%d %H:%M:%S'*){#yandex_cloud_ml_sdk._sdk.BaseSDK.setup_default_logging}

Sets up the default logging configuration.

Read more about log\_levels, log\_format, and date\_format in [Python documentation (logging)](https://docs.python.org/3/library/logging.html).

#|
|| Parameters | 

- **log\_level** ([*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*['CRITICAL', 'FATAL', 'ERROR', 'WARN', 'WARNING', 'INFO', 'DEBUG', 'TRACE'] \| ~typing.Literal['critical', 'fatal', 'error', 'warn', 'warning', 'info', 'debug', 'TRACE'] \| int*) – The logging level to set.
- **log\_format** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – The format of the log messages.
- **date\_format** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – The format for timestamps in log messages. ||
|| Returns | The instance of the SDK with logging configured. ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

## *class* yandex\_cloud\_ml\_sdk.\_types.domain.**BaseDomain**{#yandex_cloud_ml_sdk._types.domain.BaseDomain}

## *class* yandex\_cloud\_ml\_sdk.\_types.model.**BaseModel**{#yandex_cloud_ml_sdk._types.model.BaseModel}

*property* **uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._types.model.BaseModel.uri}

*property* **config**\: *[ConfigTypeT](../types/other.md#yandex_cloud_ml_sdk._types.model.ConfigTypeT)*{#yandex_cloud_ml_sdk._types.model.BaseModel.config}

**configure**(*\*\*kwargs*){#yandex_cloud_ml_sdk._types.model.BaseModel.configure}

#|
|| Return type | Self ||
|#

## *class* yandex\_cloud\_ml\_sdk.\_types.model\_config.**BaseModelConfig**{#yandex_cloud_ml_sdk._types.model_config.BaseModelConfig}

BaseModelConfig()

## *class* yandex\_cloud\_ml\_sdk.\_auth.**BaseAuth**{#yandex_cloud_ml_sdk._auth.BaseAuth}

Abstract base class for authentication methods.

This class defines the interface for obtaining authentication metadata and checking if the authentication method is applicable from environment variables.

## *class* yandex\_cloud\_ml\_sdk.\_tools.domain.**BaseTools**{#yandex_cloud_ml_sdk._tools.domain.BaseTools}

*property* **function**\: *[FunctionToolsTypeT](../types/other.md#yandex_cloud_ml_sdk._tools.function.FunctionToolsTypeT)*{#yandex_cloud_ml_sdk._tools.domain.BaseTools.function}

*property* **rephraser**\: *[RephraserFunction](../types/tools.md#yandex_cloud_ml_sdk._tools.search_index.rephraser.function.RephraserFunction)*{#yandex_cloud_ml_sdk._tools.domain.BaseTools.rephraser}

**search\_index**(*indexes*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *max\_num\_results=Undefined*, *rephraser=Undefined*, *call\_strategy=Undefined*){#yandex_cloud_ml_sdk._tools.domain.BaseTools.search_index}

Creates SearchIndexTool (not to be confused with [**SearchIndex**](../sync/search_indexes.md#yandex_cloud_ml_sdk._search_indexes.search_index.SearchIndex)/[**AsyncSearchIndex**](../async/search_indexes.md#yandex_cloud_ml_sdk._search_indexes.search_index.AsyncSearchIndex)).

#|
|| Parameters | 

- **indexes** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseSearchIndex*](#yandex_cloud_ml_sdk._search_indexes.search_index.BaseSearchIndex) *\|* [*Iterable*](https://docs.python.org/3/library/typing.html#typing.Iterable)*[*[*BaseSearchIndex*](#yandex_cloud_ml_sdk._search_indexes.search_index.BaseSearchIndex)*] \|* [*Iterable*](https://docs.python.org/3/library/typing.html#typing.Iterable)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*]*) – parameter takes [**BaseSearchIndex**](#yandex_cloud_ml_sdk._search_indexes.search_index.BaseSearchIndex), string with search index id, or a list of this values in any combination.
- **max\_num\_results** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the maximum number of results to return from the search. Fewer results may be returned if necessary to fit within the prompt’s token limit. This ensures that the combined prompt and search results do not exceed the token constraints.
- **rephraser** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*[True] \| ~yandex\_cloud\_ml\_sdk.\_tools.search\_index.rephraser.model.Rephraser \| ~yandex\_cloud\_ml\_sdk.\_types.misc.Undefined*) – setting for rephrasing user queries; refer to [**Rephraser**](../types/tools.md#yandex_cloud_ml_sdk._tools.search_index.rephraser.model.Rephraser) documentation for details.
- **call\_strategy** ([*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*['always'] \| ~yandex\_cloud\_ml\_sdk.\_types.tools.function.FunctionDictType \| ~yandex\_cloud\_ml\_sdk.\_tools.search\_index.call\_strategy.CallStrategy \| ~yandex\_cloud\_ml\_sdk.\_types.misc.Undefined*) ||
|| Return type | [*SearchIndexTool*](../types/tools.md#yandex_cloud_ml_sdk._tools.search_index.tool.SearchIndexTool) ||
|#

**generative\_search**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *description*, *site=Undefined*, *host=Undefined*, *url=Undefined*, *enable\_nrfm\_docs=Undefined*, *search\_filters=Undefined*){#yandex_cloud_ml_sdk._tools.domain.BaseTools.generative_search}

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

## *class* yandex\_cloud\_ml\_sdk.\_tools.function.**BaseFunctionTools**{#yandex_cloud_ml_sdk._tools.function.BaseFunctionTools}

**\_\_call\_\_**(*parameters*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *name=Undefined*, *description=Undefined*, *strict=Undefined*){#yandex_cloud_ml_sdk._tools.function.BaseFunctionTools.__call__i}

Call self as a function.

#|
|| Parameters | 

- **parameters** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*, None \|* [*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*float*](https://docs.python.org/3/library/functions.html#float) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\| TypeAliasForwardRef('yandex\_cloud\_ml\_sdk.\_types.schemas.JsonArray') \|* [*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*, None \|* [*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*float*](https://docs.python.org/3/library/functions.html#float) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\| TypeAliasForwardRef('yandex\_cloud\_ml\_sdk.\_types.schemas.JsonArray') \| JsonObject]] \|* [*type*](https://docs.python.org/3/library/functions.html#type))
- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **description** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **strict** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) ||
|| Return type | [*FunctionTool*](../types/tools.md#yandex_cloud_ml_sdk._tools.tool.FunctionTool) ||
|#

## *class* yandex\_cloud\_ml\_sdk.\_tools.tool.**BaseTool**{#yandex_cloud_ml_sdk._tools.tool.BaseTool}

## *class* yandex\_cloud\_ml\_sdk.\_tools.tool\_call.**BaseToolCall**{#yandex_cloud_ml_sdk._tools.tool_call.BaseToolCall}

BaseToolCall(id: ‘str | None’, function: ‘FunctionCallTypeT | None’, \_proto\_origin: ‘ProtoToolCall | None’, \_json\_origin: ‘JsonObject | None’)

**id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._tools.tool_call.BaseToolCall.id}

**function**\: *[FunctionCallTypeT](../types/other.md#yandex_cloud_ml_sdk._tools.function_call.FunctionCallTypeT) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._tools.tool_call.BaseToolCall.function}

## *class* yandex\_cloud\_ml\_sdk.\_tools.tool\_call\_list.**ToolCallList**{#yandex_cloud_ml_sdk._tools.tool_call_list.ToolCallList}

ToolCallList(tool\_calls: ‘tuple[ToolCallTypeT, …]’, \_proto\_origin: ‘ProtoToolCallListTypeT’)

**count**(*value*) → integer -- return number of occurrences of value{#yandex_cloud_ml_sdk._tools.tool_call_list.ToolCallList.count}

**index**(*value*[, *start*[, *stop*]]) → integer -- return first index of value.{#yandex_cloud_ml_sdk._tools.tool_call_list.ToolCallList.index}

Raises ValueError if the value is not present.

Supporting start and stop arguments is optional, but recommended.

**tool\_calls**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[ToolCallTypeT](../types/other.md#yandex_cloud_ml_sdk._tools.tool_call.ToolCallTypeT)*]... ,{#yandex_cloud_ml_sdk._tools.tool_call_list.ToolCallList.tool_calls}

## *class* yandex\_cloud\_ml\_sdk.\_tools.function\_call.**BaseFunctionCall**{#yandex_cloud_ml_sdk._tools.function_call.BaseFunctionCall}

BaseFunctionCall(name: ‘str’, arguments: ‘JsonObject’, \_proto\_origin: ‘ProtoFunctionCall | None’)

**name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._tools.function_call.BaseFunctionCall.name}

**arguments**\: *JsonObject*{#yandex_cloud_ml_sdk._tools.function_call.BaseFunctionCall.arguments}

## *class* yandex\_cloud\_ml\_sdk.\_models.**BaseModels**{#yandex_cloud_ml_sdk._models.BaseModels}

Domain for working with [Yandex Foundation Models](https://yandex.cloud/ru/services/foundation-models).

**completions**\: *[BaseCompletions](#yandex_cloud_ml_sdk._models.completions.function.BaseCompletions)*{#yandex_cloud_ml_sdk._models.BaseModels.completions}

**text\_classifiers**\: *[BaseTextClassifiers](#yandex_cloud_ml_sdk._models.text_classifiers.function.BaseTextClassifiers)*{#yandex_cloud_ml_sdk._models.BaseModels.text_classifiers}

**image\_generation**\: *[BaseImageGeneration](#yandex_cloud_ml_sdk._models.image_generation.function.BaseImageGeneration)*{#yandex_cloud_ml_sdk._models.BaseModels.image_generation}

**text\_embeddings**\: *[BaseTextEmbeddings](#yandex_cloud_ml_sdk._models.text_embeddings.function.BaseTextEmbeddings)*{#yandex_cloud_ml_sdk._models.BaseModels.text_embeddings}

## *class* yandex\_cloud\_ml\_sdk.\_models.completions.function.**BaseCompletions**{#yandex_cloud_ml_sdk._models.completions.function.BaseCompletions}

A class for handling completions models.

It defines the core functionality for calling a model to generate completions based on the provided model name and version.

**\_\_call\_\_**(*model\_name*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *model\_version='latest'*){#yandex_cloud_ml_sdk._models.completions.function.BaseCompletions.__call__i}

Create a model object to call for generating completions.

This method constructs the URI for the model based on the provided name and version. If the name contains **\://**, it is treated as a full URI. Otherwise, it looks up the model name in the well-known names dictionary. But after this, in any case, we construct a URI in the form **gpt://<folder\_id>/<model>/<version>**.

#|
|| Parameters | 

- **model\_name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – the name or URI of the model to call.
- **model\_version** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – the version of the model to use. Defaults to ‘latest’. ||
|| Return type | [*ModelTypeT*](../types/other.md#yandex_cloud_ml_sdk._types.model.ModelTypeT) ||
|#

## *class* yandex\_cloud\_ml\_sdk.\_models.completions.model.**BaseGPTModel**{#yandex_cloud_ml_sdk._models.completions.model.BaseGPTModel}

A class for GPT models providing various functionalities including tuning, and batch processing.

**langchain**(*model\_type='chat'*, *timeout=60*){#yandex_cloud_ml_sdk._models.completions.model.BaseGPTModel.langchain}

Initializes a langchain model based on the specified model type.

#|
|| Parameters | 

- **model\_type** (*Literal['chat']*) – the type of langchain model to initialize. Defaults to **"chat"**.
- **timeout** ([*int*](https://docs.python.org/3/library/functions.html#int)) – the timeout which sets the default for the langchain model object. Defaults to 60 seconds. ||
|| Return type | BaseYandexLanguageModel ||
|#

**configure**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *temperature=Undefined*, *max\_tokens=Undefined*, *reasoning\_mode=Undefined*, *response\_format=Undefined*, *tools=Undefined*, *parallel\_tool\_calls=Undefined*, *tool\_choice=Undefined*){#yandex_cloud_ml_sdk._models.completions.model.BaseGPTModel.configure}

Configures the model with specified parameters.

#|
|| Parameters | 

- **temperature** ([*float*](https://docs.python.org/3/library/functions.html#float) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a sampling temperature to use - higher values mean more random results. Should be a double number between 0 (inclusive) and 1 (inclusive).
- **max\_tokens** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a maximum number of tokens to generate in the response.
- **reasoning\_mode** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*ReasoningMode*](../types/other.md#yandex_cloud_ml_sdk._models.completions.config.ReasoningMode) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the mode of reasoning to apply during generation, allowing the model to perform internal reasoning before responding. Read more about possible modes in the [reasoning documentation](https://yandex.cloud/docs/foundation-models/text-generation/api-ref/TextGeneration/completion#yandex.cloud.ai.foundation_models.v1.ReasoningOptions).
- **response\_format** ([*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*['json'] \| ~yandex\_cloud\_ml\_sdk.\_types.schemas.JsonSchemaResponseType \| type \| ~yandex\_cloud\_ml\_sdk.\_types.misc.Undefined*) – a format of the response returned by the model. Could be a JsonSchema, a JSON string, or a pydantic model. Read more about possible response formats in the [structured output documentation\_BaseGPTModel\_URL](https://yandex.cloud/docs/ai-studio/concepts/generation/structured-output).
- **tools** ([*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*FunctionTool*](../types/tools.md#yandex_cloud_ml_sdk._tools.tool.FunctionTool)*] \|* [*FunctionTool*](../types/tools.md#yandex_cloud_ml_sdk._tools.tool.FunctionTool) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – tools to use for completion. Can be a sequence or a single tool.
- **parallel\_tool\_calls** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – whether to allow parallel calls to tools during completion. Defaults to **true**.
- **tool\_choice** ([*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*['none', 'None', 'NONE', 'auto', 'Auto', 'AUTO', 'required', 'Required', 'REQUIRED'] \| ~yandex\_cloud\_ml\_sdk.\_types.tools.function.FunctionDictType \| ~yandex\_cloud\_ml\_sdk.\_tools.tool.FunctionTool \| ~yandex\_cloud\_ml\_sdk.\_types.misc.Undefined*) – the strategy for choosing tools. There are several ways to configure **tool\_choice** for query processing: - no tools to call (**tool\_choice='none'**); - required to call any tool (**tool\_choice='required'**); - call a specific tool (**tool\_choice={'type': 'function', 'function': {'name': 'another\_calculator'}}** or directly passing a tool object). ||
|| Returns | new model instance with provided configuration. ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

*property* **batch**\: *[BatchSubdomainTypeT](../types/other.md#yandex_cloud_ml_sdk._types.batch.domain.BatchSubdomainTypeT)*{#yandex_cloud_ml_sdk._models.completions.model.BaseGPTModel.batch}

*property* **config**\: *[ConfigTypeT](../types/other.md#yandex_cloud_ml_sdk._types.model.ConfigTypeT)*{#yandex_cloud_ml_sdk._models.completions.model.BaseGPTModel.config}

*property* **uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._models.completions.model.BaseGPTModel.uri}

## *class* yandex\_cloud\_ml\_sdk.\_models.text\_classifiers.function.**BaseTextClassifiers**{#yandex_cloud_ml_sdk._models.text_classifiers.function.BaseTextClassifiers}

A class for text classifiers.

It provides a common interface for text classification models and constructs the model URI based on the provided model name and version.

**\_\_call\_\_**(*model\_name*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *model\_version='latest'*){#yandex_cloud_ml_sdk._models.text_classifiers.function.BaseTextClassifiers.__call__i}

Call the text classification model.

Constructs the URI for the model based on the provided model’s name and version. If the name contains **\://**, it is treated as a complete URI. Otherwise, it looks up the model name in the well-known names dictionary. But after this, in any case, we construct a URI in the form **cls://<folder\_id>/<model>/<version>**.

#|
|| Parameters | 

- **model\_name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – the name or URI of the model to call.
- **model\_version** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – the version of the model to be used. Defaults to ‘latest’. ||
|#

## *class* yandex\_cloud\_ml\_sdk.\_models.text\_embeddings.function.**BaseTextEmbeddings**{#yandex_cloud_ml_sdk._models.text_embeddings.function.BaseTextEmbeddings}

A class for text embeddings models.

It provides the functionality to call a text embeddings model either by a well-known name or a full URI.

**\_\_call\_\_**(*model\_name*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *model\_version='latest'*){#yandex_cloud_ml_sdk._models.text_embeddings.function.BaseTextEmbeddings.__call__i}

Call the specified model for text embeddings. It returns an instance of the specified type of the model.

This method constructs the URI for the model based on the provided name and version. If the name contains **\://**, it is treated as a full URI. Otherwise, it looks up the model name in the well-known names dictionary. But after this, in any case, we construct a URI in the form **emb://<folder\_id>/<model>/<version>**.

#|
|| Parameters | 

- **model\_name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – the name or URI of the model to call.
- **model\_version** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – the version of the model to use. Defaults to ‘latest’. ||
|#

## *class* yandex\_cloud\_ml\_sdk.\_models.image\_generation.function.**BaseImageGeneration**{#yandex_cloud_ml_sdk._models.image_generation.function.BaseImageGeneration}

A class for image generation models.

It provides the functionality to call an image generation model by constructing the appropriate URI based on the provided model name and version.

Returns a model’s object through which requests to the backend are made.

```python
>>> model = sdk.models.image_generation('yandex-art')  # this is how the model is created
```

**\_\_call\_\_**(*model\_name*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *model\_version='latest'*){#yandex_cloud_ml_sdk._models.image_generation.function.BaseImageGeneration.__call__i}

Call the image generation model with the specified name and version.

Constructs the URI for the model based on the provided model’s name and version. If the name contains **\://**, it is treated as a complete URI. Otherwise, it looks up the model name in the well-known names dictionary. But after this, in any case, we construct a URI in the form **art://<folder\_id>/<model>/<version>**.

#|
|| Parameters | 

- **model\_name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – the name or URI of the model to call.
- **model\_version** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – the version of the model to use. Defaults to ‘latest’. ||
|#

## *class* yandex\_cloud\_ml\_sdk.\_threads.domain.**BaseThreads**{#yandex_cloud_ml_sdk._threads.domain.BaseThreads}

A class for managing threads. It is a part of Assistants API.

This class provides methods to create, retrieve, and list threads.

## *class* yandex\_cloud\_ml\_sdk.\_threads.thread.**BaseThread**{#yandex_cloud_ml_sdk._threads.thread.BaseThread}

A class for a thread resource.

It provides methods for working with messages that the thread contains (e.g. updating, deleting, writing to, and reading from).

**expiration\_config**\: *[ExpirationConfig](../types/assistants.md#yandex_cloud_ml_sdk._types.expiration.ExpirationConfig)*{#yandex_cloud_ml_sdk._threads.thread.BaseThread.expiration_config}

**id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._threads.thread.BaseThread.id}

## *class* yandex\_cloud\_ml\_sdk.\_files.domain.**BaseFiles**{#yandex_cloud_ml_sdk._files.domain.BaseFiles}

Files domain, which contains API for working with files.

Files is a part of [Assistants API](https://yandex.cloud/ru/docs/foundation-models/concepts/assistant), which is the only place you could use it. Provides upload, get and list methods that allow you to work with remote file objects you created earlier.

## *class* yandex\_cloud\_ml\_sdk.\_files.file.**BaseFile**{#yandex_cloud_ml_sdk._files.file.BaseFile}

BaseFile(id: ‘str’, \_sdk: ‘BaseSDK’, \_lock: ‘asyncio.Lock’, \_deleted: ‘bool’, expiration\_config: ‘ExpirationConfig’)

**expiration\_config**\: *[ExpirationConfig](../types/assistants.md#yandex_cloud_ml_sdk._types.expiration.ExpirationConfig)*{#yandex_cloud_ml_sdk._files.file.BaseFile.expiration_config}

**id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._files.file.BaseFile.id}

## *class* yandex\_cloud\_ml\_sdk.\_assistants.domain.**BaseAssistants**{#yandex_cloud_ml_sdk._assistants.domain.BaseAssistants}

Base class for assistants management.

Provides common functionality for creating, getting and listing assistants.

## *class* yandex\_cloud\_ml\_sdk.\_assistants.assistant.**BaseAssistant**{#yandex_cloud_ml_sdk._assistants.assistant.BaseAssistant}

BaseAssistant(id: ‘str’, \_sdk: ‘BaseSDK’, \_lock: ‘asyncio.Lock’, \_deleted: ‘bool’, expiration\_config: ‘ExpirationConfig’, model: ‘BaseGPTModel’, instruction: ‘str | None’, prompt\_truncation\_options: ‘PromptTruncationOptions’, tools: ‘tuple[BaseTool, …]’, response\_format: ‘ResponseType | None’)

**expiration\_config**\: *[ExpirationConfig](../types/assistants.md#yandex_cloud_ml_sdk._types.expiration.ExpirationConfig)*{#yandex_cloud_ml_sdk._assistants.assistant.BaseAssistant.expiration_config}

Expiration configuration for the assistant.

**model**\: *[BaseGPTModel](#yandex_cloud_ml_sdk._models.completions.model.BaseGPTModel)*{#yandex_cloud_ml_sdk._assistants.assistant.BaseAssistant.model}

The GPT model used by the assistant.

**instruction**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._assistants.assistant.BaseAssistant.instruction}

Instructions or guidelines that the assistant should follow. These instructions guide the assistant’s behavior and responses.

**prompt\_truncation\_options**\: *[PromptTruncationOptions](../types/assistants.md#yandex_cloud_ml_sdk._assistants.prompt_truncation_options.PromptTruncationOptions)*{#yandex_cloud_ml_sdk._assistants.assistant.BaseAssistant.prompt_truncation_options}

Options for truncating thread messages. Controls how messages are truncated when forming the prompt.

**tools**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[BaseTool](#yandex_cloud_ml_sdk._tools.tool.BaseTool)*]... ,{#yandex_cloud_ml_sdk._assistants.assistant.BaseAssistant.tools}

Tools available to the assistant. Can be a sequence or a single tool. Tools must implement BaseTool interface.

**response\_format**\: *ResponseType | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._assistants.assistant.BaseAssistant.response_format}

A format of the response returned by the model. Could be a JsonSchema, a JSON string, or a pydantic model

*property* **max\_prompt\_tokens**\: *[int](https://docs.python.org/3/library/functions.html#int) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._assistants.assistant.BaseAssistant.max_prompt_tokens}

Returns the maximum number of prompt tokens allowed for the assistant.

**id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._assistants.assistant.BaseAssistant.id}

## *class* yandex\_cloud\_ml\_sdk.\_runs.domain.**BaseRuns**{#yandex_cloud_ml_sdk._runs.domain.BaseRuns}

Class for Runs operations. Provides core functionality for managing assistant execution in streams.

For usage examples see [runs example](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/blob/master/examples/{link}/assistants/runs.py).

## *class* yandex\_cloud\_ml\_sdk.\_runs.run.**BaseRun**{#yandex_cloud_ml_sdk._runs.run.BaseRun}

BaseRun(id: ‘str’, \_sdk: ‘BaseSDK’, assistant\_id: ‘str’, thread\_id: ‘str’, created\_by: ‘str’, created\_at: ‘datetime’, labels: ‘dict[str, str] | None’, custom\_temperature: ‘float | None’, custom\_max\_tokens: ‘int | None’, custom\_prompt\_truncation\_options: ‘PromptTruncationOptions | None’, custom\_response\_format: ‘ResponseType | None’)

**id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._runs.run.BaseRun.id}

Unique run identifier

**assistant\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._runs.run.BaseRun.assistant_id}

ID of the assistant used

**thread\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._runs.run.BaseRun.thread_id}

ID of the thread used

**created\_by**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._runs.run.BaseRun.created_by}

Creator of the run

**created\_at**\: *datetime*{#yandex_cloud_ml_sdk._runs.run.BaseRun.created_at}

Creation timestamp

**labels**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [str](https://docs.python.org/3/library/stdtypes.html#str)] | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.run.BaseRun.labels}

Optional metadata labels

**custom\_temperature**\: *[float](https://docs.python.org/3/library/functions.html#float) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.run.BaseRun.custom_temperature}

Custom temperature setting

**custom\_max\_tokens**\: *[int](https://docs.python.org/3/library/functions.html#int) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.run.BaseRun.custom_max_tokens}

Custom max tokens setting

**custom\_prompt\_truncation\_options**\: *[PromptTruncationOptions](../types/assistants.md#yandex_cloud_ml_sdk._assistants.prompt_truncation_options.PromptTruncationOptions) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.run.BaseRun.custom_prompt_truncation_options}

Custom prompt truncation options

**custom\_response\_format**\: *ResponseType | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.run.BaseRun.custom_response_format}

Custom response format

*property* **custom\_max\_prompt\_tokens**\: *[int](https://docs.python.org/3/library/functions.html#int) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.run.BaseRun.custom_max_prompt_tokens}

Get max prompt tokens from truncation options if set.

## *class* yandex\_cloud\_ml\_sdk.\_search\_api.domain.**BaseSearchAPIDomain**{#yandex_cloud_ml_sdk._search_api.domain.BaseSearchAPIDomain}

Domain for working with [Yandex Search API](https://yandex.cloud/docs/search-api) services.

**generative**\: *[BaseGenerativeSearchFunction](#yandex_cloud_ml_sdk._search_api.generative.function.BaseGenerativeSearchFunction)*{#yandex_cloud_ml_sdk._search_api.domain.BaseSearchAPIDomain.generative}

API for [generative response](https://yandex.cloud/docs/search-api/concepts/generative-response) service

**web**\: *[BaseWebSearchFunction](#yandex_cloud_ml_sdk._search_api.web.function.BaseWebSearchFunction)*{#yandex_cloud_ml_sdk._search_api.domain.BaseSearchAPIDomain.web}

API for [web search](https://yandex.cloud/ru/docs/search-api/concepts/web-search) service

**image**\: *[BaseImageSearchFunction](#yandex_cloud_ml_sdk._search_api.image.function.BaseImageSearchFunction)*{#yandex_cloud_ml_sdk._search_api.domain.BaseSearchAPIDomain.image}

API for [text image search](https://yandex.cloud/ru/docs/search-api/concepts/image-search#search-by-text-query) service

**by\_image**\: *[BaseByImageSearchFunction](#yandex_cloud_ml_sdk._search_api.by_image.function.BaseByImageSearchFunction)*{#yandex_cloud_ml_sdk._search_api.domain.BaseSearchAPIDomain.by_image}

API for [search by image](https://yandex.cloud/ru/docs/search-api/concepts/image-search#search-by-image) service

## *class* yandex\_cloud\_ml\_sdk.\_search\_api.generative.function.**BaseGenerativeSearchFunction**{#yandex_cloud_ml_sdk._search_api.generative.function.BaseGenerativeSearchFunction}

Generative search function for creating search object which provides methods for invoking generative search.

**\_\_call\_\_**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *site=Undefined*, *host=Undefined*, *url=Undefined*, *fix\_misspell=Undefined*, *enable\_nrfm\_docs=Undefined*, *search\_filters=Undefined*){#yandex_cloud_ml_sdk._search_api.generative.function.BaseGenerativeSearchFunction.__call__i}

Creates generative search object which provides methods for invoking generative search.

Not to be confused with **sdk.tools.generative\_search**. Tools domain is for creating tools for using in LLMs/Assistants and search\_api domain is for using Search API directly.

To learn more about parameters and their formats and possible values, refer to [generative search documentation](https://yandex.cloud/docs/search-api/concepts/generative-response#body)

NB: All of the **site**, **host**, **url** parameters are mutually exclusive.

#|
|| Parameters | 

- **site** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – parameter for limiting search to specific location or list of sites.
- **host** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – parameter for limiting search to specific location or list of hosts.
- **url** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – parameter for limiting search to specific location or list of URLs.
- **fix\_misspell** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – tells to backend to fix or not to fix misspels in queries.
- **enable\_nrfm\_docs** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – tells to backend to include or not to include pages, which are not available via direct clicks from given sites/hosts/urls to search result.
- **search\_filters** ([*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*DateFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.DateFilterType) *\|* [*FormatFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.FormatFilterType) *\|* [*LangFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.LangFilterType)*] \|* [*DateFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.DateFilterType) *\|* [*FormatFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.FormatFilterType) *\|* [*LangFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.LangFilterType) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – allows to limit search results with additional filters.
```python
>>> date_filter = {'date': '<20250101'}
>>> format_filter = {'format': 'doc'}
>>> lang_filter = {'lang': 'ru'}
>>> search = sdk.search_api.generative(search_filters=[date_filter, format_filter, lang_filter])
```
 ||
|| Return type | [*GenerativeSearchTypeT*](../types/other.md#yandex_cloud_ml_sdk._search_api.generative.generative.GenerativeSearchTypeT) ||
|#

*property* **available\_formats**{#yandex_cloud_ml_sdk._search_api.generative.function.BaseGenerativeSearchFunction.available_formats}

## *class* yandex\_cloud\_ml\_sdk.\_search\_api.generative.generative.**BaseGenerativeSearch**{#yandex_cloud_ml_sdk._search_api.generative.generative.BaseGenerativeSearch}

Generative search class which provides concrete methods for working with Search API and incapsulates search setting.

**configure**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *site=Undefined*, *host=Undefined*, *url=Undefined*, *fix\_misspell=Undefined*, *enable\_nrfm\_docs=Undefined*, *search\_filters=Undefined*){#yandex_cloud_ml_sdk._search_api.generative.generative.BaseGenerativeSearch.configure}

Returns the new object with config fields overrode by passed values.

To learn more about parameters and their formats and possible values, refer to [generative search documentation](https://yandex.cloud/docs/search-api/concepts/generative-response#body)

NB: All of the **site**, **host**, **url** parameters are mutually exclusive and using one of them is mandatory.

#|
|| Parameters | 

- **site** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – parameter for limiting search to specific location or list of sites.
- **host** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – parameter for limiting search to specific location or list of hosts.
- **url** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – parameter for limiting search to specific location or list of URLs.
- **fix\_misspell** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – tells to backend to fix or not to fix misspels in queries.
- **enable\_nrfm\_docs** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – tells to backend to include or not to include pages, which are not available via direct clicks from given sites/hosts/urls to search result.
- **search\_filters** ([*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*DateFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.DateFilterType) *\|* [*FormatFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.FormatFilterType) *\|* [*LangFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.LangFilterType)*] \|* [*DateFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.DateFilterType) *\|* [*FormatFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.FormatFilterType) *\|* [*LangFilterType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.generative.config.LangFilterType) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*) – allows to limit search results with additional filters.
```python
>>> date_filter = {'date': '<20250101'}
>>> format_filter = {'format': 'doc'}
>>> lang_filter = {'lang': 'ru'}
>>> search = sdk.search_api.generative(search_filters=[date_filter, format_filter, lang_filter])
```
 ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

**as\_tool**(*description*){#yandex_cloud_ml_sdk._search_api.generative.generative.BaseGenerativeSearch.as_tool}

Converts generative search instance to [**GenerativeSearchTool**](../types/tools.md#yandex_cloud_ml_sdk._tools.generative_search.GenerativeSearchTool) object which is eligible to use as tools in LLMs/Assistants.

#|
|| Parameters | **description** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – description of tool instance which also instructs model when to call it. ||
|| Return type | [*GenerativeSearchTool*](../types/tools.md#yandex_cloud_ml_sdk._tools.generative_search.GenerativeSearchTool) ||
|#

*property* **config**\: *[ConfigTypeT](../types/other.md#yandex_cloud_ml_sdk._types.model.ConfigTypeT)*{#yandex_cloud_ml_sdk._search_api.generative.generative.BaseGenerativeSearch.config}

*property* **uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_api.generative.generative.BaseGenerativeSearch.uri}

## *class* yandex\_cloud\_ml\_sdk.\_search\_indexes.domain.**BaseSearchIndexes**{#yandex_cloud_ml_sdk._search_indexes.domain.BaseSearchIndexes}

A class for search indexes. It is a part of Assistants API and it provides the foundation for creating and managing search indexes.

## *class* yandex\_cloud\_ml\_sdk.\_search\_indexes.search\_index.**BaseSearchIndex**{#yandex_cloud_ml_sdk._search_indexes.search_index.BaseSearchIndex}

This class represents a search index with associated operations.

**expiration\_config**\: *[ExpirationConfig](../types/assistants.md#yandex_cloud_ml_sdk._types.expiration.ExpirationConfig)*{#yandex_cloud_ml_sdk._search_indexes.search_index.BaseSearchIndex.expiration_config}

**id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_indexes.search_index.BaseSearchIndex.id}

## *class* yandex\_cloud\_ml\_sdk.\_datasets.domain.**BaseDatasets**{#yandex_cloud_ml_sdk._datasets.domain.BaseDatasets}

This class provides methods to create and manage datasets of a specific type.

**completions**{#yandex_cloud_ml_sdk._datasets.domain.BaseDatasets.completions}

a helper for autocompletion text-to-text generation tasks

**text\_classifiers\_multilabel**{#yandex_cloud_ml_sdk._datasets.domain.BaseDatasets.text_classifiers_multilabel}

a helper for autocompletion multilabel text classification tasks

**text\_classifiers\_multiclass**{#yandex_cloud_ml_sdk._datasets.domain.BaseDatasets.text_classifiers_multiclass}

a helper for autocompletion multiclass text classification tasks

**text\_classifiers\_binary**{#yandex_cloud_ml_sdk._datasets.domain.BaseDatasets.text_classifiers_binary}

a helper for autocompletion binary text classification tasks

**text\_embeddings\_pair**{#yandex_cloud_ml_sdk._datasets.domain.BaseDatasets.text_embeddings_pair}

a helper for autocompletion pairwise text embeddings tasks

**text\_embeddings\_triplet**{#yandex_cloud_ml_sdk._datasets.domain.BaseDatasets.text_embeddings_triplet}

a helper for autocompletion triplet text embeddings tasks

**draft\_from\_path**(*path*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *task\_type=Undefined*, *upload\_format=Undefined*, *name=Undefined*, *description=Undefined*, *metadata=Undefined*, *labels=Undefined*, *allow\_data\_logging=Undefined*){#yandex_cloud_ml_sdk._datasets.domain.BaseDatasets.draft_from_path}

Create a new dataset draft from a specified path.

#|
|| Parameters | 

- **path** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*PathLike*](https://docs.python.org/3/library/os.html#os.PathLike)) – the path to the data file or directory.
- **task\_type** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the type of task for the dataset.
- **upload\_format** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the format in which the data should be uploaded.
- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – the name of the dataset.
- **description** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a description of the dataset.
- **metadata** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – metadata associated with the dataset.
- **labels** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*,* [*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a set of labels for the dataset.
- **allow\_data\_logging** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – a flag indicating if data logging is allowed. ||
|| Return type | [*DatasetDraftT*](../types/other.md#yandex_cloud_ml_sdk._datasets.draft.DatasetDraftT) ||
|#

## *class* yandex\_cloud\_ml\_sdk.\_datasets.dataset.**BaseDataset**{#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset}

This class represents methods for operating with datasets.

**folder\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset.folder_id}

the ID of the folder which contains the dataset

**name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset.name}

the name of the dataset

**description**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset.description}

a description of the dataset

**metadata**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset.metadata}

metadata associated with the dataset

**created\_by**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset.created_by}

the user who created the dataset

**created\_at**\: *datetime*{#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset.created_at}

the timestamp when the dataset was created

**updated\_at**\: *datetime*{#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset.updated_at}

the timestamp when the dataset was last updated

**labels**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [str](https://docs.python.org/3/library/stdtypes.html#str)] | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset.labels}

a dictionary of labels associated with the dataset

**allow\_data\_logging**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset.allow_data_logging}

indicates if data logging is allowed for this dataset

**status**\: *[DatasetStatus](../types/datasets.md#yandex_cloud_ml_sdk._datasets.status.DatasetStatus)*{#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset.status}

the current status of the dataset

**task\_type**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset.task_type}

the type of task associated with the dataset

**rows**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset.rows}

the number of rows in the dataset

**size\_bytes**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset.size_bytes}

the size of the dataset in bytes

**validation\_errors**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[ValidationErrorInfo](../types/datasets.md#yandex_cloud_ml_sdk._datasets.dataset.ValidationErrorInfo)*]... ,{#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset.validation_errors}

a tuple of validation errors associated with the dataset

**id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset.id}

## *class* yandex\_cloud\_ml\_sdk.\_datasets.draft.**BaseDatasetDraft**{#yandex_cloud_ml_sdk._datasets.draft.BaseDatasetDraft}

This class allows users to create a draft representation of a dataset without immediately interacting with the server. This draft serves as a structure for storing configuration settings, enabling users to edit the dataset’s properties before finalizing the upload.

**task\_type**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._datasets.draft.BaseDatasetDraft.task_type}

the type of task associated with the dataset

**path**\: *[PathLike](../types/other.md#yandex_cloud_ml_sdk._types.misc.PathLike) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._datasets.draft.BaseDatasetDraft.path}

the file path to the dataset

**upload\_format**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._datasets.draft.BaseDatasetDraft.upload_format}

the format in which the dataset will be uploaded

**name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._datasets.draft.BaseDatasetDraft.name}

the name of the dataset

**description**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._datasets.draft.BaseDatasetDraft.description}

a description of the dataset

**metadata**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._datasets.draft.BaseDatasetDraft.metadata}

metadata associated with the dataset

**labels**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [str](https://docs.python.org/3/library/stdtypes.html#str)] | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._datasets.draft.BaseDatasetDraft.labels}

labels for categorizing the dataset

**allow\_data\_logging**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._datasets.draft.BaseDatasetDraft.allow_data_logging}

a flag indicating if iyt is allowed to use the dataset to improve the models quality. Default false.

**configure**(*\*\*kwargs*){#yandex_cloud_ml_sdk._datasets.draft.BaseDatasetDraft.configure}

#|
|| Parameters | **kwargs** ([*Any*](https://docs.python.org/3/library/typing.html#typing.Any)) ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

**validate**(){#yandex_cloud_ml_sdk._datasets.draft.BaseDatasetDraft.validate}

#|
|| Return type | None ||
|#

## *class* yandex\_cloud\_ml\_sdk.\_tuning.domain.**BaseTuning**{#yandex_cloud_ml_sdk._tuning.domain.BaseTuning}

## *class* yandex\_cloud\_ml\_sdk.\_types.batch.domain.**BaseBatchSubdomain**{#yandex_cloud_ml_sdk._types.batch.domain.BaseBatchSubdomain}

## *class* yandex\_cloud\_ml\_sdk.\_messages.base.**BaseMessage**{#yandex_cloud_ml_sdk._messages.base.BaseMessage}

Abstract class for messages in Yandex Cloud ML Assistant service.

Provides core functionality for all message types including: - Storage and processing of message parts (text, citations, etc.) - Basic text content operations - Protocol buffer support via BaseProtoResult[ProtoMessageTypeT\_contra]

Extended by: - Message: Complete assistant messages - PartialMessage: Intermediate message content during streaming

**parts**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[Any](https://docs.python.org/3/library/typing.html#typing.Any)*]... ,{#yandex_cloud_ml_sdk._messages.base.BaseMessage.parts}

Tuple containing message parts (can be strings or other types)

*property* **text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._messages.base.BaseMessage.text}

Get concatenated string of all text parts in the message by joining all string parts.

## *class* yandex\_cloud\_ml\_sdk.\_batch.domain.**BaseBatch**{#yandex_cloud_ml_sdk._batch.domain.BaseBatch}

Сlass for managing batch operations in Yandex Cloud ML SDK.

For usage examples see [batch example](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/blob/master/examples/{link}/completions/batch.py).

## *class* yandex\_cloud\_ml\_sdk.\_types.batch.operation.**BaseBatchTaskOperation**{#yandex_cloud_ml_sdk._types.batch.operation.BaseBatchTaskOperation}

*property* **id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._types.batch.operation.BaseBatchTaskOperation.id}

*property* **task\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._types.batch.operation.BaseBatchTaskOperation.task_id}

## *class* yandex\_cloud\_ml\_sdk.\_chat.**BaseChat**{#yandex_cloud_ml_sdk._chat.BaseChat}

A class for Chat API domain operations.

This class provides functionality for working with the [Yandex Cloud OpenAI Compatible API\_BaseChat\_URL](https://yandex.cloud/docs/ai-studio/concepts/openai-compatibility). It serves as the foundation for chat operations.

**completions**\: *[BaseChatCompletions](#yandex_cloud_ml_sdk._chat.completions.function.BaseChatCompletions)*{#yandex_cloud_ml_sdk._chat.BaseChat.completions}

Chat API subdomain for working with text-generation models

**text\_embeddings**\: *[BaseChatEmbeddings](#yandex_cloud_ml_sdk._chat.text_embeddings.function.BaseChatEmbeddings)*{#yandex_cloud_ml_sdk._chat.BaseChat.text_embeddings}

## *class* yandex\_cloud\_ml\_sdk.\_chat.completions.function.**BaseChatCompletions**{#yandex_cloud_ml_sdk._chat.completions.function.BaseChatCompletions}

A class for working with chat completions models.

This class provides the core functionality for creating chat model instances and managing completions. It handles model URI construction and provides methods for listing available models.

**\_\_call\_\_**(*model\_name*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *model\_version='latest'*){#yandex_cloud_ml_sdk._chat.completions.function.BaseChatCompletions.__call__i}

Create a model instance in selected chat subdomain (completions, embeddings, etc)

Constructs the model URI based on the provided name and version. If the name contains ‘://’, it is treated as a full URI. Otherwise constructs a URI in the form ‘gpt://<folder\_id>/<model>/<version>’.

#|
|| Parameters | 

- **model\_name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – The name or URI of the model.
- **model\_version** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – The version of the model to use. Defaults to ‘latest’. ||
|| Return type | [*ModelTypeT*](../types/other.md#yandex_cloud_ml_sdk._types.model.ModelTypeT) ||
|#

## *class* yandex\_cloud\_ml\_sdk.\_chat.completions.model.**BaseChatModel**{#yandex_cloud_ml_sdk._chat.completions.model.BaseChatModel}

A class for working with chat models providing inference functionality.

This class provides the foundation for chat model implementations, handling configuration, request building, and response processing.

**configure**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *temperature=Undefined*, *max\_tokens=Undefined*, *reasoning\_mode=Undefined*, *response\_format=Undefined*, *tools=Undefined*, *parallel\_tool\_calls=Undefined*, *tool\_choice=Undefined*, *extra\_query=Undefined*){#yandex_cloud_ml_sdk._chat.completions.model.BaseChatModel.configure}

Configure the model with specified parameters.

#|
|| Parameters | 

- **temperature** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*float*](https://docs.python.org/3/library/functions.html#float)*] \| None*) – Sampling temperature (0-1). Higher values produce more random results.
- **max\_tokens** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*int*](https://docs.python.org/3/library/functions.html#int)*] \| None*) – Maximum number of tokens to generate in the response.
- **reasoning\_mode** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*ChatReasoningModeType*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningModeType)*] \| None*) – Reasoning mode for internal processing before responding.
- **response\_format** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[ResponseType] \| None*) – Format of the response (JsonSchema, JSON string, or pydantic model). See [structured output documentation\_BaseChatModel\_URL](https://yandex.cloud/docs/ai-studio/concepts/generation/structured-output).
- **tools** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[Sequence[*[*CompletionTool*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._models.completions.config.CompletionTool)*] \|* [*CompletionTool*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._models.completions.config.CompletionTool)*]*) – Tools available for completion. Can be a sequence or single tool.
- **parallel\_tool\_calls** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*bool*](https://docs.python.org/3/library/functions.html#bool)*]*) – Whether to allow parallel tool calls. Defaults to ‘true’.
- **tool\_choice** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*ToolChoiceType*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.tools.tool_choice.ToolChoiceType)*]*) – Strategy for tool selection. There are several ways to configure **tool\_choice** for query processing: - no tools to call (**tool\_choice='none'**); - required to call any tool (**tool\_choice='required'**); - call a specific tool (**tool\_choice={'type': 'function', 'function': {'name': 'another\_calculator'}}** or directly passing a tool object).
- **extra\_query** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*QueryType*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._chat.completions.config.QueryType)*]*) – Additional experimental model parameters. ||
|| Return type | Self ||
|#

*property* **config**\: *[ConfigTypeT](../types/other.md#yandex_cloud_ml_sdk._types.model.ConfigTypeT)*{#yandex_cloud_ml_sdk._chat.completions.model.BaseChatModel.config}

*property* **uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._chat.completions.model.BaseChatModel.uri}

## *class* yandex\_cloud\_ml\_sdk.\_chat.text\_embeddings.function.**BaseChatEmbeddings**{#yandex_cloud_ml_sdk._chat.text_embeddings.function.BaseChatEmbeddings}

**\_\_call\_\_**(*model\_name*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *model\_version='latest'*){#yandex_cloud_ml_sdk._chat.text_embeddings.function.BaseChatEmbeddings.__call__i}

Create a model instance in selected chat subdomain (completions, embeddings, etc)

Constructs the model URI based on the provided name and version. If the name contains ‘://’, it is treated as a full URI. Otherwise constructs a URI in the form ‘gpt://<folder\_id>/<model>/<version>’.

#|
|| Parameters | 

- **model\_name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – The name or URI of the model.
- **model\_version** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – The version of the model to use. Defaults to ‘latest’. ||
|| Return type | [*ModelTypeT*](../types/other.md#yandex_cloud_ml_sdk._types.model.ModelTypeT) ||
|#

## *class* yandex\_cloud\_ml\_sdk.\_chat.text\_embeddings.model.**BaseChatEmbeddingsModel**{#yandex_cloud_ml_sdk._chat.text_embeddings.model.BaseChatEmbeddingsModel}

**configure**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *dimensions=Undefined*, *encoding\_format=Undefined*, *extra\_query=Undefined*){#yandex_cloud_ml_sdk._chat.text_embeddings.model.BaseChatEmbeddingsModel.configure}

#|
|| Parameters | 

- **dimensions** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*int*](https://docs.python.org/3/library/functions.html#int)*]*)
- **encoding\_format** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*EncodingFormatType*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._chat.text_embeddings.config.EncodingFormatType)*]*)
- **extra\_query** ([*UndefinedOr*](../types/other.md#yandex_cloud_ml_sdk._types.misc.UndefinedOr)*[*[*QueryType*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._chat.completions.config.QueryType)*]*) ||
|| Return type | Self ||
|#

*property* **config**\: *[ConfigTypeT](../types/other.md#yandex_cloud_ml_sdk._types.model.ConfigTypeT)*{#yandex_cloud_ml_sdk._chat.text_embeddings.model.BaseChatEmbeddingsModel.config}

*property* **uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._chat.text_embeddings.model.BaseChatEmbeddingsModel.uri}

## *class* yandex\_cloud\_ml\_sdk.\_search\_api.web.function.**BaseWebSearchFunction**{#yandex_cloud_ml_sdk._search_api.web.function.BaseWebSearchFunction}

Web search function for creating search object which provides methods for invoking web search.

**\_\_call\_\_**(*search\_type*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *family\_mode=Undefined*, *fix\_typo\_mode=Undefined*, *localization=Undefined*, *sort\_order=Undefined*, *sort\_mode=Undefined*, *group\_mode=Undefined*, *groups\_on\_page=Undefined*, *docs\_in\_group=Undefined*, *max\_passages=Undefined*, *region=Undefined*, *user\_agent=Undefined*, *metadata=Undefined*){#yandex_cloud_ml_sdk._search_api.web.function.BaseWebSearchFunction.__call__i}

Creates web search object which provides methods for web search.

To learn more about parameters and their formats and possible values, refer to [web search documentation](https://yandex.cloud/ru/docs/search-api/concepts/web-search#parameters)

#|
|| Parameters | 

- **search\_type** ([*SearchType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.SearchType) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*SearchType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.SearchType)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int)) – Search type.
- **family\_mode** ([*FamilyMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.FamilyMode) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*FamilyMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.FamilyMode)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Results filtering.
- **fix\_typo\_mode** ([*FixTypoMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.FixTypoMode) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*FixTypoMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.FixTypoMode)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Search query typo correction setting
- **localization** ([*Localization*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.Localization) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*Localization*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.Localization)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Search response notifications language. Affects the text in the **found-docs-human** tag and error messages
- **sort\_order** ([*SortOrder*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.SortOrder) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*SortOrder*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.SortOrder)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Search results sorting order
- **sort\_mode** ([*SortMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.SortMode) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*SortMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.SortMode)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Search results sorting mode rule
- **group\_mode** ([*GroupMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.GroupMode) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*GroupMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.GroupMode)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Result grouping method.
- **groups\_on\_page** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Maximum number of groups that can be returned per page.
- **docs\_in\_group** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Maximum number of documents that can be returned per group.
- **max\_passages** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Maximum number of passages that can be used when generating a document.
- **region** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Search country or region ID that affects the document ranking rules.
- **user\_agent** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – String containing the User-Agent header. Use this parameter to have your search results optimized for a specific device and browser, including mobile search results.
- **metadata** ([*Mapping*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Mapping)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*,* [*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) ||
|| Return type | [*WebSearchTypeT*](../types/other.md#yandex_cloud_ml_sdk._search_api.web.web.WebSearchTypeT) ||
|#

## *class* yandex\_cloud\_ml\_sdk.\_search\_api.image.function.**BaseImageSearchFunction**{#yandex_cloud_ml_sdk._search_api.image.function.BaseImageSearchFunction}

Image search function for creating search object which provides methods for invoking image search.

**\_\_call\_\_**(*search\_type*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *family\_mode=Undefined*, *fix\_typo\_mode=Undefined*, *format=Undefined*, *size=Undefined*, *orientation=Undefined*, *color=Undefined*, *site=Undefined*, *docs\_on\_page=Undefined*, *user\_agent=Undefined*){#yandex_cloud_ml_sdk._search_api.image.function.BaseImageSearchFunction.__call__i}

Creates image search object which provides methods for image search.

To learn more about parameters and their formats and possible values, refer to [image search documentation](https://yandex.cloud/ru/docs/search-api/concepts/image-search#parameters)

#|
|| Parameters | 

- **search\_type** ([*SearchType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.SearchType) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*SearchType*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.SearchType)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int)) – Search type.
- **family\_mode** ([*FamilyMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.FamilyMode) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*FamilyMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.FamilyMode)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Results filtering.
- **fix\_typo\_mode** ([*FixTypoMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.FixTypoMode) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*FixTypoMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.FixTypoMode)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Search query typo correction setting.
- **format** ([*ImageFormat*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.ImageFormat) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*ImageFormat*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.ImageFormat)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Searching for images in a particular format.
- **size** ([*ImageSize*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.ImageSize) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*ImageSize*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.ImageSize)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Searching for images of a particular size.
- **orientation** ([*ImageOrientation*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.ImageOrientation) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*ImageOrientation*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.ImageOrientation)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Searching for images with a particular orientation.
- **color** ([*ImageColor*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.ImageColor) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*ImageColor*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.ImageColor)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Searching for images containing a particular color.
- **site** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Number of results per search result page.
- **docs\_on\_page** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Number of results per search result page.
- **user\_agent** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – String containing the User-Agent header. Use this parameter to have your search results optimized for a specific device and browser, including mobile search results. ||
|| Return type | [*ImageSearchTypeT*](../types/other.md#yandex_cloud_ml_sdk._search_api.image.image.ImageSearchTypeT) ||
|#

## *class* yandex\_cloud\_ml\_sdk.\_search\_api.by\_image.function.**BaseByImageSearchFunction**{#yandex_cloud_ml_sdk._search_api.by_image.function.BaseByImageSearchFunction}

ByImage search function for creating search object which provides methods for invoking by\_image search.

**\_\_call\_\_**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *family\_mode=Undefined*, *site=Undefined*){#yandex_cloud_ml_sdk._search_api.by_image.function.BaseByImageSearchFunction.__call__i}

Creates by\_image search object which provides methods for search by image.

To learn more about parameters and their formats and possible values, refer to [search by image documentation](https://yandex.cloud/ru/docs/search-api/concepts/image-search#request-body-by-pic)

#|
|| Parameters | 

- **family\_mode** ([*FamilyMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.FamilyMode) *\|* [*UnknownEnumValue*](../types/other.md#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._types.enum.UnknownEnumValue)*[*[*FamilyMode*](../types/search_api.md#yandex_cloud_ml_sdk._search_api.enums.FamilyMode)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Results filtering.
- **site** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Restricts the search to the specific website. ||
|| Return type | [*ByImageSearchTypeT*](../types/other.md#yandex_cloud_ml_sdk._search_api.by_image.by_image.ByImageSearchTypeT) ||
|#