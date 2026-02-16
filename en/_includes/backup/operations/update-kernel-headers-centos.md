1. Make sure the Linux kernel version does not match that of the kernel headers:

    * To find out the Linux kernel version, run this command in the terminal:

        ```bash
        uname -r
        ```

        Result:

        ```text
        3.10.0.1160.81.1.el7.x86_64
        ```
    * To find out the version of the Linux kernel headers, run this command:

        ```bash
        sudo yum list installed | grep kernel-dev*
        ```

        Result:

        ```bash
        kernel-devel.x86_64             3.10.0-1160.76.1.el7            @updates
        ```
    As you can see from the output of the commands, the versions are different: the Linux kernel version is `3.10.0.1160.81.1.el7`, while the version of the Linux kernel headers is `3.10.0-1160.76.1.el7`.
1. Install the `linux-headers` package for the new Linux kernel:

    ```bash
    sudo yum install kernel-$(uname -r)
    ```
1. Make sure the new kernel headers have been added:

    ```bash
    sudo yum list installed | grep kernel-dev*
    ```

    Result:

    ```bash
    kernel-devel.x86_64             3.10.0-1160.76.1.el7            @updates
    kernel-devel.x86_64             3.10.0.1160.81.1.el7            @updates
    ```
1. Reboot your OS:

    ```bash
    sudo reboot
    ```

    During the reboot, the DKMS framework will rebuild the SnapAPI module for the required Linux kernel version and the {{ backup-name }} agent will start operating.