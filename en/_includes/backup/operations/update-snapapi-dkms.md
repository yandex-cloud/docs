If the {{ backup-name }} agent's performance is not restored after a reboot, complete the following steps to manually rebuild the SnapAPI kernel module for the required version:

1. Find out the Linux kernel version:

    ```bash
    uname -r
    ```

    Result:

    ```text
    6.8.0-110-generic
    ```

    As you can see in the output, the Linux kernel version is `6.8.0-110-generic`. You will need this value when updating the module.

1. Find out the SnapAPI version. If missing, install the `dkms` utility for your OS first:

    ```bash
    sudo dkms status | grep snapapi
    ```

    Result:

    ```text
    snapapi26/2.0.6, 5.15.0-119-generic, x86_64: built
    snapapi26/2.0.6, 6.8.0-48-generic, x86_64: built
    ```

    As you can see in the output, the SnapAPI module version is `snapapi26/2.0.6`. You will need this value when updating the module.

1. Update the SnapAPI module by populating the command with the SnapAPI and Linux kernel versions you obtained previously:

    ```bash
    sudo dkms install snapapi26/2.0.6 -k 6.8.0-110-generic
    ```

    Result: 

    ```text
    Building module:
    cleaning build area...
    ...
    - Installation
      - Installing to /lib/modules/6.8.0-110-generic/updates/dkms/
    depmod.......
    ```
1. Run the command again to check the installed SnapAPI version:

    ```bash
    sudo dkms status | grep snapapi
    ```

    Result:

    ```text
    snapapi26/2.0.6, 5.15.0-119-generic, x86_64: built
    snapapi26/2.0.6, 6.8.0-110-generic, x86_64: installed
    snapapi26/2.0.6, 6.8.0-48-generic, x86_64: built
    ```
1. Reboot your OS:

    ```bash
    sudo reboot
    ```