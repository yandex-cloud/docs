---
sourcePath: en/_sdk-ref/sdk-ref/sync/runs.md
---
# Runs domain

## *class* yandex\_cloud\_ml\_sdk.\_runs.domain.**Runs**{#yandex_cloud_ml_sdk._runs.domain.Runs}

**get**(*run\_id*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._runs.domain.Runs.get}

#|
|| Parameters | 

- **run\_id** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*Run*](#yandex_cloud_ml_sdk._runs.run.Run) ||
|#

**get\_last\_by\_thread**(*thread*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._runs.domain.Runs.get_last_by_thread}

#|
|| Parameters | 

- **thread** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseThread*](../internals/bases.md#yandex_cloud_ml_sdk._threads.thread.BaseThread))
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*Run*](#yandex_cloud_ml_sdk._runs.run.Run) ||
|#

**list**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *page\_size=Undefined*, *timeout=60*){#yandex_cloud_ml_sdk._runs.domain.Runs.list}

#|
|| Parameters | 

- **page\_size** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*Iterator*](https://docs.python.org/3/library/typing.html#typing.Iterator)[[*Run*](#yandex_cloud_ml_sdk._runs.run.Run)] ||
|#

## *class* yandex\_cloud\_ml\_sdk.\_runs.run.**Run**{#yandex_cloud_ml_sdk._runs.run.Run}

**listen**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *events\_start\_idx=0*, *timeout=60*){#yandex_cloud_ml_sdk._runs.run.Run.listen}

#|
|| Parameters | 

- **events\_start\_idx** ([*int*](https://docs.python.org/3/library/functions.html#int))
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*Iterator*](https://docs.python.org/3/library/typing.html#typing.Iterator)[[*RunStreamEvent*](../types/runs.md#yandex_cloud_ml_sdk._runs.result.RunStreamEvent)[[*ToolCall*](tools.md#yandex_cloud_ml_sdk._tools.tool_call.ToolCall)]] ||
|#

**submit\_tool\_results**(*tool\_results*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._runs.run.Run.submit_tool_results}

#|
|| Parameters | 

- **tool\_results** ([*FunctionResultDict*](../types/message.md#yandex_cloud_ml_sdk._tools.tool_result.FunctionResultDict) *\|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable)*[*[*FunctionResultDict*](../types/message.md#yandex_cloud_ml_sdk._tools.tool_result.FunctionResultDict)*]*)
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | None ||
|#

**cancel**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._runs.run.Run.cancel}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | None ||
|#

*property* **custom\_max\_prompt\_tokens**\: *[int](https://docs.python.org/3/library/functions.html#int) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.run.Run.custom_max_prompt_tokens}

**get\_result**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._runs.run.Run.get_result}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*AnyResultTypeT\_co*](../types/other.md#yandex_cloud_ml_sdk._types.operation.AnyResultTypeT_co) ||
|#

**get\_status**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._runs.run.Run.get_status}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*OperationStatusTypeT*](../types/other.md#yandex_cloud_ml_sdk._types.operation.OperationStatusTypeT) ||
|#

**wait**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*, *poll\_timeout=None*, *poll\_interval=None*){#yandex_cloud_ml_sdk._runs.run.Run.wait}

#|
|| Parameters | 

- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float))
- **poll\_timeout** ([*int*](https://docs.python.org/3/library/functions.html#int) *\| None*)
- **poll\_interval** ([*float*](https://docs.python.org/3/library/functions.html#float) *\| None*) ||
|| Return type | [*AnyResultTypeT\_co*](../types/other.md#yandex_cloud_ml_sdk._types.operation.AnyResultTypeT_co) ||
|#

**id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._runs.run.Run.id}

**assistant\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._runs.run.Run.assistant_id}

**thread\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._runs.run.Run.thread_id}

**created\_by**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._runs.run.Run.created_by}

**created\_at**\: *datetime*{#yandex_cloud_ml_sdk._runs.run.Run.created_at}

**labels**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [str](https://docs.python.org/3/library/stdtypes.html#str)] | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.run.Run.labels}

**custom\_temperature**\: *[float](https://docs.python.org/3/library/functions.html#float) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.run.Run.custom_temperature}

**custom\_max\_tokens**\: *[int](https://docs.python.org/3/library/functions.html#int) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.run.Run.custom_max_tokens}

**custom\_prompt\_truncation\_options**\: *[PromptTruncationOptions](../types/assistants.md#yandex_cloud_ml_sdk._assistants.prompt_truncation_options.PromptTruncationOptions) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.run.Run.custom_prompt_truncation_options}

**custom\_response\_format**\: *ResponseType | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.run.Run.custom_response_format}