---
title: How to reset a user password on a Windows Server VM
description: Follow this guide to reset a user password on a Windows Server VM.
---

# Resetting a user password on a Windows Server VM

To reset a user password on a Windows Server VM, you need the following {{ yandex-cloud }} tools:

* [Password reset agent](../../concepts/guest-agent.md). The agent is part of default Windows Server images. If you are using a custom image, you will need to install the agent manually by following [this guide](../vm-guest-agent/install.md).

{% include [vm-reset-password-windows-reqs](../../../_includes/compute/vm-reset-password-windows-reqs.md) %}

To reset a password:

{% list tabs group=programming_language %}

- Management console {#console}

  {% include [vm-reset-password-windows-console](../../../_includes/compute/vm-reset-password-windows-console.md) %}

- PowerShell {#powershell}

  1. Run PowerShell as an administrator.
  1. Install the password reset module (once):

     1. [Install the CLI and configure it](../../../cli/quickstart.md) so that you can run commands as a user or [service account](../../../iam/concepts/users/service-accounts.md) with the required role (see above).
     1. Run this command:

        ```powershell
        Install-Module -Name YCPasswordReset
        ```

        Answer `Y` (for "Yes") to installer questions, such as those regarding NuGet and repositories.

  1. Run this command:

     ```powershell
     Reset-YCUserPassword -InstanceName <VM_name> -Username <VM_username>
     ```

     {% note info %}

     If a command takes too long to run, stop it with **Ctrl** + **C**. After you do this, verify that the password reset agent has been installed and check its logs. For more information, see [{#T}](../vm-guest-agent/check.md).

     {% endnote %}

     If there is no user with the name specified in the `-Username` parameter on your VM, it will automatically be created with admin permissions.

  1. Save the generated password as it will not be shown again after you close the window.

{% endlist %}
