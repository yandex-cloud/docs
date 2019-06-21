1. Go to the VM page of the [management console](https://console.cloud.yandex.com). In the **Network** section, find the VM's public IP address.

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH. You can use the `ssh` tool on Linux and macOS and [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) for Windows.

   The recommended authentication method when connecting over SSH is using a key pair.  Don't forget to set up the created key pair: the private key must match the public key sent to the VM.

1. Grant your user write access to the directory `/var/www/html`:

   {% list tabs %}

   - Ubuntu
  
     ```bash
     $ sudo chown -R "$USER":www-data /var/www/html
     ```
  
   - CentOS
  
     ```bash
     $ sudo chown -R "$USER":apache /var/www/html
     ```
  
   {% endlist %}

1. Upload the website files to the VM over SCP.

   {% list tabs %}

   - Linux/macOS
  
     Use the `scp` command-line utility:
  
     ```bash
     $ scp -r <path to the file directory> <your user's name>@<VM's IP address>:/var/www/html
     ```
  
   - Windows
  
     Use the [WinSCP](https://winscp.net/eng/download.php) program to copy the local file directory to the `/var/www/html` directory on the VM.
  
   {% endlist %}

