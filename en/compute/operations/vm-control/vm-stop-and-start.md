---
title: "How to stop, start, or restart a VM"
description: "The Stop command shuts down the VM. After the VM is shut down, its status changes to STOPPED. You can enable the VM at any time to continue working with it. The Start command starts a previously stopped VM. After the VM is started, its status changes to RUNNING, and the operating system starts loading."
---

# Stopping, starting, or restarting a VM

## Stop {#stop}

This **Stop** command shuts down the VM. Once shut down, the VM status changes to `STOPPED`. While the VM is stopped, no fee is charged for it.

You can restart a VM at any time to continue using it. All data and changes you've made are saved.

Some VM parameters (such as its boot disk) can only be modified when the VM is stopped.

To stop a VM:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
   1. Select **{{ compute-name }}**.
   1. To stop a single VM, select the VM → click ![image](../../../_assets/options.svg) → select **Stop**.

   To perform this action with multiple VMs, select relevant VMs in the list → click **Stop** at the bottom of the screen → in the window that opens, click **Stop**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to stop a VM:

      ```bash
      yc compute instance stop --help
      ```

   1. Get a list of all VMs in the default folder:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

   1. Select the VM `ID` or `NAME` (for example, `first-instance`).
   1. Stop the VM:

      ```bash
      yc compute instance stop first-instance
      ```

- API

   Use the [stop](../../api-ref/Instance/stop.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/Stop](../../api-ref/grpc/instance_service.md#Stop) gRPC API call.

{% endlist %}

## Start {#start}

The **Start** command starts a previously stopped VM. Once the VM is started, its status changes to `RUNNING`, and the operating system starts loading. From this point on, you will be charged for using the VM.

To start a VM:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
   1. Select **{{ compute-name }}**.
   1. To start a single VM, select the VM → click ![image](../../../_assets/options.svg) → select **Start**.

   To perform this action with multiple VMs, select relevant VMs in the list → click **Start** at the bottom of the screen → in the window that opens, click **Start**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command that starts a VM:

      ```bash
      yc compute instance start --help
      ```

   1. Get a list of all VMs in the default folder:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

   1. Select the VM `ID` or `NAME` (for example, `first-instance`).
   1. Run the VM:

      ```bash
      yc compute instance start first-instance
      ```

- API

   Use the [start](../../api-ref/Instance/start.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/Start](../../api-ref/grpc/instance_service.md#Start) gRPC API call.

{% endlist %}

## Restart {#restart}

The **Restart** command restarts a VM.

To restart a VM:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
   1. Select **{{ compute-name }}**.
   1. To restart a single VM, select the VM → click ![image](../../../_assets/options.svg) → select **Restart**.

   To perform this action with multiple VMs, select relevant VMs in the list → click **Restart** at the bottom of the screen → in the window that opens, click **Restart**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command that restarts a VM:

      ```bash
      yc compute instance restart --help
      ```

   1. Get a list of all VMs in the default folder:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

   1. Select the VM `ID` or `NAME` (for example, `first-instance`).
   1. Restart the VM:

      ```bash
      yc compute instance restart first-instance
      ```

- API

   Use the [restart](../../api-ref/Instance/restart.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/Restart](../../api-ref/grpc/instance_service.md#Restart) gRPC API call.

{% endlist %}