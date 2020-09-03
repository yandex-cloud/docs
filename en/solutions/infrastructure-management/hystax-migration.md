# Migrating to Yandex.Cloud using Hystax Acura

You can use Hystax Acura to migrate your cloud infrastructure to Yandex.Cloud from another cloud platform. To migrate, create a VM with Hystax Acura in your cloud. This VM will be used to set up and perform the migration. The migration process is performed by an auxiliary VM with Hystax Acura Cloud Agent. It will migrate your VMs to Yandex.Cloud. Before VM migration starts, VM replicas are created. Those replicas will be used for infrastructure deployment during migration. To migrate VMs:

1. [Before you start](#before-begin).
1. [Required paid resources](#paid-resources).
1. [Create a VM with Hystax Acura](#create-acura-vm).
1. [Create a service account and authorized key](#create-sa).
1. [Set up Hystax Acura](#setup-hystax-acura).
1. [Set up migration flow](#set-up-migration-flow).
1. [Prepare Hystax Acura Cloud Agent](#prepare-agent).
1. [Create replicas for your VMs](#create-replicas).
1. [Create a migration plan](#prepare-migration-plan).
1. [Start migration](#start-migration).

If you no longer need the created resources, [delete them](#clear-out).

## Before you start {#before-begin}

Before deploying the server, you need to sign up for Yandex.Cloud and create a billing account:

{% include [prepare-register-billing](../_solutions_includes/prepare-register-billing.md) %}

If you have an active billing account, you can create or select a folder to run your VM in from the [Yandex.Cloud page](https://console.cloud.yandex.com/cloud).

[Learn more about clouds and folders](../../resource-manager/concepts/resources-hierarchy.md).

### Required paid resources {#paid-resources}

{% note info %}

Please note that the infrastructure for Hystax Acura and Hystax Acura Cloud Agent, as well as all migrated VMs, consume quotas and require payment.

* A Hystax Acura VM uses 8 vCPUs, 16 GB of RAM, and a 100 GB disk.
* A Hystax Acura Cloud Agent VM uses 2 vCPUs, 4 GB of RAM, and an 8 GB disk.

{% endnote %}

Resource costs for Hystax Acura and Hystax Acura Cloud Agent include:

* A fee for the disks and continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* A fee for storing images (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* A fee for using a dynamic or static external IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

## Create a service account and authorized key {#create-sa}

[Create a service account](../../iam/operations/sa/create.md) with the `editor` and `marketplace.meteringAgent` roles, and an [authorized key](../../iam/operations/authorized-key/create.md). Save the service account ID, private key ID, and the private key. You'll need them when setting up Hystax Acura.

## Create a VM with Hystax Acura {#create-acura-vm}

Create a VM with a boot disk from an `acura` image:

{% list tabs %}

- CLI

   In the terminal, run the following command:

   ```
   $ yc compute instance create \
     --name hystax-acura-vm \
     --zone <availability zone> \
     --cores 8 \
     --memory 16 \ 
     --network-interface subnet-id=<subnet ID>,nat-ip-version=ipv4 \
     --create-boot-disk name=hystax-acura-disk,size=100,image-id=<Hystax Acura image ID> \
     --service-account-id <service account ID> \
     --ssh-key ~/.ssh/id_rsa.pub
   ```

{% endlist %}

## Set up Hystax Acura {#setup-hystax-acura}

1. Open the `hystax-acura-vm` VM page in the management console and find its public IP address.

1. Open the `hystax-acura-vm` VM public IP address in the browser. The Hystax Acura initial setup screen opens.

1. On the page that opens, fill in the following fields:
   - **Organization**: The name of your organization.
   - **Admin user login**: The email address for logging in to the Hystax Acura Control Panel.
   - **Password**: The administrator password.
   - **Confirm password**: Re-enter the administrator password.

1. Click **Next**.

1. Set up your Yandex.Cloud connection parameters:
   - **Service Account id**: The ID of your service account.
   - **Key id**: The ID of the authorized key of your service account.
   - **Private Key**: The private part of the authorized key of your service account.
   - **Default Folder id**: The ID of your folder.
   - **zone**: Availability zone.
   - **Hystax Service Network id**: The ID of the subnet that the `hystax-acura-vm` virtual machine is connected to.
   - **Control Panel Public IP**: The public IP address to access the Hystax Control Panel. This field is populated by the VM public IP address by default, so leave it unchanged.

1. Click **Next**.

Hystax Acura automatically checks that it can access your cloud. If everything is correct, you can now log in to the Hystax Acura Control Panel using your email address and password.

## Add a platform {#set-up-migration-flow}

Specify the platform for migration:

1. Open the Hystax Acura Control Panel. Click on the Hystax logo.

1. On the screen that opens, click **Add** and fill in the following fields:
   - **Company name**: The name of your company.
   - **Contact email**: Your email address.
   - **Cloud**: Select `Yandex Cloud`.
   - **Use custom replication agent settings**: Enabled.
   - **Replication agent endpoint IP**: The public IP address of the `hystax-acura-vm` virtual machine.
   - **Replication agent logging IP**: The public IP address of the `hystax-acura-vm` virtual machine.

   Click **Save**.

## Prepare and install agents for migration {#prepare-agent}

The agents are installed on virtual machines to be migrated to Yandex.Cloud. To download and install an agent:

1. In the Hystax Acura Control Panel, click the **Download agents** tab.

1. Select the source cloud platform for migration. Click **Next**.

1. Choose one out of three types of agents depending on the OS:
   - VMware.
   - Windows.
   - Linux.

   Click **Next**.

1. Download and install the agent on the VMs you would like to migrate:

   {% list tabs %}

   - VMware

     1. Select **New VMware vSphere** and fill in the fields:
        - **Platform Name**: The name of the platform.
        - **Endpoint**: The public IP address of the `hystax-acura-vm` virtual machine.
        - **Login**: The user's login.
        - **Password**: The user's password.

         Click **Next**.

     1. Click **Download Agent** and wait for the agent to download.

     1. Unpack the downloaded OVA agent file to the VMs in your cluster.

     1. Start the VMs with the agent.

   - Windows
     1. Click **Next**.
     1. Click **Download Agent** and wait for the agent to download.
     1. Unpack the archive and install the agent from the file `hwragent.msi` on the VMs you would like to migrate.

   - Linux

     1. Select the package type for your OS:
        - **CentOS/RHEL (.rpm package)**: For CentOS or Red Hat-based operating systems.
        - **Debian/Ubuntu (.deb package)**: For Ubuntu and Debian.

     1. Click **Next**.

     1. Upload the agent to the migrated VMs and install it:
        - For Debian and Ubuntu, run the command `dpkg -i <package path>`.
        - For CentOS and Red Hat-based OS, run the command `rpm -i <package path>`.

   {% endlist %}

## Create VM replicas {#create-replicas}

{% note alert %}

When replication starts, Hystax Acura creates a new VM with Hystax Acura Cloud Agent in Yandex.Cloud to run all the operations in your cloud.

{% endnote %}

When the agents are installed, create VM replicas. VM replicas include all the data from the source VM, which is why replication may take a long time.

1. Click on the Hystax logo.
1. Select the source cloud platform for migration.
1. Click **Next**.
1. Under **Machines Groups**, select the virtual machines to be replicated.
1. Click **Bulk actions**. In the menu that opens, select **Start replication**.

Make sure that the replicas of the selected VMs are shown in the {{ compute-name }} VM list.

## Create a migration plan {#prepare-migration-plan}

As soon as the replicated status of the VMs is `Synced`, you can create a migration plan. The migration plan defines which machines should be migrated to your cloud and their start order after migration.

1. Click **Add Migration plan**.
1. Enter a name for the migration plan: `YC Migration`
1. Under **Devices & Ranks**, click ![options](../../_assets/options.svg). In the menu that opens, select **Add machine**, the VM instance group, and VM to be added to the migration plan. Repeat the steps for all the VMs to migrate.
1. In the **Subnet ID** field, specify the subnet ID to connect the VMs to after migration.
1. Click **Save**.

## Start migration {#start-migration}

You can now migrate using the plan you created.

1. Open the **Migrate** tab.
1. Select the source cloud platform for migration.
1. Click **Next**.
1. Select the `YC migration` plan and click **Next**.
1. Enter the name CloudSite.
1. Make sure that all the required resources are in the list and click **Run migration**.

Wait until the migration is complete. Make sure all the necessary resources migrated and your applications are ready. If the migrated infrastructure runs as expected, click **Detach** on the **CloudSite** page. If you don't want to migrate anything else, you can delete the VM with Hystax Acura and Hystax Cloud Agent.

## Delete the created resources {#clear-out}

To avoid paying more for the migration infrastructure, [delete](../../compute/operations/vm-control/vm-delete.md) the `hystax-acura-vm` virtual machine and other VMs created by it with `cloud-agent` in their names. If you don't need the migrated VMs any more, you can delete them too.

If you reserved a public static IP address, [delete it](../../vpc/operations/address-delete.md).

