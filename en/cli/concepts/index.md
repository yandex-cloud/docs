# Running commands

CLI commands are grouped by {{ yandex-cloud }} service or component.

{% note info %}

To get help information for a particular command, specify the `--help` global flag.

{% endnote %}

## Managing a CLI configuration {#manage-properties}

Use one of the following to set or change the values of the CLI configuration parameters before executing a command:

- Profiles: They store the value of a parameter (or multiple parameters) to use when running each command.

    You can create multiple profiles and switch between them as you need or run a command once using parameters from another profile by specifying the global `--profile` parameter.

    For more information about profile management, see the [step-by-step instructions](../operations/index.md#profile).
- Global parameters: They define properties only once when a command is called. Global parameters are available for any command at any nesting level.

For a full list of available configuration parameters, see [CLI configuration](core-properties.md).

## Synchronous command execution {#sync-invoke}

Some commands take a long time to execute. In this case, you can control the timing of command execution.
While a command is running, the CLI displays dots in synchronous mode and immediately provides information about the operation in asynchronous mode. For more information about synchronization, see [Synchronous and asynchronous modes of command execution](mode.md).

## Connecting to a proxy server {#cli-via-proxy}

The CLI can send requests to {{ yandex-cloud }} through a proxy server. To do this, you need to create the `HTTPS_PROXY` environment variable which the CLI will read for connection parameters. In the variable, specify:

* Login and a password if authentication is required to connect.
* Proxy server domain name or IP address.
* Port to connect to.

{% note info %}

If the password contains special characters, replace them with hexadecimal ASCII codes. For example, if the password contains the `@` character, use `%40`.

{% endnote %}

{% list tabs group=operating_system %}

- Linux/macOS {#linux-macos}

    To create the `HTTPS_PROXY` environment variable, run this command:

    ```bash
    export HTTPS_PROXY="https://user:password@hostname:port"
    ```

    To disable traffic routing through the proxy server, clear `HTTPS_PROXY`:

    ```bash
    unset HTTPS_PROXY
    ```

- Windows (PowerShell) {#windows-powershell}

    To create the `HTTPS_PROXY` environment variable, run this command:

    ```
    $Env:HTTPS_PROXY = "https://user:password@hostname:port"
    ```

    To disable traffic routing through the proxy server, restart the shell or clear `HTTPS_PROXY` using the command below:

    ```
    $Env:HTTPS_PROXY = ""
    ```

- Windows (cmd) {#windows-cmd}

    To create the `HTTPS_PROXY` environment variable, run this command:

    ```
    set HTTPS_PROXY=https://user:password@hostname:port
    ```

    To disable traffic routing through the proxy server, restart the shell or clear `HTTPS_PROXY` using the command below:

    ```
    set HTTPS_PROXY=
    ```

{% endlist %}
