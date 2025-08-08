---
editable: false
apiPlayground:
  - url: https://mks.{{ api-host }}/managed-kubernetes/marketplace/v1/helm-releases/{id}
    method: get
    path:
      type: object
      properties:
        id:
          description: |-
            **string**
            Required field. The ID of the Helm release to retrieve.
          type: string
      required:
        - id
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/k8s/marketplace/v1/kubernetes-marketplace/api-ref/HelmRelease/get.md
---

# Kubernetes Marketplace, REST: HelmRelease.Get

Returns the specified Helm release.

## HTTP request

```
GET https://mks.{{ api-host }}/managed-kubernetes/marketplace/v1/helm-releases/{id}
```

## Path parameters

#|
||Field | Description ||
|| id | **string**

Required field. The ID of the Helm release to retrieve. ||
|#

## Response {#yandex.cloud.k8s.marketplace.v1.HelmRelease}

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

#|
||Field | Description ||
|| id | **string**

ID of a helm release. ||
|| clusterId | **string**

ID of the Kubernetes cluster. ||
|| appName | **string**

Name of the application. ||
|| appNamespace | **string**

Namespace of the application. ||
|| productId | **string**

Kubernetes marketplace product id. ||
|| productName | **string**

Kubernetes marketplace product name. ||
|| productVersion | **string**

Kubernetes marketplace product version. ||
|| status | **enum** (Status)

Status of a helm release.

- `STATUS_UNSPECIFIED`
- `UNKNOWN`: Helm release status is unknown
- `DEPLOYED`: Helm release deployed.
- `UNINSTALLED`: Helm release uninstalled.
- `SUPERSEDED`: Helm release superseded.
- `FAILED`: Helm release installation failed.
- `UNINSTALLING`: Helm release is being uninstalled.
- `PENDING_INSTALL`: Helm release is to be installed.
- `PENDING_UPGRADE`: Helm release is to be updated.
- `PENDING_ROLLBACK`: Helm release is to be rolled back. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#