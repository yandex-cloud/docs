# Running commands

CLI commands are divided into groups, each of which corresponds to a Yandex.Cloud service or component.

{% note info %}

To open Help for a certain command, specify the `--help` global flag.

{% endnote %}

## Managing the CLI configuration

Use one of the following to set or change the values of the CLI configuration parameters before executing a certain command:

- Profiles: they store the value of a parameter (or a set of parameters), which is used when running each command.

    You can create multiple profiles and switch between them as necessary or perform a single call of a command with a set of parameters from another profile by specifying the `--profile` global flag.

    For more information about managing profiles, see [Profiles](profile.md).

- Global flags: they only define parameters once when a command is called. Global flags are available for any command at any nesting level.

For a full list of available configuration parameters, see [CLI configuration](core-propreties.md).

## Synchronous/asynchronous command execution

Some commands take a long time to execute. In this case, you can control the timing of command execution.
While a command is running, the CLI displays dots in synchronous mode and immediately provides information about the operation in asynchronous mode. For more information about synchronization, see [Synchronous and asynchronous modes of command execution](mode.md).

