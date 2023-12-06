---
editable: false
sourcePath: en/_api-ref/k8s/v1/api-ref/Cluster/listNodes.md
---

# Managed Services for Kubernetes API, REST: Cluster.listNodes
Lists cluster's nodes.
 

 
## HTTP request {#https-request}
```
GET https://mks.{{ api-host }}/managed-kubernetes/v1/clusters/{clusterId}/nodes
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the Kubernetes cluster to list nodes in. To get the Kubernetes cluster ID use a <a href="/docs/managed-kubernetes/api-ref/Cluster/list">list</a> request.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/managed-kubernetes/api-ref/Cluster/listNodes#query_params">pageSize</a>, the service returns a <a href="/docs/managed-kubernetes/api-ref/Cluster/listNodes#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the <a href="/docs/managed-kubernetes/api-ref/Cluster/listNodeGroups#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "nodes": [
    {
      "status": "string",
      "spec": {
        "resources": {
          "memory": "string",
          "cores": "string",
          "coreFraction": "string",
          "gpus": "string"
        },
        "disk": {
          "diskTypeId": "string",
          "diskSize": "string"
        }
      },
      "cloudStatus": {
        "id": "string",
        "status": "string",
        "statusMessage": "string"
      },
      "kubernetesStatus": {
        "id": "string",
        "conditions": [
          {
            "type": "string",
            "status": "string",
            "message": "string",
            "lastHeartbeatTime": "string",
            "lastTransitionTime": "string"
          }
        ],
        "taints": [
          {
            "key": "string",
            "value": "string",
            "effect": "string"
          }
        ],
        "attachedVolumes": [
          {
            "driverName": "string",
            "volumeHandle": "string"
          }
        ]
      }
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
nodes[] | **object**<br><p>List of nodes for the specified Kubernetes cluster.</p> 
nodes[].<br>status | **string**<br><p>Computed node status.</p> <p>Computed node status.</p> <ul> <li>PROVISIONING: Node instance is not yet created (e.g. in progress).</li> <li>NOT_CONNECTED: Node instance is created but not registered (e.g. is still initializing).</li> <li>NOT_READY: Node has connected but is not ready for workload (see conditions for details).</li> <li>READY: Node has connected and ready for workload.</li> <li>MISSING: Node is still registered but its instance is deleted (this is our bug).</li> <li>STOPPED: Node is stopped</li> <li>UNKNOWN: Backend request to kubernetes api was unsuccessful.</li> </ul> 
nodes[].<br>spec | **object**<br><p>Node specificaion.</p> <p>Node specification.</p> 
nodes[].<br>spec.<br>resources | **object**<br><p>Node group specified resources.</p> 
nodes[].<br>spec.<br>resources.<br>memory | **string** (int64)<br><p>Amount of memory available to the node, specified in bytes.</p> <p>The minimum value is 0.</p> 
nodes[].<br>spec.<br>resources.<br>cores | **string** (int64)<br><p>Number of cores available to the node.</p> <p>The minimum value is 0.</p> 
nodes[].<br>spec.<br>resources.<br>coreFraction | **string** (int64)<br><p>Baseline level of CPU performance with the possibility to burst performance above that baseline level. This field sets baseline performance for each core.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
nodes[].<br>spec.<br>resources.<br>gpus | **string** (int64)<br><p>Number of GPUs available to the node.</p> <p>The minimum value is 0.</p> 
nodes[].<br>spec.<br>disk | **object**<br><p>Node group specified disk.</p> 
nodes[].<br>spec.<br>disk.<br>diskTypeId | **string**<br><p>ID of the disk type.</p> <p>Value must match the regular expression ``\|network-ssd\|network-hdd\|network-ssd-nonreplicated\|network-ssd-io-m3``.</p> 
nodes[].<br>spec.<br>disk.<br>diskSize | **string** (int64)<br><p>Size of the disk, specified in bytes.</p> <p>Acceptable values are 0 to 4398046511104, inclusive.</p> 
nodes[].<br>cloudStatus | **object**<br><p>Cloud instance status. Not available in ``MISSING`` status.</p> <p>Cloud instance info</p> 
nodes[].<br>cloudStatus.<br>id | **string**<br><p>Compute instance id</p> 
nodes[].<br>cloudStatus.<br>status | **string**<br><p>IG instance status</p> 
nodes[].<br>cloudStatus.<br>statusMessage | **string**<br><p>IG instance status message</p> 
nodes[].<br>kubernetesStatus | **object**<br><p>Kubernetes node status. Not available in ``PROVISIONING`` and ``NOT_CONNECTED`` states.</p> <p>Kubernetes node info</p> 
nodes[].<br>kubernetesStatus.<br>id | **string**<br><p>Node id (and instance name)</p> 
nodes[].<br>kubernetesStatus.<br>conditions[] | **object**<br><p>Conditions is an array of current observed node conditions. More info: https://kubernetes.io/docs/concepts/nodes/node/#condition</p> 
nodes[].<br>kubernetesStatus.<br>conditions[].<br>type | **string**<br><p>Type of node condition.</p> 
nodes[].<br>kubernetesStatus.<br>conditions[].<br>status | **string**<br><p>Status is the status of the condition.</p> 
nodes[].<br>kubernetesStatus.<br>conditions[].<br>message | **string**<br><p>Human-readable message indicating details about last transition.</p> 
nodes[].<br>kubernetesStatus.<br>conditions[].<br>lastHeartbeatTime | **string** (date-time)<br><p>Last time we got an update on a given condition.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
nodes[].<br>kubernetesStatus.<br>conditions[].<br>lastTransitionTime | **string** (date-time)<br><p>Last time the condition transit from one status to another.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
nodes[].<br>kubernetesStatus.<br>taints[] | **object**<br><p>If specified, the node's taints.</p> 
nodes[].<br>kubernetesStatus.<br>taints[].<br>key | **string**<br><p>The taint key to be applied to a node.</p> 
nodes[].<br>kubernetesStatus.<br>taints[].<br>value | **string**<br><p>The taint value corresponding to the taint key.</p> 
nodes[].<br>kubernetesStatus.<br>taints[].<br>effect | **string**<br><p>The effect of the taint on pods that do not tolerate the taint.</p> <ul> <li>NO_SCHEDULE: Do not allow new pods to schedule onto the node unless they tolerate the taint, but allow all pods submitted to Kubelet without going through the scheduler to start, and allow all already-running pods to continue running.</li> <li>PREFER_NO_SCHEDULE: Like NO_SCHEDULE, but the scheduler tries not to schedule new pods onto the node, rather than prohibiting new pods from scheduling onto the node entirely. Enforced by the scheduler.</li> <li>NO_EXECUTE: Evict any already-running pods that do not tolerate the taint.</li> </ul> 
nodes[].<br>kubernetesStatus.<br>attachedVolumes[] | **object**<br><p>List of volumes that are attached to the node.</p> 
nodes[].<br>kubernetesStatus.<br>attachedVolumes[].<br>driverName | **string**<br><p>Name of the driver which has attached the volume</p> 
nodes[].<br>kubernetesStatus.<br>attachedVolumes[].<br>volumeHandle | **string**<br><p>Volume handle (cloud disk id)</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-kubernetes/api-ref/Cluster/listNodes#query_params">pageSize</a>, use the ``next_page_token`` as the value for the <a href="/docs/managed-kubernetes/api-ref/Cluster/listNodes#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own ``next_page_token`` to continue paging through the results.</p> 