# Getting started with the {{ yandex-cloud }} plugin for Citrix Virtual Apps and Desktops

If you're working with [Citrix Virtual Apps and Desktops](https://www.citrix.com/products/citrix-virtual-apps-and-desktops/), you can deploy desktops running on this platform on {{ compute-full-name }} VMs. To do this, install the plugin developed by the {{ yandex-cloud }} team.

{% if product == "cloud-il" %}

## Create resources {{ yandex-cloud }} {#setup-resources}

{% note warning %}

All VMs created in this section must reside in the same [folder](../resource-manager/concepts/resources-hierarchy.md#folder) and the same [subnet](../vpc/concepts/network.md#subnet). Be sure to [enable egress NAT](../vpc/operations/enable-nat.md) for the subnet.

{% endnote %}

1. [Create a service account](../iam/operations/sa/create.md) to use with the Citrix Delivery Controller. You can also use an existing service account.
1. [Create a static access keys](../iam/operations/sa/create-access-key.md) for the service account.
1. [Create a bucket](../storage/operations/buckets/create.md) in {{ objstorage-full-name }}.
1. [Edit the bucket's ACL](../storage/operations/buckets/edit-acl.md) and grant the service account the `READ` and `WRITE` [permissions](../storage/concepts/acl.md#permissions-types).
1. [Create a Windows VM](../compute/operations/vm-create/create-windows-vm.md) in {{ compute-name }} to install the Citrix Delivery Controller. Under **Access**, select the service account you set up in the previous steps.
1. (optional) Create a Windows VM to install Citrix Studio, Citrix Storefront, and Citrix License Server. You can use an individual VM for each of these components, install the components on a standalone VM or a VM allocated for the Citrix Delivery Controller (in this case, there is no need to create new VMs).
1. Connect to the created VMs (for example, [via RDP](../compute/operations/vm-connect/rdp.md)) and install the components on them according to the [instructions](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops/install-configure/install-core.html) given in the Citrix documentation.
1. [Create a Windows VM](../compute/operations/vm-create/create-windows-vm.md) to be used as a template for desktops you create.
1. Connect to the created VM (for example, [via RDP](../compute/operations/vm-connect/rdp.md)) and install the following components on it:

   * Citrix Virtual Delivery Agent (VDA) version no higher than 1912.0.0.24265 by following the [instructions](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops/1912/install-configure/install-vdas.html) given in the Citrix documentation.
   * Applications required on the desktops.

## Install the plugin {#install-plugin}

1. Connect to the VM with the Citrix Delivery Controller (for example, [via RDP](../compute/operations/vm-connect/rdp.md)).
1. Upload the archive with the plugin to the VM and unpack it to `C:\Program Files\Common Files\Citrix\HCLPlugins\CitrixMachineCreation\v1.0.0.0`.
1. In `C:\Program Files\Common Files\Citrix\HCLPlugins\CitrixMachineCreation\v1.0.0.0\YandexCloud`, create a folder named `Logs` and grant all users full access to it.
1. In the same `YandexCloud` folder, run the `RegisterPlugin.cmd` file and wait until the script is executed.
1. Restart the Citrix Host Service, Citrix Broker Service, and Citrix Machine Creation Service by running the following commands:

   ```powershell
   Restart-Service -DisplayName "Citrix Host Service"
   Restart-Service -DisplayName "Citrix Broker Service"
   Restart-Service -DisplayName "Citrix Machine Creation Service"
   ```

1. To check that the plugin is installed, run the following command:

   ```powershell
   Get-HypHypervisorPlugin
   ```

   The resulting list should contain the `Yandex.Cloud` plugin.

## Create a machine catalog {#create-machine-catalog}

1. Connect to the VM with Citrix Studio (for example, [via RDP](../compute/operations/vm-connect/rdp.md)).
1. Create a site using Citrix Studio according to the [instructions](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops/install-configure/site-create.html) given in the Citrix documentation.
1. Download a file named `Citrix-Provisioning.ps1` with a script for creating a machine catalog on the VM.
1. Run the script by executing the following command:

   ```powershell
   .\Citrix-Provisioning.ps1 `
     -ConnectionName <connection name> `
     -CloudId <cloud ID> `
     -FolderId <folder ID> `
     -AvailabilityZoneId <availability zone ID> `
     -TemplateVM <template VM name> `
     -NetworkName <subnet name> `
     -StorageBucket <bucket name> `
     -StorageAccessKey <access key ID> `
     -StorageSecret <access key value> `
     -ActiveDirectoryDomain <Active Directory domain name> `
     -ActiveDirectoryAccountNamingScheme <desktop naming convention>
   ```

   All the script parameters are required except:

   * `-ConnectionName` (defaults to `YandexCloud_Pvd`).
   * `-ActiveDirectoryDomain` (defaults to `citrix.local`).
   * `-ActiveDirectoryAccountNamingScheme` (defaults to `CITRIX-VM-####`: Active Directory accounts corresponding to desktops will be named `CITRIX-VM-0001`, `CITRIX-VM-0002`, and so on. For more information, see the [NamingScheme parameter description](https://developer-docs.citrix.com/projects/citrix-virtual-apps-desktops-sdk/en/latest/ADIdentity/New-AcctIdentityPool/#parameters) in the Citrix documentation).

1. Add desktops to the created catalog using Citrix Studio according to the [instructions](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops/install-configure/machine-catalogs-manage.html#add-machines-to-a-catalog) given in the Citrix documentation.

{% endif %}
