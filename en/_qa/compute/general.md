
# General questions about {{ compute-name }}

#### What is cloud computing used for? {#benefits}

{{ yandex-cloud }} provides scalable computing capacity: you can quickly create and start [virtual machines](../../compute/concepts/vm.md) on demand and stop them when the load decreases. The usage of cloud resources reduces your IT infrastructure costs because you pay only for the resources you use.

It is easier to manage a cloud infrastructure so you can focus on your business challenges instead of server maintenance.

#### What can I do with a {{ yandex-cloud }} VM? {#what-can-i-do}

* Use only the computing capacity you really need. You do not have to buy expensive powerful equipment whenever there is a task that requires it. Instead, you can create a {{ yandex-cloud }} VM and use it if and when required.
* Quickly [scale the computing power](../../compute/tutorials/vm-autoscale/index.md) up or down as needed. You can start additional VMs during peak periods and stop them when the load drops.
* Use VMs to deploy applications that must [always be available](../../tutorials/infrastructure-management/fault-tolerance.md). You do not need to worry about guaranteeing server uptime: {{ yandex-cloud }} will keep it running smoothly. Focus on creating applications that work.
* [Configure backups](../../compute/tutorials/hystax-backup.md) to make it easier to restore your data in the event of loss.
* Create and distribute VM [disk images](../../compute/concepts/image.md). You can use images to quickly deploy your software on other VMs.
* Automate VM management using the API and scripts in the command line interface.

For more information about {{ yandex-cloud }} VMs, see [{#T}](../../compute/concepts/vm.md).

#### How do {{ yandex-cloud }} VMs differ from regular hosting? {#better-than-hosting}

Traditional hosting offers you resources on lease with pre-agreed performance for a fixed time. {{ yandex-cloud }} VMs allow you to use cloud resources as your personal data center. At the same time, you get all the advantages of the fault tolerant infrastructure {{ yandex-cloud }} data centers provide.

You can scale your cloud infrastructure as your performance requirements change. This way you can control how many resources you are using at any given time and how much you pay for them.

You will also have complete control over the VM status. You can [start and stop VMs](../../compute/operations/vm-control/vm-stop-and-start.md) when you need to. You can set up your VM software configuration and change it as required. Disk images and [snapshots](../../compute/concepts/snapshot.md) allow you to easily transfer data between your VMs.

#### How do I get started with a {{ yandex-cloud }} VM? {#get-started}

You can create your first VM by following one of the scenarios described in [{#T}](../../compute/quickstart/index.md).

#### How do I get access to a VM? {#access-ssh}

You can connect to a VM from another VM on the same [cloud network](../../vpc/concepts/network.md#network). Use the VM's [internal IP address](../../vpc/concepts/address.md#internal-addresses) or [FQDN](../../vpc/concepts/address.md#fqdn) to do this.

If you assigned a VM a [public IP](../../vpc/concepts/address.md#public-addresses) during creation, you can use that IP to connect to the VM from the internet.

You can get the IP addresses, FQDNs, and other information in the management console in to the **{{ ui-key.yacloud.compute.instance.overview.section_network }}** section on the VM's page.

For more information, see [{#T}](../../compute/concepts/network.md).

[Use SSH](../../compute/operations/vm-connect/ssh.md) to connect to Linux VMs. Use RDP to connect to Windows VMs.

#### How quickly can I change the performance of my information systems? {#scalability}

You can change the performance of your information system in one of the following ways:
* Create VMs in advance with the appropriate configuration and pre-installed software. During peak times, all you have to do is start these VMs to increase the performance of the information system. When the load decreases, you can stop some of the VMs to avoid paying for extra resources.
* If you frequently need new VMs with the same configuration, you can create a boot disk image and use it when creating VMs.

#### Why is my VM slow? {#why-vm-slowly}

Just like for any other servers, including physical ones, VM performance depends on the performance of:
* CPU
* RAM
* [Disks](../../compute/concepts/disk.md)
* Network

Please note: The physical core thread allocated to your VM handles, in addition to the vCPU itself, the qemu virtualization process and I/O operations (network and disk ones).

General recommendations for improving VM performance:
1. For product solutions, use a vCPU with a guaranteed performance of at least 100%. If you use a vCPU with performance below 100%, the vCPU performance may drop to the guaranteed level when "neighbors" appear on the physical core. For example, for a share of 5%, this is only about 100 MHz of clock frequency, which is most likely insufficient for a product server.

   If the graphs show that the load on the vCPU is close to 100% for a long time or at the time the issue occurs, we recommend increasing the number of cores.
1. Never use the swap file. It causes a significant drop in performance. The best solution is to expand the vRAM if there is not enough memory. With Linux, you can also use the `zram-config` utility.
1. Use large network SSDs. The weak point of the system may be network drives. They are subject to the limits of IOPS and bandwidth, which depend on the disk type and size. For more information, see the [{#T}](../../compute/concepts/limits.md#compute-limits-disks) documentation section.

   Keep in mind that disk performance also depends on the read and write request size. See [{#T}](../../compute/concepts/storage-read-write.md).

   You should read and write data in several threads.
1. Note that network computing depends on the vCPU performance. Run synthetic tests that do not affect disk usage to diagnose network problems. If it does have to do with a slow network, we recommend adding a vCPU and retesting it.

#### Which operating systems are supported by {{ yandex-cloud }} VMs? {#os}

Such VMs support Linux and Windows-based operating systems.

Public boot disk images that have been tested in {{ yandex-cloud }} are available for popular distributions of these systems.

{% include [cli-period.md](../../_qa/cli-period.md) %}


{% include [fz-152.md](../../_qa/fz-152.md) %}


#### How do I contact technical support? {#support-channels}

You can contact technical support in the [Support]({{ link-console-support }}) section of the management console.

{% include [logs](../../_qa/logs.md) %}

#### How do I learn about the cost? {#pricing}

You can lean how much the service will cost in [{#T}](../../compute/pricing.md). You can also use [our calculator]({{ link-cloud-calculator }}).