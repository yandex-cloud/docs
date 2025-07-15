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
* `metadata` (`ObjectMeta`, required)

  Resource metadata.

  * `name` (`string`, required)

    Resource name. For more information about the group name format, see the relevant [{{ k8s }} article](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

  * `namespace` (`string`)

    Resource [namespace](../../../managed-kubernetes/concepts/index.md#namespace). The default value is `default`.

* `spec` (`YCStorageBucketSpec`, required):

  Resource specification. For more information, see [below](#spec).

## YCStorageBucketSpec {#spec}

```yaml
bucketRef:
  bucketName: <string>
```

Where:

* `bucketRef` (required)

  {{ objstorage-name }} bucket parameters.

  * `bucketName` (`string`)
  
    Bucket name.
