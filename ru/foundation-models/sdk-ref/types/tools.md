---
sourcePath: en/_sdk-ref/sdk-ref/types/tools.md
---
# Tools

## Search index tool

### *class* yandex\_cloud\_ml\_sdk.\_tools.search\_index.tool.**SearchIndexTool**{#yandex_cloud_ml_sdk._tools.search_index.tool.SearchIndexTool}

SearchIndexTool(search\_index\_ids: ‘tuple[str, …]’, max\_num\_results: ‘int | None’ = None, rephraser: ‘Rephraser | None’ = None, call\_strategy: ‘CallStrategy | None’ = None)

**search\_index\_ids**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[str](https://docs.python.org/3/library/stdtypes.html#str)*]... ,{#yandex_cloud_ml_sdk._tools.search_index.tool.SearchIndexTool.search_index_ids}

**max\_num\_results**\: *[int](https://docs.python.org/3/library/functions.html#int) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._tools.search_index.tool.SearchIndexTool.max_num_results}

**rephraser**\: *[Rephraser](#yandex_cloud_ml_sdk._tools.search_index.rephraser.model.Rephraser) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._tools.search_index.tool.SearchIndexTool.rephraser}

**call\_strategy**\: *[CallStrategy](#yandex_cloud_ml_sdk._tools.search_index.call_strategy.CallStrategy) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_cloud_ml_sdk._tools.search_index.tool.SearchIndexTool.call_strategy}

### *class* yandex\_cloud\_ml\_sdk.\_tools.search\_index.rephraser.function.**RephraserFunction**{#yandex_cloud_ml_sdk._tools.search_index.rephraser.function.RephraserFunction}

Function for creating Rephraser object, which incapsulating rephrasing settings.

**\_\_call\_\_**(*model\_name*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *model\_version='latest'*){#yandex_cloud_ml_sdk._tools.search_index.rephraser.function.RephraserFunction.__call__i}

Creates a Rephraser object, which incapsulating rephrasing settings.

#|
|| Parameters | 

- **model\_name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)* \| *[*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*[**True**] **\| **~yandex\_cloud\_ml\_sdk.\_tools.search\_index.rephraser.model.Rephraser*) – Model ID used for model uri definition in a resulting Rephraser object. It is handled differently depending on the type and format of the input value:
- If **model\_name** includes **\://** substring, it would be used unchanged.
- Otherwise if **model\_name** is a string, it would be used in **gpt://<folder\_id>/<model\_name>/<model\_version>** template.
- If **model\_name** is a True, it would be transformed into default value **gpt://<folder\_id>/rephraser/<model\_version>**
- If **model\_name** is a Rephraser object, it would returned unchanged.

- **model\_version** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – **<model\_version>** value for model uri template, refer to model\_name parameter documentation for details. ||
|| Returns | Rephraser object, which incapsulating rephrasing settings ||
|| Return type | [*Rephraser*](#yandex_cloud_ml_sdk._tools.search_index.rephraser.model.Rephraser) ||
|#

### *class* yandex\_cloud\_ml\_sdk.\_tools.search\_index.rephraser.model.**Rephraser**{#yandex_cloud_ml_sdk._tools.search_index.rephraser.model.Rephraser}

Class for incapsulating rephraser settings.

Used to rewrite the last user message for search, incorporating context from the previous conversation.

*property* **config**\: *[ConfigTypeT](other.md#yandex_cloud_ml_sdk._types.model.ConfigTypeT)*{#yandex_cloud_ml_sdk._tools.search_index.rephraser.model.Rephraser.config}

**configure**(*\*\*kwargs*){#yandex_cloud_ml_sdk._tools.search_index.rephraser.model.Rephraser.configure}

#|
|| Return type | Self ||
|#

*property* **uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._tools.search_index.rephraser.model.Rephraser.uri}

### *class* yandex\_cloud\_ml\_sdk.\_tools.search\_index.call\_strategy.**CallStrategy**{#yandex_cloud_ml_sdk._tools.search_index.call_strategy.CallStrategy}

*property* **value**\: *[Literal](https://docs.python.org/3/library/typing.html#typing.Literal)['always'] | [FunctionDictType](message.md#yandex_cloud_ml_sdk._types.tools.function.FunctionDictType)*{#yandex_cloud_ml_sdk._tools.search_index.call_strategy.CallStrategy.value}

## Function tool

### *class* yandex\_cloud\_ml\_sdk.\_tools.tool.**FunctionTool**{#yandex_cloud_ml_sdk._tools.tool.FunctionTool}

FunctionTool(name: ‘str’, description: ‘str | None’, parameters: ‘JsonSchemaType’, strict: ‘bool | None’)

**name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._tools.tool.FunctionTool.name}

**description**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._tools.tool.FunctionTool.description}

**parameters**\: *JsonSchemaType*{#yandex_cloud_ml_sdk._tools.tool.FunctionTool.parameters}

**strict**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._tools.tool.FunctionTool.strict}