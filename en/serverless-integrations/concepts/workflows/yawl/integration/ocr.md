---
title: OCR integration step
description: This article describes the fields for the OCR integration step.
---

# OCR

Image-to-text recognition with [{{ vision-full-name }}]({{ link-docs-ai }}vision/concepts/ocr/).

The `base64`, `url`, `objectStorage`, and `disk` fields are mutually exclusive: you can use only one of them.

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`recognizeText` | [OCR.RecognizeText](#OCR-RecognizeText) | Yes | No | No | Text recognition settings.
`base64` | `string` | No | No | Yes | Base64-encoded image.
`url` | `string` | No | No | Yes | Image via a public URL.
`objectStorage` | [OCR.ObjectStorage](#OCR-ObjectStorage) | No | No | No | Image from an {{ objstorage-name }} [bucket](../../../../../storage/concepts/bucket.md).
`disk` | [OCR.Disk](#OCR-Disk) | No | No | No | Image on Yandex Disk.

## OCR.RecognizeText {#OCR-RecognizeText}

#|
|| **Field name** | **Type** | **This is a required field** | **Default value** | **[Templating](../../templating.md) supported** | **Description** ||
|| `mimeType` | `string` | Yes | No | No | Image file format. Available formats: `pdf`, `jpeg`, `png`. ||
|| `languageCodes` | `string[]` | Yes | No | No | Text recognition languages.

{% cut "Available languages" %}

* `ru`: Russian
* `en`: English
* `ar`: Arabic
* `az`: Azerbaijani
* `ba`: Bashkir
* `be`: Belarusian
* `bg`: Bulgarian
* `bs`: Bosnian
* `cs`: Czech
* `da`: Danish
* `de`: German
* `el`: Greek
* `es`: Spanish
* `et`: Estonian
* `fi`: Finnish
* `fr`: French
* `he`: Hebrew
* `hu`: Hungarian
* `hy`: Armenian
* `id`: Indonesian
* `it`: Italian
* `ja`: Japanese
* `ka`: Georgian
* `kk`: Kazakh
* `ko`: Korean
* `ky`: Kirghiz
* `lt`: Lithuanian
* `lv`: Latvian
* `mt`: Maltese
* `nl`: Dutch
* `no`: Norwegian
* `pl`: Polish
* `pt`: Portuguese
* `ro`: Romanian
* `sk`: Slovak
* `sl`: Slovenian
* `sv`: Swedish
* `tg`: Tajik
* `th`: Thai
* `tr`: Turkish
* `tt`: Tatar
* `uk`: Ukrainian
* `uz`: Uzbek
* `vi`: Vietnamese
* `zh`: Chinese

{% endcut %}

||
|| `model` | `string` | Yes | No | No | Text recognition model.

{% cut "Available models" %}

* `page`: Text recognition on page.
* `page-column-sort`: Column-sorted text recognition.
* `passport`: Russian Federation passport.
* `driver-license-front`: Driver's license, front side.
* `driver-license-back`: Driver's license, back side.
* `license-plates`: Car license plates.
* `vehicle-registration-front`: Vehicle registration certificate (VRC), front side.
* `vehicle-registration-back`: Vehicle registration certificate (VRC), back side.
* `handwritten`: Handwritten text.
* `table`: Table.
* `markdown`: Markdown markup.
* `math-markdown`: Markdown markup with formulas.

{% endcut %}

||
|#

## OCR.ObjectStorage {#OCR-ObjectStorage}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`bucket` | `string` | Yes | No| No | Name of the {{ objstorage-name }} bucket the image file is in.
`object` | `string` | Yes | No | Yes | Object name, e.g., `prefix/subprefix/data.png`.

## OCR.Disk {#OCR-Disk}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description |
--- | --- | --- | --- | --- | ---
`oauthToken` | `string` | Yes | No | No | [OAuth token]({{ link-yadisk-doc }}concepts/quickstart#oauth) for authentication when accessing Yandex Disk. |
`path` | `string` | Yes | No | Yes | Image file path. |
`sharedDiskId` | `string` | No | No | Yes | Shared disk [label]({{ link-yadisk-doc }}reference/content_shd#query). |