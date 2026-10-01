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

- `bus_id` (*Read-Only*) (String). ID of the bus that the connector belongs to
- `cloud_id` (*Read-Only*) (String). ID of the cloud that the connector resides in
- `connector_id` (String). ID of the connector
- `created_at` (*Read-Only*) (String). Creation timestamp
- `deletion_protection` (*Read-Only*) (Bool). Deletion protection
- `description` (*Read-Only*) (String). Description of the connector
- `folder_id` (*Read-Only*) (String). ID of the folder that the connector resides in
- `id` (String). 
- `labels` (*Read-Only*) (Map Of String). Connector labels
- `name` (String). Name of the connector
- `timer` (*Read-Only*) (List Of Object). Timer source of the connector.
  - `cron_expression` . 
  - `payload` . 
  - `timezone` . 
- `yds` (*Read-Only*) (List Of Object). Data Stream source of the connector.
  - `consumer` . 
  - `database` . 
  - `service_account_id` . 
  - `stream_name` . 
- `ymq` (*Read-Only*) (List Of Object). Message Queue source of the connector.
  - `batch_size` . 
  - `polling_timeout` . 
  - `queue_arn` . 
  - `service_account_id` . 
  - `visibility_timeout` .


