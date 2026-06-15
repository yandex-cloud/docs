---
title: Managing serial console access in {{ compute-full-name }}
description: Follow this guide to learn how to enable and disable access to the serial console of {{ compute-full-name }} VM instances.
---

# Managing serial console access

The [serial console](../../concepts/serial-console.md) allows you to access a [VM instance](../../concepts/vm.md) no matter what the [network](../../../vpc/concepts/network.md#network) or OS state currently is.

{% include [serial-console-roles](../../../_includes/compute/serial-console-roles.md) %}

By default, access to the {{ compute-name }} VM serial console is disabled.

{% include [sc-warning](../../../_includes/compute/serial-console-warning.md) %}

## Enabling access to the serial console {#enable}

You can enable access to the serial console either when creating a new VM instance or by updating the existing one.

### Creating a new VM with serial console access enabled {#turn-on-for-new-instance}

To enable access to the serial console when creating a new VM instance based on a public [image](../images-with-pre-installed-software/get-list.md) from [{{ marketplace-full-name }}](../../../marketplace/index.yaml):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your VM.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ compute-name }}**.
  1. In the left-hand panel, select ![server](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select one of the {{ marketplace-full-name }} [images](../../concepts/image.md).
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../../overview/concepts/geo-scope.md) where your VM will reside.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, select one of the preset configurations or create a custom one.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, enter the ID of a subnet in the new VM’s availability zone. Alternatively, select a [cloud network](../../../vpc/concepts/network.md#network) from the list.

          * Each network must have at least one [subnet](../../../vpc/concepts/network.md#subnet). If your network has no subnets, create one by selecting **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.
          * If there is no network, click **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** to create one:
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select the `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` address assignment method to assign a random IP address from the {{ yandex-cloud }} address pool.
      * Select the [relevant security groups](../../../vpc/concepts/security-groups.md). If you leave this field empty, the default security group will be assigned to the VM.
  1. {% include [section-access](../../../_includes/compute/create/section-access.md) %}
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, enter a name for your VM:

      {% include [name-format](../../../_includes/name-format.md) %}

      {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

  1. Expand the **{{ ui-key.yacloud.compute.instances.create.section_additional }}** section, and enable **{{ ui-key.yacloud.compute.instances.create.value_serial-port-enable }}** in the **{{ ui-key.yacloud.compute.instance.overview.field_serial-port-enable }}** field.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  The VM will appear in the list. The new VM will get an [IP address](../../../vpc/concepts/address.md) and a [host name](../../../vpc/concepts/address.md#fqdn) (FQDN).

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. [Create](../vm-connect/ssh.md#creating-ssh-keys) a key pair (public and private keys) for SSH access to the VM.
  1. Create a VM in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder). The example below creates a VM based on a public [image](../images-with-pre-installed-software/get-list.md) from [{{ marketplace-full-name }}](../../../marketplace/index.yaml) running [Ubuntu 24.04 LTS](/marketplace/products/yc/ubuntu-2404-lts-oslogin):

      ```bash
      yc compute instance create \
        --name sample-instance \
        --zone {{ region-id }}-a \
        --network-interface subnet-id=<subnet_ID>,nat-ip-version=ipv4 \
        --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2404-lts-oslogin,auto-delete=true \
        --metadata enable-oslogin=false,serial-port-enable=1,ssh-keys='<username>:<public_SSH_key>'
      ```

      Where:

      * `--name`: VM name. The naming requirements are as follows:

          {% include [name-format](../../../_includes/name-format.md) %}

          {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      * `--zone`: [Availability zone](../../../overview/concepts/geo-scope.md) to create the VM in.
      * `--network-interface`: Network settings of the new VM:

          * `subnet-id`: [ID of the subnet](../../../vpc/operations/subnet-get-info.md) in the availability zone the VM is created in.
      * `--metadata`: VM [metadata](../../concepts/vm-metadata.md):

          * `enable-oslogin`: Parameter responsible for access to the VM instance via [{{ oslogin }}](../../../organization/concepts/os-login.md). The possible values are:

              * `true`: To enable access to the VM via {{ oslogin }}. This will block access to the VM with the SSH key set via the metadata.
              * `false`: To disable access to the VM via {{ oslogin }}. Access the VM will only be possible with the SSH key set via the metadata.
          * `serial-port-enable=1`: Parameter enabling access to the VM via the serial console.
          * `ssh-keys`: Name of the local VM user and the contents of the [public SSH key](../vm-connect/ssh.md#creating-ssh-keys) that will allow this user to connect to the VM over SSH.

      For more information about the `yc compute instance create` command, see the [CLI reference](../../../cli/cli-ref/compute/cli-ref/instance/create.md).

{% endlist %}

### Enabling access to the serial console for an existing VM {#turn-on-for-current-instance}

To enable access to the serial console for an existing VM: 

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the VM instance resides in.

  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ compute-name }}**.

  1. In the left-hand panel, select ![server](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.

  1. Find the VM row in the VM list, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg), and select ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**. In the window that opens:

     1. Expand the **{{ ui-key.yacloud.compute.instances.create.section_additional }}** section, and enable **{{ ui-key.yacloud.compute.instances.create.value_serial-port-enable }}** in the **{{ ui-key.yacloud.compute.instance.overview.field_serial-port-enable }}** field.
     1. Click **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Update the VM by specifying its [name or ID](../vm-info/get-info.md#outside-instance) in the command below:

      ```bash
      yc compute instance update <VM_name_or_ID> \
        --metadata enable-oslogin=<true|false>,serial-port-enable=1,ssh-keys='<username>:<public_SSH_key>'
      ```

      Where `--metadata` is the VM [metadata](../../concepts/vm-metadata.md):

      * `enable-oslogin`: Parameter responsible for access to the VM instance via [{{ oslogin }}](../../../organization/concepts/os-login.md). The possible values are:

          * `true`: To enable access to the VM via {{ oslogin }}. This will block access to the VM with the SSH key set via the metadata.
          * `false`: To disable access to the VM via {{ oslogin }}. Access the VM will only be possible with the SSH key set via the metadata.
      * `serial-port-enable=1`: Parameter enabling access to the VM via the serial console.
      * `ssh-keys`: Name of the local VM user and the contents of the [public SSH key](../vm-connect/ssh.md#creating-ssh-keys) that will allow this user to connect to the VM over SSH.

     For more information about the `yc compute instance update` command, see the [CLI reference](../../../cli/cli-ref/compute/cli-ref/instance/update.md).

{% endlist %}

## Disabling access to the serial console {#disable}

Access to the serial console for all newly created {{ compute-name }} VMs is disabled by default.

To disable serial console access for an existing VM: 

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the VM instance resides in.

  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ compute-name }}**.

  1. In the left-hand panel, select ![server](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.

  1. Find the VM row in the VM list, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg), and select ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**. In the window that opens:

     1. Expand the **{{ ui-key.yacloud.compute.instances.create.section_additional }}** section, and enable **{{ ui-key.yacloud.compute.instances.create.value_serial-port-enable }}** in the **{{ ui-key.yacloud.compute.instance.overview.field_serial-port-enable }}** field.
     1. Click **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Update the VM by specifying its [name or ID](../vm-info/get-info.md#outside-instance) in the command below:

      ```bash
      yc compute instance update <VM_name_or_ID> \
        --metadata enable-oslogin=<true|false>,serial-port-enable=0,ssh-keys='<username>:<public_SSH_key>'
      ```

      Where `--metadata` is the VM [metadata](../../concepts/vm-metadata.md):

      * `enable-oslogin`: Parameter responsible for access to the VM instance via [{{ oslogin }}](../../../organization/concepts/os-login.md). The possible values are:

          * `true`: To enable access to the VM via {{ oslogin }}. This will block access to the VM with the SSH key set via the metadata.
          * `false`: To disable access to the VM via {{ oslogin }}. Access the VM will only be possible with the SSH key set via the metadata.
      * `serial-port-enable=1`: Parameter disabling access to the VM via the serial console.
      * `ssh-keys`: Name of the local VM user and the contents of the [public SSH key](../vm-connect/ssh.md#creating-ssh-keys) that will allow this user to connect to the VM over SSH.

      For more information about the `yc compute instance update` command, see the [CLI reference](../../../cli/cli-ref/compute/cli-ref/instance/update.md).

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/serial-console.md)
* [{#T}](./connect-ssh.md)
* [{#T}](./windows-sac.md)
