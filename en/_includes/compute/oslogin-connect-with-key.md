To connect to a VM via {{ oslogin }} with an SSH key using the {{ yandex-cloud }} CLI:

1. {% include [oslogin-connect-key-enable-in-org](../../_includes/compute/oslogin-connect-key-enable-in-org.md) %}
1. {% include [oslogin-connect-instr-create-ssh-key](../../_includes/compute/oslogin-connect-instr-create-ssh-key.md) %}
1. View the description of the CLI command to connect to a VM:

    ```bash
    yc compute ssh --help
    ```
1. {% include [os-login-cli-organization-list](../../_includes/organization/os-login-cli-organization-list.md) %}
1. {% include [os-login-cli-profile-list](../../_includes/organization/os-login-cli-profile-list.md) %}
1. {% include [oslogin-connect-instr-list-vms](../../_includes/compute/oslogin-connect-instr-list-vms.md) %}
1. Connect to the VM:

    ```bash
    yc compute ssh \
      --name <VM_name> \
      --identity-file <path_to_private_SSH_key_file> \
      --login <user_or_service_account_login> \
      --internal-address
    ```

    Where:
    * `--name`: Previously obtained VM name. You can specify the VM ID instead of its name by using the `--id` parameter.
    * `--identity-file`: Path to a private SSH key file, e.g., `/home/user1/.ssh/id_ed25519`.
    * `--login`: Previously obtained user or service account login, as set in the {{ oslogin }} profile. This is an optional parameter. If this parameter is not specified, the connection will use the login specified in the default [{{ oslogin }} profile](../../organization/concepts/os-login.md#os-login-profiles) for the user or service account currently authorized in the {{ yandex-cloud }} CLI profile.
    * `--internal-address`: To connect using an internal IP address. This is an optional parameter.