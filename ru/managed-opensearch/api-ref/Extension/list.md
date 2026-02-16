---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/{clusterId}/extensions
    method: get
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. Required. ID of the cluster to list extensions in.
            The maximum string length in characters is 50.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page that should be returned. If the number of available
            results is larger than `page_size`, the service returns a `next_page_token` that can be used
            to get the next page of results in subsequent ListBackups requests.
            Acceptable values are 0 to 1000, inclusive. Default value: 100.
            Acceptable values are 0 to 1000, inclusive.
          default: '100'
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. Set `page_token` to the `next_page_token` returned by a previous ListBackups
            request to get the next page of results.
            The maximum string length in characters is 100.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/mdb/opensearch/v1/api-ref/Extension/list.md
---

# Managed Service for OpenSearch API, REST: Extension.List

Returns the list of available extensions for the specified OpenSearch cluster.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/{clusterId}/extensions
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. Required. ID of the cluster to list extensions in.

The maximum string length in characters is 50. ||
|#

## Query parameters {#yandex.cloud.mdb.opensearch.v1.ListExtensionsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page that should be returned. If the number of available
results is larger than `page_size`, the service returns a `next_page_token` that can be used
to get the next page of results in subsequent ListBackups requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100.

Acceptable values are 0 to 1000, inclusive. ||
|| pageToken | **string**

Page token. Set `page_token` to the `next_page_token` returned by a previous ListBackups
request to get the next page of results.

The maximum string length in characters is 100. ||
|#

## Response {#yandex.cloud.mdb.opensearch.v1.ListExtensionsResponse}

**HTTP Code: 200 - OK**

```json
{
  "extensions": [
    {
      "name": "string",
      "id": "string",
      "clusterId": "string",
      "version": "string",
      "active": "boolean",
      "type": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| extensions[] | **[Extension](#yandex.cloud.mdb.opensearch.v1.Extension)**

Requested list of extensions. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for ListBackups requests,
if the number of results is larger than `page_size` specified in the request.
To get the next page, specify the value of `next_page_token` as a value for
the `page_token` parameter in the next ListBackups request. Subsequent ListBackups
requests will have their own `next_page_token` to continue paging through the results. ||
|#

## Extension {#yandex.cloud.mdb.opensearch.v1.Extension}

#|
||Field | Description ||
|| name | **string**

Name of the extension. ||
|| id | **string**

Extension unique ID ||
|| clusterId | **string**

ID of the OpenSearch cluster the extension belongs to. ||
|| version | **string** (int64)

Extension version ||
|| active | **boolean**

Flag is extension active now ||
|| type | **enum** (ExtensionType)

Extension type

- `EXTENSION_TYPE_SYNONYMS`
- `EXTENSION_TYPE_STOPWORDS` ||
|#