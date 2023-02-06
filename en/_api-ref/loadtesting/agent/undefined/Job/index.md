---
editable: false
---

# Title not set., REST: Job methods

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
id | **string**
config | **string**
ammo | **object**
ammo.<br>name | **string**
ammo.<br>content | **string** (byte)
loggingLogGroupId | **string**
testData | **object**
testData.<br>objectStorageBucket | **string**
testData.<br>objectStorageFilename | **string**

## Methods {#methods}
Method | Description
--- | ---
[claimStatus](claimStatus.md) | Claims status for the specified job.
[get](get.md) | Returns the job for the specified agent.
[get](get.md) | Returns the job for the specified agent.
[getSignal](getSignal.md) | Returns the signal for the specified job.