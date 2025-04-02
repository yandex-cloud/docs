---
editable: false
sourcePath: en/_api-ref/dataproc/v1/api-ref/Cluster/listUILinks.md
---

# Yandex Data Processing API, REST: Cluster.ListUILinks

Retrieves a list of links to web interfaces being proxied by Yandex Data Processing UI Proxy.

## HTTP request

```
GET https://dataproc.{{ api-host }}/dataproc/v1/clusters/{clusterId}/ui_links
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. Required. ID of the Hadoop cluster. ||
|#

## Response {#yandex.cloud.dataproc.v1.ListUILinksResponse}

**HTTP Code: 200 - OK**

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