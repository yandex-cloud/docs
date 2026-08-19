---
title: CLI troubleshooting
description: This article describes solutions for typical issues with the CLI.
---

# {{ yandex-cloud }} CLI troubleshooting

* [{#T}](#installation-errors)
  * [{#T}](#powershell-restriction)
  * [{#T}](#access-to-s3)
  * [{#T}](#failure-writing-output-to-destination)
  * [{#T}](#command-not-found)
  * [{#T}](#compdef-not-found)
* [{#T}](#operation-errors)
  * [{#T}](#sample)
  * [{#T}](#operation-error-details)
  * [{#T}](#what-to-do)
  * [{#T}](#name-not-found)
  * [{#T}](#proxy)
  * [{#T}](#invalid-token)
  * [{#T}](#federated-auth-without-gui)

## CLI installation issues {#installation-errors}

#### You cannot run scripts in PowerShell {#powershell-restriction}

{% include [cli-powershell-execution-policy](../_includes/cli/cli-powershell-execution-policy.md) %}

#### No access to https://{{ s3-storage-host-cli }} {#access-to-s3}

{% include [cli-install-without-access](../_includes/cli/cli-install-without-access.md) %}

#### Failure writing output to destination {#failure-writing-output-to-destination}

If `curl` was installed on Linux Ubuntu using a [snap package](https://en.wikipedia.org/wiki/Snap_(software)), you may get the `curl: (23) Failure writing output to destination` error while [installing](operations/install-cli.md) the CLI.

To fix this error, delete `curl` and reinstall it using the `apt` [package manager](https://en.wikipedia.org/wiki/APT_(software)):

```bash
sudo snap remove curl
sudo apt install curl
```

Then repeat the [CLI installation](./operations/install-cli.md).

#### The yc command not found in Linux or macOS {#command-not-found}

If you get the `yc: command not found` error after installing the CLI, restart the command shell or run this command:

```bash
exec -l $SHELL
```

If the error persists:

1. Make sure the CLI executable is installed:

    ```bash
    ls -l "$HOME/yandex-cloud/bin/yc"
    ```

    If the file is not there, [reinstall the CLI](./operations/install-cli.md).

1. Add the executable file path to the `PATH` environment variable for the current session and test the CLI:

    ```bash
    source "$HOME/yandex-cloud/path.bash.inc"
    yc version
    ```

1. To add the path in new session automatically, make sure the `~/.zshrc`, `~/.bashrc`, or `~/.bash_profile` file, depending on which shell you are using, contains the following line:

    ```bash
    if [ -f "$HOME/yandex-cloud/path.bash.inc" ]; then source "$HOME/yandex-cloud/path.bash.inc"; fi
    ```

#### `command not found: compdef` error {#compdef-not-found}

The `command not found: compdef` error occurs if CLI autocompletion is loaded before initializing the `zsh` autocompletion system.

Add the following lines to the `~/.zshrc` file before the line which connects the `completion.zsh.inc` file:

```bash
autoload -Uz compinit
compinit
```

Then restart the shell or run the `exec -l $SHELL` command. For more on setting up autocompletion, see [{#T}](./operations/install-cli.md#enable-completion).

## Issues when using the CLI {#operation-errors}

If an error occurs during the operation, the CLI displays the corresponding message.

#### Error message example {#sample}

```bash
yc compute instance create \
  --name my-inst3 \
  --metadata user-data="#ps1\nnet user Administrator Passw0rd" \
  --zone {{ region-id }}-a \
  --public-ip \
  --create-boot-disk image-folder-id=standard-images,image-name=windows-2016-gvlk-153

ERROR: rpc error: code = ResourceExhausted desc = The limit on maximum number of instances has exceeded.

server-request-id: 9d42710c-4a14-4561-a491-1f3bf76dbaaa
client-request-id: e69f4463-b9de-45bc-89b3-4db6e4d1bae6
client-trace-id: ddd8c763-81a3-4c58-9a7d-445257b59aee

Use server-request-id, client-request-id, client-trace-id for investigation of issues in cloud support
If you are going to ask for help of cloud support, please send the following trace file: C:\Users\username\yandex-cloud\logs\yc_compute_instance_create-2019-02-18T12-26-39.897.txt
```

#### How do I get operation error details? {#operation-error-details}

If the CLI outputs the operation ID, request information about the operation:

```bash
yc operation get <operation_ID>
```

The operation info may describe the cause of the error in more detail.

#### How do I contact support? {#what-to-do}

To help our support team solve your problem faster, from the error message:
1. Copy all available **IDs**. In our example, they are `server-request-id`, `client-request-id`, and `client-trace-id`.
1. Copy the **trace file** that was saved to your PC. See the path to the trace file at the end of the error message.
In our example, it is:

    ```text
    C:\Users\username\yandex-cloud\logs\yc_compute_instance_create-2019-02-18T12-26-39.897.txt
    ```

1. Provide this information to the [technical support team]({{ link-console-support }}).

#### Resource not found when accessed by name {#name-not-found}

If you get an error when accessing a resource by name:

```text
ERROR: ... not found
```

or

```text
ERROR: rpc error: code = NotFound ...
```

The resource is most likely not in the default folder of the current CLI profile.

To fix this issue, explicitly specify the folder using the `--folder-id` or `--folder-name` parameter:

```bash
yc <service> <resource> get <resource_name> --folder-id <folder_ID>
```

Example for a VM:

```bash
yc compute instance get my-vm --folder-id b1g5bhjofg7o********
```

If you work with this folder regularly, make it your default folder.

```bash
yc config set folder-id <folder_ID>
```

If using the resource ID, there is no need to specify the folder because their IDs are unique.

#### How do I use the CLI via a proxy server? {#proxy}

{% include [cli-proxy-setup](../_includes/cli/cli-proxy-setup.md) %}

#### Invalid token {#invalid-token}

When running a CLI command, you may get an invalid token error, e.g.:

```text
ERROR: Unable to list clouds: rpc error: code = Unauthenticated desc = UNAUTHENTICATED: The token is invalid
```

Regardless of the [profile](./operations/profile/profile-create.md) type, CLI authentication in {{ yandex-cloud }} is performed using an [IAM token](../iam/concepts/authorization/iam-token.md). The CLI uses the following methods to get it:
* From the browser.
* In exchange for an [authorized key](../iam/concepts/authorization/key.md).
* Directly from the `YC_IAM_TOKEN` environment variable.

The error means that the IAM token is invalid, e.g., due to being expired or revoked.

[Re-authenticate](./operations/index.md#auth) to the CLI.

Also bear in mind that providing an IAM token into the `export YC_IAM_TOKEN=<IAM_token_value>` environment variable overrides the authentication parameters set for other authentication types.

#### Error when authenticating on a server without a GUI or browser {#federated-auth-without-gui}

{% include [federated-auth-without-gui](../_includes/cli/federated-auth-without-gui.md) %}


### Useful links {#see-also}

* [{#T}](../overview/concepts/console-syntax-guide.md)
* [{#T}](../overview/concepts/interfaces.md)
* [{#T}](../support/overview.md)

