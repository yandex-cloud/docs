# Network
A set of methods for managing Network resources.
## JSON Representation {#representation}
```json 
 {
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object"
}
```

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a network in the specified folder using the data specified in the request. Method starts an asynchronous operation that can be cancelled while it is in progress.
[delete](delete.md) | Deletes the specified network.
[get](get.md) | Returns the specified Network resource.
[list](list.md) | Retrieves the list of Network resources in the specified folder.
[listOperations](listOperations.md) | Lists operations for the specified network.
[listSubnets](listSubnets.md) | Lists subnets from the specified network.
[update](update.md) | Updates the specified network. Method starts an asynchronous operation that can be cancelled while it is in progress.