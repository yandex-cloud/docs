---
editable: false
---

# Cluster
A set of methods for managing Kubernetes cluster.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "status": "string",
  "health": "string",
  "networkId": "string",
  "master": {
    "version": "string",
    "endpoints": {
      "internalV4Endpoint": "string",
      "externalV4Endpoint": "string"
    },
    "masterAuth": {
      "clusterCaCertificate": "string"
    },
    "zonalMaster": {
      "zoneId": "string",
      "internalV4Address": "string",
      "externalV4Address": "string"
    }
  },
  "ipAllocationPolicy": {
    "clusterIpv4CidrBlock": "string",
    "serviceIpv4CidrBlock": "string"
  },
  "serviceAccountId": "string",
  "nodeServiceAccountId": "string",
  "gatewayIpv4Address": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the Kubernetes cluster.</p> 
folderId | **string**<br><p>ID of the folder that the Kubernetes cluster belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the Kubernetes cluster.</p> 
description | **string**<br><p>Description of the Kubernetes cluster. 0-256 characters long.</p> 
labels | **object**<br><p>Resource labels as <code>key:value</code> pairs. Мaximum of 64 per resource.</p> 
status | **string**<br>Status of the Kubernetes cluster.<br><ul> <li>PROVISIONING: Kubernetes cluster is waiting for resources to be allocated.</li> <li>RUNNING: Kubernetes cluster is running.</li> <li>RECONCILING: Kubernetes cluster is being reconciled.</li> <li>STOPPING: Kubernetes cluster is being stopped.</li> <li>STOPPED: Kubernetes cluster stopped.</li> <li>DELETING: Kubernetes cluster is being deleted.</li> </ul> 
health | **string**<br>Health of the Kubernetes cluster.<br><ul> <li>HEALTHY: Kubernetes cluster is alive and well.</li> <li>UNHEALTHY: Kubernetes cluster is inoperable.</li> </ul> 
networkId | **string**<br><p>ID of the network the Kubernetes cluster belongs to.</p> 
master | **object**<br>
master.<br>version | **string**<br><p>Version of Kubernetes components that runs on the master.</p> 
master.<br>endpoints | **object**<br>
master.<br>endpoints.<br>internalV4Endpoint | **string**<br><p>Internal endpoint that can be used to connect to the master from cloud networks.</p> 
master.<br>endpoints.<br>externalV4Endpoint | **string**<br><p>External endpoint that can be used to access Kubernetes cluster API from the internet (outside of the cloud).</p> 
master.<br>masterAuth | **object**<br>
master.<br>masterAuth.<br>clusterCaCertificate | **string**<br><p>PEM-encoded public certificate that is the root of trust for the Kubernetes cluster.</p> 
master.<br>zonalMaster | **object**<br>
master.<br>zonalMaster.<br>zoneId | **string**<br><p>ID of the availability zone where the master resides.</p> 
master.<br>zonalMaster.<br>internalV4Address | **string**<br><p>An IPv4 internal network address that is assigned to the master.</p> 
master.<br>zonalMaster.<br>externalV4Address | **string**<br><p>An IPv4 external network address that is assigned to the master.</p> 
ipAllocationPolicy | **object**<br>
ipAllocationPolicy.<br>clusterIpv4CidrBlock | **string**<br><p>CIDR block. IP range for allocating pod addresses.</p> <p>It should not overlap with any subnet in the network the Kubernetes cluster located in. Static routes will be set up for this CIDR blocks in node subnets.</p> 
ipAllocationPolicy.<br>serviceIpv4CidrBlock | **string**<br><p>CIDR block. IP range Kubernetes service Kubernetes cluster IP addresses will be allocated from.</p> <p>It should not overlap with any subnet in the network the Kubernetes cluster located in.</p> 
serviceAccountId | **string**<br><p>Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster.</p> 
nodeServiceAccountId | **string**<br><p>Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics.</p> 
gatewayIpv4Address | **string**<br><p>Gateway IPv4 address.</p> <p>The maximum string length in characters is 15.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a Kubernetes cluster in the specified folder.
[delete](delete.md) | Deletes the specified Kubernetes cluster.
[get](get.md) | Returns the specified Kubernetes cluster.
[list](list.md) | Retrieves the list of Kubernetes cluster in the specified folder.
[listNodeGroups](listNodeGroups.md) | Lists nodegroup for the specified Kubernetes cluster.
[listOperations](listOperations.md) | Lists operations for the specified Kubernetes cluster.
[update](update.md) | Updates the specified Kubernetes cluster.