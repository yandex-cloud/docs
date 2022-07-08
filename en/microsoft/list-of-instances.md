# Windows VM images


The {{ marketplace-name }} offers a wide choice of products:

* VMs with the pre-installed Windows Server operating system.
* VMs with activated Remote Desktop Services supporting a different number of remote desktops.
* Pre-configured Microsoft SQL Server images.




## Windows Server images {#win-server}

The {{ marketplace-name }} provides images with Microsoft Windows Server Datacenter Edition only:

* [Windows Server 2012 R2](/marketplace/products/yc/windows-server-2012r2-datacenter)
* [Windows Server 2016](/marketplace/products/yc/windows-server-2016-datacenter)
* [Windows Server 2019](/marketplace/products/yc/windows-server-2019-datacenter)



### Remote Desktop Services (RDS) {#rds}

The {{ marketplace-name }} provides [Windows RDS](/marketplace?tab=software&search=windows+rds) images based on [Windows Server 2019 Datacenter](/marketplace?tab=software&search=Windows+Server+2019+Datacenter) with the pre-activated Remote Desktop Licensing Server role and a custom license package. You can choose from RDS license packages of [5](/marketplace/products/yc/windows-rds-5-licenses), [10](/marketplace/products/yc/windows-rds-10-licenses), [25](/marketplace/products/yc/windows-rds-25-licenses), [50](/marketplace/products/yc/windows-rds-50-licenses), [100](/marketplace/products/yc/windows-rds-100-licenses), [250](/marketplace/products/yc/windows-rds-250-licenses) or [500](/marketplace/products/yc/windows-rds-500-licenses) licenses.

{% note warning %}

Images with pre-activated RDS are not optimized using the `sysprep` utility and have a constant SID. This may cause conflicts if two VMs with the same number of licenses are running in the same domain.

{% endnote %}



### Changes to Windows VM images {#changes}

To work in the cloud, changes have been made to the operating system to anonymize it and delete temporary files.

#### Configuration of network services {#configuration}

* Windows remote management is enabled using the WinRM service. Rules that allow WinRM to run via HTTPS were created.
* Rules that allow using ICMP were created.
* The names of the network interfaces correspond to the names on the {{ yandex-cloud }} platform.
* RDP is enabled in the system registry, and the required rules and corresponding network ports have been configured.

#### Power saving settings {#power-saving-settings}

* The system's power plan is set to <q>High performance</q>.

#### Time settings {#time-settings}

* The `RealTimeIsUniversal` parameter is set, meaning that the hardware time is [UTC+0](https://en.wikipedia.org/wiki/Coordinated_Universal_Time).

#### Other conversions {#conversions}

* The `ShutDownWithoutLogon` registry parameter allows responding to ACPI Call without having an interactive session.
* SMBv1 is disabled.
* The [serial console](https://docs.microsoft.com/en-us/windows-hardware/drivers/devtest/boot-parameters-to-enable-ems-redirection) is enabled.
* The system is optimized using the [Ngen](https://en.wikipedia.org/wiki/Native_Image_Generator) utility.
* The `cloudbase-init` utility is installed to automate operations when initializing VMs.

### Drivers {#drivers}

To run VMs on Microsoft Windows, you need `virtIO` drivers for network and disk devices. The drivers are provided by the Fedora Project. VM images use the latest available stable version of the drivers that can be [downloaded](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.185-2/) from the software developer's website.



## Microsoft SQL Server images {#sql}

Microsoft SQL Server images available in the {{ marketplace-name }} are VMs with pre-installed Windows Server and Microsoft SQL Server. Available SQL Server versions for:

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

The images have pre-activated licenses and store the activation key. If you need to change or add components to the system, the Microsoft SQL Server distribution is located in a separate directory in the root of the system drive (by default, `C:\`).

