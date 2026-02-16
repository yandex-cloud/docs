# YCStorageBucket resource fields

The `YCStorageBucket` resource contains the {{ objstorage-name }} bucket parameters for setting up a backend in the `HTTPRoute` resource.

## YCStorageBucket {#yc-storage-bucket}

```yaml
apiVersion: gwin.yandex.cloud/v1
kind: YCStorageBucket
metadata:
  name: <string>
  namespace: <string>
spec: <YCStorageBucketSpec>
```

Where:

* `apiVersion`: `gwin.yandex.cloud/v1`
* `kind`: `YCStorageBucket`
* `metadata` (`ObjectMeta`; this is a required field)

  Resource metadata.

  * `name` (`string`; this is a required field)

    Resource name. For more information about the format, see [this {{ k8s }} guide](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

  * `namespace` (`string`)

    [Namespace](../../../managed-kubernetes/concepts/index.md#namespace) the resource belongs to. The default value is `default`.

* `spec` (`YCStorageBucketSpec`; this is a required field)

  Resource specification. For more information, see [below](#spec).

## YCStorageBucketSpec {#spec}

```yaml
bucketRef:
  bucketName: <string>
```

Where:

* `bucketRef` (this is a required field)

  {{ objstorage-name }} bucket parameters.

  * `bucketName` (`string`)
  
    Bucket name.
