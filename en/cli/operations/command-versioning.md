# Working with CLI command versions 

{% include [command-ver-intro](../../_includes/cli/command-ver-intro.md) %}

## Getting info on available versions {#get-versions}

If the service supports multiple command versions, there is a separate branch with version number available for each one of them.

To learn about available versions and which one is used in the main branch, run this command:

```bash
yc <service_name> --help
```

Here is an example:

```bash
yc baremetal --help
```

Result:

```text
Command tree v1 (new CLI interface) is the default. Run `yc baremetal v1 <command>`.
Legacy command tree v0 is also available: `yc baremetal v0 <command>`.
Set `services.baremetal.version: v0` or `services.baremetal.version: v1` in your profile to change the default.
```

The same information is also provided on the overview page of the relevant service in the CLI reference, e.g., [yc baremetal](../cli-ref/baremetal/cli-ref/index.md) or [yc smartwebsecurity](../cli-ref/smartwebsecurity/cli-ref/index.md).

## Using a specific version {#use-version}

To use a specific version, specify it after the service name in the command:

```bash
yc <service_name> v<version_number> <command>
```

Here is an example:

```bash
yc baremetal v0 server list
```

## Changing the main branch version {#default-version}

To override the main branch version for a selected CLI profile, run this command:

```bash
yc config set services.<service_name>.version v<version_number>
```

Here is an example:

```bash
yc config set services.smartwebsecurity.version v0
```

#### Useful links

* [CLI reference](../cli-ref/index.md)
* [{#T}](../release-notes.md)
* [{#T}](./profile/manage-properties.md)
