---
sourcePath: en/_sdk-ref/sdk-ref/async/runs.md
---
# Runs domain

## *class* yandex\_cloud\_ml\_sdk.\_runs.domain.**AsyncRuns**{#yandex_cloud_ml_sdk._runs.domain.AsyncRuns}

Class for Runs operations. Provides core functionality for managing assistant execution in streams.

For usage examples see [runs example](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/blob/master/examples/async/assistants/runs.py).

*async* **get**(*run\_id*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._runs.domain.AsyncRuns.get}

Get a run by ID.

#|
|| Parameters | 

- **run\_id** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – Run ID
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – The timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | [*AsyncRun*](#yandex_cloud_ml_sdk._runs.run.AsyncRun) ||
|#

*async* **get\_last\_by\_thread**(*thread*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._runs.domain.AsyncRuns.get_last_by_thread}

Get the last run for a thread.

#|
|| Parameters | 

- **thread** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*BaseThread*](../internals/bases.md#yandex_cloud_ml_sdk._threads.thread.BaseThread)) – Thread ID or instance
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – The timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | [*AsyncRun*](#yandex_cloud_ml_sdk._runs.run.AsyncRun) ||
|#

*async* **list**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *page\_size=Undefined*, *timeout=60*){#yandex_cloud_ml_sdk._runs.domain.AsyncRuns.list}

List runs. Returns an async iterator to retrieve all runs.

#|
|| Parameters | 

- **page\_size** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../types/other.md#yandex_cloud_ml_sdk._types.misc.Undefined)) – Number of items per page. Larger values reduce the number of network calls but increase memory consumption per request.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – The timeout, or the maximum time to wait for each network request to complete in seconds. Defaults to 60 seconds. This affects the network behavior but not the total time for iteration. ||
|| Return type | [*AsyncIterator*](https://docs.python.org/3/library/collections.abc.html#collections.abc.AsyncIterator)[[*AsyncRun*](#yandex_cloud_ml_sdk._runs.run.AsyncRun)] ||
|#

## *class* yandex\_cloud\_ml\_sdk.\_runs.run.**AsyncRun**{#yandex_cloud_ml_sdk._runs.run.AsyncRun}

Asynchronous implementation of Run operations.

Represents a server-side Run object that has been started by an assistant on a specific thread. It implements the Operation interface, allowing you to monitor the Run’s execution on the server, track its progress, and retrieve its results.

The AsyncRun provides asynchronous methods to: - Listen to real-time events from the running assistant - Submit tool execution results back to continue the conversation - Monitor the Run’s status and retrieve final results - Handle the complete lifecycle of an assistant conversation session

*async* **listen**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *events\_start\_idx=0*, *timeout=60*){#yandex_cloud_ml_sdk._runs.run.AsyncRun.listen}

Listen to run events stream.

#|
|| Parameters | 

- **events\_start\_idx** ([*int*](https://docs.python.org/3/library/functions.html#int)) – Starting event index
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – The timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | [*AsyncIterator*](https://docs.python.org/3/library/collections.abc.html#collections.abc.AsyncIterator)[[*RunStreamEvent*](../types/runs.md#yandex_cloud_ml_sdk._runs.result.RunStreamEvent)[[*AsyncToolCall*](tools.md#yandex_cloud_ml_sdk._tools.tool_call.AsyncToolCall)]] ||
|#

*async* **submit\_tool\_results**(*tool\_results*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._runs.run.AsyncRun.submit_tool_results}

Submit tool execution results to continue the run.

#|
|| Parameters | 

- **tool\_results** ([*FunctionResultDict*](../types/message.md#yandex_cloud_ml_sdk._tools.tool_result.FunctionResultDict) *\|* [*Iterable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable)*[*[*FunctionResultDict*](../types/message.md#yandex_cloud_ml_sdk._tools.tool_result.FunctionResultDict)*]*) – Tool call results to submit
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – The timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | None ||
|#

*async* **cancel**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_cloud_ml_sdk._runs.run.AsyncRun.cancel}

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | None ||
|#

*property* **custom\_max\_prompt\_tokens**\: *[int](https://docs.python.org/3/library/functions.html#int) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.run.AsyncRun.custom_max_prompt_tokens}

Get max prompt tokens from truncation options if set.

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

Unique run identifier

**assistant\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._runs.run.AsyncRun.assistant_id}

ID of the assistant used

**thread\_id**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._runs.run.AsyncRun.thread_id}

ID of the thread used

**created\_by**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._runs.run.AsyncRun.created_by}

Creator of the run

**created\_at**\: *datetime*{#yandex_cloud_ml_sdk._runs.run.AsyncRun.created_at}

Creation timestamp

**labels**\: *[dict](https://docs.python.org/3/library/stdtypes.html#dict)[[str](https://docs.python.org/3/library/stdtypes.html#str), [str](https://docs.python.org/3/library/stdtypes.html#str)] | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.run.AsyncRun.labels}

Optional metadata labels

**custom\_temperature**\: *[float](https://docs.python.org/3/library/functions.html#float) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.run.AsyncRun.custom_temperature}

Custom temperature setting

**custom\_max\_tokens**\: *[int](https://docs.python.org/3/library/functions.html#int) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.run.AsyncRun.custom_max_tokens}

Custom max tokens setting

**custom\_prompt\_truncation\_options**\: *[PromptTruncationOptions](../types/assistants.md#yandex_cloud_ml_sdk._assistants.prompt_truncation_options.PromptTruncationOptions) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.run.AsyncRun.custom_prompt_truncation_options}

Custom prompt truncation options

**custom\_response\_format**\: *ResponseType | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.run.AsyncRun.custom_response_format}

Custom response format