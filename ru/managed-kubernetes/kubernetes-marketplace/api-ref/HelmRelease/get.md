---
editable: false
sourcePath: en/_api-ref/k8s/marketplace/v1/kubernetes-marketplace/api-ref/HelmRelease/get.md
---

# Kubernetes Marketplace, REST: HelmRelease.get
Returns the specified Helm release.
 

 
## HTTP request {#https-request}
```
GET https://mks.{{ api-host }}/managed-kubernetes/marketplace/v1/helm-releases/{id}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
id | <p>Required. The ID of the Helm release to retrieve.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
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
```
A Helm Release.
 
Field | Description
--- | ---
id | **string**<br><p>ID of a helm release.</p> 
clusterId | **string**<br><p>ID of the Kubernetes cluster.</p> 
appName | **string**<br><p>Name of the application.</p> 
appNamespace | **string**<br><p>Namespace of the application.</p> 
productId | **string**<br><p>Kubernetes marketplace product id.</p> 
productName | **string**<br><p>Kubernetes marketplace product name.</p> 
productVersion | **string**<br><p>Kubernetes marketplace product version.</p> 
status | **string**<br><p>Status of a helm release.</p> <ul> <li>UNKNOWN: Helm release status is unknown</li> <li>DEPLOYED: Helm release deployed.</li> <li>UNINSTALLED: Helm release uninstalled.</li> <li>SUPERSEDED: Helm release superseded.</li> <li>FAILED: Helm release installation failed.</li> <li>UNINSTALLING: Helm release is being uninstalled.</li> <li>PENDING_INSTALL: Helm release is to be installed.</li> <li>PENDING_UPGRADE: Helm release is to be updated.</li> <li>PENDING_ROLLBACK: Helm release is to be rolled back.</li> </ul> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 