1. You can learn the IP address of the VM under **Network** on the VM page in [management console]({{ link-console-main }}).

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH.

1. Grant your user write access to the directory `/var/www/html`:

   {% list tabs %}

   - Ubuntu

     ```bash
     sudo chown -R "$USER":www-data /var/www/html
     ```

   - CentOS

     ```bash
     sudo chown -R "$USER":apache /var/www/html
     ```

   {% endlist %}

1. Upload the website files to the VM over SCP.

   {% list tabs %}

   - Linux/macOS

     Use the `scp` command-line utility:

     ```bash
     scp -r <path to the file directory> <VM username>@<VM IP address>:/var/www/html
     ```

   - Windows

     Use the [WinSCP](https://winscp.net/eng/download.php) program to copy the local file directory to the `/var/www/html` directory on the VM.

   {% endlist %}

