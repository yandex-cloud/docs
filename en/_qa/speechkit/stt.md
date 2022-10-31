# Speech recognition (STT)

#### Incorrect stress and pronunciation {#stt-stress-pronunciation}

Create a request and attach examples so that developers can make adjustments to the next releases of the speech synthesis model.

{% if audience == "internal" %}

We also recommend sending your examples via the **Feedback form**. You can find it in the management console under **AI API** → **{{ speechkit-short-name }}** → **Recognition Benchmark**.

{% endif %}

#### Poor speech recognition quality at 8kHz {#at-8khz}

If the issue is systematic (tens of percent of the total number of speech recognition requests), submit a request and attach examples for analysis. The more examples you send, the more likely the developers will discover the bug.

{% if audience == "internal" %}

We recommend sending your examples via the **Feedback form**. You can find it in the management console under **AI API** → **{{ speechkit-short-name }}** → **Recognition Benchmark**.

{% endif %}

#### Feedback form on speech recognition quality {#feedback}

{% if audience == "internal" %}

You can find the **Feedback form** in the management console under **AI API** → **{{ speechkit-short-name }}** → **Recognition Benchmark**.

Direct link, substitute the folder_id if possible: {% if lang == "ru" %}https://console.cloud.yandex.ru/folders/<folder_id>/api/speechkit?section=recognition-benchmark{% endif %}{% if lang == "en" %}https://console.cloud.yandex.com/folders/<folder_id>/api/speechkit?section=recognition-benchmark{% endif %}

{% endif %}

#### Noises, beeps, silence is reproduced as a strange speech {#strange-speech}

Try using [a different recognition model](../../speechkit/stt/models.md#tags), such as `general:rc`. For streaming recognition, there is a [setting](../../speechkit/stt/api/streaming-api.md#additional-settings) that reduces the sensitivity of background noise recognition.

{% if audience == "internal" %}

We also recommend sending your examples via the **Feedback form**. You can find it in the management console under **AI API** → **{{ speechkit-short-name }}** → **Recognition Benchmark**.

{% endif %}

#### Two channels were recognized as one / How to recognize each channel separately {#two-channels}

Check the format of your recording.

For LPCM, use the [config.specification.audioChannelCount](../../speechkit/stt/api/transcribation-api.md#sendfile-params) parameter equal to 2.

You don't need to specify the parameter for OggOpus, since the file contains information about the number of channels. The file will be automatically split into two records.

The recognized text in the response is separated by the [channelTag](../../speechkit/stt/api/transcribation-api.md#get-result-response) parameter.

#### Is it possible to recognize 2 or more voices separated by speaker? {#separate-speaker}

During speech recognition, text is not split by voice, but you can place the voices in different channels and separate the recognized text in the response with the [channelTag](../../speechkit/stt/api/transcribation-api.md#get-result-response) parameter.

The number of channels can be specified in a request using the [config.specification.audioChannelCount](../../speechkit/stt/api/transcribation-api.md#sendfile-params) parameter.

#### Incomplete audio recognition {#incomplete}

If you recognize streaming audio, try using different API versions: [API v1](../../speechkit/stt/api/streaming-api.md) or [API v3](../../speechkit/stt-v3/api-ref/grpc/).

To recognize an audio file, try different [models](../../speechkit/stt/models.md).

{% if audience == "internal" %}

We also recommend sending your examples via the **Feedback form**. You can find it in the management console under **AI API** → **{{ speechkit-short-name }}** → **Recognition Benchmark**.

{% endif %}

#### The file doesn't exceed the limit, but an error occurs during recognition {#multi-channel-limits}

If the file is multi-channel, take into account the total recording time of all channels. For more information, see the [Quotas and limits in {{ speechkit-short-name }}](../../speechkit/concepts/limits.md#speechkit-limits) section in the documentation.

#### Internal Server Error {#internal-server-err}

Make sure the [format](../../speechkit/stt/api/request-api.md#body_params) specified in the request matches the actual file format. If the error persists, send us sample audio files that can't be recognized.

#### When is a response sent during recognition? {#when-response}

Under synchronous and asynchronous recognition, a response is sent once: after processing the request.

In streaming recognition mode, you can configure the server behavior. By default, the server returns a response only after the received utterance is fully recognized. You can use the [partialResults](../../speechkit/stt/api/streaming-api.md#specification-msg) parameter to set up recognition so that the server also returns intermediate recognition results.

Intermediate results let you quickly respond to the recognized speech without waiting for the end of the utterance.

#### Sample script for recognizing audio files {#script}

You can find examples of asynchronous recognition of [LPCM](../../speechkit/stt/api/transcribation-lpcm.md) and [OggOpus](../../speechkit/stt/api/transcribation-ogg.md) files in the documentation.

#### Can I use POST for streaming recognition? {#post}

Streaming recognition only works through the gRPC API, you can't use POST.

When using the [header](../../speechkit/stt/api/request-api.md#http_request) `Transfer-Encoding: chunked` during synchronous recognition, you can send an audio stream without closing the current connection.

#### A streaming recognition session is broken/terminated {#broken-session}

If the [streaming recognition](../../speechkit/stt/streaming.md#session-restrictions) service doesn't receive data to recognize within 5 seconds, a session is aborted. You can't change this parameter.

Streaming recognition runs in real time. You can send «silence» for recognition so that the service doesn't terminate the connection.

#### How are the end of an utterance and the recognition session duration determined {#utterance-end}

The end of an utterance is determined automatically by the «silence» after the utterance.

[The maximum duration of a session](../../speechkit/stt/streaming.md#session-restrictions) is 5 minutes.

#### Error: OutOfRange desc = Exceeded maximum allowed stream duration {#duration-exceeded}

This error means that the maximum allowed duration of a recognition session has been exceeded.

For streaming recognition, [the maximum session duration](../../speechkit/concepts/limits.md#speechkit-limits) is 5 minutes.

This is a technical limitation due to the {{ yandex-cloud }} architecture and it cannot be changed.

#### What goes into the cost of using the service? {#stt-cost}

You can find examples of calculating the usage cost, pricing rules, and effective prices in the [documentation](../../speechkit/pricing.md).
