---
editable: false
apiPlayground:
  - url: https://mks.{{ api-host }}/managed-kubernetes/marketplace/v1/helm-releases:install
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. The ID of the Kubernetes cluster where the Helm release is to be installed.
          type: string
        productVersionId:
          description: |-
            **string**
            The product version ID to install.
          type: string
        userValues:
          description: |-
            **[ValueWithKey](/docs/managed-kubernetes/kubernetes-marketplace/api-ref/HelmRelease/install#yandex.cloud.k8s.marketplace.v1.ValueWithKey)**
            User-defined values for the Helm chart during installation.
          type: array
          items:
            $ref: '#/definitions/ValueWithKey'
      required:
        - clusterId
      additionalProperties: false
    definitions:
      ValueWithKey:
        type: object
        properties:
          key:
            description: |-
              **string**
              Required field. The key associated with the value.
            type: string
          value:
            description: |-
              **[Value](/docs/managed-kubernetes/kubernetes-marketplace/api-ref/HelmRelease/install#yandex.cloud.k8s.marketplace.v1.Value)**
              The value associated with the key.
            oneOf:
              - type: object
                properties:
                  typedValue:
                    description: |-
                      **string**
                      The typed string value.
                      Includes only one of the fields `typedValue`.
                    type: string
        required:
          - key
sourcePath: en/_api-ref/k8s/marketplace/v1/kubernetes-marketplace/api-ref/HelmRelease/install.md
---

# Kubernetes Marketplace, REST: HelmRelease.Install

Installs helm release into specified Kubernetes Cluster.

## HTTP request

```
POST https://mks.{{ api-host }}/managed-kubernetes/marketplace/v1/helm-releases:install
```

## Body parameters {#yandex.cloud.k8s.marketplace.v1.InstallHelmReleaseRequest}

```json
{
  "clusterId": "string",
  "productVersionId": "string",
  "userValues": [
    {
      "key": "string",
      "value": {
        // Includes only one of the fields `typedValue`
        "typedValue": "string"
        // end of the list of possible fields
      }
    }
  ]
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. The ID of the Kubernetes cluster where the Helm release is to be installed. ||
|| productVersionId | **string**

The product version ID to install. ||
|| userValues[] | **[ValueWithKey](#yandex.cloud.k8s.marketplace.v1.ValueWithKey)**

User-defined values for the Helm chart during installation. ||
|#

## ValueWithKey {#yandex.cloud.k8s.marketplace.v1.ValueWithKey}

#|
||Field | Description ||
|| key | **string**

Required field. The key associated with the value. ||
|| value | **[Value](#yandex.cloud.k8s.marketplace.v1.Value)**

The value associated with the key. ||
|#

## Value {#yandex.cloud.k8s.marketplace.v1.Value}

#|
||Field | Description ||
|| typedValue | **string**

The typed string value.

Includes only one of the fields `typedValue`. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "clusterId": "string",
    "helmReleaseId": "string",
    "productVersionId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
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
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[InstallHelmReleaseMetadata](#yandex.cloud.k8s.marketplace.v1.InstallHelmReleaseMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[HelmRelease](#yandex.cloud.k8s.marketplace.v1.HelmRelease)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## InstallHelmReleaseMetadata {#yandex.cloud.k8s.marketplace.v1.InstallHelmReleaseMetadata}

#|
||Field | Description ||
|| clusterId | **string**

The ID of the Kubernetes cluster where the Helm release is being installed. ||
|| helmReleaseId | **string**

The ID of the Helm release being installed. ||
|| productVersionId | **string**

The ID of the product version being deployed. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## HelmRelease {#yandex.cloud.k8s.marketplace.v1.HelmRelease}

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