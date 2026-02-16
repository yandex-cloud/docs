When creating a VM, an administrator account for the web interface is created automatically. To get authentication credentials:

1. Use SSH to connect to the VM you created:

   ```bash
   ssh <username>@<VM_public_IP_address>
   ```

1. Switch to the `root` account:

   ```bash
   sudo su
   ```

1. Open the file for reading:

   ```bash
   cat root/default_passwords.txt
   ```

1. Copy the username and user password from the `WP_ADMIN_USER` and `WP_ADMIN_PASSWORD` lines.