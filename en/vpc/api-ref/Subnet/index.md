# Subnet
A set of methods for managing Subnet resources.
## JSON Representation {#representation}
```json 
 {
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "networkId": "string",
  "zoneId": "string",
  "v4CidrBlocks": [
    "string"
  ],
  "v6CidrBlocks": [
    "string"
  ]
}
```

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a subnet in the specified folder and network. Method starts an asynchronous operation that can be cancelled while it is in progress.
[delete](delete.md) | Deletes the specified subnet.
[get](get.md) | Returns the specified Subnet resource.
[list](list.md) | Retrieves the list of Subnet resources in the specified folder.
[listOperations](listOperations.md) | List operations for the specified subnet.
[update](update.md) | Updates the specified subnet. Method starts an asynchronous operation that can be cancelled while it is in progress.