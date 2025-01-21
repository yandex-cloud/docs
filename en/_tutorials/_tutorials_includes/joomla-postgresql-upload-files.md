1. Under **{{ ui-key.yacloud.compute.instance.overview.section_network }}** on the VM page in the [management console]({{ link-console-main }}), find the VM's public IP address.
1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM via SSH.
1. Grant your user write permissions for the `/var/www/html` directory:

   ```bash
   sudo chown -R "$USER":apache /var/www/html
   ```

1. Upload the website files to the VM via [SCP](https://en.wikipedia.org/wiki/Secure_copy_protocol).

   {% list tabs group=operating_system %}

   - Linux/macOS {#linux-macos}

     Use the `scp` command line utility:

     ```bash
     scp -r <path_to_directory_with_files> <VM_user_name>@<VM_IP_address>:/var/www/html
     ```

   - Windows {#windows}

     Use [WinSCP](https://winscp.net/eng/download.php) to copy the local file directory to `/var/www/html` on the VM.

   {% endlist %}