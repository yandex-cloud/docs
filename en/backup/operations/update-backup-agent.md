---
title: How do I update the {{ backup-full-name }} agent on a {{ compute-full-name }} VM?
description: Follow this guide to update the {{ backup-full-name }} agent on a {{ compute-full-name }} VM.
---

# Updating the {{ backup-full-name }} agent on a {{ compute-full-name }} VM

In some situations, you may need to update your [{{ backup-name }} agent](../concepts/agent.md) or restore its functionality for reliable automatic backups of {{ compute-name }} [VMs](../../compute/concepts/vm.md).

## Updating the {{ backup-name }} agent {#update-agent}

You may need to update the {{ backup-name }} agent in the event of technical updates on the [backup provider's](../concepts/index.md#providers) side. {{ yandex-cloud }} warns its customers in advance about such cases.

{% note info %}

Updating the {{ backup-name }} agent will not affect the data in your existing backups.

{% endnote %}

To update the {{ backup-name }} agent on a {{ compute-name }} VM:

{% list tabs group=operating_system %}

- Linux {#linux}

  1. [Connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM over SSH.
  1. In the terminal, run this command:

      ```bash
      curl \
        --output backup_agent_linux_installer.bin \
        https://{{ s3-storage-host }}/backup-distributions/backup_agent_linux_installer.bin && \
      sudo bash ./backup_agent_linux_installer.bin -a
      ```

      Result:

      ```text
      ...
      Congratulations!
      Cyber Backup Agent has been successfully installed in the system.
      ```

      Updating the {{ backup-name }} agent may take around 15 minutes.

  1. Disconnect from the VM.


- Windows {#windows}

  1. [Connect](../../compute/operations/vm-connect/rdp.md) to the VM over RDP.
  1. Run [Windows PowerShell](https://learn.microsoft.com/en-us/powershell/).
  1. Run the following commands:

      ```powershell
      Invoke-WebRequest `
        "https://{{ s3-storage-host }}/backup-distributions/backup_agent_windows_installer.exe" `
        -OutFile ".\backup_agent_windows_installer.exe"
      Invoke-Expression .\backup_agent_windows_installer.exe
      ```

  1. In the window that opens, click **Repair**.
  1. Wait for the `The installation was successfully repaired` message and click **CLOSE**.
      
      Updating the {{ backup-name }} agent may take around 15 minutes.
  1. Disconnect from the VM.

{% endlist %}

If you were unable to update your {{ backup-name }} agent for any reason, [contact]({{ link-console-support }}) support.

#### See also {#see-also}

* [{#T}](./backup-baremetal/restore-agent.md)