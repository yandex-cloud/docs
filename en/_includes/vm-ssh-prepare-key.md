{% list tabs group=operating_system %}

- Linux/macOS {#linux-macos}

  1. Open the terminal.
  1. Use the `ssh-keygen` command to create a new key:

     ```bash
     ssh-keygen -t ed25519 -C "<optional_comment>"
     ```

     You can specify an empty string in the `-C` parameter to avoid adding a comment, or you may not specify the `-C` parameter at all: in this case, a default comment will be added.

     After running this command, you will be prompted to specify the name and path to the key files, as well as enter the password for the private key. If you only specify the name, the key pair will be created in the current directory. The public key will be saved in a file with the `.pub` extension, while the private key, in a file without extension.

     By default, the command prompts you to save the key under the `id_ed25519` name in the following directory: `/home/<username>/.ssh`. If there is already an SSH key named `id_ed25519` in this directory, you may accidentally overwrite it and lose access to the resources it is used in. Therefore, you may want to use unique names for all SSH keys. 

- Windows 10/11 {#windows}

  If you do not have [OpenSSH](https://en.wikipedia.org/wiki/OpenSSH) installed yet, follow this [guide](https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse?tabs=gui) to install it.

  1. Run `cmd.exe` or `powershell.exe` (make sure to update PowerShell before doing so).
  1. Use the `ssh-keygen` command to create a new key:

     ```shell
     ssh-keygen -t ed25519 -C "<optional_comment>"
     ```

     You can specify an empty string in the `-C` parameter to avoid adding a comment, or you may not specify the `-C` parameter at all: in this case, a default comment will be added.

     After running this command, you will be prompted to specify the name and path to the key files, as well as enter the password for the private key. If you only specify the name, the key pair will be created in the current directory. The public key will be saved in a file with the `.pub` extension, while the private key, in a file without extension.

     By default, the command prompts you to save the key under the `id_ed25519` name in the following folder: `C:\Users\<username>/.ssh`. If there is already an SSH key named `id_ed25519` in this directory, you may accidentally overwrite it and lose access to the resources it is used in. Therefore, you may want to use unique names for all SSH keys.

- Windows 7/8 {#windows7-8}

  Create keys using the PuTTY app:
  1. [Download](https://www.putty.org) and install PuTTY.
  1. Add the folder with PuTTY to the `PATH` variable:

      {% include [windows-environment-vars](windows-environment-vars.md) %}

  1. Launch the PuTTYgen app.
  1. Select **EdDSA** as the pair type to generate. Click **Generate** and move the cursor in the field above it until key creation is complete.

     ![ssh_generate_key](../_assets/compute/ssh-putty/ssh_generate_key.png)

  1. In **Key passphrase**, enter a strong password. Enter it again in the field below.
  1. Click **Save private** key and save the private key. Do not share its key phrase with anyone.
  1. Click **Save public key** and save the public key to a file named `<key_name>.pub`.

{% endlist %}
