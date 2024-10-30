To connect to a VM instance via OS Login with an SSH key using the YC CLI:

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
    * `--login`: Previously obtained user or service account login, as set in the OS Login profile. This is an optional parameter. If this parameter is not specified, the connection will use the SSH certificate of the user or service account currently authorized in the YC CLI profile.
    * (Optional) `--internal-address`: To connect using an internal IP address.

    You can also see the command for VM connection in the [management console]({{ link-console-main }}). On the **{{ ui-key.yacloud.compute.instance.overview.label_title }}** page of the VM you need, under **Connect to VM**, expand the **Connect via the {{ yandex-cloud }} CLI interface** section and select the **SSH key** tab.