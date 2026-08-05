---
title: STT integration step
description: This article describes the fields for the STT integration step.
---

# STT

Speech recognition in audio files using [{{ speechkit-full-name }} STT]({{ link-docs-ai }}speechkit/stt/).

The `base64`, `url`, `objectStorage`, and `disk` fields are mutually exclusive: you can use only one of them.

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`recognizeText` | [STT.RecognizeText](#STT-RecognizeText) | Yes | No | No | Speech recognition settings.
`base64` | `string` | No | No | Yes | Base64-encoded audio file.
`url` | `string` | No | No | Yes | Audio file via a public URL.
`objectStorage` | [STT.ObjectStorage](#STT-ObjectStorage) | No | No | No | Audio file from an {{ objstorage-name }} [bucket](../../../../../storage/concepts/bucket.md).
`disk` | [STT.Disk](#STT-Disk) | No | No | No | Audio file on Yandex Disk.

## STT.RecognizeText {#STT-RecognizeText}

#|
|| **Field name** | **Type** | **This is a required field** | **Default value** | **[Templating](../../templating.md) supported** | **Description** ||
|| `mimeType` | `string` | Yes | No | No | Audio file format. Available formats: `mp3`, `wav`, `ogg`. ||
|| `languageCodes` | `string[]` | Yes | No | No | Speech recognition languages.

{% cut "Available languages" %}

* `auto`: Automatic language detection
* `ru-RU`: Russian
* `en-US`: English
* `de-DE`: German
* `es-ES`: Spanish
* `fi-FI`: Finnish
* `fr-FR`: French
* `he-IL`: Hebrew
* `it-IT`: Italian
* `kk-KZ`: Kazakh
* `nl-NL`: Dutch
* `pl-PL`: Polish
* `pt-PT`: Portuguese
* `pt-BR`: Brazilian Portuguese
* `sv-SE`: Swedish
* `tr-TR`: Turkish
* `uz-UZ`: Uzbek (Latin script)

{% endcut %}

||
|| `model` | `string` | Yes | No | No | Speech recognition model. Available model: `general` (general recognition model). ||
|#

## STT.ObjectStorage {#STT-ObjectStorage}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`bucket` | `string` | Yes | No| No | Name of the {{ objstorage-name }} bucket the audio file is in.
`object` | `string` | Yes | No | Yes | Object name, e.g., `prefix/subprefix/data.mp3`.

## STT.Disk {#STT-Disk}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description |
--- | --- | --- | --- | --- | ---
`oauthToken` | `string` | Yes | No | No | [OAuth token]({{ link-yadisk-doc }}concepts/quickstart#oauth) for authentication when accessing Yandex Disk. |
`path` | `string` | Yes | No | Yes | Audio file path. |
`sharedDiskId` | `string` | No | No | Yes | Shared disk [label]({{ link-yadisk-doc }}reference/content_shd#query). |