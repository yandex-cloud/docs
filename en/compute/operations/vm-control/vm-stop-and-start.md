---
title: How to stop, start, or restart a VM
description: The `stop` command shuts down a VM. Once a VM is shut down, its status changes to `STOPPED`. You can restart a VM at any time to continue using it. The `start` command starts a previously stopped VM. Once the VM is started, its status changes to `RUNNING`, and the operating system starts loading.
---

# Stopping, starting, or restarting a VM

## Stopping {#stop}

The **{{ ui-key.yacloud.common.stop }}** command shuts down a VM. Once a VM is shut down, its status changes to `Stopped`. While the VM is stopped, you will not be charged for it. Disk usage is [billed](../../pricing.md#disk) separately, regardless of the VM's state.

You can restart a VM at any time to continue using it. All your data and changes will be saved.

Certain VM parameters can only be modified when the VM is stopped.

To stop a VM:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. To stop a single VM, select the VM, click ![image](../../../_assets/console-icons/ellipsis.svg), and select **{{ ui-key.yacloud.common.stop }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.compute.instances.popup-confirm_button_stop }}**.

  To stop multiple VMs, select the VMs from the list, click **{{ ui-key.yacloud.compute.instances.button_gr-action-stop }}** at the bottom of the screen, and then, in the window that opens, click **{{ ui-key.yacloud.compute.instances.popup-confirm_button_gr-stop }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for stopping a VM:

     ```bash
     yc compute instance stop --help
     ```

  1. Get a list of all VMs in the default folder:

     {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Select `ID` or `NAME` of the VM, e.g., `first-instance`.
  1. Stop the VM:

     ```bash
     yc compute instance stop first-instance
     ```

- API {#api}

  Use the [stop](../../api-ref/Instance/stop.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/Stop](../../api-ref/grpc/Instance/stop.md) gRPC API call.

{% endlist %}

When a VM stops, the hypervisor sends a shutdown signal to the VM operating system. The OS has 30 seconds to gracefully terminate all running processes to avoid data loss. After this time elapses, the VM will be forcibly terminated.

## Starting {#start}

The **{{ ui-key.yacloud.common.start }}** command starts a previously stopped VM. Once the VM is started, its status changes to `Running`, and the operating system starts loading. From this point on, you will be charged for using the VM.

To start a VM:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. To start a single VM, select the VM, click ![image](../../../_assets/console-icons/ellipsis.svg), and select **{{ ui-key.yacloud.common.start }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.compute.instances.popup-confirm_button_start }}**.

  To start multiple VMs, select the VMs from the list, click **{{ ui-key.yacloud.common.start }}** at the bottom of the screen, and then, in the window that opens, click **{{ ui-key.yacloud.compute.instances.popup-confirm_button_start }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for starting a VM:

     ```bash
     yc compute instance start --help
     ```

  1. Get a list of all VMs in the default folder:

     {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Select `ID` or `NAME` of the VM, e.g., `first-instance`.
  1. Run the VM:

     ```bash
     yc compute instance start first-instance
     ```

- API {#api}

  Use the [start](../../api-ref/Instance/start.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/Start](../../api-ref/grpc/Instance/start.md) gRPC API call.

{% endlist %}

## Restarting {#restart}

The **{{ ui-key.yacloud.compute.instances.button_action-restart }}** command restarts a VM.

To restart a VM:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. To restart a single VM, select the VM, click ![image](../../../_assets/console-icons/ellipsis.svg), and select **{{ ui-key.yacloud.compute.instances.button_action-restart }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.compute.instances.popup-confirm_button_restart }}**.

  To restart multiple VMs, select the VMs from the list, click **{{ ui-key.yacloud.compute.instances.button_action-restart }}** at the bottom of the screen, and then, in the window that opens, click **{{ ui-key.yacloud.compute.instances.popup-confirm_button_restart }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for restarting a VM:

     ```bash
     yc compute instance restart --help
     ```

  1. Get a list of all VMs in the default folder:

     {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Select `ID` or `NAME` of the VM, e.g., `first-instance`.
  1. Restart the VM:

     ```bash
     yc compute instance restart first-instance
     ```

- API {#api}

  Use the [restart](../../api-ref/Instance/restart.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/Restart](../../api-ref/grpc/Instance/restart.md) gRPC API call.

{% endlist %}