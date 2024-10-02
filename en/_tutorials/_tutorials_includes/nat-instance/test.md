1. [Connect](../../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM via a private IP address, using the NAT instance as a jump host:

    ```bash
    ssh -J <NAT_instance_username>@<NAT_instance_public_IP_address> \
      <VM_user_name>@<VM_internal_IP_address>
    ```

    You can also connect to the test VM using the standard input/output redirection (`-W` flag) to forward the connection through a NAT instance:

    ```bash
    ssh -o ProxyCommand="ssh -i <NAT_key_file_path/name> -W %h:%p <NAT_username>@<NAT_public_IP_address>" \
      -i <VM_key_file_path/name> <VM_user_name>@<VM_internal_IP_address>
    ```

    Use this command for connection in the following cases:

    * Your VM is running an OpenSSH version below 7.3.
    * Your SSH keys are stored outside the default directory or have non-standard names.

1. Type **yes** to connect to the NAT instance and re-enter **yes** to connect to the test VM.

    {% note info %}

    When you type **yes**, the command may not be displayed in the terminal, but it will run anyway.

    {% endnote %}

1. Make sure the test VM is connected to the internet via the public IP address of the NAT instance. Run this command:

    ```bash
    curl ifconfig.co
    ```

    If it returns the public IP address of the NAT instance, the configuration is correct.