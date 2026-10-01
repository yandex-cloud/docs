---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/v2/clouds/{cloudId}/folders/{folderId}/extend/stacklandClusters/{stacklandClusterId}:configs
    method: get
    path:
      type: object
      properties:
        cloudId:
          description: |-
            **string**
            ID of the parent cloud.
          type: string
        folderId:
          description: |-
            **string**
            ID of the parent folder.
          type: string
        stacklandClusterId:
          description: |-
            **string**
            ID of the cluster to retrieve configs.
          type: string
      additionalProperties: false
    query: null
    body: null
    definitions: null
---

# Extend API, REST: StacklandCluster.GetStacklandClusterConfigs

Returns a zip archive with the cluster config.yaml and secrets.yaml.


## HTTP request

```
GET https://baremetal.{{ api-host }}/v2/clouds/{cloudId}/folders/{folderId}/extend/stacklandClusters/{stacklandClusterId}:configs
```

## Path parameters

#|
||Field | Description ||
|| cloudId | **string**

Required field. ID of the parent cloud. ||
|| folderId | **string**

Required field. ID of the parent folder. ||
|| stacklandClusterId | **string**

Required field. ID of the cluster to retrieve configs. ||
|#

## Response {#yandex.cloud.baremetal.v2.extend.GetStacklandClusterConfigsResponse}

**HTTP Code: 200 - OK**

```json
{
  "filename": "string",
  "content": "string"
}
```

#|
||Field | Description ||
|| filename | **string**

Name of the returned archive. ||
|| content | **string** (bytes)

Zip archive with config.yaml and secrets.yaml. ||
|#