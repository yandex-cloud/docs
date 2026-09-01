[Документация Yandex Cloud](../../../../../index.md) > [Yandex BareMetal](../../../../index.md) > Концепции > Настройка и управление > Справочник API > API v2 > gRPC (англ.) > [Extend API](../index.md) > [StacklandCluster](index.md) > UpdateStacklandCluster

# Extend API, gRPC: StacklandClusterService.UpdateStacklandCluster

Updates the specified Stackland cluster.


## gRPC request

**rpc UpdateStacklandCluster ([UpdateStacklandClusterRequest](#yandex.cloud.baremetal.v2.extend.UpdateStacklandClusterRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateStacklandClusterRequest {#yandex.cloud.baremetal.v2.extend.UpdateStacklandClusterRequest}

```json
{
  "cluster": {
    "stackland_cluster_id": "string",
    "cloud_id": "string",
    "folder_id": "string",
    "name": "string",
    "description": "string",
    "state": "State",
    "create_time": "google.protobuf.Timestamp",
    "update_time": "google.protobuf.Timestamp",
    "annotations": "map<string, string>",
    "hardware_pool_id": "string",
    "preset": "StacklandPreset",
    "host_roles": {
      "controlplane": [
        {
          "configuration_id": "string",
          "node_count": "int64",
          "nodes": [
            {
              "server_id": "string",
              "configuration_id": "string",
              "management_ip_address": "string",
              "hostname": "string"
            }
          ],
          "server_ids": [
            "string"
          ]
        }
      ],
      "combined": [
        {
          "configuration_id": "string",
          "node_count": "int64",
          "nodes": [
            {
              "server_id": "string",
              "configuration_id": "string",
              "management_ip_address": "string",
              "hostname": "string"
            }
          ],
          "server_ids": [
            "string"
          ]
        }
      ],
      "worker": [
        {
          "configuration_id": "string",
          "node_count": "int64",
          "nodes": [
            {
              "server_id": "string",
              "configuration_id": "string",
              "management_ip_address": "string",
              "hostname": "string"
            }
          ],
          "server_ids": [
            "string"
          ]
        }
      ]
    },
    "bastion_node": {
      "server_id": "string",
      "configuration_id": "string",
      "management_ip_address": "string",
      "hostname": "string"
    },
    "subnet_id": "string",
    "cidr": "string",
    "version": "string",
    "license": "string",
    "credentials_lockbox_secret_id": "string",
    "configuration_url": "string",
    "virtual_ip": "string",
    "cluster_domain": "string",
    "subdomains": {
      "console": "string",
      "dashboard": "string",
      "grafana": "string",
      "prometheus": "string",
      "alertmanager": "string"
    },
    "bastion_spec": {
      // Includes only one of the fields `ssh_public_key_text`, `user_ssh_id`
      "ssh_public_key_text": "string",
      "user_ssh_id": "string",
      // end of the list of possible fields
      // Includes only one of the fields `password_plain_text`, `password_lockbox_secret`
      "password_plain_text": "string",
      "password_lockbox_secret": {
        "secret_id": "string",
        "version_id": "string",
        "key": "string"
      }
      // end of the list of possible fields
    },
    "settings": {
      "public_network_access": "PublicNetworkAccess"
    }
  },
  "update_mask": "google.protobuf.FieldMask"
}
```

#|
||Field | Description ||
|| cluster | **[StacklandCluster](#yandex.cloud.baremetal.v2.extend.StacklandCluster)**

The cluster object to be updated ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the StacklandCluster resource are going to be updated. ||
|#

## StacklandCluster {#yandex.cloud.baremetal.v2.extend.StacklandCluster}

#|
||Field | Description ||
|| stackland_cluster_id | **string**

ID of the cluster. ||
|| cloud_id | **string**

ID of the cloud that the cluster belongs to. ||
|| folder_id | **string**

ID of the folder that the cluster belongs to. ||
|| name | **string**

Name of the cluster.
The display name is unique within the folder. ||
|| description | **string**

Description of the server. ||
|| state | enum **State**

State of the cluster.

- `CREATING`: Cluster is being created.
- `UPDATING`: Cluster is being updated.
- `RUNNING`: Cluster is running.
- `DELETING`: Cluster is being deleted.
- `ERROR`: Cluster is in error state. ||
|| create_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| update_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Update timestamp. ||
|| annotations | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| hardware_pool_id | **string**

ID of the hardware pool that the cluster belongs to. ||
|| preset | enum **StacklandPreset**

Preset of the cluster.

- `MINIMAL`: Minimal preset.
- `FULL`: Full preset. ||
|| host_roles | **[StacklandHostRoles](#yandex.cloud.baremetal.v2.extend.StacklandHostRoles)**

Which node types are to be used for cluster roles. ||
|| bastion_node | **[Node](#yandex.cloud.baremetal.v2.extend.Node)**

Bastion node. ||
|| subnet_id | **string**

ID of the subnet that the cluster belongs to. ||
|| cidr | **string**

Optional CIDR to preselect in subnet. ||
|| version | **string**

Version of Stackland to be used. ||
|| license | **string**

License to activate Stackland. ||
|| credentials_lockbox_secret_id | **string**

ID of secret with cluster credentials in lockbox. ||
|| configuration_url | **string**

URL in S3 to the cluster configuration. ||
|| virtual_ip | **string**

IP of the cluster control plane. . ||
|| cluster_domain | **string**

Base cluster DNS domain. ||
|| subdomains | **[StacklandSubdomains](#yandex.cloud.baremetal.v2.extend.StacklandSubdomains)**

Cluster component URLs, available once the cluster is active. ||
|| bastion_spec | **[BastionSpec](#yandex.cloud.baremetal.v2.extend.BastionSpec)**

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
|| configuration_id | **string**

ID of the configuration.

Required when automatically leasing new servers for the group (scenarios 1 and 2).
Left blank when the group consists solely of custom servers (scenario 3). ||
|| node_count | **int64**

Total number of nodes in the group, including both newly leased and
already leased (existing) servers listed in `server_ids`.

Must be greater than or equal to `len(server_ids)`. The number of new
servers leased for the group is `node_count - len(server_ids)`.

Required (non-zero) when automatically leasing new servers for the group; ||
|| nodes[] | **[Node](#yandex.cloud.baremetal.v2.extend.Node)**

Nodes in the group with detailed information. Set after group is filled. ||
|| server_ids[] | **string**

IDs of already leased servers to include in the NodeGroup.

WARNING: the OS on these servers will be reinstalled as part of cluster
creation, just like for newly leased servers. All data on the servers
will be lost. ||
|#

## Node {#yandex.cloud.baremetal.v2.extend.Node}

#|
||Field | Description ||
|| server_id | **string**

ID of the server. ||
|| configuration_id | **string**

ID of the configuration. ||
|| management_ip_address | **string**

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
|| ssh_public_key_text | **string**

Public SSH key for the server.

Input only field.

The maximum string length in characters is 20000.

Includes only one of the fields `ssh_public_key_text`, `user_ssh_id`.

Root user SSH key.

Input only field. One of elements is required. ||
|| user_ssh_id | **string**

ID of the user SSH key to use for the server.

Input only field. To get the user SSH key ID, use a [yandex.cloud.organizationmanager.v1.UserSshKeyService.List](../../../../../organization/api-ref/grpc/UserSshKey/list.md#List) request.

The maximum string length in characters is 50.

Includes only one of the fields `ssh_public_key_text`, `user_ssh_id`.

Root user SSH key.

Input only field. One of elements is required. ||
|| password_plain_text | **string**

Raw password.

Input only field.

The minimum string length in characters is 6.

Includes only one of the fields `password_plain_text`, `password_lockbox_secret`.

Password for the server.

Input only field. One of elements is required. ||
|| password_lockbox_secret | **[LockboxSecret](#yandex.cloud.baremetal.v2.LockboxSecret)**

Reference to the Lockbox secret used to obtain the password.

Input only field.

Includes only one of the fields `password_plain_text`, `password_lockbox_secret`.

Password for the server.

Input only field. One of elements is required. ||
|#

## LockboxSecret {#yandex.cloud.baremetal.v2.LockboxSecret}

#|
||Field | Description ||
|| secret_id | **string**

Required field. The unique identifier for the lockbox secret that contains the user password. ||
|| version_id | **string**

The unique identifier for the lockbox version.
If omitted, the current version of the secret will be used. ||
|| key | **string**

Required field. The key used to access a specific secret entry. ||
|#

## StacklandClusterSettings {#yandex.cloud.baremetal.v2.extend.StacklandClusterSettings}

Settings of the Stackland cluster.

#|
||Field | Description ||
|| public_network_access | enum **PublicNetworkAccess**

Access of the cluster to the public network. Disabled by default.
Can be set only at cluster creation.

- `ENABLED`: Cluster is accessible from the public network.
- `DISABLED`: Cluster is not accessible from the public network. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../../../api-design-guide/concepts/operation.md).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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