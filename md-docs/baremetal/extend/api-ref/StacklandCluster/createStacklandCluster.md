[Документация Yandex Cloud](../../../../index.md) > [Yandex BareMetal](../../../index.md) > Концепции > Настройка и управление > Справочник API > API v2 > REST (англ.) > [Extend API](../index.md) > [StacklandCluster](index.md) > CreateStacklandCluster

# Extend API, REST: StacklandCluster.CreateStacklandCluster

Creates new Stackland cluster.


## HTTP request

```
POST https://baremetal.api.cloud.yandex.net/v2/clouds/{cloudId}/folders/{folderId}/extend/stacklandClusters
```

## Path parameters

#|
||Field | Description ||
|| cloudId | **string**

Required field. ID of the parent cloud.

To get the cloud ID, use a [yandex.cloud.resourcemanager.v1.CloudService.List](../../../../resource-manager/api-ref/Cloud/list.md#List) request. ||
|| folderId | **string**

Required field. ID of the parent folder.

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../../resource-manager/api-ref/Folder/list.md#List) request. ||
|#

## Body parameters {#yandex.cloud.baremetal.v2.extend.CreateStacklandClusterRequest}

```json
{
  "cluster": {
    "stacklandClusterId": "string",
    "cloudId": "string",
    "folderId": "string",
    "name": "string",
    "description": "string",
    "state": "string",
    "createTime": "string",
    "updateTime": "string",
    "annotations": "object",
    "hardwarePoolId": "string",
    "preset": "string",
    "hostRoles": {
      "controlplane": [
        {
          "configurationId": "string",
          "nodeCount": "string",
          "nodes": [
            {
              "serverId": "string",
              "configurationId": "string",
              "managementIpAddress": "string",
              "hostname": "string"
            }
          ],
          "serverIds": [
            "string"
          ]
        }
      ],
      "combined": [
        {
          "configurationId": "string",
          "nodeCount": "string",
          "nodes": [
            {
              "serverId": "string",
              "configurationId": "string",
              "managementIpAddress": "string",
              "hostname": "string"
            }
          ],
          "serverIds": [
            "string"
          ]
        }
      ],
      "worker": [
        {
          "configurationId": "string",
          "nodeCount": "string",
          "nodes": [
            {
              "serverId": "string",
              "configurationId": "string",
              "managementIpAddress": "string",
              "hostname": "string"
            }
          ],
          "serverIds": [
            "string"
          ]
        }
      ]
    },
    "bastionNode": {
      "serverId": "string",
      "configurationId": "string",
      "managementIpAddress": "string",
      "hostname": "string"
    },
    "subnetId": "string",
    "cidr": "string",
    "version": "string",
    "license": "string",
    "credentialsLockboxSecretId": "string",
    "configurationUrl": "string",
    "virtualIp": "string",
    "clusterDomain": "string",
    "subdomains": {
      "console": "string",
      "dashboard": "string",
      "grafana": "string",
      "prometheus": "string",
      "alertmanager": "string"
    },
    "bastionSpec": {
      // Includes only one of the fields `sshPublicKeyText`, `userSshId`
      "sshPublicKeyText": "string",
      "userSshId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `passwordPlainText`, `passwordLockboxSecret`
      "passwordPlainText": "string",
      "passwordLockboxSecret": {
        "secretId": "string",
        "versionId": "string",
        "key": "string"
      }
      // end of the list of possible fields
    },
    "settings": {
      "publicNetworkAccess": "string"
    }
  }
}
```

#|
||Field | Description ||
|| cluster | **[StacklandCluster](#yandex.cloud.baremetal.v2.extend.StacklandCluster)**

The cluster to create. ||
|#

## StacklandCluster {#yandex.cloud.baremetal.v2.extend.StacklandCluster}

#|
||Field | Description ||
|| stacklandClusterId | **string**

ID of the cluster. ||
|| cloudId | **string**

ID of the cloud that the cluster belongs to. ||
|| folderId | **string**

ID of the folder that the cluster belongs to. ||
|| name | **string**

Name of the cluster.
The display name is unique within the folder. ||
|| description | **string**

Description of the server. ||
|| state | **enum** (State)

State of the cluster.

- `CREATING`: Cluster is being created.
- `UPDATING`: Cluster is being updated.
- `RUNNING`: Cluster is running.
- `DELETING`: Cluster is being deleted.
- `ERROR`: Cluster is in error state. ||
|| createTime | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updateTime | **string** (date-time)

Update timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| annotations | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| hardwarePoolId | **string**

ID of the hardware pool that the cluster belongs to. ||
|| preset | **enum** (StacklandPreset)

Preset of the cluster.

- `MINIMAL`: Minimal preset.
- `FULL`: Full preset. ||
|| hostRoles | **[StacklandHostRoles](#yandex.cloud.baremetal.v2.extend.StacklandHostRoles)**

Which node types are to be used for cluster roles. ||
|| bastionNode | **[Node](#yandex.cloud.baremetal.v2.extend.Node)**

Bastion node. ||
|| subnetId | **string**

ID of the subnet that the cluster belongs to. ||
|| cidr | **string**

Optional CIDR to preselect in subnet. ||
|| version | **string**

Version of Stackland to be used. ||
|| license | **string**

License to activate Stackland. ||
|| credentialsLockboxSecretId | **string**

ID of secret with cluster credentials in lockbox. ||
|| configurationUrl | **string**

URL in S3 to the cluster configuration. ||
|| virtualIp | **string**

IP of the cluster control plane. . ||
|| clusterDomain | **string**

Base cluster DNS domain. ||
|| subdomains | **[StacklandSubdomains](#yandex.cloud.baremetal.v2.extend.StacklandSubdomains)**

Cluster component URLs, available once the cluster is active. ||
|| bastionSpec | **[BastionSpec](#yandex.cloud.baremetal.v2.extend.BastionSpec)**

Credentials for access to the bastion node.

Input only field. ||
|| settings | **[StacklandClusterSettings](#yandex.cloud.baremetal.v2.extend.StacklandClusterSettings)**

Cluster settings. Can be set only at cluster creation. ||
|#

## StacklandHostRoles {#yandex.cloud.baremetal.v2.extend.StacklandHostRoles}

#|
||Field | Description ||
|| controlplane[] | **[NodeGroup](#yandex.cloud.baremetal.v2.extend.NodeGroup)**

Node types used as controlplane nodes. ||
|| combined[] | **[NodeGroup](#yandex.cloud.baremetal.v2.extend.NodeGroup)**

Node types used as combined nodes. ||
|| worker[] | **[NodeGroup](#yandex.cloud.baremetal.v2.extend.NodeGroup)**

Node types used as workder nodes. ||
|#

## NodeGroup {#yandex.cloud.baremetal.v2.extend.NodeGroup}

NodeGroup describes a group of nodes with a common role.

A group can be filled in one of three ways:
1. New servers only: `configuration_id` and `node_count` are set, `server_ids` is empty.
`node_count` new servers of the given configuration will be leased.
2. Mixed group with a default configuration: `configuration_id` and `node_count` are set,
`server_ids` is non-empty and `node_count >= len(server_ids)`. Servers listed in
`server_ids` must already match `configuration_id` or be custom servers
(assembled manually, not via a standard configuration). If `node_count == len(server_ids)`,
no new servers are leased; otherwise `node_count - len(server_ids)` new servers of
`configuration_id` are leased in addition to the existing ones.
3. Custom servers only: `configuration_id` is empty, `server_ids`
is non-empty and contains only custom servers, `node_count == len(server_ids)`.

Servers listed in `server_ids` must satisfy (checked synchronously before the
create-cluster operation is created): the server's configuration matches
`configuration_id` or the server is custom; the server's hardware pool matches the
cluster's hardware pool; the server's status is not `QUARANTINED` or `DELETING`.
If a server's status is `UPDATING` or `PROVISIONING`, the request is still accepted
and the cluster-creation operation waits for the server's current operation to
complete before proceeding.

A server listed in `server_ids` can belong to only one group within a single request.

#|
||Field | Description ||
|| configurationId | **string**

ID of the configuration.

Required when automatically leasing new servers for the group (scenarios 1 and 2).
Left blank when the group consists solely of custom servers (scenario 3). ||
|| nodeCount | **string** (int64)

Total number of nodes in the group, including both newly leased and
already leased (existing) servers listed in `server_ids`.

Must be greater than or equal to `len(server_ids)`. The number of new
servers leased for the group is `node_count - len(server_ids)`.

Required (non-zero) when automatically leasing new servers for the group; ||
|| nodes[] | **[Node](#yandex.cloud.baremetal.v2.extend.Node)**

Nodes in the group with detailed information. Set after group is filled. ||
|| serverIds[] | **string**

IDs of already leased servers to include in the NodeGroup.

WARNING: the OS on these servers will be reinstalled as part of cluster
creation, just like for newly leased servers. All data on the servers
will be lost. ||
|#

## Node {#yandex.cloud.baremetal.v2.extend.Node}

#|
||Field | Description ||
|| serverId | **string**

ID of the server. ||
|| configurationId | **string**

ID of the configuration. ||
|| managementIpAddress | **string**

IP address of the node in the management network. ||
|| hostname | **string**

Hostname of the node inside the cluster. ||
|#

## StacklandSubdomains {#yandex.cloud.baremetal.v2.extend.StacklandSubdomains}

#|
||Field | Description ||
|| console | **string**

Cluster URL. ||
|| dashboard | **string**

Cluster URL. ||
|| grafana | **string**

Grafana URL. ||
|| prometheus | **string**

Prometheus URL. ||
|| alertmanager | **string**

Alertmanager URL. ||
|#

## BastionSpec {#yandex.cloud.baremetal.v2.extend.BastionSpec}

#|
||Field | Description ||
|| sshPublicKeyText | **string**

Public SSH key for the server.

Input only field.

The maximum string length in characters is 20000.

Includes only one of the fields `sshPublicKeyText`, `userSshId`.

Root user SSH key.

Input only field. One of elements is required. ||
|| userSshId | **string**

ID of the user SSH key to use for the server.

Input only field. To get the user SSH key ID, use a [yandex.cloud.organizationmanager.v1.UserSshKeyService.List](../../../../organization/api-ref/UserSshKey/list.md#List) request.

The maximum string length in characters is 50.

Includes only one of the fields `sshPublicKeyText`, `userSshId`.

Root user SSH key.

Input only field. One of elements is required. ||
|| passwordPlainText | **string**

Raw password.

Input only field.

The minimum string length in characters is 6.

Includes only one of the fields `passwordPlainText`, `passwordLockboxSecret`.

Password for the server.

Input only field. One of elements is required. ||
|| passwordLockboxSecret | **[LockboxSecret](#yandex.cloud.baremetal.v2.LockboxSecret)**

Reference to the Lockbox secret used to obtain the password.

Input only field.

Includes only one of the fields `passwordPlainText`, `passwordLockboxSecret`.

Password for the server.

Input only field. One of elements is required. ||
|#

## LockboxSecret {#yandex.cloud.baremetal.v2.LockboxSecret}

#|
||Field | Description ||
|| secretId | **string**

Required field. The unique identifier for the lockbox secret that contains the user password. ||
|| versionId | **string**

The unique identifier for the lockbox version.
If omitted, the current version of the secret will be used. ||
|| key | **string**

Required field. The key used to access a specific secret entry. ||
|#

## StacklandClusterSettings {#yandex.cloud.baremetal.v2.extend.StacklandClusterSettings}

Settings of the Stackland cluster.

#|
||Field | Description ||
|| publicNetworkAccess | **enum** (PublicNetworkAccess)

Access of the cluster to the public network. Disabled by default.
Can be set only at cluster creation.

- `ENABLED`: Cluster is accessible from the public network.
- `DISABLED`: Cluster is not accessible from the public network. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../../api-design-guide/concepts/operation.md).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **object**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **object**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#