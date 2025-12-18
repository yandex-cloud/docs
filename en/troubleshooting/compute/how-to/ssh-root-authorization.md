# How to connect via SSH as root with a password or key



## Case description {#case-description}

You need to connect via SSH as root with a password or key.

## Solution {#case-resolution}

{% list tabs %}

- Connecting with a key

    When connecting with a key, the `/root/.ssh/authorized_keys` file must contain only the key. Delete everything preceding the key, if any.

- Connecting with a password

    To connect via SSH with a password:

    1. Create a password for root using the `sudo passwd root` command.

    1. The `/root/.ssh/authorized_keys` file must be empty or contain only the key. If the key does not match, the file will prompt you to enter a password.

    1. The `/etc/ssh/sshd_config.d/50-cloud-init.conf` file must contain:

        ```
        PasswordAuthentication yes
        PermitRootLogin yes
        ```

{% endlist %}