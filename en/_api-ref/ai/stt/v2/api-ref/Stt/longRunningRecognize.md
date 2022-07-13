---
editable: false
---

# Method longRunningRecognize

 

 
## HTTP request {#https-request}
```
POST https://stt.{{ api-host }}/speech/stt/v2/longRunningRecognize
```
 
## Body parameters {#body_params}
 
```json 
{
  "config": {
    "specification": {
      "audioEncoding": "string",
      "sampleRateHertz": "string",
      "languageCode": "string",
      "profanityFilter": true,
      "model": "string",
      "partialResults": true,
      "singleUtterance": true,
      "audioChannelCount": "string",
      "rawResults": true,
      "literatureText": true
    },
    "folderId": "string"
  },
  "audio": {

    // `audio` includes only one of the fields `content`, `uri`
    "content": "string",
    "uri": "string",
    // end of the list of possible fields`audio`

  }
}
```

 
Field | Description
--- | ---
config | **object**
config.<br>specification | **object**
config.<br>specification.<br>audioEncoding | **string**<br><ul> <li>LINEAR16_PCM: 16-bit signed little-endian (Linear PCM)</li> <li>MP3: transcription only</li> </ul> 
config.<br>specification.<br>sampleRateHertz | **string** (int64)<br><p>8000, 16000, 48000 only for pcm</p> 
config.<br>specification.<br>languageCode | **string**<br><p>code in BCP-47</p> 
config.<br>specification.<br>profanityFilter | **boolean** (boolean)
config.<br>specification.<br>model | **string**
config.<br>specification.<br>partialResults | **boolean** (boolean)<br><p>If set true, tentative hypotheses may be returned as they become available (final=false flag) If false or omitted, only final=true result(s) are returned. Makes sense only for StreamingRecognize requests.</p> 
config.<br>specification.<br>singleUtterance | **boolean** (boolean)
config.<br>specification.<br>audioChannelCount | **string** (int64)<br><p>Used only for long running recognize.</p> 
config.<br>specification.<br>rawResults | **boolean** (boolean)<br><p>This mark allows disable normalization text</p> 
config.<br>specification.<br>literatureText | **boolean** (boolean)<br><p>Rewrite text in literature style (default: false)</p> 
config.<br>folderId | **string**
audio | **object**
audio.<br>content | **string** (byte) <br>`audio` includes only one of the fields `content`, `uri`<br>
audio.<br>uri | **string** <br>`audio` includes only one of the fields `content`, `uri`<br>
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 