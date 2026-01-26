# YCCertificate resource fields

The `YCCertificate` resource contains {{ certificate-manager-name }} certificate parameters for setting up TLS connections in the `Gateway` resource.

## YCCertificate {#yc-certificate}

```yaml
apiVersion: gwin.yandex.cloud/v1
kind: YCCertificate
metadata:
  name: <string>
  namespace: <string>
spec: <YCCertificateSpec>
```

Where:

* `apiVersion`: `gwin.yandex.cloud/v1`
* `kind`: `YCCertificate`
* `metadata` (`ObjectMeta`; this is a required field)

  Resource metadata.

  * `name` (`string`; this is a required field)

    Resource name. For more information about the format, see [this {{ k8s }} guide](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

  * `namespace` (`string`)

    [Namespace](../../../managed-kubernetes/concepts/index.md#namespace) the resource belongs to. The default value is `default`.

* `spec` (`YCCertificateSpec`; this is a required field)

  Resource specification. For more information, see [below](#spec).

## YCCertificateSpec {#spec}

```yaml
certificateRef:
  certificateID: <string>
  certificateName: <string>
  folderID: <string>
```

Where:

* `certificateRef` (this is a required field)

  {{ certificate-manager-name }} certificate parameters. You can set either `certificateID` or `certificateName` and `folderID`. If the certificate folder is the same as the load balancer folder, you only need to specify `certificateName`.

  * `certificateID` (`string`)
  
    Certificate ID.

  * `certificateName` (`string`)
  
    Certificate name. It is used together with the `folderID` parameter. If the certificate folder is the same as the load balancer folder, you only need to specify `certificateName`.

  * `folderID` (`string`)
  
    Certificate folder. It is used together with the `certificateName` parameter.
