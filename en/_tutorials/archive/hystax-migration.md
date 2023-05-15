# Migrating to {{ yandex-cloud }} using Hystax Acura

You can use Hystax Acura to migrate your cloud infrastructure to {{ yandex-cloud }} from another cloud platform. To do so, you will need to create a VM with Hystax Acura in your cloud. This VM will be used to manage the migration setup and run, while the migration process itself will be performed by a service VM with Hystax Acura Cloud Agent. This service VM will migrate your VMs to your cloud. Before VM migration starts, VM replicas are created. Those replicas will be used for infrastructure deployment during migration.

To migrate VMs:
1. [Prepare your cloud](#before-begin).
1. [Create a service account and authorized key](#create-sa).
1. [Configure network traffic permissions](#network-settings).
1. [Create a VM with Hystax Acura](#create-acura-vm).
1. [Set up Hystax Acura](#setup-hystax-acura).
1. [Set up Hystax Acura Cloud Agent](#prepare-agent).
1. [Create VM replicas](#create-replicas).
1. [Create a migration plan](#prepare-migration-plan).
1. [Start migration](#start-migration).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% note info %}

Please note that the infrastructure for Hystax Acura and Hystax Acura Cloud Agent and all migrated VMs will consume your [quotas]({{ link-console-quotas }}) and you will have to pay for them.
* A Hystax Acura VM uses 8 vCPUs, 16 GB of RAM, and a 200-GB disk.
* A Hystax Acura Cloud Agent VM uses 2 vCPUs, 4 GB of RAM, and an 8-GB disk.

{% endnote %}

The cost of the resources required to use Hystax Acura Live Migration includes:
* Charge for the disks and continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Charges for object storage (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* A fee for using a dynamic or a static public IP (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* A charge for each completed migration (see [product description](/marketplace/products/hystax/hystax-acura-live-cloud-migration-3-7) in {{ marketplace-name }}).

## Create a service account and authorized key {#create-sa}

Hystax Acura Live Migration will run under a [service account](../../iam/concepts/users/service-accounts.md):
1. [Create](../../iam/operations/sa/create.md) the `hystax-acura-account` service account with the `editor` and the `marketplace.meteringAgent` roles.
1. [Create](../../iam/operations/authorized-key/create.md) an authorized key for the service account.

Save the following details to use in subsequent steps:
1. Service account ID.
1. Service account authorized key ID.
1. Service account private authorized key.

## Configure network traffic permissions {#network-settings}

Configure network traffic permissions in the [default security group](../../vpc/concepts/security-groups.md#default-security-group). If a security group is unavailable, any incoming or outgoing VM traffic will be allowed.

If a security group is available, [add](../../vpc/operations/security-group-add-rule.md) the rules below to it:

| Traffic<br>direction | Description | Port<br>range | Protocol | Source<br>type | Source/Purpose |
--- | --- | --- | --- | --- | ---
| Incoming | http | 80 | TCP | CIDR | 0.0.0.0/0 |
| Incoming | https | 443 | TCP | CIDR | 0.0.0.0/0 |
| Incoming | https | 4443 | TCP | CIDR | 0.0.0.0/0 |
| Incoming | vmware | 902 | TCP | CIDR | 0.0.0.0/0 |
| Incoming | vmware | 902 | UDP | CIDR | 0.0.0.0/0 |
| Incoming | iSCSI | 3260 | TCP | CIDR | 0.0.0.0/0 |
| Incoming | udp | 12201 | UDP | CIDR | 0.0.0.0/0 |
| Incoming | TCP | 15,000 | TCP | CIDR | 0.0.0.0/0 |
| Outgoing | http | 80 | TCP | CIDR | 0.0.0.0/0 |
| Outgoing | https | 443 | TCP | CIDR | 0.0.0.0/0 |
| Outgoing | vmware | 902 | TCP | CIDR | 0.0.0.0/0 |
| Outgoing | vmware | 902 | UDP | CIDR | 0.0.0.0/0 |
| Outgoing | iSCSI | 3260 | TCP | CIDR | 0.0.0.0/0 |
| Outgoing | udp | 12201 | UDP | CIDR | 0.0.0.0/0 |

Save the security group ID. You will need it when creating VMs with Hystax Acura.

## Create a VM with Hystax Acura {#create-acura-vm}

Create a VM with a boot disk from the [Hystax Acura Live Migration to {{ yandex-cloud }}](/marketplace/products/hystax/hystax-acura-live-cloud-migration) image:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to create your VM in.
   1. In the list of services, select **{{ compute-name }}**.
   1. Click **Create VM**.
   1. Under **Basic parameters**:
      * Enter `hystax-acura-vm` as your VM name and add a description.
      * Select an [availability zone](../../overview/concepts/geo-scope.md) to place the VM in.

   1. Under **Image/boot disk selection**:

      * Click the **{{ marketplace-name }}** tab.
      * Click **Show more**.
      * In the public image list, select [Hystax Acura Disaster Recovery to {{ yandex-cloud }}](/marketplace/products/hystax/hystax-acura-live-cloud-migration) and click **Use**.

   1. Under **Disks**, enter 200 GB as your disk size.

      1. Under **File storage**, keep the default value.
   1. Under **Computing resources**, specify:
      * vCPU: 8
      * RAM: 16 GB
   1. Under **Network settings**:
      * Select a cloud network and a [subnet](../../vpc/concepts/network.md#subnet) from the list. If there is no subnet, click **Add subnet** and create one.

        To add a subnet, select a folder, enter a subnet name, select the availability zone, specify a CIDR in the window that opens, and click **Create**.
      * If a list of **Security groups** is available, select the [security group](../../vpc/concepts/security-groups.md#default-security-group) for which you previously configured network traffic permissions. If this list does not exist, all incoming and outgoing traffic will be enabled for the VM.
   1. Under **Access**, specify the information required to access the instance:
      * Select the previously created `hystax-acura-account` service account.
      * In the **Login** field, enter a username for SSH access, such as `yc-user`.
      * In the **SSH key** field, paste the [public SSH key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

   1. Click **Create VM**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   In the terminal, run the following command:

   ```bash
   yc compute instance create \
     --name hystax-acura-vm \
     --zone <availability zone> \
     --cores 8 \
     --memory 16 \
     --network-interface subnet-id=<subnet ID>,nat-ip-version=ipv4,security-group-ids=<security group ID if previously configured> \
     --create-boot-disk name=hystax-acura-disk,size=200,image-id=<Hystax Acura image ID> \
     --service-account-id <service account ID> \
     --ssh-key ~/.ssh/id_ed25519.pub
   ```

   Where:

   * `name`: VM name, such as `hystax-acura-vm`.
   * `zone`: [Availability zone](../../overview/concepts/geo-scope.md), for example `{{ region-id }}-a`.
   * `cores`: [Number of vCPUs](../../compute/concepts/vm.md) in your VM.
   * `memory`: [Amount of RAM](../../compute/concepts/vm.md) in your VM.
   * `network-interface`: VM network interface description:
      * `subnet-id`: Subnet to connect your VM to.

         You can get a list of subnets using the `yc vpc subnet list` command.
      * `nat-ip-version=ipv4`: Connect a public IP.
      * `security-group-ids`: Security groups.

         You can retrieve a group list using the `yc vpc security-group list` command. If you skip this parameter, the [default security group](../../vpc/concepts/security-groups.md#default-security-group) will be assigned.
   * `create-boot-disk`: Create a new disk for the VM:
      * `name`: Disk name, such as `hystax-acura-disk`.
      * `size`: Disk size.
      * `image-id`: Disk image ID.

         For this example, use `image_id` from the [product description](/marketplace/products/hystax/hystax-acura-live-cloud-migration-3-7) in {{ marketplace-name }}.

   * `service-account-id`: ID of the [previously created](#create-sa) service account.

      You can retrieve a list using the `yc iam service-account list` command.
   * `ssh-key`: Path to the [public SSH key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) file.

{% endlist %}

## Set up Hystax Acura {#setup-hystax-acura}

1. Open the `hystax-acura-vm` VM page in the [management console]({{ link-console-main }}) and find its public IP address.
1. Enter the `hystax-acura-vm` VM public IP address in your browser. The Hystax Acura initial setup screen will open.

   {% note info %}

   Booting the Hystax Acura Disaster Recovery VM for the first time initiates an installation process which can take over 20 minutes.

   {% endnote %}

1. By default, a Hystax Acura VM has a self-signed certificate installed.
1. When you are prompted to fill out the fields, use the values below:
   * **Organization**: Name of your organization.
   * **Admin user login**: Email address for logging in to Hystax Acura Control Panel.
   * **Password**: Administrator password.
   * **Confirm password**: Re-enter the administrator password.
1. Click **Next**.
1. Specify the {{ yandex-cloud }} connection settings:
   * **Service Account id**: ID of your service account.
   * **Key id**: ID of the authorized key of your service account.
   * **Private key**: Service account private key.
   * **Default Folder id**: ID of your folder.
   * **Availability zone**: Availability zone for `hystax-acura-vm` VM.
   * **Hystax Service Subnet**: ID of the subnet the `hystax-acura-vm` virtual machine is connected to.
   * **Hystax Acura Control Panel Public IP**: `hystax-acura-vm` VM's public IP. Replace the value in this field with the IP address obtained in step 1.
   * **Additional parameters**: Advanced settings. Do not edit this field.
1. Click **Next**.

Hystax Acura will automatically check whether it can access your cloud. If everything is correct, you can now log on to the Hystax Control Panel using the specified email address and password.

## Prepare and install agents for migration {#prepare-agent}

The agents are normally installed onto VMs to be migrated to {{ yandex-cloud }}. To download and install an agent:
1. In the Hystax Acura Control Panel, click the **Download agents** tab.
1. Choose one of the agent types depending on the OS:
   * VMware
   * Windows
   * Linux

   Click **Next**.
1. Download and install the agent on the VMs you would like to migrate:

   {% list tabs %}

   - VMware

      1. Select **New VMware vSphere** and fill out the fields:
         * **Platform Name**: Name of the platform.
         * **Endpoint**: IP address of the VMware ESXi host where the replication agent will be deployed.
         * **Login**: User login.
         * **Password**: Password.

         Click **Next**.
      1. Click **Download Agent** and wait for the agent to download.
      1. Unpack the downloaded OVA agent file to the VMs in your cluster.
      1. Start the VMs with the agent.

   - Windows

      1. Click **Next**.
      1. Click **Download Agent** and wait for the agent to download.
      1. Unpack the archive and install the agent from the `hwragent.msi` file on the VMs you would like to migrate.

   - Linux

      1. Select Linux distribution type:
         * **CentOS/RHEL (.rpm package)**: CentOS or Red Hat-based.
         * **Debian/Ubuntu (.deb package)**: Ubuntu or Debian.
      1. Select driver install method:
         * **Pre-built**: Install a driver binary.
         * **DKMS**: Compile as you install.
      1. Click **Next**.
      1. You will get commands for installing the agent to the VM. Run these commands following the instructions for your distribution and installation method.

   {% endlist %}

The VM will show up in the target group a few minutes after the agent is installed.

## Create VM replicas {#create-replicas}

{% note alert %}

When replication starts, Hystax Acura creates a new VM with Hystax Acura Cloud Agent in the cloud to run all operations in your cloud.

{% endnote %}

Start replication:
1. Click the Hystax logo.
1. Under **Machines Groups**, select the virtual machines to replicate.
1. You can specify additional parameters for the `network-ssd` volume in the replication editing menu.
1. Click **Bulk actions**. In the menu that opens, select **Start Replication**.

A VM replica will include all the data of the original VM; therefore, replication can take a long time (about 40 minutes). The replication status will be displayed in the **Status** column under **Machines Groups**. Wait for the status to change to `Synced` and make sure the replicas of the selected machines show up in your folder in the {{ compute-name }} VM list.

## Create a migration plan {#prepare-migration-plan}

As soon as the replication status of the VMs is `Synced`, you can create a migration plan. The migration plan defines which machines should be migrated to your cloud and their start order after migration.
1. Click **Add Migration plan**.
1. Enter a name for the migration plan, e.g., `YC Migration`.
1. Under **Devices & Ranks**, click ![options](../../_assets/options.svg). In the menu that opens, click **Add machine**, pick the VM group you need, and select the VM you want to add to the migration plan. Repeat the steps for all VMs to migrate.
1. In the **Subnet ID** and the **CIDR** fields, specify the ID and the CIDR of the subnet to connect the VMs to once migrated.
1. Expand the device description and edit the **Flavor name** field (parameters of the VM being created) as follows: `<platform>-<cpu>-<ram>-<core_fraction>`. For example, `2-8-16-100`.
1. In the **Port ip** field, enter a new VM IP from the current subnet.
1. Click **Save**.

## Start migration {#start-migration}

Perform the migration as per the created plan:
1. Open the **Migrate** tab.
1. Select the `YC Migration` plan and click **Next**.
1. Enter `CloudSite` in the **Cloud Site Name** field.
1. Make sure all required resources are in the list and click **Run migration**.

The migration process might take about 10 minutes. The status of the VM being migrated will be displayed in the **Status** column under **Machines**. Wait for the status to change to `Running`, then make sure all required resources have been transferred and your applications are ready to run. If the migrated infrastructure is running as expected, click **Detach** on the **CloudSite** page and confirm the detach action.

## How to delete the resources you created {#clear-out}

To stop paying for the migration infrastructure:
1. [Delete](../../compute/operations/vm-control/vm-delete.md) the `hystax-acura-vm` VM.
1. [Delete](../../compute/operations/vm-control/vm-delete.md) the supplemental `cloud-agent` VMs.
1. [Delete](../../iam/operations/sa/delete.md) the `hystax-acura-account` service account.

If you reserved a public static IP address, [delete it](../../vpc/operations/address-delete.md).