
# General questions about {{ compute-name }}

#### Why use cloud computing? {#benefits}

{{ yandex-cloud }} offers scalable computing capacity: you can quickly create and start [VMs](../../compute/concepts/vm.md) on demand and stop them when the load decreases. By leveraging cloud resources, you reduce your IT infrastructure costs as you pay only for the resources you actually consume.

Cloud infrastructure is easier to manage, so you can focus on your business tasks rather than maintaining servers.

#### What can I do with a {{ yandex-cloud }} VM? {#what-can-i-do}

* Use only the computing capacity you really need. You do not have to buy expensive, powerful equipment for every business task that requires it. Instead, you can create a {{ yandex-cloud }} VM and use it if and when required.
* Quickly [scale computing power](../../compute/tutorials/vm-autoscale/index.md) up or down as needed. You can start additional VMs during peak periods and stop them when the load drops.
* Use VMs to deploy applications that must [always be available](../../tutorials/infrastructure-management/fault-tolerance.md). You do not need to worry about guaranteeing server uptime: {{ yandex-cloud }} will keep it running smoothly. Focus on building your software.
* [Configure backups](../../compute/tutorials/hystax-backup.md) to easily recover your data in the event of data loss.
* Create and distribute VM [disk images](../../compute/concepts/image.md). You can use images to quickly deploy your software on other VMs.
* Automate VM management using the API and scripts in the CLI.

For more information about {{ yandex-cloud }} VMs, see [{#T}](../../compute/concepts/vm.md).

#### How do {{ yandex-cloud }} VMs differ from regular hosting? {#better-than-hosting}

Traditional hosting offers resources on lease with pre-agreed performance for a fixed term. {{ yandex-cloud }} VMs enable you to use cloud resources as your personal data center. At the same time, you get all the advantages of the fault tolerant infrastructure {{ yandex-cloud }} data centers provide.

You can scale your cloud infrastructure as your performance requirements change. This way you can manage how many resources you are using at any given time and how much you pay for them.

You will also be able to monitor and manage the status of your VMs. You can [start and stop VMs](../../compute/operations/vm-control/vm-stop-and-start.md) as needed. You can set up your VM software configuration and change it as required. Disk images and [snapshots](../../compute/concepts/snapshot.md) enable you to easily transfer data between your VMs.

#### How do I get started with a {{ yandex-cloud }} VM? {#get-started}

You can create your first VM by following one of the scenarios described in [{#T}](../../compute/quickstart/index.md).

#### How do I access my VM? {#access-ssh}

You can connect to your VM from another VM within the same [cloud network](../../vpc/concepts/network.md#network). To connect, use the VM [internal IP address](../../vpc/concepts/address.md#internal-addresses) or [FQDN](../../vpc/concepts/address.md#fqdn).

If you assigned a [public IP address](../../vpc/concepts/address.md#public-addresses) to your VM when creating it, you can use that IP address to connect to the VM from the internet.

You can get IP addresses, FQDNs, and other information in the management console, under **{{ ui-key.yacloud.compute.instance.overview.section_network }}** on the VM page.

For more information, see [{#T}](../../compute/concepts/network.md).

[Use SSH](../../compute/operations/vm-connect/ssh.md) to connect to your Linux VMs. Use RDP to connect to your Windows VMs.

#### How quickly can I adjust the capacity of my IT systems? {#scalability}

You can adjust your IT system capacity in one of the following ways:
* Create VMs with the appropriate configuration and pre-installed software in advance. During peak loads, simply start these VMs to scale up your IT system capacity. When the load decreases, you can stop some of the VMs to avoid paying for extra resources.
* If you frequently need new VMs with the same configuration, you can create a boot disk image and use it when creating VMs.

#### Why is my VM running slowly? {#why-vm-slowly}

As with any servers, including physical ones, VM performance depends on the performance of the following:
* CPU
* RAM
* [Disks](../../compute/concepts/disk.md)
* Network

Note that the physical core thread allocated to your VM handles not only the vCPU, but also QEMU virtualization and I/O operations (both network and disk ones).

General best practices for improving VM performance:
1. For product solutions, use a vCPU with a guaranteed performance of at least 100%. If you are using a vCPU with performance below 100%, the vCPU performance may decrease to the guaranteed minimum due to other active processes on the same physical core. For example, for 5% performance, this is only about 100 MHz of clock frequency, which is most likely insufficient for a production server.

   If the graphs show that the vCPU load is close to 100% for a long time or at the time the issue occurs, we recommend increasing the number of cores.
1. Never use the swap file. It causes a significant drop in performance. The best solution is to expand vRAM if your system is running low on memory. With Linux, you can also use `zram-config`.
1. Use large network SSDs. Network disks can become a bottleneck in the system. They have limits on IOPS and bandwidth, which vary depending on the disk type and size. For more information, see [{#T}](../../compute/concepts/limits.md#compute-limits-disks).

   Keep in mind that disk performance also depends on the read and write request size. For details, see [{#T}](../../compute/concepts/storage-read-write.md).

   You should read and write data in several threads.
1. Note that network computing depends on the vCPU performance. To diagnose network problems, run synthetic tests that do not involve disk usage. If the issue is indeed related to a slow network, we recommend adding vCPUs and retesting.

#### Which operating systems do {{ yandex-cloud }} VMs support? {#os}

{{ yandex-cloud }} VMs support Linux and Windows operating systems.

Public boot disk images for popular distributions of these systems are available and tested in {{ yandex-cloud }}.

{% include [cli-period.md](../../_qa/cli-period.md) %}

{% include [fz-152.md](../../_qa/fz-152.md) %}

#### How do I contact support? {#support-channels}

You can contact support in the [Support]({{ link-console-support }}) section of the management console.

{% include [logs](../../_qa/logs.md) %}

#### How do I learn about the cost? {#pricing}

See the pricing for this service in [{#T}](../../compute/pricing.md). You can also use [our calculator]({{ link-cloud-calculator }}).