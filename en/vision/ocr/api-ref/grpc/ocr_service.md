---
editable: false
sourcePath: en/_api-ref-grpc/vision/ocr/ocr/api-ref/grpc/ocr_service.md
---

# Vision OCR API, gRPC: TextRecognitionService

A set of methods for the Vision OCR service.

| Call | Description |
| --- | --- |
| [Recognize](#Recognize) | To send the image for text recognition. |

## Calls TextRecognitionService {#calls}

## Recognize {#Recognize}

To send the image for text recognition.

**rpc Recognize ([RecognizeTextRequest](#RecognizeTextRequest)) returns (stream [RecognizeTextResponse](#RecognizeTextResponse))**

### RecognizeTextRequest {#RecognizeTextRequest}

Field | Description
--- | ---
source | **oneof:** `content`<br>
&nbsp;&nbsp;content | **bytes**<br>Bytes with data 
mime_type | **string**<br>Specifications of the ([MIME type](https://en.wikipedia.org/wiki/Media_type)). Each specification contains the file to analyze and features to use for analysis. Restrictions: <ul><li>Supported file formats: `JPEG`, `PNG`, `WEBP`, `PDF`. </li><li>Maximum file size: 20 MB. </li><li>Image size should not exceed 20M pixels (length x width). </li><li>The number of pages in a PDF file should not exceed 200 (each page counts as 1 request).</li></ul> 
language_codes[] | **string**<br>List of the languages to recognize text. Specified in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) format (for example, `ru`). 
model | **string**<br>Model to use for text detection. The maximum string length is 50 characters. Possible values: <ul><li>`page` (default): this model is suitable for detecting multiple text entries in an image. </li><li>`passport`: passport, the main double-page spread. </li><li>`driver-license-front`: driver's license, the front side. </li><li>`driver-license-back`: driver's license, the reverse side. </li><li>`vehicle-registration-front`: front side of the vehicle registration certificate. </li><li>`vehicle-registration-back`: back side of the vehicle registration certificate.</li></ul> The maximum string length in characters is 50.


### RecognizeTextResponse {#RecognizeTextResponse}

Field | Description
--- | ---
text_annotation | **[TextAnnotation](#TextAnnotation)**<br>Recognized text blocks in this page or text from entities. 
page | **int64**<br>Page number in PDF file. 


### TextAnnotation {#TextAnnotation}

Field | Description
--- | ---
width | **int64**<br>Page width in pixels. 
height | **int64**<br>Page height in pixels. 
blocks[] | **[Block](#Block)**<br>Recognized text blocks in this page. 
entities[] | **[Entity](#Entity)**<br>Recognized entities. 


### Block {#Block}

Field | Description
--- | ---
bounding_box | **[Polygon](#Polygon)**<br>Area on the page where the text block is located. 
lines[] | **[Line](#Line)**<br>Recognized lines in this block. 
languages[] | **[DetectedLanguage](#DetectedLanguage)**<br>A list of detected languages 


### DetectedLanguage {#DetectedLanguage}

Field | Description
--- | ---
language_code | **string**<br>Detected language code. 


### Polygon {#Polygon}

Field | Description
--- | ---
vertices[] | **[Vertex](#Vertex)**<br>The bounding polygon vertices. 


### Vertex {#Vertex}

Field | Description
--- | ---
x | **int64**<br>X coordinate in pixels. 
y | **int64**<br>Y coordinate in pixels. 


### Line {#Line}

Field | Description
--- | ---
bounding_box | **[Polygon](#Polygon1)**<br>Area on the page where the line is located. 
text | **string**<br>Recognized text. 
words[] | **[Word](#Word)**<br>Recognized words 


### Word {#Word}

Field | Description
--- | ---
bounding_box | **[Polygon](#Polygon1)**<br>Area on the page where the word is located. 
text | **string**<br>Recognized word value. 
entity_index | **int64**<br>ID of the recognized word in entities array. 


### Entity {#Entity}

Field | Description
--- | ---
name | **string**<br>Entity name. 
text | **string**<br>Recognized entity text. 


