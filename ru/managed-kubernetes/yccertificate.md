---
sourcePath: en/_gwin-ref/yccertificate.md
---
# YCCertificate

YCCertificate is a Gwin custom resource for referencing TLS certificates from Yandex Certificate Manager. It allows you to use certificates managed by Yandex Cloud in your Gateway and Ingress resources for TLS termination.

* [Cheatsheet](#cheatsheet)
* [YCCertificateSpec](#yccertificatespec)
  * [YCCertificateReference](#yccertificatereference)

## Cheatsheet

{% note info %}

Specification provided below is not valid configuration.

It's just demonstration of all `YCCertificate` fields.

{% endnote %}

```yaml
apiVersion: gwin.yandex.cloud/v1
kind: YCCertificate
metadata:
  name: example-certificate
  namespace: example-ns
spec:
  certificateRef:
    # Option 1: Reference by certificate ID
    certificateID: "fpq6gvvm6piu********"
    
    # Option 2: Reference by certificate name and folder ID
    certificateName: "my-certificate"
    folderID: "b1g0itj57rbj********"
    
    # Option 3: Reference by certificate name only (uses controller's folder)
    certificateName: "my-certificate"
```

Reference the YCCertificate in a Gateway resource:

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: example-gateway
spec:
  gatewayClassName: gwin-default
  listeners:
    - name: https
      protocol: HTTPS
      port: 443
      tls:
        mode: Terminate
        certificateRefs:
          - group: gwin.yandex.cloud
            kind: YCCertificate
            name: example-certificate
            namespace: example-ns
```

| Field | Description |
|-------|-------------|
| metadata | **ObjectMeta** <br> Standard Kubernetes metadata. |
| spec | **[YCCertificateSpec](#yccertificatespec)** <br> Certificate specification. |

## YCCertificateSpec

YCCertificateSpec defines the desired state of YCCertificate.

*Appears in*: [YCCertificate](#yccertificate)

| Field | Description |
|-------|-------------|
| certificateRef | **[YCCertificateReference](#yccertificatereference)** <br> Reference to the Yandex Cloud Certificate Manager certificate. |

### YCCertificateReference

YCCertificateReference is a reference to a Yandex Certificate Manager certificate. You can specify either `certificateID` or `certificateName`+`folderID`. You can specify only `certificateName` if folder is same as controller folder.

*Appears in*: [YCCertificateSpec](#yccertificatespec)

| Field | Description |
|-------|-------------|
| certificateID | **string** <br> Direct reference to certificate by its ID. This is the most specific way to reference a certificate. <br> Example: `fpq6gvvm6piu********` |
| certificateName | **string** <br> Name of the certificate in Yandex Cloud Certificate Manager. Must be used with `folderID` or rely on controller's default folder. <br> Example: `my-certificate` |
| folderID | **string** <br> Folder ID where the certificate is located. If not specified, controller's folder is used. <br> Example: `b1g0itj57rbj********` |

