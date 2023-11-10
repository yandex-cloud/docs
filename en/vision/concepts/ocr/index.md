---
description: "OCR stands for Optical Character Recognition. The service highlights text characters found in an image and groups them by level: words are grouped into lines, lines into blocks, and blocks into pages. The service provides text recognition based on a language model that is trained on a specific set of languages."
---

# Optical character recognition (OCR)

This section describes how the _Optical Character Recognition (OCR)_ feature works.

## Preparing the recognition request {#request}

In your request, you specify a list of [analysis features](../index.md#features) to apply to the image. To recognize a text, use the `TEXT_DETECTION` type and set the list of languages in the configuration.

### Request configuration {#config}

In the configuration, you need to specify:
* List of languages to use to [detect the language model](#detect-model) for recognition.

   If you do not know the text language, enter `*`; {{ vision-full-name }} will automatically select the most appropriate model.
* Model to use to detect text in the image. The available models include:
   * `page` (default): Suitable for images with any number of text lines.
   * `papers`: Suitable for recognizing multi-column text (only available in the {{ vision-short-name }} [OCR API](../../ocr/api-ref/index.md))

### Language model detection {#detect-model}

{{ vision-full-name }} provides text recognition based on a [language model](supported-languages.md) that is trained on a specific set of languages. The model is selected automatically based on the list of languages you specified in the configuration.

Only a single model is used each time you recognize a text. For example, if an image contains text in Chinese and Japanese, only one language will be recognized. To recognize both languages, specify multiple analysis options based on different language lists in your request.

{% note tip %}

If your text is in Russian and English, the [English-Russian model](supported-languages.md#engrus) works best. To use this model, specify one of these languages or both in `text_detection_config`, but do not specify any other languages.

{% endnote %}

### Image requirements {#image-requirements}

An image in a request must meet the following requirements:

{% list tabs %}

- {{ vision-short-name }} API

   {% include [file-restrictions](../../../_includes/vision/file-restrictions.md) %}

- OCR API

   {% include [file-restrictions](../../../_includes/vision/ocr-file-restrictions.md) %}

{% endlist %}

## Response with recognition results {#response}

The service highlights the text characters found in the image and groups them by level: words are grouped into lines, lines into blocks, and blocks into pages.

![image](../../../_assets/vision/text-detection.jpg)

As a result, {{ vision-full-name }} returns an object with the following properties:
* For `pages[]`: Page size.
* For `blocks[]`: Position of the text on the page.
* For `lines[]`: Position and [recognition accuracy](#confidence).
* For `words[]`: Position, accuracy, text, and language used for recognition.

To show the position of the text, {{ vision-full-name }} returns the coordinates of the rectangle that frames the text. Coordinates are the number of pixels from the top-left corner of the image.

{% include [coordinates](../../../_includes/vision/coordinates.md) %}

Example of a recognized word with coordinates:

```json
{
  "boundingBox": {
    "vertices": [{
      "x": "410",
      "y": "404"
    },
    {
      "x": "410",
      "y": "467"
    },
    {
      "x": "559",
      "y": "467"
    },
    {
      "x": "559",
      "y": "404"
    }]
  },
  "languages": [{
    "languageCode": "en",
    "confidence": 0.9412244558
  }],
  "text": "you",
  "confidence": 0.9412244558
}
```

### Errors in determining coordinates {#coordinate-definition-issue}

Coordinates returned by the service may in some cases mismatch the text displayed in the user's image processor. This is due to incorrect handling of `exif` metadata by the user's image processor.

During recognition, {{ vision-full-name }} considers data about image rotation set by the `Orientation` attribute in the `exif` section. Some tools used for viewing images may ignore the rotation values set in `exif`. This causes a mismatch between the obtained results and the displayed image.

To fix this error, do one of the following:

* Change the image processor settings so that the rotation angle specified in the `exif` section is considered while viewing images.
* Remove the `Orientation` attribute from the image `exif` section or set it to `0` when providing the image to {{ vision-full-name }}.

### Recognition accuracy {#confidence}

The recognition accuracy (`confidence`) means {{ vision-full-name }}'s result accuracy. For example, the value `"confidence": 0.9412244558` for the line <q>we like you</q> means that the text is recognized correctly with a probability of 94%.

Currently, the recognition accuracy value is only calculated for lines. You will also see it for words and languages, but it will be borrowed from the line's value.

#### What's next {#what-is-next}

* [View the list of supported languages and models](supported-languages.md)
* [Learn about known issues for the current version](known-issues.md)
* [Try recognizing text in an image](../../operations/ocr/text-detection-image.md)