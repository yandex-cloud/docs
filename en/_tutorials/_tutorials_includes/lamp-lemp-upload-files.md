To test the web server, upload the `index.html` file to the VM. You can use a [test file](https://{{ s3-storage-host }}/doc-files/index.html.zip). Download and unzip the archive.
1. Under **Network** on the VM page in the [management console]({{ link-console-main }}), find the VM's public IP address.
1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM via SSH.
1. Grant your user write access to the `/var/www/html` directory:

   ```bash
   sudo chown -R "$USER":www-data /var/www/html
   ```

1. Upload the website files to the VM via [SCP](https://en.wikipedia.org/wiki/Secure_copy_protocol).

   {% list tabs group=operating_system %}

   - Linux/macOS {#linux-macos}

      Use the `scp` command-line utility:

      ```bash
      scp -r <path_to_file_directory> <VM_username>@<VM_IP_address>:/var/www/html
      ```

   - Windows {#windows}

      Use [WinSCP](https://winscp.net/eng/download.php) to copy the local file directory to `/var/www/html` on the VM.

   {% endlist %}