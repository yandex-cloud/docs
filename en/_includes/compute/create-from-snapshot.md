{% list tabs %}

- Management console


   1. In the [management console]({{ link-console-main }}), select the folder to create the virtual machine in.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. At the top right, click **{{ ui-key.yacloud.compute.instances.button_create }}**.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**:

      * Enter a name and description for the VM. The naming requirements are as follows:

         {% include [name-format](../name-format.md) %}

         {% include [name-fqdn](../compute/name-fqdn.md) %}

      * Select an [availability zone](../../overview/concepts/geo-scope.md) to put your virtual machine in.

   1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, choose a snapshot:

      * Go to the **{{ ui-key.yacloud.compute.instances.create.image_value_custom }}** tab and click **{{ ui-key.yacloud.compute.instances.create.button_choose }}**.
      * In the window that opens, go to the **{{ ui-key.yacloud.compute.instances.create-disk.value_source-snapshot }}** tab.
      * Select a disk snapshot from the list and click **{{ ui-key.yacloud.common.apply }}**.

   
   1. {% include [encryption-section-boot](encryption-section-boot.md) %}


   1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}**, [add a disk](../../compute/operations/vm-create/create-from-disks.md):

      * Click **{{ ui-key.yacloud.compute.instances.create.label_add-disk }}**.
      * Enter the disk name.
      * Select the [disk type](../../compute/concepts/disk.md#disks_types).
      * Specify the required block size.
      * Specify the required disk size.

      
      * {% include [encryption-section-secondary](encryption-section-secondary.md) %}


      * (Optional) Enable the **{{ ui-key.yacloud.compute.instances.create-disk.field_auto-delete }}** option if you need to automatically delete the disk when deleting the VM it will be attached to.
      * Select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-snapshot }}` as content.
      * Click **{{ ui-key.yacloud.compute.instances.create-disk.button_create }}**.

   
   1. (Optional) Under **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}**, select the **{{ ui-key.yacloud.compute.nfs.label_filesystems }}** tab and attach the [file storage](../../compute/concepts/filesystem.md):

      * Click **{{ ui-key.yacloud.compute.nfs.button_attach-filesystem-to-the-instance }}**.
      * In the window that opens, select the file storage.
      * Enter the device name.
      * Click **{{ ui-key.yacloud.compute.nfs.button_attach-filesystem-to-the-instance }}**.


   1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:

      * Choose a [platform](../../compute/concepts/vm-platforms.md).
      * Specify the [guaranteed share](../../compute/concepts/performance-levels.md) and the required number of vCPUs, as well as the amount of RAM.
      * If required, make your VM [preemptible](../../compute/concepts/preemptible-vm.md).
      * (Optional) Enable a [software-accelerated network](../../compute/concepts/software-accelerated-network.md).

   1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      {% include [network-settings](network-settings.md) %}

   
   1. {% include [backup-info](backup-info.md) %}


   1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the information required to access the instance:

      * (Optional) Select or create a [service account](../../iam/concepts/users/service-accounts.md). With a service account, you can flexibly configure access rights for your resources.
      * Enter the username in the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.

         {% note alert %}

         Do not use the `root` username or other names reserved by the operating system. To perform operations that require superuser permissions, use the `sudo` command.

         {% endnote %}

      * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the [public key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) file.
      * If required, grant access to the [serial console](../../compute/operations/serial-console/index.md).

      {% include [vm-connect-linux](../vm-connect-linux.md) %}

   1. (Optional) Under **{{ ui-key.yacloud.compute.instances.create.section_placement }}**, select a VM [placement group](../../compute/concepts/placement-groups.md).
   1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

   The virtual machine will appear in the list. When a VM is created, it is assigned an [IP address](../../vpc/concepts/address.md) and [hostname](../../vpc/concepts/address.md#fqdn) (FQDN).

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   1. View the description of the CLI command for creating a VM:

      ```
      yc compute instance create --help
      ```

   1. Prepare snapshots of the required disks, see [{#T}](../../compute/operations/disk-control/create-snapshot.md).
   1. Get a list of snapshots in the default folder:

      {% include [compute-snapshot-list](../../compute/_includes_service/compute-snapshot-list.md) %}

   1. Select the identifier (`ID`) or name (`NAME`) of the necessary snapshots.
   1. Create a VM in the default folder:

      ```
      yc compute instance create \
        --name first-instance \
        --zone {{ region-id }}-a \
        --public-ip \
        --create-boot-disk snapshot-name=first-snapshot \
        --create-disk snapshot-name=second-snapshot \
        --ssh-key ~/.ssh/id_ed25519.pub
      ```

      This command creates a VM named `first-instance` in the `{{ region-id }}-a` availability zone, with a public IP and the disks from the snapshots.

      {% include [name-fqdn](name-fqdn.md) %}

      To create a VM without a public IP, remove the `--public-ip` flag.


- API

   Use the [create](../../compute/api-ref/Instance/create.md) REST API method for the [Instance](../../compute/api-ref/Instance/) resource or the [InstanceService/Create](../../compute/api-ref/grpc/instance_service.md#Create) gRPC API call.

{% endlist %}
