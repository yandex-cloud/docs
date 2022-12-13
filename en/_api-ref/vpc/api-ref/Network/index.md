---
editable: false
---

# Virtual Private Cloud API, REST: Network methods
A set of methods for managing Network resources.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "defaultSecurityGroupId": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the network.</p> 
folderId | **string**<br><p>ID of the folder that the network belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the network. The name is unique within the folder. 3-63 characters long.</p> 
description | **string**<br><p>Optional description of the network. 0-256 characters long.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
defaultSecurityGroupId | **string**<br><p>ID of default security group for network.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a network in the specified folder using the data specified in the request. Method starts an asynchronous operation that can be cancelled while it is in progress.
[delete](delete.md) | Deletes the specified network.
[get](get.md) | Returns the specified Network resource.
[list](list.md) | Retrieves the list of Network resources in the specified folder.
[listOperations](listOperations.md) | Lists operations for the specified network.
[listRouteTables](listRouteTables.md) | Lists route tables from the specified network.
[listSecurityGroups](listSecurityGroups.md) | Lists security groups from the specified network.
[listSubnets](listSubnets.md) | Lists subnets from the specified network.
[move](move.md) | Move network to another folder.
[update](update.md) | Updates the specified network. Method starts an asynchronous operation that can be cancelled while it is in progress.