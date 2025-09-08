---
sourcePath: en/_sdk-ref/sdk-ref/types/runs.md
---
# Run types

## *class* yandex\_cloud\_ml\_sdk.\_runs.status.**BaseRunStatus**{#yandex_cloud_ml_sdk._runs.status.BaseRunStatus}

*property* **is\_failed**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._runs.status.BaseRunStatus.is_failed}

*property* **is\_finished**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._runs.status.BaseRunStatus.is_finished}

*property* **is\_running**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._runs.status.BaseRunStatus.is_running}

*property* **is\_succeeded**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._runs.status.BaseRunStatus.is_succeeded}

*property* **status\_name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._runs.status.BaseRunStatus.status_name}

## *class* yandex\_cloud\_ml\_sdk.\_runs.status.**RunStatus**{#yandex_cloud_ml_sdk._runs.status.RunStatus}

**UNKNOWN** = *-1*{#yandex_cloud_ml_sdk._runs.status.RunStatus.UNKNOWN}

**RUN\_STATUS\_UNSPECIFIED** = *0*{#yandex_cloud_ml_sdk._runs.status.RunStatus.RUN_STATUS_UNSPECIFIED}

**PENDING** = *1*{#yandex_cloud_ml_sdk._runs.status.RunStatus.PENDING}

**IN\_PROGRESS** = *2*{#yandex_cloud_ml_sdk._runs.status.RunStatus.IN_PROGRESS}

**FAILED** = *3*{#yandex_cloud_ml_sdk._runs.status.RunStatus.FAILED}

**COMPLETED** = *4*{#yandex_cloud_ml_sdk._runs.status.RunStatus.COMPLETED}

**TOOL\_CALLS** = *5*{#yandex_cloud_ml_sdk._runs.status.RunStatus.TOOL_CALLS}

*property* **is\_running**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._runs.status.RunStatus.is_running}

*property* **is\_succeeded**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._runs.status.RunStatus.is_succeeded}

*property* **is\_failed**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._runs.status.RunStatus.is_failed}

**\_\_new\_\_**(*value*){#yandex_cloud_ml_sdk._runs.status.RunStatus.__new__i}

## *class* yandex\_cloud\_ml\_sdk.\_runs.status.**StreamEvent**{#yandex_cloud_ml_sdk._runs.status.StreamEvent}

**UNKNOWN** = *-1*{#yandex_cloud_ml_sdk._runs.status.StreamEvent.UNKNOWN}

**EVENT\_TYPE\_UNSPECIFIED** = *0*{#yandex_cloud_ml_sdk._runs.status.StreamEvent.EVENT_TYPE_UNSPECIFIED}

**PARTIAL\_MESSAGE** = *1*{#yandex_cloud_ml_sdk._runs.status.StreamEvent.PARTIAL_MESSAGE}

**ERROR** = *2*{#yandex_cloud_ml_sdk._runs.status.StreamEvent.ERROR}

**DONE** = *3*{#yandex_cloud_ml_sdk._runs.status.StreamEvent.DONE}

**TOOL\_CALLS** = *4*{#yandex_cloud_ml_sdk._runs.status.StreamEvent.TOOL_CALLS}

*property* **is\_running**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._runs.status.StreamEvent.is_running}

*property* **is\_succeeded**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._runs.status.StreamEvent.is_succeeded}

*property* **is\_failed**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._runs.status.StreamEvent.is_failed}

**\_\_new\_\_**(*value*){#yandex_cloud_ml_sdk._runs.status.StreamEvent.__new__i}

## *class* yandex\_cloud\_ml\_sdk.\_runs.result.**RunResult**{#yandex_cloud_ml_sdk._runs.result.RunResult}

RunResult(status: ‘StatusTypeT’, error: ‘str | None’, tool\_calls: ‘ToolCallList[ProtoAssistantToolCallList, ToolCallTypeT] | None’, \_message: ‘MessageTypeT | None’, usage: ‘Usage | None’)

**usage**\: *[Usage](model_results.md#yandex_cloud_ml_sdk._models.completions.result.Usage) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.result.RunResult.usage}

*property* **citations**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[Citation](message.md#yandex_cloud_ml_sdk._messages.citations.Citation)*]... ,{#yandex_cloud_ml_sdk._runs.result.RunResult.citations}

*property* **is\_failed**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._runs.result.RunResult.is_failed}

*property* **is\_finished**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._runs.result.RunResult.is_finished}

*property* **is\_running**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._runs.result.RunResult.is_running}

*property* **is\_succeeded**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._runs.result.RunResult.is_succeeded}

*property* **message**\: *[MessageTypeT](other.md#yandex_cloud_ml_sdk._runs.result.MessageTypeT) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.result.RunResult.message}

*property* **parts**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[Any](https://docs.python.org/3/library/typing.html#typing.Any)*]... ,{#yandex_cloud_ml_sdk._runs.result.RunResult.parts}

*property* **status\_name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._runs.result.RunResult.status_name}

*property* **text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.result.RunResult.text}

**status**\: *[StatusTypeT](other.md#yandex_cloud_ml_sdk._runs.result.StatusTypeT)*{#yandex_cloud_ml_sdk._runs.result.RunResult.status}

**error**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.result.RunResult.error}

**tool\_calls**\: *[ToolCallList](../internals/bases.md#yandex_cloud_ml_sdk._tools.tool_call_list.ToolCallList)[ToolCallList, [ToolCallTypeT](other.md#yandex_cloud_ml_sdk._tools.tool_call.ToolCallTypeT)] | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.result.RunResult.tool_calls}

## *class* yandex\_cloud\_ml\_sdk.\_runs.result.**RunStreamEvent**{#yandex_cloud_ml_sdk._runs.result.RunStreamEvent}

RunStreamEvent(status: ‘StatusTypeT’, error: ‘str | None’, tool\_calls: ‘ToolCallList[ProtoAssistantToolCallList, ToolCallTypeT] | None’, \_message: ‘MessageTypeT | None’)

*property* **is\_failed**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._runs.result.RunStreamEvent.is_failed}

*property* **is\_finished**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._runs.result.RunStreamEvent.is_finished}

*property* **is\_running**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._runs.result.RunStreamEvent.is_running}

*property* **is\_succeeded**\: *[bool](https://docs.python.org/3/library/functions.html#bool)*{#yandex_cloud_ml_sdk._runs.result.RunStreamEvent.is_succeeded}

*property* **message**\: *[MessageTypeT](other.md#yandex_cloud_ml_sdk._runs.result.MessageTypeT) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.result.RunStreamEvent.message}

*property* **parts**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[Any](https://docs.python.org/3/library/typing.html#typing.Any)*]... ,{#yandex_cloud_ml_sdk._runs.result.RunStreamEvent.parts}

*property* **status\_name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_cloud_ml_sdk._runs.result.RunStreamEvent.status_name}

*property* **text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.result.RunStreamEvent.text}

**status**\: *[StatusTypeT](other.md#yandex_cloud_ml_sdk._runs.result.StatusTypeT)*{#yandex_cloud_ml_sdk._runs.result.RunStreamEvent.status}

**error**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.result.RunStreamEvent.error}

**tool\_calls**\: *[ToolCallList](../internals/bases.md#yandex_cloud_ml_sdk._tools.tool_call_list.ToolCallList)[ToolCallList, [ToolCallTypeT](other.md#yandex_cloud_ml_sdk._tools.tool_call.ToolCallTypeT)] | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_cloud_ml_sdk._runs.result.RunStreamEvent.tool_calls}