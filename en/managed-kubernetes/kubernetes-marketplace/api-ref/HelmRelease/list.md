---
editable: false
sourcePath: en/_api-ref/k8s/marketplace/v1/kubernetes-marketplace/api-ref/HelmRelease/list.md
---

# Kubernetes Marketplace, REST: HelmRelease.list
Retrieves the list of Helm releases in the specified Kubernetes Cluster.
 

 
## HTTP request {#https-request}
```
GET https://mks.{{ api-host }}/managed-kubernetes/marketplace/v1/helm-releases
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. The ID of the Kubernetes cluster to list Helm releases from.</p> 
pageSize | <p>The maximum number of results per page that should be returned.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Token for pagination to retrieve the next page of results.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "helmReleases": [
    {
      "id": "string",
      "clusterId": "string",
      "appName": "string",
      "appNamespace": "string",
      "productId": "string",
      "productName": "string",
      "productVersion": "string",
      "status": "string",
      "createdAt": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
helmReleases[] | **object**<br><p>List of Helm releases in the Kubernetes cluster.</p> 
helmReleases[].<br>id | **string**<br><p>ID of a helm release.</p> 
helmReleases[].<br>clusterId | **string**<br><p>ID of the Kubernetes cluster.</p> 
helmReleases[].<br>appName | **string**<br><p>Name of the application.</p> 
helmReleases[].<br>appNamespace | **string**<br><p>Namespace of the application.</p> 
helmReleases[].<br>productId | **string**<br><p>Kubernetes marketplace product id.</p> 
helmReleases[].<br>productName | **string**<br><p>Kubernetes marketplace product name.</p> 
helmReleases[].<br>productVersion | **string**<br><p>Kubernetes marketplace product version.</p> 
helmReleases[].<br>status | **string**<br><p>Status of a helm release.</p> <ul> <li>UNKNOWN: Helm release status is unknown</li> <li>DEPLOYED: Helm release deployed.</li> <li>UNINSTALLED: Helm release uninstalled.</li> <li>SUPERSEDED: Helm release superseded.</li> <li>FAILED: Helm release installation failed.</li> <li>UNINSTALLING: Helm release is being uninstalled.</li> <li>PENDING_INSTALL: Helm release is to be installed.</li> <li>PENDING_UPGRADE: Helm release is to be updated.</li> <li>PENDING_ROLLBACK: Helm release is to be rolled back.</li> </ul> 
helmReleases[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
nextPageToken | **string**<br><p>Token for retrieving the next page of Helm releases.</p> 