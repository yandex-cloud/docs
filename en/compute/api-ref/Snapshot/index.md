# Snapshot
A set of methods for managing Snapshot resources.
## JSON Representation {#representation}
```json 
 {
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "storageSize": "string",
  "diskSize": "string",
  "productIds": [
    "string"
  ],
  "status": "string",
  "sourceDiskId": "string"
}
```

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a snapshot of the specified disk.
[delete](delete.md) | Deletes the specified snapshot.
[get](get.md) | Returns the specified Snapshot resource.
[list](list.md) | Retrieves the list of Snapshot resources in the specified folder.
[listOperations](listOperations.md) | Lists operations for the specified snapshot.
[update](update.md) | Updates the specified snapshot.