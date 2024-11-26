Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**:

* Select **{{ ui-key.yacloud.compute.instance.access-method.field_os-login-access-method }}** to [connect](../../../compute/operations/vm-connect/os-login.md) and manage access to the new VM using [{{ oslogin }}](../../../organization/concepts/os-login.md) in {{ org-full-name }}.

    With {{ oslogin }}, you can connect to VMs using SSH keys and SSH certificates via a standard SSH client or the [{{ yandex-cloud }} CLI](../../../cli/quickstart.md). {{ oslogin }} allows you to rotate the SSH keys used to access VMs, providing the most [secure](../../../security/domains/iaas-checklist.md#vm-security) access option.

* If you prefer not to use {{ oslogin }}, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the following info for VM access:

    * Under **{{ ui-key.yacloud.compute.instances.create.field_user }}**, enter the username.

        {% note alert %}

        Do not use `root` or other usernames reserved by the OS. To perform operations requiring superuser permissions, use the `sudo` command.

        {% endnote %}

    * {% include [access-ssh-key](./access-ssh-key.md) %}

If you want to add several users with SSH keys to the VM at the same time, [specify](../../../compute/concepts/vm-metadata.md#how-to-send-metadata) these users' data under **{{ ui-key.yacloud.common.metadata }}**. You can also use metadata to [install additional software](../../../compute/operations/vm-create/create-with-cloud-init-scripts.md) on a VM when creating it.

{% include [vm-connect-linux](../../vm-connect-linux.md) %}