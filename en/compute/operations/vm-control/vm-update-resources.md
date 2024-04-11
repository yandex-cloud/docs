# Changing VM computing resources

After you create a VM, you can change its computing resources. For more information about how to change a VM name, description, and tags, see [{#T}](vm-update.md).

## Changing the vCPU and RAM configuration {#update-vcpu-ram}

This section provides guidelines for changing the number and performance of vCPUs and the amount of RAM.

{% list tabs group=instructions %}

- Management console {#console}

  To change vCPU and RAM of a VM:
  1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Click the name of the required VM.
  1. Click **{{ ui-key.yacloud.compute.instance.overview.button_action-stop }}** in the top-right corner of the page.
  1. In the window that opens, click **{{ ui-key.yacloud.compute.instance.stop-dialog.button_stop }}**.
  1. Wait until the VM status changes to `Stopped`, then click ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-edit }}** in the top-right corner of the page.
  1. Change the [configuration](../../concepts/performance-levels.md) of the VM in the **{{ ui-key.yacloud.compute.instances.create.section_platform }}** section:
     * Choose a [platform](../../concepts/vm-platforms.md).
     * Specify the required number of vCPUs.
     * Choose a guaranteed vCPU performance.
     * Specify the RAM size.
  1. Click **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.
  1. Click **{{ ui-key.yacloud.common.start }}** in the top-right corner.
  1. In the window that opens, click **{{ ui-key.yacloud.compute.instances.popup-confirm_button_start }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command for updating VM parameters:

      ```bash
      yc compute instance update --help
      ```

   1. Get a list of VMs in the default folder:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

   1. Select the `ID` or `NAME` of the VM, e.g., `first-instance`.
   1. Stop the VM:

      ```bash
      yc compute instance stop first-instance
      ```

   1. Get the current VM [configuration](../../concepts/performance-levels.md) with [metadata](../../concepts/vm-metadata.md):

      ```bash
      yc compute instance get --full first-instance
      ```

   1. Change the VM configuration:

      ```bash
      yc compute instance update first-instance \
        --memory 32 \
        --cores 4 \
        --core-fraction 100
      ```

      This command will change the configuration of the VM:
      * **Guaranteed vCPU level** to 100%.
      * **Number of vCPUs** to 4.
      * **RAM** to 32 GB.

   1. Run the VM:

      ```bash
      yc compute instance start first-instance
      ```

- API {#api}

   To change vCPU and RAM of a VM, use the [update](../../api-ref/Instance/update.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/Update](../../api-ref/grpc/instance_service.md#Update) gRPC API call.

{% endlist %}

{% note warning %}

When you edit VM resources, the PCI topology might change. Keep this in mind when working with operating systems that are sensitive to such changes. For example, if you make substantial changes in network settings in Windows Server, you may lose network connectivity and access to the VM.

{% endnote %}

## Adding a GPU to an existing VM {#add-gpu}

To add a [GPU](../../concepts/gpus.md) to an existing VM, change the platform and specify the number of GPUs.

{% list tabs group=instructions %}

- Management console {#console}

   To change the number of GPUs on the VM:
   1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. Click the name of the required VM.
   1. Click **{{ ui-key.yacloud.compute.instance.overview.button_action-stop }}** in the top-right corner of the page.
   1. In the window that opens, click **{{ ui-key.yacloud.compute.instance.stop-dialog.button_stop }}**.
   1. Wait until the VM status changes to `Stopped`, then click ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-edit }}** in the top-right corner of the page.
   1. Change the [configuration](../../concepts/performance-levels.md) of the VM in the **{{ ui-key.yacloud.compute.instances.create.section_platform }}** section:
      * Choose a [platform](../../concepts/vm-platforms.md#gpu-platforms).


      * Specify the required number of GPUs.
   1. Click **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.
   1. Click **{{ ui-key.yacloud.common.start }}** in the top-right corner of the page.
   1. In the window that opens, click **{{ ui-key.yacloud.compute.instances.popup-confirm_button_start }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command for updating VM parameters:

      ```bash
      yc compute instance update --help
      ```

   1. Get a list of VMs in the default folder:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

   1. Select the `ID` or `NAME` of the VM, e.g., `first-instance`.
   1. Stop the VM:

      ```bash
      yc compute instance stop first-instance
      ```

   1. Get the current VM [configuration](../../concepts/performance-levels.md) with [metadata](../../concepts/vm-metadata.md):

      ```bash
      yc compute instance get --full first-instance
      ```

   1. Change the VM configuration:

      ```bash
      yc compute instance update first-instance \
        --platform=standard-v3-t4 \
        --cores=8 \
        --memory=32 \
        --gpus=1
      ```

      This command changes the following VM specs:
      * **Platform** to {{ t4-ice-lake }}.


      * **Number of vCPUs** to 8.
      * **RAM** to 32 GB.
      * **GPU** to 1.

   1. Run the VM:

      ```bash
      yc compute instance start first-instance
      ```

- API {#api}

   To change a VM's platform and configuration, use the [update](../../api-ref/Instance/update.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/Update](../../api-ref/grpc/instance_service.md#Update) gRPC API call.

{% endlist %}

## Changing the number of GPUs {#update-gpu}

{% list tabs group=instructions %}

- Management console {#console}

   To change the number of [GPUs](../../concepts/gpus.md) on an existing VM:
   1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. Click the name of the required VM.
   1. Click **{{ ui-key.yacloud.compute.instance.overview.button_action-stop }}** in the top-right corner of the page.
   1. In the window that opens, click **{{ ui-key.yacloud.compute.instance.stop-dialog.button_stop }}**.
   1. Wait until the VM status changes to `Stopped`, then click ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-edit }}** in the top-right corner of the page.
   1. Change the VM [configuration](../../concepts/performance-levels.md) Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, specify the required number of GPUs.
   1. Click **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.
   1. Click **{{ ui-key.yacloud.common.start }}** in the top-right corner of the page.
   1. In the window that opens, click **{{ ui-key.yacloud.compute.instances.popup-confirm_button_start }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command for updating VM parameters:

      ```bash
      yc compute instance update --help
      ```

   1. Get a list of VMs in the default folder:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

   1. Select the `ID` or `NAME` of the VM, e.g., `first-instance`.
   1. Stop the VM:

      ```bash
      yc compute instance stop first-instance
      ```

   1. Get the current VM [configuration](../../concepts/performance-levels.md) with [metadata](../../concepts/vm-metadata.md):

      ```bash
      yc compute instance get --full first-instancegit
      ```

   1. Change the VM configuration:

      ```bash
      yc compute instance update first-instance \
        --gpus=2 \
        --cores=56 \
        --memory=238
      ```

      This command changes the number of GPUs to 2.

      The values of `--cores` (number of vCPUs) and `--memory` (amount of RAM in GB) parameters depend on the platform and the number of GPUs. See [List of available configurations](../../concepts/gpus.md#config).

   1. Run the VM:

      ```bash
      yc compute instance start first-instance
      ```

- API {#api}

   To change the number of GPUs, use the [update](../../api-ref/Instance/update.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/Update](../../api-ref/grpc/instance_service.md#Update) gRPC API call.

{% endlist %}

## Enabling a software-accelerated network {#enable-software-accelerated-network}

{% note warning %}

This feature is only available upon agreement with your account manager.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

   To enable a [software-accelerated network](../../concepts/software-accelerated-network.md) on an existing VM:
   1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. Click the name of the required VM.
   1. Click **{{ ui-key.yacloud.compute.instance.overview.button_action-stop }}** in the top-right corner of the page.
   1. In the window that opens, click **{{ ui-key.yacloud.compute.instance.stop-dialog.button_stop }}**.
   1. Wait until the VM status changes to `Stopped`, then click ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-edit }}** in the top-right corner of the page.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, enable the **{{ ui-key.yacloud.component.compute.resources.label_sw-accelerated-net }}** option.
   1. Click **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.
   1. Click **{{ ui-key.yacloud.common.start }}** in the top-right corner of the page.
   1. In the window that opens, click **{{ ui-key.yacloud.compute.instances.popup-confirm_button_start }}**.

{% endlist %}