---
editable: false
---

# Lockbox API, gRPC: PayloadService

Set of methods to access payload of secrets.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the payload of the specified secret. |

## Calls PayloadService {#calls}

## Get {#Get}

Returns the payload of the specified secret. <br>To get the list of all available secrets, make a [SecretService.List](./secret_service#List) request.

**rpc Get ([GetPayloadRequest](#GetPayloadRequest)) returns ([Payload](#Payload))**

### GetPayloadRequest {#GetPayloadRequest}

Field | Description
--- | ---
secret_id | **string**<br>Required. ID of the secret. The maximum string length in characters is 50.
version_id | **string**<br>Optional ID of the version. The maximum string length in characters is 50.


### Payload {#Payload}

Field | Description
--- | ---
version_id | **string**<br>ID of the version that the payload belongs to. 
entries[] | **[Entry](#Entry)**<br>Payload entries. 


### Entry {#Entry}

Field | Description
--- | ---
key | **string**<br>Non-confidential key of the entry. 
value | **oneof:** `text_value` or `binary_value`<br>Confidential value of the entry.
&nbsp;&nbsp;text_value | **string**<br>Text value. 
&nbsp;&nbsp;binary_value | **bytes**<br>Binary value. 


