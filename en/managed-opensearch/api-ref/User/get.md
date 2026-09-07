---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/{clusterId}/users/{userName}
    method: get
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. Required. ID of the OpenSearch cluster.
            The maximum string length in characters is 50.
          type: string
        userName:
          description: |-
            **string**
            Required field. Required. Name of the user to return.
            The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
          pattern: '[a-zA-Z0-9_]*'
          type: string
      required:
        - clusterId
        - userName
      additionalProperties: false
    query: null
    body: null
    definitions: null
---

# Managed Service for OpenSearch API, REST: User.Get

Returns the specified OpenSearch user.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/{clusterId}/users/{userName}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. Required. ID of the OpenSearch cluster.

The maximum string length in characters is 50. ||
|| userName | **string**

Required field. Required. Name of the user to return.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `. ||
|#

## Response {#yandex.cloud.mdb.opensearch.v1.User}

**HTTP Code: 200 - OK**

```json
{
  "name": "string",
  "connectionManager": {
    "connectionId": "string"
  }
}
```

An OpenSearch user.

#|
||Field | Description ||
|| name | **string**

Name of the user. ||
|| connectionManager | **[ConnectionManager](#yandex.cloud.mdb.opensearch.v1.ConnectionManager)**

Connection Manager connection associated with the user. Read only field. ||
|#

## ConnectionManager {#yandex.cloud.mdb.opensearch.v1.ConnectionManager}

#|
||Field | Description ||
|| connectionId | **string**

ID of the Connection Manager connection. ||
|#