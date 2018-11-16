# Key
A set of methods for managing Key resources.
## JSON Representation {#representation}
```json 
 {
  "id": "string",
  "createdAt": "string",
  "description": "string",
  "keyAlgorithm": "string",
  "publicKey": "string",

  // includes only one of the fields `userAccountId`, `serviceAccountId`
  "userAccountId": "string",
  "serviceAccountId": "string",
  // end of the list of possible fields

}
```

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a key pair for the specified service account.
[delete](delete.md) | Deletes the specified key pair.
[get](get.md) | Returns the specified Key resource.
[list](list.md) | Retrieves the list of Key resources for the specified service account.