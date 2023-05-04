---
editable: false
sourcePath: en/_api-ref-grpc/functions/api-gateway/websocket/apigateway/websocket/api-ref/grpc/connection_service.md
---

# API Gateway WebSocket Connection Service, gRPC: ConnectionService

A set of methods for managing API Gateway WebSocket connections.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified connection info. |
| [Send](#Send) | Sends data to the specified connection. |
| [Disconnect](#Disconnect) | Disconnects the specified connection. |

## Calls ConnectionService {#calls}

## Get {#Get}

Returns the specified connection info.

**rpc Get ([GetConnectionRequest](#GetConnectionRequest)) returns ([Connection](#Connection))**

### GetConnectionRequest {#GetConnectionRequest}

Field | Description
--- | ---
connection_id | **string**<br>Required. ID of the connection to get. The maximum string length in characters is 50.


### Connection {#Connection}

Field | Description
--- | ---
id | **string**<br>ID of the connection. 
gateway_id | **string**<br>ID of the API Gateway. 
identity | **[Identity](#Identity)**<br>The information about the caller making the request to API Gateway. 
connected_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The timestamp at which connection was established. 
last_active_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The timestamp at which connection was last accessed. 


### Identity {#Identity}

Field | Description
--- | ---
source_ip | **string**<br>The source IP address of the caller making the request to API Gateway. 
user_agent | **string**<br>The User Agent of the caller making the request to API Gateway. 


## Send {#Send}

Sends data to the specified connection.

**rpc Send ([SendToConnectionRequest](#SendToConnectionRequest)) returns ([SendToConnectionResponse](#SendToConnectionResponse))**

### SendToConnectionRequest {#SendToConnectionRequest}

Field | Description
--- | ---
connection_id | **string**<br>Required. ID of the connection to which send. The maximum string length in characters is 50.
data | **bytes**<br>Required. Data to send. The maximum string length in characters is 131072.
type | enum **DataType**<br>Type of the sending data. <ul><li>`BINARY`: Binary data.</li><li>`TEXT`: Text data.</li></ul>


### SendToConnectionResponse {#SendToConnectionResponse}

Empty

## Disconnect {#Disconnect}

Disconnects the specified connection.

**rpc Disconnect ([DisconnectRequest](#DisconnectRequest)) returns ([DisconnectResponse](#DisconnectResponse))**

### DisconnectRequest {#DisconnectRequest}

Field | Description
--- | ---
connection_id | **string**<br>Required. ID of the connection to disconnect. The maximum string length in characters is 50.


### DisconnectResponse {#DisconnectResponse}

Empty

