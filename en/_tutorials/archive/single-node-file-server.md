# Single-node file server

You will learn to use [Samba](https://www.samba.org/) and [NFS](https://docs.microsoft.com/en-us/windows-server/storage/nfs/nfs-overview) to create a single-node file server, as well as connect to it from computers running Linux, macOS, and Windows.

To create a single-node file server:

1. [Prepare your cloud](#before-you-begin).
1. [Create a security group](#create-security-group).
1. [Create a virtual machine for your file server](#create-vm).
1. [Set up Samba and NFS](#setup-samba-nfs).
1. [Test your file server](#test-file-server).

If you no longer need the resources you created, [delete them](#clear-out).

You can also deploy the infrastructure for hosting a website via {{ TF }} using a [ready-made configuration file](#terraform).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of hosting a static website includes:

* Fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using a dynamic or a static public IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


### Prepare the network infrastructure {#deploy-infrastructure}

1. Go to the {{ yandex-cloud }} [management console]({{ link-console-main }}) and select the folder where you will perform the operations.
1. Make sure the selected folder has a network with a subnet that the VM can be connected to. To do this, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}** on the folder page. If the list contains a network, click its name to see the available subnets. If there is neither network nor subnet, [create them](../../vpc/quickstart.md).

## Create a security group {#create-security-group}

To create a [security group](../../vpc/concepts/security-groups.md) for your file server:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. Open the **{{ ui-key.yacloud.vpc.switch_security-groups }}** tab.
   1. Create a security group:

      1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** field, enter the group name: `fileserver-sg`.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** field, select the network where the `fileserver-tutorial` VM is located.
      1. Under **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}**, create the following rules using the instructions below the table:

         | Traffic<br/>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
         | --- | --- | --- | --- | --- | --- |
         | Outgoing | `any` | `All` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
         | Incoming | `ssh` | `22` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
         | Incoming | `ext-http` | `80` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
         | Incoming | `ext-https` | `443` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
         | Incoming | `nfs` | `2049` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |

         1. Select the **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** or **{{ ui-key.yacloud.vpc.network.security-groups.label_ingress }}** tab.
         1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
         1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** field of the window that opens, specify a single port or a range of ports that traffic will come to or from. To open all ports, click **{{ ui-key.yacloud.vpc.network.security-groups.forms.button_select-all-port-range }}**.
         1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** field, specify the appropriate protocol or leave **{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}** to allow traffic transmission over any protocol.
         1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** or **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** field, select the `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`, and the rule will apply to a range of IP addresses. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** field, enter `0.0.0.0/0`.
         1. Click **{{ ui-key.yacloud.common.save }}**. Repeat the steps to create all the rules from the table.

      1. Click **{{ ui-key.yacloud.common.save }}**.

- {{ TF }} {#tf}

   See [How to create an infrastructure using {{ TF }}](#terraform).

{% endlist %}

## Create a virtual machine for your file server {#create-vm}

To create a VM:

{% list tabs group=instructions %}

- Management console {#console}

   1. On the folder page in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.
   1. In the **{{ ui-key.yacloud.compute.instances.create.field_name }}** field, enter the VM name: `fileserver-tutorial`.
   1. Select an [availability zone](../../overview/concepts/geo-scope.md) to place your VM in.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, go to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab and select a public [Ubuntu](/marketplace?tab=software&search=Ubuntu&categories=os) image.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}**, click **{{ ui-key.yacloud.compute.instances.create.label_add-disk }}**. In the **{{ ui-key.yacloud.compute.instances.create-disk.label_title }}** window, specify the [disk](../../compute/concepts/disk.md) settings for data storage:
      * **{{ ui-key.yacloud.compute.disk-form.field_name }}**: `fileserver-tutorial-disk`
      * **{{ ui-key.yacloud.compute.disk-form.field_type }}**: `{{ ui-key.yacloud.compute.value_disk-type-network-ssd }}`
      * **{{ ui-key.yacloud.compute.disk-form.field_size }}**: `100 {{ ui-key.yacloud.common.units.label_gigabyte }}`
      * **{{ ui-key.yacloud.compute.disk-form.field_source }}**: `{{ ui-key.yacloud.compute.disk-form.value_source-none }}`

      Click **{{ ui-key.yacloud.compute.instances.create-disk.button_create }}**.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
      * Choose a [platform](../../compute/concepts/vm-platforms.md).
      * Specify the required number of vCPUs and the amount of RAM.

      Recommended values for the file server:
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `8` or more
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `56 {{ ui-key.yacloud.common.units.label_gigabyte }}` or more

   1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**, select the subnet to connect the VM to when creating it and specify the `fileserver-sg` security group.

   1. Specify the data required for accessing the VM:

      * Enter the username in the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.
      * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the public key file. You need to create the SSH [key pair yourself](../../compute/operations/images-with-pre-installed-software/operate.md#creating-ssh-keys).

   1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- {{ TF }} {#tf}

   See [How to create an infrastructure using {{ TF }}](#terraform).

{% endlist %}

It may take a few minutes to create the VM. When the VM status changes to `RUNNING`, you can [set up NFS and Samba](#setup-samba-nfs).

Once created, the VM is assigned an IP address and a host name (FQDN). This data can be used for SSH access.

## Set up Samba and NFS {#setup-samba-nfs}

After the `fileserver-tutorial` VM's status changes to `RUNNING`, do the following:

1. On the VM page of the [management console]({{ link-console-main }}), under **{{ ui-key.yacloud.compute.instance.overview.section_network }}**, find the VM's public IP address.

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH.

   The recommended authentication method when connecting over SSH is using a key pair. Make sure to set up the created key pair so that the private key matches the public key sent to the VM.

1. Configure Samba and NFS:

   {% list tabs group=operating_system %}

   - Ubuntu {#ubuntu}

      1. Download and install Samba:

         ```bash
         sudo apt-get update
         sudo apt-get install nfs-kernel-server samba
         ```

      1. Prepare and mount the file system on the disk:

         ```bash
         sudo mkfs -t ext4 -L data /dev/vdb
         ```

      1. Prepare and mount the folder for data storage on the disk:

         ```bash
         sudo mkdir /<folder_name>
         echo "LABEL=data /<folder_name> ext4 defaults 0 0" | sudo tee -a /etc/fstab
         sudo mount /<folder_name>
         ```

      1. Set the NFS configuration in the `/etc/exports` file. You can edit the file using the `nano` utility:

         ```bash
         sudo nano /etc/exports
         ```

         Add the following lines to the file:

         ```bash
         /<folder_name> <IP_address>(rw,no_subtree_check,fsid=100)
         /<folder_name> 127.0.0.1(rw,no_subtree_check,fsid=100)
         ```

         Where `<IP_address>` is the IP address of the computer to connect the network data disk via NFS.

      1. Set the Samba configuration in the `/etc/samba/smb.conf` file. You can edit the file using the `nano` utility:

         ```bash
         sudo nano /etc/samba/smb.conf
         ```

         Make the file look like:

         ```bash
         [global]
            workgroup = WORKGROUP
            server string = %h server (Samba)
            dns proxy = no
            log file = /var/log/samba/log.%m
            max log size = 1000
            syslog = 0
            panic action = /usr/share/samba/panic-action %d
            server role = standalone server
            passdb backend = tdbsam
            obey pam restrictions = yes
            unix password sync = yes
            passwd program = /usr/bin/passwd %u
            passwd chat = *Enter\snew\s*\spassword:* %n\n *Retype\snew\s*\spassword:* %n\n *password\supdated\ssuccessfully* .
            pam password change = yes
            map to guest = bad user
            usershare allow guests = yes
         [printers]
            comment = All Printers
            browseable = no
            path = /var/spool/samba
            printable = yes
            guest ok = no
            read only = yes
            create mask = 0700
         [print$]
            comment = Printer Drivers
            path = /var/lib/samba/printers
            browseable = yes
            read only = yes
            guest ok = no
         [data]
            comment = /<folder_name>
            path = /<folder_name>
            browseable = yes
            read only = no
            writable = yes
            guest ok = yes
            hosts allow = <IP_address> 127.0.0.1
            hosts deny = 0.0.0.0/0
         ```

         Where `<IP_address>` in the `[data]` section is the IP address of the computer to connect the network data disk via NFS.

      1. Restart Samba and NFS:

         ```bash
         sudo service nfs-kernel-server restart
         sudo service smbd restart
         ```

   {% endlist %}

## Test your file server {#test-file-server}

1. Install ACL on the `fileserver-tutorial` VM:

   {% list tabs group=operating_system %}

   - Ubuntu {#ubuntu}

      ```bash
      sudo apt install acl
      ```

   {% endlist %}

1. On the `fileserver-tutorial` VM instance, create a directory named `remote` and the `test.txt` file:

   {% list tabs group=operating_system %}

   - Ubuntu {#ubuntu}

      ```bash
      sudo mkdir /<folder_name>/remote
      sudo setfacl -m u:<name_of_your_user>:rwx /<folder_name>/remote
      echo "Hello world!" > /<folder_name>/remote/test.txt
      ```

   {% endlist %}

1. Connect the network disk to your computer via NFS and check if the test file is available:

   {% list tabs group=operating_system %}

   - Linux/macOS {#linux-macos}

      If needed, install the network disk utility:

      ```bash
      sudo apt-get install nfs-common
      ```

      Create a mount point:

      ```bash
      sudo mkdir /remote-test-dir
      ```

      Attach a network disk:

      ```bash
      sudo mount -t nfs <VM_public_IP_address>:/<folder_name> /remote-test-dir
      ```

      As as result, the test directory and the file should become available at the mount point.

   - Windows {#windows}

      1. Run the **cmd.exe** utility. To do this, use the **Windows** + **R** keyboard shortcut and run the `cmd` command.
      1. From the command line, run:

         ```bash
         net use x: \\<VM_public_IP_address>\<folder_name>
         ```

      Now you have the disk X with the test folder and file.

   {% endlist %}

## How to create an infrastructure using {{ TF }} {#terraform}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

To create a single-node file server using {{ TF }}:
1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Prepare files with the infrastructure description:

   {% list tabs group=infrastructure_description %}

   - Ready-made archive {#ready}

      1. Create a directory for files.
      1. Download the [archive](https://{{ s3-storage-host }}/doc-files/single-node-file-server.zip) (1 KB).
      1. Unpack the archive to the directory. Now, it should contain the `single-node-file-server.tf` configuration file.

   - Manually {#manual}

      1. Create a directory for files.
      1. Create a configuration file named `single-node-file-server.tf` in the folder:

         {% cut "single-node-file-server.tf" %}

         {% include [single-node-file-server-tf-config](../../_includes/archive/single-node-file-server-tf-config.md) %}

         {% endcut %}

   {% endlist %}

   For more information about the parameters of resources used in {{ TF }}, see the provider documentation:
   * [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network)
   * [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet)
   * [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group)
   * [yandex_compute_image]({{ tf-provider-resources-link }}/compute_image)
   * [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance)

1. Under `metadata`, enter your username and the contents of your SSH key. For more information, see [{#T}](../../compute/concepts/vm-metadata.md).
1. Create resources:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

1. [Set up Samba and NFS](#setup-samba-nfs).
1. [Test your file server](#test-file-server).

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete the VM](../../compute/operations/vm-control/vm-delete.md).
1. [Delete the static public IP](../../vpc/operations/address-delete.md) if you reserved one.
