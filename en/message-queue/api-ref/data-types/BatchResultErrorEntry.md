# BatchResultErrorEntry

Describes why the action failed on the entry.

| Parameter | Type | Required parameter | Description |
----- | ----- | ----- | -----
| `Code` | **string** | Yes | Code of the error that occurred when executing the request. |
| `Id` | **string** | Yes | ID of a batch entry. |
| `Message` | **string** | No | Message with error details. |
| `SenderFault` | **boolean** | Yes | Specifies whether the error happened due to the producer. |