# Speech recognition (STT)

#### Incorrect stress and pronunciation {#stt-stress-pronunciation}

Create a request and attach examples so that developers can make adjustments to the next releases of the speech synthesis model.


#### Poor speech recognition quality at 8kHz {#at-8khz}

If the issue is systematic (tens of percent of the total number of speech recognition requests), submit a request and attach examples for analysis. The more examples you send, the more likely the developers will discover the bug.


#### Feedback form on speech recognition quality {#feedback}



If you have any issues, please contact [support]({{ link-console-support }}) and provide files and a description.


#### Two channels were recognized as one / How to recognize each channel separately {#two-channels}

You can recognize multi-channel audio files only using [asynchronous recognition](../../{{ speechkit-slug }}/stt/transcribation.md).

Check the format of your recording:

* For LPCM, use the [config.specification.audioChannelCount](../../{{ speechkit-slug }}/stt/api/transcribation-api.md#sendfile-params) parameter set to 2.
* Do not specify this parameter for MP3 and OggOpus, since the number of channels is already stated in the file. The file will be automatically split into the appropriate number of recordings.

The recognized text in the response is separated by the [channelTag](../../{{ speechkit-slug }}/stt/api/transcribation-api.md#get-result-response) parameter.

#### Is it possible to recognize two or more voices separated by speaker? {#separate-speaker}

You can recognize multi-channel audio files only using [asynchronous recognition](../../{{ speechkit-slug }}/stt/transcribation.md).

During speech recognition, text is not split by voice, but you can place the voices in different channels and separate the recognized text in the response with the [channelTag](../../{{ speechkit-slug }}/stt/api/transcribation-api.md#get-result-response) parameter.

You can specify the number of channels in a request using the [config.specification.audioChannelCount](../../{{ speechkit-slug }}/stt/api/transcribation-api.md#sendfile-params) parameter.

#### Incomplete audio recognition {#incomplete}

If you recognize streaming audio, try using different API versions: [API v1](../../{{ speechkit-slug }}/stt/api/streaming-api.md) or [API v3](../../{{ speechkit-slug }}/stt-v3/api-ref/grpc/).

To recognize an audio file, try different [models](../../{{ speechkit-slug }}/stt/models.md).


#### The file doesn't exceed the limit, but an error occurs during recognition {#multi-channel-limits}

If the file is multi-channel, take into account the total recording time of all channels. For the full list of limitations, see [Quotas and limits in {{ speechkit-short-name }}](../../{{ speechkit-slug }}/concepts/limits.md#speechkit-limits).

#### Internal Server Error {#internal-server-err}

Make sure the [format](../../{{ speechkit-slug }}/stt/api/request-api.md#body_params) you specified in the request matches the actual file format. If the error persists, send us examples of your audio files that cannot be recognized.

#### When is a response sent during recognition? {#when-response}

Under synchronous and asynchronous recognition, a response is sent once: after processing the request.

In streaming recognition mode, you can configure the server behavior. By default, the server returns a response only after the received utterance is fully recognized. You can use the [partialResults](../../{{ speechkit-slug }}/stt/api/streaming-api.md#specification-msg) parameter to set up recognition so that the server also returns intermediate recognition results.

Intermediate results allow you to quickly respond to the recognized speech without waiting for the end of the utterance.

#### Where can I find an example of audio file recognition? {#audiofile}

For {{ speechkit-name }} usage examples, see [Tutorials](../../{{ speechkit-slug }}/tutorials/index.md). To recognize pre-recorded audio files, use [asynchronous recognition](../../speechkit/stt/transcribation.md).

#### Where can I find an example of microphone speech recognition? {#microphone}

[Example of streaming recognition of microphone-recorded speech](../../{{ speechkit-slug }}/stt/api/microphone-streaming.md).

#### Can I use POST for streaming recognition? {#post}

Streaming recognition uses gRPC and is not supported by the REST API, so you cannot use the POST method.

#### A streaming recognition session is broken/terminated {#broken-session}

When using the [API v2](../../{{ speechkit-slug }}/stt/streaming.md#session-restrictions) for streaming recognition, the service awaits audio data. If it does not receive any data within 5 seconds, the session terminates. You cannot change this parameter in the API v2.

Streaming recognition runs in real time. You can send "silence" for recognition so that the service does not terminate the connection.

We recommend using the [API v3](../../) for streaming recognition. The API v3 features a [special message type](../../speechkit/stt-v3/api-ref/grpc/Recognizer/recognizeStreaming.md#speechkit.stt.v3.SilenceChunk) for sending "silence", so you will not have to simulate it yourself in your audio recording.

#### How does the service figure out the end of an utterance and the duration of a recognition session? {#utterance-end}

The end of an utterance is determined automatically by the "silence" after the utterance. For more information about end-of-utterance detection, see [{#T}](../../speechkit/stt/eou.md).

The [maximum session duration](../../{{ speechkit-slug }}/stt/streaming.md#session-restrictions) for streaming recognition is {{ stt-streaming-audioLength }}.

#### What should I do if {{ speechkit-name }} does not listen to a conversation to the end or, conversely, it takes too long to wait until it ends? {#eou-tune}

Interruptions or delays during [streaming recognition](../../{{ speechkit-slug }}/stt/streaming.md) may occur due to detecting the end of utterance (EOU). For EOU setup recommendations, see [{#T}](../../{{ speechkit-slug }}/stt/eou.md).

#### Error: OutOfRange desc = Exceeded maximum allowed stream duration {#duration-exceeded}

This error means that the maximum allowed duration of a recognition session has been exceeded. In this case, you need to reopen the session.

For streaming recognition, the [maximum session duration](../../{{ speechkit-slug }}/concepts/limits.md#speechkit-limits) is {{ stt-streaming-audioLength }}. This is a technical limitation due to the {{ yandex-cloud }} architecture and it cannot be changed.

#### What goes into the usage cost? {#stt-cost}

For usage cost calculation examples, pricing rules, and effective prices, see [{#T}](../../{{ speechkit-slug }}/pricing.md).
