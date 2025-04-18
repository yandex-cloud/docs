If you do not have the {{ TR }} CLI yet, install it using the [guide on the official {{ TR }} website](https://trino.io/docs/current/client/cli.html#installation).

To connect to an {{ mtr-name }} cluster:

1. Create an [IAM token](../../iam/concepts/authorization/iam-token.md) and put it to the `TRINO_PASSWORD` environment variable:

   ```bash
   export TRINO_PASSWORD=$(yc iam create-token)
   ```

   This IAM token in `TRINO_PASSWORD` will be your password to the {{ mtr-name }} cluster. To enable it, specify the `--password` flag upon connection.

1. Connect to the {{ mtr-name }} cluster:

   ```bash
   ./trino <coordinator_URL> --user iam --password
   ```

   You can copy the coordinator URL and paste it to the **{{ ui-key.yacloud.trino.overview.title_resource-coordinator }}** field on the {{ TR }} overview page in the [management console]({{ link-console-main }}).
