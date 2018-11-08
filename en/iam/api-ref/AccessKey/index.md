# AccessKey
A set of methods for managing AccessKey resources.
## JSON Representation {#representation}
```json 
 {
  "id": "string",
  "serviceAccountId": "string",
  "createdAt": "string",
  "description": "string",
  "keyId": "string"
}
```

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates an access key for the specified service account.
[delete](delete.md) | Deletes the specified access key.
[get](get.md) | Returns the specified AccessKey resource.
[list](list.md) | Retrieves the list of AccessKey resources for the specified service account.