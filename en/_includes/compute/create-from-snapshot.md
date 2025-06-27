{% list tabs group=instructions %}

- Management console {#console}



  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your VM.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**:

      * Navigate to the **{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}** tab.
      * Click ![image](../../_assets/console-icons/pencil.svg), and, in the window that opens, select **{{ ui-key.yacloud.common.create }}**.
      * In the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field, select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-snapshot }}` and then select the disk snapshot you need from the list below. Use the filter as needed.
      * Enter a name for the new boot disk.
      * Select the [disk type](../../compute/concepts/disk.md#disks_types).
      * Specify the required disk and block size.
      * Optionally, enable **{{ ui-key.yacloud.compute.field_additional_vt356 }}** in the **{{ ui-key.yacloud.compute.field_disk-autodelete_qZn4x }}** field if you need this disk automatically deleted when deleting the VM.
      * Click **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.

  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the [availability zone](../../overview/concepts/geo-scope.md) your VM will reside in.
  1. Add a secondary [disk](../../compute/concepts/disk.md):

      * Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, click **{{ ui-key.yacloud.compute.instances.create-disk.button_create }}**.
      * In the window that opens, select **{{ ui-key.yacloud.compute.instances.create-disk.value_source-disk }}** → `Create new`.
      * In the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field, select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-snapshot }}`.
      * Enter a name for the new disk.
      * Select the [disk type](../../compute/concepts/disk.md#disks_types).
      * Specify the required disk and block size.
      * Optionally, enable **{{ ui-key.yacloud.compute.field_additional_vt356 }}** in the **{{ ui-key.yacloud.compute.field_disk-autodelete_qZn4x }}** field if you need this disk automatically deleted when deleting the VM.
      * Click **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.

  1. {% include [encryption-section-secondary](encryption-section-secondary.md) %}
  1. {% include [section-storages-filesystem](create/section-storages-filesystem.md) %}
  1. {% include [section-platform](create/section-platform.md) %}
  1. {% include [network-settings](create/section-network.md) %}
  1. {% include [section-access](create/section-access.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, enter a name for the VM:

      {% include [name-format](../name-format.md) %}

      {% include [name-fqdn](../compute/name-fqdn.md) %}

  1. {% include [section-additional](../../_includes/compute/create/section-additional.md) %}
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  The VM will appear in the list. Every new VM gets an [IP address](../../vpc/concepts/address.md) and [host name](../../vpc/concepts/address.md#fqdn) (FQDN).

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. See the description of the CLI command for creating a VM:

      ```
      yc compute instance create --help
      ```

  1. Prepare snapshots of the disks you need by following the steps in [{#T}](../../compute/operations/disk-control/create-snapshot.md).
  1. Get a list of snapshots in the default folder:

      {% include [compute-snapshot-list](../../compute/_includes_service/compute-snapshot-list.md) %}

  1. Select `ID` or `NAME` of the snapshots you need.
  1. Create a VM in the default folder:

      ```
      yc compute instance create \
        --name first-instance \
        --zone {{ region-id }}-a \
        --public-ip \
        --create-boot-disk snapshot-name=first-snapshot,kms-key-id=<key_ID> \
        --create-disk snapshot-name=second-snapshot,kms-key-id=<key_ID> \
        --ssh-key ~/.ssh/id_ed25519.pub
      ```

      Where:

      * `--name`: VM name. Follow these naming requirements:

          {% include [name-format](../../_includes/name-format.md) %}

          {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

      * `--zone`: [Availability zone](../../overview/concepts/geo-scope.md).
      * `--public-ip`: Connecting a public IP address. Remove this flag to create a VM without a public IP address.
      * `--create-boot-disk`: VM boot disk settings:

          * `snapshot-name`: Disk snapshot name.
          * `kms-key-id`: ID of the [{{ kms-short-name }} symmetric key](../../kms/concepts/key.md) to create an encrypted boot disk. This is an optional parameter.

            {% include [encryption-role](../../_includes/compute/encryption-role.md) %}

            {% include [encryption-disable-warning](../../_includes/compute/encryption-disable-warning.md) %}

            {% include [encryption-keys-note](../../_includes/compute/encryption-keys-note.md) %}

      * `--create-disk`: Secondary disk settings:

          * `snapshot-name`: Disk snapshot name.
          * `kms-key-id`: ID of the [{{ kms-short-name }} symmetric key](../../kms/concepts/key.md) to create an encrypted disk. This is an optional parameter.

      * `--ssh-key`: Path to the file with the [public SSH key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys). The VM will automatically create a user named `yc-user` for this key.

          {% include [ssh-note](../../_includes/compute/ssh-note.md) %}

      The above command will create a VM named `first-instance` in the `{{ region-id }}-a` availability zone, with a public IP address and disks from the snapshots.

      {% include [add-several-net-interfaces-notice-cli](./add-several-net-interfaces-notice-cli.md) %}

- API {#api}

  Use the [create](../../compute/api-ref/Instance/create.md) REST API method for the [Instance](../../compute/api-ref/Instance/) resource or the [InstanceService/Create](../../compute/api-ref/grpc/Instance/create.md) gRPC API call.

{% endlist %}
