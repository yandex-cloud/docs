# How to recognize long audio files in {{ speechkit-name }}

The service can recognize speech [in different ways](../stt/index.md#stt-ways). The example below demonstrates how to transcribe an audio file using the [asynchronous recognition](../stt/transcribation.md) API v2. This API has the following limitations:

* Maximum audio duration: {{ stt-long-audioLength }}
* Maximum file size: {{ stt-long-fileSize }}

You can also use the API v3 for asynchronous recognition. To learn more about using the API v3, see [this guide](../stt/api/transcribation-api-v3.md).

## Getting started {#before-you-begin}

{% include [transcribation-before-you-begin](../../_includes/speechkit/transcribation-before-you-begin.md) %}

If you do not have an LPCM audio file, you can download a [sample file](https://{{ s3-storage-host }}/speechkit/speech.pcm).

## Speech recognition {#speech-recognition}

{% list tabs group=programming_language %}

- cURL {#curl}

   {% include [async-recognition](../../_includes/speechkit/async-recognition.md) %}

{% endlist %}

#### See also {#what-is-next}

* [{#T}](../stt/index.md)
* [{#T}](../stt/api/transcribation-api.md)
* [{#T}](../concepts/auth.md)
* [{#T}](../stt/api/transcribation-ogg.md)
