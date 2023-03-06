---
editable: false
---

# Managed Service for PostgreSQL API, REST: Database methods
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
  ],
  "templateDb": "string",
  "deletionProtection": true
}
```
 
Field | Description
--- | ---
name | **string**<br><p>Name of the database.</p> 
clusterId | **string**<br><p>ID of the PostgreSQL cluster that the database belongs to.</p> 
owner | **string**<br><p>Name of the user assigned as the owner of the database.</p> 
lcCollate | **string**<br><p>POSIX locale for string sorting order. Can only be set at creation time.</p> 
lcCtype | **string**<br><p>POSIX locale for character classification. Can only be set at creation time.</p> 
extensions[] | **object**<br><p>PostgreSQL extensions enabled for the database.</p> 
extensions[].<br>name | **string**<br><p>Name of the extension, e.g. ``pg_trgm`` or ``pg_btree``. Extensions supported by Managed Service for PostgreSQL are <a href="/docs/managed-postgresql/operations/extensions/cluster-extensions">listed in the Developer's Guide</a>.</p> 
extensions[].<br>version | **string**<br><p>Version of the extension.</p> 
templateDb | **string**<br><p>Name of the database template.</p> 
deletionProtection | **boolean** (boolean)<br><p>Deletion Protection inhibits deletion of the database</p> <p>Default value: ``unspecified`` (inherits cluster's deletion_protection)</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a new PostgreSQL database in the specified cluster.
[delete](delete.md) | Deletes the specified PostgreSQL database.
[get](get.md) | Returns the specified PostgreSQL Database resource.
[list](list.md) | Retrieves the list of PostgreSQL Database resources in the specified cluster.
[update](update.md) | Updates the specified PostgreSQL database.