---
editable: false
---

# Trigger

## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "rule": {
    "messageQueue": {
      "serviceAccountId": "string",
      "batchSettings": {
        "size": "string",
        "cutoff": "string"
      },
      "arn": "string",
      "invokeFunction": {
        "functionId": "string",
        "functionTag": "string",
        "serviceAccountId": "string"
      }
    }
  }
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the trigger.</p> 
folderId | **string**<br><p>Required. ID of the folder that the trigger belongs to.</p> <p>The maximum string length in characters is 50.</p> 
createdAt | **string** (date-time)<br><p>Timestamp when the trigger was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Required. Name of the trigger.</p> 
description | **string**<br><p>Description of the trigger.</p> 
labels | **object**<br><p>Resource labels as <code>key:value</code> pairs.</p> 
rule | **object**<br><p>Required. Defines trigger rule (is always consistent with type filed)</p> 
rule.<br>messageQueue | **object**<br>
rule.<br>messageQueue.<br>serviceAccountId | **string**<br><p>Required. SA which has read access to the queue.</p> <p>The maximum string length in characters is 50.</p> 
rule.<br>messageQueue.<br>batchSettings | **object**<br>
rule.<br>messageQueue.<br>batchSettings.<br>size | **string** (int64)<br><p>Maximum batch size: trigger will send a batch if number of events exceeds this value.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
rule.<br>messageQueue.<br>batchSettings.<br>cutoff | **string**<br><p>Required. Maximum batch size: trigger will send a batch if its lifetime exceeds this value.</p> 
rule.<br>messageQueue.<br>arn | **string**<br><p>ARN stands for Amazon Resource ID. ARN is the only way to uniquely identify a queue in the YMQ. One is expected to use it as a reference to a queue when creating a trigger.</p> 
rule.<br>messageQueue.<br>invokeFunction | **object**<br>
rule.<br>messageQueue.<br>invokeFunction.<br>functionId | **string**<br><p>Required. The maximum string length in characters is 50.</p> 
rule.<br>messageQueue.<br>invokeFunction.<br>functionTag | **string**<br>
rule.<br>messageQueue.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>SA which should be used to call a function, optional.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | 
[delete](delete.md) | 
[get](get.md) | 
[list](list.md) | 
[listOperations](listOperations.md) | 
[update](update.md) | 