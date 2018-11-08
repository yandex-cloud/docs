# UserAccount
A set of methods for managing UserAccount resources.
## JSON Representation {#representation}
```json 
 {
  "id": "string",

  // includes only one of the fields `yandexPassportUserAccount`
  "yandexPassportUserAccount": {
    "login": "string",
    "defaultEmail": "string"
  },
  // end of the list of possible fields

}
```

## Methods {#methods}
Method | Description
--- | ---
[get](get.md) | Returns the specified UserAccount resource.