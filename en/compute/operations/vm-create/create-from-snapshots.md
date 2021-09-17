# Creating a VM with disks restored from snapshots

You can create a VM with disks restored from the snapshots that exist in the folder. Learn about creating a disk snapshot in [{#T}](../disk-control/create-snapshot.md).

{% list tabs %}

- Management console

  To create a VM:
  1. In the [management console]({{ link-console-main }}), select a folder to create a VM in.
  1. From the list of services, select {{ compute-name }}.
  1. Click **Create VM**.
  1. Under **Basic parameters**:
      - Enter a name and description for the VM. Naming requirements:

          {% include [name-format](../../../_includes/name-format.md) %}

          {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      - (optional) Select or create a [service account](../../../iam/concepts/index.md#sa). By using a service account, you can flexibly configure access rights for your resources.

      - Select the [availability zone](../../../overview/concepts/geo-scope.md) to host the VM in.
  1. If you don't have a boot disk or snapshot, select a public image.
  1. To add a disk from a snapshot, click **Add disk**.
  1. Set the **Contents** toggle to **Snapshot** and select a snapshot from the list. Then click **Add**.
  1. Under **Computing resources**:
      - Choose a [platform](../../concepts/vm-platforms.md).
      - Specify the [guaranteed share](../../concepts/performance-levels.md), the necessary number of vCPUs, and the amount of RAM.
      - If necessary, make your VM [preemptible](../../concepts/preemptible-vm.md).
  1. Under **Network settings**:
      - Specify the subnet ID or select a [cloud network](../../../vpc/concepts/network.md#network) from the list.
      - In the **Public IP** field, choose a method for assigning an IP address:
          - **Auto**: Assign a random IP address from the {{ yandex-cloud }} IP pool.
          - **List**: Select a public IP address from the list of previously reserved static addresses. For more information, see [{#T}](../../../vpc/operations/set-static-ip.md).
          - **No address**: Don't assign a public IP address.
      - (optional) If necessary, enable [DDoS protection](../../../vpc/ddos-protection/).
      - Select the [appropriate security groups](../../../vpc/concepts/security-groups.md) (if there is no corresponding field, all incoming and outgoing traffic will be allowed for the VM).
  1. Under **Access**, specify the data required to access the VM:
      - Enter the username in the **Login** field.
      - In the **SSH key** field, paste the contents of the [public key file](../../quickstart/quick-create-linux.md#create-ssh).
      - (optional) If necessary, enable access to the [serial console](../index.md#serial-console).
  1. Click **Create VM**.

  The virtual machine appears in the list. When a VM is being created, it is assigned an [IP address](../../../vpc/concepts/address) and [hostname](../../../vpc/concepts/address#imya-hosta-(fqdn)) (FQDN).

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

