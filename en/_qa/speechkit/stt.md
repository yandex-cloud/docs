# Speech recognition (STT)

#### Incorrect stress and pronunciation {#stt-stress-pronunciation}

Create a request and attach examples so that developers can make adjustments to the next releases of the speech synthesis model.


#### Poor speech recognition quality at 8kHz {#at-8khz}

If the issue is systematic (tens of percent of the total number of speech recognition requests), submit a request and attach examples for analysis. The more examples you send, the more likely the developers will discover the bug.


#### Feedback form on speech recognition quality {#feedback}



If you have any issues, please contact [support]({{ link-console-support }}) and provide files and a description.


#### Noises, beeps, silence is reproduced as a strange speech {#strange-speech}

Try using a [different recognition model](../../{{ speechkit-slug }}/stt/models.md#tags), such as `general:rc`. For streaming recognition, there is a [setting](../../{{ speechkit-slug }}/stt/api/streaming-api.md#additional-settings) that reduces the sensitivity of background noise recognition.


#### Two channels were recognized as one / How to recognize each channel separately {#two-channels}

Check the format of your recording.

For LPCM, use the [config.specification.audioChannelCount](../../{{ speechkit-slug }}/stt/api/transcribation-api.md#sendfile-params) parameter equal to 2.

You don't need to specify the parameter for OggOpus, since the file contains information about the number of channels. The file will be automatically split into two recordings.

The recognized text in the response is separated by the [channelTag](../../{{ speechkit-slug }}/stt/api/transcribation-api.md#get-result-response) parameter.

#### Is it possible to recognize 2 or more voices separated by speaker? {#separate-speaker}

During speech recognition, text is not split by voice, but you can place the voices in different channels and separate the recognized text in the response with the [channelTag](../../{{ speechkit-slug }}/stt/api/transcribation-api.md#get-result-response) parameter.

The number of channels can be specified in a request using the [config.specification.audioChannelCount](../../{{ speechkit-slug }}/stt/api/transcribation-api.md#sendfile-params) parameter.

#### Incomplete audio recognition {#incomplete}

If you recognize streaming audio, try using different API versions: [API v1](../../{{ speechkit-slug }}/stt/api/streaming-api.md) or [API v3](../../{{ speechkit-slug }}/stt-v3/api-ref/grpc/).

To recognize an audio file, try different [models](../../{{ speechkit-slug }}/stt/models.md).


#### The file doesn't exceed the limit, but an error occurs during recognition {#multi-channel-limits}

If the file is multi-channel, take into account the total recording time of all channels. For more information, see the [Quotas and limits in {{ speechkit-short-name }}](../../{{ speechkit-slug }}/concepts/limits.md#speechkit-limits) section in the documentation.

#### Internal Server Error {#internal-server-err}

Make sure the [format](../../{{ speechkit-slug }}/stt/api/request-api.md#body_params) you specified in the request matches the actual file format. If the error persists, send us sample audio files that can't be recognized.

#### When is a response sent during recognition? {#when-response}

Under synchronous and asynchronous recognition, a response is sent once: after processing the request.

In streaming recognition mode, you can configure the server behavior. By default, the server returns a response only after the received utterance is fully recognized. You can use the [partialResults](../../{{ speechkit-slug }}/stt/api/streaming-api.md#specification-msg) parameter to set up recognition so that the server also returns intermediate recognition results.

Intermediate results allow you to quickly respond to the recognized speech without waiting for the end of the utterance.

#### Where can I find an example of audio file recognition? {#audiofile}

You can find examples of asynchronous recognition of [LPCM](../../{{ speechkit-slug }}/stt/api/transcribation-lpcm.md) and [OggOpus](../../{{ speechkit-slug }}/stt/api/transcribation-ogg.md) files in the [Tutorials](../../{{ speechkit-slug }}/tutorials/index.md) section.

#### Where can I find an example of microphone speech recognition? {#microphone}

[Example of streaming recognition of microphone-recorded speech](../../{{ speechkit-slug }}/stt/api/microphone-streaming.md).

#### Can I use POST for streaming recognition? {#post}

Streaming recognition only works through the gRPC API, you can't use POST.

When using the [header](../../{{ speechkit-slug }}/stt/api/request-api.md#http_request) `Transfer-Encoding: chunked` during synchronous recognition, you can send an audio stream without closing the current connection.

#### A streaming recognition session is broken/terminated {#broken-session}

If the [streaming recognition](../../{{ speechkit-slug }}/stt/streaming.md#session-restrictions) service doesn't receive data to recognize within 5 seconds, a session is aborted. You cannot change this parameter.

Streaming recognition runs in real time. You can send "silence" for recognition so that the service doesn't terminate the connection.

#### How are the end of an utterance and the recognition session duration determined? {#utterance-end}

The end of an utterance is determined automatically by the "silence" after the utterance.

[The maximum duration of a session](../../{{ speechkit-slug }}/stt/streaming.md#session-restrictions) is 5 minutes.

#### What should I do if {{ speechkit-name }} does not listen to a conversation to the end or, conversely, it takes too long to wait until it ends? {#eou-tune}

Interruptions or delays during [streaming recognition](../../{{ speechkit-slug }}/stt/streaming.md) may occur due to detecting the end of utterance (EOU). For EOU setup recommendations, see [{#T}](../../{{ speechkit-slug }}/stt/eou.md).

#### Error: OutOfRange desc = Exceeded maximum allowed stream duration {#duration-exceeded}

This error means that the maximum allowed duration of a recognition session has been exceeded.

For streaming recognition, [the maximum session duration](../../{{ speechkit-slug }}/concepts/limits.md#speechkit-limits) is 5 minutes.

This is a technical limitation due to the {{ yandex-cloud }} architecture and it cannot be changed.

#### What goes into the cost of using the service? {#stt-cost}

You can find examples of calculating the usage cost, pricing rules, and effective prices in the [documentation](../../{{ speechkit-slug }}/pricing.md).
