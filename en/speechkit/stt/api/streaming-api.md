# API v2 for streaming recognition


The streaming recognition service is located at: `stt.{{ api-host }}:443`

### Message with recognition settings {#specification-msg}

Parameter | Description
----- | -----
config | **object**<br>Field with the recognition settings and folder ID.
config<br>.specification | **object**<br>Recognition settings.
config<br>.specification<br>.languageCode | **string**<br>Recognition language.<br/>See the [model description](../models.md) for acceptable values. The default value is `ru-RU`, Russian.
config<br>.specification<br>.model | **string**<br>Language model to use for recognition.<br/>The more accurate your choice of the model, the better the recognition result. You can specify only one model per request.<br/>The [acceptable values](../models.md) depend on the language you select. The default value is `general`.
config<br>.specification<br>.profanityFilter | **boolean**<br>Profanity filter.<br/>Acceptable values:<ul><li>`true`: Exclude profanities from the recognition results.</li><li>`false` (default): Do not exclude profanities from the recognition results.</li></ul>
config<br>.specification<br>.partialResults | **boolean**<br>Intermediate result filter.<br/>Acceptable values:<ul><li>`true`: Return intermediate results (part of recognized utterance). For intermediate results, `final` equals `false`.</li><li>`false` (default): Return only the final results (entire recognized utterance).
config<br>.specification<br>.singleUtterance | **boolean**<br>Flag disabling recognition after the first utterance.<br/>Acceptable values:<ul><li>`true`: Recognize only the first utterance, stop recognition and wait for the user to disconnect.</li><li>`false` (default): Continue recognition until the end of the session.</li></ul>
config<br>.specification<br>.audioEncoding | **string**<br>Submitted audio [format](../../formats.md).<br/>Acceptable values:<ul><li>`LINEAR16_PCM`: [LPCM without a WAV header](../../formats.md#lpcm).</li><li>`OGG_OPUS` (default): [OggOpus](../../formats.md#oggopus) format.</li></ul>
config<br>.specification<br>.sampleRateHertz | **integer** (int64)<br>Submitted audio sampling frequency.<br/>This parameter is required if `format` equals `LINEAR16_PCM`. Acceptable values:<ul><li>`48000` (default): 48 kHz.</li><li>`16000`: 16 kHz.</li><li>`8000`: 8 kHz.</li></ul>
config.<br>specification.<br>rawResults | **boolean** <br>Flag for how to write numbers: `true` for words, `false` (default) for figures.
folderId | **string**<br><p>[ID of the folder](../../../resource-manager/operations/folder/get-id.md) you have access to. It is required for authentication with a user account (see [{#T}](../../concepts/auth.md)). Do not use this field if you make a request on behalf of a service account.</p> <p>The maximum string length is 50 characters.</p>

### Experimental additional recognition settings {#additional-settings}

For streaming recognition models, new recognition settings are supported. They are passed to a gRPC procedure via metadata.

Parameter | Description
----- | -----
`x-normalize-partials` | **boolean**<br>Flag allowing you to get intermediate recognition results (parts of recognized utterance) in a normalized format: numbers as digits, profanity filter enabled, etc.<br>Acceptable values:<ul><li>`true`: Return a normalized result.</li><li>`false` (default): Return an non-normalized result.

### Audio message {#audio-msg}

Parameter | Description
----- | -----
`audio_content` | Audio fragment represented as an array of bytes. The audio must match the format specified in the [message with recognition settings](#specification-msg).


### Message with recognition results {#response}

If speech fragment recognition is successful, you will receive a message containing a list of recognition results (`chunks[]`). Each result contains the following fields:

* `alternatives[]`: List of recognized text alternatives. Each alternative contains the following fields:
   * `text`: Recognized text.
   * `confidence`: This field is currently not supported. Do not use it.
* `final`: Flag indicating that this recognition result is final and will not change anymore. If the value is `false`, it means the recognition result is intermediate and may change as subsequent speech fragments get recognized.
* `endOfUtterance`: Flag indicating that this result contains the end of the utterance. If the value is `true`, the new utterance will start with the next result you get.

  {% note info %}

  If you set `singleUtterance=true`, only one utterance per session will be recognized. After the message where `endOfUtterance` is `true`, the server will not recognize the following utterances and will wait for you to terminate the session.

  {% endnote %}

### Error codes returned by the server {#error_codes}

To see how gRPC statuses correspond to HTTP codes, see [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto).

List of possible gRPC errors returned by the service:

Code | Status | Description
----- | ----- | -----
3 | `INVALID_ARGUMENT` | Incorrect request parameters specified. Detailed information is provided in the `details` field.
9 | `RESOURCE_EXHAUSTED` | Client exceeded a quota.
16 | `UNAUTHENTICATED` | The operation requires authentication. Check the IAM token and the folder ID that you provided.
13 | `INTERNAL` | Internal server error. This error means that the operation cannot be performed due to a server-side technical problem, e.g., due to insufficient computing resources.

## Use cases {#examples}

* [{#T}](streaming-examples.md).
