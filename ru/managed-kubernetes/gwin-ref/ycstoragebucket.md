---
sourcePath: en/_gwin-ref/gwin-ref/ycstoragebucket.md
---
# YCStorageBucket

YCStorageBucket is a Gwin custom resource for referencing S3 buckets from Yandex Object Storage. It allows you to use Object Storage buckets as backend targets in [HTTPRoute](./httproute.md), [IngressBackendGroup](./ingressbackendgroup.md), [Ingress](./ingress.md) resources for serving static content or as part of traffic routing strategies.

* [Cheatsheet](#cheatsheet)
* [YCStorageBucketSpec](#ycstoragebucketspec)
  * [YCStorageBucketReference](#ycstoragebucketreference)

## Cheatsheet

```yaml
apiVersion: gwin.yandex.cloud/v1
kind: YCStorageBucket
metadata:
  name: example-bucket
  namespace: example-ns
spec:
  bucketRef:
    bucketName: "my-static-content-bucket"
```

Reference the YCStorageBucket as a backend in HTTPRoute:

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: static-content-route
  namespace: example-ns
spec:
  parentRefs:
    - name: example-gateway
  hostnames:
    - "static.example.com"
  rules:
    - matches:
        - path:
            type: PathPrefix
            value: "/assets"
      backendRefs:
        - group: gwin.yandex.cloud
          kind: YCStorageBucket
          name: example-bucket
          weight: 100
```

| Field | Description |
|-------|-------------|
| metadata | **ObjectMeta** <br> Standard Kubernetes metadata. |
| spec | **[YCStorageBucketSpec](#ycstoragebucketspec)** <br> Storage bucket specification. |

## YCStorageBucketSpec

YCStorageBucketSpec defines the desired state of YCStorageBucket.

*Appears in*: [YCStorageBucket](#ycstoragebucket)

| Field | Description |
|-------|-------------|
| bucketRef | **[YCStorageBucketReference](#ycstoragebucketreference)** <br> Reference to the Yandex Cloud S3 Bucket. |

### YCStorageBucketReference

YCStorageBucketReference is a reference to a Yandex Cloud S3 Bucket.

*Appears in*: [YCStorageBucketSpec](#ycstoragebucketspec)

| Field | Description |
|-------|-------------|
| bucketName | **string** <br> Name of the Yandex Cloud S3 Bucket. <br> Example: `my-static-content-bucket` |
