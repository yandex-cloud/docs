---
sourcePath: en/_sdk-ref/sdk-ref/async/runs.md
---
# Runs domain

## *class* yandex\_cloud\_ml\_sdk.\_runs.domain.**AsyncRuns**{#yandex_cloud_ml_sdk._runs.domain.AsyncRuns}

*async* **get**(*run\_id*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._runs.domain.AsyncRuns.get}

#|
|| Parameters | 

- **run\_id** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*AsyncRun*](#yandex_cloud_ml_sdk._runs.run.AsyncRun) ||
|#

*async* **get\_last\_by\_thread**(*thread*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._runs.domain.AsyncRuns.get_last_by_thread}

#|
|| Parameters | 

- **thread** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseThread*](../internals/bases.md#yandex_cloud_ml_sdk._threads.thread.BaseThread))
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*AsyncRun*](#yandex_cloud_ml_sdk._runs.run.AsyncRun) ||
|#

*async* **list**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *page\_size=Undefined*, *timeout=60*){#yandex_cloud_ml_sdk._runs.domain.AsyncRuns.list}

#|
|| Parameters | 

- **page\_size** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined))
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*AsyncIterator*](https://docs.python.org/3/library/typing.html#typing.AsyncIterator)[[*AsyncRun*](#yandex_cloud_ml_sdk._runs.run.AsyncRun)] ||
|#

## *class* yandex\_cloud\_ml\_sdk.\_runs.run.**AsyncRun**{#yandex_cloud_ml_sdk._runs.run.AsyncRun}

*async* **listen**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *events\_start\_idx=0*, *timeout=60*){#yandex_cloud_ml_sdk._runs.run.AsyncRun.listen}

#|
|| Parameters | 

- **events\_start\_idx** ([*int*](https://docs.python.org/3/library/functions.html#int))
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*AsyncIterator*](https://docs.python.org/3/library/typing.html#typing.AsyncIterator)[[*RunStreamEvent*](../types/runs.md#yandex_cloud_ml_sdk._runs.result.RunStreamEvent)[[*AsyncToolCall*](tools.md#yandex_cloud_ml_sdk._tools.tool_call.AsyncToolCall)]] ||
|#

*async* **submit\_tool\_results**(*tool\_results*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._runs.run.AsyncRun.submit_tool_results}

#|
|| Parameters | 

- **tool\_results** ([*FunctionResultDict*](../types/message.md#yandex_cloud_ml_sdk._tools.tool_result.FunctionResultDict) *\|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable)*[*[*FunctionResultDict*](../types/message.md#yandex_cloud_ml_sdk._tools.tool_result.FunctionResultDict)*]*)
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | None ||
|#

*async* **cancel**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._runs.run.AsyncRun.cancel}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | None ||
|#

*property* **custom\_max\_prompt\_tokens**\: *[int](https://docs.python.org/3/library/functions.html#int) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.run.AsyncRun.custom_max_prompt_tokens}

*async* **get\_result**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._runs.run.AsyncRun.get_result}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*AnyResultTypeT\_co*](../types/other.md#yandex_cloud_ml_sdk._types.operation.AnyResultTypeT_co) ||
|#

*async* **get\_status**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._runs.run.AsyncRun.get_status}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*OperationStatusTypeT*](../types/other.md#yandex_cloud_ml_sdk._types.operation.OperationStatusTypeT) ||
|#

*async* **wait**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*, *poll\_timeout=None*, *poll\_interval=None*){#yandex_cloud_ml_sdk._runs.run.AsyncRun.wait}

#|
|| Parameters | 

- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float))
- **poll\_timeout** ([*int*](https://docs.python.org/3/library/functions.html#int) *\| None*)
- **poll\_interval** ([*float*](https://docs.python.org/3/library/functions.html#float) *\| None*) ||
|| Return type | [*AnyResultTypeT\_co*](../types/other.md#yandex_cloud_ml_sdk._types.operation.AnyResultTypeT_co) ||
|#

**id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._runs.run.AsyncRun.id}

**assistant\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._runs.run.AsyncRun.assistant_id}

**thread\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._runs.run.AsyncRun.thread_id}

**created\_by**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._runs.run.AsyncRun.created_by}

**created\_at**\: *datetime*{#yandex_cloud_ml_sdk._runs.run.AsyncRun.created_at}

**labels**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [str](https://docs.python.org/3/library/stdtypes.html#str)] | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.run.AsyncRun.labels}

**custom\_temperature**\: *[float](https://docs.python.org/3/library/functions.html#float) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.run.AsyncRun.custom_temperature}

**custom\_max\_tokens**\: *[int](https://docs.python.org/3/library/functions.html#int) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.run.AsyncRun.custom_max_tokens}

**custom\_prompt\_truncation\_options**\: *[PromptTruncationOptions](../types/assistants.md#yandex_cloud_ml_sdk._assistants.prompt_truncation_options.PromptTruncationOptions) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.run.AsyncRun.custom_prompt_truncation_options}

**custom\_response\_format**\: *ResponseType | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.run.AsyncRun.custom_response_format}