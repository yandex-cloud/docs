# Event reference

The value of the `event_type` field (_event type_) in the audit log is determined by a service that is the event source.

General value format:

{% if product == "yandex-cloud" %}
```text
yandex.cloud.audit.<service name>.<event name>
```
{% endif %}
{% if product == "cloud-il" %}
```text
cloudil.audit.<service name>.<event name>
```
{% endif %}

Below are events for services:

* [{{ at-name }}](#audit-trails)
* [{{ certificate-manager-name }}](#certificate-manager)
{% if product == "yandex-cloud" %}
* [{{ cloud-logging-name }}](#cloud-logging-name)
{% endif %}
* [{{ compute-name }}](#compute)
* [{{ iam-name }}](#iam)
* [{{ kms-name }}](#kms)
* [{{ lockbox-name }}](#lockbox)
* [{{ mch-short-name }}](#managed-service-for-clickhouse)
{% if product == "yandex-cloud" %}
* [{{ mgl-name }}](#managed-service-for-gitlab)
* [{{ mmg-short-name }}](#managed-service-for-mongodb)
{% endif %}
* [{{ mmy-short-name }}](#managed-service-for-mysql)
* [{{ mpg-short-name }}](#managed-service-for-postgresql)
{% if product == "yandex-cloud" %}
* [{{ mrd-short-name }}](#managed-service-for-redis)
{% endif %}
* [{{ network-load-balancer-name }}](#network-load-balancer)
* [{{ objstorage-name }}](#objstorage)
* [{{ org-name }}](#organization)
* [{{ resmgr-name }}](#resmgr)
* [{{ vpc-name }}](#vpc)
{% if product == "yandex-cloud" %}
* [{{ ydb-short-name }}](#ydb)
{% endif %}

## {{ at-name }} {#audit-trails}

Service name: `audittrails`.

| Event name | Description |
--- | ---
| `CreateTrail` | Creating a trail |
| `DeleteTrail` | Deleting a trail |
| `SetTrailAccessBindings` | Setting access bindings for a trail |
| `UpdateTrail` | Editing a trail |
| `UpdateTrailAccessBindings` | Updating access bindings for a trail |

## {{ certificate-manager-name }} {#certificate-manager}

Service name: `certificatemanager`.

| Event name | Description |
--- | ---
| `CreateCertificate` | Create a certificate |
| `UpdateCertificate` | Edit a certificate |
| `DeleteCertificate` | Delete a certificate |
| `UpdateCertificateAccessBindings` | Updating access bindings for a certificate |
| `SetCertificateAccessBindings` | Setting access bindings for a certificate |

{% if product == "yandex-cloud" %}
## {{ cloud-logging-name }} {#cloud-logging-name}

Service name: `logging`.

| Event name | Description |
--- | ---
| `CreateLogGroup` | Creating a log group |
| `UpdateLogGroup` | Editing a log group |
| `DeleteLogGroup` | Deleting a log group |
| `SetLogGroupAccessBindings` | Setting access bindings for a log group |
| `UpdateLogGroupAccessBindings` | Editing access bindings for a log group |
{% endif %}

## {{ compute-name }} {#compute}

Service name: `compute`.

| Event name | Description |
--- | ---
| `AddInstanceOneToOneNat` | Adding a public IP address for a VM instance |
| `AttachInstanceDisk` | Attaching a disk to a VM instance |
| `AttachInstanceFilesystem` | Connecting a file system to a VM |
| `ChangeDiskStatus` | Changing a non-replicated disk status |
| `CrashInstance` | Emergency VM shutdown |
| `CreateDisk` | Creating a disk |
| `CreateFilesystem` | Creating a file system |
| `CreateImage` | Creating a disk image |
| `CreateInstance` | Creating a VM instance |
| `CreateSnapshot` | Creating a disk snapshot |
| `DeleteDisk` | Deleting a disk |
| `DeleteFilesystem` | Deleting a file system |
| `DeleteImage` | Deleting a disk image |
| `DeleteInstance` | Deleting a VM |
| `DeleteSnapshot` | Deleting a disk snapshot |
| `DetachInstanceDisk` | Detaching a disk from a VM instance |
| `DetachInstanceFilesystem` | Detaching a file system from a VM instance |
| `GuestStopInstance` | Stopping a VM on command from this VM |
| `PreemptInstance` | Interrupting a VM |
| `RemoveInstanceOneToOneNat` | Removing a VM's public IP address |
| `RestartInstance` | Restarting a VM |
| `StartInstance` | Starting a VM |
| `StopInstance` | Stopping a VM |
| `UpdateDisk` | Changing a disk |
| `UpdateFilesystem` | Modifying a file system |
| `UpdateImage` | Updating a disk image |
| `UpdateInstance` | Updating a VM instance |
| `UpdateInstanceMetadata` | Updating VM instance metadata |
| `UpdateInstanceNetworkInterface` | Updating VM network settings |
| `UpdateSnapshot` | Updating a disk snapshot |
| `instancegroup.CreateInstanceGroup` | Creating an instance group |
| `instancegroup.DeleteInstanceGroup` | Deleting an instance group. |
| `instancegroup.DeleteInstanceGroupInstances` | Deleting an instance from a group |
| `instancegroup.PauseInstanceGroup` | Pausing instance group management processes |
| `instancegroup.ResumeInstanceGroup` | Resuming instance group management processes |
| `instancegroup.SetInstanceGroupAccessBindings` | Assigning roles for an instance group |
| `instancegroup.StartInstanceGroup` | Starting an instance group |
| `instancegroup.StopInstanceGroup` | Stopping an instance group |
| `instancegroup.StopInstanceGroupInstances` | Stopping an instance in a group |
| `instancegroup.UpdateInstanceGroup` | Updating an instance group |
| `instancegroup.UpdateInstanceGroupAccessBindings` | Updating roles for an instance group |

## {{ iam-name }} {#iam}

Service name: `iam`.

| Event name | Description |
--- | ---
| `AddFederatedUserAccounts` | Adding a user to a federation |
| `CreateAccessKey` | Creating an access key |
| `CreateApiKey` | Creating API keys |
| `CreateCertificate` | Adding a certificate for a federation |
| `CreateFederation` | Creating a federation |
| `CreateIamCookieForSubject` | Federated user login ^*^ |
| `CreateKey` | Creating a key pair for a service account |
| `CreateServiceAccount` | Creating a service account |
| `DeleteAccessKey` | Deleting an access key |
| `DeleteApiKey` | Deleting API keys |
| `DeleteCertificate` | Deleting a certificate for a federation |
| `DeleteFederation` | Deleting a federation |
| `DeleteKey` | Deleting a key pair for a service account |
| `DeleteServiceAccount` | Deleting a service account |
| `DetectLeakedCredential` | Detecting a secret in a public source |
| `UpdateAccessKey` | Updating an access key |
| `UpdateApiKey` | Updating an API key |
| `UpdateCertificate` | Renewing a certificate |
| `UpdateFederation` | Updating a federation |
| `UpdateKey` | Updating a key pair |
| `UpdateServiceAccount` | Updating a service account |
| `UpdateServiceAccountAccessBindings` | Updating access bindings |

\* The event is not logged in the audit log unless a trail's [audit logs](./trail.md#collecting-area) have `Enterprise` scope.

## {{ kms-name }} {#kms}

Service name: `kms`.

| Event name | Description |
--- | ---
| `CancelDeleteSymmetricKey` | Canceling a previously scheduled key destruction |
| `CancelSymmetricKeyVersionDestruction` | Canceling a previously planned destruction of a symmetric key version |
| `CreateSymmetricKey` | Creating a symmetric key |
| `DeleteSymmetricKey` | Deleting a symmetric key |
| `RotateSymmetricKey` | Rotating a symmetric key |
| `ScheduleSymmetricKeyVersionDestruction` | Scheduling the destruction of a key version |
| `SetPrimarySymmetricKeyVersion` | Selecting the primary version of a symmetric key |
| `SetSymmetricKeyAccessBindings` | Selecting access bindings for a symmetric key |
| `UpdateSymmetricKey` | Changing a symmetric key |
| `UpdateSymmetricKeyAccessBindings` | Updating access bindings for a symmetric key |

## {{ lockbox-name }} {#lockbox}

Service Name: `lockbox`.

| Event name | Description |
--- | ---
| `AddVersion` | Adding a version of a secret |
| `ActivateSecret` | Activating a secret |
| `CancelVersionDestruction` | Canceling a previously scheduled destruction of a secret version |
| `CreateSecret` | Creating a secret |
| `DeactivateSecret` | Deactivating a secret |
| `DeleteSecret` | Destroying a secret |
| `GetPayload` | Accessing the contents of a secret ^*^ |
| `ScheduleVersionDestruction` | Scheduling the destruction of a secret version |
| `SetSecretAccessBindings` | Selecting access bindings for a secret |
| `UpdateSecret` | Updating a secret |
| `UpdateSecretAccessBindings` | Updating access bindings for a secret |

\* By default, this event is not included in the audit log. To have this event added to the audit log, please contact [technical support]({{ link-console-support }}). Message template:
"Please include data plane Lockbox events in audit trail `<trail ID>`."

## {{ mch-short-name }} {#managed-service-for-clickhouse}

Service name: `mdb.clickhouse`.

| Event name | Description |
--- | ---
| `AddClusterHosts` | Adding new hosts to a cluster |
| `AddClusterShard` | Adding a shard to a cluster |
| `AddClusterZookeeper` | Adding a ZooKeeper subcluster to a cluster |
| `BackupCluster` | Creating backups |
| `CreateCluster` | Creating clusters |
| `CreateClusterExternalDictionary` | Creating an external dictionary |
| `CreateDatabase` | Creating a database |
| `CreateFormatSchema` | Creating a data format schema |
| `CreateMlModel` | Creating a machine learning model |
| `CreateShardGroup` | Creating a shard group |
| `CreateUser` | Creating a database user |
| `DeleteCluster` | Deleting clusters |
| `DeleteClusterExternalDictionary` | Editing an external dictionary |
| `DeleteClusterHosts` | Deleting hosts from a cluster |
| `DeleteClusterShard` | Deleting a shard from a cluster |
| `DeleteDatabase` | Deleting a database |
| `DeleteFormatSchema` | Deleting a data format schema |
| `DeleteMlModel` | Deleting a machine learning model |
| `DeleteUser` | Deleting a database user |
| `GrantUserPermission` | Assigning privileges to a database user |
| `MoveCluster` | Moving a cluster |
| `RestoreCluster` | Creating a new cluster from a backup |
| `RevokeUserPermission` | Revoking a database user's privileges |
| `StartCluster` | Start cluster |
| `StopCluster` | Stop cluster |
| `UpdateCluster` | Updating clusters |
| `UpdateClusterShard` | Editing a cluster shard |
| `UpdateFormatSchema` | Editing a data schema format |
| `UpdateMlModel` | Editing a machine learning model |
| `UpdateUser` | Editing a database user |

{% if product == "yandex-cloud" %}

## {{ mgl-name }} {#managed-service-for-gitlab}

Service name: `gitlab`.

| Event name | Description |
--- | ---
| `BackupInstance` | Creating backups |
| `CreateInstance` | Creating an instance |
| `DeleteInstance` | Deleting an instance |
| `StartInstance` | Launching an instance |
| `StopInstance` | Stopping an instance |
| `UpdateInstance` | Updating an instance |
| `UpdateOmniauthInstance` | Updating OmniAuth settings |
| `UpgradeInstance` | Updating the GitLab version |

## {{ mmg-short-name }} {#managed-service-for-mongodb}

Service name: `mdb.mongodb`.

| Event name | Description |
--- | ---
| `AddClusterHosts` | Adding new hosts to a cluster |
| `AddClusterShard` | Adding a shard to a cluster |
| `BackupCluster` | Creating backups |
| `CreateCluster` | Creating clusters |
| `CreateDatabase` | Creating a database |
| `CreateUser` | Creating a database user |
| `DeleteCluster` | Deleting clusters |
| `DeleteClusterHosts` | Deleting hosts from a cluster |
| `DeleteClusterShard` | Deleting a shard from a cluster |
| `DeleteDatabase` | Deleting a database |
| `DeleteUser` | Deleting a database user |
| `EnableClusterSharding` | Enabling sharding for a cluster |
| `GrantUserPermission` | Assigning privileges to a database user |
| `MoveCluster` | Moving a cluster |
| `RestoreCluster` | Creating a new cluster from a backup |
| `RevokeUserPermission` | Revoking a database user's privileges |
| `StartCluster` | Start cluster |
| `StopCluster` | Stop cluster |
| `UpdateCluster` | Updating clusters |
| `UpdateUser` | Editing a database user |

{% endif %}
## {{ mmy-short-name }} {#managed-service-for-mysql}

Service name: `mdb.mysql`.

| Event name | Description |
--- | ---
| `AddClusterHosts` | Adding new hosts to a cluster |
| `BackupCluster` | Creating backups |
| `CreateCluster` | Creating clusters |
| `CreateDatabase` | Creating a database |
| `CreateUser` | Creating a database user |
| `DeleteCluster` | Deleting clusters |
| `DeleteClusterHosts` | Deleting hosts from a cluster |
| `DeleteDatabase` | Deleting a database |
| `DeleteUser` | Deleting a database user |
| `GrantUserPermission` | Assigning privileges to a database user |
| `MoveCluster` | Moving a cluster |
| `RescheduleMaintenance` | Rescheduling scheduled maintenance |
| `RestoreCluster` | Creating a new cluster from a backup |
| `RevokeUserPermission` | Revoking a database user's privileges |
| `StartCluster` | Start cluster |
| `StartClusterFailover` | Launching master switching for a cluster |
| `StopCluster` | Stop cluster |
| `UpdateCluster` | Updating clusters |
| `UpdateClusterHosts` | Editing hosts in a cluster |
| `UpdateUser` | Editing a database user |

## {{ mpg-short-name }} {#managed-service-for-postgresql}

Service name: `mdb.postgresql`.

| Event name | Description |
--- | ---
| `AddClusterHosts` | Adding new hosts to a cluster |
| `BackupCluster` | Creating backups |
| `CreateCluster` | Creating clusters |
| `CreateDatabase` | Creating a database |
| `CreateUser` | Creating a database user |
| `DeleteCluster` | Deleting clusters |
| `DeleteClusterHosts` | Deleting hosts from a cluster |
| `DeleteDatabase` | Deleting a database |
| `DeleteUser` | Deleting a database user |
| `GrantUserPermission` | Assigning privileges to a database user |
| `MoveCluster` | Moving a cluster |
| `RestoreCluster` | Creating a new cluster from a backup |
| `RevokeUserPermission` | Revoking a database user's privileges |
| `StartCluster` | Start cluster |
| `StopCluster` | Stop cluster |
| `UpdateCluster` | Updating clusters |
| `UpdateClusterHosts` | Editing hosts in a cluster |
| `UpdateDatabase` | Updating a database |
| `UpdateUser` | Editing a database user |

{% if product == "yandex-cloud" %}
## {{ mrd-short-name }} {#managed-service-for-redis}

Service name: `mdb.redis`.

| Event name | Description |
--- | ---
| `AddClusterHosts` | Adding new hosts to a cluster |
| `AddClusterShard` | Adding a shard to a cluster |
| `BackupCluster` | Creating backups |
| `CreateCluster` | Creating clusters |
| `DeleteCluster` | Deleting clusters |
| `DeleteClusterHosts` | Deleting hosts from a cluster |
| `DeleteClusterShard` | Deleting a shard from a cluster |
| `MoveCluster` | Moving a cluster |
| `RebalanceCluster` | Rebalancing a cluster |
| `RestoreCluster` | Creating a new cluster from a backup |
| `StartCluster` | Start cluster |
| `StartClusterFailover` | Launching master switching for a cluster |
| `StopCluster` | Stop cluster |
| `UpdateCluster` | Updating clusters |

{% endif %}
## {{ network-load-balancer-name }} {#network-load-balancer}

Service name: `loadbalancer`.

| Event name | Description |
--- | ---
| `AddNetworkLoadBalancerListener` | Adding listener to network load balancer |
| `AddTargetGroupTargets` | Adding a VM to a target group |
| `AttachNetworkLoadBalancerTargetGroup` | Connecting a target group to a network load balancer |
| `CreateNetworkLoadBalancer` | Creating a network load balancer |
| `CreateTargetGroup` | Creating a target group |
| `DeleteNetworkLoadBalancer` | Deleting a network load balancer |
| `DeleteTargetGroup` | Deleting a target group |
| `DetachNetworkLoadBalancerTargetGroup` | Detaching a target group from a network load balancer |
| `RemoveNetworkLoadBalancerListener` | Removing a listener from a network load balancer |
| `RemoveTargetGroupTargets` | Removing a VM from a target group |
| `StartNetworkLoadBalancer` | Starting a network load balancer |
| `StopNetworkLoadBalancer` | Stopping a network load balancer |
| `UpdateNetworkLoadBalancer` | Updating a network load balancer |
| `UpdateTargetGroup` | Editing a target group |

## {{ objstorage-name }} {#objstorage}

Service name: `storage`.

| Event name | Description |
--- | ---
| `BucketAclUpdate` | Updating the ACL for a bucket |
| `BucketCorsUpdate` | Updating the CORS configuration for a bucket |
| `BucketCreate` | Creating a bucket |
| `BucketDelete` | Deleting a bucket |
| `BucketHttpsUpdate` | Updating the HTTPS configuration for a bucket |
| `BucketLifecycleUpdate` | Changing the lifecycle of an object in a bucket |
| `BucketPolicyUpdate` | Updating the access policies for a bucket |
| `BucketUpdate` | Updating a bucket |
| `BucketWebsiteUpdate` | Updating a website configuration |
| `ObjectCreate` | Creating an object in a bucket ^*^ |
| `ObjectDelete` | Deleting an object from a bucket ^*^ |
| `ObjectUpdate` | Updating an object in a bucket ^*^ |

\* The audit log does not include the above events by default. To have these events added to the audit log, please contact [technical support]({{ link-console-support }}). Message template:
"Please enable the recording of data plane object storage events in audit trail `<trail id>`."

## {{ org-name }} {#organization}

The name of the service is `organizationmanager`.

| Event name | Description |
--- | ---
| `CreateMembership` | Adding a user to an organization |
| `DeleteMembership` | Deleting a user from an organization |

## {{ resmgr-name }} {#resmgr}

Service name: `resourcemanager`.

| Event name | Description |
--- | ---
| `CreateCloud` | Creating a cloud |
| `CreateFolder` | Creating a folder |
| `DeleteCloud` | Deleting a cloud |
| `DeleteFolder` | Deleting a folder |
| `UpdateCloud` | Updating a cloud |
| `UpdateCloudAccessBindings` | Updating access bindings for a cloud |
| `UpdateFolder` | Updating a folder |
| `UpdateFolderAccessBindings` | Updating access bindings for a folder ^*^ |

\* The event may not be included in the audit log if the service account privileges were granted via the [console]({{ link-console-main }}).

## {{ vpc-name }} {#vpc}

Service name: `network`.

| Event name | Description |
--- | ---
| `CreateAddress` | Creating a cloud resource address |
| `CreateGateway` | Creating a gateway |
| `CreateNetwork` | Creating a cloud network |
| `CreateRouteTable` | Creating a routing table |
| `CreateSecurityGroup` | Create security group |
| `CreateSubnet` | Creating a cloud subnet |
| `DeleteAddress` | Deleting a cloud resource address |
| `DeleteGateway` | Deleting a gateway |
| `DeleteNetwork` | Deleting a cloud network |
| `DeleteRouteTable` | Deleting a routing table |
| `DeleteSecurityGroup` | Deleting a security group |
| `DeleteSubnet` | Deleting a cloud subnet |
| `GatewayAttached` | Adding a gateway |
| `GatewayDetached` | Detaching a gateway |
| `MoveAddress` | Moving an address of cloud resources to another folder |
| `MoveGateway` | Moving a gateway to another folder |
| `MoveNetwork` | Moving a cloud network to another folder |
| `MoveRouteTable` | Moving a routing table to another folder |
| `MoveSecurityGroup` | Moving a security group to another folder |
| `MoveSubnet` | Moving a cloud subnet to another folder |
| `RouteTableAttached` | Adding a routing table to a subnet |
| `RouteTableDetached` | Detaching a routing table from a subnet |
| `UpdateAddress` | Updating the address of a cloud resource |
| `UpdateGateway` | Updating a gateway |
| `UpdateNetwork` | Updating a cloud network |
| `UpdateRouteTable` | Updating a routing table |
| `UpdateSecurityGroup` | Updating a security group |
| `UpdateSubnet` | Updating a cloud subnet |

{% if product == "yandex-cloud" %}
## {{ ydb-short-name }} {#ydb}

Service name: `ydb`.

| Event name | Description |
--- | ---
| `BackupDatabase` | Creating a database backup |
| `CreateDatabase` | Creating a database |
| `DeleteBackup` | Deleting a database backup |
| `DeleteDatabase` | Deleting a database |
| `MoveDatabase` | Moving a database |
| `RestoreBackup` | Restoring a database from a backup |
| `StartDatabase` | Starting a database |
| `StopDatabase` | Stopping a database |
| `UpdateDatabase` | Updating a database |
{% endif %}
