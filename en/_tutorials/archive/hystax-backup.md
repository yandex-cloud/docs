# Creating a VM backup with Hystax Acura Backup

You can create VM backups automatically and recover them in your cloud infrastructure using [Hystax Acura Backup in {{ yandex-cloud }}](/marketplace/products/hystax/hystax-acura-backup).

A VM with Hystax Acura Backup manages backup and recovery processes. VM backups are saved to a {{ objstorage-name }} [bucket](../../storage/concepts/bucket.md). Recovery is performed using an auxiliary Hystax Cloud Agent VM. It creates a new VM with a certain RPO (Recovery Point Objective) as of an arbitrary point of time in the past. A VM backup's RTO (Recovery Time Objective) depends on the amount of source data.

To back up and recover a VM using Hystax Acura Backup:

1. [Prepare your cloud](#before-begin).
1. [Create a service account](#create-sa).
1. [Configure network traffic permissions](#network-settings).
1. [Create a bucket](#create-bucket).
1. [Create a VM with Hystax Acura Backup](#create-acura-vm).
1. [Make the VM's IP address static](#static-ip).
1. [Set up Hystax Acura Backup](#setup-hystax-acura).
1. [Prepare and install an agent on the VM](#prepare-agent).
1. [Create a VM backup](#start-protection).
1. [Create a disaster recovery plan](#create-recovery-plan).
1. [Run the recovery process](#run-recover).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% note info %}

Please note that the Hystax Acura Backup infrastructure and all the recovered VMs will consume your [quotas]({{ link-console-quotas }}) and you will have to pay for them.
* A Hystax Acura Backup VM uses 8 vCPUs, 16 GB of RAM, and a 200-GB disk.
* The auxiliary Hystax Cloud Agent VMs use 2 vCPU cores, 4 GB or RAM, and a 10-GB disk. A single Hystax Acura Cloud Agent VM can serve up to 6 replicated disks at the same time. If there are more than 6 disks, additional Hystax Acura Cloud Agent VMs are created automatically.

For detailed system requirements, see the [Hystax documentation](https://cdn.hystax.com/Hystax/Documentation/Deployment-requirements.pdf).

{% endnote %}

The cost of the resources required to use Hystax Acura Backup includes:
* Fee for VM computing resources (see [{{ compute-full-name }} pricing](../../compute/pricing.md#prices-instance-resources)).
* Fee for VM disks (see [{{ compute-full-name }} pricing](../../compute/pricing.md#prices-storage)).
* Fee for using a dynamic or a static public IP (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md#prices-public-ip)).
* Fee for data storage in a bucket and operations with data (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md)).
* Fee for using Hystax Acura Backup (see [product description](/marketplace/products/hystax/hystax-acura-backup) in {{ marketplace-name }}).


### Create a service account and access keys {#create-sa}

Hystax Acura Backup will run under a [service account](../../iam/concepts/users/service-accounts.md).
1. [Create](../../iam/operations/sa/create.md) a service account named `hystax-acura-account` with the `editor` and `marketplace.meteringAgent` roles. Save the service account ID. You will need it later.
1. [Create](../../iam/operations/authorized-key/create.md) an authorized key for the service account. An authorized key is required to perform operations in {{ yandex-cloud }} as a service account. Save the ID and private key. You will need them later.
1. [Create](../../iam/operations/sa/create-access-key.md) a static access key. A static key is required to access a bucket as a service account. Save the ID and secret key. You will need them later.

### Configure network traffic permissions {#network-settings}

Configure network traffic permissions in the [default security group](../../vpc/concepts/security-groups.md#default-security-group). If a security group is unavailable, any incoming or outgoing VM traffic will be allowed.

If a security group is available, [add](../../vpc/operations/security-group-update.md#add-rule) the rules below to it:

| Traffic<br>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} /<br>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
--- | --- | --- | --- | --- | ---
| Incoming | `http` | `80` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
| Incoming | `https` | `443` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
| Incoming | `https` | `4443` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
| Incoming | `vmware` | `902` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
| Incoming | `vmware` | `902` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_udp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
| Incoming | `iSCSI` | `3260` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
| Incoming | `udp` | `12201` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_udp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
| Incoming | `tcp` | `15000` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
| Outgoing | `http` | `80` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
| Outgoing | `https` | `443` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
| Outgoing | `vmware` | `902` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
| Outgoing | `vmware` | `902` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_udp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
| Outgoing | `iSCSI` | `3260` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
| Outgoing | `udp` | `12201` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_udp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |

Save the security group ID. You will need it later.

{% note info %}

Auxiliary Hystax Cloud Agent VMs are created automatically in the default security group. If you created an individual group for the Hystax Acura Backup VM, [move](../../compute/operations/vm-control/vm-update.md) auxiliary Hystax Cloud Agent VMs to this group once they're created.

{% endnote %}

## Create a bucket {#create-bucket}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a bucket.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
   1. Click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
   1. On the bucket creation page:
      1. Enter the bucket name, following the [naming requirements](../../storage/concepts/bucket.md#naming).
      1. Limit the maximum bucket size, if required.

         {% include [storage-no-max-limit](../../storage/_includes_service/storage-no-max-limit.md) %}

      1. Select the type of [access](../../storage/concepts/bucket.md#bucket-access):
         * **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}**: `{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}`.
         * **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}**: `{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}`.
         * **{{ ui-key.yacloud.storage.bucket.settings.field_access-config-read }}**: `{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}`.
      1. Select the [storage class](../../storage/concepts/storage-class.md): `{{ ui-key.yacloud.storage.bucket.settings.class_value_standard }}`.
      1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}** to complete the operation.
   1. Save the bucket name. You will need it later.

- API

   Use the [create](../../storage/api-ref/Bucket/create.md) REST API method for the [Bucket](../../storage/api-ref/Bucket/) resource or the [BucketService/Create](../../storage/api-ref/grpc/bucket_service.md#Create) gRPC API call.

{% endlist %}

## Create a VM with Hystax Acura Backup {#create-acura-vm}

1. [Generate](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) an SSH key pair. You will need them when creating a VM.
1. To create a VM with recommended configuration and a boot disk from the Hystax Acura Backup image:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder to create your VM in.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. In the left-hand panel, select ![img](../../_assets/compute/vm-pic.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
      1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
         * Enter `hystax-acura-vm` as your VM name and add a description.
         * Select an [availability zone](../../overview/concepts/geo-scope.md) to place the VM in.

            Save the availability zone ID. You will need it later.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**:
         * Click the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab.
         * Click **{{ ui-key.yacloud.compute.instances.create.image_button_show-all-products }}**.
         * In the list of public images, select [Hystax Acura Backup in {{ yandex-cloud }}](/marketplace/products/hystax/hystax-acura-backup) and click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}**, enter `200 {{ ui-key.yacloud.common.units.label_gigabyte }}` as your disk size.

      1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, specify:
         * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `8`.
         * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `16 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
         * Select a cloud [network](../../vpc/concepts/network.md#network) from the list. If you don't have a network, click **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}**. Set the network parameters and click **{{ ui-key.yacloud.component.vpc.create-network-dialog.button_create }}**.
         * Select a [subnet](../../vpc/concepts/network.md#subnet). If you don't have a subnet, click ![image](../../_assets/plus.svg) **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**. Set the subnet parameters and click **{{ ui-key.yacloud.component.vpc.create-subnetwork-dialog.button_create }}**. Save the subnet ID. You will need it later.
         * In the **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** field, select the [security group](../../vpc/concepts/security-groups.md#default-security-group) for which you previously configured network traffic permissions.

            {% include [security-groups-note-vm](../../_includes/vpc/security-groups-note-vm.md) %}

      1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the information required to access the instance:
         * Select the [previously created](#create-sa) `hystax-acura-account` service account.
         * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter a user name for SSH access, such as `yc-user`.
         * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the public SSH key.
      1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

   - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      Run the following command:

      ```bash
      yc compute instance create \
        --name hystax-acura-vm \
        --zone <availability_zone> \
        --cores 8 \
        --memory 16 \
        --network-interface subnet-id=<subnet_ID>,nat-ip-version=ipv4,security-group-ids=<security_group_ID> \
        --create-boot-disk name=hystax-acura-disk,size=200,image-id=<Hystax_Acura_Backup_image_ID> \
        --service-account-id <service_account_ID> \
        --ssh-key <public_SSH_key_file_path>
      ```

      Where:
      * `name`: VM name, such as `hystax-acura-vm`.
      * `zone`: [Availability zone](../../overview/concepts/geo-scope.md), such as `{{ region-id }}-a`. Save the availability zone ID. You will need it later.
      * `cores`: [Number of vCPUs](../../compute/concepts/vm.md) in your VM.
      * `memory`: [Amount of RAM](../../compute/concepts/vm.md) in your VM.
      * `network-interface`: VM network interface description:
         * `subnet-id`: ID of the subnet to connect your VM to. You can get a list of subnets using the `yc vpc subnet list` CLI command. Save the subnet ID. You will need it later.
         * `nat-ip-version=ipv4`: Connect a public IP.
         * `security-group-ids`: Security group. Use this parameter if the group is previously configured. You can get a list of groups using the `yc vpc security-group list` CLI command. If you skip this parameter, the [default security group](../../vpc/concepts/security-groups.md#default-security-group) will be assigned.
      * `create-boot-disk`: Create a new disk for the VM:
         * `name`: Disk name, such as `hystax-acura-disk`.
         * `size`: Disk size.
         * `image-id`: Disk image ID. Use the `image_id` from the [product description](/marketplace/products/hystax/hystax-acura-backup) in {{ marketplace-name }}.
      * `service-account-id`: ID of the [previously created](#create-sa) service account. You can get a list of accounts using the `yc iam service-account list` command.
      * `ssh-key`: Path to the public SSH key file. The default username for access via SSH is `yc-user`.

   - API

      Use the [create](../../compute/api-ref/Instance/create.md) REST API method for the [Instance](../../compute/api-ref/Instance/) resource or the [InstanceService/Create](../../compute/api-ref/grpc/instance_service.md#Create) gRPC API call.

   {% endlist %}

## Make your VM's IP address static {#static-ip}

VMs are created with a public dynamic IP. Since a VM with Hystax Acura Backup may reboot, make the IP static.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), open the page for the folder you are using.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. Click the **{{ ui-key.yacloud.vpc.switch_addresses }}** tab.
   1. Click ![image](../../_assets/options.svg) in the row next to the address of your Hystax Acura Backup VM.
   1. In the menu that opens, select **{{ ui-key.yacloud.vpc.addresses.button_action-static }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.vpc.addresses.popup-confirm_button_static }}**.
   1. Save the IP. You will need it later.

- CLI

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the description of the CLI's update address attribute command:

      ```bash
      yc vpc address update --help
      ```

   1. Get a list of available addresses:

      ```bash
      yc vpc address list
      ```

      Result:

      ```bash
      +----------------------+------+-----------------+----------+------+
      |          ID          | NAME |     ADDRESS     | RESERVED | USED |
      +----------------------+------+-----------------+----------+------+
      | e2l46k8conff******** |      | {{ external-ip-examples.0 }}  | false    | true |
      +----------------------+------+-----------------+----------+------+
      ```

      The `false` value of the `RESERVED` parameter of the IP address with the `e2l46k8conff********` `ID` shows that this address is dynamic.
   1. Make the address static by using the `--reserved=true` key and IP address `ID`:

      ```bash
      yc vpc address update --reserved=true <IP_address_ID>
      ```

      Result:

      ```bash
      id: e2l46k8conff********
      folder_id: b1g7gvsi89m3********
      created_at: "2023-05-23T09:36:46Z"
      external_ipv4_address:
        address: {{ external-ip-examples.0 }}
        zone_id: {{ region-id }}-b
        requirements: {}
      reserved: true
      used: true
      ```

      The `reserved` parameter value changed to `true` and the IP address is now static.
   1. Save the IP. You will need it later.

- API

   Use the [update](../../vpc/api-ref/Address/update.md) REST API method for the [Address](../../vpc/api-ref/Address/index.md) resource or the [AddressService/Update](../../vpc/api-ref/grpc/address_service.md#Update) gRPC API call.

{% endlist %}

## Set up Hystax Acura Backup {#setup-hystax-acura}

1. Open the Hystax Acura Backup VM page in the [management console]({{ link-console-main }}) and find its public IP address.
1. Enter the Hystax Acura Backup VM public IP address in your browser. The initial setup screen opens.

   {% note info %}

   Booting the Hystax Acura Backup VM for the first time initiates an installation process which can take over 20 minutes.

   {% endnote %}

   By default, a Hystax Acura VM has a self-signed certificate installed.

   {% cut "To replace a self-signed certificate" %}

   1. Get the SSL certificate and private key files in one of the available ways.

   1. [Connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM with Hystax Acura Backup over SSH. Use the username you set when creating the VM and the private SSH key.

   1. Go to the `/tmp` directory by running the following command:

      ```bash
      cd /tmp
      ```

   1. Create a file named `private.key`:

      ```bash
      nano private.key
      ```

      Copy and paste the contents of the previously obtained private key file into it.

   1. Create a file named `certificate.pem`:

      ```bash
      nano certificate.pem
      ```

      Copy and paste the contents of the previously obtained SSL certificate file into it.

   1. To update the SSL certificate and the private key in the Hystax Acura Backup configuration, run this command:

      ```bash
      hx_update_nginx_ssl
      ```

   {% endcut %}

1. On the page that opens, fill out the following fields:
   * **Organization**: Name of your organization.
   * **Admin user login**: Administrator username.
   * **Password**: Administrator password.
   * **Confirm password**: Re-enter the administrator password.
1. Click **Next**.
1. Specify the {{ yandex-cloud }} connection settings:
   * **Service account ID**: The service account ID (obtained when [Creating a service account](#create-sa)).
   * **Key ID**: Service account authorized key ID (obtained when [creating a service account](#create-sa)).
   * **Private key**: The service account's private key (obtained when [Creating a service account](#create-sa)).

     {% note info %}

     {% include [hystax-auth-key-newlines](../_tutorials_includes/hystax-auth-key-newlines.md) %}

     {% endnote %}
     
   * **Default folder ID**: [ID](../../resource-manager/operations/folder/get-id.md) of your folder.
   * **Availability zone**: The ID of the availability zone hosting the Hystax Acura Backup VM (obtained [When creating a VM with Hystax Acura Backup](#create-acura-vm)).
   * **Hystax Service Subnet**: ID of the subnet that the Hystax Acura Backup VM is connected to (obtained when [Creating a VM with Hystax Acura Backup](#create-acura-vm).
   * **S3 Host**: `{{ s3-storage-host }}`.
   * **S3 Port**: `443`.
   * **Enable HTTPS**: Select the option to enable HTTPS connections.
   * **S3 Access Key ID**: The access key ID (obtained when [Creating a service account](#create-sa)).
   * **S3 Secret Access Key**: The secret key (obtained when [Creating a service account](#create-sa)).
   * **S3 Bucket**: The name of the bucket that stores VM backups (you set it when [Creating a bucket](#create-bucket)).
   * **Hystax Acura Control Panel Public IP**: Replace the value with the Hystax Acura Backup VM's public IP (assigned when [Creating a VM with Hystax Acura Backup](#create-acura-vm)).
   * **Additional parameters**: Advanced settings. Do not edit this field.
1. Click **Next**.

Hystax Acura Backup will automatically check whether it can access your cloud. If all the settings are correct, you can log in to the control panel using the previously set username and password.

## Prepare and install an agent on your VMs {#prepare-agent}

To install an agent on the VMs to create backups of:
1. Open the Hystax Acura Backup control panel. Click the Hystax logo.
1. Click **Download agents** on the left.
1. Select the agent type for the desired OS:
   * VMware
   * Windows
   * Linux
1. Click **Next**.
1. Download and install an agent on the VMs to create backups of:

   {% list tabs %}

   - VMware

      1. In the drop-down list, select a group of VMs to set up agents for, such as `Default`.
      1. Select **New VMware vSphere** and fill out the fields:
         * **Platform Name**: Name of the platform.
         * **Endpoint**: public IP address of the ESXi host where the replication agent will be deployed.
         * **Login**: User login (the user must have the administrator permissions).
         * **Password**: Password.

         Click **Next**.
      1. Click **Download Agent** and wait for the agent to download.
      1. Deploy the downloaded OVA file with the agent in your cluster on the VMs to create backups of.
      1. Start the VMs with the agent.

   - Windows

      1. In the drop-down list, select a group of VMs to set up agents for, such as `Default`.
      1. Click **Next**.
      1. Click **Download Agent** and wait for the agent to download.
      1. Unpack the archive and install the agent from `hwragent.msi` on the VMs to create backups of.

   - Linux

      1. In the drop-down list, select a group of VMs to set up agents for, such as `Default`.
      1. Select Linux distribution type:
         * **CentOS/RHEL (.rpm package)**: CentOS or Red Hat-based.
         * **Debian/Ubuntu (.deb package)**: Ubuntu or Debian.
      1. Select driver install method:
         * **Pre-built**: Install a driver binary.
         * **DKMS**: Compile as you install.
      1. Click **Next**.
      1. You will get commands for installing the agent to the VM. Run these commands following the instructions for your distribution and installation method.

   {% endlist %}

The VMs will appear in the target group of the Hystax Acura Backup control panel a few minutes after the agent is installed.

## Create a VM backup {#start-protection}

Once the agent is installed on the VMs to protect, they will show up in the list as `Unprotected`.

To enable VM protection:
1. Open the Hystax Acura Backup control panel. Click the Hystax logo.
1. Under **Machines Groups**, deploy an instance group, such as `Default`.
1. Click ![image](../../_assets/options.svg) in the VM list on the right.
1. In the **Edit replication settings** menu, set up a replication schedule for the instance group by hour, day, or week, or select continuous protection. In the **Volume type** section, specify the type of drive for VM recovery: `network-hdd`, `network-ssd`, or `network-ssd-nonreplicated`.
1. In the **Edit retention settings** menu, set the backup retention period. For more information, see the [Hystax documentation](https://hystax.com/documentation/dr/dr_overview.html#edit-replication-settings-schedule).
1. Select **Start Protection**.

VM replication will start. A VM replica will include all the data of the original VM. Therefore, replication can take a long time (depending on the original VM's disk size). The replication status will be displayed in the **Status** column under **Machines Groups**. Once it is complete, the VMs will change their status to `Protected`.

## Create a disaster recovery plan {#create-recovery-plan}

The DR plan includes a VM description and the network settings. The plan determines the VMs to recover to your cloud and the VM configuration, subnet, and IP. You can have a plan generated automatically or create one manually:

{% list tabs %}

- Automatically

   1. Open the Hystax Acura Backup control panel. Click the Hystax logo.
   1. Check the VMs you need on the list, click **Bulk actions**, and select **Generate DR plan**. You can also generate a plan for a group of VMs by clicking ![image](../../_assets/options.svg) in the group header.
   1. In the **Name** field, enter `Plan-1` as the name.
   1. In the **Subnets** section on the right, set the parameters of the subnet to run the recovered VMs in:
      * In the **Subnet ID** field, enter the subnet ID.
      * In the **CIDR** field, specify the subnet's [CIDR](../../vpc/concepts/network.md#subnet).
   1. Expand the VM description and edit the **Flavor name** field (parameters of the VM being restored) as follows: `<platform>-<cpu>-<ram>-<core_fraction>`. For example, `3-8-16-100`.

      Where:
      * `platform`: The VM [platform](../../compute/concepts/vm-platforms.md#standard-platforms), such as `1`, `2`, or `3`.
      * `cpu`: The number of vCPUs.
      * `ram`: The amount of RAM.
      * `core_fraction`: The vCPU performance level.
   1. In the **Port ip** field, enter a new IP for the VM from the selected subnet.
   1. Click **Save**.

- Manually

   1. Open the Hystax Acura Backup control panel. Click the Hystax logo.
   1. Click **Add DR Plan**.
   1. In the **Name** field, enter `Plan-1` as the name.
   1. Under **Devices & Ranks**, click ![image](../../_assets/options.svg). In the menu that opens, click **Add machine**. Select an instance group, such as `Default`. Select the VM to be added to the DR plan. Repeat the steps for all VMs to recover.
   1. In the **Subnets** section on the right, set the parameters of the subnet to run the recovered VMs in:
      * In the **Subnet ID** field, enter the subnet ID.
      * In the **CIDR** field, specify the subnet's [CIDR](../../vpc/concepts/network.md#subnet).
   1. Expand the VM description and edit the **Flavor name** field (parameters of the VM being restored) as follows: `<platform>-<cpu>-<ram>-<core_fraction>`. For example, `3-8-16-100`.

      Where:
      * `platform`: The VM [platform](../../compute/concepts/vm-platforms.md#standard-platforms), such as `1`, `2`, or `3`.
      * `cpu`: The number of vCPUs.
      * `ram`: The amount of RAM.
      * `core_fraction`: The vCPU performance level.
   1. In the **Port ip** field, enter a new IP for the VM from the selected subnet.
   1. Click **Save**.

{% endlist %}

{% note warning %}

Make sure a valid IP address is specified for each VM.

{% endnote %}

## Run the recovery process {#run-recover}

For a VM's recovery from a backup, Hystax Acura Backup will create a new VM with Hystax Acura Cloud Agent in your cloud. This VM will perform all operations in the cloud.

To run a VM's recovery from a backup:
1. Open the Hystax Acura Backup control panel. Click the Hystax logo.
1. Under **DR plans**, select the previously created plan. Expand plans and edit as required.
1. Click **Run Recover**.
1. In the **Cloud Site Name** field, enter a name, such as `Cloud-Site-from-Plan-1`.
1. Check that all the required resources are listed under **Final DR plan** and click **Run Recover**.

   The Hystax Acura Backup control panel will display a section named **Cloud Sites**. The VM recovery may take a long time. The recovery status will be displayed in the **Status** column under **Machines**. Wait until it changes to `Running`.

1. Open the [management console]({{ link-console-main }}) and check that all the required resources are restored.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
1. [Delete](../../compute/operations/vm-control/vm-delete.md) the Hystax Acura Backup VM.
1. [Delete](../../compute/operations/vm-control/vm-delete.md) the auxiliary Hystax Cloud Agent VMs.
1. [Delete](../../compute/operations/vm-control/vm-delete.md) the recovered VMs.
1. [Delete](../../storage/operations/buckets/delete.md) the respective bucket.
1. [Delete](../../iam/operations/sa/delete.md) the service account used for Hystax Acura Backup.
1. [Delete](../../vpc/operations/address-delete.md) the public static IP you reserved.
