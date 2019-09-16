# Optical character recognition (OCR)

This section describes how the _Optical Character Recognition (OCR)_ feature works in the service.

## Text recognition process

Text in an image is recognized in two stages:

1. [Detecting the language model for text recognition](#detect-model).
1. [Detecting text in the image](#detect-text).

As a result of recognition, the service returns a JSON object with the recognized text, its position on the page, and the [recognition confidence](#confidence) value.

### Language model detection {#detect-model}

The service provides text recognition based on a model that is trained on a specific set of languages. Some languages are very different from each other (like Arabic and Chinese), so they use [different models](supported-languages.md).

The model is selected automatically based on the list of languages specified in the `language_codes` property. If you don't know the text language, specify `"language_codes": ["*"]` to let the service choose the best-fitting model.

For each requested [feature](../index.md#features) (`feature`) only one model is used. For example, if the image contains text in Chinese and Japanese, only one language is recognized. To recognize languages from different models, specify several features in the request.

See the examples in the [{#T}](../../operations/ocr/text-detection.md) instructions.

{% note tip %}

If your text is in Russian and English, the [English-Russian model](supported-languages.md#engrus) works best. To use it, specify one or both of these languages, but don't specify other languages in the same configuration.

{% endnote %}

### Detecting text in images {#detect-text}

The service highlights the text characters found in the image and groups them by level: words are grouped into lines, the lines into blocks, and the blocks into pages.

![image](../../../_assets/vision/text-detection.jpg)

As a result, the service returns a JSON object, where additional information is provided for each of the levels:

* `pages[]` — Page size.
* `blocks[]` — Position of the text on the page.
* `lines[]` — Position and [recognition confidence](#confidence).
* `words[]` — Position, confidence, text, and language used for recognition.

To show the position of the text, the service returns the coordinates of the rectangle that frames the text. Coordinates are the number of pixels from the upper-left corner of the image.

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
      }
    ]
  },
  "languages": [{
    "languageCode": "en",
    "confidence": 0.9412244558
  }],
  "text": "you",
  "confidence": 0.9412244558
}
```

## Image requirements

An image in a request must meet the following requirements:

{% include [file-restrictions](../../../_includes/vision/file-restrictions.md) %}

## Recognition confidence {#confidence}

The recognition confidence shows the service's confidence in the result. For example, the value `"confidence": 0.9412244558` for the line <q>we like you</q> means that the text is recognized correctly with a probability of 94%.

Currently, the recognition confidence value is only calculated for lines. The `confidence` value for words and language is substituted with the line's `confidence` value.

#### What's next

* [View the list of supported languages and models](supported-languages.md)
* [View known restrictions for the current version](known-issues.md)
* [Try recognizing text in an image](../../operations/ocr/text-detection.md)

