---
title: Asynchronous LPCM audio file recognition in {{ speechkit-full-name }}
description: Follow this guide to use asynchronous LPCM audio file recognition.
---

# Asynchronous recognition of LPCM audio files using the API v2

Below is an example of [asynchronous recognition of speech](../transcribation.md) from an audio file using the {{ speechkit-name }} [API v2](transcribation-api.md). This example uses the following parameters:

* [Language](../models.md#languages): Russian.
* [Language model](../models.md#tags): `general`.
* Format of the submitted audio: [LPCM](../../formats.md#LPCM) with a sampling rate of 8000 Hz.
* [Number of audio channels](transcribation-api.md#sendfile-params): 1 (default).
* Other parameters left by default.

You can generate and send a speech recognition request using [cURL](https://curl.haxx.se).

An [IAM token](../../../iam/concepts/authorization/iam-token.md) is used to authenticate the service account. Learn more about [authentication in the {{speechkit-name}} API](../../concepts/auth.md).

## Getting started {#before-you-begin}

{% include [transcribation-before-you-begin](../../../_includes/speechkit/transcribation-before-you-begin.md) %}

If you do not have an LPCM audio file, you can download a [sample file](https://{{ s3-storage-host }}/speechkit/speech.pcm).

## Perform speech recognition via the API {#recognize-using-api}

{% list tabs group=programming_language %}

- cURL {#curl}

   {% include [async-recognition](../../../_includes/speechkit/async-recognition.md) %}

{% endlist %}

#### See also {#see-also}

* [{#T}](transcribation-api.md)
* [{#T}](transcribation-ogg.md)
* [{#T}](batch-transcribation.md)
* [{#T}](../../concepts/auth.md)
