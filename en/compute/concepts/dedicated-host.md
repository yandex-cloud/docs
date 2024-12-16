---
title: Dedicated host in {{ compute-full-name }}
description: In this article, you will learn about dedicated hosts, relationship between the host configuration and type, host maintenance in {{ compute-name }}, host troubleshooting, etc.
---

# Dedicated hosts


A _dedicated host_ is a physical server that is intended solely for hosting your VMs in {{ yandex-cloud }}. VMs on dedicated hosts have all features of regular VMs; additionally, they are physically isolated from other users' VMs. You can also distinguish your VMs used for different projects:

![Dedicated host](../../_assets/compute/dedicated-host.svg "Dedicated host")

You can create a group of one or more dedicated hosts of the same type. To optimize the use of resources, you can host multiple [VMs with different configurations](performance-levels.md) on each dedicated host.

Dedicated hosts provide the following advantages:
* Security and compliance:
  You can use a dedicated host to physically isolate your VM in the public cloud if this is required by your company's information security service or industry standards, such as medical or financial ones.
* Using your own licenses:
  If your company has Microsoft licenses or those from other vendors that require linking to physical resources, you can use them in {{ yandex-cloud }} based on the <q>Bring your own license</q> (BYOL) model.
* Managing your VM allocation:
  You can choose which dedicated host to run your VM on or allow {{ compute-name }} to do it automatically.

{% include [dedicated](../../_includes/compute/dedicated-quota.md) %}

To ensure fault tolerance of your infrastructure hosted on dedicated hosts, we recommend using at least two hosts.

## Types of dedicated hosts {#host-types}

The configuration of a dedicated host is determined by its _type_. Host types differ by their models and the number of available CPU cores, RAM size, and the number and size of local SSD disks.

You can specify the dedicated host type when creating a host group. This type will be assigned to every host in the group, and you will not be able to change it moving forward.

The number of free dedicated hosts of each type per [availability zone](../../overview/concepts/geo-scope.md) is limited and changes with time. When a host group is created or resized, {{ compute-name }} checks that there are enough dedicated hosts of this type. If there are not enough hosts, you will get an error.


### List of types {#host-types-list}

Current types: based on Intel<sup>®</sup> Ice Lake

