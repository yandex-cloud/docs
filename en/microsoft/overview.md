# Microsoft in {{ yandex-cloud }}

You can run familiar software and your Windows-based products in {{ yandex-cloud }} and use all the advantages of cloud technologies. Work with a reliable cloud storage and network infrastructure and scale computing capacity to meet your needs.

{{ compute-full-name }} provides tools to help you create Windows applications and services in the cloud:

* Create VMs running Microsoft Windows from ready-made images in the [{{ marketplace-name }}](/marketplace).
   {% if product == "yandex-cloud" %}
* Use the features of SQL Server in [{{ mms-short-name }}](/services/managed-sqlserver) or in pre-configured {{ marketplace-name }} products. You can also use your SQL Server licenses in the {{ yandex-cloud }} infrastructure.
   {% endif %}
* Configure Active Directory and Microsoft Exchange on a VM.
* Run .NET applications on VMs in [{{ compute-name }}](/services/compute){% if product == "yandex-cloud" %} or as a function in [{{ sf-name }}](/services/functions){% endif %}.

To learn more about the features of VM images in {{ yandex-cloud }}, go to [{#T}](list-of-instances.md).

For more information about how to use your own licenses, see [{#T}](licensing.md#byol).

{% include [ms-licensing-personal-data-note](../_includes/ms-licensing-personal-data-note.md) %}

## Windows Server {#win-server}

Create VMs with Microsoft Windows Server to run Windows applications. Multiple system versions are available in Datacenter edition in {{ marketplace-name }}:

* [Windows Server 2012 R2](/marketplace/products/yc/windows-server-2012r2-datacenter)
* [Windows Server 2016](/marketplace/products/yc/windows-server-2016-datacenter)
* [Windows Server 2019](/marketplace/products/yc/windows-server-2019-datacenter)

When creating VMs, you should specify their [performance level](../compute/concepts/performance-levels.md) and the guaranteed number of vCPUs to be reserved for your VM. In this case, the vCPU will only process computing and network operations within the reserved performance level. Use VMs with a guaranteed vCPU share below 100% for testing and running applications that do not require high performance.

{% include [initialization-windows-vm](../_includes/initialization-windows-vm.md) %}

### Graphics accelerators (GPUs) {#gpus}

Windows Server 2016 and Windows Server 2019 Datacenter edition are available with GPUs.

{% if product == "cloud-il" %}

GPUs are used for ML, AI, and 3D rendering tasks. They run in [TCC](https://docs.nvidia.com/nsight-visual-studio-edition/reference/index.html#tesla-compute-cluster) mode and are powered by the CUDA<sup>®</sup> technology. To use a GPU, you don't need a license or a license server.

For more information about using GPUs in {{ yandex-cloud }}, see [{#T}](../compute/concepts/gpus.md).

{% endif %}


{% if product == "yandex-cloud" %}

### Remote Desktop Services (RDS) {#rds}

Remote Desktop Licensing Server (RDS) is a Windows Server service that lets you configure secure access to virtual and remote desktops in the cloud. With RDS, you can simultaneously run multiple sessions to connect to your VMs.

All VM images available in the {{ marketplace-name }} have two RDS licenses for administration. If you need a larger number of remote sessions, use images with pre-activated [Remote Desktop Services](/marketplace?tab=software&search=windows+rds) from {{ marketplace-name }}.

They are based on Windows Server 2019 Datacenter and are suitable for increasing the number of sessions for all Windows Server versions available in the {{ marketplace-name }}.

{% endif %}


{% if product == "yandex-cloud" %}

## SQL Server {#sql-server}

Microsoft SQL Server is a database management system. You can use SQL Server on our infrastructure or as an additional tool to ensure high availability of your systems.

{{ marketplace-name }} provides Microsoft SQL Server images pre-installed on Windows Server. Available SQL Server versions for:

* Web:
  * [Microsoft SQL Server 2016](/marketplace/products/yc/sql-server-2016-web)
  * [Microsoft SQL Server 2017](/marketplace/products/yc/sql-server-2017-web)
  * [Microsoft SQL Server 2019](/marketplace/products/yc/sql-server-2019-web)

* Standard:
  * [Microsoft SQL Server 2016](/marketplace/products/yc/sql-server-2016-standard)
  * [Microsoft SQL Server 2017](/marketplace/products/yc/sql-server-2017-standard)
  * [Microsoft SQL Server 2019](/marketplace/products/yc/sql-server-2019-standard)

* Enterprise:
  * [Microsoft SQL Server 2016](/marketplace/products/yc/sql-server-2016-enterprise)
  * [Microsoft SQL Server 2017](/marketplace/products/yc/sql-server-2017-enterprise)
  * [Microsoft SQL Server 2019](/marketplace/products/yc/sql-server-2019-enterprise)

Instead of pre-activated VM images from the {{ marketplace-name }}, you can use {{ mms-name }} and let us take care of DB maintainance.

If you already have a Microsoft SQL Server license, you can migrate it to {{ compute-name }} VMs. For more information about Microsoft SQL Server licenses in a virtual environment, see [{#T}](licensing.md#SQLmobility).

{% endif %}


## Creating failover clusters {#clustering}

A failover cluster is a group of independent VMs that work together to ensure high availability and service continuity.

Windows Failover Cluster uses dynamic IP addresses that are reassigned to cluster nodes by sending `gARP` packets. These packets notify you of changes in the IP and MAC address binding within a broadcast domain. As a rule, cloud providers do not support the transmission of such packets at all or only support it in a limited way.

There are two ways to create a failover SQL Server cluster in {{ yandex-cloud }}:

1. Using [multisubnetfailover](../tutorials/windows/mssql-alwayson.md#configure-always-on) and additional IP addresses of network interfaces where static routes are configured. Cluster nodes will be located in different subnets. To ensure this, specify multiple IP addresses in the `connection string` parameter.
1. Using an [internal network load balancer](../network-load-balancer/concepts/internal-load-balancer.md). Traffic will be redirected depending on [health checks](../network-load-balancer/concepts/health-check.md) performed on ports. However, these ports will only be [available](../network-load-balancer/concepts/internal-load-balancer.md#notes) to the {{ network-load-balancer-name }}.
