---
title: Data storage subsystem (Storage)
description: This article compares fault tolerance, disaster recovery, and backup models in VMware Cloud Director and {{ yandex-cloud }}. You will also learn about the different ways to approach data storage.
---

# Data storage subsystem (Storage)

## Fault tolerance and disaster recovery models {#disaster-recovery-models}

High availability systems are designed for protection from single foreseeable failures. Predictable components can include hardware components, such as power supply units, processors, or memory, as well as operating system errors and application faults.

High availability (HA) systems monitor components, detect failures, and restart resources. HA features are applied automatically without human intervention; however, they require additional backup components to restore an application on in case it fails. For example, if a virtualization server fails, the VMs it hosts will restart on different equivalent hardware. The downtime in this case will be almost the same as the time it takes to restart the instances.

HA typically requires a shared data storage, a pool of computing resources, and an orchestrator that selects a cluster node to start an instance on.

Disaster recovery (DR) includes workflows and human resources an organization needs to recover from a massive disruption, such as a power outage, fire in a data center, or cyber attack.

DR goes beyond high availability and does not depend on the data center or any other system level. It also implies distributing load across multiple geographically distributed locations, e.g., in a disaster recovery data center.

DR also dictates that all components should be independent to avoid situations where disaster recovery is impossible after a system or human error. Therefore, a cluster spread across multiple sites or any similar implementation are not disaster recovery solutions; they are more likely to fall within the scope of business continuity practices.

vCloud Director and {{ yandex-cloud }} provide a high level of fault tolerance and are similar in their architecture, but {{ yandex-cloud }} does not require additional modules or settings to use geo-redundancy, the way it is implemented in VMware.

## Comparing fault tolerance, disaster recovery, and backup models {#model-comparison}

### Fault tolerance models {#fault-tolerance-models}

#|
|| **VMware Cloud Director** | **{{ yandex-cloud }}** ||
|| In VMware, a datastore acts as a shared storage for a cluster. It is usually located in a data storage network or shared file storage accessible to all cluster nodes (ESXi hypervisors managed by vSphere vCenter).

If a node fails, the VM running on it will immediately restart on another node without losing time to transfer data, being located in a storage accessible to all cluster nodes.

An ESXi hypervisor group is, therefore, not an HA solution because it lacks an orchestrator to automatically select a node to run the load on. It is vCenter that provides dynamic load balancing across cluster nodes. 
| {{ yandex-cloud }} network and server hardware is deployed in three [availability zones](../../concepts/geo-scope.md). These host the platform's basic infrastructure: virtual networks, VMs, and network block storages.

Each availability zone is an infrastructure independent of other zones for all basic components: networks, storage resources, and computing resources.

