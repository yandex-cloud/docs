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

Note that the infrastructure for Hystax Acura and Hystax Acura Cloud Agent and all the migrated VMs will be charged and counted against the [quotas]({{ link-console-quotas }}).
* A Hystax Acura VM uses 8 vCPUs, 16 GB of RAM, and a 200-GB disk.
* A Hystax Acura Cloud Agent VM uses 2 vCPUs, 4 GB of RAM, and an 8-GB disk.

{% endnote %}

The cost of the resources required to use Hystax Acura Live Migration includes:
* Fee for disks and continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for storing images (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Fee for using a dynamic or static public IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for each completed migration (see [product description](/marketplace/products/hystax/hystax-acura-live-cloud-migration) in {{ marketplace-name }}).

## Create a service account and authorized key {#create-sa}

Hystax Acura Live Migration will run under a [service account](../../iam/concepts/users/service-accounts.md):
1. [Create](../../iam/operations/sa/create.md) a service account named `hystax-acura-account` with the `editor` and `marketplace.meteringAgent` roles.
1. [Create](../../iam/operations/authorized-key/create.md) an authorized key for the service account.

Save the following details to use in the next steps:
1. Service account ID.
1. Service account authorized key ID.
1. Service account private authorized key.

## Configure network traffic permissions {#network-settings}

Configure network traffic permissions in the [default security group](../../vpc/concepts/security-groups.md#default-security-group). If a security group is unavailable, any incoming or outgoing VM traffic will be allowed.

If a security group is available, [add](../../vpc/operations/security-group-add-rule.md) to it the following rules:

Traffic<br>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
--- | --- | --- | --- | --- | ---
Incoming | `http` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Incoming | `https` | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Incoming | `https` | `4443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Incoming | `vmware` | `902` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Incoming | `vmware` | `902` | `{{ ui-key.yacloud.common.label_udp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Incoming | `iSCSI` | `3260` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Incoming | `udp` | `12201` | `{{ ui-key.yacloud.common.label_udp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Incoming | `tcp` | `15000` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Outgoing | `http` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Outgoing | `https` | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Outgoing | `vmware` | `902` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Outgoing | `vmware` | `902` | `{{ ui-key.yacloud.common.label_udp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Outgoing | `iSCSI` | `3260` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Outgoing | `udp` | `12201` | `{{ ui-key.yacloud.common.label_udp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`

Save the security group ID. You will need it when creating VMs with Hystax Acura.

## Create a VM with Hystax Acura {#create-acura-vm}

Create a VM with a boot disk from the [Hystax Acura Live Migration to {{ yandex-cloud }}](/marketplace/products/hystax/hystax-acura-live-cloud-migration) image:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create your VM.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**:

      * Go to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab.
      * Click **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**.
      * In the public image list, select [Hystax Acura Live Cloud Migration to {{ yandex-cloud }}](/marketplace/products/hystax/hystax-acura-live-cloud-migration) and click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.

  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../overview/concepts/geo-scope.md) to place your VM in.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, enter `200 {{ ui-key.yacloud.common.units.label_gigabyte }}` for boot [disk](../../compute/concepts/disk.md) size.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, select the configuration with `8 vCPU` and `16 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**: 

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, enter the ID of a subnet in the new VM’s availability zone. Alternatively, you can select a [cloud network](../../vpc/concepts/network.md#network) from the list.

          * Each network must have at least one [subnet](../../vpc/concepts/network.md#subnet). If there is no subnet, create one by selecting **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.
          * If you do not have a network, click **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** to create one:

              * In the window that opens, enter the network name and select the folder to host the network.
              * (Optional) Select the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** option to automatically create subnets in all availability zones.
              * Click **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

      * If a list of **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** is available, select the [security group](../../vpc/concepts/security-groups.md#default-security-group) for which you previously configured network traffic permissions. If this list does not exist, all incoming and outgoing traffic will be enabled for the VM.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the information required to access the VM:

      * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter a username, e.g., `yc-user`.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `hystax-acura-vm`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_additional }}**, select the `hystax-acura-account` service account.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   In the terminal, run the following command:

   ```bash
   yc compute instance create \
     --name hystax-acura-vm \
     --zone <availability_zone> \
     --cores 8 \
     --memory 16 \
     --network-interface subnet-id=<subnet_ID>,nat-ip-version=ipv4,security-group-ids=<security_group_ID_if_group_set_up_previously> \
     --create-boot-disk name=hystax-acura-disk,size=200,image-id=<Hystax_Acura_image_ID> \
     --service-account-id <service_account_ID> \
     --ssh-key ~/.ssh/id_ed25519.pub
   ```

   Where:

   * `name`: VM name, e.g., `hystax-acura-vm`.
   * `zone`: [Availability zone](../../overview/concepts/geo-scope.md), e.g., `{{ region-id }}-a`.
   * `cores`: [Number of vCPUs](../../compute/concepts/vm.md) the VM has.
   * `memory`: VM [RAM size](../../compute/concepts/vm.md).
   * `network-interface`: VM network interface description:
     * `subnet-id`: Subnet to connect your VM to.

       You can get the list of subnets using the `yc vpc subnet list` CLI command.
     * `nat-ip-version=ipv4`: Connect a public IP address.
     * `security-group-ids`: Security groups.

       You can get the list of groups using the `yc vpc security-group list` command. If you skip this parameter, the [default security group](../../vpc/concepts/security-groups.md#default-security-group) will be assigned.
   * `create-boot-disk`: Create a new disk for the VM:
     * `name`: Disk name, e.g., `hystax-acura-disk`.
     * `size`: Disk size.
     * `image-id`: Disk image ID.

        For this example, use `image_id` from the [product description](/marketplace/products/hystax/hystax-acura-live-cloud-migration) in {{ marketplace-name }}.

   * `service-account-id`: ID of the [previously created](#create-sa) service account.

     You can get the list of accounts using the `yc iam service-account list` command.
   * `ssh-key`: Path to the [public SSH key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) file.

{% endlist %}

## Set up Hystax Acura {#setup-hystax-acura}

1. Open the `hystax-acura-vm` VM page in the [management console]({{ link-console-main }}) and find its public IP address.
1. Enter the `hystax-acura-vm` VM public IP address in your browser. This will open the initial setup screen for Hystax Acura.

   {% note info %}

   Booting the Hystax Acura Live Cloud Migration VM for the first time will start an installation process which can take over 20 minutes.

   {% endnote %}

1. By default, a Hystax Acura VM has a self-signed certificate installed.
1. When you are prompted to fill out the fields, use the values below:
   * **Organization**: Name of your organization.
   * **Admin user login**: Email address for logging in to the admin panel.
   * **Password**: Admin password.
   * **Confirm password**: Re-enter the admin password.
1. Click **Next**.
1. Specify the {{ yandex-cloud }} connection settings:
   * **Service account ID**: ID of the service account.
   * **Key ID**: ID of the service account authorized key.
   * **Private key**: Service account private key.

     {% note info %}

     {% include [hystax-auth-key-newlines](../_tutorials_includes/hystax-auth-key-newlines.md) %}

     {% endnote %}

   * **Default folder ID**: ID of your folder.
   * **Availability zone**: Availability zone hosting the `hystax-acura-vm` VM.
   * **Hystax Service Subnet**: ID of the subnet the `hystax-acura-vm` VM is connected to.
   * **S3 host**: `{{ s3-storage-host }}`.
   * **S3 port**: `443`.
   * **Enable HTTPS**: Select this option to enable HTTPS connections.
   * **Public IP address of the Hystax Acura management console**: `hystax-acura-vm` public IP address. Replace the value in this field with the IP address obtained in Step 1.
   * **Additional parameters**: Additional parameters. Do not edit this field.
1. Click **Next**.

Hystax Acura will automatically check whether it can access your cloud. If everything is correct, you can now log on to the Hystax Control Panel using the specified email address and password.

## Prepare and install agents for migration {#prepare-agent}

The agents are normally installed onto VMs to be migrated to {{ yandex-cloud }}. To download and install an agent:
1. If you are migrating from VMware ESXi, Microsoft Hyper-V, or any other hypervisor different from KVM, make sure to [install virtio drivers](../../compute/operations/image-create/custom-image#virtio) on the VM before performing migration.
1. In the Hystax Acura admin panel, click the **Download agent** tab.
1. Choose one of the agent types depending on the OS:
   * VMware
   * Windows
   * Linux

   Click **Next**.
1. Download and install the agent on the VMs you would like to migrate:

   {% list tabs group=operating_system %}

   - VMware {#vmware}

     1. Select **New VMware vSphere** and fill in these fields:
        * **Platform name**: Platform name.
        * **Host IP address**: IP address of the VMware ESXi host where to deploy the replication agent.
        * **Login**: Login.
        * **Password**: Password.

        Click **Next**.
     1. Click **Download agent** and wait for the download to complete.
     1. Unpack the downloaded OVA agent file to the VMs in your cluster.
     1. Start the VMs with the agent.

   - Windows {#windows}

     1. Click **Next**.
     1. Click **Download agent** and wait for the download to complete.
     1. Unpack the archive and install the agent from `hwragent.msi` on the VMs you want to migrate.

   - Linux {#linux}

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
1. Click **Bulk actions** and in the menu that opens, select **Start replication**.

A VM replica will include all the data of the original VM; therefore, replication can take a long time (about 40 minutes). The replication status will be displayed in the **Status** column under **Machines Groups**. Wait for the status to change to `Synced` and make sure you can see the new replicas of the selected VMs in the {{ compute-name }} VM list in your folder.

## Create a migration plan {#prepare-migration-plan}

As soon as the VMs you are replicating switch to `Synced`, you can create a migration plan. The migration plan defines which machines should be migrated to your cloud and their start order after migration.
1. Click **Add Migration plan**.
1. Enter the migration plan name: `YC Migration`.
1. Under **Devices & Ranks**, click ![options](../../_assets/options.svg). In the menu that opens, click **Add machine**, pick the VM group you need, and select the VM you want to add to the migration plan. Repeat the steps for all VMs to migrate.
1. In the **Subnet ID** and the **CIDR** fields, specify the ID and CIDR of the subnet the VMs will be connected to following the migration.
1. Expand the device description and edit the **Flavor name** field (the new VM's parameters) as follows: `<platform>-<cpu>-<ram>-<core_fraction>`, e.g., `2-8-16-100`.
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
1. [Delete](../../compute/operations/vm-control/vm-delete.md) `hystax-acura-vm`.
1. [Delete](../../compute/operations/vm-control/vm-delete.md) the secondary `cloud-agent` VMs.
1. [Delete](../../iam/operations/sa/delete.md) the `hystax-acura-account` service account.

If you reserved a public static IP address, [delete it](../../vpc/operations/address-delete.md).
