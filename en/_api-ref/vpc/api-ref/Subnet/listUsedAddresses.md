---
editable: false
---

# Virtual Private Cloud API, REST: Subnet.listUsedAddresses
List used addresses in specified subnet.
 

 
## HTTP request {#https-request}
```
GET https://vpc.{{ api-host }}/vpc/v1/subnets/{subnetId}/addresses
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
subnetId | <p>Required.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | 
pageToken | 
filter | 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "addresses": [
    {
      "address": "string",
      "ipVersion": "string",
      "references": [
        {
          "referrer": {
            "type": "string",
            "id": "string"
          },
          "type": "string"
        }
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
addresses[] | **object**
addresses[].<br>address | **string**
addresses[].<br>ipVersion | **string**
addresses[].<br>references[] | **object**
addresses[].<br>references[].<br>referrer | **object**
addresses[].<br>references[].<br>referrer.<br>type | **string**<br><ul> <li>``type = compute.instance, id = <instance id>``</li> <li>``type = compute.instanceGroup, id = <instanceGroup id>``</li> <li>``type = loadbalancer.networkLoadBalancer, id = <networkLoadBalancer id>``</li> <li>``type = managed-kubernetes.cluster, id = <cluster id>``</li> <li>``type = managed-mysql.cluster, id = <cluster id>``</li> </ul> 
addresses[].<br>references[].<br>referrer.<br>id | **string**
addresses[].<br>references[].<br>type | **string**
nextPageToken | **string**