---
editable: false
---

# Subnet
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
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the subnet. The name is unique within the project. 3-63 characters long.</p> 
description | **string**<br><p>Optional description of the subnet. 0-256 characters long.</p> 
labels | **object**<br><p>Resource labels as `` key:value `` pairs. Мaximum of 64 per resource.</p> 
networkId | **string**<br><p>ID of the network the subnet belongs to.</p> 
zoneId | **string**<br><p>ID of the availability zone where the subnet resides.</p> 
v4CidrBlocks[] | **string**<br><p>CIDR block. The range of internal addresses that are defined for this subnet. This field can be set only at Subnet resource creation time and cannot be changed. For example, 10.0.0.0/22 or 192.168.0.0/24. Minimum subnet size is /28, maximum subnet size is /16.</p> 
v6CidrBlocks[] | **string**<br><p>IPv6 not available yet.</p> 
routeTableId | **string**<br><p>ID of route table the subnet is linked to.</p> 
dhcpOptions | **object**<br>
dhcpOptions.<br>domainNameServers[] | **string**<br>
dhcpOptions.<br>domainName | **string**<br>
dhcpOptions.<br>ntpServers[] | **string**<br>

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a subnet in the specified folder and network. Method starts an asynchronous operation that can be cancelled while it is in progress.
[delete](delete.md) | Deletes the specified subnet.
[get](get.md) | Returns the specified Subnet resource.
[list](list.md) | Retrieves the list of Subnet resources in the specified folder.
[listOperations](listOperations.md) | List operations for the specified subnet.
[move](move.md) | Move subnet to another folder.
[update](update.md) | Updates the specified subnet. Method starts an asynchronous operation that can be cancelled while it is in progress.