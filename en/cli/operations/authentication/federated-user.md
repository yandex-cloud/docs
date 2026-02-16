---
title: Authenticating as a federated user
description: Follow this guide to authenticate in the CLI as a federated user.
---

# Authenticating as a federated user

You can use a [federated account](../../../iam/concepts/users/accounts.md#saml-federation) to work with {{ yandex-cloud }} if your company has an [identity federation](../../../iam/concepts/federations.md) set up. In this case, no personal [Yandex account](../../../iam/concepts/users/accounts.md#passport) is required.

{% note info %}

To authenticate on a server with no GUI, you need to install a browser with [X11 forwarding set up](https://docs.ssh.com/manuals/client-user/53/tunnel-x11.html). With X11 forwarding, you can use your browser on the server over SSH. For SSH clients running on Linux, this feature is available by default. For Windows clients, you can use [Xming](https://sourceforge.net/projects/xming/).

See also [{#T}](#linux-vm-auth).

If you cannot install a browser, use a [service account](../../../iam/concepts/users/service-accounts.md) instead of a federated account.

{% endnote %}

If you do not have the {{ yandex-cloud }} CLI yet, [install it](../install-cli.md).


{% include [include](../../../_includes/cli/auth-federated-user.md) %}

## Example of authenticating to a Linux VM without GUI {#linux-vm-auth}

To authenticate to a Linux VM, follow these steps:

1. [Connect](../../../compute/operations/vm-connect/ssh.md) to the VM over SSH.
1. [Install the CLI](../install-cli.md).

1. On your VM, create a file named `/usr/local/bin/xdg-open` with the following contents:

    ```bash
    #!/bin/sh
    echo $* > /dev/tty
    ```

1. Assign permissions to execute the file:

    ```bash
    sudo chmod +x /usr/local/bin/xdg-open
    ```

1. Run this CLI command to create a profile:

    ```bash
    yc init --federation-id=<federation_ID>
    ```

1. Select the profile you want to set up authentication for or create a new one:

   ```text
   Welcome! This command will take you through the configuration process.
   Pick desired action:
   [1] Re-initialize this profile 'default' with new settings
   [2] Create a new profile
   ```

1. The CLI prompts you to continue authentication in the browser. Press **Enter** to continue:

   ```text
   You are going to be authenticated via federation-id 'aje1f0hsgds3a********'.
   Your federation authentication web site will be opened.
   After your successful authentication, you will be redirected to '{{ link-console-main }}'.

   Press 'enter' to continue...
   ```

1. Once you press **Enter**, you will get a URL that looks like this:

    ```text
    https://{{ auth-main-host }}/oauth/authorize?client_id=yc.oauth.public-sdk&code_challenge=y22kspX4VrKLmdg9hGr_Bwgte_a3RXtw1En********&code_challenge_method=S256&redirect_uri=http%3A%2F%2F127.0.0.1%3A42121%2Fauth%2Fcallback&response_type=code&scope=openid&state=aExf0z********&yc_federation_hint=federation-id
    ```

    Save this URL. You will need it for browser authentication. You will also need the port which you can find in the `redirect_uri` query parameter following the `127.0.0.1` IP address. In our example, it is `42121`.

1. On your local computer, open a new terminal window and run the command to set up an SSH tunnel, specifying the port obtained in the previous step, username, and VM IP address:

    ```bash
    ssh -L <port>:127.0.0.1:<port> <username>@<VM_IP_address>
    ```

1. Use your local computer's browser to open the authentication URL you got earlier.

1. Upon successful authentication, the pending CLI command within the VM SSH session will display the next profile configuration step. 
1. Complete the CLI configuration.
