Enable IP forwarding in the Linux kernel settings:

1. Open the `sysctl.conf` configuration file:

    ```bash
    sudo nano /etc/sysctl.conf
    ```
1. Add this line to end of the `sysctl.conf` file:

    ```text
    net.ipv4.ip_forward = 1
    ```
1. Apply the new kernel settings:

    ```bash
    sudo sysctl -p
    ```