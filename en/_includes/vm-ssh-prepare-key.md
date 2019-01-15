## Creating an SSH key pair

Prepare the keys for use with your virtual machines. To do this:

---

**[!TAB Linux/MacOS]**

1. Open the terminal.

1. Use the `ssh-keygen` command to create a new key:

   ```
   $ ssh-keygen -t rsa -b 2048
   ```

   After the command runs, you will be asked to specify the names of files where the keys will be saved and enter the password for the private key. The default name is `id_rsa`. Keys are created in the `~./ssh` directory.

   The public part of the key will be saved in a file with the name `<key_name>.pub`. Copy the key string to the public key field when creating a new virtual machine via the management console.

**[!TAB Windows 10]**

1. Run `cmd.exe` or `powershell.exe`.

1. Use the `ssh-keygen` command to create a new key. Run the command:

   ```
   $ ssh-keygen -t rsa -b 2048
   ```

   After the command runs, you will be asked to specify the names of files where the keys will be saved and enter the password for the private key. The default name is `id_rsa`. Keys are created in the `C:\Users\<user_name>\.ssh\` directory.

   The public part of the key will be saved in a file with the name `<key_name>.pub`. Open the file using Notepad or another text editor and copy the key string to the public key field when creating a new virtual machine via the management console.

**[!TAB Windows 7/8]**

To create keys for Windows, use the PuTTY application.

1. [Download](https://www.putty.org) and install PuTTY.

1. Make sure that the directory where you installed PuTTY is included in `PATH`:
   1. Right-click on **My computer**. Click **Properties**.
   1. In the window that opens, select **Additional system parameters**, then **Environment variables** (located in the lower part of the window).
   1. Under **System variables**, find `PATH` and click **Edit**.
   1. In the **Variable value** field, append the path to the directory where you installed PuTTY.

1. Launch the PuTTYgen application.

1. Select **RSA** for the type of pair to generate and set the length to `2048`. Click **Generate** and move the mouse in the field above it until the key creation is complete.

   ![ssh_generate_key](../compute/_assets/ssh-putty/ssh_generate_key.png)

1. In the **Key passphrase** field, enter a strong password. Enter it again in the field below.

1. Click **Save private key** and save the private key. Never share it with anyone and do not tell anyone the passphrase for it.

1. Save the public key from the text field in a text file with the name `id_rsa.pub`. The key will be saved in a single line in this file. Open the file using Notepad or another text editor and copy the key string to the public key field when creating a new virtual machine via the management console.

---

