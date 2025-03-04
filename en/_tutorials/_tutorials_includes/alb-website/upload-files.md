To test the web server, upload the website files to each VM. You can use the `index.html` file from [this archive](https://{{ s3-storage-host }}/doc-files/index.html.zip) as an example.

For each VM in the [created group](#create-vms), do the following:
1. On the **{{ ui-key.yacloud.compute.instances.label_title }}** tab, click the VM name in the list.
1. Copy **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}** from the **{{ ui-key.yacloud.compute.instance.overview.section_network }}** section.
1. [Connect](../../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM over SSH.
1. Grant your user write permissions for the `/var/www/html` directory:

   ```bash
   sudo chown -R "$USER":www-data /var/www/html
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