# Disk
A set of methods for managing Disk resources.
## JSON Representation {#representation}
```json 
 {
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "typeId": "string",
  "zoneId": "string",
  "size": "string",
  "productIds": [
    "string"
  ],
  "status": "string",
  "instanceIds": [
    "string"
  ],

  // includes only one of the fields `sourceImageId`, `sourceSnapshotId`
  "sourceImageId": "string",
  "sourceSnapshotId": "string",
  // end of the list of possible fields

}
```

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a disk in the specified folder.
[delete](delete.md) | Deletes the specified disk.
[get](get.md) | Returns the specified Disk resource.
[list](list.md) | Retrieves the list of Disk resources in the specified folder.
[listOperations](listOperations.md) | Lists operations for the specified disk.
[update](update.md) | Updates the specified disk.