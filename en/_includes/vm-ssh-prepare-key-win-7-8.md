Create keys using the PuTTY app:

1. [Download](https://www.putty.org) and install PuTTY.
1. Add the folder with PuTTY to the `PATH` variable:

    {% include [windows-environment-vars](windows-environment-vars.md) %}

1. Launch the PuTTYgen app.
1. Select **EdDSA** as the pair type to generate. Click **Generate** and move the cursor in the field above it until key creation is complete.

    ![ssh_generate_key](../_assets/compute/ssh-putty/ssh_generate_key.png)

1. In **Key passphrase**, enter a strong password. Enter it again in the field below.
1. Click **Save private key** and save the private key. Do not share its key phrase with anyone.
1. Click **Save public key** and save the public key to a file named `<key_name>.pub`.