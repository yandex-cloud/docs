---
editable: false
---

# Method listNodeGroups
Lists nodegroup for the specified Kubernetes cluster.
 

 
## HTTP request {#https-request}
```
GET https://mks.api.cloud.yandex.net/managed-kubernetes/v1/clusters/{clusterId}/nodeGroups
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the Kubernetes cluster to list node groups in. To get the Kubernetes cluster ID use a [list](/docs/managed-kubernetes/api-ref/Cluster/list) request.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/managed-kubernetes/api-ref/Cluster/listNodeGroups#query_params), the service returns a [nextPageToken](/docs/managed-kubernetes/api-ref/Cluster/listNodeGroups#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/managed-kubernetes/api-ref/Cluster/listNodeGroups#query_params) to the [nextPageToken](/docs/managed-kubernetes/api-ref/Cluster/listNodeGroups#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters resources listed in the response. Currently you can use filtering only on [Cluster.name](/docs/managed-kubernetes/api-ref/Cluster#representation) field.  The maximum string length in characters is 1000.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "nodeGroups": [
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
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
nodeGroups[] | **object**<br><p>List of node groups for the specified Kubernetes cluster.</p> 
nodeGroups[].<br>id | **string**<br><p>ID of the node group.</p> 
nodeGroups[].<br>clusterId | **string**<br><p>ID of the cluster that the node group belongs to.</p> 
nodeGroups[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
nodeGroups[].<br>name | **string**<br><p>Name of the node group. The name is unique within the folder.</p> 
nodeGroups[].<br>description | **string**<br><p>Description of the node group. 0-256 characters long.</p> 
nodeGroups[].<br>labels | **object**<br><p>Resource labels as <code>key:value</code> pairs. Мaximum of 64 per resource.</p> 
nodeGroups[].<br>status | **string**<br><p>Status of the node group.</p> <ul> <li>PROVISIONING: Node group is waiting for resources to be allocated.</li> <li>RUNNING: Node group is running.</li> <li>RECONCILING: Node group is waiting for some work to be done, such as upgrading node software.</li> <li>STOPPING: Node group is being stopped.</li> <li>STOPPED: Node group stopped.</li> <li>DELETING: Node group is being deleted.</li> </ul> 
nodeGroups[].<br>nodeTemplate | **object**<br><p>Node template that specifies parameters of the compute instances for the node group.</p> 
nodeGroups[].<br>nodeTemplate.<br>platformId | **string**<br><p>ID of the hardware platform configuration for the node.</p> <p>Value must match the regular expression <code>\|standard-v1\|standard-v2</code>.</p> 
nodeGroups[].<br>nodeTemplate.<br>resourcesSpec | **object**<br><p>Computing resources of the node such as the amount of memory and number of cores.</p> 
nodeGroups[].<br>nodeTemplate.<br>resourcesSpec.<br>memory | **string** (int64)<br><p>Amount of memory available to the node, specified in bytes.</p> <p>Acceptable values are 0 to 274877906944, inclusive.</p> 
nodeGroups[].<br>nodeTemplate.<br>resourcesSpec.<br>cores | **string** (int64)<br><p>Number of cores available to the node.</p> <p>Value must be one of 0, 1, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30 or 32.</p> 
nodeGroups[].<br>nodeTemplate.<br>resourcesSpec.<br>coreFraction | **string** (int64)<br><p>Baseline level of CPU performance with the possibility to burst performance above that baseline level. This field sets baseline performance for each core.</p> <p>Value must be one of 0, 5, 20, 50 or 100.</p> 
nodeGroups[].<br>nodeTemplate.<br>bootDiskSpec | **object**<br><p>The metadata as <code>key:value</code> pairs assigned to this instance template. This includes custom metadata and predefined keys.</p> <p>For example, you may use the metadata in order to provide your public SSH key to the node. For more information, see <a href="/docs/compute/concepts/vm-metadata">Metadata</a>.</p> 
nodeGroups[].<br>nodeTemplate.<br>bootDiskSpec.<br>diskTypeId | **string**<br><p>ID of the disk type.</p> <p>Value must match the regular expression <code>\|network-nvme\|network-hdd</code>.</p> 
nodeGroups[].<br>nodeTemplate.<br>bootDiskSpec.<br>diskSize | **string** (int64)<br><p>Size of the disk, specified in bytes.</p> <p>Acceptable values are 0 to 4398046511104, inclusive.</p> 
nodeGroups[].<br>nodeTemplate.<br>metadata | **object**<br><p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression <code>[a-z][-_0-9a-z]*</code>. The maximum string length in characters for each value is 131072.</p> 
nodeGroups[].<br>nodeTemplate.<br>v4AddressSpec | **object**<br><p>Specification for the create network interfaces for the node group compute instances.</p> 
nodeGroups[].<br>nodeTemplate.<br>v4AddressSpec.<br>oneToOneNatSpec | **object**<br><p>One-to-one NAT configuration. Setting up one-to-one NAT ensures that public IP addresses are assigned to nodes, and therefore internet is accessible for all nodes of the node group. If the field is not set, NAT will not be set up.</p> 
nodeGroups[].<br>nodeTemplate.<br>v4AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**<br><p>IP version for the public IP address.</p> <ul> <li>IPV4: IPv4 address, for example 192.168.0.0.</li> <li>IPV6: IPv6 address, not available yet.</li> </ul> 
nodeGroups[].<br>nodeTemplate.<br>schedulingPolicy | **object**<br><p>Scheduling policy configuration.</p> 
nodeGroups[].<br>nodeTemplate.<br>schedulingPolicy.<br>preemptible | **boolean** (boolean)<br><p>True for preemptible compute instances. Default value is false. Preemptible compute instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see <a href="/docs/compute/concepts/preemptible-vm">Preemptible Virtual Machines</a>.</p> 
nodeGroups[].<br>scalePolicy | **object**<br><p>Scale policy of the node group.  For more information, see <a href="/docs/compute/concepts/instance-groups/policies#scale-policy">Scaling policy</a>.</p> 
nodeGroups[].<br>scalePolicy.<br>fixedScale | **object**<br>Fixed scale policy of the node group.<br>
nodeGroups[].<br>scalePolicy.<br>fixedScale.<br>size | **string** (int64)<br><p>Number of nodes in the node group.</p> <p>The minimum value is 1.</p> 
nodeGroups[].<br>allocationPolicy | **object**<br><p>Allocation policy by which resources for node group are allocated to zones and regions.</p> 
nodeGroups[].<br>allocationPolicy.<br>locations[] | **object**<br><p>List of locations where resources for the node group will be allocated.</p> 
nodeGroups[].<br>allocationPolicy.<br>locations[].<br>zoneId | **string**<br><p>Required. ID of the availability zone where the nodes may reside.</p> 
nodeGroups[].<br>allocationPolicy.<br>locations[].<br>subnetId | **string**<br><p>ID of the subnet. If a network chosen for the Kubernetes cluster has only one subnet in the specified zone, subnet ID may be omitted.</p> 
nodeGroups[].<br>instanceGroupId | **string**<br><p>ID of the managed instance group associated with this node group.</p> 
nodeGroups[].<br>nodeVersion | **string**<br><p>Version of Kubernetes components that runs on the nodes.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-kubernetes/api-ref/Cluster/listNodeGroups#query_params">pageSize</a>, use the <a href="/docs/managed-kubernetes/api-ref/Cluster/listNodeGroups#responses">nextPageToken</a> as the value for the <a href="/docs/managed-kubernetes/api-ref/Cluster/listNodeGroups#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-kubernetes/api-ref/Cluster/listNodeGroups#responses">nextPageToken</a> to continue paging through the results.</p> 