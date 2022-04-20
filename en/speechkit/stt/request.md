# Synchronous audio recognition

Synchronous audio recognition ensures fast response times and is suitable for pre-recorded small single-channel audio fragments.

If you want to recognize speech over the same connection, use [streaming mode](streaming.md). In streaming mode, you can get intermediate recognition results.

## Audio requirements {#Audio-requirements}

The audio you send must meet the following requirements:

1. Maximum file size: {{ stt-short-fileSize }}.
1. Maximum length: {{ stt-short-audioLength }}.
1. Maximum number of audio channels: {{ stt-short-channelsCount }}.

If your file is larger, longer, or has more audio channels, use [asynchronous recognition](transcribation.md).
