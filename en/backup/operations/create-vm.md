---
title: "How to create a Linux VM with a connection to {{ backup-full-name }}"
description: "Follow this guide to create a Linux VM with a connection to {{ backup-name }}."
---

# Creating a Linux VM with a connection to {{ backup-name }}

You can back up {{ compute-name }} [VMs](../../compute/concepts/vm.md) with [supported Linux-based operating systems](../concepts/vm-connection.md#linux).

{% include [requirements](../../_includes/backup/requirements.md) %}

## Getting started {#before-you-begin}

1. [Create](../../iam/operations/sa/create.md) a service account with the `backup.editor` [role](../security/index.md#backup-editor).
1. [Set up](../concepts/vm-connection.md#vm-network-access) network access for your VM.

## Creating a VM {#creating-vm}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a VM.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}** and click **{{ ui-key.yacloud.compute.instances.button_create }}**.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
      * Enter a name and description for the VM. The naming requirements are as follows:

         {% include [name-format](../../_includes/name-format.md) %}

         {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

      * Select an [availability zone](../../overview/concepts/geo-scope.md) to place your VM in.

   1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, choose [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts) or lower or [CentOS 7](/marketplace/products/yc/centos-7).
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
      1. Choose a subnet in the selected availability zone.
      1. In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
      1. Select a security group configured to work with {{ backup-name }}.
   1. Under **{{ ui-key.yacloud.compute.instances.create.label_backup }}**, enable the {{ backup-name }} connection option for your VM.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select the service account with the `backup.editor` role.
   1. Specify the other VM parameters as needed. For more information, see [Creating a VM from a public Linux image](../../compute/operations/vm-create/create-linux-vm).
   1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

   {% include [agent-installation-timespan](../../_includes/backup/agent-installation-timespan.md) %}

- CLI {#cli}

   1. Select a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc resource-manager folder list
      ```

      Result:

      ```bash
      +----------------------+--------------------+------------------+--------+
      |          ID          |        NAME        |      LABELS      | STATUS |
      +----------------------+--------------------+------------------+--------+
      | wasdcjs6be29******** | my-folder          |                  | ACTIVE |
      | qwertys6be29******** | default            |                  | ACTIVE |
      +----------------------+--------------------+------------------+--------+
      ```

   1. Select a [subnet](../../vpc/concepts/network.md#subnet):

      ```bash
      yc vpc subnet list --folder-id <folder_ID>
      ```

      Result:

      ```text
      +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
      |          ID          |           NAME            |      NETWORK ID      | ROUTE TABLE ID |       ZONE        |      RANGE      |
      +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
      | b0c6n43f9lgh******** | default-{{ region-id }}-d     | enpe3m3fa00u******** |                | {{ region-id }}-d     | [10.***.0.0/24] |
      | e2l2da8a20b3******** | default-{{ region-id }}-b     | enpe3m3fa00u******** |                | {{ region-id }}-b     | [10.***.0.0/24] |
      | e9bnlm18l70a******** | default-{{ region-id }}-a     | enpe3m3fa00u******** |                | {{ region-id }}-a     | [10.***.0.0/24] |
      +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
      ```

   1. [Create](../../compute/operations/vm-create/create-linux-vm.md) a VM:

      ```bash
      yc compute instance create \
        --folder-id <folder_ID> \
        --name <VM_name> \
        --zone <availability_zone> \
        --network-interface subnet-name=<subnet_name>,nat-ip-version=ipv4,security-group-ids=<security_group_ID> \
        --create-boot-disk image-id=<image_ID>,size=<boot_disk_size> \
        --cores 2 \
        --core-fraction 100 \
        --memory 4 \
        --service-account-name <service_account_name> \
        --ssh-key <path_to_public_SSH_key>
      ```

      Where:

      * `--folder-id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
      * `--name`: Name of the new VM.

         {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

      * `--zone`: [Availability zone](../../overview/concepts/geo-scope.md) that corresponds to the selected subnet.
      * `subnet-name`: Name of the selected [subnet](../../vpc/concepts/network.md#subnet).
      * `security-group-ids`: ID of the [security group](../../vpc/concepts/security-groups.md) configured to work with {{ backup-name }}.
      * `image-id`: OS [image](../../compute/concepts/image.md) ID.
      * `size`: Boot disk size.
      * `--cores`: [Number of vCPUs](../../compute/concepts/vm.md) in the VM.
      * `--core-fraction`: Guaranteed vCPU share in %.
      * `--memory`: VM [RAM size](../../compute/concepts/vm.md).
      * `--service-account-name`: Name of the [service account](../../iam/concepts/users/service-accounts.md) with the `backup.editor` role.
      * `--ssh-key`: Path to the file with the [public SSH key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys). The VM will automatically create a user named `yc-user` for this key.

      In this example, a VM running on [Ubuntu 20.04](https://yandex.cloud/en/marketplace/products/yc/ubuntu-20-04-lts) is created:

      ```bash
      yc compute instance create \
        --folder-id wasdcjs6be29******** \
        --name my-vm \
        --zone {{ region-id }}-b \
        --network-interface subnet-name=my-vpc-{{ region-id }}-b,nat-ip-version=ipv4,security-group-ids=abcd3570sbqg******** \
        --create-boot-disk image-id=fd8ecgtorub9********,size=25 \
        --cores 2 \
        --core-fraction 100 \
        --memory 4 \
        --service-account-name backup-editor \
        --ssh-key my-key.pub
      ```

      Result:

      ```bash
      done (46s)
      id: abcdho6nspdk********
      folder_id: wasdcjs6be29********
      created_at: "2023-10-09T14:57:06Z"
      name: my-vm
      ...
            one_to_one_nat:
              address: 158.***.**.***
      ...
      placement_policy: {}
      ```

   1. [Connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM over SSH. Establish a connection as `yc-user` and use the VM's public IP address from the create VM command output under `one_to_one_nat`.
   1. Install the {{ backup-name }} agent:

      **Ubuntu**

      ```bash
      sudo apt update && \
      sudo apt install -y jq && \
      curl https://{{ s3-storage-host }}/backup-distributions/agent_installer.sh | sudo bash
      ```

      Result:

      ```text
      ...
      Agent registered with id D9CA44FC-716A-4B3B-A702-C6**********
      ```

      **CentOS**

      ```bash
      sudo yum install epel-release -y && \
      sudo yum update -y && \
      sudo yum install jq -y && \
      curl https://{{ s3-storage-host }}/backup-distributions/agent_installer.sh | sudo bash
      ```

      Result:

      ```text
      ...
      Agent registered with id D9CA44FC-716A-4B3B-A702-C6**********
      ```

{% endlist %}

{% include [agent-installation-failure](../../_includes/backup/agent-installation-failure.md) %}

{% include [vm-list](../../_includes/backup/vm-list.md) %}

#### See also {#see-also}

* [{#T}](connect-vm-windows.md)
* [{#T}](connect-vm-linux.md)
* [Attaching a VM to a backup policy](./policy-vm/update.md#update-vm-list)
* [{#T}](./backup-vm/recover.md)
* [{#T}](./backup-vm/delete.md)
* [{#T}](./policy-vm/create.md)
