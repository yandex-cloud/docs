---
title: Asynchronous recognition with {{ speechkit-full-name }}
description: Asynchronous recognition helps convert multi-channel audio files into text. Recognition results are saved on the {{ stt-long-resultsStorageTime }} server, after which you cannot get them.
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

The {{ speechkit-name }} API v2 and v3 are used for asynchronous speech recognition. To recognize pre-recorded audio:

1. [Create a service account](../../iam/operations/sa/create.md).
1. [Assign the following roles to it](../../iam/operations/sa/assign-role-for-sa.md):

   * `{{ roles-speechkit-stt }}` for speech recognition.
   * `storage.uploader` for uploading audio files to an [{{ objstorage-full-name }} bucket](../../storage/concepts/bucket.md).
   * (Optional) `storage.configurer`, `kms.keys.encrypter`, and `kms.keys.decrypter` for bucket object encryption and decryption. These roles are only required if you use [encryption in {{ objstorage-name }}](../../storage/concepts/encryption.md).

1. Obtain an [IAM token](../../iam/operations/iam-token/create-for-sa.md) or an [API key](../../iam/operations/api-key/create.md) for your service account. You will use them to authenticate to the API.
1. [Create an {{ objstorage-full-name }} bucket](../../storage/operations/buckets/create.md).
1. [Upload an audio file to the bucket](../../storage/operations/objects/upload.md).
1. [Get a link](../../storage/operations/objects/link-for-download.md) to the uploaded file.

   The link contains additional query parameters (after `?`) for buckets with restricted access. You do not need to provide these parameters in {{ speechkit-name }} as they are ignored.

1. Send an API request to recognize a file via the [gRPC API](../stt-v3/api-ref/grpc/AsyncRecognizer) or [REST API](../stt-v3/api-ref/AsyncRecognizer/index.md). In the body of the request, provide the link to the audio file. In the HTTP header, specify your authentication credentials:

   * `Authorization: Bearer <IAM_token>`: IAM token used for authentication.
   * `Authorization: Api-Key <API_key>`: For authentication with the API key.

   The response to the request returns the ID of the recognition operation. Save it: you will need it for the next request.

   {% note warning %}

   The recognition results are stored on the {{ stt-long-resultsStorageTime }} server. You can then request the recognition results using the obtained ID.

   {% endnote %}

1. Wait for the recognition to complete. It takes about 10 seconds to recognize one minute of single-channel audio.
1. Send an API request to get the recognition results:
   * Using the [API v2](api/transcribation-api.md#get-result)
   * Using the [API v3](../stt-v3/api-ref/AsyncRecognizer/getRecognition.md):
       * [REST](../stt-v3/api-ref/AsyncRecognizer/getRecognition.md)
       * [gRPC](../stt-v3/api-ref/grpc/AsyncRecognizer/getRecognition.md)

   Specify the same authentication credentials in the HTTP header.

   The results contain the entire recognized text and a list of recognized words.


## Examples of using the asynchronous recognition API {#examples}

* [{#T}](api/transcribation-lpcm.md).
* [{#T}](api/transcribation-ogg.md).
* [{#T}](api/transcribation-api-v3.md).
* [{#T}](api/batch-transcribation.md).

