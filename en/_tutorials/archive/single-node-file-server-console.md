1. [Get your cloud ready](#before-you-begin).
1. [Create a security group](#create-security-group).
1. [Create a virtual machine to host your file server](#create-vm).
1. [Set up Samba and NFS](#setup-samba-nfs).
1. [Test your file server](#test-file-server).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/single-node-file-server/paid-resources.md) %}

### Prepare your network infrastructure {#deploy-infrastructure}

1. Navigate to the {{ yandex-cloud }} [management console]({{ link-console-main }}) and select a folder for your network infrastructure.
1. Make sure the selected folder contains a network with a subnet you can connect your VM to. On the folder page, click **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**. You will see the list of available networks. If the list contains at least one network, click it to see its subnets. If you cannot see any networks or subnets [create them](../../vpc/quickstart.md) as required.

## Create a security group {#create-security-group}

To create a [security group](../../vpc/concepts/security-groups.md) for your file server:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Open the **{{ ui-key.yacloud.vpc.label_security-groups }}** tab.
  1. Create a security group:

     1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
     1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** field, specify the security group name: `fileserver-sg`.
     1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** field, select the network hosting the `fileserver-tutorial` VM.
     1. Under **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}**, create the following rules using the instructions below the table:

        | Traffic<br/>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
        | --- | --- | --- | --- | --- | --- |
        | Outbound | `any` | `All` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
        | Inbound | `ssh` | `22` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
        | Inbound | `ext-http` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
        | Inbound | `ext-https` | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
        | Inbound | `nfs` | `2049` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |

        1. Select the **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** or **{{ ui-key.yacloud.vpc.network.security-groups.label_ingress }}** tab.
        1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
        1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** field of the window that opens, specify a single port or a port range for traffic to come to or from. To open all ports, click **{{ ui-key.yacloud.vpc.network.security-groups.forms.button_select-all-port-range }}**.
        1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** field, specify the required protocol or leave **{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}** to allow traffic over any protocol.
        1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** or **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** field, select `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` for the rule to apply to a range of IP addresses. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** field, specify `0.0.0.0/0`.
        1. Click **{{ ui-key.yacloud.common.save }}**. Repeat these steps to create all rules from the table.

     1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Create a virtual machine to host your file server {#create-vm}

To create a VM:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your VM.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Select **{{ ui-key.yacloud.compute.instances.create.option_create-form-extended-title }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select the [Ubuntu](/marketplace?tab=software&search=Ubuntu&categories=os) public image.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../overview/concepts/geo-scope.md) for your VM.
  1. Add a secondary [disk](../../compute/concepts/disk.md) for data storage:

      * Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, click **{{ ui-key.yacloud.compute.instances.create-disk.button_create }}**.
      * In the window that opens, select **{{ ui-key.yacloud.compute.instances.create-disk.value_source-disk }}**.
      * Select `Create new disk` and specify the parameters:

          * **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}**: `{{ ui-key.yacloud.compute.instances.create-disk.value_source-none }}`
          * **{{ ui-key.yacloud.compute.instances.create-disk.field_name }}**: `fileserver-tutorial-disk`
          * **{{ ui-key.yacloud.compute.disk-form.field_type }}**: `{{ ui-key.yacloud.compute.value_disk-type-network-ssd_4Mmub }}`
          * **{{ ui-key.yacloud.compute.disk-form.field_size }}**: `100 {{ ui-key.yacloud.common.units.label_gigabyte }}`

      * Click **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}** tab, select the [platform](../../compute/concepts/vm-platforms.md) and specify the file server parameters:

      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `8` or more
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `56 {{ ui-key.yacloud.common.units.label_gigabyte }}` or more

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, enter the ID of a subnet in the new VM’s availability zone. Alternatively, select a [cloud network](../../vpc/concepts/network.md#network) from the list.

          * Each network must have at least one [subnet](../../vpc/concepts/network.md#subnet). If there is no subnet, create one by selecting **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.
          * If you do not have a network, click **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** to create one:

              * In the window that opens, specify the network name and select the folder to host the network.
              * Optionally, enable the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** setting to automatically create subnets in all availability zones.
              * Click **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` to assign the VM a random external IP address from the {{ yandex-cloud }} pool. If you reserved a static IP address, you can select it from the list.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** field, select the `fileserver-sg` security group you created earlier.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

      * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter a name for the user you want to create on the VM, e.g., `ubuntu`.

        {% note alert %}

        Do not use `root` or other reserved usernames. To perform operations requiring root privileges, use the `sudo` command.

        {% endnote %}

      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `fileserver-tutorial`.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

{% endlist %}

It may take a few minutes to create the VM. When the VM status switches to `RUNNING`, copy the public IP address from the **Network** section on the VM page. You will need it later to [configure NFS and Samba](#setup-samba-nfs).

## Set up Samba and NFS {#setup-samba-nfs}

{% include [setup-samba-nfs](../_tutorials_includes/single-node-file-server/setup-samba-nfs.md) %}

## Test your file server {#test-file-server}

{% include [single-node-file-server](../_tutorials_includes/single-node-file-server/test-file-server.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete the VM](../../compute/operations/vm-control/vm-delete.md).
1. [Delete the static public IP address](../../vpc/operations/address-delete.md) if you reserved one.