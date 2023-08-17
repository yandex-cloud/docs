# Event reference

The value of the `event_type` field (_event type_) in the audit log is determined by a service that is the event source.

General value format:

```text
{{ at-event-prefix }}.audit.<service name>.<event name>
```

Below are events for services:

* [{{ api-gw-name }}](#api-gateway)
* [{{ alb-name }}](#alb)
* [{{ at-name }}](#audit-trails)
* [{{ certificate-manager-name }}](#certificate-manager)
* [{{ dns-name }}](#dns)
* [{{ sf-name }}](#functions)
* [{{ cdn-name }}](#cdn)
* [{{ cloud-logging-name }}](#cloud-logging)
* [{{ compute-name }}](#compute)
* [{{ container-registry-name }}](#container-registry)
* [{{ dataproc-name }}](#dataproc)
* [{{ iam-name }}](#iam)
* [{{ iot-name }}](#iot)
* [{{ kms-name }}](#kms)
* [{{ lockbox-name }}](#lockbox)
* [{{ mch-short-name }}](#managed-service-for-clickhouse)
* [{{ mgl-full-name }}](#managed-service-for-gitlab)
* [{{ mgp-short-name }}](#managed-service-for-greenplum)
* [{{ mmg-short-name }}](#managed-service-for-mongodb)
* [{{ managed-k8s-name }}](#managed-service-for-kubernetes)
* [{{ mmy-short-name }}](#managed-service-for-mysql)
* [{{ mpg-short-name }}](#managed-service-for-postgresql)
* [{{ mrd-short-name }}](#managed-service-for-redis)
* [{{ network-load-balancer-name }}](#network-load-balancer)
* [{{ objstorage-name }}](#objstorage)
* [{{ serverless-containers-name }}](#serverless-containers)
* [{{ org-name }}](#organization)
* [{{ resmgr-name }}](#resmgr)
* [{{ captcha-name }}](#smartcaptcha)
* [{{ vpc-name }}](#vpc)
* [{{ ydb-short-name }}](#ydb)
* [{{ yq-short-name }}](#yq)

## {{ api-gw-name }} {#api-gateway}

Service name: `serverless.apigateway`.

| Event name | Description |
--- | ---
| `CreateApiGateway` | Creating a gateway |
| `DeleteApiGateway` | Deleting a gateway |
| `UpdateApiGateway` | Updating a gateway |


## {{ alb-name }} {#alb}

Service name: `apploadbalancer`.

| Event name | Description |
--- | ---
| `AddBackendGroupBackend` | Adding a backend to a backend group |
| `AddLoadBalancerListener` | Adding a listener to a load balancer |
| `AddLoadBalancerSniMatch` | Adding an SNI match to a load balancer |
| `AddTargetGroupTargets` | Adding a VM to a target group |
| `CreateBackendGroup` | Creating a backend group |
| `CreateHttpRouter` | Create an HTTP router |
| `CreateLoadBalancer` | Creating a load balancer |
| `CreateTargetGroup` | Creating a target group |
| `CreateVirtualHost` | Creating a virtual host |
| `DeleteBackendGroup` | Deleting a backend group |
| `DeleteHttpRouter` | Delete an HTTP router |
| `DeleteLoadBalancer` | Deleting a load balancer |
| `DeleteTargetGroup` | Deleting a target group |
| `DeleteVirtualHost` | Deleting a virtual host |
| `RemoveBackendGroupBackend` | Removing a backend from a backend group |
| `RemoveLoadBalancerListener` | Removing a listener from a load balancer |
| `RemoveLoadBalancerSniMatch` | Removing an SNI match from a load balancer |
| `RemoveTargetGroupTargets` | Removing a VM from a target group |
| `RemoveVirtualHostRoute` | Deleting a virtual host route |
| `StartLoadBalancer` | Starting a load balancer |
| `StopLoadBalancer` | Stopping a load balancer |
| `UpdateBackendGroup` | Updating a backend group |
| `UpdateBackendGroupBackend` | Updating a backend in a backend group |
| `UpdateHttpRouter` | Update an HTTP router |
| `UpdateLoadBalancer` | Updating a load balancer |
| `UpdateLoadBalancerListener` | Updating a listener in a load balancer |
| `UpdateLoadBalancerSniMatch` | Updating an SNI match in a load balancer |
| `UpdateTargetGroup` | Editing a target group |
| `UpdateVirtualHost` | Updating a virtual host |
| `UpdateVirtualHostRoute` | Updating a virtual host route |

## {{ at-name }} {#audit-trails}

Service name: `audittrails`.

| Event name | Description |
--- | ---
| `CreateTrail` | Creating a trail |
| `DeleteTrail` | Deleting a trail |
| `SetTrailAccessBindings` | Setting access bindings for a trail |
| `UpdateTrail` | Editing a trail |
| `UpdateTrailAccessBindings` | Updating access bindings for a trail |

## {{ sf-name }} {#functions}

Service name: `serverless`.

| Event name | Description |
| --- | --- |
| `functions.CreateFunction` | Creating a function |
| `functions.CreateFunctionVersion` | Creating a function version |
| `functions.DeleteFunction` | Deleting a function |
| `functions.RemoveFunctionTag` | Removing a function tag |
| `functions.SetFunctionTag` | Assigning a function tag |
| `functions.UpdateFunction` | Updating a function |
| `mdbproxy.CreateProxy` | Creating a proxy |
| `mdbproxy.DeleteProxy` | Deleting a proxy |
| `mdbproxy.UpdateProxy` | Updating a proxy |
| `triggers.CreateTrigger` | Creating a trigger |
| `triggers.DeleteTrigger` | Deleting a trigger |
| `triggers.UpdateTrigger` | Updating a trigger |

## {{ cdn-name }} {#cdn}

Service name: `cdn`.

| Event name | Description |
--- | ---
| `gcore.CachePrefetch` | Preloading cache |
| `gcore.CachePurge` | Purging cache |
| `gcore.OriginCreate` | Creating an origin |
| `gcore.OriginDelete` | Deleting an origin |
| `gcore.OriginGroupCreate` | Creating an origin group |
| `gcore.OriginGroupDelete` | Deleting origin groups |
| `gcore.OriginGroupUpdate` | Editing origin groups |
| `gcore.OriginUpdate` | Changing an origin |
| `gcore.ProviderActivate` | Activating a provider |
| `gcore.ResourceCreate` | Creating a resource |
| `gcore.ResourceUpdate` | Changing a resource |

## {{ certificate-manager-name }} {#certificate-manager}

Service name: `certificatemanager`.

| Event name | Description |
--- | ---
| `CreateCertificate` | Create a certificate |
| `CreateDomain` | Create a domain |
| `UpdateCertificate` | Edit a certificate |
| `UpdateDomain` | Update a domain |
| `DeleteCertificate` | Delete a certificate |
| `DeleteDomain` | Delete a domain |
| `UpdateCertificateAccessBindings` | Updating access bindings for a certificate |
| `SetCertificateAccessBindings` | Setting access bindings for a certificate |
| `SetDomainPrimaryCertificate` | Assigning a primary certificate to a domain |

## {{ dns-name }} {#dns}

Service name: `dns`.

| Event name | Description |
--- | ---
| `CreateDnsZone` | Creating a DNS zone |
| `DeleteDnsZone` | Deleting a DNS zone |
| `SetDnsZoneAccessBindings` | Setting access bindings to a DNS zone |
| `UpdateDnsZone` | Updating a DNS zone |
| `UpdateDnsZoneAccessBindings` | Updating access bindings to a DNS zone |
| `UpdateRecordSets` | Updating a record set |

## {{ cloud-logging-name }} {#cloud-logging-name}

Service name: `logging`.

| Event name | Description |
--- | ---
| `CreateLogGroup` | Creating a log group |
| `UpdateLogGroup` | Editing a log group |
| `DeleteLogGroup` | Deleting a log group |
| `SetLogGroupAccessBindings` | Setting access bindings for a log group |
| `UpdateLogGroupAccessBindings` | Updating access bindings for a log group |

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
| `CreateSnapshotSchedule` | Creating a disk snapshot schedule |
| `DeleteDisk` | Deleting a disk |
| `DeleteFilesystem` | Deleting a file system |
| `DeleteImage` | Deleting a disk image |
| `DeleteInstance` | Deleting a VM |
| `DeleteSnapshot` | Deleting a disk snapshot |
| `DeleteSnapshotSchedule` | Deleting a disk snapshot schedule |
| `DetachInstanceDisk` | Detaching a disk from a VM instance |
| `DetachInstanceFilesystem` | Detaching a file system from a VM instance |
| `DisableSnapshotSchedule` | Disabling a disk snapshot schedule |
| `EnableSnapshotSchedule` | Enabling a disk snapshot schedule |
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
| `UpdateSnapshotSchedule` | Updating disk snapshot schedule parameters |
| `UpdateSnapshotScheduleDisks` | Updating disk snapshot schedule parameters |
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

## {{ container-registry-name }} {#container-registry}

Service name: `containerregistry`.

| Event name | Description |
--- | ---
| `CreateImage` | Creating an image |
| `CreateImageTag` | Creating an image tag |
| `CreateRegistry` | Creating a registry |
| `CreateRepository` | Creating a repository |
| `DeleteImage` | Deleting an image |
| `DeleteImageTag` | Deleting an image tag |
| `DeleteRegistry` | Deleting a registry |
| `DeleteRepository` | Deleting a repository |
| `ScanImage` | Scanning an image |
| `UpdateIpPermission` | Updating policies for accessing a registry from IP addresses |
| `UpdateRegistry` | Updating a registry |
| `UpdateRegistryAccessBindings` | Updating access bindings for a registry |
| `UpdateRepositoryAccessBindings` | Updating access bindings for a repository |
| `SetRegistryAccessBindings` | Setting access bindings for a registry |
| `SetRepositoryAccessBindings` | Setting access bindings for a repository |

## {{ dataproc-name }} {#dataproc}

Service name: `dataproc`.

| Event name | Description |
--- | ---
| `CreateCluster` | Creating clusters |
| `CreateSubcluster` | Creating a subcluster |
| `DeleteCluster` | Deleting clusters |
| `DeleteSubcluster` | Deleting a subcluster |
| `StartCluster` | Starting cluster |
| `StopCluster` | Stopping cluster |
| `UpdateCluster` | Updating clusters |
| `UpdateSubcluster` | Updating subclusters |

## {{ iam-name }} {#iam}

Service name: `iam`.

| Event name | Description |
--- | ---
| `AddFederatedUserAccounts` | Adding a user to a federation |
| `CreateAccessKey` | Creating a static key |
| `CreateApiKey` | Creating API keys |
| `CreateCertificate` | Adding a certificate for a federation |
| `CreateFederation` | Creating a federation |
| `CreateIamCookieForSubject` | Federated user login ^*^ |
| `CreateKey` | Creating a key pair for a service account |
| `CreateServiceAccount` | Creating a service account |
| `DeleteAccessKey` | Deleting a static key |
| `DeleteApiKey` | Deleting API keys |
| `DeleteCertificate` | Deleting a certificate for a federation |
| `DeleteFederation` | Deleting a federation |
| `DeleteKey` | Deleting a key pair for a service account |
| `DeleteServiceAccount` | Deleting a service account |
| `DetectLeakedCredential` | Detecting a secret in a public source |
| `UpdateAccessKey` | Updating a static key |
| `UpdateApiKey` | Updating an API key |
| `UpdateCertificate` | Renewing a certificate |
| `UpdateFederation` | Updating a federation |
| `UpdateKey` | Updating a key pair |
| `UpdateServiceAccount` | Updating a service account |
| `UpdateServiceAccountAccessBindings` | Updating access bindings for a service account |
| `SetServiceAccountAccessBindings` | Setting access bindings for a service account |

\* The event is not logged in the audit log unless a trail's [audit logs](./trail.md#collecting-area) have `Enterprise` scope.

## {{ iot-name }} {#iot}

Service name: `iot`.

| Event name | Description |
--- | ---
| `devices.CreateDevice` | Creating a device |
| `devices.CreateRegistry` | Creating a registry |
| `devices.DeleteDevice` | Deleting a device |
| `devices.DeleteRegistry` | Deleting a registry |
| `devices.UpdateDevice` | Updating a device |
| `devices.UpdateRegistry` | Updating a registry |

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
| `DeleteShardGroup` | Deleting a shard group |
| `DeleteUser` | Deleting a database user |
| `GrantUserPermission` | Assigning privileges to a database user |
| `MoveCluster` | Moving a cluster |
| `RestoreCluster` | Creating a new cluster from a backup |
| `RevokeUserPermission` | Revoking a database user's privileges |
| `StartCluster` | Starting cluster |
| `StopCluster` | Stopping cluster |
| `UpdateCluster` | Updating clusters |
| `UpdateClusterShard` | Editing a cluster shard |
| `UpdateFormatSchema` | Editing a data schema format |
| `UpdateMlModel` | Editing a machine learning model |
| `UpdateShardGroup` | Editing a shard group |
| `UpdateUser` | Editing a database user |


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
| `CleanupRegistryInstance` | Docker Registry cleanup |


## {{ mgp-short-name }} {#managed-service-for-greenplum}

Service name: `mdb.greenplum`.

| Event name | Description |
--- | ---
| `CreateCluster` | Creating clusters |
| `DeleteCluster` | Deleting clusters |
| `ExpandCluster` | Expanding a cluster |
| `RestoreCluster` | Creating a new cluster from a backup |
| `StartCluster` | Starting cluster |
| `StopCluster` | Stopping cluster |
| `UpdateCluster` | Updating clusters |


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
| `StartCluster` | Starting cluster |
| `StopCluster` | Stopping cluster |
| `UpdateCluster` | Updating clusters |
| `UpdateUser` | Editing a database user |


## {{ managed-k8s-name }} {#managed-service-for-kubernetes}

Service name: `k8s`.

| Event name | Description |
--- | ---
| `AutoUpgradeCluster` | Performing cluster auto-updates |
| `AutoUpgradeNodeGroup` | Performing node group auto-updates |
| `CreateCluster` | Creating clusters |
| `CreateNodeGroup` | Creating a node group |
| `DeleteCluster` | Deleting clusters |
| `DeleteNodeGroup` | Deleting a node group |
| `DeleteStoppedCluster` | Deleting a stopped cluster |
| `InstallHelmRelease` | Installing a Helm version |
| `StartCluster` | Starting cluster |
| `StopCluster` | Stopping cluster |
| `UninstallHelmRelease` | Destroying a Helm version |
| `UpdateCluster` | Updating clusters |
| `UpdateHelmRelease` | Updating a Helm version |
| `UpdateNodeGroup` | Changing a node group |

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
| `StartCluster` | Starting cluster |
| `StartClusterFailover` | Launching master switching for a cluster |
| `StopCluster` | Stopping cluster |
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
| `StartCluster` | Starting cluster |
| `StopCluster` | Stopping cluster |
| `UpdateCluster` | Updating clusters |
| `UpdateClusterHosts` | Editing hosts in a cluster |
| `UpdateDatabase` | Updating a database |
| `UpdateUser` | Editing a database user |

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
| `StartCluster` | Starting cluster |
| `StartClusterFailover` | Launching master switching for a cluster |
| `StopCluster` | Stopping cluster |
| `UpdateCluster` | Updating clusters |
| `UpdateClusterHosts` | Updating cluster hosts |

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
| `BucketEncryptionUpdate` | Updating bucket encryption settings |
| `BucketVersioningUpdate` | Updating bucket versioning settings |
| `BucketHttpsUpdate` | Updating the HTTPS configuration for a bucket |
| `BucketLifecycleUpdate` | Changing the lifecycle of an object in a bucket |
| `BucketPolicyUpdate` | Updating the access policies for a bucket |
| `BucketUpdate` | Updating a bucket |
| `BucketWebsiteUpdate` | Updating a website configuration |
| `ObjectAclUpdate` | Updating an object's ACL in a bucket ^*^ |
| `ObjectCreate` | Creating an object in a bucket ^*^ |
| `ObjectDelete` | Deleting an object from a bucket ^*^ |
| `ObjectUpdate` | Updating an object in a bucket ^*^ |

\* The audit log does not include the above events by default. To have these events added to the audit log, please contact [technical support]({{ link-console-support }}). Message template:
"Please enable the recording of data plane object storage events in audit trail `<trail id>`."

## {{ serverless-containers-name }} {#serverless-containers}

Service name: `serverless.containers`.

| Event name | Description |
--- | ---
| `CreateContainer` | Creating a container |
| `DeleteContainer` | Deleting a container |
| `DeployContainerRevision` | Creating a container revision |
| `RollbackContainer` | Rolling back to a target container revision |
| `SetContainerAccessBindings` | Setting access bindings to a container |
| `UpdateContainer` | Updating a container |
| `UpdateContainerAccessBindings` | Updating access bindings to a container |
| `mdbproxy.CreateProxy` | Creating a proxy |
| `mdbproxy.DeleteProxy` | Deleting a proxy |
| `mdbproxy.UpdateProxy` | Updating a proxy |
| `triggers.CreateTrigger` | Creating a trigger |
| `triggers.DeleteTrigger` | Deleting a trigger |
| `triggers.UpdateTrigger` | Updating a trigger |

## {{ org-name }} {#organization}

The name of the service is `organizationmanager`.

| Event name | Description |
--- | ---
| `AcceptInvitation` | Accepting an invitation |
| `CreateInvitations` | Creating an invitation |
| `CreateGroup` | Creating a user group |
| `CreateMembership` | Adding a user to an organization |
| `CreateOrganization` | Creating an organization |
| `DeleteInvitation` | Deleting an invitation |
| `DeleteGroup` | Deleting a user group |
| `DeleteMembership` | Deleting a user from an organization |
| `DeleteOrganization` | Deleting an organization |
| `RejectInvitation` | Rejecting an invitation |
| `ResendInvitation` | Resending an invitation |
| `SetGroupAccessBindings` | Setting access bindings to a user group |
| `SetOrganizationAccessBindings` | Setting access bindings to an organization |
| `UpdateGroup` | Updating a user group |
| `UpdateGroupAccessBindings` | Updating access bindings to a user group |
| `UpdateGroupMembers` | Changing user group members |
| `UpdateOrganization` | Changing an organization |
| `UpdateOrganizationAccessBindings` | Updating access bindings to an organization |

## {{ resmgr-name }} {#resmgr}

Service name: `resourcemanager`.

| Event name | Description |
--- | ---
| `AddCloudToOrganization` | Adding a cloud to an organization |
| `CreateCloud` | Creating a cloud |
| `CreateFolder` | Creating a folder |
| `DeleteCloud` | Deleting a cloud |
| `DeleteFolder` | Deleting a folder |
| `UpdateCloud` | Updating a cloud |
| `UpdateCloudAccessBindings` | Updating access bindings for a cloud |
| `UpdateFolder` | Updating a folder |
| `UpdateFolderAccessBindings` | Updating access bindings for a folder |
| `SetCloudAccessBindings` | Setting access bindings for a cloud |
| `SetFolderAccessBindings` | Setting access bindings for a folder |

## {{ captcha-name }} {#smartcaptcha}

Service name: `smartcaptcha`.

| Event name | Description |
--- | ---
| `CreateCaptcha` | Creating a CAPTCHA |
| `DeleteCaptcha` | Deleting a CAPTCHA |
| `UpdateCaptcha` | Updating a CAPTCHA |

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

## {{ yq-short-name }} {#yq}

Service name: `yq`.

| Event name | Description |
--- | ---
| `ControlQuery` | Managing queries |
| `CreateBinding` | Creating a data binding |
| `CreateConnection` | Creating a connection |
| `CreateQuery` | Creating a query |
| `DeleteBinding` | Deleting a data binding |
| `DeleteConnection` | Deleting a connection |
| `DeleteQuery` | Deleting a query |
| `UpdateBinding` | Updating a data binding |
| `UpdateConnection` | Updating a connection |
| `UpdateQuery` | Updating a query |
