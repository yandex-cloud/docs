---
editable: false
---

# Method list
Retrieves the list of Kubernetes cluster in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://mks.api.cloud.yandex.net/managed-kubernetes/v1/clusters
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder to list Kubernetes cluster in. To get the folder ID use a [list](/docs/resource-manager/api-ref/Folder/list) request.
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/managed-kubernetes/api-ref/Cluster/list#query_params), the service returns a [nextPageToken](/docs/managed-kubernetes/api-ref/Cluster/list#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/managed-kubernetes/api-ref/Cluster/list#query_params) to the [nextPageToken](/docs/managed-kubernetes/api-ref/Cluster/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters resources listed in the response. The expression must specify: 1. The field name. Currently you can use filtering only on [Cluster.name](/docs/managed-kubernetes/api-ref/Cluster#representation) field. 2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. The value. Must be 1-61 characters long and match the regular expression `|[a-z][-a-z0-9]{1,61}[a-z0-9]`.  The maximum string length in characters is 1000.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "clusters": [
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
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
clusters[] | **object**<br><p>A Kubernetes cluster.</p> 
clusters[].<br>id | **string**<br><p>ID of the Kubernetes cluster.</p> 
clusters[].<br>folderId | **string**<br><p>ID of the folder that the Kubernetes cluster belongs to.</p> 
clusters[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
clusters[].<br>name | **string**<br><p>Name of the Kubernetes cluster.</p> 
clusters[].<br>description | **string**<br><p>Description of the Kubernetes cluster. 0-256 characters long.</p> 
clusters[].<br>labels | **object**<br><p>Resource labels as <code>key:value</code> pairs. Мaximum of 64 per resource.</p> 
clusters[].<br>status | **string**<br>Status of the Kubernetes cluster.<br><ul> <li>PROVISIONING: Kubernetes cluster is waiting for resources to be allocated.</li> <li>RUNNING: Kubernetes cluster is running.</li> <li>RECONCILING: Kubernetes cluster is being reconciled.</li> <li>STOPPING: Kubernetes cluster is being stopped.</li> <li>STOPPED: Kubernetes cluster stopped.</li> <li>DELETING: Kubernetes cluster is being deleted.</li> </ul> 
clusters[].<br>health | **string**<br>Health of the Kubernetes cluster.<br><ul> <li>HEALTHY: Kubernetes cluster is alive and well.</li> <li>UNHEALTHY: Kubernetes cluster is inoperable.</li> </ul> 
clusters[].<br>networkId | **string**<br><p>ID of the network the Kubernetes cluster belongs to.</p> 
clusters[].<br>master | **object**<br>Properties of the master for the Kubernetes cluster.<br>
clusters[].<br>master.<br>version | **string**<br><p>Version of Kubernetes components that runs on the master.</p> 
clusters[].<br>master.<br>endpoints | **object**<br>Endpoints of the master. Endpoints constitute of scheme and port (i.e. `https://ip-address:port`) and can be used by the clients to communicate with the Kubernetes API of the Kubernetes cluster.<br>
clusters[].<br>master.<br>endpoints.<br>internalV4Endpoint | **string**<br><p>Internal endpoint that can be used to connect to the master from cloud networks.</p> 
clusters[].<br>master.<br>endpoints.<br>externalV4Endpoint | **string**<br><p>External endpoint that can be used to access Kubernetes cluster API from the internet (outside of the cloud).</p> 
clusters[].<br>master.<br>masterAuth | **object**<br>Master authentication parameters are used to establish trust between the master and a client.<br>
clusters[].<br>master.<br>masterAuth.<br>clusterCaCertificate | **string**<br><p>PEM-encoded public certificate that is the root of trust for the Kubernetes cluster.</p> 
clusters[].<br>master.<br>zonalMaster | **object**<br>Parameters of the availability zone for the master.<br>
clusters[].<br>master.<br>zonalMaster.<br>zoneId | **string**<br><p>ID of the availability zone where the master resides.</p> 
clusters[].<br>master.<br>zonalMaster.<br>internalV4Address | **string**<br><p>An IPv4 internal network address that is assigned to the master.</p> 
clusters[].<br>master.<br>zonalMaster.<br>externalV4Address | **string**<br><p>An IPv4 external network address that is assigned to the master.</p> 
clusters[].<br>ipAllocationPolicy | **object**<br>Allocation policy for IP addresses of services and pods inside the Kubernetes cluster in different availability zones.<br>
clusters[].<br>ipAllocationPolicy.<br>clusterIpv4CidrBlock | **string**<br><p>CIDR block. IP range for allocating pod addresses.</p> <p>It should not overlap with any subnet in the network the Kubernetes cluster located in. Static routes will be set up for this CIDR blocks in node subnets.</p> 
clusters[].<br>ipAllocationPolicy.<br>serviceIpv4CidrBlock | **string**<br><p>CIDR block. IP range Kubernetes service Kubernetes cluster IP addresses will be allocated from.</p> <p>It should not overlap with any subnet in the network the Kubernetes cluster located in.</p> 
clusters[].<br>serviceAccountId | **string**<br><p>Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster.</p> 
clusters[].<br>nodeServiceAccountId | **string**<br><p>Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics.</p> 
clusters[].<br>gatewayIpv4Address | **string**<br><p>Gateway IPv4 address.</p> <p>The maximum string length in characters is 15.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-kubernetes/api-ref/Cluster/list#query_params">pageSize</a>, use the <a href="/docs/managed-kubernetes/api-ref/Cluster/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-kubernetes/api-ref/Cluster/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-kubernetes/api-ref/Cluster/list#responses">nextPageToken</a> to continue paging through the results.</p> 