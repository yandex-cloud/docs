# Getting started with {{ vision-short-name }}

This section describes how to get started with the {{ vision-short-name }} API for image analysis.

## Getting started {#before-you-begin}

{% include [curl](../_includes/curl.md) %}

{% include [ai-before-beginning](../_includes/vision/ai-before-beginning.md) %}

## Analyze the image {#analyze-image}

You can use any of the analysis features from the [list](concepts/index.md#features). For example, use the [Text recognition](concepts/ocr/index.md) feature:

1. Prepare an image file that meets the requirements:

    * Supported file formats: JPEG, PNG, PDF.
    * Maximum file size: 1 MB.
    * Image size should not exceed 20 MP (height x width).

    {% note info %}

    Need a sample image? Download an image of the [penguin crossing](https://{{ s3-storage-host }}/vision/penguins_sample.jpg) road sign.

    {% endnote %}

{% include [text-detection-steps](../_includes/vision/text-detection-steps.md) %}

{% include [coordinate-definition-issue-note](../_includes/vision/coordinate-definition-issue-note.md) %}

#### What's next {#what-is-next}

* [Find out about all the service features](concepts/index.md)
* [Learn about API authentication methods](api-ref/authentication.md)
* [Detect faces in a photo](operations/face-detection/index.md)
* [Assess the quality of an image](operations/classification/quality.md)
* [Moderate images](operations/classification/moderation.md)