Type and processor | Processors | Cores | vCPU^1^ | RAM, GB | Disks | Disk size
--- | --- | --- | --- | --- | --- | ---
**Ice Lake**<br>`intel-6338-c108-m704-n3200x6`<br>[Intel<sup>®</sup> Xeon<sup>®</sup> Gold 6338](https://ark.intel.com/content/www/us/en/ark/products/212285/intel-xeon-gold-6338-processor-48m-cache-2-00-ghz.html) | 2 | 64 | 108 | 704 | 6 | 3198924357632&nbsp;bytes <br>(~ 2.91 TB)
**Ice Lake Compute-Optimized**<br>`intel-6354-c56-m454-n3200x6`<br>[Intel<sup>®</sup> Xeon<sup>®</sup> Gold 6354](https://ark.intel.com/content/www/us/en/ark/products/212460/intel-xeon-gold-6354-processor-39m-cache-3-00-ghz.html) | 2 | 32 | 56 | 454 | 6 | 3198924357632&nbsp;bytes <br>(~ 2.91 TB)

{% cut "Archived types: based on Intel Cascade Lake" %}

{% note alert %}

Do not use archived types to create dedicated hosts. Select a current type instead (see above).

{% endnote %}

Type and processor<br>(Cascade Lake) | Processors | Cores | vCPU^1^ | RAM, GB | Disks | Disk size
--- | --- | --- | --- | --- | --- | ---
`intel-6230-c66-m454`<br>[Intel® Xeon® Gold 6230](https://ark.intel.com/content/www/us/en/ark/products/192437/intel-xeon-gold-6230-processor-27-5m-cache-2-10-ghz.html) | 2 | 40 | 66 | 454 | 4 | 3198924357632 bytes <br>(~ 2.91 TB)
`intel-6230r-c84-m328-n3200x4`<br>[Intel® Xeon® Gold 6230R](https://ark.intel.com/content/www/us/en/ark/products/199346/intel-xeon-gold-6230r-processor-35-75m-cache-2-10-ghz.html) | 2 | 52 | 84 | 328 | 4 | 3198924357632 bytes <br>(~ 2.91 TB)

{% endcut %}

The above lists of the current and archived types are provided for indicative purposes and may change. You can get an up-to-date list of types (both current and archived) in the following ways:

* In the [management console]({{ link-console-main }}), on the dedicated host group create page in {{ compute-name }}.
* Using the following CLI command:

    ```bash
    yc compute host-type list
    ```

    For more information, see the [guide on creating host groups](../operations/dedicated-host/create-host-group.md).

^1^ This is the number of vCPUs you can use to run VMs. Other vCPUs of the host are allocated for system usage (see [below](#resource-fragmentation) for details): 20 vCPUs running on the Intel® Xeon® Gold 6338 processors, and 8 vCPUs, on Intel® Xeon® Gold 6354.

## Using physical resources of a host {#resource}

### Processor fragmentation {#resource-fragmentation}

There are two processors installed on a physical server. However, not all their cores are available for running VMs. Some cores are allocated for system usage.

For example, a dedicated host of the `intel-6354-c56-m454-n3200x6` type has:
* Two Intel® Xeon® Gold 6354 CPUs
* 32 vCPUs on each processor, where:
    * 4 vCPUs are allocated for system usage.
    * 28 vCPUs are available to run user VMs. 

When creating a VM on a dedicated host, you may encounter resource fragmentation, when the number of free vCPUs is sufficient, but you are unable to run your VM. 

![Resource fragmentation](../../_assets/compute/resource-fragmentation.svg "Resource fragmentation")

For example, a dedicated host from this diagram has 56 vCPUs (2 × 28) available to a user, but you can use it to run only eight VMs with six vCPUs each. A VM cannot use vCPUs from different physical CPUs at once.

In this case, you can run two more VMs with four vCPUs each to fully use the dedicated host's vCPUs.

### Local and network disks {#resource-disks}

Each dedicated host has multiple local disks available. Their number and size depend on the selected host configuration (see [above](#host-types)).

You can attach network and local disks to VMs on dedicated hosts. Make sure the configuration meets the following requirements:

* VM boot disk must be a network disk. Local disks can only be used as secondary ones.
* All network disks must be in the same availability zone as the group of dedicated hosts.
* You can only attach an entire local disk to a VM. For example, when attaching a disk to a VM on a host of the `intel-6338-c108-m704-n3200x6` type, specify the exact disk size: `3198924357632`.
* You cannot attach a single disk to two or more different VMs at the same time.

When working with local disks attached to VMs on dedicated hosts, you cannot:

* Change an existing VM's RAM and CPU. To modify these parameters, recreate the VM.
* Attach additional network disks to a `stopped` VM. You can only attach additional network disks to a [running](../operations/vm-control/vm-stop-and-start.md#start) VM.
* Attach additional local disks to a VM or delete the attached ones. To change the local disks attached, recreate the VM. For more information about creating VMs with local disks on dedicated hosts, see the [guides](../operations/index.md#dedicated-host).

You can connect a local disk to a VM on a dedicated host only if you [create](../operations/dedicated-host/running-host-vms.md) the VM using the [YC CLI](../../cli/cli-ref/compute/cli-ref/instance/create.md) or [API](../api-ref/Instance/create.md). To connect multiple local disks, when running the `yc compute instance create` command, set the `--attach-local-disk` parameter as many times as you need, once for each disk you are connecting.

If a dedicated host fails, the data stored on local disks will be lost. To ensure data security, set up replication yourself, e.g., using [{{ backup-full-name }}](../../backup/concepts/index.md).

## Host group size {#host-group-size}

When creating a host group, you need to specify the number of dedicated hosts. When updating the group, you can reduce or increase the number of hosts in it:

```
yc compute host-group create \
  --fixed-size <number_of_hosts> \
  ...
```

## Maintenance {#maintenance}

{{ compute-name }} performs host maintenance on a regular basis. Some maintenance activities run in the background without affecting user experience. Others require the host to be released of VMs. For the latter kind of maintenance:

* A new (replacement) host is added to the host group.
* The date for automatic release of the old host is calculated.

You can get the `host-id` and `server-id` values and the auto release date for the new host in the [management console]({{ link-console-main }}) on the **{{ ui-key.yacloud.compute.host-group.hosts.label_title }}** page or using this [CLI](../../cli/quickstart.md) command:

```bash
yc compute host-group list-hosts <host_group_ID>
```

Result:

```
+----------------------+----------------------+----------------------+--------------------------+
|          ID          |      SERVER ID       | REPLACEMENT HOST ID  |   REPLACEMENT DEADLINE   |
+----------------------+----------------------+----------------------+--------------------------+
| fhm1ab2mhnf3******** | fhmlabct12vp******** | fhmabcun12kb******** | 2023-10-24T12:36:14.321Z |
| fhmabcun12kb******** | fhm1a2bcsl13******** |                      |                          |
+----------------------+----------------------+----------------------+--------------------------+
```

Where:

* `REPLACEMENT HOST ID`: ID of the new (replacement) host.
* `REPLACEMENT DEADLINE`: Automatic host release date and time (UTC).

A host undergoing maintenance is not charged, not included in the host group size, and not used for deploying new VMs.

The auto release date and time are scheduled for the seventh day after dedicating the replacement host. {{ compute-name }} will start automatically releasing the host in the period from `REPLACEMENT DEADLINE` to `REPLACEMENT DEADLINE + 1 hour`. Depending on the type of your VMs:

* VMs with no local disks, GPUs, or [affinity](#bind-vm) to `host-id` will be [live migrated](live-migration.md).
* VMs with affinity to `host-id` will be stopped. You will need to either remove host affinity or update it to a new `host-id` and then restart the VM.
* VMs with local disks will first be stopped and, in 12 hours, change their status to `ERROR` with their local disks cleaned.

The auto release date can be shifted backwards or forwards by as much as 21 days after dedicating the replacement host. You can change the date using this command:

```bash
yc compute host-group update-host <host_group_ID> \
  --host-id <host_ID> \
  --replacement-deadline <deadline>
```

Where `--replacement-deadline` is the date and time in UTC format (`YYYY-MM-DDTHH:MM:SSZ`).

VMs are automatically moved based on the VM host affinity rules. A VM will be moved to any host in a host group that has sufficient resources, including the replacement host. If there are no resources, the VMs will be stopped.

You can move your VMs from the old host yourself before the specified date:

* Using [live migration](live-migration.md): To migrate your VMs, contact [support]({{ link-console-support }}).
* By [stopping and restarting](../operations/vm-control/vm-stop-and-start.md) your VMs in the [management console]({{ link-console-main }}) or with these CLI commands:

    ```bash
    yc compute instance stop <VM_name>
    ```

    ```bash
    yc compute instance start <VM_name>
    ```

* By [deleting](../operations/vm-control/vm-delete.md) and [recreating](../operations/vm-create/create-linux-vm.md) your VMs (for VMs with local disks).

Use the command below to learn which dedicated host the VM is actually running on:

```bash
yc compute instance get <VM_name>
```

Result:

```
...
host_id: <host_ID>
```

## Host issues {#malfunctions}

If the physical server is restarted, the VMs running on it will be restarted automatically and [linked](#bind-vm):

* To the same host group if the VM was linked to a group. In this case, you can link the VM to a different host in the group.
* To a dedicated host if the VM was linked to a specific host.

If the physical server is completely stopped, {{ compute-name }} proceeds as follows:

* Removes the physical server from the host group.
* Replaces the failed server with a new one (with a new `server-id`). In this case, the IDs of the host group (`host-group-id`) and the dedicated host (`host-id`) stay the same.
* Runs the VMs from the failed server based on the VM host affinity rules. In this case, VMs with no local disks run automatically, while those with local disks get the `ERROR` status. The contents of the local disks from the failed server are not moved to the new one.

## Linking a VM to a group or host {#bind-vm}

To uniquely map a VM and a physical server, you can create a VM that is linked:
* To a group of dedicated hosts:
  When the VM is stopped, it will not be available on the group hosts, and when it is restarted, it may be linked to a different host of the group.
* To the selected host of a group of hosts:
  When the VM is stopped, it will not be available on the host, and when it is restarted, it will be linked to the same host from the group.

Linking a VM ensures that it will run on the same physical server or group of servers even after scheduled maintenance.

To move a VM from one dedicated host to another:
1. [Stop the VM](../operations/vm-control/vm-stop-and-start).
1. Link the VM to a different host in the group.
1. Restart the VM.

When creating a VM, you can specify multiple host groups or specific hosts it can be linked to. Example of linking a VM to a host group:

```
yc compute instance create \
  --host-group-id <host_group_ID> \
  --network-interface subnet-name=default-{{ region-id }}-a \
  --zone {{ region-id }}-a
```

In this case, the VM will be linked to the specified host group:

```
done (33s)
id: abcdefghigkl********
folder_id: a1b23cd45efg********
...
placement_policy:               # VM host affinity rules
  host_affinity_rules:
    - key: yc.hostGroupId
      op: IN
      values:
        - <host_group_ID>
host_group_id: <host_group_ID>  # Actual VM location
host_id: <host_ID>              # Actual VM location
...
```

Rules in `host_affinity_rules` are combined via `OR`. For example, the following rules allow you to run VMs on any host of the `<host_group_ID>` group or the `<host_ID>` host:

```
placement_policy:
  host_affinity_rules:
    - key: yc.hostGroupId
      op: IN
      values:
        - <host_group_ID>
    - key: yc.hostId
      op: IN
      values:
        - <host_ID>
```

## Placement groups {#placement-groups}

We do not recommend using [placement groups](placement-groups.md) for VMs on dedicated hosts.


## Pricing {#billing}

For information about pricing for dedicated hosts, see [{#T}](../pricing.md#prices-dedicated-host).


## See also {#see-also}

* [{#T}](../operations/dedicated-host/create-host-group.md)
* [{#T}](../operations/dedicated-host/running-host-group-vms.md)
* [{#T}](../operations/dedicated-host/running-host-vms.md)
* [{#T}](../operations/dedicated-host/access.md)

_Intel and Xeon are trademarks of Intel Corporation or its subsidiaries._