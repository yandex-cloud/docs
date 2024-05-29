---
editable: false
sourcePath: en/_api-ref/ai/foundation_models/v1/text_classification/text-classification/api-ref/TextClassification/fewShotClassify.md
---

# Foundation Models Text Classification API, REST: TextClassification.fewShotClassify
RPC method for few-shot text classification.
 

 
## HTTP request {#https-request}
```
POST https://llm.{{ api-host }}/foundationModels/v1/fewShotTextClassification
```
 
## Body parameters {#body_params}
 
```json 
{
  "modelUri": "string",
  "taskDescription": "string",
  "labels": [
    "string"
  ],
  "text": "string",
  "samples": [
    {
      "text": "string",
      "label": "string"
    }
  ]
}
```
Request for the service to classify text.
 
Field | Description
--- | ---
modelUri | **string**<br><p>The identifier of the classification model.</p> 
taskDescription | **string**<br><p>Text description of the classification task.</p> 
labels[] | **string**<br><p>List of available labels for the classification result.</p> 
text | **string**<br><p>Text for classification.</p> 
samples[] | **object**<br><p>Optional set of text samples with expected labels that may be used as an additional hint for the classifier.</p> 
samples[].<br>text | **string**<br><p>Text sample.</p> 
samples[].<br>label | **string**<br><p>Expected label for a given text.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "predictions": [
    {
      "label": "string",
      "confidence": "number"
    }
  ],
  "modelVersion": "string"
}
```
Response containing classifier predictions.
 
Field | Description
--- | ---
predictions[] | **object**<br><p>Result of classification - a list of label-confidence pairs.</p> 
predictions[].<br>label | **string**<br><p>A label with a class name.</p> 
predictions[].<br>confidence | **number** (double)<br><p>Confidence of item's belonging to a class.</p> 
modelVersion | **string**<br><p>Model version (changes with model releases).</p> 