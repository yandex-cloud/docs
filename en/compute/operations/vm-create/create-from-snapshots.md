# Create a VM with disks restored from snapshots

You can create a VM with disks restored from the snapshots that exist in the folder. Learn about creating a disk snapshot in [{#T}](../disk-control/create-snapshot.md).

{% list tabs %}

- Management console

  To create a VM:

  1. In the [management console]({{ link-console-main }}), select the folder to create your VM in.
  1. In the list of services, select **{{ compute-name }}**.
  1. Click **Create VM**.
  1. Under **Basic parameters**:

      * Enter a name and description for the VM. Naming requirements:

          {% include [name-format](../../../_includes/name-format.md) %}

          {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      * Select the [availability zone](../../../overview/concepts/geo-scope.md) to host the VM in.

  1. Under **Image/boot disk selection**, select one of the [images](../../operations/images-with-pre-installed-software/get-list.md).
  1. Under **Disks**, click **Add disk**:
      * Enter the disk name.
      * Select the [disk type](../../concepts/disk.md#disks_types).
      * Specify the desired block size.
      * Specify the necessary disk size.
      * (optional) Enable the **Delete with the VM** option if you need to automatically delete the disk when deleting the VM it will be attached to.
      * Under **Content**, select **Snapshot**.
      * Select the snapshot from the list.
      * Click **Add**.

  1. (optional) Under **File storages**, attach the [file storage](../../concepts/filesystem.md) and enter the device name.

  1. Under **Computing resources**:
      * Choose a [platform](../../concepts/vm-platforms.md).
      * Specify the [guaranteed share](../../../compute/concepts/performance-levels.md) and number of vCPUs and RAM you need.
      * If necessary, make your VM [preemptible](../../concepts/preemptible-vm.md).
      * (optional) Enable a [software-accelerated network](../../concepts/software-accelerated-network.md).

  1. Under **Network settings**:
      * Specify the subnet ID or select a [cloud network](../../../vpc/concepts/network.md#network) from the list.
          If you don't have a network, click **Create network** to create one:
          * In the window that opens, enter the network name and folder to host the network.
          * (optional) To automatically create subnets, select the **Create subnets** option.
          * Click **Create**.
          Each network must have at least one [subnet](../../../vpc/concepts/network.md#subnet). If there is no subnet, create one by selecting **Add subnet**.
      * In the **Public IP** field, choose a method for assigning an IP address:
          * **Auto**: Assign a random IP address from the {{ yandex-cloud }} IP pool. In this case, you can enable [protection from DDoS attacks](../../../vpc/ddos-protection/index.md) using the option below.
          * **List**: Select a public IP address from the list of previously reserved static addresses. For more information, see [{#T}](../../../vpc/operations/set-static-ip.md).
          * **No address**: Don't assign a public IP address.
      * In the **Internal address** field, select the method for assigning internal addresses: **Auto** or **Manual**.
      * (optional) Create a record for the VM in the [DNS zone](../../../dns/concepts/dns-zone.md). Expand the **DNS settings for internal addresses** section, click **Add record** and specify the zone, FQDN and TTL for the record. For more information, see [Yandex Cloud DNS integration with Yandex Compute Cloud](../../../dns/concepts/compute-integration.md).
      * Select the [appropriate security groups](../../../vpc/concepts/security-groups.md) (if there is no corresponding field, all incoming and outgoing traffic will be allowed for the VM).

  1. Under **Access**, specify the data required to access the VM:

      * (optional) Select or create a [service account](../../../iam/concepts/users/service-accounts.md). By using a service account, you can flexibly configure access rights for your resources.
      * Enter the username in the **Login** field.

          {% note alert %}

          Don't use the username `root` or other names reserved by the operating system. To perform operations that require superuser permissions, use the command `sudo`.

          {% endnote %}

      * In the **SSH key** field, paste the contents of the [public key file](../../operations/vm-connect/ssh.md#creating-ssh-keys).
      * If required, grant access to the [serial console](../../operations/serial-console/index.md).

  1. Click **Create VM**.

  The virtual machine appears in the list. When a VM is being created, it is assigned an [IP address](../../../vpc/concepts/address.md) and [hostname](../../../vpc/concepts/address.md#fqdn) (FQDN).

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for creating a VM:

      ```
      $ yc compute instance create --help
      ```

  1. Prepare the snapshots of the disks, see [{#T}](../disk-control/create-snapshot.md).

  1. Get a list of snapshots in the default folder:

      {% include [compute-snapshot-list](../../_includes_service/compute-snapshot-list.md) %}

  1. Select the identifier (`ID`) or name (`NAME`) of the necessary snapshots.

  1. Create a VM in the default folder:

      ```
      $ yc compute instance create \
          --name first-instance \
          --zone ru-central1-a \
          --public-ip \
          --create-boot-disk snapshot-name=first-snapshot \
          --create-disk snapshot-name=second-snapshot \
          --ssh-key ~/.ssh/id_rsa.pub
      ```

      This command creates a VM named `first-instance` in the `ru-central1-a` availability zone, with a public IP and the disks from the snapshots. To create a VM without a public IP, remove the `--public-ip` flag.

      {% include [name-format](../../../_includes/name-format.md) %}

      {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

- API

  Use the [Create](../../api-ref/Instance/create.md) method for the `Instance` resource.

{% endlist %}
