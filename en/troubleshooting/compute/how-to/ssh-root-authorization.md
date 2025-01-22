# How to connect via SSH as root with a password or key



## Scenario description {#case-description}

You need to connect via SSH from root with a password or key.

## Solution {#case-resolution}

{% list tabs %}

- Connecting with a key

   To connect via SSH with a key, make sure that the `/root/.ssh/authorized_keys` file contains only the key. Everything preceding the key needs to be deleted.

- Connecting with a password.

   To connect via SSH with a password:

   1. Create a password for root using the `sudo passwd root` command.

   2. The `/root/.ssh/authorized_keys` file must be empty or contain only the key. If the key does not match, the file will request a password.

   3. The `/etc/ssh/sshd_config.d/50-cloud-init.conf` file must contain:

   ```
   PasswordAuthentication yes
   PermitRootLogin yes
   ```

{% endlist %}