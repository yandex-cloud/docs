# Fixing the «audio duration should be less than 30s» error in SpeechKit

## Issue description {#issue-description}

When uploading an OGG audio file to the SpeechKit API for streaming recognition, you see the error:

```text
{'error_code': 'BAD_REQUEST', 'error_message': 'audio duration should be less than 30s'}
```

However, the length of the audio file uploaded to SpeechKit might be less than 30 seconds.

## Solution {#issue-resolution}

The cause of the error is that the codec of the file uploaded for recognition is not supported.
For example, for the OGG video container format, the service only supports the [Opus codec](../../../speechkit/formats.md#OggOpus).

For proper OGG format recognition, upload data encoded by the Opus audio codec.
