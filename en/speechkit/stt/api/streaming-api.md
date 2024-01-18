# API v2 for streaming recognition

The service is located at: `stt.{{ api-host }}:443`

### Message with recognition settings {#specification-msg}

| Parameter | Description |
----- | -----
| config | **object**<br>Field with the recognition settings and folder ID |
| config<br>.specification | **object**<br>Recognition settings |
| config<br>.specification<br>.languageCode | **string**<br>Language that recognition will be performed for.<br/>See a list of available languages in the [model description](../models.md). The default value is `ru-RU` (Russian). |
| config<br>.specification<br>.model | **string**<br>Language model to use for recognition.<br/>The closer the model is matched, the better is the recognition result. You can only specify one model per request.<br/>[Acceptable values](../models.md) depend on the selected language. The default value is `general`. |
| config<br>.specification<br>.profanityFilter | **boolean**<br>Profanity filter.<br/>Acceptable values include:<ul><li>`true`: Exclude profanities from recognition results.</li><li>`false` (default): Do not exclude profanities from recognition results.</li></ul> |
| config<br>.specification<br>.partialResults | **boolean**<br>Filter intermediate results.<br/>Acceptable values include:<ul><li>`true`: Return intermediate results (part of the recognized utterance). For intermediate results, `final` is set to `false`:</li><li>`false` (default): Return only the final results (the entire recognized utterance). |
| config<br>.specification<br>.singleUtterance | **boolean**<br>Flag that disables recognition after the first utterance.<br/>Acceptable values include:<ul><li>`true`: Recognize only the first utterance, stop recognition, and wait for the user to disconnect.</li><li>`false` (default): Continue recognition until the end of the session.</li></ul> |
| config<br>.specification<br>.audioEncoding | **string**<br>[Format](../../formats.md) of the audio being provided.<br/>Acceptable values include:<ul><li>`LINEAR16_PCM`: [LPCM without WAV header](../../formats.md#lpcm).</li><li>`OGG_OPUS` (default): [OggOpus](../../formats.md#oggopus) format.</li></ul> |
| config<br>.specification<br>.sampleRateHertz | **integer** (int64)<br>Sampling frequency of the audio being provided.<br/>This parameter is required if `format` is set to `LINEAR16_PCM`. Acceptable values include:<ul><li>`48000` (default): Sampling rate of 48 kHz.</li><li>`16000`: Sampling rate of 16 kHz.</li><li>`8000`: Sampling rate of 8 kHz.</li></ul> |
| config.<br>specification.<br>rawResults | **boolean** <br>Flag that toggles spelling out numbers. `true`: Spell out. `false` (default): Write as numbers. |
| folderId | **string**<br><p>[ID of the folder](../../../resource-manager/operations/folder/get-id.md) that you have access to. It is required for authorization with a user account (see [{#T}](../../concepts/auth.md)). Do not use this field if you make a request on behalf of a service account.</p> <p>The maximum string length is 50 characters.</p> |

### Experimental additional recognition settings {#additional-settings}

For streaming recognition models, new recognition settings are supported. They are passed to a gRPC procedure via metadata.

| Parameter | Description |
----- | -----
| `x-normalize-partials` | **boolean**<br>Flag that allows you to get intermediate recognition results (parts of a recognized utterance) in a normalized format: numbers are specified as digits, the profanity filter is enabled, etc.<br>Acceptable values include:<ul><li>`true `: Return a normalized result.</li><li>`false` (default): Return an non-normalized result. |

### Audio message {#audio-msg}

Use the `"Transfer-Encoding: chunked"` header for data streaming.

| Parameter | Description |
----- | -----
| `audio_content` | Audio fragment represented as an array of bytes. The audio must match the format specified in the [message with recognition settings](#specification-msg). |


### Message with recognition results {#response}

If speech fragment recognition is successful, you will receive a message containing a list of recognition results `chunks[]`. Each result contains the following fields:

* `alternatives[]`: List of recognized text alternatives. Each alternative contains the following fields:
   * `text`: Recognized text
   * `confidence`: This field is currently not supported. Do not use it.
* `final`: Flag indicating that this recognition result is final and will not change anymore. If the value is `false`, it means that the recognition result is intermediate and may change as the next speech fragments are recognized.
* `endOfUtterance`: Flag indicating that this result contains the ending of the utterance. If the value is `true`, the new utterance will start with the next result obtained.

   {% note info %}

   If you specified `singleUtterance=true` in the settings, only one utterance will be recognized per session. After sending a message where `endOfUtterance` is `true`, the server does not recognize the following utterances and waits until you end the session.

   {% endnote %}

### Error codes returned by the server {#error_codes}

To see how gRPC statuses correspond to HTTP codes, see [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto).

List of possible gRPC errors returned by the service:

| Code | Status | Description |
----- | ----- | -----
| 3 | `INVALID_ARGUMENT` | Incorrect request parameters specified. Details are provided in the `details` field. |
| 9 | `RESOURCE_EXHAUSTED` | Client exceeded a quota. |
| 16 | `UNAUTHENTICATED` | Operation requires authentication. Check the IAM token and the folder ID that you provided. |
| 13 | `INTERNAL` | Internal server error. This error means that the operation cannot be performed due to a server-side technical problem, e.g., due to insufficient computing resources. |

## Use cases {#examples}

* [{#T}](streaming-examples.md).
