---
editable: false
sourcePath: ru/_api-ref-grpc/vision/api-ref/grpc/vision_service.md
---

# VisionService

Набор методов для сервиса Yandex Vision.

| Вызов | Описание |
| --- | --- |
| [BatchAnalyze](#BatchAnalyze) | Анализирует набор изображений и возвращает результаты с аннотациями. |

## Вызовы VisionService {#calls}

## BatchAnalyze {#BatchAnalyze}

Анализирует набор изображений и возвращает результаты с аннотациями.

**rpc BatchAnalyze ([BatchAnalyzeRequest](#BatchAnalyzeRequest)) returns ([BatchAnalyzeResponse](#BatchAnalyzeResponse))**

### BatchAnalyzeRequest {#BatchAnalyzeRequest}

Поле | Описание
--- | ---
analyze_specs[] | **[AnalyzeSpec](#AnalyzeSpec)**<br><ul><li>Поддерживаемые форматы файлов: JPEG, PNG. </li><li>Максимальный размер файла: 1 МБ. </li><li>Размер изображения не должен превышать 20 мегапикселей (длина x ширина).</li></ul> Количество элементов должно находиться в диапазоне от 1 до 8.
folder_id | **string**<br>Идентификатор каталога, к которому у вас есть доступ. Требуется для авторизации с пользовательским аккаунтом (см. ресурс `yandex.cloud.iam.v1.UserAccount`) . Не используйте это поле, если вы делаете запрос от имени сервисного аккаунта. Максимальная длина строки в символах — 50.


### AnalyzeSpec {#AnalyzeSpec}

Поле | Описание
--- | ---
source | **oneof:** `content`<br>
&nbsp;&nbsp;content | **bytes**<br>Содержимое изображения, представленное в виде потока байтов. Примечание: как и во всех полях с байтами, в protobuf используется чистое двоичное представление, тогда как в JSON-представлении используется base64. Максимальная длина строки в символах — 10485760.
features[] | **[Feature](#Feature)**<br>Запрошенные возможности для анализа. <br>Максимальное количество запрошенных возможностей для одного файла - 8. Количество элементов должно находиться в диапазоне от 1 до 8.
mime_type | **string**<br>[MIME-тип](https://en.wikipedia.org/wiki/Media_type) контента (например, `` application/pdf ``). Максимальная длина строки в символах — 255.


### Feature {#Feature}

Поле | Описание
--- | ---
type | enum **Type**<br>Тип запрашиваемой возможности для анализа. <ul><li>`TEXT_DETECTION`: Распознавание текста (OCR).</li><li>`CLASSIFICATION`: Возможность Классификация.</li><li>`FACE_DETECTION`: Возможность Обнаружение лиц.</li><ul/>
config | **oneof:** `classification_config` или `text_detection_config`<br>
&nbsp;&nbsp;classification_config | **[FeatureClassificationConfig](#FeatureClassificationConfig)**<br>Обязательно для типа `CLASSIFICATION`. Задает конфигурацию для классификации. 
&nbsp;&nbsp;text_detection_config | **[FeatureTextDetectionConfig](#FeatureTextDetectionConfig)**<br>Обязательно для типа `TEXT_DETECTION`. Задает конфигурацию для распознавания текста (OCR). 


### FeatureClassificationConfig {#FeatureClassificationConfig}

Поле | Описание
--- | ---
model | **string**<br>Модель, которая будет использоваться для анализа изображений. Максимальная длина строки в символах — 256.


### FeatureTextDetectionConfig {#FeatureTextDetectionConfig}

Поле | Описание
--- | ---
language_codes[] | **string**<br>Список языков для распознавания текста. Указывается в формате [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) (например, `` ru ``). Количество элементов должно находиться в диапазоне от 1 до 8. Максимальная длина строки в символах для каждого значения — 3.
model | **string**<br><ul><li>page (по умолчанию) — эта модель подходит для распознавания изображений со множеством текстовых блоков на нем. </li><li>line — эта модель подходит для обрезанных изображений, которые содержат одну строку текста.</li></ul> Максимальная длина строки в символах — 50.


### BatchAnalyzeResponse {#BatchAnalyzeResponse}

Поле | Описание
--- | ---
results[] | **[AnalyzeResult](#AnalyzeResult)**<br>Результаты запроса. Результаты имеют тот же порядок, что и спецификации в запросе. 


### AnalyzeResult {#AnalyzeResult}

Поле | Описание
--- | ---
results[] | **[FeatureResult](#FeatureResult)**<br>Результаты для каждой запрошенной возможности для анализа. Результаты имеют тот же порядок, что и указанные возможности в запросе. 
error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Возвращает информацию об ошибке, если ошибка произошла при обработке файла. 


### FeatureResult {#FeatureResult}

Поле | Описание
--- | ---
feature | **oneof:** `text_detection`, `classification` или `face_detection`<br>
&nbsp;&nbsp;text_detection | **[TextAnnotation](#TextAnnotation)**<br>Результат распознавания текста (OCR). 
&nbsp;&nbsp;classification | **[ClassAnnotation](#ClassAnnotation)**<br>Результат классификации. 
&nbsp;&nbsp;face_detection | **[FaceAnnotation](#FaceAnnotation)**<br>Результат обнаружения лиц. 
error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Возвращает информацию об ошибке, если ошибка произошла при выполнении анализа для указанной возможности. 


### TextAnnotation {#TextAnnotation}

Поле | Описание
--- | ---
pages[] | **[Page](#Page)**<br>Страницы распознанного файла. <br>Для JPEG и PNG файлов содержит только 1 страницу. 


### Page {#Page}

Поле | Описание
--- | ---
width | **int64**<br>Ширина страницы в пикселях. 
height | **int64**<br>Высота страницы в пикселях. 
blocks[] | **[Block](#Block)**<br>Распознанные блоки текста на этой странице. 


### Block {#Block}

Поле | Описание
--- | ---
bounding_box | **[Polygon](#Polygon)**<br>Область на странице, где находится блок текста. 
lines[] | **[Line](#Line)**<br>Распознанные строки в этом блоке. 


### Polygon {#Polygon}

Поле | Описание
--- | ---
vertices[] | **[Vertex](#Vertex)**<br>Вершины обрамляющей фигуры. 


### Vertex {#Vertex}

Поле | Описание
--- | ---
x | **int64**<br>Координата по оси X в пикселях. 
y | **int64**<br>Координата по оси Y в пикселях. 


### Line {#Line}

Поле | Описание
--- | ---
bounding_box | **[Polygon](#Polygon1)**<br>Область на странице, где расположена строка. 
words[] | **[Word](#Word)**<br>Распознанные слова в этой строке. 
confidence | **double**<br>Достоверность результатов OCR для строки. Диапазон [0, 1]. 


### Polygon {#Polygon1}

Поле | Описание
--- | ---
vertices[] | **[Vertex](#Vertex1)**<br>Вершины обрамляющей фигуры. 


### Vertex {#Vertex1}

Поле | Описание
--- | ---
x | **int64**<br>Координата по оси X в пикселях. 
y | **int64**<br>Координата по оси Y в пикселях. 


### Word {#Word}

Поле | Описание
--- | ---
bounding_box | **[Polygon](#Polygon2)**<br>Область на странице, где расположена строка. 
text | **string**<br>Распознанное слово. 
confidence | **double**<br>Достоверность результатов OCR для слова. Диапазон [0, 1]. 
languages[] | **[DetectedLanguage](#DetectedLanguage)**<br>Список распознанных языков и достоверность распознавания. 


### DetectedLanguage {#DetectedLanguage}

Поле | Описание
--- | ---
language_code | **string**<br>Код распознанного языка. 
confidence | **double**<br>Достоверность распознанного языка. Диапазон [0, 1]. 


### Polygon {#Polygon2}

Поле | Описание
--- | ---
vertices[] | **[Vertex](#Vertex2)**<br>Вершины обрамляющей фигуры. 


### Vertex {#Vertex2}

Поле | Описание
--- | ---
x | **int64**<br>Координата по оси X в пикселях. 
y | **int64**<br>Координата по оси Y в пикселях. 


### ClassAnnotation {#ClassAnnotation}

Поле | Описание
--- | ---
properties[] | **[Property](#Property)**<br>Признаки, извлеченные указанной моделью. <br>Например, если вы попросите оценить качество изображения, сервис может вернуть такие признаки, как `good` и `bad`. 


### Property {#Property}

Поле | Описание
--- | ---
name | **string**<br>Имя признака. 
probability | **double**<br>Вероятность для признака, от 0 до 1. 


### FaceAnnotation {#FaceAnnotation}

Поле | Описание
--- | ---
faces[] | **[Face](#Face)**<br>Массив обнаруженных лиц для указанного изображения. 


### Face {#Face}

Поле | Описание
--- | ---
bounding_box | **[Polygon](#Polygon3)**<br>Область на изображении, где находится лицо. 


### Polygon {#Polygon3}

Поле | Описание
--- | ---
vertices[] | **[Vertex](#Vertex3)**<br>Вершины обрамляющей фигуры. 


### Vertex {#Vertex3}

Поле | Описание
--- | ---
x | **int64**<br>Координата по оси X в пикселях. 
y | **int64**<br>Координата по оси Y в пикселях. 


