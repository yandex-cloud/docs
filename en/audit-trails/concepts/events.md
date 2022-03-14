# Event reference

The value of the `event_type` field (_event type_) in the audit log is determined by a service that is the event source.

General value format:

```text
yandex.cloud.audit.<service name>.<event name>
```

Below are events for services:

* [{{ at-name }}](#audit-trails)
* [{{ cloud-logging-name }}](#cloud-logging-name)
* [{{ compute-name }}](#compute)
* [{{ iam-name }}](#iam)
* [{{ kms-name }}](#kms)
* [{{ lockbox-name }}](#lockbox)
* [{{ network-load-balancer-name }}](#network-load-balancer)
* [{{ objstorage-name }}](#objstorage)
* [{{ resmgr-name }}](#resmgr)
* [{{ vpc-name }}](#vpc)
* [{{ ydb-short-name }}](#ydb)

## {{ at-name }} {#audit-trails}

Service name: `audittrails`.

| Event name | Description |
| --- | --- |
| `CreateTrail` | Creating a trail |
| `DeleteTrail` | Deleting a trail |
| `SetTrailAccessBindings` | Setting access bindings for a trail |
| `UpdateTrail` | Editing a trail |
| `UpdateTrailAccessBindings` | Updating access bindings for a trail |

## {{ cloud-logging-name }} {#cloud-logging-name}

Service name: `logging`.

| Event name | Description |
| --- | --- |
| `CreateLogGroup` | Creating a log group |
| `UpdateLogGroup` | Editing a log group |
| `DeleteLogGroup` | Deleting a log group |
| `SetLogGroupAccessBindings` | Setting access bindings for a log group |
| `UpdateLogGroupAccessBindings` | Editing access bindings for a log group |

## {{ compute-name }} {#compute}

Service name: `compute`.

| Event name | Description |
| --- | --- |
| `AddInstanceOneToOneNat` | Adding a public IP address for a VM instance |
| `AttachInstanceDisk` | Attaching a disk to a VM instance |
| `AttachInstanceFilesystem` | Connecting a file system to a VM |
| `CreateDisk` | Creating a disk |
| `CreateFilesystem` | Creating a file system |
| `CreateImage` | Creating a disk image |
| `CreateInstance` | Creating a VM instance |
| `CreateSnapshot` | Creating a disk snapshot |
| `DeleteDisk` | Deleting a disk |
| `DeleteFilesystem` | Deleting a file system |
| `DeleteImage` | Deleting a disk image |
| `DeleteInstance` | Delete VM |
| `DeleteSnapshot` | Deleting a disk snapshot |
| `DetachInstanceDisk` | Detaching a disk from a VM instance |
| `DetachInstanceFilesystem` | Detaching a file system from a VM |
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
| `instancegroup.DeleteInstanceGroup` | Deleting an instance group |
| `instancegroup.DeleteInstanceGroupInstances` | Removing an instance from a group |
| `instancegroup.PauseInstanceGroup` | Pausing instance group management processes |
| `instancegroup.ResumeInstanceGroup` | Resuming instance group management processes |
| `instancegroup.SetInstanceGroupAccessBindings` | Assigning roles to an instance group |
| `instancegroup.StartInstanceGroup` | Starting an instance group |
| `instancegroup.StopInstanceGroup` | Stopping an instance group |
| `instancegroup.StopInstanceGroupInstances` | Stopping an instance from a group |
| `instancegroup.UpdateInstanceGroup` | Updating an instance group |
| `instancegroup.UpdateInstanceGroupAccessBindings` | Updating roles for an instance group |

## {{ iam-name }} {#iam}

Service name: `iam`.

| Event name | Description |
| --- | --- |
| `AddFederatedUserAccounts` | Adding a user to a federation |
| `CreateAccessKey` | Creating an access key |
| `CreateApiKey` | Creating API keys |
| `CreateCertificate` | Adding a certificate for a federation |
| `CreateFederation` | Create federation |
| `CreateIamCookieForSubject` | Federated user login ^*^ |
| `CreateKey` | Creating a key pair for a service account |
| `CreateServiceAccount` | Create service account |
| `DeleteAccessKey` | Deleting an access key |
| `DeleteApiKey` | Deleting API keys |
| `DeleteCertificate` | Deleting a certificate for a federation |
| `DeleteFederation` | Delete federation |
| `DeleteKey` | Deleting a key pair for a service account |
| `DeleteServiceAccount` | Deleting a service account |
| `UpdateAccessKey` | Updating an access key |
| `UpdateApiKey` | Updating an API key |
| `UpdateCertificate` | Renew a certificate |
| `UpdateFederation` | Updating a federation |
| `UpdateKey` | Updating a key pair |
| `UpdateServiceAccount` | Updating a service account |
| `UpdateServiceAccountAccessBindings` | Updating access bindings |

\* An event gets into the audit log only if [audit log collection scope](./trail.md#collecting-area) for the trail is `Organization`.

## {{ kms-name }} {#kms}

Service name: `kms`.

| Event name | Description |
| --- | --- |
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
| --- | --- |
| `AddVersion` | Adding a version of a secret |
| `ActivateSecret` | Activating a secret |
| `CancelVersionDestruction` | Canceling a previously scheduled destruction of a secret version |
| `CreateSecret` | Creating a secret |
| `DeactivateSecret` | Deactivating a secret |
| `DeleteSecret` | Destroying a secret |
| `ScheduleVersionDestruction` | Scheduling the destruction of a secret version |
| `SetSecretAccessBindings` | Selecting access bindings for a secret |
| `UpdateSecret` | Updating a secret |
| `UpdateSecretAccessBindings` | Updating access bindings for a secret |

## {{ network-load-balancer-name }} {#network-load-balancer}

Service name: `loadbalancer`.

| Event name | Description |
| --- | --- |
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
| --- | --- |
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

\* The audit log does not include the above events by default. To add these events to the audit log, contact [technical support]({{ link-console-support }}). Message template:
"Please enable the recording of data plane object storage events in audit trail <trail id>."

## {{ resmgr-name }} {#resmgr}

Service name: `resourcemanager`.

| Event name | Description |
| --- | --- |
| `CreateCloud` | Creating a cloud |
| `CreateFolder` | Creating a folder |
| `DeleteCloud` | Deleting a cloud |
| `DeleteFolder` | Deleting a folder |
| `UpdateCloud` | Updating a cloud |
| `UpdateCloudAccessBindings` | Updating access bindings for a cloud |
| `UpdateFolder` | Updating a folder |
| `UpdateFolderAccessBindings` | Updating access bindings for a folder ^*^ |

\* The event may not be included in the audit log if the rights to the service account were assigned using [console]({{ link-console-main }}).

## {{ vpc-name }} {#vpc}

Service name: `network`.

| Event name | Description |
| --- | --- |
| `CreateAddress` | Creating a cloud resource address |
| `CreateNetwork` | Creating a cloud network |
| `CreateRouteTable` | Creating a routing table |
| `CreateSecurityGroup` | Create security group |
| `CreateSubnet` | Creating a cloud subnet |
| `DeleteAddress` | Deleting a cloud resource address |
| `DeleteNetwork` | Deleting a cloud network |
| `DeleteRouteTable` | Deleting a routing table |
| `DeleteSecurityGroup` | Deleting a security group |
| `DeleteSubnet` | Deleting a cloud subnet |
| `MoveAddress` | Moving the address of cloud resources to another folder |
| `MoveNetwork` | Moving a cloud network to another folder |
| `MoveRouteTable` | Moving a routing table to another folder |
| `MoveSecurityGroup` | Moving a security group to another folder |
| `MoveSubnet` | Moving a cloud subnet to another folder |
| `UpdateAddress` | Updating the address of a cloud resource |
| `UpdateNetwork` | Updating a cloud network |
| `UpdateRouteTable` | Updating a routing table |
| `UpdateSecurityGroup` | Updating a security group |
| `UpdateSubnet` | Updating a cloud subnet |

## {{ ydb-short-name }} {#ydb}

Service name: `ydb`.

| Event name | Description |
| --- | --- |
| `BackupDatabase` | Creating a database backup |
| `CreateDatabase` | Creating a database |
| `DeleteBackup` | Deleting a database backup |
| `DeleteDatabase` | Deleting a database |
| `RestoreBackup` | Restoring a database from a backup |
| `StartDatabase` | Starting a database |
| `StopDatabase` | Stopping a database |
| `UpdateDatabase` | Updating a database |
