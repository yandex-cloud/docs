# Fixing the `audio duration should be less than 30s` error


## Issue description {#issue-description}

When uploading an OGG audio file to the {{ speechkit-name }} API for recognition, you get this error:

```text
{'error_code': 'BAD_REQUEST', 'error_message': 'audio duration should be less than 30s'}
```
This happens even if the uploaded audio file is shorter than 30 seconds.

## Solution {#issue-resolution}

The cause of the error is that the codec of the file uploaded for recognition is not supported. For OGG files, {{ speechkit-name }} only supports the [Opus codec](../../../speechkit/formats.md#OggOpus).

For proper recognition, you need to upload data encoded by this codec.
