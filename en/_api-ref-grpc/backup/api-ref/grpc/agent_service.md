---
editable: false
---

# Cloud Backup Agent API, gRPC: AgentService



| Call | Description |
| --- | --- |
| [IssueToken](#IssueToken) |  |
| [Register](#Register) |  |

## Calls AgentService {#calls}

## IssueToken {#IssueToken}



**rpc IssueToken ([IssueTokenRequest](#IssueTokenRequest)) returns ([IssueTokenResponse](#IssueTokenResponse))**

### IssueTokenRequest {#IssueTokenRequest}

Field | Description
--- | ---
instance_id | **string**<br> 


### IssueTokenResponse {#IssueTokenResponse}

Field | Description
--- | ---
registration_token | **string**<br> 
registration_url | **string**<br> 


## Register {#Register}



**rpc Register ([RegisterRequest](#RegisterRequest)) returns ([google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty))**

### RegisterRequest {#RegisterRequest}

Field | Description
--- | ---
instance_id | **string**<br>Required.  
agent_id | **string**<br>Required.  
instance_name | **string**<br> 


