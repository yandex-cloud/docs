{% list tabs group=operating_system %}

- Linux {#linux}

    1. Install Docker Engine. Use [this guide](https://docs.docker.com/engine/install/#supported-platforms) to install and run Docker for your operating system.

    1. After the installation is complete, add the current user to the `docker` group:

        ```bash
        sudo groupadd docker
        sudo usermod -aG docker $USER
        newgrp docker
        ```

    For information about additional Docker settings for Linux, see the [developer documentation](https://docs.docker.com/engine/install/linux-postinstall/).

    If you are working on a device with a GUI, you can also [install](https://docs.docker.com/desktop/install/linux-install/) Docker Desktop for Linux.

- macOS {#macos}

  [Download](https://docs.docker.com/get-docker/) and install the Docker Desktop distribution for macOS. For more information, see the [developer documentation](https://docs.docker.com/desktop/install/mac-install/).

- Windows {#windows}

    1. [Download](https://docs.docker.com/get-docker/) and install the Docker Desktop distribution for Windows.

    1. After the installation is complete, add the current user to the `docker-users` group:

        1. Run **Computer Management** as administrator:

            ```powershell
            compmgmt.msc
            ```

        1. Expand the **(Local) Computer Management** menu, then go to **Utilities** → **Local Users and Groups** → **Groups** and open the `docker-users` group.
        1. Click **Add** and add the required user to the group.
        1. Click **OK**.
    1. Run Docker Desktop and make sure the app status is `running`.

    For information about additional Docker settings for Windows, see the [developer documentation](https://docs.docker.com/desktop/install/windows-install/).

{% endlist %}