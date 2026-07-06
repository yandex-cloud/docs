[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Kubernetes](../index.md) > Инструменты Application Load Balancer > Gwin > Конфигурация ресурсов (англ.) > BackendTLSPolicy

# BackendTLSPolicy

BackendTLSPolicy configures TLS encryption for connections between the load balancer and backend services. It allows you to specify the CA certificate used to verify the backend's TLS certificate and the SNI hostname sent during the TLS handshake.

BackendTLSPolicy is a [Kubernetes Gateway API](https://gateway-api.sigs.k8s.io/) project resource. Below, we describe its fields used by Gwin. For configuration details, see the [upstream documentation](https://gateway-api.sigs.k8s.io/reference/spec/#gateway.networking.k8s.io/v1alpha3.BackendTLSPolicy).

BackendTLSPolicy resources must be in the same namespace as the Service they target.

* [Cheatsheet](#cheatsheet)
* [Gwin-specific constraints](#gwin-specific-constraints)
* [BackendTLSPolicySpec](#backendtlspolicyspec)
  * [LocalPolicyTargetReferenceWithSectionName](#localpolicytargetreferencewithsectionname)
  * [BackendTLSPolicyValidation](#backendtlspolicyvalidation)
  * [LocalObjectReference](#localobjectreference)
* [Example](#example)

## Cheatsheet

{% note info %}

Specification provided below is not valid configuration.

It's just demonstration of all `BackendTLSPolicy` fields.

{% endnote %}

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: BackendTLSPolicy
metadata:
  name: my-backend-tls-policy
  namespace: my-ns  # must match the namespace of the target Service
spec:
  targetRefs:
    - group: ""          # must be empty string for Service
      kind: Service
      name: my-service
      sectionName: https  # optional: target a specific named port of the Service
  validation:
    hostname: "my-backend.example.com"  # SNI hostname sent during TLS handshake
    caCertificateRefs: # Either none or one reference may be provided
      # Option 1: Kubernetes Secret containing the CA certificate
      - group: ""        # must be empty string for Secret
        kind: Secret
        name: my-ca-secret  # Secret must have a "ca.crt" key with PEM-encoded CA cert

      # Option 2: YCCertificate referencing a Yandex Cloud Certificate Manager certificate
      - group: gwin.yandex.cloud
        kind: YCCertificate
        name: my-yc-certificate  # YCCertificate must have an explicit certificateID
```

| Field | Description |
|-------|-------------|
| metadata | **ObjectMeta** <br> Standard Kubernetes metadata. |
| spec | **[BackendTLSPolicySpec](#backendtlspolicyspec)** <br> Policy specification. |

## Gwin-specific constraints

Gwin enforces the following constraints on BackendTLSPolicy:

- Only `Service` (with empty group `""`) is supported as a `targetRef` kind.
- Either none or one `caCertificateRef` must be provided. Multiple refs are not supported.
- When referencing a `Secret`, it must contain a `ca.crt` key with a PEM-encoded CA certificate.
- When referencing a `YCCertificate`, it must have an explicit `certificateID` set. Name-based lookup is not supported for BackendTLSPolicy.
- Each Service + `sectionName` combination must be targeted by **at most one** BackendTLSPolicy. If two policies conflict, the older one (by creation timestamp) wins; ties are broken alphabetically by `namespace/name`.
- BackendTLSPolicy takes precedence over any other TLS configuration (annotations or policies) on the route for the same backend port.

## BackendTLSPolicySpec

BackendTLSPolicySpec defines the desired state of BackendTLSPolicy.

*Appears in*: [BackendTLSPolicy](#backendtlspolicy)

| Field | Description |
|-------|-------------|
| targetRefs | **[[]LocalPolicyTargetReferenceWithSectionName](#localpolicytargetreferencewithsectionname)** <br> References to the Services this policy applies to. Only `Service` (with empty group) is supported. |
| validation | **[BackendTLSPolicyValidation](#backendtlspolicyvalidation)** <br> TLS validation configuration for connections to the target backends. |

### LocalPolicyTargetReferenceWithSectionName

LocalPolicyTargetReferenceWithSectionName identifies a Service (and optionally a specific named port) that this policy targets.

*Appears in*: [BackendTLSPolicySpec](#backendtlspolicyspec)

| Field | Description |
|-------|-------------|
| group | **string** <br> API group of the target resource. Must be an empty string `""` for Kubernetes Services. |
| kind | **string** <br> Kind of the target resource. Must be `Service`. |
| name | **string** <br> Name of the target Service. Must be in the same namespace as the BackendTLSPolicy. |
| sectionName | **string** <br> Optional. Name of a specific port on the target Service. When set, TLS is applied only to backends using that named port. When omitted, TLS is applied to all ports of the Service. <br> Example: `https` |

### BackendTLSPolicyValidation

BackendTLSPolicyValidation defines the TLS parameters used when connecting to the backend.

*Appears in*: [BackendTLSPolicySpec](#backendtlspolicyspec)

| Field | Description |
|-------|-------------|
| hostname | **string** <br> Server Name Indication (SNI) value sent during the TLS handshake. The load balancer also uses this hostname to verify the backend's certificate. <br> Example: `my-backend.example.com` |
| caCertificateRefs | **[[]LocalObjectReference](#localobjectreference)** <br> References to the CA certificates used to verify the backend's TLS certificate. Either none or one reference must be provided. If empty, backend certificate is not validated. Supported kinds: `Secret` (group `""`) and `YCCertificate` (group `gwin.yandex.cloud`). |

### LocalObjectReference

LocalObjectReference identifies a CA certificate resource in the same namespace as the BackendTLSPolicy.

*Appears in*: [BackendTLSPolicyValidation](#backendtlspolicyvalidation)

| Field | Description |
|-------|-------------|
| group | **string** <br> API group of the certificate resource. Use `""` for a Kubernetes Secret, or `gwin.yandex.cloud` for a [YCCertificate](yccertificate.md). |
| kind | **string** <br> Kind of the certificate resource. Use `Secret` for a Kubernetes Secret, or `YCCertificate` for a Yandex Cloud certificate reference. |
| name | **string** <br> Name of the certificate resource. <br> Example: `my-ca-secret` |

## Example

The following example shows how to configure TLS between the load balancer and a backend service using a CA certificate stored in a Kubernetes Secret.

```yaml
# Secret containing the CA certificate that signed the backend's TLS certificate
apiVersion: v1
kind: Secret
metadata:
  name: foxes-ca
  namespace: foxes-ns
type: Opaque
data:
  ca.crt: <base64-encoded PEM CA certificate>
---
# Service exposing both plain HTTP and HTTPS ports
apiVersion: v1
kind: Service
metadata:
  name: foxes-service
  namespace: foxes-ns
spec:
  type: NodePort
  selector:
    app: foxes-app
  ports:
    - name: http
      port: 8080
    - name: https
      port: 8443
---
# BackendTLSPolicy targets only the "https" named port
apiVersion: gateway.networking.k8s.io/v1
kind: BackendTLSPolicy
metadata:
  name: foxes-backend-tls-policy
  namespace: foxes-ns
spec:
  targetRefs:
    - group: ""
      kind: Service
      name: foxes-service
      sectionName: https  # apply TLS only to the "https" port
  validation:
    hostname: "foxes-backend.zoo.com"
    caCertificateRefs:
      - group: ""
        kind: Secret
        name: foxes-ca
---
# HTTPRoute — the /tls path routes to the HTTPS port; TLS is applied via BackendTLSPolicy
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: foxes-tls-route
  namespace: foxes-ns
spec:
  hostnames:
    - "foxes.zoo.com"
  parentRefs:
    - name: my-gateway
      namespace: default
  rules:
    - matches:
        - path:
            value: /tls
      backendRefs:
        - name: foxes-service
          port: 8443
```