The name of the metric is written to the `name` label.

Common labels for all {{ iam-name }} metrics:

| Label | Value |
| --- | --- |
| service | Service ID: `iam` |
| key_id | [Key](../../../iam/concepts/index.md#keys) ID |
| service_account | [Service account](../../../iam/concepts/users/service-accounts.md) ID |

Service metrics:

| Metric name<br>Type, units | Description<br>Labels |
| --- | --- |
| `service_account.access_key.authentication_events_count`<br>`COUNTER`, number | Number of authentication events using the service account's static access key |
| `service_account.api_key.authentication_events_count`<br>`COUNTER`, number | Number of authentication events using the service account's API key |
| `service_account.api_key.authentication_failed_events_count`<br>`COUNTER`, number | Number of failed authentication events using the service account's API key<br>`code` label: error code |
| `service_account.authorized_key.authentication_events_count`<br>`COUNTER`, number | Number of authentication events using the service account's authorized key |
| `service_account.authorized_key.create_token_events_count`<br>`COUNTER`, number | Number of token creation events using the service account's authorized key |
| `service_account.authorized_key.create_token_failed_events_count`<br>`COUNTER`, number | Number of failed token creation events using the service account's authorized key<br>`code` label: error code |