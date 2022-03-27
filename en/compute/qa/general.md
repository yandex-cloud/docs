---
title: "Cloud Computing. FAQ"
description: "What is cloud computing for? Yandex Cloud provides scalable cloud computing: you can quickly create and start virtual machines as needed and stop them if the load decreases. Using cloud computing reduces your IT infrastructure costs: you pay only for the resources you use."
---

# General questions about {{ compute-name }}

#### What is cloud computing used for? {#benefits}

{{ yandex-cloud }} provides scalable computing capacity: you can quickly create and start VMs when necessary and stop them if the load drops. The usage of cloud resources reduces your IT infrastructure costs because you pay only for the resources you use.

It's easier to manage a cloud infrastructure so you can focus on your business challenges instead of server maintenance.

#### What can I do with {{ yandex-cloud }} VMs? {#what-can-i-do}

* Use only those computing resources which are necessary to meet your needs. If you need expensive powerful systems, you don't have to buy them. You can create a VM in {{ yandex-cloud }} and use it whenever necessary.
* Quickly scale processing capacity to meet your needs. You can start additional VMs during peak times and stop them when the load is low.
* Use your VMs to deploy applications that must be always available. You don't need to worry about guaranteeing server uptime: {{ yandex-cloud }} will keep it running smoothly. Focus on creating applications that work.
* Configure backups to make it easier to restore your data in the event of loss.
* Create and distribute VM disk images. You can use images to quickly deploy your software on other VMs.
* Automate VM management using the API and scripts in the command line interface.

For more information about {{ yandex-cloud }} VMs, see [{#T}](../concepts/vm.md).

#### How do {{ yandex-cloud }} VMs differ from regular hosting? {#better-than-hosting}

Traditional hosting offers you resources on lease with pre-agreed performance for a fixed time. {{ yandex-cloud }} VMs let you use cloud resources like your personal data center. At the same time, you receive all the advantages of the resilient infrastructure of Yandex's data centers.

You can scale your cloud infrastructure as your performance requirements change. This way you can control how many resources you are using at any given time and how much you pay for them.

You also get full control over the status of your VMs. You can start and stop VMs when you need to. You can set up your VM software configuration and change it as necessary. Disk images and snapshots let you easily transfer data between your VMs.

#### How do I get started with {{ yandex-cloud }} VMs? {#get-started}

You can create your first VM using one of the methods described in [{#T}](../quickstart/index.md).

#### How do I get access to a VM? {#access-ssh}

You can connect to a VM from another VM in the same cloud network. Use the VM's internal IP address or FQDN to do this.

If a public IP address was assigned to the VM when it was created, you can use it to connect to the VM from the internet.

You can find out the IP addresses, FQDN and other information in the management console (go to the **Network** section on the virtual machine's page).

For more information, see [{#T}](../concepts/network.md).

To connect to Linux VMs, [use SSH](../operations/vm-connect/ssh.md). Connect to Windows VMs over RDP.

#### How quickly can I change the performance of my information systems? {#scalability}

You can change the performance of your information system in one of the following ways:
* Create VMs in advance with the appropriate characteristics and pre-installed software. During peak times, you will just need to start these VMs to increase the performance of the information system. When the load drops, you can stop some of the VMs so that you will not have to pay for consuming extra resources.
* If you frequently need new VMs with the same configuration, you can create a boot disk image and use it when creating VMs.

#### Why is the VM running slowly? {#why-vm-slowly}

As for any servers, including physical ones, the VM performance depends on the performance of the:
* CPU.
* RAM.
* Disks.
* Networks.

Note that the physical core thread allocated to your VM handles, in addition to the vCPU itself, the qemu virtualization process and I/O operations (networks and disks).

General recommendations for improving VM performance:
1. For product solutions, use a vCPU with a guaranteed performance of at least 100%. If you use a vCPU with performance below 100%, then the vCPU performance may drop to the guaranteed level when "neighbors" appear on the physical core. For example, for a share of 5%, this is only about 100 MHz of clock frequency, which is most likely insufficient for a product server.

   If the graphs show that the load on the vCPU is close to 100% for a long time or at the time the issue occurs, we recommend increasing the number of cores.
1. Never use the swap file. It causes a significant drop in performance. The best solution is simply to expand the vRAM if there isn't enough memory. With Linux, it's acceptable to use the `zram-config` utility.
1. Use large network SSDs. The weak point of the system may be network drives. They are subject to the limits of IOPS and bandwidth, which depend on the disk type and size. For more information, see [{#T}](../concepts/limits.md#compute-limits-disks).

   Also keep in mind that disk performance depends on the size of the write and read request. See [{#T}](../concepts/storage-read-write.md).

   You should read and write data in several threads.
1. Remember that network computing depends on the vCPU performance. Run synthetic tests that don't affect disk usage to diagnose network problems. If it does have to do with a slow network, we recommend adding a vCPU and retesting it.

#### What operating systems are supported by {{ yandex-cloud }} VMs? {#os}

Linux and Windows operating systems are supported.

Public boot disk images that have been tested in {{ yandex-cloud }} are available for popular distributions of these systems.

{% include [qa-fz-152.md](../../_includes/qa-fz-152.md) %}

#### How do I contact technical support? {#support-channels}

You can contact technical support in the management console under [Support]({{ link-console-support }}).

{% include [qa-logs.md](../../_includes/qa-logs.md) %}