# YCStorageBucket

YCStorageBucket is a Gwin custom resource for referencing S3 buckets from Yandex Object Storage. It allows you to use Object Storage buckets as backend targets in [HTTPRoute](./httproute.md), [IngressBackendGroup](./ingressbackendgroup.md), [Ingress](./ingress.md) resources for serving static content or as part of traffic routing strategies.

When a request is routed to a YCStorageBucket backend, the load balancer forwards the request to the bucket using the URL path from the incoming request. For example, a request for `/robots.txt` will fetch the object at key `robots.txt` from the bucket.

## Controlling browser behavior

Whether a browser displays or downloads a file depends on the Content-Type and Content-Disposition response headers. To make the browser display the content instead of downloading it, ensure the object is served with the correct Content-Type and no Content-Disposition: attachment.

Option 1 (recommended): Upload objects with explicit content type metadata:

aws s3 cp index.html s3://my-bucket/index.html \
  --content-type "text/html; charset=utf-8" \
  --endpoint-url https://storage.yandexcloud.net

Option 2: Override headers at the routing layer without changing objects in storage.

For HTTPRoute, use a ResponseHeaderModifier filter on the rule:

filters:
  - type: ResponseHeaderModifier
    responseHeaderModifier:
      set:
        - name: Content-Type
          value: text/html; charset=utf-8
      remove:
        - Content-Disposition

For Ingress, use annotations on the rule:

annotations:
  gwin.yandex.cloud/rules.modifyResponseHeaders.replace.Content-Type: "text/html; charset=utf-8"
  gwin.yandex.cloud/rules.modifyResponseHeaders.remove: "Content-Disposition"

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

To use YCStorageBucket as a backend for Ingress, use [IngressBackendGroup](./ingressbackendgroup.md).

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: static-content-ingress
  namespace: example-ns
  annotations:
    ...
spec:
  ingressClassName: gwin-default
  rules:
    - host: static.example.com
      http:
        paths:
          - pathType: Prefix
            path: "/assets"
            backend:
              resource:
                apiGroup: gwin.yandex.cloud
                kind: IngressBackendGroup
                name: static-bg
---
apiVersion: gwin.yandex.cloud/v1
kind: IngressBackendGroup
metadata:
  name: static-bg
  namespace: example-ns
spec:
  type: HTTP
  backends:
    - name: some-bucket
      backendRef:
        group: gwin.yandex.cloud
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
