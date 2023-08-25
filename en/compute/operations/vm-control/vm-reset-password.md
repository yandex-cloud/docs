# Resetting a user password on a Windows Server virtual machine

To reset a user password on a Windows Server virtual machine using {{ yandex-cloud }} tools, you require:

* [Password reset agent](../../concepts/guest-agent.md). The agent is part of standard Windows Server images. If you are using a custom image, follow the [instructions](../vm-guest-agent/install.md) to install the password reset agent.

{% include [vm-reset-password-windows-reqs](../../../_includes/compute/vm-reset-password-windows-reqs.md) %}

To reset a password:

{% list tabs %}

- Management console

   {% include [vm-reset-password-windows-console](../../../_includes/compute/vm-reset-password-windows-console.md) %}

- PowerShell

   1. Run PowerShell as an administrator.
   1. Install the password reset module (once):

      1. [Install the CLI and configure it](../../../cli/quickstart.md) to run commands under a user or a [service account](../../../iam/concepts/users/service-accounts.md) with the required role (see above).
      1. Run this command:

         ```powershell
         Install-Module -Name YCPasswordReset
         ```

         Answer `Y` (for "Yes") to any installer questions such as those regarding the NuGet package manager and repositories.

   1. Run this command:

      ```powershell
      Reset-YCUserPassword -InstanceName <VM name> -Username <VM username>
      ```

      {% note info %}

      If a command takes too long to run, stop it using the **Ctrl** + **C** key combination. After you do this, verify that the password reset agent has been installed. For more information, see [{#T}](../vm-guest-agent/check.md).

      {% endnote %}

      If the VM does not have the username specified in the `-Username` parameter, the user will be created with administrator access.

   1. Save the generated password. It will become unavailable once you close the window.

{% endlist %}
