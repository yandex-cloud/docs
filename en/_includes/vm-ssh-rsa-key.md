To connect to a [VM](../compute/concepts/vm.md) over SSH, you need a key pair: the public key resides on the VM, and the private one is kept by the user. This method is more secure than connecting with login and password.

{% include [vm-connect-ssh-linux-note](vm-connect-ssh-linux-note.md) %}

Cisco Cloud Services Router (CSR) 1000v only supports keys generated using the RSA algorithm.

To create a key pair:

{% list tabs group=operating_system %}

- Linux/macOS {#linux-macos}

  1. Open the terminal.
  1. Use the `ssh-keygen` command to create a new key:

     ```bash
     ssh-keygen -t rsa -b 2048
     ```

     After you run the command, you will be asked to specify the names of files where the keys will be saved and enter the password for the private key. The default name is `id_rsa`. Keys are created in the `~/.ssh` directory.

     The public part of the key will be saved in the `<key_name>.pub` file.

- Windows 10/11 {#windows}

  1. Run `cmd.exe` or `powershell.exe`.
  1. Use the `ssh-keygen` command to create a new key:

     ```shell
     ssh-keygen -t rsa -b 2048
     ```

     After you run the command, you will be asked to specify the names of files where the keys will be saved and enter the password for the private key. The default name is `id_rsa`. The keys are created in `C:\Users\<username>\.ssh\` or `C:\Users\<username>\` depending on the command-line interface.

     The public part of the key will be saved to a file named `<key name>.pub`.

- Windows 7/8 {#windows7-8}

  Create keys using the PuTTY app:
  1. [Download](https://www.putty.org) and install PuTTY.
  1. Add the folder with PuTTY to the `PATH` variable:

      {% include [windows-environment-vars](windows-environment-vars.md) %}

  1. Launch the PuTTYgen app.
  1. Select **RSA** for the type of pair to generate and set the length to 2048. Click **Generate** and move the cursor in the field above it until key creation is complete.

     ![ssh_generate_key](../_assets/compute/ssh-putty/ssh-generate-key-rsa.png)

  1. In **Key passphrase**, enter a strong password. Enter it again in the field below.
  1. Click **Save private key** and save the private key. Do not share its key phrase with anyone.
  1. Save the key to a text file. To do this, copy the public key from the text field to a text file named `id_rsa.pub`. Please note that the key must be written as a **single line** (no returns or line breaks).

{% endlist %}