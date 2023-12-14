---
title: "Asynchronous recognition in {{ speechkit-full-name }}"
description: "Asynchronous recognition helps convert multi-channel audio files into text. Recognition results are saved on the {{ stt-long-resultsStorageTime }} server, after which you cannot get them."
---

# Asynchronous recognition

Asynchronous recognition helps convert multi-channel audio files with the following properties into text:
* Maximum recording duration: {{ stt-long-audioLength }}
* Maximum file size: {{ stt-long-fileSize }}

Recognition results are saved on the {{ stt-long-resultsStorageTime }} server, after which you cannot get them.

Asynchronous recognition cannot be used for real-time dialog recognition. If you need intermediate results and minimum response time, use [streaming recognition](streaming.md).

View the list of supported languages in [{#T}](models.md#languages).

## Asynchronous recognition modes {#modes}

{% include [async-stt-modes](../../_includes/speechkit/async-modes.md) %}

## How to asynchronously recognize pre-recorded audio {#async-recognition}

The {{ speechkit-name }} API v2 is used for asynchronous speech recognition. To recognize pre-recorded audio:

1. [Create a service account](../../iam/operations/sa/create.md).
1. [Assign it the following roles](../../iam/operations/sa/assign-role-for-sa.md):

   * `{{ roles-speechkit-stt }}` for speech recognition.
   * `storage.uploader` for uploading audio files to a [{{ objstorage-full-name }} bucket](../../storage/concepts/bucket.md).
   * `storage.configurer`, `kms.keys.encrypter`, and `kms.keys.decrypter` for bucket object encryption and decryption. These roles are only required if you use [encryption in {{ objstorage-name }}](../../storage/concepts/encryption.md).

1. Get an [IAM token](../../iam/operations/iam-token/create-for-sa.md) or [API key](../../iam/operations/api-key/create.md) for your service account. You will need them for authorization in the API.
1. [Create a {{ objstorage-full-name }} bucket](../../storage/operations/buckets/create.md).
1. [Upload an audio file to the bucket](../../storage/operations/objects/upload.md).
1. [Get a link](../../storage/operations/objects/link-for-download.md) to the uploaded file.

 The link contains additional query parameters (after `?`) for buckets with restricted access. You do not need to provide these parameters in {{ speechkit-name }} as they are ignored.

1. [Send an API request to recognize the file](api/transcribation-api.md#sendfile). In the body of the request, provide the link to the audio file. In the HTTP header, specify the authorization data:

   * `Authorization: Bearer <IAM_token>`: For authorization using an IAM token.
   * `Authorization: Api-Key <API_key>`: For authorization using an API key.

   The response to the request returns the ID of the recognition operation. Save it: you will need it for the next request.

   {% note warning %}

   The recognition results are stored on the {{ stt-long-resultsStorageTime }} server. You can then request the recognition results using the obtained ID.

   {% endnote %}

1. Wait for the recognition to complete. It takes about 10 seconds to recognize one minute of a single-channel audio file.
1. [Send an API request to get the recognition results](api/transcribation-api.md#get-result). In the HTTP header, specify the same authorization data.

   The results contain the entire recognized text and a list of recognized words.


## Examples of using the asynchronous recognition API {#examples}

* [{#T}](api/transcribation-lpcm.md).
* [{#T}](api/transcribation-ogg.md).
* [{#T}](api/batch-transcribation.md).

