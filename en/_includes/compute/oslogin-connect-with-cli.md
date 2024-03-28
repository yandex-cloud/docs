1. [Enable](../../organization/operations/os-login-access.md) access via OS Login at the organization level.

   To connect to a VM via OS Login using an SSH certificate over the YC CLI, enable **{{ ui-key.yacloud_org.form.oslogin-settings.title_ssh-certificate-settings }}**.

1. View the description of the CLI command to connect to a VM:

   ```bash
   yc compute ssh --help
   ```

1. Get a list of all VMs in the default folder:

   ```bash
   yc compute instance list
   ```

   Result:

   ```text
   +----------------------+-----------------+---------------+---------+----------------------+
   |          ID          |       NAME      |    ZONE ID    | STATUS  |     DESCRIPTION      |
   +----------------------+-----------------+---------------+---------+----------------------+
   | fhm0b28lgf********** | first-instance  | {{ region-id }}-a | RUNNING | my first vm via CLI  |
   | fhm9gk85nj********** | second-instance | {{ region-id }}-a | RUNNING | my second vm via CLI |
   +----------------------+-----------------+---------------+---------+----------------------+
   ```

1. Connect to the VM by specifying its name. The connect command depends on the VM's Linux version:

   * **Debian, Ubuntu 20.04+**

      ```bash
      yc compute ssh \
        --name <VM_name>
      ```

      When connecting via OS Login, you can specify the VM ID instead of its name:

      ```bash
      yc compute ssh \
        --id <VM_ID>
      ```

   * **CentOS 7, Ubuntu 18.04**

      ```bash
      yc compute ssh \
        --name <VM_name> \
        -o "PubkeyAcceptedKeyTypes=+ssh-rsa-cert-v01@openssh.com"
      ```

      When connecting via OS Login, you can specify the VM ID instead of its name:

      ```bash
      yc compute ssh \
        --id <VM_ID> \
        -o "PubkeyAcceptedKeyTypes=+ssh-rsa-cert-v01@openssh.com"
      ```