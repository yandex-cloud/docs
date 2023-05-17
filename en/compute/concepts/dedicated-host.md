# Dedicated hosts

A _dedicated host_ is a physical server that is intended solely for hosting your VMs in {{ yandex-cloud }}. VMs on dedicated hosts have all features of regular VMs; additionally, they are physically isolated from other users' VMs. You can also distinguish your VMs used for different projects:

![Dedicated host](../../_assets/compute/dedicated-host.svg "Dedicated host")

You can create a group of one or more dedicated hosts of the same type. To optimize the use of resources, you can host multiple [VMs with different configurations](vm-platforms.md) on each dedicated host.

Advantages of using dedicated hosts:
* Security and compliance.
  You can use a dedicated host to physically isolate your VM in the public cloud if this is required by your company's information security service or industry standards, such as medical or financial ones.
* Using your own licenses.
  If your company has Microsoft licenses or those from other vendors that require linking to physical resources, you can use them in {{ yandex-cloud }} based on the _Bring your own license_ (BYOL) model.
* Managing your VM allocation.
  You can choose which dedicated host to run your VM on or allow {{ compute-name }} to do it automatically.

{% include [dedicated](../../_includes/compute/dedicated-quota.md) %}

To ensure fault tolerance of your infrastructure hosted on dedicated hosts, we recommend using at least two hosts for it.


## Types of dedicated hosts {#host-types}

The configuration of a dedicated host is determined by its _type_. Host types differ by their models and the number of available CPU cores, RAM size, and the number and size of local SSD disks.

You can specify the dedicated host type when creating a host group. This type will be assigned to every host in the group, and you will not be able to change it moving forward.

The number of free dedicated hosts of each type per [availability zone](../../overview/concepts/geo-scope.md) is limited and changes with time. When a host group is created or resized, {{ compute-name }} checks that there are enough dedicated hosts of this type. If there are not enough hosts, you will get an error.


### List of types {#host-types-list}

Current type: Intel<sup>®</sup> Ice Lake platform

