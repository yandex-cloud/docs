---
editable: false
---

# Lockbox API, REST: Payload methods
Set of methods to access payload of secrets.
## JSON Representation {#representation}
```json 
{
  "versionId": "string",
  "entries": [
    {
      "key": "string",

      // `entries[]` includes only one of the fields `textValue`, `binaryValue`
      "textValue": "string",
      "binaryValue": "string",
      // end of the list of possible fields`entries[]`

    }
  ]
}
```
 
Field | Description
--- | ---
versionId | **string**<br><p>ID of the version that the payload belongs to.</p> 
entries[] | **object**<br><p>Payload entries.</p> 
entries[].<br>key | **string**<br><p>Non-confidential key of the entry.</p> 
entries[].<br>textValue | **string** <br>`entries[]` includes only one of the fields `textValue`, `binaryValue`<br><br><p>Text value.</p> 
entries[].<br>binaryValue | **string** (byte) <br>`entries[]` includes only one of the fields `textValue`, `binaryValue`<br><br><p>Binary value.</p> 

## Methods {#methods}
Method | Description
--- | ---
[get](get.md) | Returns the payload of the specified secret.