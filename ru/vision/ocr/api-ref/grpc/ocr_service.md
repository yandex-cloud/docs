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
mime_type | **string**<br>Specifications of the ([MIME type](https://en.wikipedia.org/wiki/Media_type)). Each specification contains the file to analyze and features to use for analysis. Restrictions: <ul><li>Supported file formats: `JPEG`, `PNG`, `PDF`. </li><li>Maximum file size: see [documentation](/docs/vision/concepts/limits). </li><li>Image size should not exceed 20M pixels (length x width). </li><li>The number of pages in a PDF file should not exceed 1.</li></ul> 
language_codes[] | **string**<br>[List of the languages](/docs/vision/concepts/ocr/supported-languages) to recognize text. Specified in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) format (for example, `ru`). 
model | **string**<br>[Model](/docs/vision/concepts/ocr/template-recognition#models) to use for text detection. The maximum string length in characters is 50.


### RecognizeTextResponse {#RecognizeTextResponse}

Field | Description
--- | ---
text_annotation | **[TextAnnotation](#TextAnnotation)**<br>Recognized text blocks in page or text from entities. 
page | **int64**<br>Page number in PDF file. 


### TextAnnotation {#TextAnnotation}

Field | Description
--- | ---
width | **int64**<br>Page width in pixels. 
height | **int64**<br>Page height in pixels. 
blocks[] | **[Block](#Block)**<br>Recognized text blocks in this page. 
entities[] | **[Entity](#Entity)**<br>Recognized entities. 
tables[] | **[Table](#Table)**<br> 
full_text | **string**<br>Full text recognized from image. 
rotate | enum **Angle**<br>Angle of image rotation. 


### Block {#Block}

Field | Description
--- | ---
bounding_box | **[Polygon](#Polygon)**<br>Area on the page where the text block is located. 
lines[] | **[Line](#Line)**<br>Recognized lines in this block. 
languages[] | **[DetectedLanguage](#DetectedLanguage)**<br>A list of detected languages 
text_segments[] | **[TextSegments](#TextSegments)**<br>Block position from full_text string. 


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
words[] | **[Word](#Word)**<br>Recognized words. 
text_segments[] | **[TextSegments](#TextSegments)**<br>Line position from full_text string. 
orientation | enum **Angle**<br>Angle of line rotation. 


### Word {#Word}

Field | Description
--- | ---
bounding_box | **[Polygon](#Polygon1)**<br>Area on the page where the word is located. 
text | **string**<br>Recognized word value. 
entity_index | **int64**<br>ID of the recognized word in entities array. 
text_segments[] | **[TextSegments](#TextSegments)**<br>Word position from full_text string. 


### TextSegments {#TextSegments}

Field | Description
--- | ---
start_index | **int64**<br>Start character position from full_text string. 
length | **int64**<br>Text segment length. 


### Entity {#Entity}

Field | Description
--- | ---
name | **string**<br>Entity name. 
text | **string**<br>Recognized entity text. 


### Table {#Table}

Field | Description
--- | ---
bounding_box | **[Polygon](#Polygon1)**<br>Area on the page where the table is located. 
row_count | **int64**<br>Number of rows in table. 
column_count | **int64**<br>Number of columns in table. 
cells[] | **[TableCell](#TableCell)**<br>Table cells. 


### TableCell {#TableCell}

Field | Description
--- | ---
bounding_box | **[Polygon](#Polygon1)**<br>Area on the page where the table cell is located. 
row_index | **int64**<br>Row index. 
column_index | **int64**<br>Column index. 
column_span | **int64**<br>Column span. 
row_span | **int64**<br>Row span. 
text | **string**<br>Text in cell. 
text_segments[] | **[TextSegments](#TextSegments1)**<br>Table cell position from full_text string. 


