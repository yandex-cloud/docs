# General questions

#### What is cloud computing used for? {#benefits}

Yandex.Cloud provides scalable computing capacity: you can quickly create and start VMs when necessary and stop them if the load has dropped. The usage of cloud resources reduces your IT infrastructure costs: you pay only for the resources you use.

It's easier to manage a cloud infrastructure so you can focus on your business challenges instead of server maintenance.

#### What can I do with Yandex.Cloud virtual machines? {#what-can-i-do}

- Use only those computing resources which are necessary to meet your needs. If you need expensive powerful systems for that, you don't have to buy them. You can create a VM in Yandex.Cloud and use it when necessary.
- Quickly scale processing capacity to meet your needs. You can start additional VMs during peak times and stop them when the load is low.
- Use your VMs to deploy the applications that must be always available. You don't need to worry about guaranteeing server uptime — Yandex.Cloud will keep it running smoothly. Focus on creating programs that work.
- Configure backups to make it easier to restore your data in the event of loss.
- Create and distribute VM disk images. You can use images to quickly deploy your software on other VMs.
- Automate VM management using the API and scripts in the command line interface.

For more information about Yandex.Cloud VMs, see the section [[!TITLE]](../concepts/vm.md).

#### How do Yandex.Cloud VMs differ from regular hosting? {#better-than-hosting}

Traditional hosting offers you resources on lease with pre-agreed performance for a fixed time. Yandex.Cloud VMs let you use cloud resources like your personal data center. At the same time, you receive all the advantages of the resilient infrastructure of Yandex's data centers.

You can scale your cloud infrastructure as your performance requirements change. This way you can control how many resources you are using at any given time and how much you pay for them.

You also get full control over the status of your VMs. You can start and stop VMs when you need to. You can set up your VM software configuration and change it as necessary. Disk images and snapshots let you easily transfer data between your VMs.

#### How do I get started with Yandex.Cloud VMs? {#get-started}

You can create your first VM using one of the methods described in the section [[!TITLE]](../quickstart/index.md).

#### How do I get access to a VM? {#access-ssh}

You can connect to a VM from another VM in the same cloud network. Use the VM's internal IP address or FQDN to do this.

If a public IP address was assigned to the VM when it was created, you can use it to connect to the VM from the internet.

You can find out the IP addresses, FQDN and other information in the management console (go to the **Network** section on the virtual machine's page).

For more information, see the section [[!TITLE]](../concepts/network.md)

To connect to Linux VMs, [use SSH](../operations/vm-connect/ssh.md). Connect to Windows VMs via RDP.

#### How quickly can I change the performance of my information systems? {#scalability}

You can change the performance of your information system in one of the following ways:

- Create VMs in advance with the appropriate characteristics and pre-installed software. During peak times, you will just need to start these VMs to increase the performance of the information system. When the load drops, you can stop some of the VMs so that you will not have to pay for consuming extra resources.
- If you frequently need new VMs with the same configuration, you can create a boot disk image and use it when creating VMs.

#### What operating systems are supported by Yandex.Cloud VMs? {#os}

Linux and Windows operating systems are supported.

Public boot disk images that have been tested in Yandex.Cloud are available for popular distributions of these systems.

#### How do I contact technical support? {#support-channels}

You can contact technical support using any of these methods:

[!INCLUDE [support-channels](../../_includes/support-channels.md)]

