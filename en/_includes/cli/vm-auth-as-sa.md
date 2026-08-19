The authentication process from inside a VM is simplified for a service account:
1. [Link your service account](../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) to a VM.
1. Authenticate from inside a VM:
      1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH.
   1. [Install the CLI](../../cli/operations/install-cli.md).
   1. Create a new profile:

      ```bash
      yc config profile create my-robot-profile
      ```


1. Configure your profile to run commands.

    {% include [add-folder](../cli-add-folder.md) %}
