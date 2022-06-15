1. You can get the IP address of an instance under **Network** on the instance page in the [management console]({{ link-console-main }}).

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

1. Upload the website files to the VM over [SCP](https://en.wikipedia.org/wiki/Secure_copy_protocol).

   {% list tabs %}

   - Linux/macOS
   
     Use the `scp` command-line utility:
   
     ```
     scp -r <path to the file directory> <your user's name>@<VM's IP address>:/var/www/html
     ```
   
   - Windows
   
     Use the [WinSCP](https://winscp.net/eng/download.php) program to copy the local file directory to the `/var/www/html` directory on the VM.

   {% endlist %}

