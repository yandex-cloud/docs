# About {{ vision-full-name }}

{{ vision-full-name }} is a computer vision service that analyzes a transmitted image and returns the result.

## Analysis features {#features}

_Features_ are various types of analysis {{ vision-full-name }} provides, such as:
* [Text recognition](ocr/index.md)
* [Face detection](face-detection/index.md)
* [Image classification](classification/index.md)

## Request body format {#format-of-the-request-body}

The body of a request consists of _specifications_ (`analyzeSpecs`). In each spec, you provide an image file (`content`) and a list of `features` to apply.

For example, if you want {{ vision-full-name }} to detect faces and recognize text in an image, the request body will look like this:

```json
{
  "folderId": "b1gvmob95yys********",
  "analyze_specs": [{
    "content": "iVBORw0KGgo...",
    "features": [{
      "type": "FACE_DETECTION"
    },
    {
      "type": "TEXT_DETECTION",
      "text_detection_config": {
        "language_codes": ["ru", "en"]
      }
    }]
  }]
}
```

You can provide up to eight specs in a request and use up to eight features in each spec. If you need to use more than eight features for a single image, provide it twice in different specs.

## Service response {#service-responce}

The service returns an array of analysis results for each provided spec. Each element of the array is also an array of results for each requested feature:

```json
{
  "results": [{
    // Results for the first spec.
    "results": [{
      // Results for the first requested feature, i.e., face detection.
      "faceDetection": { ... }
    },
    {
      // Results for the second requested feature, i.e., text recognition.
      "textDetection": { ... }
    }]
  }]
}
```

{{ vision-full-name }} returns the results in the same order as they were specified in the request. If you provided two specs and the first one contains an image with cats and the second has an image with dogs, the first element in the array will be the result for the image with cats.

{{ vision-full-name }} also returns the results for each requested feature.

If an error occurs during an analysis, it will be returned instead of the result. You can read more about handling errors [here](../api-ref/errors-handling.md).

{% note info %}

The {{ vision-name }} API does not support a [resource-based approach](../../api-design-guide/concepts/general.md#resource-oriented-design), since it does not use {{ yandex-cloud }} resources. {{ vision-name }} API requests are [not idempotent](../../api-design-guide/concepts/idempotency.md).

{% endnote %}

#### What's next {#what-is-next}

* [How text recognition works](ocr/index.md)
* [How face detection works](face-detection/index.md)
* [How image classification works](classification/index.md)