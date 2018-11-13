# Image
A set of methods for managing Image resources.
## JSON Representation {#representation}
```json 
 {
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "family": "string",
  "storageSize": "string",
  "minDiskSize": "string",
  "productIds": [
    "string"
  ],
  "status": "string",
  "os": {
    "type": "string"
  }
}
```

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates an image in the specified folder.
[delete](delete.md) | Deletes the specified image.
[get](get.md) | Returns the specified Image resource.
[getLatestByFamily](getLatestByFamily.md) | Returns the latest image that is part of an image family.
[list](list.md) | Retrieves the list of Image resources in the specified folder.
[listOperations](listOperations.md) | Lists operations for the specified image.
[update](update.md) | Updates the specified image.