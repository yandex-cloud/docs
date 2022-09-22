---
editable: false
sourcePath: en/_api-ref-grpc/vision/classifier/classifier/api-ref/grpc/image_classifier_service.md
---

# ImageClassifierService



| Call | Description |
| --- | --- |
| [Annotate](#Annotate) |  |

## Calls ImageClassifierService {#calls}

## Annotate {#Annotate}



**rpc Annotate ([AnnotationRequest](#AnnotationRequest)) returns ([AnnotationResponse](#AnnotationResponse))**

### AnnotationRequest {#AnnotationRequest}

Field | Description
--- | ---
image | **[Image](#Image)**<br>image to annotate 


### Image {#Image}

Field | Description
--- | ---
ImageSource | **oneof:** `content`<br>type of image
&nbsp;&nbsp;content | **bytes**<br>bytes with data 
image_type | enum **ImageType**<br>type of data 


### AnnotationResponse {#AnnotationResponse}

Field | Description
--- | ---
request_id | **string**<br>internal service requestId 
classifier_specification | **[ClassifierSpecification](#ClassifierSpecification)**<br>class specification 
annotations[] | **[ClassAnnotation](#ClassAnnotation)**<br>annotations for each class 


### ClassifierSpecification {#ClassifierSpecification}

Field | Description
--- | ---
labels[] | **[Label](#Label)**<br>List of labels, annotated by service 
classification_type | enum **ClassificationType**<br>type of annotation: exclusive (multi-class) or non-exclusive (multi-label) 


### Label {#Label}

Field | Description
--- | ---
name | **string**<br>Label name 
description | **string**<br>human readable description of label 


### ClassAnnotation {#ClassAnnotation}

Field | Description
--- | ---
label | **[Label](#Label1)**<br>list of annotated labels 
confidence | **double**<br>confidence for each label 


