You can use a custom SSH key to connect to VMs with OS Login access enabled. To do this, [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) an SSH key, [add](../../organization/operations/add-ssh.md) it to the organization user profile in {{ org-full-name }} and specify the following when connecting:

1. [Enable](../../organization/operations/os-login-access.md) access via OS Login at the organization level.

   To connect to a VM via OS Login using an SSH key over the YC CLI, enable **{{ ui-key.yacloud_org.form.oslogin-settings.title_user-ssh-key-settings }}**.

1. Get a list of all VMs in the default folder:

   ```bash
   yc compute instance list
   ```

   Result:

   ```text
   +----------------------+-----------------+---------------+---------+---------------+--------------+
   |          ID          |       NAME      |    ZONE ID    | STATUS  |  EXTERNAL IP  | INTERNAL IP  |
   +----------------------+-----------------+---------------+---------+---------------+--------------+
   | fhm0b28lgf********** | first-instance  | {{ region-id }}-a | RUNNING | 158.160.**.** | 192.168.0.8  |
   | fhm9gk85nj********** | second-instance | {{ region-id }}-a | RUNNING | 51.250.**.*** | 192.168.0.12 |
   +----------------------+-----------------+---------------+---------+---------------+--------------+
   ```

1. Connect to the VM:

   ```bash
   yc compute ssh \
     --name <VM_name> \
     --identity-file <path_to_private_SSH_key_file>
     --login <username>
   ```

   Where:

   * `--name`: Previously obtained VM name. You can specify the VM ID instead of its name by using the `--id` parameter.
   * `--identity-file`: Path to the previously saved private SSH key file, e.g., `/home/user1/.ssh/id_ed25519`.
   * `--login`: OS Login username.

You will connect to the specified virtual machine using your SSH key. If this is your first time connecting to this VM, a new user profile will be created in the VM's operating system.