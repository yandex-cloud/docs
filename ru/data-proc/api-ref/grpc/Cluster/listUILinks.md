---
editable: false
sourcePath: en/_api-ref-grpc/dataproc/v1/api-ref/grpc/Cluster/listUILinks.md
---

# Data Proc API, gRPC: ClusterService.ListUILinks

Retrieves a list of links to web interfaces being proxied by Data Proc UI Proxy.

## gRPC request

**rpc ListUILinks ([ListUILinksRequest](#yandex.cloud.dataproc.v1.ListUILinksRequest)) returns ([ListUILinksResponse](#yandex.cloud.dataproc.v1.ListUILinksResponse))**

## ListUILinksRequest {#yandex.cloud.dataproc.v1.ListUILinksRequest}

```json
{
  "cluster_id": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required. ID of the Hadoop cluster. ||
|#

## ListUILinksResponse {#yandex.cloud.dataproc.v1.ListUILinksResponse}

```json
{
  "links": [
    {
      "name": "string",
      "url": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| links[] | **[UILink](#yandex.cloud.dataproc.v1.UILink)**

Requested list of ui links. ||
|#

## UILink {#yandex.cloud.dataproc.v1.UILink}

#|
||Field | Description ||
|| name | **string** ||
|| url | **string** ||
|#