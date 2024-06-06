1. Go to the VM page of the [management console]({{ link-console-main }}). In the **Network** section, find the VM's public IP address.
1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH.
1. Grant your user write access to the `/var/www/html` directory:

   {% list tabs group=operating_system %}

   - Ubuntu {#ubuntu}

      ```bash
      sudo chown -R "$USER":www-data /var/www/html
      ```

   - CentOS {#centos}

      ```bash
      sudo chown -R "$USER":apache /var/www/html
      ```

   {% endlist %}


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
