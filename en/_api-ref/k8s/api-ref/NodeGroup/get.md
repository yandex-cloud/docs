---
editable: false
---

# Method get
Returns the specified node group.
 
To get the list of available node group, make a [list](/docs/managed-kubernetes/api-ref/NodeGroup/list) request.
 
## HTTP request {#https-request}
```
GET https://mks.api.cloud.yandex.net/managed-kubernetes/v1/nodeGroups/{nodeGroupId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
nodeGroupId | Required. ID of the node group to return. To get the node group ID use a [list](/docs/managed-kubernetes/api-ref/NodeGroup/list) request.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "clusterId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "status": "string",
  "nodeTemplate": {
    "platformId": "string",
    "resourcesSpec": {
      "memory": "string",
      "cores": "string",
      "coreFraction": "string"
    },
    "bootDiskSpec": {
      "diskTypeId": "string",
      "diskSize": "string"
    },
    "metadata": "object",
    "v4AddressSpec": {
      "oneToOneNatSpec": {
        "ipVersion": "string"
      }
    },
    "schedulingPolicy": {
      "preemptible": true
    }
  },
  "scalePolicy": {
    "fixedScale": {
      "size": "string"
    }
  },
  "allocationPolicy": {
    "locations": [
      {
        "zoneId": "string",
        "subnetId": "string"
      }
    ]
  },
  "instanceGroupId": "string",
  "nodeVersion": "string"
}
```

 
Field | Description
--- | ---
id | **string**<br><p>ID of the node group.</p> 
clusterId | **string**<br><p>ID of the cluster that the node group belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the node group. The name is unique within the folder.</p> 
description | **string**<br><p>Description of the node group. 0-256 characters long.</p> 
labels | **object**<br><p>Resource labels as <code>key:value</code> pairs. Мaximum of 64 per resource.</p> 
status | **string**<br><p>Status of the node group.</p> <ul> <li>PROVISIONING: Node group is waiting for resources to be allocated.</li> <li>RUNNING: Node group is running.</li> <li>RECONCILING: Node group is waiting for some work to be done, such as upgrading node software.</li> <li>STOPPING: Node group is being stopped.</li> <li>STOPPED: Node group stopped.</li> <li>DELETING: Node group is being deleted.</li> </ul> 
nodeTemplate | **object**<br><p>Node template that specifies parameters of the compute instances for the node group.</p> 
nodeTemplate.<br>platformId | **string**<br><p>ID of the hardware platform configuration for the node.</p> <p>Value must match the regular expression <code>\|standard-v1\|standard-v2</code>.</p> 
nodeTemplate.<br>resourcesSpec | **object**<br><p>Computing resources of the node such as the amount of memory and number of cores.</p> 
nodeTemplate.<br>resourcesSpec.<br>memory | **string** (int64)<br><p>Amount of memory available to the node, specified in bytes.</p> <p>Acceptable values are 0 to 274877906944, inclusive.</p> 
nodeTemplate.<br>resourcesSpec.<br>cores | **string** (int64)<br><p>Number of cores available to the node.</p> <p>Value must be one of 0, 1, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30 or 32.</p> 
nodeTemplate.<br>resourcesSpec.<br>coreFraction | **string** (int64)<br><p>Baseline level of CPU performance with the possibility to burst performance above that baseline level. This field sets baseline performance for each core.</p> <p>Value must be one of 0, 5, 20, 50 or 100.</p> 
nodeTemplate.<br>bootDiskSpec | **object**<br><p>The metadata as <code>key:value</code> pairs assigned to this instance template. This includes custom metadata and predefined keys.</p> <p>For example, you may use the metadata in order to provide your public SSH key to the node. For more information, see <a href="/docs/compute/concepts/vm-metadata">Metadata</a>.</p> 
nodeTemplate.<br>bootDiskSpec.<br>diskTypeId | **string**<br><p>ID of the disk type.</p> <p>Value must match the regular expression <code>\|network-ssd\|network-hdd</code>.</p> 
nodeTemplate.<br>bootDiskSpec.<br>diskSize | **string** (int64)<br><p>Size of the disk, specified in bytes.</p> <p>Acceptable values are 0 to 4398046511104, inclusive.</p> 
nodeTemplate.<br>metadata | **object**<br><p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression <code>[a-z][-_0-9a-z]*</code>. The maximum string length in characters for each value is 131072.</p> 
nodeTemplate.<br>v4AddressSpec | **object**<br><p>Specification for the create network interfaces for the node group compute instances.</p> 
nodeTemplate.<br>v4AddressSpec.<br>oneToOneNatSpec | **object**<br><p>One-to-one NAT configuration. Setting up one-to-one NAT ensures that public IP addresses are assigned to nodes, and therefore internet is accessible for all nodes of the node group. If the field is not set, NAT will not be set up.</p> 
nodeTemplate.<br>v4AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**<br><p>IP version for the public IP address.</p> <ul> <li>IPV4: IPv4 address, for example 192.168.0.0.</li> <li>IPV6: IPv6 address, not available yet.</li> </ul> 
nodeTemplate.<br>schedulingPolicy | **object**<br><p>Scheduling policy configuration.</p> 
nodeTemplate.<br>schedulingPolicy.<br>preemptible | **boolean** (boolean)<br><p>True for preemptible compute instances. Default value is false. Preemptible compute instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see <a href="/docs/compute/concepts/preemptible-vm">Preemptible Virtual Machines</a>.</p> 
scalePolicy | **object**<br><p>Scale policy of the node group.  For more information, see <a href="/docs/compute/concepts/instance-groups/policies#scale-policy">Scaling policy</a>.</p> 
scalePolicy.<br>fixedScale | **object**<br>Fixed scale policy of the node group.<br>
scalePolicy.<br>fixedScale.<br>size | **string** (int64)<br><p>Number of nodes in the node group.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
allocationPolicy | **object**<br><p>Allocation policy by which resources for node group are allocated to zones and regions.</p> 
allocationPolicy.<br>locations[] | **object**<br><p>List of locations where resources for the node group will be allocated.</p> 
allocationPolicy.<br>locations[].<br>zoneId | **string**<br><p>Required. ID of the availability zone where the nodes may reside.</p> 
allocationPolicy.<br>locations[].<br>subnetId | **string**<br><p>ID of the subnet. If a network chosen for the Kubernetes cluster has only one subnet in the specified zone, subnet ID may be omitted.</p> 
instanceGroupId | **string**<br><p>ID of the managed instance group associated with this node group.</p> 
nodeVersion | **string**<br><p>Version of Kubernetes components that runs on the nodes.</p> 