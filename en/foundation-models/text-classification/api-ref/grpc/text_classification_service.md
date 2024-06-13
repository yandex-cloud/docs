---
editable: false
sourcePath: en/_api-ref-grpc/foundation-models/text-classification/text-classification/api-ref/grpc/text_classification_service.md
---

# Foundation Models Text Classification API, gRPC: TextClassificationService

Service for classifying text from input text.

| Call | Description |
| --- | --- |
| [Classify](#Classify) | RPC method for text classification. |
| [FewShotClassify](#FewShotClassify) | RPC method for few-shot text classification. |

## Calls TextClassificationService {#calls}

## Classify {#Classify}

RPC method for text classification.

**rpc Classify ([TextClassificationRequest](#TextClassificationRequest)) returns ([TextClassificationResponse](#TextClassificationResponse))**

### TextClassificationRequest {#TextClassificationRequest}

Field | Description
--- | ---
model_uri | **string**<br>The identifier of the classification model. 
text | **string**<br>Text for classification. 


### TextClassificationResponse {#TextClassificationResponse}

Field | Description
--- | ---
predictions[] | **[ClassificationLabel](#ClassificationLabel)**<br>Result of classification - a list of label-confidence pairs. 
model_version | **string**<br>Model version (changes with model releases). 


### ClassificationLabel {#ClassificationLabel}

Field | Description
--- | ---
label | **string**<br>A label with a class name. 
confidence | **double**<br>Confidence of item's belonging to a class. 


## FewShotClassify {#FewShotClassify}

RPC method for few-shot text classification.

**rpc FewShotClassify ([FewShotTextClassificationRequest](#FewShotTextClassificationRequest)) returns ([FewShotTextClassificationResponse](#FewShotTextClassificationResponse))**

### FewShotTextClassificationRequest {#FewShotTextClassificationRequest}

Field | Description
--- | ---
model_uri | **string**<br>The identifier of the classification model. 
task_description | **string**<br>Text description of the classification task. 
labels[] | **string**<br>List of available labels for the classification result. 
text | **string**<br>Text for classification. 
samples[] | **[ClassificationSample](#ClassificationSample)**<br>Optional set of text samples with expected labels that may be used as an additional hint for the classifier. 


### ClassificationSample {#ClassificationSample}

Field | Description
--- | ---
text | **string**<br>Text sample. 
label | **string**<br>Expected label for a given text. 


### FewShotTextClassificationResponse {#FewShotTextClassificationResponse}

Field | Description
--- | ---
predictions[] | **[ClassificationLabel](#ClassificationLabel1)**<br>Result of classification - a list of label-confidence pairs. 
model_version | **string**<br>Model version (changes with model releases). 


### ClassificationLabel {#ClassificationLabel1}

Field | Description
--- | ---
label | **string**<br>A label with a class name. 
confidence | **double**<br>Confidence of item's belonging to a class. 


