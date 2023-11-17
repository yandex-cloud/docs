---
title: "{{ vision-full-name }}. Questions and answers"
description: "How do I get the logs of my activity in {{ vision-full-name }}? Find the answer to this and other questions in this article."
---

# General questions about {{ vision-name }}

{% include [logs](../../_qa/logs.md) %}

#### Which permissions are missing if an access error occurs when accessing the image recognition service? {#qa-permission-denied}

{{ vision-name }} returns the "Permission denied" error if the subject sending the request has no relevant access rights. To fix this error, assign the subject the `editor` role or higher. For more information, see [{#T}](../security/index.md).

#### For which tasks can I use {{ vision-name }} in {{ yandex-cloud }}? {#qa-usecases}

You can use {{ vision-name }} to:
  * Recognize text
  * Detect faces in an image
  * Moderate images
  * Determine image quality
  * Encode files in Base64

For a detailed guide, see [{#T}](../operations/index.md).

#### Is {{ vision-name }} suitable for recognizing documents (passport or driver's license)? {#qa-docs}

Yes, it is. Supported templates are listed in the [Recognition models](../concepts/ocr/template-recognition.md#models) section. You can test other templates yourself.

#### Which languages does the `license-plates` recognition model support? {#qa-languages-license-plates}

The `license-plates` recognition model supports only Russian (`ru`) and English (`en`). You need to specify them explicitly in your request, in the `language_codes` parameter.

#### How do I recognize and present individual fields from a document rather than the whole text? {#qa-specific-detection}

For this, select the `line` model in the configuration: this model is better suited for recognizing individual lines. For a more detailed guide, see [{#T}](../operations/ocr/text-detection-single-line.md#vision-line-recognition).

#### Why are element coordinates determined incorrectly? {#coordinate-definition-issue}

Your image processor has incorrectly processed metadata from the `exif` section. For more information, see [Errors determining coordinates](../concepts/ocr/index.md#coordinate-definition-issue).

Do one of the following:

* Enable support for `exif` metadata in your image viewing tool.
* Remove the `Orientation` attribute from the image `exif` section during transfer to the service or set it to `0`.