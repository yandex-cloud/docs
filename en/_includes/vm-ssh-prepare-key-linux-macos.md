1. Open the terminal.
1. Use the `ssh-keygen` command to create a new key:

    ```bash
    ssh-keygen -t ed25519 -C "<optional_comment>"
    ```

    You can specify an empty string in the `-C` parameter to avoid adding a comment, or you may not specify the `-C` parameter at all: in this case, a default comment will be added.

    After running this command, you will be prompted to specify the name and path to the key files, as well as enter the password for the private key. If you only specify the name, the key pair will be created in the current directory. The public key will be saved in a file with the `.pub` extension, while the private key, in a file without extension.

    By default, the command prompts you to save the key under the `id_ed25519` name in the following directory: `/home/<username>/.ssh`. If there is already an SSH key named `id_ed25519` in this directory, you may accidentally overwrite it and lose access to the resources it is used in. Therefore, you may want to use unique names for all SSH keys.