---
editable: false
---

# Compute Cloud API, REST: GpuCluster.get
Returns the specified GPU cluster.
 
To get the list of available GPU clusters, make a [list](/docs/compute/api-ref/GpuCluster/list) request.
 
## HTTP request {#https-request}
```
GET https://compute.{{ api-host }}/compute/v1/gpuClusters/{gpuClusterId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
gpuClusterId | <p>ID of the GPU cluster to return.</p> <p>To get a GPU cluster ID, make a <a href="/docs/compute/api-ref/GpuCluster/list">list</a> request.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "status": "string",
  "zoneId": "string",
  "interconnectType": "string"
}
```
A GPU cluster. For details about the concept, see [documentation](/docs/compute/concepts/gpu-cluster).
 
Field | Description
--- | ---
id | **string**<br><p>ID of GPU cluster.</p> 
folderId | **string**<br><p>ID of the folder that the GPU cluster belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the GPU cluster.</p> <p>The name is unique within the folder.</p> 
description | **string**<br><p>Description of the GPU cluster.</p> 
labels | **object**<br><p>GPU cluster labels as ``key:value`` pairs.</p> 
status | **string**<br><p>Status of the GPU cluster.</p> <ul> <li>CREATING: GPU cluster is being created.</li> <li>READY: GPU cluster is ready to use.</li> <li>ERROR: GPU cluster encountered a problem and cannot operate.</li> <li>DELETING: GPU cluster is being deleted.</li> </ul> 
zoneId | **string**<br><p>ID of the availability zone where the GPU cluster resides.</p> 
interconnectType | **string**<br><p>Type of interconnect used for this GPU cluster.</p> <ul> <li>INFINIBAND: InfiniBand interconnect.</li> </ul> 