---
title: Access management in {{ compute-full-name }}
description: Access management in {{ compute-full-name }}, a service providing scalable computing capacities for creating and managing virtual machines. This section describes the resources for which you can assign a role and the roles existing in the service.
---

# Access management in {{ compute-name }}


In this section, you will learn:

* [About access management in {{ yandex-cloud }}](#about-access-control).
* [What resources you can assign a role for](#resources).
* [What roles this service has](#roles-list).
* [What roles are required to perform specific actions](#choosing-roles).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

{% include [role-note](../../_includes/compute/role-note.md) %}

To assign a role for a resource, a user should have the `compute.admin` role or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Which resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

You can also assign roles for individual resources of the service:

{% list tabs group=instructions %}

- Management console {#console}

  Use the [management console]({{ link-console-main }}) to assign roles for the following resources:

  {% include notitle [compute-resources](../../_includes/iam/resources-with-access-control/compute.md) %}

- CLI {#cli}

  You can use the [{{ yandex-cloud }} CLI](../../cli/cli-ref/compute/cli-ref/index.md) to assign roles for the following resources:

  {% include notitle [compute-resources](../../_includes/iam/resources-with-access-control/compute.md) %}

- {{ TF }} {#tf}

  Use [{{ TF }}]({{ tf-provider-link }}) to assign roles for the following resources:

  {% include notitle [compute-resources-tf](../../_includes/iam/resources-with-access-control/compute-tf.md) %}

- API {#api}

  You can use the [{{ yandex-cloud }}](../api-ref/authentication.md) API to assign roles for the following resources:

  {% include notitle [compute-resources](../../_includes/iam/resources-with-access-control/compute.md) %}

{% endlist %}

## What roles exist in this service {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/compute/security/service-roles-hierarchy.svg)

### Service roles {#service-roles}

#### compute.auditor {#compute-auditor}

{% include [compute.auditor](../../_roles/compute/auditor.md) %}

#### compute.viewer {#compute-viewer}

{% include [compute.viewer](../../_roles/compute/viewer.md) %}

#### compute.editor {#compute-editor}

{% include [compute.editor](../../_roles/compute/editor.md) %}

#### compute.admin {#compute-admin}

{% include [compute.admin](../../_roles/compute/admin.md) %}

#### compute.osLogin {#compute-oslogin}

{% include [compute.oslogin](../../_roles/compute/osLogin.md) %}

#### compute.osAdminLogin {#compute-osadminlogin}

{% include [compute.osadminlogin](../../_roles/compute/osAdminLogin.md) %}

{% note alert %}

{% include [sudo-and-oslogin](../../_includes/compute/sudo-and-oslogin.md) %}

{% endnote %}

#### compute.disks.user {#compute-disks-user}

{% include [compute.disks.user](../../_roles/compute/disks/user.md) %}

#### compute.images.user {#compute-images-user}

{% include [compute.images.user](../../_roles/compute/images/user.md) %}

#### compute.operator {#compute-operator}

{% include [compute.operator](../../_roles/compute/operator.md) %}

#### compute.snapshotSchedules.viewer {#compute-snapshotSchedules-viewer}

{% include [compute.snapshotSchedules.viewer](../../_roles/compute/snapshotSchedules/viewer.md) %}

#### compute.snapshotSchedules.editor {#compute-snapshotSchedules-editor}

{% include [compute.snapshotSchedules.editor](../../_roles/compute/snapshotSchedules/editor.md) %}

#### iam.serviceAccounts.user {#iam-serviceAccounts-user}

{% include [iam.serviceAccounts.user](../../_roles/iam/serviceAccounts/user.md) %}

For more information about service roles, see [{#T}](../../iam/concepts/access-control/roles.md) in the {{ iam-full-name }} documentation.

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## What roles do I need {#choosing-roles}

The table below lists the roles required for specific actions. You can always assign a role offering more permissions than the specified one. For example, you can assign the `editor` role instead of `compute.editor`, or the `compute.viewer` role for a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) instead of a separate VM or disk.

Action | Minimum required roles
----- | -----
**Viewing data** |
Viewing information about any resource and [access permissions](../../iam/concepts/access-control/index.md) assigned to any resource | `compute.viewer` for the resource
Viewing the list of [VM instances](../concepts/vm.md) in an [instance group](../concepts/instance-groups/index.md), viewing instance group logs | `compute.viewer` for the instance group
Viewing the list of [disks](../concepts/disk.md) in a [disk placement group](../concepts/disk-placement-group.md) | `compute.viewer` for the disk placement group
Viewing the list of VM instances in a [GPU cluster](../concepts/gpus.md#gpu-clusters) | `compute.viewer` for the GPU cluster
Viewing the list of virtual machines on a [dedicated host](../concepts/dedicated-host.md), viewing the list of dedicated hosts in a dedicated host group | `compute.viewer` for the dedicated host group
Viewing a list of virtual machines in a [placement group](../concepts/placement-groups.md) | `compute.viewer` for the placement group
[Getting the VM serial port output](../operations/vm-info/get-serial-port-output.md) | `compute.viewer` for the VM instance
Getting information about the latest [image](../concepts/image.md) in an [image family](../concepts/image.md#family) | `compute.viewer` or `compute.images.user` for the image
Viewing information about disk [snapshot](../concepts/snapshot.md) [schedules](../concepts/snapshot-schedule.md), viewing the list of disks attached to a specific disk snapshot schedule and the list of disk snapshots created based this schedule | `compute.snapshotSchedules.viewer` or `compute.viewer` for the schedule
**Use of resources** |
Using any resource | `compute.editor` for the resource
Use of [disks](../concepts/disk.md) | `compute.disks.user`, `compute.snapshotSchedules.editor`, or `compute.editor` for the disk
Use of [images](../concepts/image.md) | `compute.images.user` or `compute.editor` for the image
**Managing resources** |
[Creating](../operations/vm-create/create-linux-vm.md) a VM | `compute.editor` for the folder
[Starting](../operations/vm-control/vm-stop-and-start.md#start), [stopping](../operations/vm-control/vm-stop-and-start.md#stop), and [restarting](../operations/vm-control/vm-stop-and-start.md#restart) virtual machines | `compute.operator` for the VM instance
[Modifying](../operations/vm-control/vm-update.md) and [deleting](../operations/vm-control/vm-delete.md) a virtual machine | `compute.editor` for the VM instance
[Linking](../operations/vm-control/vm-connect-sa.md) a service account to a VM | `compute.editor` for the VM instance
[Changing VM metadata](../operations/vm-metadata/update-vm-metadata.md) | `compute.editor` for the VM instance
[Attaching](../operations/vm-control/vm-attach-disk.md)/[detaching](../operations/vm-control/vm-detach-disk.md) a disk to/from a VM | `compute.editor` for the VM instance
[Attaching](../operations/filesystem/attach-to-vm.md)/[detaching](../operations/filesystem/detach-from-vm.md) a [file storage](../concepts/filesystem.md) to/from a VM | `compute.editor` for the VM instance
[Adding](../operations/vm-control/attach-network-interface.md) a [network interface](../concepts/network.md) to a VM and [deleting](../operations/vm-control/detach-network-interface.md) it from a VM, modifying a VM network interface | `compute.editor` for the VM instance
[Assigning](../operations/vm-control/vm-attach-public-ip.md) a [public IP address](../../vpc/concepts/address.md#public-addresses.md) to a VM and [unassigning](../operations/vm-control/vm-detach-public-ip.md) it from a VM | `compute.editor` for the VM instance
[Assigning](../operations/vm-control/vm-change-security-groups-set.md) [security groups](../../vpc/concepts/security-groups.md) to a VM | `compute.editor` for the VM instance
Moving a VM [to another cloud folder](../operations/vm-control/vm-change-folder.md) | `compute.editor` for the VM instance
[Simulating](../operations/vm-control/vm-update-policies.md#simulate) an instance maintenance event | `compute.editor` for the VM instance
[Creating](../operations/instance-groups/create-fixed-group.md) an instance group | `compute.editor` for the folder
[Starting](../operations/instance-groups/start.md) and [stopping](../operations/instance-groups/stop.md) an instance group | `compute.operator` for the instance group
[Changing](../operations/instance-groups/update.md) and [deleting](../operations/instance-groups/delete.md) an instance group | `compute.editor` for the instance group
Sequential [restarting](../operations/instance-groups/rolling-restart.md) and [recreating](../operations/instance-groups/rolling-recreate.md) instances in a group | `compute.operator` for the instance group
[Pausing](../operations/instance-groups/pause-processes.md) and [resuming](../operations/instance-groups/resume-processes.md) instance group processes | `compute.editor` for the instance group
[Creating](../operations/gpu-cluster/gpu-cluster-create.md) a GPU cluster | `compute.editor` for the folder
[Updating](../operations/gpu-cluster/gpu-cluster-update.md) and [deleting](../operations/gpu-cluster/gpu-cluster-delete.md) a GPU cluster | `compute.editor` for the GPU cluster
[Creating](../operations/dedicated-host/create-host-group.md) a group of dedicated hosts | `compute.editor` for the folder
Updating and deleting a group of dedicated hosts, updating hosts in a group of dedicated hosts | `compute.editor` for the dedicated host group
[Creating](../operations/reserved-pools/create-reserved-pool.md) a pool of reserved VMs | `compute.editor` for the folder
[Updating](../operations/reserved-pools/update-reserved-pool.md) and [deleting](../operations/reserved-pools/delete-reserved-pool.md) a pool of reserved VMs | `compute.editor` for the folder
[Creating](../operations/placement-groups/create.md) a placement group | `compute.editor` for the folder
Changing and [deleting](../operations/placement-groups/delete.md) a placement group | `compute.editor` for the placement group
[Creating](../operations/disk-placement-groups/create.md) a disk placement group | `compute.editor` for the folder
Changing and deleting a disk placement group | `compute.editor` for the disk placement group
[Creating](../operations/disk-create/empty.md) a disk | `compute.editor` for the folder
[Updating](../operations/disk-control/update.md) and [deleting](../operations/disk-control/delete.md) a disk | `compute.editor` for the disk
Moving a disk to a [different cloud folder](../operations/disk-control/disk-change-folder.md) | `compute.editor` for the disk
[Creating](../operations/filesystem/create.md) a file storage | `compute.editor` for the folder
[Updating](../operations/filesystem/update.md) and [deleting](../operations/filesystem/delete.md) a file storage | `compute.editor` for the file storage
[Creating](../operations/image-create/create-from-disk.md) an image | `compute.editor` for the folder
Updating and [deleting](../operations/image-control/delete.md) an image | `compute.editor` for the image
[Creating](../operations/disk-control/create-snapshot.md) a disk snapshot | `compute.snapshotSchedules.editor` or `compute.editor` for the folder
[Deleting](../operations/snapshot-control/delete.md) a disk snapshot | `compute.snapshotSchedules.editor` or `compute.editor` for the disk snapshot
[Creating](../operations/snapshot-control/create-schedule.md) a disk snapshot schedule | `compute.snapshotSchedules.editor` or `compute.editor` for the folder
[Starting](../operations/snapshot-control/stop-and-start-schedule.md#start-schedule), [stopping](../operations/snapshot-control/stop-and-start-schedule.md#stop-schedule), [updating](../operations/snapshot-control/update-schedule.md) and [deleting](../operations/snapshot-control/delete-schedule.md) a disk snapshot schedule | `compute.snapshotSchedules.editor` or `compute.editor` for the schedule
**Managing resource access** |
[Assigning](../../iam/operations/roles/grant.md) and [revoking](../../iam/operations/roles/revoke.md) access permissions for any resource | `compute.admin` for the resource

#### What's next {#what-is-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about role inheritance](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
