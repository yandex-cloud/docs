To quickly release new service functionality and provide broader coverage of public API calls, the {{ yandex-cloud }} CLI is gradually introducing a new approach to generating command trees directly from the public gRPC API [proto specifications](https://github.com/yandex-cloud/cloudapi/tree/master/yandex/cloud).

With the new approach in place, new commands and their parameters are not always the same as the previous ones. For backward compatibility, versioning of service command trees has been implemented. 

In each group of service commands, e.g., `yc compute`, the _main command branch_ remains as before: `yc compute [ instance | image | disk | ... ]`, but branches _with command version numbers_ are also added, e.g., `yc compute v0 [ instance | image | disk | ... ]`.

The main branch of commands must match one of the versions. If there is only one version, the main branch completely duplicates it.

The information on adding or removing a command version, as well as on switching the main branch to another version, is published in [{#T}](../../cli/release-notes.md).

{% note tip %}

Use the current version of the CLI and the command tree the service has assigned as the main one. If CLI commands are called from scripts, CI/CD, or other automated processes, first check command compatibility when migrating to a new CLI version. While the legacy version of the commands is available, you can [explicitly state it in specific commands](../../cli/operations/command-versioning.md#use-version) or [set it as the default version](../../cli/operations/command-versioning.md#default-version).

{% endnote %}