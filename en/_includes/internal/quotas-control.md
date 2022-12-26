# Managing quotas and resources

To start using a resource in MDB:

1. Get a quota using one of the following methods:
   * [Order a quota or request it from the parent service in Dispenser](#order).
   * [Pass a quota from Qloud](#exchange-qloud).
   * [Pass equipment in exchange for the quota](#exchange-hardware).
1. Read the MDB documentation:

   * [{{ mch-full-name }}](https://doc.yandex-team.ru/cloud/managed-clickhouse/).
   * [{{ mmg-full-name }}](https://doc.yandex-team.ru/cloud/managed-mongodb/).
   * [{{ mpg-full-name }}](https://doc.yandex-team.ru/cloud/managed-postgresql/).

1. Create a cluster via the [management console](https://yc.yandex-team.ru/), the [CLI](https://wiki.yandex-team.ru/MDB/quickstart) or API.
1. Make sure MDB databases are accessible from the Yandex internal network via [Puncher](https://puncher.yandex-team.ru/).
1. Make sure there's [access to ABC](../../mdb/access.md) or request it.

   You need to be the _MDB administrator_ in the appropriate ABC project to perform operations on clusters. To assign a role in the ABC interface, click **Add employee or department** (use **+** in the **Team — X persons and Y bots** line).

   If there's no access, operations on clusters will result in the error `You do not have permission to access the requested object or object does not exist`.

1. [Configure access to MDB databases from the Yandex internal network](https://wiki.yandex-team.ru/mdb/faq/mdbconnect).

## Viewing available resources {#list}

{% list tabs %}

- Management console

   To view your cloud quotas, [follow the link]({{ link-console-quotas }}). Quotas are shown for a specific ABC service, not including child resources.

   You can also view quotas and their consumption in [Dispenser]({{ link-dispenser }}). By default, quotas are shown with the hierarchy of projects in ABC (child resources).

   {% note warning %}

   In Sandy Bridge (`db1.*`) hosts, the limit on RAM is twice as the guarantee. For example, in `db1.small` hosts, the guarantee is 8 GB and the limit is 16 GB. In quotas, the resource consumption is tracked based on the guarantee, while the management console shows the limits. In later generations, this issue is resolved and the guarantee is the same as the limit.

   {% endnote %}

{% endlist %}

## Ordering a quota {#order}

1. Find your service in Dispenser. If there's none, create one in ABC. Data syncing between ABC and Dispenser can take up to 4 hours.
1. Make sure to have the required quota.
1. If there's no such quota, contact the user responsible for the upper-level service, and if there's none, the service manager.

   {% note info %}

   In the ABC hierarchy, each service has a quota manager or a responsible user. In Dispenser, they are displayed as <q>Responsible</q>, and in ABC as users with the <q>Quota manager</q> role.

   {% endnote %}

1. When you make a request in Dispenser, a task is created in the `DISPENSER` queue. Indicate the quota order number in the task if the quota is requested from the order. If a free quota is not allocated for your business unit, summon Pavel Amelichkin (`amatol`) or Vladimir Borodin (`d0uble`) and ask to allocate one.

   If you request a vCPU quota over 80 and an NVMe SSD storage quota over 4 TB or vCPU over 40 and the respective storage quota over 2 TB, summon the user responsible for your cloud capacity and Vladimir Borodin (`d0uble`) to get their approval.

1. After quota is allocated, it can take up to 20 minutes to sync quota data between Dispenser and IAM services.

{% note info %}

If you need to immediately upgrade the host class in a cluster in your project (the load surged, your applications are unstable with the current load, and so on), for an urgent quota request, contact Pavel Amelichkin (`amatol`) or Vladimir Borodin (`d0uble`) on Telegram. Describe your reasons and indicate necessary resources and the ABC service slug in your project.

{% endnote %}

## Exchanging a Qloud quota {#exchange-qloud}

You can exchange your Qloud quota for an MDB quota:

1. Check with Vladimir Borodin (`d0uble`) if that's possible.
1. Create a task in the `st/QLOUDRES` queue to allocate an MDB quota from Qloud resources.

## Exchanging equipment for quotas {#exchange-hardware}

You can exchange your equipment for a quota for your cloud. To do this:

1. [Check requirements for the equipment](#requirements) and [upgrade](#update-hardware) it if necessary.
1. [Calculate the available quota based on the specifications of your equipment](#calculate-quota).
1. Find servers in Wall-E, bot, or golem projects and take off the load of them.
1. In the Wall-E project, select **Switch VLANs** → **Parking** or locate servers in RackTables and move their VLANs to the `999` zone.
1. Remove the servers from the Wall-E project.
1. [Fill out the form](https://forms.yandex-team.ru/surveys/25942/).

### Requirements for equipment {#requirements}

* Processors at least E5-2660 v4 (2660 v4, 2683 v4, and so on).
* The vCPU to RAM ratio should be 1:4 or 1:8, but with the XEON 6230 processor, 512 GB RAM is enough (1:6.4 ratio).
* At least 1920 GB of at least 4 SSDs. There should be the even number of disks of the same size.
* The SSD to vCPU ratio should be at least 90:1.
* 10 Gbps network connection.

{% note warning %}

SSDs of less than 960 GB and HDDs of less than 12 TB cannot be used in this configuration.

{% endnote %}

### Upgrading hardware {#update-hardware}

If you have servers with suitable processors but lack the amount of RAM or SSDs, send a request for upgrade to [helpdc@yandex-team.ru](mailto:htlpdc@yandex-team.ru) or create a task in the `st/ITDC` queue. Make sure to mention that the hardware will be passed to MDB in exchange for a quota.

You can send your request to the VLA, SAS, and MAN data centers.

### Calculating equipment in quotas {#calculate-quota}

A vCPU quota is calculated as follows:

```text
(number_of_vCPUs_on_server - 1) * 0.96.
```

One vCPU is one server's logical core (with hyper threading).

A RAM quota in GB is calculated as follows:

```text
GB_of_RAM_of_server - 4 GB
```

4 GB of RAM is required for the Cloud's internal needs.

A quota of local SSD storage is calculated as follows:

```text
amount_of_raw_GBs_of_disk_on_server / 2) * 0.93
```

For quotas on local HDD storage, only servers with the even number of disks of 12 TB or 14 TB are accepted. Intel Broadwell (Xeon E5-2660 v4 or higher) and Intel Cascade Lake (Xeon Gold 6230) quotas, respectively, are allocated for them. A storage quota is calculated as follows:

* 10,240 GB of the quota is allocated for each 2 disks of 12 TB.
* 12,800 GB of the quota is allocated for each 2 disks of 14 TB.

## Requesting quota changes {#change}

To request quota changes, follow the [Dispenser instructions](https://wiki.yandex-team.ru/dispenser/ui/#quota-request).

Dispenser sends details of allocated quotas to MDB every 5 minutes. For this reason, you may have to wait up to 5 minutes after requesting quota changes until the quota is actually updated. Before synchronization finishes, you may get the `Quota limits exceeded` error when creating a cluster.

## Transferring quotas {#move}

Quotas are transferred between projects by a user responsible for the parent project of both projects. If this person isn't assigned, add to your ABC projects an employee with the <q>Quota manager</q> role. If the responsible person isn't available, you can concurrently transfer a quota via Dispenser on-duty personnel. To do this, create a task in the `DISPENSER` queue with the `duty` label.

## Transferring clusters between ABC services {#move-cluster}

To transfer a cluster between ABC services, you need to allocate a temporary quota in the cloud of the target service. To do this:

1. Create a request for a quota increase on the page of the target service. The request is sent to the user responsible for the upper-level service.
1. If there's an available quota, it'll be allocated. If no quota is available, [request users responsible for Dispenser](https://abc.yandex-team.ru/services/dispenser/duty/?role=940) to increase the quota.
1. Once a quota is allocated, move your cluster to the target folder via the management console.
1. Remove the temporary quota. To do this, contact the user responsible for the upper-level service or Dispenser on-duty personnel.
