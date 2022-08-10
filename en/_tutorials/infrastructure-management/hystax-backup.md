# Creating a VM backup with Hystax Acura Backup

You can create VM backups automatically and recover them in your cloud infrastructure using [Hystax Acura Backup in {{ yandex-cloud }}](/marketplace/products/hystax/hystax-acura-backup).

A VM with Hystax Acura Backup manages backup and recovery processes. VM backups are saved to a {{ objstorage-name }} [bucket](../../storage/concepts/bucket.md). Recovery is performed using an auxiliary Hystax Cloud Agent VM. It creates a new VM with a certain RPO (Recovery Point Objective) as of an arbitrary point of time in the past. A VM backup's RTO (Recovery Time Objective) depends on the amount of source data.

To back up and recover a VM using Hystax Acura Backup:

1. [Before you start](#before-begin).
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

If you no longer need these resources, [delete them](#clear-out).

## Prepare your cloud {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% if product == "yandex-cloud" %}

### Required paid resources {#paid-resources}

{% note info %}

Please note that the Hystax Acura Backup infrastructure and all the recovered VMs will consume your [quotas]({{ link-console-quotas }}) and you'll have to pay for them.
* A Hystax Acura Backup VM uses 8 vCPUs, 16 GB of RAM, and a 200GB disk.
* The auxiliary Hystax Cloud Agent VMs use 2 vCPU cores, 4 GB or RAM, and a 10-GB disk. A single Hystax Acura Cloud Agent VM can serve up to 6 replicated disks at the same time. If there are more than 6 disks, additional Hystax Acura Cloud Agent VMs are created automatically.

For detailed system requirements, see the [Hystax documentation](https://cdn.hystax.com/Hystax/Documentation/Deployment-requirements.pdf).

{% endnote %}

The cost of the resources required to use Hystax Acura Backup includes:
* A fee for VM computing resources (see [{{ compute-full-name }} pricing](../../compute/pricing.md#prices-instance-resources)).
* A fee for VM disks (see [{{ compute-full-name }} pricing](../../compute/pricing.md#prices-storage)).
* A fee for using a dynamic or a static public IP (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md#prices-public-ip)).
* A fee for data storage in a bucket and operations with data (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md)).
* A fee for using Hystax Acura Backup (see [product description](/marketplace/products/hystax/hystax-acura-backup) in {{ marketplace-name }}).

{% endif %}

### Create a service account and access keys {#create-sa}

Hystax Acura Backup will run under a [service account](../../iam/concepts/users/service-accounts.md).
1. [Create](../../iam/operations/sa/create.md) a service account named `hystax-acura-account` with the `editor` and `marketplace.meteringAgent` roles. Save the service account ID. You will need it later.
1. [Create](../../iam/operations/authorized-key/create.md) an authorized key for a service account. An authorized key is required to perform operations in {{ yandex-cloud }} as a service account. Save the ID and private key. You'll need them later.
1. [Create](../../iam/operations/sa/create-access-key.md) a static access key. A static key is required to access a bucket as a service account. Save the ID and secret key. You'll need them later.

### Configure network traffic permissions {#network-settings}

Configure network traffic permissions in the [default security group](../../vpc/concepts/security-groups.md#default-security-group). If a security group is unavailable, any incoming or outgoing VM traffic will be allowed.

If a security group is available, [add](../../vpc/operations/security-group-update.md#add-rule) to it the rules below:

| Traffic<br>direction | Description | Port<br>range | Protocol | Source<br>type | Source/Purpose |
--- | --- | --- | --- | --- | ---
| Incoming | http | 80 | TCP | CIDR | 0.0.0.0/0 |
| Incoming | https | 443 | TCP | CIDR | 0.0.0.0/0 |
| Incoming | https | 4443 | TCP | CIDR | 0.0.0.0/0 |
| Incoming | vmware | 902 | TCP | CIDR | 0.0.0.0/0 |
| Incoming | vmware | 902 | UDP | CIDR | 0.0.0.0/0 |
| Incoming | iSCSI | 3260 | TCP | CIDR | 0.0.0.0/0 |
| Incoming | udp | 12201 | UDP | CIDR | 0.0.0.0/0 |
| Incoming | TCP | 15000 | TCP | CIDR | 0.0.0.0/0 |
| Outgoing | http | 80 | TCP | CIDR | 0.0.0.0/0 |
| Outgoing | https | 443 | TCP | CIDR | 0.0.0.0/0 |
| Outgoing | vmware | 902 | TCP | CIDR | 0.0.0.0/0 |
| Outgoing | vmware | 902 | UDP | CIDR | 0.0.0.0/0 |
| Outgoing | iSCSI | 3260 | TCP | CIDR | 0.0.0.0/0 |
| Outgoing | udp | 12201 | UDP | CIDR | 0.0.0.0/0 |

Save the security group ID. You'll need it later.

{% note info %}

Auxiliary Hystax Cloud Agent VMs are created automatically in the default security group. If you created an individual group for the Hystax Acura Backup VM, [move](../../compute/operations/vm-control/vm-update.md) auxiliary Hystax Cloud Agent VMs to this group once they're created.

{% endnote %}

## Create a bucket {#create-bucket}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a bucket.
   1. Select **{{ objstorage-name }}**.
   1. Click **Create bucket**.
   1. On the bucket creation page:
      1. Enter the bucket name, following the [naming guidelines](../../storage/concepts/bucket.md#naming).
      1. If necessary, limit the maximum bucket size.

         {% include [storage-no-max-limit](../../storage/_includes_service/storage-no-max-limit.md) %}

      1. Select the type of [access](../../storage/concepts/bucket.md#bucket-access):
         * **Object read access**: **Limited**.
         * **Object listing access**: **Limited**.
         * **Read access to settings**: **Limited**.
      1. Select the [storage class](../../storage/concepts/storage-class.md): **Standard**.
      1. Click **Create bucket** to complete the operation.
   1. Save the bucket name. You will need it later.

{% endlist %}

## Create a VM with Hystax Acura Backup {#create-acura-vm}

1. [Generate](../../compute/operations/vm-connect/ssh#creating-ssh-keys) an SSH key pair. You'll need them when creating a VM.
1. To create a VM with recommended characteristics and a boot disk from the Hystax Acura Backup image:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder to create your VM in.
      1. In the list of services, select **{{ compute-name }}**.
      1. Click **Create VM**.
      1. Under **Basic parameters**:
         * Enter `hystax-acura-vm` as your name and a VM description.
         * Select an [availability zone](../../overview/concepts/geo-scope.md) to place the VM in.

            Save the availability zone ID. You'll need it later.
      1. Under **Image/boot disk selection**:
         * Click the **{{ marketplace-name }}** tab.
         * Click **Show more**.
         * In the list of public images, select [Hystax Acura Backup in {{ yandex-cloud }}](/marketplace/products/hystax/hystax-acura-backup) and click **Use**.
      1. Under **Disks**, enter 200 GB as your disk size.

      {% if product == "yandex-cloud" %}

      1. Under **File storage**, keep the default value.

      {% endif %}

      1. Under **Computing resources**, specify:
         * vCPU: 8.
         * RAM: 16 GB.
      1. Under **Network settings**:
         * Select a cloud [network](../../vpc/concepts/network.md#network) from the list. If you don't have a network, click **Create network**. Set the network parameters and click **Create**.
         * Select a [subnet](../../vpc/concepts/network.md#subnet). If you don't have a subnet, click ![image](../../_assets/plus.svg) **Add subnet**. Set the subnet parameters and click **Create**. Save the subnet ID. You will need it later.
         * If a list of **Security groups** is available, select the [security group](../../vpc/concepts/security-groups.md#default-security-group) for which you previously configured network traffic permissions. If this list does not exist, all incoming and outgoing traffic will be enabled for the VM.
      1. Under **Access**, specify the information required to access the instance:
         * Select the [previously created](#create-sa) `hystax-acura-account` service account.
         * In the **Login** field, enter a user name for SSH access, such as `yc-user`.
         * In the **SSH key** field, paste the public SSH key.
      1. Click **Create VM**.

   - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      Run the command:

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
      * `zone`: [Availability zone](../../overview/concepts/geo-scope.md), such as `{{ region-id }}-a`. Save the availability zone ID. You'll need it later.
      * `cores`: [Number of vCPUs](../../compute/concepts/vm.md) in your VM.
      * `memory`: [Amount of RAM](../../compute/concepts/vm.md) in your VM.
      * `network-interface`: VM network interface description:
         * `subnet-id`: ID of the subnet to connect your VM to. You can get a list of subnets using the `yc vpc subnet list` CLI command. Save the subnet ID. You will need it later.
         * `nat-ip-version=ipv4`: Connect a public IP.
         * `security-group-ids`: Security group. Use this parameter if the group is previously configured. You can get a list of groups using the `yc vpc security-group list` CLI command. If you omit the parameter, the [default security group](../../vpc/concepts/security-groups.md#default-security-group) will be assigned.
      * `create-boot-disk`: Crete a new disk for the VM:
         * `name`: Disk name, such as `hystax-acura-disk`.
         * `size`: Disk size.
         * `image-id`: Disk image ID. Use the `image_id` from the [product description](/marketplace/products/hystax/hystax-acura-backup) in {{ marketplace-name }}.
      * `service-account-id`: ID of [previously created](#create-sa) service account. You can get a list of accounts using the `yc iam service-account list` command.
      * `ssh-key`: Path to the public SSH key file. The default username for access via SSH is `yc-user`.

   {% endlist %}

## Make your VM's IP address static {#static-ip}

VMs are created with a public dynamic IP. Since a VM with Hystax Acura Backup may reboot, make the IP static.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), open the page for the folder you are using.
   1. Select **{{ vpc-name }}**.
   1. Go to the **IP addresses** tab.
   1. Click ![image](../../_assets/options.svg) in the row next to the address of your Hystax Acura Backup VM.
   1. In the menu that opens, select **Make static**.
   1. In the window that opens, click **Change**.
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
      +----------------------+------+---------------+----------+------+
      |          ID          | NAME |    ADDRESS    | RESERVED | USED |
      +----------------------+------+---------------+----------+------+
      | e2l46k8conff8n6ru1jl |      | 84.201.177.41 | false    | true |
      +----------------------+------+---------------+----------+------+
      ```

      The `false` value of the `RESERVED` parameter of the IP address with the `ID` `e2l46k8conff8n6ru1jl` shows that this address is dynamic.
   1. Make the address static by using the `--reserved=true` key and IP address `ID`:

      ```bash
      yc vpc address update --reserved=true <IP_address_ID>
      ```

      Result:

      ```bash
      id: e2l46k8conff8n6ru1jl
      folder_id: b1g7gvsi89m34pipa3ke
      created_at: "2022-01-14T09:36:46Z"
      external_ipv4_address:
        address: 84.201.177.41
        zone_id: {{ region-id }}-b
        requirements: {}
      reserved: true
      used: true
      ```

      The `reserved` parameter value changed to `true` and the IP address is now static.
   1. Save the IP. You will need it later.

{% endlist %}

## Set up Hystax Acura Backup {#setup-hystax-acura}

1. Open the Hystax Acura Backup VM page in the [management console]({{ link-console-main }}) and find its public IP address.
1. Enter the Hystax Acura Backup VM public IP address in your browser. The initial setup screen opens.

   {% note info %}

   Booting the Hystax Acura Backup VM for the first time initiates an installation process which can take over 20 minutes.

   {% endnote %}

1. By default, a Hystax Acura VM has a self-signed certificate installed. If you need to replace this certificate, follow the [procedure](https://support.hystax.com/portal/en/kb/articles/how-to-update-ssl-certificate-on-acura).
1. On the page that opens, fill in the following fields:
   * **Organization**: The name of your organization.
   * **Admin user login**: The administrator username.
   * **Password**: The administrator password.
   * **Confirm password**: Re-enter the administrator password.
1. Click **Next**.
1. Specify the {{ yandex-cloud }} connection settings:
   * **Service account ID**: The service account ID (obtained when [Creating a service account](#create-sa)).
   * **Key ID**: The service account's authorized key ID (obtained when [Creating a service account](#create-sa)).
   * **Private key**: The service account's private key (obtained when [Creating a service account](#create-sa)).
   * **Default folder ID**: The [ID](../../resource-manager/operations/folder/get-id.md) of your folder.
   * **Availability zone**: The ID of the availability zone hosting the Hystax Acura Backup VM (obtained [When creating a VM with Hystax Acura Backup](#create-acura-vm)).
   * **Hystax Service Subnet**: The ID of the subnet that the Hystax Acura Backup VM is connected to (obtained when [Creating a VM with Hystax Acura Backup](#create-acura-vm).
   * **S3 Host**: `{{ s3-storage-host }}`.
   * **S3 Port**: `443`.
   * **Enable HTTPS**: Select the option to enable HTTPS connections.
   * **S3 Access Key ID**: The access key ID (obtained when [Creating a service account](#create-sa)).
   * **S3 Secret Access Key**: The secret key (obtained when [Creating a service account](#create-sa)).
   * **S3 Bucket**: The name of the bucket that stores VM backups (you set it when [Creating a bucket](#create-bucket)).
   * **Hystax Acura Control Panel Public IP**: Replace the value with the Hystax Acura Backup VM's public IP (assigned when [Creating a VM with Hystax Acura Backup](#create-acura-vm)).
   * **Additional parameters**: Advanced settings. Do not edit this field.
1. Click **Next**.

Hystax Acura Backup automatically checks that it can access your cloud. If all the settings are correct, you can log in to the control panel using the previously set username and password.

## Prepare and install an agent on your VMs {#prepare-agent}

To install an agent on the VMs to create backups of:
1. Open the Hystax Acura Backup control panel. Click on the Hystax logo.
1. Click **Download agents** on the left.
1. Select the agent type for the desired OS:
   * VMware.
   * Windows.
   * Linux.
1. Click **Next**.
1. Download and install an agent on the VMs to create backups of:

   {% list tabs %}

   - VMware

      1. In the drop-down list, select a group of VMs to set up agents for, such as `Default`.
      1. Select **New VMware vSphere** and fill in the fields:
         * **Platform Name**: The name of the platform.
         * **Endpoint**: The public IP address of the ESXi host where the replication agent will be deployed.
         * **Login**: The user's login (the user must have the Administrator permissions).
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
      1. Commands for the VM agent install will be generated. Run the commands as required by the procedure for your distribution and install method.

   {% endlist %}

The VMs will appear in the target group of the Hystax Acura Backup control panel a few minutes after the agent is installed.

## Create a VM backup {#start-protection}

After the agent is installed on the VMs to be protected, they will show up in the list as `Unprotected`.

To enable VM protection:
1. Open the Hystax Acura Backup control panel. Click on the Hystax logo.
1. Under **Machines Groups**, deploy an instance group, such as `Default`.
1. Click ![image](../../_assets/options.svg) in the VM list on the right.
1. In the **Edit replication settings** menu, set up a replication schedule for the instance group by hour, day, or week, or select continuous protection. In the **Volume type** section, specify the type of drive for VM recovery: `network-hdd`, `network-ssd`, or `network-ssd-nonreplicated`.
1. In the **Edit retention settings** menu, set the backup retention period. For more information, see the [Hystax documentation](https://hystax.com/documentation/dr/dr_overview.html?highlight=replication%20schedule#edit-replication-settings-schedule).
1. Select **Start Protection**.

VM replication will start. A VM replica will include all the data of the original VM. Therefore, replication can take a long time (depending on the original VM's disk size). Replication status will be displayed in the **Status** column under **Machines Groups**. Once the process is complete, the VMs will change their status to `Protected`.

## Create a disaster recovery plan {#create-recovery-plan}

The DR plan includes a VM description and the network settings. The plan determines the VMs to recover to your cloud and the VM configuration, subnet, and IP. You can have a plan generated automatically or create one manually:

{% list tabs %}

- Automatically

   1. Open the Hystax Acura Backup control panel. Click on the Hystax logo.
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

   1. Open the Hystax Acura Backup control panel. Click on the Hystax logo.
   1. Click **Add DR Plan**.
   1. In the **Name** field, enter `Plan-1` as the name.
   1. Under **Devices & Ranks**, click ![image](../../_assets/options.svg). In the menu that opens, click **Add machine**. Select an instance group, such as `Default`. Select the VM to be added to the DR plan. Repeat the steps for all the VMs to recover.
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

Make sure that a valid IP address is specified for each VM.

{% endnote %}

## Run the recovery process {#run-recover}

For a VM's recovery from a backup, Hystax Acura Backup will create a new VM with Hystax Acura Cloud Agent in your cloud. This VM will perform all operations in the cloud.

To run a VM's recovery from a backup:
1. Open the Hystax Acura Backup control panel. Click on the Hystax logo.
1. Under **DR plans**, select the previously created plan. Expand plans and edit as required.
1. Click **Run Recover**.
1. In the **Cloud Site Name** field, enter a name, such as `Cloud-Site-from-Plan-1`.
1. Check that all the required resources are listed under **Final DR plan** and click **Run Recover**.

   The Hystax Acura Backup control panel will display a section named **Cloud Sites**. The VM recovery may take a long time. The recovery status will be displayed in the **Status** column under **Machines**. Wait until it changes to `Running`.

1. Open the [management console]({{ link-console-main }}) and check that all the required resources are restored.

## How to delete created resources {#clear-out}

To stop paying for the resources created:
1. [Delete](../../compute/operations/vm-control/vm-delete.md) the Hystax Acura Backup VM.
1. [Delete](../../compute/operations/vm-control/vm-delete.md) the auxiliary Hystax Cloud Agent VMs.
1. [Delete](../../compute/operations/vm-control/vm-delete.md) the recovered VMs.
1. [Delete](../../storage/operations/buckets/delete.md) the respective bucket.
1. [Delete](../../iam/operations/sa/delete.md) the service account used for Hystax Acura Backup.
1. [Delete](../../vpc/operations/address-delete.md) the public static IP you reserved.
