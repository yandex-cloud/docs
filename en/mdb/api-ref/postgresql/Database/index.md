# Database
A set of methods for managing PostgreSQL Database resources.
## JSON Representation {#representation}
```json 
 {
  "name": "string",
  "clusterId": "string",
  "owner": "string",
  "lcCollate": "string",
  "lcCtype": "string",
  "extensions": [
    {
      "name": "string",
      "version": "string"
    }
  ]
}
```

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a new PostgreSQL database in the specified cluster.
[delete](delete.md) | Deletes the specified PostgreSQL database.
[get](get.md) | Returns the specified PostgreSQL Database resource.
[list](list.md) | Retrieves the list of PostgreSQL Database resources in the specified cluster.
[update](update.md) | Updates the specified PostgreSQL database.