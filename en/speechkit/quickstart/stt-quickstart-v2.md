# How to recognize long audio files in {{ speechkit-name }}

The service can recognize speech [in different ways](../stt/index.md#stt-ways). The example below demonstrates [asynchronous recognition](../stt/transcribation.md) of an audio file. The following limits apply:

* Maximum audio duration: {{ stt-long-audioLength }}
* Maximum file size: {{ stt-long-fileSize }}

For asynchronous recognition, two API versions are supported: v3 and v2. Learn how to perform speech recognition using both API versions.

In the example below, the API is used via the [cURL](https://curl.se/) utility. If you want to use the API via a Python script, see [the relevant tutorials](../tutorials/index.md#async-stt).

## Getting started {#before-you-begin}

1. [Create](../../storage/operations/buckets/create.md) a bucket and [upload](../../storage/operations/objects/upload.md) to it the audio file you want to recognize.
1. [Create](../../iam/operations/sa/create.md) a service account.

   {% note warning %}

   You can recognize audio files asynchronously only as a service account. Do not use any [other {{ yandex-cloud }} accounts](../../iam/concepts/users/accounts.md) for the purpose.

   {% endnote %}

1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) to the service account the `storage.uploader` and `ai.speechkit-stt.user` roles for the folder you had created the bucket in.
1. [Get an API key](../../iam/operations/api-key/create.md) for the service account you created.
1. Download a sample audio file:

   * For API v3: a WAV file.
   * For API v2: an LPCM file.

## Speech recognition {#speech-recognition}

{% include [async-recognition](../../_includes/speechkit/async-recognition.md) %}

#### See also {#what-is-next}

* [{#T}](../stt/index.md)
* [API v3 for asynchronous recognition](../stt-v3/api-ref/AsyncRecognizer/getRecognition.md)
* [{#T}](../stt/api/transcribation-api.md)
* [{#T}](../concepts/auth.md)
* [{#T}](../stt/api/transcribation-api-v3.md)
* [{#T}](../stt/api/transcribation-ogg.md)