Within a single zone, high availability of {{ compute-name }} and its associated services is achieved through similar scheduler tools. A scheduler decides which of thousands of cloud hosts to run the load on and how to distribute it in case a host fails. For more information on how schedulers work, see [this video](https://www.youtube.com/watch?v=ynkFYOFHn_Q&feature=youtu.be).

In addition, there are tools for increasing the availability of computing resources within a single availability zone. For example, [placement groups](../../../compute/concepts/placement-groups.md) allow you to distribute VMs in such a way that each of them would be reliably placed on a separate server rack in one of the availability zones. If one rack fails, the others will continue to run normally.

VM disks are created and operate in the Network Block Storage (NBS) subsystem that maintains operation of a distributed storage system within an availability zone. NBS is based on the Yandex Database ({{ ydb-short-name }}) technology that allows you to store metadata of client load blocks for all users. This distributed transactional DBMS ensures the performance required for NBS. Disks NBS currently provides come close to corporate storage systems in terms of performance. For more information about available disk types and their performance, see the relevant [documentation](../../../compute/concepts/limits#compute-limits-vm-disks.md). ||
|#

### Disaster recovery {#disaster-recovery}

#|
|| **VMware Cloud Director** | **{{ yandex-cloud }}** ||
|| In VMware, disaster recovery is commonly based on an independent vSphere cluster with separate storage resources for a datastore. In this scenario, the disaster recovery data center is entirely independent and does not get information about the load and state of the production one.

Data synchronization between datastores happens at the storage system level and is usually asynchronous. Additional solutions integrated with vCenter can act as an orchestrator that determines the logic of using either the production or the disaster recovery site.

Most often, for backup purposes, one will use Veeam DR or vCloud Availability integrated with vCloud Director.

A common business continuity solution is a stretched metro cluster with synchronous data replication between the sites at the storage system level. Synchronous data replication has a number of limitations, for example, on geographic distribution between the sites, as longer distances increase storage system latency.

VMware solutions for disaster recovery are typically used for sites located closely one to another to ensure synchronous replication of storage system data with acceptable latency of around 10 ms RTT, as in the case of metro clusters. For this reason, such solutions are used less often, since, in the cloud-native approach, it would be more feasible to delegate the logic of site failover to an application. A microservice architecture and container technologies, such as Kubernetes, solve this task, which makes solutions based on metro clusters with synchronous data replication inappropriate for most types of load. 
| {{ yandex-cloud }}'s DR can be viewed as an affordable out-of-the-box solution for most cloud services. Availability zones do not share any resources, while data replication methods depend on the cloud services in use.

For {{ compute-name }}, you can create a VM snapshot or image stored in an object storage and available in all zones and use it to deploy a VM.

[{{ objstorage-short-name }}](../../../storage/) provides a way to reliably store data in {{ yandex-cloud }} with high availability.

In {{ objstorage-short-name }}, the data is replicated across availability zones, which allows you to preserve both the data and access to it, even if one of the zones fails.

{{ objstorage-short-name }} data is accessible via an AWS S3-compatible API, which ensures support of a wide variety of applications and clients for accessing data. One example is [GeeseFS](../../../storage/tools/geesefs.md), which allows you to mount an object storage as a POSIX file system to replace block storage and create a cluster file system.

{{ objstorage-short-name }} supports secure client-server data exchange via the Transport Layer Security (TLS) protocol.

The support of versioning, encryption, access control lists, and object locks also makes this storage suitable for data backup and archiving. ||
|#

### Backups {#backup}

#|
|| **VMware Cloud Director** | **{{ yandex-cloud }}** ||
|| In VMware, you can move disk snapshots to a different infrastructure and use them to create VMs. Such solutions work on the block level and do not guarantee application data integrity. Granular recovery of individual files or elements of applications, such as a DBMS, is not guaranteed.

Dedicated backup systems maintain the integrity and manage the backup lifecycle. They often work on top of the technologies provided by such virtualization systems as snapshots.

To work with file systems, dedicated software (an agent) is usually used, which also manages specialized applications and ensures data is written correctly to the disk.

Agentless backup scenarios are also possible and involve installing backup software on the hypervisor host. At the same time, to enable the quiesce feature, the guest OS still has the virtualization system agent (guest tools) installed.

Backup system providers can use both approaches.

VMware does not recommend using disk snapshots as the only backup feature; this may undermine data integrity, since a VM snapshot is associated with the disk by means of the VM itself. 
| {{ yandex-cloud }} provides the following solutions for reliable data storage:

  * {{ objstorage-short-name }}: Data replication, versioning, object locks.

  * Managed database services: Backup tools native to each DBMS, e.g., [PostgreSQL](../../../managed-postgresql/concepts/backup.md).

  * {{ compute-name }}: A {{ backup-full-name }} service.

[{{ backup-full-name }}](https://yandex.cloud/ru/services/backup) uses an agent-based backup technology. Backup and recovery is available for [{{ compute-name }}](../../../compute/concepts/vm.md) VMs with [supported operating systems](../../../backup/concepts/vm-connection.md#os).

You can install a [{{ backup-name }} agent](../../../backup/concepts/agent.md) on the guest OS of a VM when creating the VM or after deploying it manually.

The agent is managed using [backup policies](../../../backup/concepts/backup.md#types) that define the backup schedule and type, full or incremental.

Backups are stored in {{ objstorage-short-name }}, which ensures high reliability of data storage.

When creating backups, agents can rely on various OS-level features, such as VSS or those built into the Linux kernel or drivers. ||
|#

## Approaches to data storage provision {#organization-approaches}

### VMware vCloud Director {#vmware-organization}

VMware provides VM disks in the form of disk files in various formats (VMDK, VHD, RAW). You can store them in any compatible storages, which may be local disks, storage networks, file storages, and VSAN (a software-defined storage system).

In this case, vCenter cluster nodes must have a shared data storage (datastore) for high availability. Reliability and performance of a datastore depend on the underlying storage system hardware. Modern storage system hardware has integration with VMware, which allows you to effectively provide the required storage resources to the virtualization platform.

Available technologies for higher reliability and storage optimization depend on the hardware class and may include:

* RAID erasure coding technologies for reliable storage, as well as data replication.

* Storage optimization tools, such as tiering: automatic placement of hot data on fast and expensive media and cold data, on slow and cheap media.

* Data deduplication and compression to minimize duplicate data on VM disks, thus significantly reducing storage space usage. However, note that using these technologies may affect the performance of the disk subsystem.

* Disk encryption.

vCloud Director users can select a required storage level mapped to a preset datastore configuration. Storage system manufacturers each have their own methods to limit the impact of _noisy neighbors_. These methods are usually hidden from the platform users.

The noisy neighbor effect is usually addressed through various tools implementing minimum performance guarantees for individual datastores, such as Storage QoS. If a VMware Cloud client intensely utilizes the disk subsystem, their disks with data can be transferred to a separate datastore provided by a dedicated controller and storage system disks.

In such transfers, data is copied to the new datastore using [Storage DRS](https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.resmgmt.doc/GUID-47C8982E-D341-4598-AC71-2CF2ABB644C0.html). Providers can do this manually or with partial automation. VM disk migration takes some time, which may affect the performance of the original datastore.

In some cases, users must provide a VM direct access to a separate LUN to the storage system or local disk (raw mapping), without placing data in the datastore file system. Performance of such disks may improve; however, they also have limitations:

* Such disks do not have a cluster file system and cannot be used by multiple VMs at once.
* VM with a raw-mapped disk is linked to the host such disk is provided to, so you cannot migrate it to another host automatically.

### VMware disk snapshots {#vmware-disk-snapshots}

VMware disk snapshots do not create full data copies, but merely redirect the new record to a separate file (COW) that allows you to keep the original data in case you need to roll back. This makes copying almost instant, and, once created, a snapshot does not use any space in the storage system. To work with storage systems, VMware features a dedicated API, VAAI, which allows you to maintain disk snapshots at the hardware level. Many storage system vendors support VAAI.

Since the VMware snapshot technology is one of the best-known out there, it is often what one may mean when mentioning snapshots in general. This is why backup system manufacturers leverage integration with VMware to create backups. However, you should also consider the limitations of VMware snapshots:

* They do not support RDM.

* Data consistency is ensured by the agent that must control writing to the disk from the VM's OS (quiescing).

* Snapshots cannot replace backups, even though backup system manufacturers often use them for such purposes.

* A large number of snapshots may hinder VM performance.

### VMware vSAN {#vsan}

[vSAN](https://www.vmware.com/products/cloud-infrastructure/vsan) is a standalone VMware offering which operates as a distributed software-defined storage system based on commodity or hyperconverged server hardware. As a separate VMware product, it requires licensing and qualified support.

At the software level, vSAN has similar features to enterprise storage systems, including synchronous data replication for building a metro cluster.

### NBS-based disks in {{ yandex-cloud }} {#yc-nbs}

{{ yandex-cloud }} uses a software-defined storage system, Network Block Storage (NBS). In terms of concepts, this storage system may be compared to vSAN. Each availability zone has its own NBS resources, which ensures high availability (shared storage) within a single availability zone, as well as low latency, high performance, and disaster recovery if any one availability zone fails. To recover data, you need to use the disk migration feature provided by {{ compute-name }} and {{ objstorage-name }}.

A VM virtual disk consists of placement blocks, each representing a storage area on physical disks. Replication and erasure coding ensure protection of placement block data (excluding NRD disks). Each placement block of every disk type has a predefined performance limit which is forcibly imposed by [throttling](../../../compute/concepts/storage-read-write.md#throttling) on the NBS side. Throttling properties depend on the type and size of the disks: with more placement blocks assigned to the disk, you get higher performance. For more information about disk performance levels, see the relevant [documentation](../../../compute/concepts/limits.md#compute-limits-disks).

Managing disk performance level allows you to avoid _noisy neighbors_ in cases when the load on the VM disk of one client affects the performance of another client's VM disk (if they share the same host).

#### Features of NBS disks {#ability-nbs}

1. [Disk encryption](../../../compute/concepts/encryption.md):
   
   You can encrypt VM disks with user-managed encryption keys. By default, all data on HDDs and SSDs is encrypted at the storage database level using a system key. In addition, cloud users can encrypt disks with custom keys. This way you can control access to encrypted data: create custom keys for specific users or tasks or promptly deactivate or delete certain keys.

1. [Local-SSD](../../../compute/concepts/dedicated-host.md#resource-disks):

   Local disks on dedicated hosts are provided directly to VMs residing on such a host. Such disks do not rely on the virtual network for performance. Local disks do not ensure hardware fault tolerance, which means it is the user that becomes responsible for preventing data loss; this can be arranged by using data mirroring (mdadm) or copying data at the application level.

1. [Disk snapshots](../../../compute/concepts/snapshot.md):

   Disk snapshots allow you to create copies of disk data. All snapshots you create are stored in {{ objstorage-name }}, which makes them available in any zone. A snapshot can be used independently, e.g., as a boot image of another VM.

1. Disk import:

   Cloud users can import disks from other virtualization systems and use them to create VMs in {{ yandex-cloud }}. The supported formats are VMDK, QCOW, and VHD. While being imported, disks are converted to the QCOW2 format that is compatible with {{ yandex-cloud }}.

1. File storages:

   This is a virtual file system you can attach to multiple {{ compute-name }} [VMs](../../../compute/concepts/vm.md) in the same availability zone. Users can share files in a storage and use them from different VMs. Each file storage resides in an availability zone where it is replicated for data protection. File storages are not replicated across availability zones.

A storage is attached to a VM through [Filesystem in Userspace](https://en.wikipedia.org/wiki/Filesystem_in_Userspace) (FUSE) as a [virtiofs](https://www.kernel.org/doc/html/latest/filesystems/virtiofs.html) device without a direct link to the host file system.