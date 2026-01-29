---
sourcePath: en/_sdk-ref/sdk-ref/types/runs.md
---
# Run types

## *class* yandex\_ai\_studio\_sdk.\_runs.status.**BaseRunStatus**{#yandex_ai_studio_sdk._runs.status.BaseRunStatus}

Class for run status enumerations.

*property* **is\_failed**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_ai_studio_sdk._runs.status.BaseRunStatus.is_failed}

Check if operation execution failed.

*property* **is\_finished**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_ai_studio_sdk._runs.status.BaseRunStatus.is_finished}

Check if operation execution finished.

*property* **is\_running**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_ai_studio_sdk._runs.status.BaseRunStatus.is_running}

Check if operation execution is still in progress.

*property* **is\_succeeded**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_ai_studio_sdk._runs.status.BaseRunStatus.is_succeeded}

Check if operation execution completed successfully.

*property* **status\_name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._runs.status.BaseRunStatus.status_name}

Get operation execution status name.

## *class* yandex\_ai\_studio\_sdk.\_runs.status.**RunStatus**{#yandex_ai_studio_sdk._runs.status.RunStatus}

Enumeration of possible run statuses.

**UNKNOWN** = *-1*{#yandex_ai_studio_sdk._runs.status.RunStatus.UNKNOWN}

Unknown status (-1)

**RUN\_STATUS\_UNSPECIFIED** = *0*{#yandex_ai_studio_sdk._runs.status.RunStatus.RUN_STATUS_UNSPECIFIED}

Status not specified

**PENDING** = *1*{#yandex_ai_studio_sdk._runs.status.RunStatus.PENDING}

Status not specified

**IN\_PROGRESS** = *2*{#yandex_ai_studio_sdk._runs.status.RunStatus.IN_PROGRESS}

Run is in progress

**FAILED** = *3*{#yandex_ai_studio_sdk._runs.status.RunStatus.FAILED}

Run has failed

**COMPLETED** = *4*{#yandex_ai_studio_sdk._runs.status.RunStatus.COMPLETED}

Run completed successfully

**TOOL\_CALLS** = *5*{#yandex_ai_studio_sdk._runs.status.RunStatus.TOOL_CALLS}

Run requires tool calls

*property* **is\_running**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_ai_studio_sdk._runs.status.RunStatus.is_running}

Check if operation execution is still in progress.

*property* **is\_succeeded**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_ai_studio_sdk._runs.status.RunStatus.is_succeeded}

Check if operation execution completed successfully.

*property* **is\_failed**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_ai_studio_sdk._runs.status.RunStatus.is_failed}

Check if operation execution failed.

**\_\_new\_\_**(*value*){#yandex_ai_studio_sdk._runs.status.RunStatus.__new__i}

## *class* yandex\_ai\_studio\_sdk.\_runs.status.**StreamEvent**{#yandex_ai_studio_sdk._runs.status.StreamEvent}

Enumeration of possible stream events during run execution.

**UNKNOWN** = *-1*{#yandex_ai_studio_sdk._runs.status.StreamEvent.UNKNOWN}

Unknown event type (-1)

**EVENT\_TYPE\_UNSPECIFIED** = *0*{#yandex_ai_studio_sdk._runs.status.StreamEvent.EVENT_TYPE_UNSPECIFIED}

Event type not specified

**PARTIAL\_MESSAGE** = *1*{#yandex_ai_studio_sdk._runs.status.StreamEvent.PARTIAL_MESSAGE}

Partial message content

**ERROR** = *2*{#yandex_ai_studio_sdk._runs.status.StreamEvent.ERROR}

Error occurred

**DONE** = *3*{#yandex_ai_studio_sdk._runs.status.StreamEvent.DONE}

Execution completed

**TOOL\_CALLS** = *4*{#yandex_ai_studio_sdk._runs.status.StreamEvent.TOOL_CALLS}

Tool calls required

*property* **is\_running**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_ai_studio_sdk._runs.status.StreamEvent.is_running}

Check if operation execution is still in progress.

*property* **is\_succeeded**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_ai_studio_sdk._runs.status.StreamEvent.is_succeeded}

Check if operation execution completed successfully.

*property* **is\_failed**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_ai_studio_sdk._runs.status.StreamEvent.is_failed}

Check if operation execution failed.

**\_\_new\_\_**(*value*){#yandex_ai_studio_sdk._runs.status.StreamEvent.__new__i}

## *class* yandex\_ai\_studio\_sdk.\_runs.result.**RunResult**{#yandex_ai_studio_sdk._runs.result.RunResult}

RunResult(status: ‘StatusTypeT’, error: ‘str | None’, tool\_calls: ‘ToolCallList[ProtoAssistantToolCallList, ToolCallTypeT] | None’, \_message: ‘MessageTypeT | None’, usage: ‘Usage | None’)

**usage**\: *[Usage](model_results.md#yandex_ai_studio_sdk._models.completions.result.Usage) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._runs.result.RunResult.usage}

Token usage statistics

*property* **citations**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[Citation](message.md#yandex_ai_studio_sdk._messages.citations.Citation)*]... ,{#yandex_ai_studio_sdk._runs.result.RunResult.citations}

Return citations from the assistant’s message if present.

Citations refer to references to external sources or documents that the model used to generate its response. These typically include: - Source document IDs - Document titles or descriptions - Relevant snippets or passages Returns None if no citations are present in the message.

*property* **is\_failed**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_ai_studio_sdk._runs.result.RunResult.is_failed}

Check if operation execution failed.

*property* **is\_finished**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_ai_studio_sdk._runs.result.RunResult.is_finished}

Check if operation execution finished.

*property* **is\_running**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_ai_studio_sdk._runs.result.RunResult.is_running}

Check if operation execution is still in progress.

*property* **is\_succeeded**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_ai_studio_sdk._runs.result.RunResult.is_succeeded}

Check if operation execution completed successfully.

*property* **message**\: *[MessageTypeT](other.md#yandex_ai_studio_sdk._runs.result.MessageTypeT) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._runs.result.RunResult.message}

Get the message result of the run. If run has failed this property raise error value.

*property* **parts**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[Any](https://docs.python.org/3/library/typing.html#typing.Any)*]... ,{#yandex_ai_studio_sdk._runs.result.RunResult.parts}

Get message parts if available, otherwise return nothing.

*property* **status\_name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._runs.result.RunResult.status_name}

Get operation execution status name.

*property* **text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._runs.result.RunResult.text}

Get the text content of the message if available, otherwise return nothing.

**status**\: *[StatusTypeT](other.md#yandex_ai_studio_sdk._runs.result.StatusTypeT)*{#yandex_ai_studio_sdk._runs.result.RunResult.status}

Run status

**error**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._runs.result.RunResult.error}

Error message if run failed

**tool\_calls**\: *[ToolCallList](../internals/bases.md#yandex_ai_studio_sdk._tools.tool_call_list.ToolCallList)[ToolCallList, [ToolCallTypeT](other.md#yandex_ai_studio_sdk._tools.tool_call.ToolCallTypeT)] | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._runs.result.RunResult.tool_calls}

List of tool calls if any

## *class* yandex\_ai\_studio\_sdk.\_runs.result.**RunStreamEvent**{#yandex_ai_studio_sdk._runs.result.RunStreamEvent}

Represents a streaming event in a run execution process.

This class encapsulates all possible events that can occur during streaming execution of a run, including: - Partial and completed messages - Errors that may occur during execution - Tool calls initiated by the model

*property* **is\_failed**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_ai_studio_sdk._runs.result.RunStreamEvent.is_failed}

Check if operation execution failed.

*property* **is\_finished**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_ai_studio_sdk._runs.result.RunStreamEvent.is_finished}

Check if operation execution finished.

*property* **is\_running**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_ai_studio_sdk._runs.result.RunStreamEvent.is_running}

Check if operation execution is still in progress.

*property* **is\_succeeded**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_ai_studio_sdk._runs.result.RunStreamEvent.is_succeeded}

Check if operation execution completed successfully.

*property* **message**\: *[MessageTypeT](other.md#yandex_ai_studio_sdk._runs.result.MessageTypeT) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._runs.result.RunStreamEvent.message}

Get the message result of the run. If run has failed this property raise error value.

*property* **parts**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[Any](https://docs.python.org/3/library/typing.html#typing.Any)*]... ,{#yandex_ai_studio_sdk._runs.result.RunStreamEvent.parts}

Get message parts if available, otherwise return nothing.

*property* **status\_name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._runs.result.RunStreamEvent.status_name}

Get operation execution status name.

*property* **text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._runs.result.RunStreamEvent.text}

Get the text content of the message if available, otherwise return nothing.

**status**\: *[StatusTypeT](other.md#yandex_ai_studio_sdk._runs.result.StatusTypeT)*{#yandex_ai_studio_sdk._runs.result.RunStreamEvent.status}

Run status

**error**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._runs.result.RunStreamEvent.error}

Error message if run failed

**tool\_calls**\: *[ToolCallList](../internals/bases.md#yandex_ai_studio_sdk._tools.tool_call_list.ToolCallList)[ToolCallList, [ToolCallTypeT](other.md#yandex_ai_studio_sdk._tools.tool_call.ToolCallTypeT)] | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._runs.result.RunStreamEvent.tool_calls}

List of tool calls if any