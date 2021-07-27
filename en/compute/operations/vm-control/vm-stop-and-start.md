---
title: "How to Stop, Start or Restart a Virtual Machine"
description: "The Stop command turns off the virtual machine. After shutdown, the virtual machine goes into the STOPPED status. You can turn on the machine at any time to continue working. The Start command turns on the stopped virtual machine. After turning on, the virtual machine enters the RUNNING state, and the operating room starts loading system."

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# Stopping, starting, or restarting a VM

## Stop {#stop}

The **Stop** command shuts down the VM. After the VM is shut down, its status changes to `STOPPED`. While the VM is stopped, no fee is charged for it.

You can enable the VM at any time to continue working with it. All data and changes you've made are saved.

Some VM parameters (such as its boot disk) can only be modified when the VM is stopped.

To stop a VM:

{% list tabs %}

- Management console
  
  1. In the management console, select the folder the VM belongs to.
  
  1. Select **{{ compute-name }}**.
  
  1. To stop a single VM, select the machine → click ![image](../../../_assets/dots.svg) → select **Stop**.
  
      To do this with multiple VMs, select the VMs you need to stop from the list → click **Stop** at the bottom of the screen.
  
- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. View a description of the CLI's stop VM command:
  
      ```
      $ yc compute instance stop --help
      ```
  
  1. Get a list of all VMs in the default folder:
  
      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}
  
  1. Select the `ID` or `NAME` of the VM you need (for example, `first-instance`).
  
  1. Stop the VM:
  
      ```
      $ yc compute instance stop first-instance
      ```
  
{% endlist %}

## Start {#start}

The **Start** command starts a previously stopped VM. After the VM is started, its status changes to `RUNNING`, and the operating system starts loading. From this point on, you will be charged for using the VM.

To start a VM:

{% list tabs %}

- Management console
  
  1. In the management console, select the folder the VM belongs to.
  
  1. Select **{{ compute-name }}**.
  
  1. To start a single VM, select the machine → click ![image](../../../_assets/dots.svg) → select **Start**.
  
      To do this with multiple VMs, select the VMs you need to start from the list → click **Start** at the bottom of the screen.
  
- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. View a description of the CLI's start VM command:
  
      ```
      $ yc compute instance start --help
      ```
  
  1. Get a list of all VMs in the default folder:
  
      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}
  
  1. Select the `ID` or `NAME` of the VM you need (for example, `first-instance`).
  
  1. Start the VM:
  
      ```
      $ yc compute instance start first-instance
      ```
  
{% endlist %}

## Restart {#restart}

The **Restart** command restarts a VM.

To restart a VM:

{% list tabs %}

- Management console
  
  1. In the management console, select the folder the VM belongs to.
  
  1. Select **{{ compute-name }}**.
  
  1. To restart a single VM, select the machine → click ![image](../../../_assets/dots.svg) → select **Restart**.
  
      To do this with multiple VMs, select the VMs you need to restart from the list → click **Restart** at the bottom of the screen.
  
- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. View a description of the CLI's restart VM command:
  
      ```
      $ yc compute instance restart --help
      ```
  
  1. Get a list of all VMs in the default folder:
  
      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}
  
  1. Select the `ID` or `NAME` of the VM you need (for example, `first-instance`).
  
  1. Restart the VM:
  
      ```
      $ yc compute instance restart first-instance
      ```
  
{% endlist %}

