Common labels for all {{ iam-name }} metrics:

| Label | Value |
| --- | --- |
| service | Service ID: `iam` |
| key_id | [Key](../../../iam/concepts/index.md#keys) ID |
| service_account | [Service account](../../../iam/concepts/users/service-accounts.md) ID |

Service metrics:

| Metric name<br>Type, units of measurement | Description<br>Labels |
| --- | --- |
| `service_account.access_key.authentication_events_count`<br>`COUNTER`, number | Number of authentication events using a static access key of the service account |
| `service_account.access_key.authentication_failed_events_count`<br>`COUNTER`, number | Number of failed authentication events using a static access key of the service account |
| `service_account.api_key.authentication_events_count`<br>`COUNTER`, number | Number of authentication events using an API key of the service account |
| `service_account.api_key.authentication_failed_events_count`<br>`COUNTER`, number | Number of failed authentication events using an API key of the service account |
| `service_account.authorized_key.authentication_events_count`<br>`COUNTER`, number | Number of authentication events using an authorized key of the service account |
| `service_account.authorized_key.authentication_failed_events_count`<br>`COUNTER`, number | Number of failed authentication events using an authorized key of the service account |
| `service_account.authorized_key.create_token_events_count`<br>`COUNTER`, number | Number of token creation events using an authorized key of the service account |
| `service_account.authorized_key.create_token_failed_events_count`<br>`COUNTER`, number | Number of failed token creation events using an authorized key of the service account |