---
editable: false
---

# Job

## JSON Representation {#representation}
```json 
{
  "id": "string",
  "config": "string",
  "ammo": {
    "name": "string",
    "content": "string"
  },
  "loggingLogGroupId": "string",
  "testData": {
    "objectStorageBucket": "string",
    "objectStorageFilename": "string"
  }
}
```
 
Field | Description
--- | ---
id | **string**<br>
config | **string**<br>
ammo | **object**<br>
ammo.<br>name | **string**<br>
ammo.<br>content | **string** (byte)<br>
loggingLogGroupId | **string**<br>
testData | **object**<br>
testData.<br>objectStorageBucket | **string**<br>
testData.<br>objectStorageFilename | **string**<br>

## Methods {#methods}
Method | Description
--- | ---
[claimStatus](claimStatus.md) | Claims status for the specified job.
[get](get.md) | Returns the job for the specified agent.
[getSignal](getSignal.md) | Returns the signal for the specified job.