---
editable: false
sourcePath: en/_api-ref/ai/foundation_models/v1/text_classification/text-classification/api-ref/TextClassification/classify.md
---

# Foundation Models Text Classification API, REST: TextClassification.classify
RPC method for text classification.
 

 
## HTTP request {#https-request}
```
POST https://llm.{{ api-host }}/foundationModels/v1/textClassification
```
 
## Body parameters {#body_params}
 
```json 
{
  "modelUri": "string",
  "text": "string"
}
```
Request for the service to classify text.
 
Field | Description
--- | ---
modelUri | **string**<br><p>The identifier of the classification model.</p> 
text | **string**<br><p>Text for classification.</p> 
 
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