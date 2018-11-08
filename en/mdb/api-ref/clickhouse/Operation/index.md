# Operation
A set of methods for managing operations for asynchronous API requests.
## JSON Representation {#representation}
```json 
 {
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  // includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```

## Methods {#methods}
Method | Description
--- | ---
[get](get.md) | Returns the specified Operation resource.