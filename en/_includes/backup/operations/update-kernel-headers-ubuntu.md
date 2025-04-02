1. Make sure the Linux kernel version does not match that of the kernel headers:

    * To find out the Linux kernel version, run this command in the terminal:

        ```bash
        uname -r
        ```

        Result:

        ```text
        6.1.0-31-amd64
        ```
    * To find out the version of the Linux kernel headers, run this command:

        ```bash
        sudo apt list --installed | grep header
        ```

        Result:

        ```bash
        linux-headers-6.1.0-27-amd64/stable,now 6.1.115-1 amd64 [installed]
        linux-headers-6.1.0-27-common/stable,now 6.1.115-1 all [installed,automatic]
        ```
    As you can see from the command outputs, the versions are different: the Linux kernel version is `6.1.0-31`, and the Linux kernel header version is `6.1.0-27`.
1. Install the `linux-headers` package for the new Linux kernel:

    ```bash
    sudo apt install linux-headers-$(uname -r)
    ```
1. Make sure the new kernel headers have been added:

    ```bash
    sudo apt list --installed | grep header
    ```

    Result:

    ```bash
    linux-headers-6.1.0-27-amd64/stable,now 6.1.115-1 amd64 [installed]
    linux-headers-6.1.0-27-common/stable,now 6.1.115-1 all [installed,automatic]
    linux-headers-6.1.0-31-amd64/stable-security,now 6.1.128-1 amd64 [installed]
    linux-headers-6.1.0-31-common/stable-security,now 6.1.128-1 all [installed,automatic]
    ```
1. Reboot your OS:

    ```bash
    sudo reboot
    ```

    During the reboot, the DKMS framework will rebuild the SnapAPI module for the required Linux kernel version and the {{ backup-name }} agent will start operating.