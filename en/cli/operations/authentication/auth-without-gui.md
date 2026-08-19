# Authenticating with the {{ yandex-cloud }} CLI on a server with no GUI

{% include [note-auth-without-gui](../../../_includes/cli/note-auth-without-gui.md) %}

This subsection discusses the following methods for authentication on a server with no GUI:
* [{#T}](#auth-without-gui)
* [{#T}](#linux-vm-auth)

## Authentication via X11 forwarding {#auth-without-gui}

This example describes [X11 forwarding](https://docs.ssh.com/manuals/client-user/53/tunnel-x11.html) authentication on a Ubuntu server.

1. If connecting to a VM from macOS or Windows, install and run an X server, e.g., [XQuartz](https://www.xquartz.org/) for macOS or [VcXsrv](https://vcxsrv.com/) for Windows. Linux has this feature available by default.
1. [Connect](../../../compute/operations/vm-connect/ssh.md) to the server over SSH:

    ```bash
    ssh -i <key_file> <username>@<server_public_IP_address>
    ```

1. Open `/etc/ssh/sshd_config`:

    ```bash
    sudo nano /etc/ssh/sshd_config
    ```

1. Uncomment these lines:

    ```text
    X11Forwarding yes
    X11DisplayOffset 10
    X11UseLocalhost yes
    ```

1. Install the X server packages:

    ```bash
    sudo apt get update
    sudo apt-get install xauth xorg
    ```

1. Disconnect from the server and reconnect to your X server using the `-X` flag:

    ```bash
    ssh -X -i <key_file> <username>@<server_public_IP_address>
    ```

1. Optionally, make sure X11 forwarding works correctly by running this command:

    ```bash
    xeyes
    ```

    An Xeyes window will open; close it.

1. Install the [Chromium](https://www.chromium.org/Home/) browser and make sure you can start it:

    ```bash
    sudo apt update && sudo apt install chromium-browser
    export XAUTHORITY=$HOME/.Xauthority
    chromium
    ```

    A browser window will open; close it.

1. Install the CLI and an X11 integration package:

    ```bash
    curl -sSL https://{{ s3-storage-host-cli }}{{ yc-install-path }} | bash
    exec -l $SHELL
    sudo apt install xdg-utils
    ```

1. Start the authentication process:

    {% list tabs group=authentication %}

    - Yandex account {#yandex-account}

            
      ```bash
      yc init --username=<email_address>
      ```



      For more information, see [{#T}](./user.md).

    - Federated account {#federated-account}

            
      ```bash
      yc init --federation-id=<federation_ID>
      ```



      For more information, see [{#T}](./federated-user.md).

    - Local user account {#local-account}

               
      ```bash
      yc init --userpool-id=<user_pool_ID>
      ```



      For more information, see [{#T}](./local-user.md).

    {% endlist %}

    A browser window with the authentication page will now open.

1. Complete the CLI configuration.

## Example of authenticating over an SSH tunnel {#linux-vm-auth}

To authenticate to a Linux VM, follow these steps:

1. [Connect](../../../compute/operations/vm-connect/ssh.md) to the VM over SSH.
1. On your VM, create a file named `/usr/local/bin/xdg-open` with the following contents:

    ```bash
    #!/bin/sh
    echo $* > /dev/tty
    ```

1. Assign permissions to execute the file:

    ```bash
    sudo chmod +x /usr/local/bin/xdg-open
    ```

1. Install the CLI:

    ```bash
    curl -sSL https://{{ s3-storage-host-cli }}{{ yc-install-path }} | bash
    exec -l $SHELL
    ```

1. Start the authentication process:

    {% list tabs group=authentication %}

    - Yandex account {#yandex-account}

            
      ```bash
      yc init --username=<email_address>
      ```



      For more information, see [{#T}](./user.md).

    - Federated account {#federated-account}

            
      ```bash
      yc init --federation-id=<federation_ID>
      ```



      For more information, see [{#T}](./federated-user.md).

    - Local user account {#local-account}

               
      ```bash
      yc init --userpool-id=<user_pool_ID>
      ```



      For more information, see [{#T}](./local-user.md).

    {% endlist %}

1. Select the profile you want to set up authentication for or create a new one:

    ```text
    Welcome! This command will take you through the configuration process.
    Pick desired action:
    [1] Re-initialize this profile 'default' with new settings
    [2] Create a new profile
    ```

1. The CLI prompts you to continue authentication in the browser. Press **Enter** to continue:

    {% list tabs group=authentication %}

    - Yandex account {#yandex-account}

      ```text
      You are going to be authenticated via username '<email_address>'.
      Authentication web site will be opened.
      After your successful authentication, you will be redirected to '{{ link-console-main }}'.

      Press 'enter' to continue...
      ```

    - Federated account {#federated-account}

      ```text
      You are going to be authenticated via federation-id 'aje1f0hsgds3a********'.
      Your federation authentication web site will be opened.
      After your successful authentication, you will be redirected to '{{ link-console-main }}'.

      Press 'enter' to continue...
      ```

    - Local user account {#local-account}

      ```text
      You are going to be authenticated via userpool-id 'ek0auknfc0mh********'.
      Your userpool authentication web site will be opened.
      After your successful authentication, you will be redirected to cloud console.

      Press 'enter' to continue...
      ```

    {% endlist %}

1. Once you press **Enter**, you will get a URL that looks like this:

    ```text
    https://{{ auth-main-host }}/oauth/authorize?client_id=yc.oauth.public-sdk&code_challenge=y22kspX4VrKLmdg9hGr_Bwgte_a3RXtw1En********&code_challenge_method=S256&redirect_uri=http%3A%2F%2F127.0.0.1%3A42121%2Fauth%2Fcallback&response_type=code&scope=openid&state=aExf0z********&yc_federation_hint=federation-id
    ```

    Save this URL. You will need it for browser authentication. You will also need the port which you can find in the `redirect_uri` query parameter following the `127.0.0.1` IP address. In our example, it is `42121`.

1. On your local computer, open a new terminal window and run the command to set up an SSH tunnel, specifying the port obtained in the previous step, username, and VM IP address:

    ```bash
    ssh -N -L <port>:127.0.0.1:<port> <username>@<VM_IP_address>
    ```

    After the connection is established, the command returns no result and remains active for as long as the SSH tunnel is operating. Do not close this terminal window until the CLI setup is complete.

1. Use your local computer's browser to open the authentication URL you got earlier.
1. Return to the VM SSH session terminal window where the `yc init` command is active. If authentication is successful, the CLI will go to the next profile configuration step.
1. Complete the CLI configuration.
1. In the local terminal window, terminate the SSH tunnel by pressing **Ctrl** + **C**.

#### Useful links {#see-also}

* [{#T}](service-account.md)
* [{#T}](user.md)
* [{#T}](federated-user.md)
* [{#T}](local-user.md)
