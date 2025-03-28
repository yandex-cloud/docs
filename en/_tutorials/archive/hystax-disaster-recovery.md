# Fault protection with Hystax Acura


Regardless of where you host your resources, you can protect your infrastructure with Hystax Acura.

Supported platforms:
* Cloud services
* Hypervisors
* Physical servers

To get started, create a VM with [Hystax Acura Disaster Recovery](/marketplace/products/hystax/hystax-acura-disaster-recovery) to manage replication and recovery. Auxiliary Hystax Cloud Agent VMs will perform continuous and periodic replication. For a detailed description of the architecture, see this [Hystax overview article](https://xn--q1ach.xn--p1ai/documentation/disaster-recovery-and-cloud-backup/index.html#_2).

To run Hystax Acura Disaster Recovery, follow these steps:
1. [Get your cloud ready](#before-begin).
1. [Create a service account and authorized key](#create-sa).
1. [Configure the network traffic permissions](#network-settings).
1. [Create a VM with Hystax Acura](#create-acura-vm).
1. [Configure Hystax Acura](#setup-hystax-acura).
1. [Prepare and install disaster recovery agents](#prepare-agent).
1. [Enable replication](#start-protection).
1. [Set up subnets to run the VMs](#prepare-network).
1. [Create a disaster recovery plan](#disaster-recovery-plan).
1. [Run tests](#run-tests).
1. [Perform disaster recovery](#run-recover).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

{% note info %}

Note that both the Hystax Acura infrastructure and all recovered VMs will be charged and counted against the [quotas]({{ link-console-quotas }}).
* A VM for Hystax Acura Disaster Recovery uses 8 vCPUs, 16 GB of RAM, and a 200-GB disk.
* Auxiliary Hystax Cloud Agent VMs use 2 vCPUs, 4 GB of RAM, and a 10-GB disk. A single Hystax Cloud Agent VM can serve up to six replicated disks at a time. Should the number of disks exceed six, this will automatically create additional Hystax Cloud Agent VMs.

{% endnote %}

The cost of resources for Hystax Acura Disaster Recovery includes:
* Fee for disks and continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for storing images (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Fee for using a dynamic or static external IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for each protected VM (see the [product description](/marketplace/products/hystax/hystax-acura-disaster-recovery) in {{ marketplace-name }}).


## Create a service account and authorized key {#create-sa}

Hystax Acura Disaster Recovery will run under a [service account](../../iam/concepts/users/service-accounts.md):
1. [Create](../../iam/operations/sa/create.md) a service account named `hystax-acura-account` with the `editor` and `marketplace.meteringAgent` roles.
1. [Create](../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) an authorized key for the service account.

Save the following details to use at the next steps:
1. Service account ID.
1. Service account authorized key ID.
1. Service account private authorized key.

## Configure the network traffic permissions {#network-settings}

Configure the network traffic permissions in the [default security group](../../vpc/concepts/security-groups.md#default-security-group). If it is unavailable, any inbound or outbound VM traffic will be allowed.

If a security group is available, [add](../../vpc/operations/security-group-add-rule.md) the following rules to it:

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

Save the security group ID. You will need it when creating the Hystax Acura VM.

## Create a VM with Hystax Acura {#create-acura-vm}

Create a VM with a boot disk from the `Hystax Acura Disaster Recovery in {{ yandex-cloud }}` image.

### Start the VM

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your VM.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**:

      * Navigate to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab.
      * Click **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**.
      * In the list of public images, select [Hystax Acura Disaster Recovery in {{ yandex-cloud }}](/marketplace/products/hystax/hystax-acura-disaster-recovery) and click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.

  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../overview/concepts/geo-scope.md) where your VM will reside.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, enter `200 {{ ui-key.yacloud.common.units.label_gigabyte }}` as the boot [disk](../../compute/concepts/disk.md) size.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, select the `8 vCPU` and `16 {{ ui-key.yacloud.common.units.label_gigabyte }}` configuration.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**: 

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, enter the ID of a subnet in the new VM’s availability zone. Alternatively, select a [cloud network](../../vpc/concepts/network.md#network) from the list.

          * Each network must have at least one [subnet](../../vpc/concepts/network.md#subnet). If there is no subnet, create one by selecting **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.
          * If you do not have a network, click **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** to create one:

              * In the window that opens, specify the network name and select the folder to host the network.
              * Optionally, enable the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** setting to automatically create subnets in all availability zones.
              * Click **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

      * If the list of **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** is available, select the [security group](../../vpc/concepts/security-groups.md#default-security-group) whose network traffic permissions you previously configured. If this list is not there, the system will allow all inbound and outbound traffic for the VM.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

      * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter a username, e.g., `yc-user`.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `hystax-acura-vm`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_additional }}**, select `hystax-acura-account`, the service account you created earlier.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   In the terminal, run this command:

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

       You can get the list of groups using the `yc vpc security-group list` command. If you skip this parameter the system will assign the [default security group](../../vpc/concepts/security-groups.md#default-security-group).
   * `create-boot-disk`: Create a new disk for the VM:
      * `name`: Disk name, e.g., `hystax-acura-disk`.
      * `size`: Disk size.
      * `image-id`: Disk image ID.

        For this example, use `image_id` from the [product description](/marketplace/products/hystax/hystax-acura-disaster-recovery) in {{ marketplace-name }}.

   * `service-account-id`: ID of the [previously created](#create-sa) service account.

     You can get the list of accounts using the `yc vpc security-group list` command.
   * `ssh-key`: Path to the [public SSH key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) file.

{% endlist %}

### Convert the IP address to static

VMs get a public dynamic IP address when created. Since a VM with Hystax Acura may reboot, you need to convert its IP address to static.

{% list tabs group=instructions %}

- Management console {#console}

  To convert a dynamic public IP address into a static one:
  1. In the [management console]({{ link-console-main }}), open the page for the folder you are using.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Navigate to the **{{ ui-key.yacloud.vpc.switch_addresses }}** tab.
  1. Click ![image](../../_assets/options.svg) in the row with the address of your Hystax Acura VM.
  1. In the menu that opens, select **{{ ui-key.yacloud.vpc.addresses.button_action-static }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.vpc.addresses.popup-confirm_button_static }}**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To convert a dynamic public IP address into a static one:

  1. See the description of the CLI commands for updating the address attributes:

     ```bash
     yc vpc address update --help
     ```

  1. Get a list of the addresses:

     ```bash
     yc vpc address list
     ```

     Result:

     ```text
     +----------------------+------+-----------------+----------+------+
     |          ID          | NAME |     ADDRESS     | RESERVED | USED |
     +----------------------+------+-----------------+----------+------+
     | e2l46k8conff8n6ru1jl |      | {{ external-ip-examples.0 }}  | false    | true |
     +----------------------+------+-----------------+----------+------+
     ```

     The `false` value of the `RESERVED` parameter means the IP address with the `e2l46k8conff8n6ru1jl` `ID` is dynamic.
  1. Convert this address to static by using the `--reserved=true` key and the IP address `ID`:

     ```bash
     yc vpc address update --reserved=true e2l46k8conff8n6ru1jl
     ```

     Result:

     ```text
     id: e2l46k8conff8n6ru1jl
     folder_id: b1g7gvsi89m34pipa3ke
     created_at: "2023-06-02T09:36:46Z"
     external_ipv4_address:
       address: {{ external-ip-examples.0 }}
       zone_id: {{ region-id }}-b
       requirements: {}
     reserved: true
     used: true
     ```

     Now that `reserved` is `true`, the IP address is static.

{% endlist %}

## Configure Hystax Acura {#setup-hystax-acura}

1. Open the `hystax-acura-vm` VM page in the [management console]({{ link-console-main }}) and find its public IP address.
1. Enter the `hystax-acura-vm` VM public IP address in your browser. This will open the Hystax Acura initial setup screen.

   {% note info %}

   Booting the Hystax Acura Disaster Recovery VM for the first time will trigger an installation process which may take over 20 minutes.

   {% endnote %}

1. By default, a Hystax Acura VM has a self-signed certificate.
1. On the page that opens, fill out these fields:
   * **Organization**: Name of your organization.
   * **Admin user login**: Email address for logging in to the admin panel.
   * **Password**: Admin password.
   * **Confirm password**: Re-enter the admin password.
1. Click **Next**.
1. Specify the {{ yandex-cloud }} connection settings:
   * **Service account ID**: ID of the service account.
   * **Key ID**: ID of the service account authorized key.
   * **Private Key**: Private part of your service account authorized key.

     {% note info %}

     {% include [hystax-auth-key-newlines](../_tutorials_includes/hystax-auth-key-newlines.md) %}

     {% endnote %}
     
   * **Default folder ID**: ID of your folder.
   * **Availability zone**.
   * **Hystax Service Subnet**: `hystax-acura-vm` VM subnet ID.
   * **Public IP address of the Hystax Acura control panel**: Specify the public IP address of the Hystax Acura VM you got in step 1.
1. Click **Next**.

Hystax Acura will automatically check whether it can access your cloud. If everything is correct, you can now log in to the Hystax control panel using your email address and password.

## Prepare and install the agents for disaster recovery {#prepare-agent}

The agents will install on the VMs that will be recovered in {{ yandex-cloud }}. To download and install an agent:
1. In the Hystax Acura control panel, click the Hystax logo in the top-left corner.
1. Under **Machines Groups**, create a group of protected VMs, e.g, `Prod-Web`.
1. Go to the **Download agent** tab.
1. Select one out of three agent types depending on the OS:
   * VMware
   * Windows
   * Linux

   Click **Next**.
1. Download and install the agent on the VMs you would like to protect:

   {% list tabs group=operating_system %}

   - VMware {#vmware}

     1. From the drop-down list, select an instance group to set up agents for, e.g., `Prod-Web`.
     1. Select **New VMware vSphere** and fill in these fields:
        * **Platform Name**.
        * **Endpoint**: Public IP address of the ESXi host.
        * **Login**: User login. This user must have the admin permissions.
        * **Password**.

        Click **Next**.
     1. Click **Download agent** and wait for the download to complete.
     1. Unpack the downloaded OVA agent file on the ESXi host.
     1. Start the VMs with the agent.

   - Windows {#windows}

     1. From the drop-down list, select an instance group to set up agents for, e.g., `Prod-Web`.
     1. Click **Next**.
     1. Click **Download agent** and wait for the download to complete.
     1. Unpack the archive and install the agent from `hwragent.msi` on the VMs you want to protect.

   - Linux {#linux}

     1. From the drop-down list, select an instance group to set up agents for, e.g., `Prod-Web`.
     1. Select the Linux distribution:
        * **CentOS/RHEL (.rpm package)**: CentOS or Red Hat-based.
        * **Debian/Ubuntu (.deb package)**.
     1. Select the driver installation method:
        * **Pre-built**: Install a driver binary.
        * **DKMS**: Compile as you install.
     1. Click **Next**.
     1. You will get agent installation commands. Run these commands following the instructions for your distribution and installation method.

   {% endlist %}

## Enable replication {#start-protection}

After the agent is installed on the VMs under protection, they will appear in the list as `Unprotected`.

To enable VM replication:
1. Open the Hystax Acura control panel. Click the Hystax logo.
1. Under **Machines Groups**, deploy an instance group, e.g., `Prod-Web`.
1. In the right-hand VM list, click ![image](../../_assets/options.svg).
1. Set up a replication schedule and snapshot retention period using the **Edit replication schedule** and **Edit retention policies** options. For more information, see the [Hystax tutorials](https://xn--q1ach.xn--p1ai/documentation/disaster-recovery-and-cloud-backup/dr_overview.html#edit-retention-policies).
1. Select **Enable protection**.

This will start VM replication. Once it is complete, the VMs will change their status to `Protected`.

## Set up the subnets to run the VMs {#prepare-network}

The recovery process will create a cloud site, i.e., an infrastructure to support your application in {{ yandex-cloud }} that includes [subnets](../../vpc/concepts/network.md#subnet) and recovered VMs.

Create subnets whose CIDRs will contain the IP addresses of your VMs.

For example, if you are protecting two VMs with IP adresses `10.155.0.23` and `192.168.0.3`, create two subnets with CIDRs `10.155.0.0/16` and `192.168.0.0/24`. The subnets must reside in the same [availability zone](../../overview/concepts/geo-scope.md) as the Hystax Acura Disaster Recovery VM.

To create subnets:

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}** section in the folder where you want to create a subnet.
  1. Click the cloud network name.
  1. Click **{{ ui-key.yacloud.vpc.network.overview.button_create_subnetwork }}**.
  1. Enter a name for the subnet, e.g., `net-b-155`.
  1. From the drop-down list, select an availability zone, e.g., `{{ region-id }}-b`.
  1. Enter the subnet CIDR, such as `10.155.0.0/16`.
  1. Click **{{ ui-key.yacloud.vpc.subnetworks.create.button_create }}**.

  Save the **IDs** of the created subnets. You will need these when you create your disaster recovery (DR) plan.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Get a list of the cloud networks:

     ```bash
     yc vpc network list
     ```

     Result:

     ```text
     +----------------------+----------------+
     |          ID          |      NAME      |
     +----------------------+----------------+
     | enplum7a98s1t0lhasi8 |    network     |
     +----------------------+----------------+
     ```

  1. Select `NAME` or `ID` of the cloud network you need. Create a subnet:

     ```bash
     yc vpc subnet create \
       --name net-b-155 \
       --network-name network \
       --zone {{ region-id }}-b \
       --range 10.155.0.0/16
     ```

  1. To view the subnet list, run the command below:

      ```bash
      yc vpc subnet list
      ```

      Result:

      ```text
      +----------------------+-------------+----------------------+----------------+---------------+------------------+
      |          ID          |    NAME     |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |      RANGE       |
      +----------------------+-------------+----------------------+----------------+---------------+------------------+
      | e2lgjspicv43ainspl0n | net-b-155   | enplum7a98s1t0lhasi8 |                | {{ region-id }}-b | [10.155.0.0/16]  |
      | e2l8g5u9ijd1sursv2ov | net-b-192   | enplum7a98s1t0lhasi8 |                | {{ region-id }}-b | [192.168.0.0/24] |
      | e2l1hqsrpp932ik74aic | net-b       | enplum7a98s1t0lhasi8 |                | {{ region-id }}-b | [192.168.1.0/24] |
      +----------------------+-------------+----------------------+----------------+---------------+------------------+
      ```

      Save the `ID`s of the subnets you created. You will need these when you create your disaster recovery (DR) plan.

{% endlist %}

For more details, see [Step-by-step guides](../../vpc/operations/subnet-create.md) in the {{ vpc-name }} documentation.

## Create a disaster recovery plan {#disaster-recovery-plan}

The DR plan includes a VM description and the network settings. You can have a plan generated automatically or create one manually.

{% list tabs group=instructions %}

- Automatically {#auto}

  To generate a DR plan automatically:
  1. Open the Hystax Acura control panel. Click the Hystax logo.
  1. Select the VMs you need from the list, click **Bulk actions**, and select **Generate DR plan**. You can also generate a plan for a VM group by clicking ![image](../../_assets/options.svg) in the group header.
  1. In the **Title** field, enter the name: `Plan-1`.
  1. Under **Subnets** on the right, specify the parameters of the previously created subnets: **Subned ID** and **CIDR**.
  1. Click **Save**.

- Manually {#manual}

  To create a DR plan manually:
  1. Open the Hystax Acura control panel. Click the Hystax logo.
  1. Click **Add DR plan**.
  1. In the **Title** field, enter the name: `Plan-1`.
  1. Use one of the modes below:
     * `Basic`: Create a plan with regular settings.
     * `Expert`: Create a plan with flexible settings using JSON (see the detailed syntax description [here](https://hystax.com/documentation/dr/dr_overview.html#id2)).
  1. Add VMs by clicking ![image](../../_assets/options.svg). If required, specify an initialization order by using the **Move to another Rank** option.
  1. If required, modify the parameters of the new VMs. To do this, specify the following in the **Flavor name** field: `<platform>-<cpu>-<ram>-<core_fraction>`, e.g., `2-8-16-100`.
  1. Under **Subnets** on the right, specify the properties of the previously created subnets: **Subned ID** and **CIDR**.
  1. Click **Save**.

  {% note warning %}

  Make sure you specified a valid IP address for each VM.

  {% endnote %}

{% endlist %}

## Run tests {#run-tests}

With regular tests, you can check your infrastructure fault tolerance as well as make early configuration changes.

To run a test without shutting down the primary infrastructure:
1. Open the Hystax Acura control panel. Click the Hystax logo.
1. In the top navigation panel, select **Run test Cloud Site**.
1. Tick the disaster recovery plans you need in the list. Expand and edit the plan, if required.
1. Click **Next**.
1. In the **Cloud Site Name** field, enter a name, e.g., `Cloud-Site-from-Plan-1`.
1. In the **Restore point time** field, open the calendar window and select the restore point that will be used to create your VMs.
1. Under **Final DR plan**, make sure the plan is up-to-date and correct.
1. Click **Run Recover**.

You will see the **Cloud Sites** section in the Hystax Acura control panel. Wait until the `Cloud-Site-from-Plan-1` status switches to `Running`.

Open the [management console]({{ link-console-main }}) and make sure these actions moved the required resources and your applications are ready to run.

## Perform disaster recovery {#run-recover}

A real disaster recovery is no different to a test one:
1. Open the Hystax Acura control panel. Click the Hystax logo.
1. In the top navigation panel, select **Run Cloud Site**.

Repeat the [test recovery](#run-tests) steps.

## How to delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Delete](../../compute/operations/vm-control/vm-delete.md) `hystax-acura-vm`.
1. [Delete](../../compute/operations/vm-control/vm-delete.md) the secondary `cloud-agent` VMs.
1. [Delete](../../iam/operations/sa/delete.md) the `hystax-acura-account` service account.

If you reserved a public static IP address, [delete it](../../vpc/operations/address-delete.md).
