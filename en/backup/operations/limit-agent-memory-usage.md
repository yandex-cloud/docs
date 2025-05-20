---
title: How to limit RAM usage by the backup agent
description: Follow this guide to configure the backup agent to limit the use of RAM of the backed up resource, i.e., virtual machine or {{ baremetal-name }} server.
---

# Limiting RAM usage by the {{ backup-name }} agent

{% include [agent-ram-usage-paragraph](../../_includes/backup/operations/agent-ram-usage-paragraph.md) %}

To prevent such issues, you can limit the amount of data the agent caches in RAM.

{% include [agent-ram-usage-notice](../../_includes/backup/operations/agent-ram-usage-notice.md) %}

To limit the use of RAM by the agent:

{% list tabs group=operating_system %}

- Linux {#linux}

  1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM or {{ baremetal-name }} server over SSH.
  1. Stop the backup agent system process by running the following command in the terminal:

      ```bash
      sudo service acronis_mms stop
      ```
  1. Open the agent configuration file:

      ```bash
      sudo nano /usr/lib/Acronis/system_libs/config
      ```

      If the configuration file does not exist, it will be created.
  1. Add the following line to the opened configuration file:

      ```text
      export A3_CACHE_SIZE=<RAM_limit>
      ```

      Where the `A3_CACHE_SIZE` variable sets the RAM limit for the agent. For example, for a 2 GB limit, specify `A3_CACHE_SIZE=2G` or `A3_CACHE_SIZE=2048M`.
  1. Save the changes and close the configuration file.
  1. Restart the backup agent system process:

      ```bash
      sudo systemctl restart acronis_mms
      ```

- Windows {#windows}

  1. Connect to the VM [via RDP](../../compute/operations/vm-connect/rdp.md) or to the {{ baremetal-name }} server [using the KVM console](../../baremetal/operations/servers/server-kvm.md).
  1. Run `PowerShell` as an administrator.
  1. In the `PowerShell` terminal, run this command:

      ```powershell
      setx /M A3_CACHE_SIZE <RAM_limit>
      ```

      Where the `A3_CACHE_SIZE` variable sets the RAM limit for the agent. For example, for a 2 GB limit, specify `A3_CACHE_SIZE 2G` or `A3_CACHE_SIZE 2048M`.

      Result:

      ```text
      SUCCESS: Specified value was saved.
      ```
  1. Restart `Acronis Managed Machine Service`:

      1. Stop `Acronis Managed Machine Service`:

          ```powershell
          net stop MMS
          ```

          Result:

          ```text
          The Acronis Managed Machine Service service is stopping..
          The Acronis Managed Machine Service service was stopped successfully.
          ```
      1. Restart `Acronis Managed Machine Service`:

          ```powershell
          net start MMS
          ```

          Result:

          ```text
          The Acronis Managed Machine Service service is starting.
          The Acronis Managed Machine Service service was started successfully.
          ```

{% endlist %}


#### See also {#see-also}

* [{#T}](../concepts/agent.md)
* [{#T}](./create-vm.md)
* [{#T}](./create-vm-windows.md)
* [{#T}](./backup-baremetal/lease-server-with-backup.md)