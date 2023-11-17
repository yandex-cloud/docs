# Asynchronous recognition

Asynchronous recognition helps convert multi-channel audio files with the following properties into text:
* Maximum recording duration: {{ stt-long-audioLength }}
* Maximum file size: {{ stt-long-fileSize }}

Recognition results are saved on the {{ stt-long-resultsStorageTime }} server, after which you cannot get them.

Asynchronous recognition cannot be used for real-time dialog recognition. If you need intermediate results and minimum response time, use [streaming recognition](streaming.md).

View the list of supported languages in [{#T}](models.md#languages).

## Asynchronous recognition modes {#modes}

{% include [async-stt-modes](../../_includes/speechkit/async-modes.md) %}

## How long audio fragments are recognized {#long-audio-recognition}

The {{ speechkit-name }} API v2 is used for asynchronous speech recognition. To recognize long audio fragments, execute two requests:

1. Send a file for recognition.
1. Get recognition results.

Requests should be made under a [service account](../../iam/concepts/users/service-accounts.md) with the following folder roles assigned:

* `{{ roles-speechkit-stt }}` for speech recognition.
* `storage.uploader` for uploading audio files to a [{{ objstorage-full-name }} bucket](../../storage/concepts/bucket.md).
* `storage.configurer`, `kms.keys.encrypter`, and `kms.keys.decrypter` for bucket object encryption and decryption. These roles are only required if you use [encryption in {{ objstorage-name }}](../../storage/concepts/encryption.md).

For authorization, provide an [IAM token](../../iam/concepts/authorization/iam-token.md) or [API key](../../iam/concepts/authorization/api-key.md) for your service account in request HTTP headers:

* IAM token: `Authorization: Bearer <IAM token>`
* API key: `Authorization: Api-Key <API key>`

An audio file to recognize is [uploaded](../../storage/operations/objects/upload.md) to an {{ objstorage-name }} bucket. To provide this file, use a [file link](../../storage/operations/objects/link-for-download.md) in the request body. The link contains additional query parameters (after `?`) for buckets with restricted access. You do not need to provide these parameters in {{ speechkit-name }} as they are ignored.

After the [speech recognition request](api/transcribation-api.md#sendfile) is sent, the service returns a response with the recognition operation ID. It is used in a [request for recognition results](api/transcribation-api.md#get-result).

{% note warning %}

The recognition results are stored on the {{ stt-long-resultsStorageTime }} server. You can then request the recognition results using the obtained ID.

{% endnote %}

The results contain the entire recognized text and a list of recognized words.


#### See also {#see-also}

To learn how to use the asynchronous speech recognition API, see these sections:

* [{#T}](api/transcribation-api.md).
* [{#T}](api/transcribation-lpcm.md).
* [{#T}](api/transcribation-ogg.md).
* [{#T}](api/batch-transcribation.md).

