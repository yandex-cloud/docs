{% list tabs group=operating_system %}

- Linux {#linux}

    1. Install Docker Engine. Use [this guide](https://docs.docker.com/engine/install/#supported-platforms) to install and run Docker for your operating system.

    1. After the installation is complete, add the current user to the `docker` group:

        ```bash
        sudo groupadd docker
        sudo usermod -aG docker $USER
        newgrp docker
        ```

    For groups to update successfully, you may need to log back into the OS or reboot the computer.

    For information about additional Docker settings for Linux, see [this developer guide](https://docs.docker.com/engine/install/linux-postinstall/).

    If you using a computer with a GUI, you can also [install](https://docs.docker.com/desktop/install/linux-install/) Docker Desktop for Linux.

- macOS {#macos}

  [Download](https://docs.docker.com/get-docker/) and install Docker Desktop for macOS. For more information, see [this developer guide](https://docs.docker.com/desktop/install/mac-install/).

- Windows {#windows}

    1. [Download](https://docs.docker.com/get-docker/) and install Docker Desktop for Windows.

    1. After the installation is complete, add the current user to the `docker-users` group:

        1. Run **Computer Management** as an administrator:

            ```powershell
            compmgmt.msc
            ```
        
        1. Expand **Computer Management (Local)** → **System Tools** → **Local Users and Groups** → **Groups** and open the `docker-users` group.
        1. Click **Add** and add the user to the group.
        1. Click **OK**.
    1. Run Docker Desktop and make sure the app's status is `running`.

    For information about additional Docker settings for Windows, see [this developer guide](https://docs.docker.com/desktop/install/windows-install/).

{% endlist %}