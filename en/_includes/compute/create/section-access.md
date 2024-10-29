Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the data for access to the VM:

* (Optional) [Enable VM access via OS Login](../../../compute/operations/vm-connect/os-login.md). The option is available for Linux images from [{{ marketplace-name }}](/marketplace) with `OS Login` in their names.
* Enter the username into the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.

    {% note alert %}

    Do not use `root` or other usernames reserved by the OS. To perform operations requiring superuser permissions, use the `sudo` command.

    {% endnote %}

* In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the [public key](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) file. You need to create a key pair for the SSH connection yourself. To learn how, see [Connecting to a VM via SSH](../../../compute/operations/vm-connect/ssh.md).

If you want to add several users with SSH keys to the VM at the same time, [specify](../../../compute/concepts/vm-metadata.md#how-to-send-metadata) these users' data under **{{ ui-key.yacloud.common.metadata }}**. You can also use metadata to [install additional software](../../../compute/operations/vm-create/create-with-cloud-init-scripts.md) on a VM when creating it.

{% include [vm-connect-linux](../../vm-connect-linux.md) %}

