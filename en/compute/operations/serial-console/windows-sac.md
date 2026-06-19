---
title: Connecting to the serial console of a Windows VM instance
description: Follow this guide to learn how to connect to the serial console of a Windows-based {{ compute-full-name }} VM instance using Windows SAC.
---

# Connecting to the serial console of a Windows VM instance

{% include [sc-warning](../../../_includes/compute/serial-console-warning.md) %}

To connect to the [serial console](../../concepts/serial-console.md) of a VM instance, first [enable access](./index.md#enable) to the serial console.

## Connect to Windows SAC {#sac-connect}

You can connect to the serial console of a Windows VM instance using the [management console]({{ link-console-main }}) or [{{ yandex-cloud }} CLI](../../../cli/index.yaml) by running a command shell in Windows SAC:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the VM instance resides in.
  1. Navigate to **{{ compute-name }}**.
  1. In the left-hand panel, select ![server](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}** and select the VM instance from the list that opens.
  1. In the left-hand menu, select **{{ ui-key.yacloud.compute.instance.switch_console }}**.
  1. In the drop-down list at the top of the screen, select the [serial port](../../concepts/serial-console.md#serial-ports) used by the serial console for VM connections.

      {% include [serial-console-default-port-win](../../../_includes/compute/serial-console-default-port-win.md) %}

- CLI {#cli}

  1. Make sure you have the [{{ yandex-cloud }} CLI](../../../cli/index.yaml) installed and configured on your machine.

      {% include [cli-install](../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for connecting to a serial console:

      ```bash
      yc compute connect-to-serial-port --help
      ```
  1. Enable metadata authorization when connecting to the serial console by specifying the virtual machine name or ID in this command:
  
      ```bash
      yc compute instance update <VM_name_or_ID> \
        --serial-port-settings ssh-authorization=INSTANCE_METADATA
      ```
      
      To learn how to find out the VM name or ID, see [this section](../vm-info/get-info.md).
      
      Result:
      
      ```yaml
      done (6s)
      id: fhm0b28lgfp4********
      folder_id: b1g9d2k0itu4********
      created_at: "2024-03-28T19:53:23Z"
      name: first-instance
      zone_id: {{ region-id }}-a
      platform_id: standard-v3
      resources:
        memory: "1073741824"
        cores: "2"
        core_fraction: "20"
      status: RUNNING
      metadata_options:
        gce_http_endpoint: ENABLED
        aws_v1_http_endpoint: ENABLED
        gce_http_token: ENABLED
        aws_v1_http_token: DISABLED
      boot_disk:
        mode: READ_WRITE
        device_name: epdu3ce920e7********
        auto_delete: true
        disk_id: epdu3ce920e7********
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:5c:**:**:**
          subnet_id: e2luhnr3rhf8********
          primary_v4_address:
            address: 192.168.1.21
            one_to_one_nat:
              address: 51.250.***.***
              ip_version: IPV4
          security_group_ids:
            - enpjauvetqfb********
      serial_port_settings:
        ssh_authorization: INSTANCE_METADATA
      gpu_settings: {}
      fqdn: sample-vm.{{ region-id }}.internal
      scheduling_policy:
        preemptible: true
      network_settings:
        type: STANDARD
      placement_policy: {}
      hardware_generation:
        legacy_features:
          pci_topology: PCI_TOPOLOGY_V1
      ```
      
      {% note info %}
      
      {% include [serial-port-settings-default](../../../_includes/compute/serial-port-settings-default.md) %}
      
      {% endnote %}

  1. Connect to the virtual machine's Windows SAC:

      ```bash
      yc compute connect-to-serial-port \
        --instance-name <VM_name> \
        --port 2
      ```

      Where:
      * `--instance-name`: VM name. Instead of the VM name, you can provide its ID in the `--instance-id` parameter.
      * `--port`: Number of the [serial port](../../concepts/serial-console.md#serial-ports) used by the serial console for VM connections.

          {% include [serial-console-default-port-win](../../../_includes/compute/serial-console-default-port-win.md) %}

      For more information about the `yc compute connect-to-serial-port` command, see the [CLI reference](../../../cli/cli-ref/compute/cli-ref/connect-to-serial-port.md).

{% endlist %}

This will open the Windows SAC shell.

## Start the command line shell {#load-commandline}

To access the virtual machine's data and settings, start the command line shell:

1. The serial console window that opens will display the command entry prompt:

    ```bash
    SAC>
    ```
1. Show the list of open channels:

    ```bash
    ch
    ```

    Result:

    ```text
    Channel List

    (Use "ch -?" for information on using channels)

    # Status  Channel Name
    0 (AV)    SAC
    ```
1. Create a new channel with the `CMD` command shell instance:

    ```bash
    cmd
    ```

    Result:

    ```text
    The Command Prompt session was successfully launched.
    SAC>
    EVENT:   A new channel has been created.  Use "ch -?" for channel help.
    Channel: Cmd0001
    ```
1. To switch to the new channel, press **ESC**+**TAB** or run the following command:

    ```bash
    ch -sn Cmd0001
    ```

    Result:

    ```text
    Name:                  Cmd0001
    Description:           Command
    Type:                  VT-UTF8
    Channel GUID:          e203fb79-d80d-11ea-87e3-c2679e14957d
    Application Type GUID: 63d02271-8aa4-11d5-bccf-00b0d014a2d0

    Press <esc><tab> for next channel.
    Press <esc><tab>0 to return to the SAC channel.
    Use any other key to view this channel.
    ```
1. Press **Enter** and then enter the following one by one:
    - Username.
    - Domain if using a domain account to log in. Otherwise, enter the host name or leave empty.
    - Password.

    ```bash
    Please enter login credentials.
    Username: Administrator
    Domain  :
    Password: ***************
    ```

    This will launch an instance of the `CMD` command line shell:

    ```bash
    C:\Windows\system32>
    ```
1. To run a PowerShell instance, run this command:

    ```bash
    powershell
    ```

    Result:

    ```text
    Windows PowerShell
    Copyright (C) Microsoft Corporation. All rights reserved.

    PS C:\Windows\system32>
    ```

    {% note tip %}

    Configure Windows language settings to enable English input in PowerShell sessions accessed via the serial console.

    Navigate as follows: **Control Panel** → **Region** → **Administrative** → **Welcome screen and new user accounts settings**. Under **Welcome Screen**, specify:
    * `Display Language`: `English (United States)`.
    * `Input Language`: `English (United States) — US`.

    {% endnote %}

1. To return to the SAC interface, press **ESC** + **TAB** + **0**.

{% note warning %}

{% include [disable-serial-console-tip](../../../_includes/compute/disable-serial-console-tip.md) %}

{% endnote %}

#### See also {#see-also}

* [{#T}](../../concepts/serial-console.md)
* [{#T}](./index.md)
* [{#T}](./connect-ssh.md)
