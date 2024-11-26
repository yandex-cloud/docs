To connect to a VM via {{ oslogin }} with an SSH key using a standard SSH client:

1. {% include [oslogin-connect-key-enable-in-org](../../_includes/compute/oslogin-connect-key-enable-in-org.md) %}
1. {% include [oslogin-connect-instr-create-ssh-key](../../_includes/compute/oslogin-connect-instr-create-ssh-key.md) %}
1. {% include [os-login-cli-organization-list](../../_includes/organization/os-login-cli-organization-list.md) %}
1. {% include [os-login-cli-profile-list](../../_includes/organization/os-login-cli-profile-list.md) %}
1. {% include [oslogin-connect-instr-list-vms](../../_includes/compute/oslogin-connect-instr-list-vms.md) %}

    Save the public IP address (the `EXTERNAL IP` value) of the VM you want to connect to.
1. Connect to the VM:

    ```bash
    ssh -i <path_to_private_SSH_key_file> \
      -l <user_or_service_account_login> <VM_public_IP_address>
    ```

    Where:

    * `<path_to_private_SSH_key_file>`: Path to the file containing the private SSH key, e.g., `/home/user1/.ssh/id_ed25519`. 
    * `<user_or_service_account_login>`: Previously obtained user or service account login, as set in the {{ oslogin }} profile.
    * `<VM_public_IP_address>`: VM public IP address you saved earlier.

    You can also see the command for VM connection in the [management console]({{ link-console-main }}). On the **{{ ui-key.yacloud.compute.instance.overview.label_title }}** page of the VM, under **Connect to VM**, expand the **Connect via SSH client** section and select the **SSH key** tab.

    If this is your first time connecting to the VM, you will see an unknown host warning:

    ```text
    The authenticity of host '158.160.**.** (158.160.**.**)' can't be established.
    ECDSA key fingerprint is SHA256:PoaSwqxRc8g6iOXtiH7ayGHpSN0MXwUfWHk********.
    Are you sure you want to continue connecting (yes/no)?
    ```

    Type `yes` in the terminal and press **Enter**.