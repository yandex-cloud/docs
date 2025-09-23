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
- **response\_format** ([*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*['json'] \| ~yandex\_cloud\_ml\_sdk.\_types.schemas.JsonSchemaResponseType \| type \| ~yandex\_cloud\_ml\_sdk.\_types.misc.Undefined*) – a format of the response returned by the model. Could be a JsonSchema, a JSON string, or a pydantic model. Read more about possible response formats in the [structured output documentation](https://yandex.cloud/docs/foundation-models/concepts/yandexgpt/#structured-output).
- **tools** ([*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*FunctionTool*](../types/tools.md#yandex_cloud_ml_sdk._tools.tool.FunctionTool)*] \|* [*FunctionTool*](../types/tools.md#yandex_cloud_ml_sdk._tools.tool.FunctionTool) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – tools to use for completion. Can be a sequence or a single tool.
- **parallel\_tool\_calls** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – whether to allow parallel calls to tools during completion. Defaults to **true**.
- **tool\_choice** ([*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*['none', 'None', 'NONE', 'auto', 'Auto', 'AUTO', 'required', 'Required', 'REQUIRED'] \| ~yandex\_cloud\_ml\_sdk.\_types.tools.function.FunctionDictType \| ~yandex\_cloud\_ml\_sdk.\_tools.tool.FunctionTool \| ~yandex\_cloud\_ml\_sdk.\_types.misc.Undefined*) – the strategy for choosing tools. There are several ways to configure **tool\_choice** for query processing: - no tools to call (tool\_choice=``’none’**); - required to call any tool (tool\_choice=**’required’**); - call a specific tool (tool\_choice=``{'type': 'function', 'function': {'name': 'another\_calculator'}}** or directly passing a tool object). ||
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

## *class* yandex\_cloud\_ml\_sdk.\_runs.run.**BaseRun**{#yandex_cloud_ml_sdk._runs.run.BaseRun}

BaseRun(id: ‘str’, \_sdk: ‘BaseSDK’, assistant\_id: ‘str’, thread\_id: ‘str’, created\_by: ‘str’, created\_at: ‘datetime’, labels: ‘dict[str, str] | None’, custom\_temperature: ‘float | None’, custom\_max\_tokens: ‘int | None’, custom\_prompt\_truncation\_options: ‘PromptTruncationOptions | None’, custom\_response\_format: ‘ResponseType | None’)

**id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._runs.run.BaseRun.id}

**assistant\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._runs.run.BaseRun.assistant_id}

**thread\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._runs.run.BaseRun.thread_id}

**created\_by**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._runs.run.BaseRun.created_by}

**created\_at**\: *datetime*{#yandex_cloud_ml_sdk._runs.run.BaseRun.created_at}

**labels**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [str](https://docs.python.org/3/library/stdtypes.html#str)] | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.run.BaseRun.labels}

**custom\_temperature**\: *[float](https://docs.python.org/3/library/functions.html#float) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.run.BaseRun.custom_temperature}

**custom\_max\_tokens**\: *[int](https://docs.python.org/3/library/functions.html#int) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.run.BaseRun.custom_max_tokens}

**custom\_prompt\_truncation\_options**\: *[PromptTruncationOptions](../types/assistants.md#yandex_cloud_ml_sdk._assistants.prompt_truncation_options.PromptTruncationOptions) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.run.BaseRun.custom_prompt_truncation_options}

**custom\_response\_format**\: *ResponseType | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.run.BaseRun.custom_response_format}

*property* **custom\_max\_prompt\_tokens**\: *[int](https://docs.python.org/3/library/functions.html#int) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.run.BaseRun.custom_max_prompt_tokens}

## *class* yandex\_cloud\_ml\_sdk.\_search\_api.domain.**BaseSearchAPIDomain**{#yandex_cloud_ml_sdk._search_api.domain.BaseSearchAPIDomain}

Domain for working with [Yandex Search API](https://yandex.cloud/docs/search-api) services.

**generative**\: *[BaseGenerativeSearchFunction](#yandex_cloud_ml_sdk._search_api.generative.function.BaseGenerativeSearchFunction)*{#yandex_cloud_ml_sdk._search_api.domain.BaseSearchAPIDomain.generative}

API for [generative response](https://yandex.cloud/docs/search-api/concepts/generative-response) service

## *class* yandex\_cloud\_ml\_sdk.\_search\_api.generative.function.**BaseGenerativeSearchFunction**{#yandex_cloud_ml_sdk._search_api.generative.function.BaseGenerativeSearchFunction}

Generative search function for creating search object which provides methods for invoking generative search.

**\_\_call\_\_**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *site=Undefined*, *host=Undefined*, *url=Undefined*, *fix\_misspell=Undefined*, *enable\_nrfm\_docs=Undefined*, *search\_filters=Undefined*){#yandex_cloud_ml_sdk._search_api.generative.function.BaseGenerativeSearchFunction.__call__i}

Creates generative search object which provides methods for invoking generative search.

To learn more about parameters and their formats and possible values, refer to [generative search documentation](https://yandex.cloud/docs/search-api/concepts/generative-response#body)

NB: All of the **site**, **host**, **url** parameters are mutually exclusive and using one of them is mandatory.

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

*property* **config**\: *[ConfigTypeT](../types/other.md#yandex_cloud_ml_sdk._types.model.ConfigTypeT)*{#yandex_cloud_ml_sdk._search_api.generative.generative.BaseGenerativeSearch.config}

*property* **uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_api.generative.generative.BaseGenerativeSearch.uri}

## *class* yandex\_cloud\_ml\_sdk.\_search\_indexes.domain.**BaseSearchIndexes**{#yandex_cloud_ml_sdk._search_indexes.domain.BaseSearchIndexes}

A class for search indexes. It is a part of Assistants API and it provides the foundation for creating and managing search indexes.

## *class* yandex\_cloud\_ml\_sdk.\_search\_indexes.search\_index.**BaseSearchIndex**{#yandex_cloud_ml_sdk._search_indexes.search_index.BaseSearchIndex}

BaseSearchIndex(id: ‘str’, \_sdk: ‘BaseSDK’, \_lock: ‘asyncio.Lock’, \_deleted: ‘bool’, expiration\_config: ‘ExpirationConfig’)

**expiration\_config**\: *[ExpirationConfig](../types/assistants.md#yandex_cloud_ml_sdk._types.expiration.ExpirationConfig)*{#yandex_cloud_ml_sdk._search_indexes.search_index.BaseSearchIndex.expiration_config}

**id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._search_indexes.search_index.BaseSearchIndex.id}

## *class* yandex\_cloud\_ml\_sdk.\_datasets.domain.**BaseDatasets**{#yandex_cloud_ml_sdk._datasets.domain.BaseDatasets}

**completions**{#yandex_cloud_ml_sdk._datasets.domain.BaseDatasets.completions}

**text\_classifiers\_multilabel**{#yandex_cloud_ml_sdk._datasets.domain.BaseDatasets.text_classifiers_multilabel}

**text\_classifiers\_multiclass**{#yandex_cloud_ml_sdk._datasets.domain.BaseDatasets.text_classifiers_multiclass}

**text\_classifiers\_binary**{#yandex_cloud_ml_sdk._datasets.domain.BaseDatasets.text_classifiers_binary}

**text\_embeddings\_pair**{#yandex_cloud_ml_sdk._datasets.domain.BaseDatasets.text_embeddings_pair}

**text\_embeddings\_triplet**{#yandex_cloud_ml_sdk._datasets.domain.BaseDatasets.text_embeddings_triplet}

**draft\_from\_path**(*path*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *task\_type=Undefined*, *upload\_format=Undefined*, *name=Undefined*, *description=Undefined*, *metadata=Undefined*, *labels=Undefined*, *allow\_data\_logging=Undefined*){#yandex_cloud_ml_sdk._datasets.domain.BaseDatasets.draft_from_path}

#|
|| Parameters | 

- **path** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*PathLike*](https://docs.python.org/3/library/os.html#os.PathLike))
- **task\_type** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **upload\_format** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **description** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **metadata** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **labels** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str)*,* [*str*](https://docs.python.org/3/library/stdtypes.html#str)*] \|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **allow\_data\_logging** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) ||
|| Return type | [*DatasetDraftT*](../types/other.md#yandex_cloud_ml_sdk._datasets.draft.DatasetDraftT) ||
|#

## *class* yandex\_cloud\_ml\_sdk.\_datasets.dataset.**BaseDataset**{#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset}

BaseDataset(id: ‘str’, \_sdk: ‘BaseSDK’, \_lock: ‘asyncio.Lock’, \_deleted: ‘bool’, folder\_id: ‘str’, name: ‘str | None’, description: ‘str | None’, metadata: ‘str | None’, created\_by: ‘str’, created\_at: ‘datetime’, updated\_at: ‘datetime’, labels: ‘dict[str, str] | None’, allow\_data\_logging: ‘bool’, status: ‘DatasetStatus’, task\_type: ‘str’, rows: ‘int’, size\_bytes: ‘int’, validation\_errors: ‘tuple[ValidationErrorInfo, …]’)

**folder\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset.folder_id}

**name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset.name}

**description**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset.description}

**metadata**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset.metadata}

**created\_by**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset.created_by}

**created\_at**\: *datetime*{#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset.created_at}

**updated\_at**\: *datetime*{#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset.updated_at}

**labels**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [str](https://docs.python.org/3/library/stdtypes.html#str)] | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset.labels}

**allow\_data\_logging**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset.allow_data_logging}

**status**\: *[DatasetStatus](../types/datasets.md#yandex_cloud_ml_sdk._datasets.status.DatasetStatus)*{#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset.status}

**task\_type**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset.task_type}

**rows**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset.rows}

**size\_bytes**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset.size_bytes}

**validation\_errors**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[ValidationErrorInfo](../types/datasets.md#yandex_cloud_ml_sdk._datasets.dataset.ValidationErrorInfo)*]... ,{#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset.validation_errors}

**id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._datasets.dataset.BaseDataset.id}

## *class* yandex\_cloud\_ml\_sdk.\_datasets.draft.**BaseDatasetDraft**{#yandex_cloud_ml_sdk._datasets.draft.BaseDatasetDraft}

BaseDatasetDraft(\_domain: ‘BaseDatasets’, task\_type: ‘str | None’ = None, path: ‘PathLike | None’ = None, upload\_format: ‘str | None’ = None, name: ‘str | None’ = None, description: ‘str | None’ = None, metadata: ‘str | None’ = None, labels: ‘dict[str, str] | None’ = None, allow\_data\_logging: ‘bool | None’ = None)

**task\_type**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._datasets.draft.BaseDatasetDraft.task_type}

**path**\: *[PathLike](../types/other.md#yandex_cloud_ml_sdk._types.misc.PathLike) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._datasets.draft.BaseDatasetDraft.path}

**upload\_format**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._datasets.draft.BaseDatasetDraft.upload_format}

**name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._datasets.draft.BaseDatasetDraft.name}

**description**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._datasets.draft.BaseDatasetDraft.description}

**metadata**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._datasets.draft.BaseDatasetDraft.metadata}

**labels**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [str](https://docs.python.org/3/library/stdtypes.html#str)] | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._datasets.draft.BaseDatasetDraft.labels}

**allow\_data\_logging**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._datasets.draft.BaseDatasetDraft.allow_data_logging}

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

## *class* yandex\_cloud\_ml\_sdk.\_types.batch.operation.**BaseBatchTaskOperation**{#yandex_cloud_ml_sdk._types.batch.operation.BaseBatchTaskOperation}

*property* **id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._types.batch.operation.BaseBatchTaskOperation.id}

*property* **task\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._types.batch.operation.BaseBatchTaskOperation.task_id}

## *class* yandex\_cloud\_ml\_sdk.\_chat.**BaseChat**{#yandex_cloud_ml_sdk._chat.BaseChat}

**completions**\: *[BaseChatCompletions](#yandex_cloud_ml_sdk._chat.completions.function.BaseChatCompletions)*{#yandex_cloud_ml_sdk._chat.BaseChat.completions}

## *class* yandex\_cloud\_ml\_sdk.\_chat.completions.function.**BaseChatCompletions**{#yandex_cloud_ml_sdk._chat.completions.function.BaseChatCompletions}

**\_\_call\_\_**(*model\_name*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *model\_version='latest'*){#yandex_cloud_ml_sdk._chat.completions.function.BaseChatCompletions.__call__i}

Call self as a function.

#|
|| Parameters | 

- **model\_name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **model\_version** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) ||
|| Return type | [*ModelTypeT*](../types/other.md#yandex_cloud_ml_sdk._types.model.ModelTypeT) ||
|#

## *class* yandex\_cloud\_ml\_sdk.\_chat.completions.model.**BaseChatModel**{#yandex_cloud_ml_sdk._chat.completions.model.BaseChatModel}

**configure**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *temperature=Undefined*, *max\_tokens=Undefined*, *reasoning\_mode=Undefined*, *response\_format=Undefined*, *tools=Undefined*, *parallel\_tool\_calls=Undefined*, *tool\_choice=Undefined*){#yandex_cloud_ml_sdk._chat.completions.model.BaseChatModel.configure}

#|
|| Parameters | 

- **temperature** ([*float*](https://docs.python.org/3/library/functions.html#float) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*)
- **max\_tokens** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*)
- **reasoning\_mode** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*ChatReasoningMode*](../types/other.md#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined) *\| None*)
- **response\_format** ([*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*['json'] \| ~yandex\_cloud\_ml\_sdk.\_types.schemas.JsonSchemaResponseType \| type \| ~yandex\_cloud\_ml\_sdk.\_types.misc.Undefined \| None*)
- **tools** ([*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*FunctionTool*](../types/tools.md#yandex_cloud_ml_sdk._tools.tool.FunctionTool)*] \|* [*FunctionTool*](../types/tools.md#yandex_cloud_ml_sdk._tools.tool.FunctionTool) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **parallel\_tool\_calls** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **tool\_choice** ([*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*['none', 'None', 'NONE', 'auto', 'Auto', 'AUTO', 'required', 'Required', 'REQUIRED'] \| ~yandex\_cloud\_ml\_sdk.\_types.tools.function.FunctionDictType \| ~yandex\_cloud\_ml\_sdk.\_tools.tool.FunctionTool \| ~yandex\_cloud\_ml\_sdk.\_types.misc.Undefined*) ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

*property* **config**\: *[ConfigTypeT](../types/other.md#yandex_cloud_ml_sdk._types.model.ConfigTypeT)*{#yandex_cloud_ml_sdk._chat.completions.model.BaseChatModel.config}

*property* **uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._chat.completions.model.BaseChatModel.uri}