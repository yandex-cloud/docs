# Changing VM computing resources

After you create a VM, you can change its computing resources. For more information about how to change a VM name, description, and tags, see [{#T}](vm-update.md).

## Changing the vCPU and RAM configuration {#update-vcpu-ram}

This section provides guidelines for changing the number and performance of vCPUs and the amount of RAM.

{% list tabs %}

- Management console

   To change vCPU and RAM of a VM:
   1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
   1. Select **{{ compute-name }}**.
   1. Click the name of the desired VM.
   1. Click **Stop** in the upper-right corner of the page.
   1. In the window that opens, click **Stop**.
   1. Wait until the VM status changes to `STOPPED`, then click **Update VM** in the upper-right corner of the page.
   1. Change the [configuration](../../concepts/performance-levels.md) of the VM and do the following in the **Computing resources** section:
      * Choose a [platform](../../concepts/vm-platforms.md).
      * Specify the necessary number of vCPUs.
      * Choose a guaranteed vCPU performance.
      * Specify the RAM size.
   1. Click **Save changes**.
   1. Click **Run** in the upper-right corner of the page.
   1. In the window that opens, click **Start**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command for updating VM parameters:

      ```bash
      yc compute instance update --help
      ```

   1. Get a list of VMs in the default folder:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

   1. Select the VM `ID` or `NAME` (for example, `first-instance`).
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

- API

   To change the vCPU and RAM of a VM, use the [Update](../../api-ref/Instance/update.md) method for the `Instance` resource.

{% endlist %}

{% note warning %}

When you edit VM resources, the PCI topology might change. Keep this in mind when working with operating systems that are sensitive to such changes. For example, if you make substantial changes in network settings in Windows Server, you may lose network connectivity and access to the VM.

{% endnote %}

## Adding a GPU to an existing VM {#add-gpu}


To add a [GPU](../../concepts/gpus.md) to an existing VM, change the platform and specify the number of GPUs.

{% list tabs %}

- Management console

   To change the number of GPUs on the VM:
   1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
   1. Select **{{ compute-name }}**.
   1. Click the name of the desired VM.
   1. Click **Stop** in the upper-right corner of the page.
   1. In the window that opens, click **Stop**.
   1. Wait until the VM status changes to `STOPPED`, then click **Update VM** in the upper-right corner of the page.
   1. Change the [configuration](../../concepts/performance-levels.md) of the VM and do the following in the **Computing resources** section:
      * Choose the [platform](../../concepts/vm-platforms.md) Intel Broadwell with NVIDIA® Tesla® V100.
      * Specify the required number of GPUs.
   1. Click **Save changes**.
   1. Click **Run** in the upper-right corner of the page.
   1. In the window that opens, click **Start**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command for updating VM parameters:

      ```bash
      yc compute instance update --help
      ```

   1. Get a list of VMs in the default folder:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

   1. Select the VM `ID` or `NAME` (for example, `first-instance`).
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
        --platform=gpu-standard-v3 \
        --cores=8 \
        --memory=96 \
        --gpus=1
      ```

      This command changes the following VM characteristics:
      * **Platform** to Intel Broadwell with NVIDIA® Tesla® V100.
      * **Number of vCPUs** to 8.
      * **RAM** to 96 GB.
      * **GPU** to 1.

   1. Run the VM:

      ```bash
      yc compute instance start first-instance
      ```

- API

   To change the VM platform and configuration, use the [Update](../../api-ref/Instance/update.md) method for the `Instance` resource.

{% endlist %}

## Changing the number of GPUs {#update-gpu}

{% list tabs %}

- Management console

   To change the number of [GPUs](../../concepts/gpus.md) on an existing VM:
   1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
   1. Select **{{ compute-name }}**.
   1. Click the name of the desired VM.
   1. Click **Stop** in the upper-right corner of the page.
   1. In the window that opens, click **Stop**.
   1. Wait until the VM status changes to `STOPPED`, then click **Update VM** in the upper-right corner of the page.
   1. Change the VM [configuration](../../concepts/performance-levels.md). Under **Computing resources**, specify the required number of GPUs.
   1. Click **Save changes**.
   1. Click **Run** in the upper-right corner of the page.
   1. In the window that opens, click **Start**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command for updating VM parameters:

      ```bash
      yc compute instance update --help
      ```

   1. Get a list of VMs in the default folder:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

   1. Select the VM `ID` or `NAME` (for example, `first-instance`).
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
        --cores=16 \
        --memory=192
      ```

      This command changes the number of GPUs to 2.
   1. Run the VM:

      ```bash
      yc compute instance start first-instance
      ```

- API

   To change the number of GPUs, use the [Update](../../api-ref/Instance/update.md) method for the `Instance`.

{% endlist %}

## Enabling a software-accelerated network {#enable-software-accelerated-network}

{% note warning %}

This functionality is only available when agreed by your account manager.

{% endnote %}

{% list tabs %}

- Management console

   To enable a [software-accelerated network](../../concepts/software-accelerated-network.md) on an existing VM:
   1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
   1. Select **{{ compute-name }}**.
   1. Click the name of the desired VM.
   1. Click **Stop** in the upper-right corner of the page.
   1. In the window that opens, click **Stop**.
   1. Wait until the VM status changes to `STOPPED`, then click **Update VM** in the upper-right corner of the page.
   1. Under **Computing resources**, select **Software-accelerated network**.
   1. Click **Save changes**.
   1. Click **Run** in the upper-right corner of the page.
   1. In the window that opens, click **Start**.

{% endlist %}