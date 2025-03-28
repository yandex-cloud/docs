---
title: How to recognize long audio files in {{ speechkit-full-name }}
description: Follow this guide to recognize long audio files in {{ speechkit-name }}.
---

# How to recognize long audio files in {{ speechkit-name }}


The service can recognize speech [in different ways](../stt/index.md#stt-ways). The provided example demonstrates [asynchronous recognition](../stt/transcribation.md) of an audio file. Asynchronous recognition is available via API v3 and API v2. Asynchronous recognition is subject to these restrictions:

* Maximum audio duration: {{ stt-long-audioLength }}
* Maximum file size: {{ stt-long-fileSize }}

In the example, the API is used via the [cURL](https://curl.se/) utility. If you want to use the API via a Python script, see [the relevant tutorials](../tutorials/index.md#async-stt).

## Getting started {#before-you-begin}

1. [Create](../../storage/operations/buckets/create.md) a bucket and [upload](../../storage/operations/objects/upload.md) to it the audio file you want to recognize.
1. [Create](../../iam/operations/sa/create.md) a service account.

   {% note warning %}

   You can recognize audio files asynchronously only as a service account. Do not use any [other {{ yandex-cloud }} accounts](../../iam/concepts/users/accounts.md) for the purpose.

   {% endnote %}

1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) to the service account the `storage.uploader` and `ai.speechkit-stt.user` roles for the folder you had created the bucket in.
1. [Get an API key](../../iam/operations/authentication/manage-api-keys.md#create-api-key) or [IAM token](../../iam/operations/iam-token/create-for-sa.md) for your service account.
1. Download a sample audio file:

   * For API v3: a WAV file.
   * For API v2: an LPCM file.

## Speech recognition {#speech-recognition}

{% list tabs %}

- API v3

  {% include [async-recognition](../../_includes/speechkit/async-recognition-v3.md) %}

- API v2

  {% include [async-recognition](../../_includes/speechkit/async-recognition.md) %}

{% endlist %}

#### See also {#what-is-next}

* [{#T}](../stt/index.md)
* [API v3 for asynchronous recognition](../stt-v3/api-ref/AsyncRecognizer/getRecognition.md)
* [{#T}](../stt/api/transcribation-api.md)
* [{#T}](../concepts/auth.md)
* [{#T}](../stt/api/transcribation-api-v3.md)
* [{#T}](../stt/api/transcribation-ogg.md)
