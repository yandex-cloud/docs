---
subcategory: Serverless Event Router
---

# yandex_serverless_eventrouter_connector (DataSource)



## Example usage

```terraform
//
// TBD
//
```

## Arguments & Attributes Reference

- `bus_id` (**Required**)(String). ID of the bus that the connector belongs to
- `cloud_id` (*Read-Only*) (String). ID of the cloud that the connector resides in
- `connector_id` (String). ID of the connector
- `created_at` (*Read-Only*) (String). Creation timestamp
- `deletion_protection` (Bool). Deletion protection
- `description` (String). Description of the connector
- `folder_id` (*Read-Only*) (String). ID of the folder that the connector resides in
- `id` (String). 
- `labels` (Map Of String). Connector labels
- `name` (**Required**)(String). Name of the connector
- `timer` [Block]. Timer source of the connector
  - `cron_expression` (**Required**)(String). Cron expression. Cron expression with seconds. Example: 0 45 16 ? * *
  - `payload` (String). Payload to be passed to bus
  - `timezone` (String). Timezone in tz database format. Example: Europe/Moscow
- `yds` [Block]. Data Stream source of the connector
  - `consumer` (**Required**)(String). Consumer name
  - `database` (**Required**)(String). Stream database
  - `service_account_id` (**Required**)(String). Service account which has read permission on the stream
  - `stream_name` (**Required**)(String). Stream name, absolute or relative
- `ymq` [Block]. Message Queue source of the connector
  - `batch_size` (Number). Batch size for polling
  - `polling_timeout` (String). Queue polling timeout
  - `queue_arn` (**Required**)(String). Queue ARN. Example: yrn:yc:ymq:ru-central1:aoe***:test
  - `service_account_id` (**Required**)(String). Service account which has read access to the queue
  - `visibility_timeout` (String). Queue visibility timeout override


