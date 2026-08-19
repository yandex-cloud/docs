# Running the {{ yandex-cloud }} CLI commands

CLI commands are grouped by {{ yandex-cloud }} service or component.

{% note info %}

To get help information for a particular command, specify the `--help` global flag.

{% endnote %}

Commands are executed after authentication, and the token is then saved in the file system. You can also get the token from the `YC_IAM_TOKEN` environment variable regardless of whether or not you have a saved token.

## Providing multiple values for a single parameter {#multiple-values}

Some CLI parameters can take multiple values. Depending on the command, you can either provide a comma-separated list of values or specify them individually by repeating the parameter:

```bash
yc <command> \
  --<parameter> <value_1> \
  --<parameter> <value_2>
```

The supported method for providing values depends on the command and parameter. Before running a command, view its description:

```bash
yc <command> --help
```

### Examples {#multiple-values-examples}

When [creating a function version](../../functions/operations/function/environment-variables-add.md), you can provide each environment variable in a separate `--environment` parameter. For example, this method is useful if the variable value contains commas:

```bash
yc serverless function version create \
  --function-name my-function \
  --runtime python312 \
  --entrypoint main.handler \
  --source-path ./function.zip \
  --environment OPENSEARCH_HOSTS='["hostname1","hostname2","hostname3"]' \
  --environment OPENSEARCH_INDEX=index_v2
```

When [assigning roles for a certificate](../../certificate-manager/operations/cert-access.md), provide each binding individually by repeating the `--access-binding` parameter:

```bash
yc certificate-manager certificate set-access-bindings my-certificate \
  --access-binding role=editor,subject=userAccount:gfei8n54hmfh******** \
  --access-binding role=viewer,subject=userAccount:helj89sfj80a******** \
  --access-binding role=editor,subject=serviceAccount:ajel6l0jcb9s********
```

## Managing a CLI configuration {#manage-properties}

Use one of the following to set or change the values of the CLI configuration parameters before executing a command:

- Profiles: They store the value of a parameter (or multiple parameters) to use when running each command.

    You can create multiple profiles and switch between them as you need or run a command once using parameters from another profile by specifying the global `--profile` parameter.

    For more information about profile management, see the [step-by-step instructions](../operations/index.md#profile).

- Global parameters: They define properties only once when a command is called.
    
    Global parameters are available for any command at any nesting level, but not all commands can process them. For example, if a resource is defined only by an ID, the cloud and folder parameters are ignored.

For a full list of available configuration parameters, see [CLI configuration](core-properties.md).

### Accessing resources by name {#name-resolution}

In most CLI commands, you can use either the resource ID or resource name. If you access a resource by its name, the search will be limited to the default folder.

If the resource is in a different folder and you want to access it, specify the folder explicitly via a global parameter:

```bash
yc <command> <resource_name> --folder-id <folder_ID>
yc <command> <resource_name> --folder-name <folder_name>

# Examples
yc compute instance get testvm --folder-id b1g2doq3bh19********
yc lockbox payload get my-secret --folder-name testname
```

To find out the default folder:

```bash
yc config list
```

{% note tip %}

If using a resource ID, you do not need to specify the folder because their IDs are unique.

{% endnote %}

## Synchronous command execution {#sync-invoke}

Some commands take a long time to execute. In this case, you can control the timing of command execution.
While a command is running, the CLI displays dots in synchronous mode and immediately provides information about the operation in asynchronous mode. For more information about synchronization, see [Synchronous and asynchronous modes of command execution](mode.md).

## Connecting to a proxy server {#cli-via-proxy}

The CLI can send requests to {{ yandex-cloud }} through a proxy server. To do this, you need to create the `HTTPS_PROXY` environment variable which the CLI will read for connection parameters. In the variable, specify:

* Login and a password if authentication is required to connect.
* Proxy server domain name or IP address.
* Port to connect to.

{% note tip %}

In the proxy server URL, specify the protocol used by the proxy server for incoming connections. If you do not know the protocol, contact your administrator. For more information about supported protocols, see [this net/http package guide](https://pkg.go.dev/net/http#Transport.Proxy).

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

## Command versioning {#versioning}

{% include [command-ver-intro](../../_includes/cli/command-ver-intro.md) %}

For more information, see [{#T}](../operations/command-versioning.md).


#### Useful links {#see-also}

[{#T}](../../overview/concepts/console-syntax-guide.md)

