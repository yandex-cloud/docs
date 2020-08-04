---
editable: false
---

# VisionService

A set of methods for the Yandex Vision service.

| Call | Description |
| --- | --- |
| [BatchAnalyze](#BatchAnalyze) | Analyzes a batch of images and returns results with annotations. |

## Calls VisionService {#calls}

## BatchAnalyze {#BatchAnalyze}

Analyzes a batch of images and returns results with annotations.

**rpc BatchAnalyze ([BatchAnalyzeRequest](#BatchAnalyzeRequest)) returns ([BatchAnalyzeResponse](#BatchAnalyzeResponse))**

### BatchAnalyzeRequest {#BatchAnalyzeRequest}

Field | Description
--- | ---
analyze_specs[] | **[AnalyzeSpec](#AnalyzeSpec)**<br><ul><li>Supported file formats: JPEG, PNG. </li><li>Maximum file size: 1 MB. </li><li>Image size should not exceed 20M pixels (length x width).</li></ul> The number of elements must be in the range 1-8.
folder_id | **string**<br>ID of the folder to which you have access. Required for authorization with a user account (see `yandex.cloud.iam.v1.UserAccount` resource). Don't specify this field if you make the request on behalf of a service account. The maximum string length in characters is 50.


### AnalyzeSpec {#AnalyzeSpec}

Field | Description
--- | ---
source | **oneof:** `content` or `signature`<br>
&nbsp;&nbsp;content | **bytes**<br>Image content, represented as a stream of bytes. Note: As with all bytes fields, protobuffers use a pure binary representation, whereas JSON representations use base64. The maximum string length in characters is 10485760.
&nbsp;&nbsp;signature | **string**<br> The maximum string length in characters is 16384.
features[] | **[Feature](#Feature)**<br>Requested features to use for analysis. <br>Max count of requested features for one file is 8. The number of elements must be in the range 1-8.
mime_type | **string**<br>[MIME type](https://en.wikipedia.org/wiki/Media_type) of content (for example, `` application/pdf ``). The maximum string length in characters is 255.


### Feature {#Feature}

Field | Description
--- | ---
type | enum **Type**<br>Type of requested feature. <ul><li>`TEXT_DETECTION`: Text detection (OCR) feature.</li><li>`CLASSIFICATION`: Classification feature.</li><li>`FACE_DETECTION`: Face detection feature.</li><li>`IMAGE_COPY_SEARCH`: Image copy search.</li><ul/>
config | **oneof:** `classification_config` or `text_detection_config`<br>
&nbsp;&nbsp;classification_config | **[FeatureClassificationConfig](#FeatureClassificationConfig)**<br>Required for the `CLASSIFICATION` type. Specifies configuration for the classification feature. 
&nbsp;&nbsp;text_detection_config | **[FeatureTextDetectionConfig](#FeatureTextDetectionConfig)**<br>Required for the `TEXT_DETECTION` type. Specifies configuration for the text detection (OCR) feature. 


### FeatureClassificationConfig {#FeatureClassificationConfig}

Field | Description
--- | ---
model | **string**<br>Model to use for image classification. The maximum string length in characters is 256.


### FeatureTextDetectionConfig {#FeatureTextDetectionConfig}

Field | Description
--- | ---
language_codes[] | **string**<br>List of the languages to recognize text. Specified in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) format (for example, `` ru ``). The number of elements must be in the range 1-8. The maximum string length in characters for each value is 3.
model | **string**<br><ul><li>page (default) — this model is suitable for detecting multiple text entries in an image. </li><li>line — this model is suitable for cropped images with one line of text.</li></ul> The maximum string length in characters is 50.


### BatchAnalyzeResponse {#BatchAnalyzeResponse}

Field | Description
--- | ---
results[] | **[AnalyzeResult](#AnalyzeResult)**<br>Request results. Results have the same order as specifications in the request. 


### AnalyzeResult {#AnalyzeResult}

Field | Description
--- | ---
results[] | **[FeatureResult](#FeatureResult)**<br>Results for each requested feature. Feature results have the same order as in the request. 
error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Return error in case of error with file processing. 


### FeatureResult {#FeatureResult}

Field | Description
--- | ---
feature | **oneof:** `text_detection`, `classification`, `face_detection` or `image_copy_search`<br>
&nbsp;&nbsp;text_detection | **[TextAnnotation](../text_detection.proto#TextAnnotation)**<br>Text detection (OCR) result. 
&nbsp;&nbsp;classification | **[ClassAnnotation](../classification.proto#ClassAnnotation)**<br>Classification result. 
&nbsp;&nbsp;face_detection | **[FaceAnnotation](../face_detection.proto#FaceAnnotation)**<br>Face detection result. 
&nbsp;&nbsp;image_copy_search | **[ImageCopySearchAnnotation](../image_copy_search.proto#ImageCopySearchAnnotation)**<br>Image Copy Search result. 
error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Return error in case of error during the specified feature processing. 


### TextAnnotation {#TextAnnotation}

Field | Description
--- | ---
pages[] | **[Page](../text_detection.proto#Page)**<br>Pages of the recognized file. <br>For JPEG and PNG files contains only 1 page. 


### Page {#Page}

Field | Description
--- | ---
width | **int64**<br>Page width in pixels. 
height | **int64**<br>Page height in pixels. 
blocks[] | **[Block](../text_detection.proto#Block)**<br>Recognized text blocks in this page. 
entities[] | **[Entity](../text_detection.proto#Entity)**<br>Recognized entities 


### Block {#Block}

Field | Description
--- | ---
bounding_box | **[Polygon](../primitives.proto#Polygon)**<br>Area on the page where the text block is located. 
lines[] | **[Line](../text_detection.proto#Line)**<br>Recognized lines in this block. 


### Polygon {#Polygon}

Field | Description
--- | ---
vertices[] | **[Vertex](../primitives.proto#Vertex)**<br>The bounding polygon vertices. 


### Vertex {#Vertex}

Field | Description
--- | ---
x | **int64**<br>X coordinate in pixels. 
y | **int64**<br>Y coordinate in pixels. 


### Line {#Line}

Field | Description
--- | ---
bounding_box | **[Polygon](../primitives.proto#Polygon1)**<br>Area on the page where the line is located. 
words[] | **[Word](../text_detection.proto#Word)**<br>Recognized words in this line. 
confidence | **double**<br>Confidence of the OCR results for the line. Range [0, 1]. 


### Polygon {#Polygon}

Field | Description
--- | ---
vertices[] | **[Vertex](../primitives.proto#Vertex1)**<br>The bounding polygon vertices. 


### Vertex {#Vertex}

Field | Description
--- | ---
x | **int64**<br>X coordinate in pixels. 
y | **int64**<br>Y coordinate in pixels. 


### Word {#Word}

Field | Description
--- | ---
bounding_box | **[Polygon](../primitives.proto#Polygon2)**<br>Area on the page where the word is located. 
text | **string**<br>Recognized word value. 
confidence | **double**<br>Confidence of the OCR results for the word. Range [0, 1]. 
languages[] | **[DetectedLanguage](../text_detection.proto#DetectedLanguage)**<br>A list of detected languages together with confidence. 
entity_index | **int64**<br>Id of recognized word in entities array 


### DetectedLanguage {#DetectedLanguage}

Field | Description
--- | ---
language_code | **string**<br>Detected language code. 
confidence | **double**<br>Confidence of detected language. Range [0, 1]. 


### Polygon {#Polygon}

Field | Description
--- | ---
vertices[] | **[Vertex](../primitives.proto#Vertex2)**<br>The bounding polygon vertices. 


### Vertex {#Vertex}

Field | Description
--- | ---
x | **int64**<br>X coordinate in pixels. 
y | **int64**<br>Y coordinate in pixels. 


### Entity {#Entity}

Field | Description
--- | ---
name | **string**<br>Entity name 
text | **string**<br>Recognized entity text 


### ClassAnnotation {#ClassAnnotation}

Field | Description
--- | ---
properties[] | **[Property](../classification.proto#Property)**<br>Properties extracted by a specified model. <br>For example, if you ask to evaluate the image quality, the service could return such properties as `good` and `bad`. 


### Property {#Property}

Field | Description
--- | ---
name | **string**<br>Property name. 
probability | **double**<br>Probability of the property, from 0 to 1. 


### FaceAnnotation {#FaceAnnotation}

Field | Description
--- | ---
faces[] | **[Face](../face_detection.proto#Face)**<br>An array of detected faces for the specified image. 


### Face {#Face}

Field | Description
--- | ---
bounding_box | **[Polygon](../primitives.proto#Polygon3)**<br>Area on the image where the face is located. 


### Polygon {#Polygon}

Field | Description
--- | ---
vertices[] | **[Vertex](../primitives.proto#Vertex3)**<br>The bounding polygon vertices. 


### Vertex {#Vertex}

Field | Description
--- | ---
x | **int64**<br>X coordinate in pixels. 
y | **int64**<br>Y coordinate in pixels. 


### ImageCopySearchAnnotation {#ImageCopySearchAnnotation}

Field | Description
--- | ---
copy_count | **int64**<br>Number of image copies 
top_results[] | **[CopyMatch](../image_copy_search.proto#CopyMatch)**<br>Top relevance result of image copy search 


### CopyMatch {#CopyMatch}

Field | Description
--- | ---
image_url | **string**<br>url of image 
page_url | **string**<br>url of page that contains image 
title | **string**<br>page title that contains image 
description | **string**<br>image description 


