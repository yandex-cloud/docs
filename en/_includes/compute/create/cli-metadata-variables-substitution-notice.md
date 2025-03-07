{% note info %}

The commands [`yc compute instance create`](../../../cli/cli-ref/compute/cli-ref/instance/create.md) | [`create-with-container`](../../../cli/cli-ref/compute/cli-ref/instance/create-with-container.md) | [`update`](../../../cli/cli-ref/compute/cli-ref/instance/update.md) | [`add-metadata`](../../../cli/cli-ref/compute/cli-ref/instance/add-metadata.md) support substitution of environment variable values into VM metadata. When you execute a {{ yandex-cloud }} CLI command, these values, specified in the `user-data` key in `$<variable_name>` format, will be substituted into the VM metadata from the environment variables of the environment the command is executed in. 

To change such behavior, i.e. to provide a variable name to the VM metadata in `$<variable_name>` format rather than take the variable value from the CLI command runtime environment, use the two-dollar syntax, e.g., `$$<variable_name>`.

For more information, see [{#T}](../../../compute/concepts/metadata/sending-metadata.md#environment-variables).

{% endnote %}