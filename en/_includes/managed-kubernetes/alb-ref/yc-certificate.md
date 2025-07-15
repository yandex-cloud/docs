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
* `metadata` (`ObjectMeta`, required)

  Resource metadata.

  * `name` (`string`, required)

    Resource name. For more information about the group name format, see the relevant [{{ k8s }} article](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

  * `namespace` (`string`)

    Resource [namespace](../../../managed-kubernetes/concepts/index.md#namespace). The default value is `default`.

* `spec` (`YCCertificateSpec`, required)

  Resource specification. For more information, see [below](#spec).

## YCCertificateSpec {#spec}

```yaml
certificateRef:
  certificateID: <string>
  certificateName: <string>
  folderID: <string>
```

Where:

* `certificateRef` (required)

  {{ certificate-manager-name }} certificate parameters. You can set either `certificateID` or `certificateName` and `folderID`. If the certificate folder is the same as the load balancer folder, you only need to specify `certificateName`.

  * `certificateID` (`string`)
  
    Certificate ID.

  * `certificateName` (`string`)
  
    Certificate name. It is used together with the `folderID` parameter. If the certificate folder is the same as the load balancer folder, you only need to specify `certificateName`.

  * `folderID` (`string`)
  
    Certificate folder. It is used together with the `certificateName` parameter.
