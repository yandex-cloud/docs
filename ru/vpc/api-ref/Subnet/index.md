---
editable: false
sourcePath: en/_api-ref/vpc/v1/api-ref/Subnet/index.md
---

# Virtual Private Cloud API, REST: Subnet methods
A set of methods for managing Subnet resources.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "networkId": "string",
  "zoneId": "string",
  "v4CidrBlocks": [
    "string"
  ],
  "v6CidrBlocks": [
    "string"
  ],
  "routeTableId": "string",
  "dhcpOptions": {
    "domainNameServers": [
      "string"
    ],
    "domainName": "string",
    "ntpServers": [
      "string"
    ]
  }
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the subnet.</p> 
folderId | **string**<br><p>ID of the folder that the subnet belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the subnet. The name is unique within the project. 3-63 characters long.</p> 
description | **string**<br><p>Optional description of the subnet. 0-256 characters long.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
networkId | **string**<br><p>ID of the network the subnet belongs to.</p> 
zoneId | **string**<br><p>ID of the availability zone where the subnet resides.</p> 
v4CidrBlocks[] | **string**<br><p>CIDR block. The range of internal addresses that are defined for this subnet. This field can be set only at Subnet resource creation time and cannot be changed. For example, 10.0.0.0/22 or 192.168.0.0/24. Minimum subnet size is /28, maximum subnet size is /16.</p> 
v6CidrBlocks[] | **string**<br><p>IPv6 not available yet.</p> 
routeTableId | **string**<br><p>ID of route table the subnet is linked to.</p> 
dhcpOptions | **object**
dhcpOptions.<br>domainNameServers[] | **string**
dhcpOptions.<br>domainName | **string**
dhcpOptions.<br>ntpServers[] | **string**

## Methods {#methods}
Method | Description
--- | ---
[addCidrBlocks](addCidrBlocks.md) | Adds CIDR blocks to the specified subnet. Method starts an asynchronous operation that can be cancelled while it is in progress.
[create](create.md) | Creates a subnet in the specified folder and network. Method starts an asynchronous operation that can be cancelled while it is in progress.
[delete](delete.md) | Deletes the specified subnet.
[get](get.md) | Returns the specified Subnet resource.
[list](list.md) | Retrieves the list of Subnet resources in the specified folder.
[listOperations](listOperations.md) | List operations for the specified subnet.
[listUsedAddresses](listUsedAddresses.md) | List used addresses in specified subnet.
[move](move.md) | Move subnet to another folder.
[removeCidrBlocks](removeCidrBlocks.md) | Removes CIDR blocks from the specified subnet. Method starts an asynchronous operation that can be cancelled while it is in progress.
[update](update.md) | Updates the specified subnet. Method starts an asynchronous operation that can be cancelled while it is in progress.