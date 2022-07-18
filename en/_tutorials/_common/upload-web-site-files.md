1. Under **Network** on the VM page in the [management console]({{ link-console-main }}) find the VM's public IP address.
1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM via SSH.
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

1. Upload the website files to the VM via [SCP]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/SCP){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Secure_copy_protocol){% endif %}.

   {% list tabs %}

   - Linux/macOS

      Use the `scp` command-line utility:

      ```bash
      scp -r <path to the file directory> <VM username>@<VM IP address>:/var/www/html
      ```

   - Windows

      Use [WinSCP](https://winscp.net/eng/download.php) to copy the local file directory to `/var/www/html` on the VM.

   {% endlist %}