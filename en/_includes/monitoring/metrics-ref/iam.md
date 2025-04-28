The `name` label contains the metric name.

Labels shared by all {{ iam-name }} metrics:

| Label | Value |
| --- | --- |
| service | Service ID: `iam` |
| key_id | [Key](../../../iam/concepts/index.md#keys) ID |
| service_account | [Service account](../../../iam/concepts/users/service-accounts.md) ID |

Service metrics:

| Metric name<br>Type, units | Description<br>Labels |
| --- | --- |
| `service_account.access_key.authentication_events_count`<br>`COUNTER`, count | Number of authentication events using the service account's static access key |
| `service_account.api_key.authentication_events_count`<br>`COUNTER`, count | Number of authentication events using the service account's API key |
| `service_account.api_key.authentication_failed_events_count`<br>`COUNTER`, count | Number of failed authentication events using the service account's API key<br>This metric features the `code` label containing the error code. |
| `service_account.authorized_key.authentication_events_count`<br>`COUNTER`, count | Number of authentication events using the service account's authorized key |
| `service_account.authorized_key.create_token_events_count`<br>`COUNTER`, count | Number of token creation events using the service account's authorized key |
| `service_account.authorized_key.create_token_failed_events_count`<br>`COUNTER`, count | Number of failed token creation events using the service account's authorized key<br>This metric features the `code` label containing the error code. |