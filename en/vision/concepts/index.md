# About the computer vision service

The {{ vision-full-name }} computer vision service analyzes a transmitted image and returns the result.

## Analysis features {#features}

_Features_ are various types of analysis that the service provides. For example:
* [Text recognition](ocr/index.md).
* [Face detection](face-detection/index.md).
* [Image classification](classification/index.md).

## Request body format {#format-of-the-request-body}

The body of a request consists of _specifications_ (`analyzeSpecs`). In each spec, you pass a file with an image (`content`) and a list of `features` to be applied.

For example, if you want the service to detect faces and recognize text in an image, the request body will look like this:

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

You can pass up to 8 specs in a request and use up to 8 features in each spec. If you need to use more than 8 features for a single image, pass it twice in different specs.

## Service response {#service-responce}

The service returns an array of analysis results for each of the passed specs. Each element of the array is also an array of results for each of the requested features:

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

The service returns the results in the same order as they were specified in the request. If you passed two specs and the first contains an image with cats and the second has an image with dogs, the first element in the array will be the result for the image with the cats.

The service also returns the results for each of the requested features.

If an error occurs during analysis, the service returns the error as a result. [More about handling errors](../api-ref/errors-handling.md).

#### What's next {#what-is-next}

* [How text recognition works](ocr/index.md)
* [How face detection works](face-detection/index.md)
* [How image classification works](classification/index.md)