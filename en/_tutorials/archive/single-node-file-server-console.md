1. [Prepare your cloud](#before-you-begin).
1. [Create a security group](#create-security-group).
1. [Create a virtual machine for your file server](#create-vm).
1. [Set up Samba and NFS](#setup-samba-nfs).
1. [Test your file server](#test-file-server).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/single-node-file-server/paid-resources.md) %}

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
         | Incoming | `ssh` | `22` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
         | Incoming | `ext-http` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
         | Incoming | `ext-https` | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
         | Incoming | `nfs` | `2049` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |

         1. Select the **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** or **{{ ui-key.yacloud.vpc.network.security-groups.label_ingress }}** tab.
         1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
         1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** field of the window that opens, specify a single port or a range of ports that traffic will come to or from. To open all ports, click **{{ ui-key.yacloud.vpc.network.security-groups.forms.button_select-all-port-range }}**.
         1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** field, specify the appropriate protocol or leave **{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}** to allow traffic transmission over any protocol.
         1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** or **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** field, select the `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`, and the rule will apply to a range of IP addresses. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** field, enter `0.0.0.0/0`.
         1. Click **{{ ui-key.yacloud.common.save }}**. Repeat the steps to create all the rules from the table.

      1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Create a virtual machine for your file server {#create-vm}

To create a VM:

{% list tabs group=instructions %}

- Management console {#console}

   1. On the folder page in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.
   1. In the **{{ ui-key.yacloud.common.name }}** field, enter the VM name: `fileserver-tutorial`.
   1. Select an [availability zone](../../overview/concepts/geo-scope.md) to place your VM in.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, go to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab and select a public [Ubuntu](/marketplace?tab=software&search=Ubuntu&categories=os) image.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}**, click **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**. In the **{{ ui-key.yacloud.compute.instances.create-disk.label_title }}** window, specify the [disk](../../compute/concepts/disk.md) settings for data storage:
      * **{{ ui-key.yacloud.compute.instances.create-disk.field_name }}**: `fileserver-tutorial-disk`
      * **{{ ui-key.yacloud.compute.disk-form.field_type }}**: `{{ ui-key.yacloud.compute.value_disk-type-network-ssd }}`
      * **{{ ui-key.yacloud.compute.disk-form.field_size }}**: `100 {{ ui-key.yacloud.common.units.label_gigabyte }}`
      * **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}**: `{{ ui-key.yacloud.compute.instances.create-disk.value_source-none }}`

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
      * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the public key file. You need to [create an SSH key pair yourself](../../compute/operations/images-with-pre-installed-software/operate.md#creating-ssh-keys).

   1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

{% endlist %}

It may take a few minutes to create a VM. When the VM status changes to `RUNNING`, copy the public IP address: it will be listed on the VM page in the **Network** section. You will need the IP address later to [configure NFS and Samba](#setup-samba-nfs).

## Set up Samba and NFS {#setup-samba-nfs}

{% include [setup-samba-nfs](../_tutorials_includes/single-node-file-server/setup-samba-nfs.md) %}

## Test your file server {#test-file-server}

{% include [single-node-file-server](../_tutorials_includes/single-node-file-server/test-file-server.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete the VM](../../compute/operations/vm-control/vm-delete.md).
1. [Delete the static public IP](../../vpc/operations/address-delete.md) if you reserved one.