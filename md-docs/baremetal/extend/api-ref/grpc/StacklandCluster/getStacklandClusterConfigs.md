[Документация Yandex Cloud](../../../../../index.md) > [Yandex BareMetal](../../../../index.md) > Концепции > Настройка и управление > Справочник API > API v2 > gRPC (англ.) > [Extend API](../index.md) > [StacklandCluster](index.md) > GetStacklandClusterConfigs

# Extend API, gRPC: StacklandClusterService.GetStacklandClusterConfigs

Returns a zip archive with the cluster config.yaml and secrets.yaml.


## gRPC request

**rpc GetStacklandClusterConfigs ([GetStacklandClusterConfigsRequest](#yandex.cloud.baremetal.v2.extend.GetStacklandClusterConfigsRequest)) returns ([GetStacklandClusterConfigsResponse](#yandex.cloud.baremetal.v2.extend.GetStacklandClusterConfigsResponse))**

## GetStacklandClusterConfigsRequest {#yandex.cloud.baremetal.v2.extend.GetStacklandClusterConfigsRequest}

```json
{
  "cloud_id": "string",
  "folder_id": "string",
  "stackland_cluster_id": "string"
}
```

#|
||Field | Description ||
|| cloud_id | **string**

ID of the parent cloud. ||
|| folder_id | **string**

ID of the parent folder. ||
|| stackland_cluster_id | **string**

ID of the cluster to retrieve configs. ||
|#

## GetStacklandClusterConfigsResponse {#yandex.cloud.baremetal.v2.extend.GetStacklandClusterConfigsResponse}

```json
{
  "filename": "string",
  "content": "bytes"
}
```

#|
||Field | Description ||
|| filename | **string**

Name of the returned archive. ||
|| content | **bytes**

Zip archive with config.yaml and secrets.yaml. ||
|#