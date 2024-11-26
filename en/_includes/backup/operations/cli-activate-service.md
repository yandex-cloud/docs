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