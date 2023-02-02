# API v2 for streaming recognition

The service is located at: `stt.{{ api-host }}:443`

### Message with recognition settings {#specification-msg}

| Parameter | Description |
----- | -----
| config | **object**<br>Field with the recognition settings and folder ID. |
| config<br>.specification | **object**<br>Recognition settings. |
| config<br>.specification<br>.languageCode | **string**<br>Language that recognition will be performed for.<br/>See a list of available languages in the [model description](../models.md). The default value is `ru-RU` (Russian). |
| config<br>.specification<br>.model | **string**<br>The language model to be used for recognition.<br/>The closer the model is matched, the better the recognition result. You can only specify one model per request.<br/>[Acceptable values](../models.md) depend on the selected language. Default value: `general`. |
| config<br>.specification<br>.profanityFilter | **boolean**<br>Profanity filter.<br/>Acceptable values:<ul><li>`true`: Exclude profanities from recognition results.</li><li>`false` (default): Do not exclude profanities from recognition results.</li></ul> |
| config<br>.specification<br>.partialResults | **boolean**<br>Filter intermediate results.<br/>Acceptable values:<ul><li>`true`: Return intermediate results (part of the recognized utterance). For intermediate results, `final` is set to `false`.</li><li>`false` (default): Return only the final results (the entire recognized utterance). |
| config<br>.specification<br>.singleUtterance | **boolean**<br>Flag that disables recognition after the first utterance.<br/>Acceptable values:<ul><li>`true`: Recognize only the first utterance, stop recognition, and wait for the user to disconnect.</li><li>`false` (default): Continue recognition until the end of the session.</li></ul> |
| config<br>.specification<br>.audioEncoding | **string**<br>The [format](../../formats.md) of the synthesized audio.<br/>Acceptable values:<ul><li>`LINEAR16_PCM`: [LPCM without WAV header](../../formats.md#lpcm).</li><li>`OGG_OPUS` (default): [OggOpus](../../formats.md#oggopus) format.</li></ul> |
| config<br>.specification<br>.sampleRateHertz | **integer** (int64)<br>The sampling frequency of the submitted audio.<br/>Required if `format` is set to `LINEAR16_PCM`. Acceptable values:<ul><li>`48000` (default): Sampling rate of 48 kHz.</li><li>`16000`: Sampling rate of 16 kHz.</li><li>`8000`: Sampling rate of 8 kHz.</li></ul> |
| config.<br>specification.<br>rawResults | **boolean** <br>Flag that indicates how to write numbers. `true`: In words. `false` (by default): In numbers. |
| folderId | **string**<br><p>[ID of the folder](../../../resource-manager/operations/folder/get-id.md) that you have access to. Required for authorization with a user account (see the [{#T}](../../concepts/auth.md) resource). Don't specify this field if you make a request on behalf of a service account.</p> <p>Maximum string length: 50 characters.</p> |

### Experimental additional recognition settings {#additional-settings}

For streaming recognition models, new recognition settings are supported. They are passed to a gRPC procedure via metadata.

| Parameter | Description |
----- | -----
| `x-normalize-partials` | **boolean**<br>A flag that lets you get intermediate recognition results (parts of a recognized utterance) in normalized form: numbers are passed as digits, the profanity filter is enabled, and so on.<br>Acceptable values:<ul><li>`true `: Return a normalized result.</li><li>`false` (default): Return an unnormalized result. |

### Audio message {#audio-msg}

| Parameter | Description |
----- | -----
| `audio_content` | An audio fragment represented as an array of bytes. The audio must match the format specified in the [message with recognition settings](#specification-msg). |


### Message with recognition results {#response}

If speech fragment recognition is successful, you will receive a message containing a list of recognition results `chunks[]`. Each result contains the following fields:

* `alternatives[]`: List of recognized text alternatives. Each alternative contains the following fields:
   * `text`: Recognized text.
   * `confidence`: This field currently isn't supported. Don't use it.
* `final`: The flag indicating that this recognition result is final and will not change anymore. If the value is `false`, it means that the recognition result is intermediate and may change as the following speech fragments are recognized.
* `endOfUtterance`: The flag indicating that this result contains the end of the utterance. If the value is `true`, the new utterance will start with the next result obtained.

   {% note info %}

   If you specified `singleUtterance=true` in the settings, only one utterance will be recognized per session. After sending a message where `endOfUtterance` is `true`, the server doesn't recognize the following utterances and waits until you end the session.

   {% endnote %}

### Error codes returned by the server {#error_codes}

To see how gRPC statuses correspond to HTTP codes, see [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto).

List of possible gRPC errors returned by the service:

| Code | Status | Description |
----- | ----- | -----
| 3 | `INVALID_ARGUMENT` | Incorrect request parameters specified. Details are provided in the `details` field. |
| 9 | `RESOURCE_EXHAUSTED` | A client exceeded a quota. |
| 16 | `UNAUTHENTICATED` | The operation requires authentication. Check the IAM token and the folder ID that you passed. |
| 13 | `INTERNAL` | Internal server error. This error means that the operation cannot be performed due to a server-side technical problem. For example, due to insufficient computing resources. |
