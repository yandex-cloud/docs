# Backup
A set of methods for managing ClickHouse Backup resources.
## JSON Representation {#representation}
```json 
 {
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "sourceClusterId": "string",
  "startedAt": "string"
}
```

## Methods {#methods}
Method | Description
--- | ---
[get](get.md) | Returns the specified ClickHouse Backup resource.
[list](list.md) | Retrieves the list of Backup resources available for the specified folder.