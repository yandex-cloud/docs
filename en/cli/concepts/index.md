# Running commands

CLI commands are grouped by {{ yandex-cloud }} service or component.

{% note info %}

To open Help for a certain command, specify the `--help` global flag.

{% endnote %}

## Managing a CLI configuration {#manage-properties}

Use one of the following to set or change the values of the CLI configuration parameters before executing a command:

- Profiles: These store the value of a parameter (or a set of parameters) to use when running each command.

   You can create multiple profiles and switch between them as needed or run a command once using a set of parameters from another profile by specifying the global `--profile` flag.

   For more information about profile management, see the [step-by-step instructions](../operations/index.md#profile).
- Global flags: These only define parameters once when a command is called. Global flags are available for any command at any nesting level.

For a full list of available configuration parameters, see [CLI configuration](core-properties.md).

## Synchronous command execution {#sync-invoke}

Some commands take a long time to execute. In this case, you can control the timing of command execution.
While a command is running, the CLI displays dots in synchronous mode and immediately provides information about the operation in asynchronous mode. For more information about synchronization, see [Synchronous and asynchronous modes of command execution](mode.md).

## Connecting to a proxy server {#cli-via-proxy}

The CLI can send requests to {{ yandex-cloud }} through a proxy server. To do this, you need to create an environment variable called `HTTPS_PROXY` which the CLI will read for connection parameters. In the variable, specify:

* Login and a password if authentication is required to connect.
* Proxy server domain name or IP address.
* Port to connect to.

{% note info %}

If the password contains special characters, replace them with hexadecimal ASCII codes. For example, if the password contains the `@` character, use `%40`.

{% endnote %}

{% list tabs %}

- Linux and macOS

   To create the `HTTPS_PROXY` environment variable, run the command below:

   ```bash
   export HTTPS_PROXY="https://user:password@hostname:port"
   ```

   To disable traffic routing through the proxy server, clear `HTTPS_PROXY`:

   ```bash
   unset HTTPS_PROXY
   ```

- Windows (PowerShell)

   To create the `HTTPS_PROXY` environment variable, run the command below:

   ```
   $Env:HTTPS_PROXY = "https://user:password@hostname:port"
   ```

   To disable traffic routing through the proxy server, restart the shell or clear `HTTPS_PROXY` using the command below:

   ```
   $Env:HTTPS_PROXY = ""
   ```

- Windows (cmd)

   To create the `HTTPS_PROXY` environment variable, run the command below:

   ```
   set HTTPS_PROXY=https://user:password@hostname:port
   ```

   To disable traffic routing through the proxy server, restart the shell or clear `HTTPS_PROXY` using the command below:

   ```
   set HTTPS_PROXY=
   ```

{% endlist %}
