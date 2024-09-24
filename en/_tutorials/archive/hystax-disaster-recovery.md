# Fault protection with Hystax Acura


No matter how your resource allocation is structured, you can protect your infrastructure with the Hystax Acura solution.

Supported platforms:
* Cloud services.
* Hypervisors.
* Physical servers.

To get started, create a VM with [Hystax Acura Disaster Recovery](/marketplace/products/hystax/hystax-acura-disaster-recovery) to manage replication and recovery. Continuous and periodic replication is performed by auxiliary Hystax Cloud Agent VMs. For a detailed description of the architecture, see the [Hystax documentation](https://hystax.com/documentation/dr/solution_description.html#architecture).

To run Hystax Acura Disaster Recovery, perform the steps below:
1. [Prepare your cloud](#before-begin).
1. [Create a service account and authorized key](#create-sa).
1. [Configure network traffic permissions](#network-settings).
1. [Create a VM with Hystax Acura](#create-acura-vm).
1. [Set up Hystax Acura](#setup-hystax-acura).
1. [Prepare and install the agents for disaster recovery](#prepare-agent).
1. [Enable replication](#start-protection).
1. [Set up the subnets to run the VMs](#prepare-network).
1. [Create a disaster recovery plan](#disaster-recovery-plan).
1. [Run exercises](#run-tests).
1. [Perform disaster recovery](#run-recover).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

{% note info %}

Note that both the Hystax Acura infrastructure and all the recovered VMs will be charged and counted against the [quotas]({{ link-console-quotas }}).
* A Hystax Acura Disaster Recovery VM uses 8 vCPUs, 16 GB of RAM, and a 200-GB disk.
* The auxiliary Hystax Cloud Agent VMs use 2 vCPU cores, 4 GB or RAM, and a 10-GB disk. A single Hystax Acura Cloud Agent VM can serve up to 6 replicated disks at the same time. If there are more than 6 disks, additional Hystax Acura Cloud Agent VMs are created automatically.

{% endnote %}

The cost of the resources required to use Hystax Acura Disaster Recovery includes:
* Fee for disks and continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for storing images (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Fee for using a dynamic or static external IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for each protected VM (see [product description](/marketplace/products/hystax/hystax-acura-disaster-recovery) in {{ marketplace-name }}).


## Create a service account and authorized key {#create-sa}

The Hystax Acura Disaster Recovery application will run under a [service account](../../iam/concepts/users/service-accounts.md):
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

Create a VM with a boot disk from the `Hystax Acura Disaster Recovery to {{ yandex-cloud }}` image.

### Run the VM

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder to create your VM in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
     * Enter a name, e.g., `hystax-acura-vm`, and description for the VM.
     * Select an [availability zone](../../overview/concepts/geo-scope.md) to place your VM in.

   1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**:

      * Go to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab.
      * Click **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**.
      * In the public image list, select [Hystax Acura Disaster Recovery to {{ yandex-cloud }}](/marketplace/products/hystax/hystax-acura-disaster-recovery) and click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.

   1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}**, enter `200 {{ ui-key.yacloud.common.units.label_gigabyte }}` as your disk size.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, specify:
     * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `8`
     * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `16 {{ ui-key.yacloud.common.units.label_gigabyte }}`
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
     * Select a cloud network and a [subnet](../../vpc/concepts/network.md#subnet) from the list. If there is no subnet, click **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}** and create one.

       To add a subnet, select a folder, enter a subnet name, select the availability zone, and specify a CIDR in the window that opens. Then click **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.
     * If a list of **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** is available, select the [security group](../../vpc/concepts/security-groups.md#default-security-group) for which you previously configured network traffic permissions. If this list does not exist, all incoming and outgoing traffic will be enabled for the VM.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the data for access to the VM:
     * Select the `hystax-acura-account` service account you created earlier.
     * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter a username for SSH access, e.g., `yc-user`.
     * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the [public SSH key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
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

        For this example, use `image_id` from the [product description](/marketplace/products/hystax/hystax-acura-disaster-recovery) in {{ marketplace-name }}.

   * `service-account-id`: ID of the [previously created](#create-sa) service account.

     You can get the list of accounts using the `yc vpc security-group list` command.
   * `ssh-key`: Path to the [public SSH key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) file.

{% endlist %}

### Make the IP static

VMs are created with a public dynamic IP. Since a VM with Hystax Acura may reboot, make the IP static.

{% list tabs group=instructions %}

- Management console {#console}

  To convert a dynamic public IP address to static:
  1. In the [management console]({{ link-console-main }}), open the page for the folder you are using.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Go to the **{{ ui-key.yacloud.vpc.switch_addresses }}** tab.
  1. Click ![image](../../_assets/options.svg) in the row with the address of your Hystax Acura VM.
  1. In the menu that opens, select **{{ ui-key.yacloud.vpc.addresses.button_action-static }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.vpc.addresses.popup-confirm_button_static }}**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To convert a dynamic public IP address to static:

  1. See the description of the CLI's update address attribute command:

     ```bash
     yc vpc address update --help
     ```

  1. Retrieve an address list:

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

     The `false` value of the `RESERVED` parameter indicates that the IP address with the `e2l46k8conff8n6ru1jl` `ID` is dynamic.
  1. Make this address static by using the `--reserved=true` key and the IP address `ID`:

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

     Now that the `reserved` parameter is `true`, the IP address is static.

{% endlist %}

## Set up Hystax Acura {#setup-hystax-acura}

1. Open the `hystax-acura-vm` VM page in the [management console]({{ link-console-main }}) and find its public IP address.
1. Enter the `hystax-acura-vm` VM public IP address in your browser. This will open the initial setup screen for Hystax Acura.

   {% note info %}

   After the Hystax Acura Disaster Recovery VM boots up for the first time, an installation process will start which may take over 20 minutes.

   {% endnote %}

1. By default, a Hystax Acura VM has a self-signed certificate installed.
1. On the page that opens, fill out the following fields:
   * **Organization**: Name of your organization.
   * **Admin user login**: Email address for logging in to Hystax Acura Control Panel.
   * **Password**: Administrator password.
   * **Confirm password**: Re-enter the administrator password.
1. Click **Next**.
1. Specify the {{ yandex-cloud }} connection settings:
   * **Service Account id**: ID of your service account.
   * **Key id**: ID of your service account authorized key.
   * **Private Key**: Private part of your service account authorized key.

     {% note info %}

     {% include [hystax-auth-key-newlines](../_tutorials_includes/hystax-auth-key-newlines.md) %}

     {% endnote %}
     
   * **Default Folder id**: ID of your folder.
   * **Zone**: Availability zone.
   * **Hystax Service Subnet**: ID of the subnet the `hystax-acura-vm` VM is connected to.
   * **S3 Host**: `{{ s3-storage-host }}`.
   * **S3 Port**: `443`.
   * **Enable HTTPS**: Select the option to enable HTTPS connections.
   * **Hystax Acura Control Panel Public IP**: Public IP address of the Hystax Acura VM. Replace the value in this field with the IP address obtained in step 1.
1. Click **Next**.

Hystax Acura will automatically check whether it can access your cloud. If everything is correct, you can now log in to the Hystax control panel using your email address and password.

## Prepare and install the agents for disaster recovery {#prepare-agent}

The agents will install on the VMs that will be recovered to {{ yandex-cloud }}. To download and install an agent:
1. In the Hystax Acura control panel, click the Hystax logo in the top-left corner.
1. Under **Machines Groups**, create a group of protected VMs, e.g, `Prod-Web`.
1. Click the **Download agents** tab.
1. Choose one out of three types of agents depending on the OS:
   * VMware
   * Windows
   * Linux

   Click **Next**.
1. Download and install the agent on the VMs you would like to protect:

   {% list tabs group=operating_system %}

   - VMware {#vmware}

     1. In the drop-down list, select a group of VMs to set up agents for, e.g., `Prod-Web`.
     1. Select **New VMware vSphere** and fill out the fields:
        * **Platform Name**: Name of the platform.
        * **Endpoint**: Public IP address of the ESXi host.
        * **Login**: User login (the user must have the administrator permissions).
        * **Password**: Password.

        Click **Next**.
     1. Click **Download Agent** and wait for the agent to download.
     1. Unpack the downloaded OVA file with the agent on the ESXi host.
     1. Start the VMs with the agent.

   - Windows {#windows}

     1. In the drop-down list, select a group of VMs to set up agents for, e.g., `Prod-Web`.
     1. Click **Next**.
     1. Click **Download Agent** and wait for the agent to download.
     1. Unpack the archive and install the agent from `hwragent.msi` on the VMs you want to protect.

   - Linux {#linux}

     1. In the drop-down list, select a group of VMs to set up agents for, e.g., `Prod-Web`.
     1. Select Linux distribution type:
        * **CentOS/RHEL (.rpm package)**: CentOS or Red Hat-based.
        * **Debian/Ubuntu (.deb package)**: Ubuntu or Debian.
     1. Select driver install method:
        * **Pre-built**: Install a driver binary.
        * **DKMS**: Compile as you install.
     1. Click **Next**.
     1. You will get commands for installing the agent to the VM. Run these commands following the instructions for your distribution and installation method.

   {% endlist %}

## Enable replication {#start-protection}

Once the agent is installed on the VMs to protect, they will appear in the list as `Unprotected`.

To enable VM replication:
1. Open the Hystax Acura control panel. Click the Hystax logo.
1. Under **Machines Groups**, deploy an instance group, e.g., `Prod-Web`.
1. In the VM list on the right, click ![image](../../_assets/options.svg).
1. Set up a replication schedule and an image lifecycle policy using the **Edit replication schedule** and **Edit retention policies** options. For more information, see the [Hystax documentation](https://hystax.com/documentation/dr/dr_overview.html#edit-replication-settings-schedule).
1. Select **Start Protection**.

VM replication will start. Once it is complete, the VMs will change their status to `Protected`.

## Set up the subnets to run the VMs {#prepare-network}

As the recovery process starts, a cloud site will be created; this is an infrastructure to support your application in {{ yandex-cloud }} that includes [subnets](../../vpc/concepts/network.md#subnet) and recovered VMs.

Create subnets, the CIDRs of which will contain the IPs of your VMs.

For example, if you are protecting two VMs with `10.155.0.23` and `192.168.0.3` as their IP adresses, create two subnets with `10.155.0.0/16` and `192.168.0.0/24` as their CIDRs. The subnets must be in the same [availability zone](../../overview/concepts/geo-scope.md) as the Hystax Acura Disaster Recovery VM.

To create subnets:

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}** section in the folder to create a subnet in.
  1. Click the name of the cloud network.
  1. Click **{{ ui-key.yacloud.vpc.network.overview.button_create_subnetwork }}**.
  1. Enter a name for the subnet, e.g., `net-b-155`.
  1. Select an availability zone from the drop-down list, e.g., `{{ region-id }}-b`.
  1. Enter the subnet CIDR, such as `10.155.0.0/16`.
  1. Click **{{ ui-key.yacloud.vpc.subnetworks.create.button_create }}**.

  Save the **IDs** of the created subnets. You will need these when you create your disaster recovery (DR) plan.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Retrieve a list of the cloud networks:

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

      Save the `ID` of the subnets you created. You will need these when you create your disaster recovery (DR) plan.

{% endlist %}

For more details, see [this step-by-step guide](../../vpc/operations/subnet-create.md) in the {{ vpc-name }} documentation.

## Create a disaster recovery plan {#disaster-recovery-plan}

The DR plan includes a VM description and the network settings. You can have a plan generated automatically or create one manually.

{% list tabs group=instructions %}

- Automatically {#auto}

  To generate a DR plan automatically:
  1. Open the Hystax Acura control panel. Click the Hystax logo.
  1. Check the VMs you need on the list, click **Bulk actions**, and select **Generate DR plan**. You can also generate a plan for an instance group by clicking ![image](../../_assets/options.svg) in the group header.
  1. In the **Name** field, enter `Plan-1`.
  1. Under **Subnets** on the right, specify the parameters of the previously created subnets: **Subned ID** and **CIDR**.
  1. Click **Save**.

- Manually {#manual}

  To create a DR plan manually:
  1. Open the Hystax Acura control panel. Click the Hystax logo.
  1. Click **Add DR Plan**.
  1. In the **Name** field, enter `Plan-1`.
  1. Use one of the modes below:
     * `Basic`: Create a plan with standard settings.
     * `Expert`: Create a plan with flexible settings using JSON (see [detailed syntax description](https://hystax.com/documentation/dr/dr_overview.html#id2)).
  1. Add VMs by clicking ![image](../../_assets/options.svg). If required, specify an initialization ordering by using the **Move to another Rank** option.
  1. If required, modify the parameters of the new VMs. To do this, in the **Flavor name** field, specify the following: `<platform>-<cpu>-<ram>-<core_fraction>`. For example, `2-8-16-100`.
  1. Under **Subnets** on the right, specify the parameters of the previously created subnets: **Subned ID** and **CIDR**.
  1. Click **Save**.

  {% note warning %}

  Make sure a valid IP address is specified for each VM.

  {% endnote %}

{% endlist %}

## Run exercises {#run-tests}

Regular exercises help verify disaster readiness as well as make changes to configurations in advance.

To run a test without shutting down the primary infrastructure:
1. Open the Hystax Acura control panel. Click the Hystax logo.
1. In the top navigation panel, select **Run test Cloud Site**.
1. Tick the disaster recovery plans you need in the list. Expand plans and edit as required.
1. Click **Next**.
1. In the **Cloud Site Name** field, enter a name, e.g., `Cloud-Site-from-Plan-1`.
1. In the **Restore point time** field, open the calendar window and select the restore point that will be used to create your VMs.
1. Under **Final DR plan**, verify that the plan is up-to-date and correct.
1. Click **Run Recover**.

The Hystax Acura control panel will display the **Cloud Sites** section. Wait until the status of `Cloud-Site-from-Plan-1` changes to `Running`.

Open the [management console]({{ link-console-main }}) and check that the required resources were moved successfully and your applications are ready to run.

## Perform disaster recovery {#run-recover}

A real disaster recovery is no different than a test one:
1. Open the Hystax Acura control panel. Click the Hystax logo.
1. In the top navigation panel, select **Run Cloud Site**.

Repeat the [test recovery](#run-tests) steps.

## How to delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Delete](../../compute/operations/vm-control/vm-delete.md) `hystax-acura-vm`.
1. [Delete](../../compute/operations/vm-control/vm-delete.md) the secondary `cloud-agent` VMs.
1. [Delete](../../iam/operations/sa/delete.md) the `hystax-acura-account` service account.

If you reserved a public static IP address, [delete it](../../vpc/operations/address-delete.md).