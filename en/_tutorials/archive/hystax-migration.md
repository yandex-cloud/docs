# Migrating to {{ yandex-cloud }} with Hystax Acura

You can use Hystax Acura to migrate your cloud infrastructure from another platform to {{ yandex-cloud }}. To do so, you will need to create a Hystax Acura VM in your cloud that will manage the migration process, while another VM running Hystax Acura Cloud Agent will migrate your third-party platform VMs to your cloud. Before the migration starts, the system will create VM replicas for infrastructure deployment during the migration process.

To perform the migration:
1. [Get your cloud ready](#before-begin).
1. [Create a service account and authorized key](#create-sa).
1. [Configure network traffic rules](#network-settings).
1. [Create a Hystax Acura VM](#create-acura-vm).
1. [Set up Hystax Acura](#setup-hystax-acura).
1. [Set up Hystax Acura Cloud Agent](#prepare-agent).
1. [Create VM replicas](#create-replicas).
1. [Create a migration plan](#prepare-migration-plan).
1. [Start migration](#start-migration).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% note info %}

Note that the Hystax Acura and Hystax Acura Cloud Agent infrastructure, as well as all migrated VMs will be charged and counted against your [quotas]({{ link-console-quotas }}).
* A Hystax Acura VM uses 8 vCPUs, 16 GB of RAM, and a 200-GB disk.
* A Hystax Acura Cloud Agent VM uses 2 vCPUs, 4 GB of RAM, and an 8-GB disk.

{% endnote %}

The cost of the Hystax Acura Live Migration resources includes:
* Fee for disks and continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for storing images (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Fee for a dynamic or static public IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for each completed migration (see [product description](/marketplace/products/hystax/hystax-acura-live-cloud-migration) in {{ marketplace-name }}).

## Create a service account and authorized key {#create-sa}

Hystax Acura Live Migration will run under a [service account](../../iam/concepts/users/service-accounts.md):
1. [Create](../../iam/operations/sa/create.md) a service account named `hystax-acura-account` with the `editor` and `marketplace.meteringAgent` roles.
1. [Create](../../iam/operations/authorized-key/create.md) a service account authorized key.

Save the following details since you will need them in the next steps:
1. Service account ID.
1. Service account authorized key ID.
1. Service account private authorized key.

## Configure network traffic rules {#network-settings}

Configure network traffic rules for the [default security group](../../vpc/concepts/security-groups.md#default-security-group). If it is unavailable, it will allow any inbound or outbound VM traffic.

If the default security group is available, [add](../../vpc/operations/security-group-add-rule.md) the following rules to it:

Traffic<br>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
--- | --- | --- | --- | --- | ---
Inbound | `http` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Inbound | `https` | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Inbound | `https` | `4443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Inbound | `vmware` | `902` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Inbound | `vmware` | `902` | `{{ ui-key.yacloud.common.label_udp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Inbound | `iSCSI` | `3260` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Inbound | `udp` | `12201` | `{{ ui-key.yacloud.common.label_udp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Inbound | `tcp` | `15000` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Outbound | `http` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Outbound | `https` | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Outbound | `vmware` | `902` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Outbound | `vmware` | `902` | `{{ ui-key.yacloud.common.label_udp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Outbound | `iSCSI` | `3260` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Outbound | `udp` | `12201` | `{{ ui-key.yacloud.common.label_udp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`

Save the security group ID you will need when creating a Hystax Acura VM.

## Create a Hystax Acura VM {#create-acura-vm}

Create a VM with the [Hystax Acura Live Migration to {{ yandex-cloud }}](/marketplace/products/hystax/hystax-acura-live-cloud-migration) image boot disk:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your VM.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**:

      * Navigate to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab.
      * Click **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**.
      * In the public image list, select [Hystax Acura Live Cloud Migration to {{ yandex-cloud }}](/marketplace/products/hystax/hystax-acura-live-cloud-migration) and click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.

  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../overview/concepts/geo-scope.md) where your VM will reside.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, specify the boot [disk](../../compute/concepts/disk.md) size: `200 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, select the `8 vCPU` and `16 {{ ui-key.yacloud.common.units.label_gigabyte }}` configuration.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**: 

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, specify the subnet ID in the VM availability zone. Alternatively, you can select a [cloud network](../../vpc/concepts/network.md#network) from the list.

          * Each network must have at least one [subnet](../../vpc/concepts/network.md#subnet). If the selected network has no subnets, create one by selecting **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.
          * If there are no networks in the list, click **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** to create one:

              * In the window that opens, specify the network name and select the folder to host it.
              * Optionally, select **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** to automatically create subnets in all availability zones.
              * Click **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

      * If the list of **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** is available, select the previously configured [security group](../../vpc/concepts/security-groups.md#default-security-group). If this list does not exist, it will allow all inbound and outbound traffic for the VM.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

      * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, specify a username, e.g., `yc-user`.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `hystax-acura-vm`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_additional }}**, select the `hystax-acura-account` service account.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Run this command in the terminal:

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
   * `cores`: [Number of vCPUs](../../compute/concepts/vm.md).
   * `memory`: [RAM size](../../compute/concepts/vm.md).
   * `network-interface`: VM network interface description:
     * `subnet-id`: VM subnet.

       You can get the list of subnets using the `yc vpc subnet list` CLI command.
     * `nat-ip-version=ipv4`: Use a public IP address.
     * `security-group-ids`: Security groups.

       You can get the security group list using the `yc vpc security-group list` command. If you skip this parameter, the system will assign the [default security group](../../vpc/concepts/security-groups.md#default-security-group) to the VM.
   * `create-boot-disk`: Create a new VM disk:
     * `name`: Disk name, e.g., `hystax-acura-disk`.
     * `size`: Disk size.
     * `image-id`: Disk image ID.

        For this example, use `image_id` from the {{ marketplace-name }} [product description](/marketplace/products/hystax/hystax-acura-live-cloud-migration).

   * `service-account-id`: ID of the [previously created](#create-sa) service account.

     You can get the list of accounts using the `yc vpc security-group list` command.
   * `ssh-key`: Path to the [public SSH key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) file.

{% endlist %}

## Set up Hystax Acura {#setup-hystax-acura}

1. In the [management console]({{ link-console-main }}), open the `hystax-acura-vm` VM page and find its public IP address.
1. Enter the `hystax-acura-vm` VM public IP address in your browser address bar. This will open the Hystax Acura initial setup screen.

   {% note info %}

   Booting the Hystax Acura Live Cloud Migration VM for the first time will start an installation process that can take over 20 minutes.

   {% endnote %}

1. By default, a Hystax Acura VM has a self-signed certificate.
1. When the setup prompts you to fill out the user profile data, use the values below:
   * **Organization**: Name of your organization.
   * **Admin user login**: Email address you will use as the admin username.
   * **Password**: Admin password.
   * **Confirm password**: Re-enter the admin password.
1. Click **Next**.
1. Specify the {{ yandex-cloud }} connection settings:
   * **Service account ID**: ID of the service account.
   * **Key ID**: Service account authorized key ID.
   * **Private key**: Service account private key.

     {% note info %}

     {% include [hystax-auth-key-newlines](../_tutorials_includes/hystax-auth-key-newlines.md) %}

     {% endnote %}

   * **Default folder ID**: Your folder ID.
   * **Availability zone**: `hystax-acura-vm` VM availability zone.
   * **Hystax Service Subnet**: `hystax-acura-vm` VM subnet ID.
   * **S3 host**: `{{ s3-storage-host }}`.
   * **S3 port**: `443`.
   * **Enable HTTPS**: Select this option to enable HTTPS connections.
   * **Public IP address of the Hystax Acura management console**: Specify the `hystax-acura-vm` public IP address you got in step 1.
   * **Additional parameters**: Do not edit this field.
1. Click **Next**.

Hystax Acura will automatically check whether it can access your cloud. If everything is correct, you will be able to log in to the Hystax control panel with the email address and password you set previously.

## Prepare and install migration agents {#prepare-agent}

You need to install migration agents on the VMs you will be migrating to {{ yandex-cloud }}. To download and install the agent, do the following:
1. If you are migrating from VMware ESXi, Microsoft Hyper-V, or any other hypervisor different from KVM, [install virtio drivers](../../compute/operations/image-create/custom-image#virtio) on the VM before the migration.
1. In the Hystax Acura admin panel, select the **Download agent** tab.
1. Select one of the agent types depending on your OS:
   * VMware
   * Windows
   * Linux

   Click **Next**.
1. Download and install the agent on the VMs you are migrating:

   {% list tabs group=operating_system %}

   - VMware {#vmware}

     1. Select **New VMware vSphere** and fill out these fields:
        * **Platform name**: Name of your platform.
        * **Host IP address**: IP address of the VMware ESXi host where you will deploy the replication agent.
        * **Login**: Your login.
        * **Password**: Your password.

        Click **Next**.
     1. Click **Download agent** and wait for the download to complete.
     1. Unpack the downloaded OVA file to the VMs in your cluster.
     1. Start the VMs with the agent.

   - Windows {#windows}

     1. Click **Next**.
     1. Click **Download agent** and wait for the download to complete.
     1. Unpack the archive and run `hwragent.msi` on the VMs you want to migrate.

   - Linux {#linux}

     1. Select Linux distribution:
        * **CentOS/RHEL (.rpm package)**: CentOS or Red Hat-based.
        * **Debian/Ubuntu (.deb package)**: Ubuntu or Debian.
     1. Select the driver installation method:
        * **Pre-built**: Install driver binary.
        * **DKMS**: Compile the modules during installation.
     1. Click **Next**.
     1. You will get agent installation commands you can run following the instructions for your distribution and installation method.

   {% endlist %}

The VM will appear in the target group a few minutes after the agent is installed.

## Create VM replicas {#create-replicas}

{% note alert %}

When replication starts, Hystax Acura will create a new Hystax Acura Cloud Agent VM to run operations in your cloud.

{% endnote %}

Start replication:
1. Click the Hystax logo.
1. Under **Machines Groups**, select the virtual machines to replicate.
1. You can specify additional parameters for the `network-ssd` volume in the replication editing menu.
1. Click **Bulk actions** and in the menu that opens, select **Start replication**.

A VM replica will include all original VM data; therefore, replication can take around 40 minutes. You will be able to see the replication status in the **Status** column under **Instance groups**. Wait for the status to change to `Synced` and check whether there are VM replicas in the {{ compute-name }} list in your folder.

## Create a migration plan {#prepare-migration-plan}

When the VMs you are replicating switch to `Synced`, you can create a migration plan. The migration plan defines the list of VMs to migrate and the order in which they will start in your cloud.
1. Click **Add Migration plan**.
1. Specify the migration plan name: `YC Migration`.
1. Under **Devices & Ranks**, click ![options](../../_assets/options.svg). In the menu that opens, click **Add machine**, select the instance group and then the VM you want to add to the migration plan. Repeat the steps for all VMs you are going to migrate.
1. In the **Subnet ID** and the **CIDR** fields, specify the ID and CIDR of the subnet where the VMs will get connected after migration.
1. Expand the device description and specify the new VM parameters in the **Flavor name** field in this format: `<platform>-<cpu>-<ram>-<core_fraction>`, e.g., `2-8-16-100`.
1. In the **Port ip** field, specify a new IP from the current subnet for the VM.
1. Click **Save**.

## Start migration {#start-migration}

Perform the migration according to the plan:
1. Open the **Migrate** tab.
1. Select the `YC Migration` plan and click **Next**.
1. Specify `CloudSite` in the **Cloud Site Name** field.
1. Make sure all required resources are in the list and click **Run migration**.

The migration process may take about 10 minutes. You can see the status of the VMs being migrated in the **Status** column under **Machines**. Wait for the status to change to `Running`, then make sure all the resources have been transferred and your applications are ready to run. If the migrated infrastructure is working correctly, click **Detach** on the **CloudSite** page and confirm the detach action.

## How to delete the resources you created {#clear-out}

To stop paying for the migration infrastructure:
1. [Delete](../../compute/operations/vm-control/vm-delete.md) `hystax-acura-vm`.
1. [Delete](../../compute/operations/vm-control/vm-delete.md) `cloud-agent` VMs.
1. [Delete](../../iam/operations/sa/delete.md) the `hystax-acura-account` service account.

If you reserved a public static IP address, [delete it](../../vpc/operations/address-delete.md).