| Type and processor<br>(Ice Lake platform) | Processors | Cores | vCPU^1^ | RAM, GB | Disks | Disk size |
|  --- | --- | --- | --- | --- | --- | --- |
| `intel-6338-c108-m704-n3200x6`<br>[Intel<sup>®</sup> Xeon<sup>®</sup> Gold 6338](https://ark.intel.com/content/www/ru/ru/ark/products/212285/intel-xeon-gold-6338-processor-48m-cache-2-00-ghz.html) | 2 | 64 | 108 | 704 | 6 | 3200 × 10^9^ B <br>(~ 2.91 TB) |

  
  You can only create hosts of this type in the `{{ region-id }}-a` and `{{ region-id }}-b` availability zones. For more information, see [{#T}](../../overview/concepts/ru-central1-c-deprecation.md).


{% cut "Archived types: Intel Cascade Lake" %}

{% note alert %}

Do not use archived types to create dedicated hosts. Select a current type instead (see above).

{% endnote %}

| Type and processor<br>(Cascade Lake platform) | Processors | Cores | vCPU^1^ | RAM, GB | Disks | Disk size |
| --- | --- | --- | --- | --- | --- | --- |
| `intel-6230-c66-m454`<br>[Intel Xeon Gold 6230](https://ark.intel.com/content/www/ru/ru/ark/products/192437/intel-xeon-gold-6230-processor-27-5m-cache-2-10-ghz.html) | 2 | 40 | 66 | 454 | 4 | 1600 × 10^9^ B <br>(~ 1,46 TB) |
| `intel-6230-c66-m704-n1600x4`<br>Intel Xeon Gold 6230 | 2 | 40 | 66 | 704 | 4 | 1600 × 10^9^ B <br>(~ 1,46 TB) |
| `intel-6230r-c84-m328-n3200x4`<br>[Intel Xeon Gold 6230R](https://ark.intel.com/content/www/ru/ru/ark/products/199346/intel-xeon-gold-6230r-processor-35-75m-cache-2-10-ghz.html) | 2 | 52 | 84 | 328 | 4 | 3200 × 10^9^ B <br>(~ 2.91 TB) |
| `intel-6230r-c84-m454-n3200x4`<br>Intel Xeon Gold 6230R | 2 | 52 | 84 | 454 | 4 | 3200 × 10^9^ B <br>(~ 2.91 TB) |

{% endcut %}

The above lists of the current and archived types are provided for indicative purposes and may change. You can get an up-to-date list of types (both current and archived) in the following ways:

* In the [management console]({{ link-console-main }}), on the dedicated host group creation page in {{ compute-name }}.
* In the CLI by running the `yc compute host-type list` command (to learn more, see [creating a group](../operations/dedicated-host/create-host-group.md)).

^1^ This specifies the number of vCPUs where you can run VMs. Other vCPUs of the host are allocated for system usage (for more information, see [below](#resource-fragmentation)): on the Intel Xeon Gold 6230 processors, there are 14 vCPUs, while on Intel Xeon Gold 6230R and Intel Xeon Gold 6338 processors, there are 20 vCPUs.

## Using physical resources of a host {#resource}

### Processor fragmentation {#resource-fragmentation}

There are two processors installed on a physical server. However, not all their cores are available for running VMs. Some cores are allocated for system usage.

For example, a dedicated host with two Intel Xeon Gold 6230 processors can use 66 vCPUs to run VMs (34 on the first processor and 32 on the second one). The remaining 14 vCPUs (6 + 8) are used by the system.

When creating a VM on a dedicated host, you may encounter resource fragmentation, when the number of free vCPUs is sufficient, but you are unable to run your VM. For example, you can only run 10 VMs with 6 vCPUs each on a dedicated host with 66 vCPUs.

![Resource fragmentation](../../_assets/compute/resource-fragmentation.svg "Resource fragmentation")

In this case, you can run two VMs with two and four vCPUs to use the dedicated host's vCPUs at full capacity.


### Local and network disks {#resource-disks}

Each dedicated host has multiple local disks available. Their number and size depend on the selected host configuration (see [above](#host-types)).

You can attach network and local disks to VMs on dedicated hosts. Make sure the configuration meets the following requirements:

* VM boot disk must be a network disk. Local disks can only be used as secondary ones.
* All network disks must be in the same availability zone as the group of dedicated hosts.
* You can only attach an entire local disk to a VM. For example, when attaching a disk to a VM on an `intel-6338-c108-m704-n3200x6` host, specify the exact disk size: `3200000000000`.
* You cannot attach a single disk to two or more different VMs at the same time.

You can only attach local disks to a VM while creating it. For more information about attaching disks, see [our guides](../operations/index.md#dedicated-host). To change the disks attached to an existing VM, you will have to recreate it.


## Scaling policy {#scale-policy}

When creating a host group, specify the number of dedicated hosts. When updating the group, you can reduce or increase the number of hosts in it. The scaling policy is defined by the `ScalePolicy` parameter:

```
yc compute host-group create \
  --fixed-size <number of hosts> \
  ...
```

Where `fixed-size` is the number of dedicated hosts in the group.

## Maintenance policy {#maintenance-policy}

{{ compute-name }} stops VMs during maintenance without moving them to other hosts. How the VMs behave afterwards depends on the physical server status.

If the physical server is restarted, the VMs running on it are automatically restarted, too, and linked:
* To the same host group if the VM was linked to any group. In this case, the VM may be linked to a different host in the group.
* To a dedicated host if the VM was linked to a specific host.

The maintenance policy is set when creating a group of dedicated hosts and defined by the `MaintenancePolicy` parameter:

```
yc compute host-group create \
  --maintenance-policy restart \
...
```

Where `maintenance-policy` is the maintenance policy. The possible value is `restart`, which stops VMs for maintenance and restart them afterwards.

If the physical server is completely stopped, {{ compute-name }} performs the following:
1. Disables access to your dedicated host.
1. Deletes the physical server and its unique ID (`server-id`). In this case, the IDs of the host group (`host-group-id`) and each dedicated host (`host-id`) are retained.
1. Replaces failed hardware and assigns a new ID.
1. Migrates VMs from failed hardware to the new one based on the [VM linking rules](#bind-vm).

## Linking a VM to a group or host {#bind-vm}

To uniquely map a VM and a physical server, you can create a VM that is linked:
* To a group of dedicated hosts.
  When the VM is stopped, it will not be available on the group hosts, and when it is restarted, it may be linked to a different host of the group.
* To the selected host of a group of hosts.
  When the VM is stopped, it will not be available on the host, and when it is restarted, it will be linked to the same host from the group.

Linking a VM ensures that it will run on the same physical server or group of servers even after scheduled maintenance.

To move a VM from one dedicated host to another:
1. [Stop the VM](../operations/vm-control/vm-stop-and-start).
1. Link the VM to a different host in the group.
1. Restart the VM.

When creating a VM, you can specify multiple host groups or specific hosts it can be linked to. Example of linking a VM to a host group:

```
yc compute instance create \
  --host-group-id 1 \
  --network-interface subnet-name=default-{{ region-id }}-a \
  --zone {{ region-id }}-a
```

In this case, the VM will be linked to one of the specified host groups:

```
done (33s)
id: abcdefghigklm12no3pq
folder_id: a1b23cd45efg6higklmn
created_at: "2020-09-08T20:19:41Z"
zone_id: {{ region-id }}-a
platform_id: standard-v2
resources:
  memory: "2147483648"
  cores: "2"
  core_fraction: "100"
host-group-id: 2
...
```

## Pricing {#billing}

For information about pricing for dedicated hosts, see [{#T}](../pricing.md#prices-dedicated-host).


_Intel and Xeon are trademarks of Intel Corporation or its subsidiaries._