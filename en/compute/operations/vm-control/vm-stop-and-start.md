---
title: How to stop, start, or restart a VM
description: The Stop command shuts down the VM. After the VM is shut down, its status changes to STOPPED. You can enable the VM at any time to continue working with it. The Start command starts a previously stopped VM. After the VM is started, its status changes to RUNNING and the operating system starts loading.
---

# Stopping, starting, or restarting a VM

## Stop {#stop}

This **{{ ui-key.yacloud.common.stop }}** command shuts down the VM. Once shut down, the VM status changes to `Stopped`. While the VM is stopped, no fee is charged for its use. You are [charged](../../pricing.md#disk) for using disks whether the VM is running or not.

You can restart a VM at any time to continue using it. All the data and changes you have made are saved.

Certain VM parameters can only be modified when the VM is stopped.

To stop a VM:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. To stop a single VM, select the VM, click ![image](../../../_assets/console-icons/ellipsis.svg), and then click **{{ ui-key.yacloud.common.stop }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.compute.instances.popup-confirm_button_stop }}**.

   To perform this action with multiple VMs, select the relevant VMs in the list, click **{{ ui-key.yacloud.compute.instances.button_gr-action-stop }}** at the bottom of the screen, and then, in the window that opens, click **{{ ui-key.yacloud.compute.instances.popup-confirm_button_gr-stop }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to stop a VM:

      ```bash
      yc compute instance stop --help
      ```

   1. Get a list of all VMs in the default folder:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

   1. Select the `ID` or `NAME` of the VM, e.g., `first-instance`.
   1. Stop the VM:

      ```bash
      yc compute instance stop first-instance
      ```

- API {#api}

   Use the [stop](../../api-ref/Instance/stop.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/Stop](../../api-ref/grpc/Instance/stop.md) gRPC API call.

{% endlist %}

When a VM stops, the hypervisor sends a shutdown signal to the VM operating system. The OS needs to terminate the current processes nice and easy within the next 30 seconds to avoid data loss. After this time elapses, the VM process is forced to stop.

## Start {#start}

The **{{ ui-key.yacloud.common.start }}** command starts a previously stopped VM. Once the VM is started, its status changes to `Running`, and the operating system starts loading. From this point on, you will be charged for using the VM.

To start a VM:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. To start a single VM, select the VM, click ![image](../../../_assets/console-icons/ellipsis.svg), and then click **{{ ui-key.yacloud.common.start }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.compute.instances.popup-confirm_button_start }}**.

   To perform this action with multiple VMs, select the relevant VMs in the list, click **{{ ui-key.yacloud.common.start }}** at the bottom of the screen, and then, in the window that opens, click **{{ ui-key.yacloud.compute.instances.popup-confirm_button_start }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command that starts a VM:

      ```bash
      yc compute instance start --help
      ```

   1. Get a list of all VMs in the default folder:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

   1. Select the `ID` or `NAME` of the VM, e.g., `first-instance`.
   1. Run the VM:

      ```bash
      yc compute instance start first-instance
      ```

- API {#api}

   Use the [start](../../api-ref/Instance/start.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/Start](../../api-ref/grpc/Instance/start.md) gRPC API call.

{% endlist %}

## Restart {#restart}

The **{{ ui-key.yacloud.compute.instances.button_action-restart }}** command restarts a VM.

To restart a VM:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. To restart a single VM, select the VM, click ![image](../../../_assets/console-icons/ellipsis.svg), and then click **{{ ui-key.yacloud.compute.instances.button_action-restart }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.compute.instances.popup-confirm_button_restart }}**.

   To perform this action with multiple VMs, select the relevant VMs in the list, click **{{ ui-key.yacloud.compute.instances.button_action-restart }}** at the bottom of the screen, and then, in the window that opens, click **{{ ui-key.yacloud.compute.instances.popup-confirm_button_restart }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command that restarts a VM:

      ```bash
      yc compute instance restart --help
      ```

   1. Get a list of all VMs in the default folder:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

   1. Select the `ID` or `NAME` of the VM, e.g., `first-instance`.
   1. Restart the VM.

      ```bash
      yc compute instance restart first-instance
      ```

- API {#api}

   Use the [restart](../../api-ref/Instance/restart.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/Restart](../../api-ref/grpc/Instance/restart.md) gRPC API call.

{% endlist %}