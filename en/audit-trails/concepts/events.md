# Event reference

The value of the `event_type` field (_event type_) in the audit log is determined by a service that is the event source.

General value format:

```text
yandex.cloud.audit.<service name>.<event name>
```

Below are events for services:

* [{{ compute-name }}](#compute)
* [{{ iam-name }}](#iam)
* [{{ kms-name }}](#kms)
* [{{ resmgr-name }}](#resmgr)
* [{{ objstorage-name }}](#objstorage)
* [{{ vpc-name }}](#vpc)

## {{ compute-name }} {#compute}

Service name: `compute`.

| Event name | Description |
| --- | --- |
| `AddInstanceOneToOneNat` | Adding a VM's public IP address. |
| `AttachInstanceDisk` | Connecting a disk to a VM. |
| `CreateDisk` | Creating a disk. |
| `CreateImage` | Creating a disk image. |
| `CreateInstance` | Creating a VM. |
| `CreateSnapshot` | Creating a disk snapshot. |
| `DeleteDisk` | Deleting a disk. |
| `DeleteImage` | Deleting a disk image. |
| `DeleteInstance` | Deleting a VM. |
| `DeleteSnapshot` | Deleting a disk snapshot. |
| `DetachInstanceDisk` | Detaching a disk from a VM. |
| `RemoveInstanceOneToOneNat` | Removing a VM's public IP address. |
| `RestartInstance` | Restarting a VM. |
| `StartInstance` | Starting a VM. |
| `StopInstance` | Stopping a VM. |
| `UpdateDisk` | Changing a disk. |
| `UpdateImage` | Changing a disk image. |
| `UpdateInstance` | Changing a VM. |
| `UpdateInstanceMetadata` | Changing VM metadata. |
| `UpdateInstanceNetworkInterface` | Changing a VM's network settings. |
| `UpdateSnapshot` | Changing a disk snapshot. |
| `instancegroup.CreateInstanceGroup` | Creating an instance group. |
| `instancegroup.DeleteInstanceGroup` | Deleting an instance group. |
| `instancegroup.StartInstanceGroup` | Starting an instance group. |
| `instancegroup.StopInstanceGroup` | Stopping an instance group. |
| `instancegroup.UpdateInstanceGroup` | Changing an instance group. |
| `instancegroup.UpdateInstanceGroupAccessBindings` | Assigning a role to an instance group. |

## {{ iam-name }} {#iam}

Service name: `iam`.

| Event name | Description |
| --- | --- |
| `AddFederatedUserAccounts` | Adding a user to a federation. |
| `CreateAccessKey` | Creating an access key. |
| `CreateApiKey` | Creating an API key. |
| `CreateCertificate` | Adding a certificate for a federation. |
| `CreateFederation` | Creating a federation. |
| `CreateIamCookieForSubject` | Creating an {{ iam-short-name }} cookie for an account. |
| `CreateKey` | Creating a key pair for a service account. |
| `CreateServiceAccount` | Creating a service account. |
| `DeleteAccessKey` | Deleting an access key. |
| `DeleteApiKey` | Deleting an API key. |
| `DeleteCertificate` | Deleting a certificate for a federation. |
| `DeleteFederation` | Deleting a federation. |
| `DeleteKey` | Deleting a key pair for a service account. |
| `DeleteServiceAccount` | Deleting a service account. |
| `UpdateAccessKey` | Updating an access key. |
| `UpdateApiKey` | Updating an API key. |
| `UpdateCertificate` | Updating a certificate. |
| `UpdateFederation` | Updating a federation. |
| `UpdateKey` | Updating a key pair. |
| `UpdateServiceAccount` | Updating a service account. |
| `UpdateServiceAccountAccessBindings` | Updating access bindings. |

## {{ kms-name }} {#kms}

Service name: `kms`.

| Event name | Description |
| --- | --- |
| `CancelDeleteSymmetricKey` | Canceling a previously scheduled key destruction. |
| `CancelSymmetricKeyVersionDestruction` | Canceling a previously planned destruction of the symmetric key version. |
| `CreateSymmetricKey` | Creating a symmetric key. |
| `DeleteSymmetricKey` | Deleting a symmetric key. |
| `RotateSymmetricKey` | Rotating a symmetric key. |
| `ScheduleSymmetricKeyVersionDestruction` | Scheduling the destruction of a key version. |
| `SetPrimarySymmetricKeyVersion` | Selecting the primary version of a symmetric key. |
| `SetSymmetricKeyAccessBindings` | Selecting access bindings for a symmetric key. |
| `UpdateSymmetricKey` | Changing a symmetric key. |
| `UpdateSymmetricKeyAccessBindings` | Updating access bindings for a symmetric key. |

## {{ resmgr-name }} {#resmgr}

Service name: `resourcemanager`.

| Event name | Description |
| --- | --- |
| `CreateCloud` | Creating a cloud. |
| `CreateFolder` | Creating a folder. |
| `DeleteCloud` | Deleting a cloud. |
| `DeleteFolder` | Deleting a folder. |
| `UpdateCloud` | Updating a cloud. |
| `UpdateCloudAccessBindings` | Updating access bindings for a cloud. |
| `UpdateFolder` | Updating a folder. |
| `UpdateFolderAccessBindings` | Updating access bindings for a folder. |

## {{ objstorage-name }} {#objstorage}

Service name: `storage`.

| Event name | Description |
| --- | --- |
| `BucketAclUpdate` | Changing a bucket's ACL. |
| `BucketCorsUpdate` | Changing the configuration of a CORS bucket. |
| `BucketCreate` | Creating a bucket. |
| `BucketDelete` | Deleting a bucket. |
| `BucketHttpsUpdate` | Changing an https configuration for a bucket. |
| `BucketLifecycleUpdate` | Changing the lifecycle of an object in a bucket. |
| `BucketPolicyUpdate` | Changing bucket access policies. |
| `BucketUpdate` | Updating a bucket. |
| `BucketWebsiteUpdate` | Changing a website configuration. |
| `ObjectCreate` | Creating an object in a bucket. |
| `ObjectDelete` | Deleting an object in a bucket. |
| `ObjectUpdate` | Updating an object in a bucket. |

## {{ vpc-name }} {#vpc}

Service name: `network`.

| Event name | Description |
| --- | --- |
| `CreateNetwork` | Creating a cloud network. |
| `CreateRouteTable` | Creating a routing table. |
| `CreateSecurityGroup` | Creating a security group. |
| `CreateSubnet` | Creating a cloud subnet. |
| `DeleteNetwork` | Deleting a cloud network. |
| `DeleteRouteTable` | Deleting a routing table. |
| `DeleteSecurityGroup` | Deleting a security group. |
| `DeleteSubnet` | Deleting a cloud subnet. |
| `MoveNetwork` | Moving a cloud network to a different folder. |
| `MoveRouteTable` | Moving a routing table to a different folder. |
| `MoveSecurityGroup` | Moving a security group to a different folder. |
| `MoveSubnet` | Moving a cloud subnet to a different folder. |
| `UpdateNetwork` | Changing a cloud network. |
| `UpdateRouteTable` | Changing a routing table. |
| `UpdateSecurityGroup` | Changing a security group. |
| `UpdateSubnet` | Changing a cloud subnet. |

