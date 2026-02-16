{% include [cli-install](../../../_includes/cli-install.md) %}

{% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. View the description of the [CLI](../../../cli/) command to activate the service:

   ```bash
   yc backup provider activate --help
   ```

1. Activate the service in the default folder:

   ```bash
   yc backup provider activate --async
   ```

   Where `--async` displays the operation progress info. This is an optional parameter.

1. Once you execute the command, you will get the activation warning: `This command will activate backup provider for your folder. Do you confirm this action to be executed? [Yes/no][y/N]`. Confirm the activation by typing `yes` or `y` in the terminal.

   {% note tip %}

   Use the `--force` flag to activate the service without a confirmation.

   {% endnote %}

   Result:

   ```text
   id: cdgmnefxiatx********
   description: activate provider
   created_at: "2024-10-14T09:03:47.960564Z"
   created_by: ajec1gaqcmtr********
   modified_at: "2024-10-14T09:03:47.960564Z"
   done: true
   metadata:
     '@type': type.googleapis.com/yandex.cloud.backup.v1.ActivateProviderMetadata
     folder_id: b1go3el0d8fs********
   response:
     '@type': type.googleapis.com/google.protobuf.Empty
     value: {}
   ```

{% include [default-policies](../default-policies.md) %}

If you prefer not to create them, use the `--skip-default-policy` parameter.