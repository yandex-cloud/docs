---
editable: false
---

# REST: Server events

Realtime server-to-client events.

## Methods

#|
||Method | Description ||
|| [realtime.server.error](realtimeServerError.md) | error ||
|| [realtime.server.session.created](realtimeServerSessionCreated.md) | session.created ||
|| [realtime.server.session.updated](realtimeServerSessionUpdated.md) | session.updated ||
|| [realtime.server.conversation.item.added](realtimeServerConversationItemAdded.md) | conversation.item.added ||
|| [realtime.server.conversation.item.created](realtimeServerConversationItemCreated.md) | conversation.item.created ||
|| [realtime.server.conversation.item.deleted](realtimeServerConversationItemDeleted.md) | conversation.item.deleted ||
|| [realtime.server.conversation.item.done](realtimeServerConversationItemDone.md) | conversation.item.done ||
|| [realtime.server.conversation.item.input_audio_transcription.completed](realtimeServerConversationItemInputAudioTranscriptionCompleted.md) | conversation.item.input_audio_transcription.completed ||
|| [realtime.server.conversation.item.input_audio_transcription.delta](realtimeServerConversationItemInputAudioTranscriptionDelta.md) | conversation.item.input_audio_transcription.delta '[CURRENTLY NOT SUPPORTED]' ||
|| [realtime.server.conversation.item.input_audio_transcription.failed](realtimeServerConversationItemInputAudioTranscriptionFailed.md) | conversation.item.input_audio_transcription.failed '[CURRENTLY NOT SUPPORTED]' ||
|| [realtime.server.conversation.item.input_audio_transcription.segment](realtimeServerConversationItemInputAudioTranscriptionSegment.md) | conversation.item.input_audio_transcription.segment '[CURRENTLY NOT SUPPORTED]' ||
|| [realtime.server.conversation.item.retrieved](realtimeServerConversationItemRetrieved.md) | conversation.item.retrieved ||
|| [realtime.server.conversation.item.truncated](realtimeServerConversationItemTruncated.md) | conversation.item.truncated ||
|| [realtime.server.input_audio_buffer.cleared](realtimeServerInputAudioBufferCleared.md) | input_audio_buffer.cleared '[CURRENTLY NOT SUPPORTED]' ||
|| [realtime.server.input_audio_buffer.committed](realtimeServerInputAudioBufferCommitted.md) | input_audio_buffer.committed ||
|| [realtime.server.input_audio_buffer.dtmf_event_received](realtimeServerInputAudioBufferDtmfEventReceived.md) | input_audio_buffer.dtmf_event_received '[CURRENTLY NOT SUPPORTED]' ||
|| [realtime.server.input_audio_buffer.speech_started](realtimeServerInputAudioBufferSpeechStarted.md) | input_audio_buffer.speech_started ||
|| [realtime.server.input_audio_buffer.speech_stopped](realtimeServerInputAudioBufferSpeechStopped.md) | input_audio_buffer.speech_stopped ||
|| [realtime.server.input_audio_buffer.timeout_triggered](realtimeServerInputAudioBufferTimeoutTriggered.md) | input_audio_buffer.timeout_triggered '[CURRENTLY NOT SUPPORTED]' ||
|| [realtime.server.output_audio_buffer.cleared](realtimeServerOutputAudioBufferCleared.md) | output_audio_buffer.cleared '[CURRENTLY NOT SUPPORTED]' ||
|| [realtime.server.output_audio_buffer.started](realtimeServerOutputAudioBufferStarted.md) | output_audio_buffer.started '[CURRENTLY NOT SUPPORTED]' ||
|| [realtime.server.output_audio_buffer.stopped](realtimeServerOutputAudioBufferStopped.md) | output_audio_buffer.stopped '[CURRENTLY NOT SUPPORTED]' ||
|| [realtime.server.response.content_part.added](realtimeServerResponseContentPartAdded.md) | response.content_part.added ||
|| [realtime.server.response.content_part.done](realtimeServerResponseContentPartDone.md) | response.content_part.done ||
|| [realtime.server.response.created](realtimeServerResponseCreated.md) | response.created ||
|| [realtime.server.response.done](realtimeServerResponseDone.md) | response.done ||
|| [realtime.server.response.function_call_arguments.delta](realtimeServerResponseFunctionCallArgumentsDelta.md) | response.function_call_arguments.delta ||
|| [realtime.server.response.function_call_arguments.done](realtimeServerResponseFunctionCallArgumentsDone.md) | response.function_call_arguments.done ||
|| [realtime.server.response.mcp_call.completed](realtimeServerResponseMcpCallCompleted.md) | response.mcp_call.completed '[CURRENTLY NOT SUPPORTED]' ||
|| [realtime.server.response.mcp_call.failed](realtimeServerResponseMcpCallFailed.md) | response.mcp_call.failed '[CURRENTLY NOT SUPPORTED]' ||
|| [realtime.server.response.mcp_call.in_progress](realtimeServerResponseMcpCallInProgress.md) | response.mcp_call.in_progress '[CURRENTLY NOT SUPPORTED]' ||
|| [realtime.server.response.mcp_call_arguments.delta](realtimeServerResponseMcpCallArgumentsDelta.md) | response.mcp_call_arguments.delta '[CURRENTLY NOT SUPPORTED]' ||
|| [realtime.server.response.mcp_call_arguments.done](realtimeServerResponseMcpCallArgumentsDone.md) | response.mcp_call_arguments.done ||
|| [realtime.server.response.output_audio.delta](realtimeServerResponseOutputAudioDelta.md) | response.output_audio.delta '[CURRENTLY NOT SUPPORTED]' ||
|| [realtime.server.response.output_audio.done](realtimeServerResponseOutputAudioDone.md) | response.output_audio.done '[CURRENTLY NOT SUPPORTED]' ||
|| [realtime.server.response.output_audio_transcript.delta](realtimeServerResponseOutputAudioTranscriptDelta.md) | response.output_audio_transcript.delta '[CURRENTLY NOT SUPPORTED]' ||
|| [realtime.server.response.output_audio_transcript.done](realtimeServerResponseOutputAudioTranscriptDone.md) | response.output_audio_transcript.done ||
|| [realtime.server.response.output_item.added](realtimeServerResponseOutputItemAdded.md) | response.output_item.added ||
|| [realtime.server.response.output_item.done](realtimeServerResponseOutputItemDone.md) | response.output_item.done ||
|| [realtime.server.response.output_text.delta](realtimeServerResponseOutputTextDelta.md) | response.output_text.delta [CURRENTLY NOT SUPPORTTED] ||
|| [realtime.server.response.output_text.done](realtimeServerResponseOutputTextDone.md) | response.output_text.done '[CURRENTLY NOT SUPPORTED]' ||
|| [realtime.server.mcp_list_tools.completed](realtimeServerMcpListToolsCompleted.md) | mcp_list_tools.completed ||
|| [realtime.server.mcp_list_tools.failed](realtimeServerMcpListToolsFailed.md) | mcp_list_tools.failed ||
|| [realtime.server.mcp_list_tools.in_progress](realtimeServerMcpListToolsInProgress.md) | mcp_list_tools.in_progress ||
|| [realtime.server.rate_limits.updated](realtimeServerRateLimitsUpdated.md) | rate_limits.updated '[CURRENTLY NOT SUPPORTED]' ||
|#