{% list tabs group=instructions %}

- Management console {#console}


  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your VM.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**:

      * Go to the **{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}** tab.
      * Click ![image](../../_assets/console-icons/pencil.svg), and, in the window that opens, select **{{ ui-key.yacloud.common.create-new }}**.
      * In the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field, select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-snapshot }}` and then select the disk snapshot you need from the list below. Use the filter as needed.
      * Enter a name for the new boot disk.
      * Select the [disk type](../../compute/concepts/disk.md#disks_types).
      * Specify the required disk and block size.
      * Optionally, enable **{{ ui-key.yacloud.compute.field_additional }}** in the **{{ ui-key.yacloud.compute.field_disk-autodelete }}** field if you need this disk automatically deleted when deleting the VM.
      * Click **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.

  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../overview/concepts/geo-scope.md) for your VM.
  1. Add a secondary [disk](../../compute/concepts/disk.md):

      * Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, click **{{ ui-key.yacloud.compute.instances.create-disk.button_create }}**.
      * In the window that opens, select **{{ ui-key.yacloud.compute.instances.create-disk.value_source-disk }}** → `Create new`.
      * In the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field, select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-snapshot }}`.
      * Enter a name for the new disk.
      * Select the [disk type](../../compute/concepts/disk.md#disks_types).
      * Specify the required disk and block size.
      * Optionally, enable **{{ ui-key.yacloud.compute.field_additional }}** in the **{{ ui-key.yacloud.compute.field_disk-autodelete }}** field if you need this disk automatically deleted when deleting the VM.
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
        --create-boot-disk snapshot-name=first-snapshot \
        --create-disk snapshot-name=second-snapshot \
        --ssh-key ~/.ssh/id_ed25519.pub
      ```

      This command will create a VM named `first-instance` in the `{{ region-id }}-a` availability zone, with a public IP address and disks from the snapshots.

      {% include [name-fqdn](name-fqdn.md) %}
     
      To create a VM without a public IP address, remove the `--public-ip` flag.

      {% include [add-several-net-interfaces-notice-cli](./add-several-net-interfaces-notice-cli.md) %}

 
- API {#api}

  Use the [create](../../compute/api-ref/Instance/create.md) REST API method for the [Instance](../../compute/api-ref/Instance/) resource or the [InstanceService/Create](../../compute/api-ref/grpc/Instance/create.md) gRPC API call.

{% endlist %}
