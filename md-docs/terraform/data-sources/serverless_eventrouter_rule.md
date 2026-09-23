[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Serverless Event Router > Data Sources > serverless_eventrouter_rule

# yandex_serverless_eventrouter_rule (DataSource)



## Example usage

```terraform
//
// TBD
//
```

## Arguments & Attributes Reference

- `bus_id` (*Read-Only*) (String). ID of the bus that the rule belongs to
- `cloud_id` (*Read-Only*) (String). ID of the cloud that the rule resides in
- `container` (*Read-Only*) (List Of Object). ContainerTarget
  - `batch_settings` . 
  - `container_id` . 
  - `container_revision_id` . 
  - `path` . 
  - `service_account_id` . 
- `created_at` (*Read-Only*) (String). Creation timestamp
- `deletion_protection` (*Read-Only*) (Bool). Deletion protection
- `description` (*Read-Only*) (String). Description of the rule
- `folder_id` (*Read-Only*) (String). ID of the folder that the rule resides in
- `function` (*Read-Only*) (List Of Object). FunctionTarget
  - `batch_settings` . 
    - `cutoff` . 
    - `max_bytes` . 
    - `max_count` . 
  - `function_id` . 
  - `function_tag` . 
  - `service_account_id` . 
- `gateway_websocket_broadcast` (*Read-Only*) (List Of Object). GatewayWebsocketBroadcastTarget
  - `batch_settings` . 
  - `gateway_id` . 
  - `path` . 
  - `service_account_id` . 
- `id` (String). 
- `jq_filter` (*Read-Only*) (String). JQ filter for matching events
- `labels` (*Read-Only*) (Map Of String). Rule labels
- `logging` (*Read-Only*) (List Of Object). LoggingTarget. Includes either log_group_id or folder_id
  - `folder_id` . 
  - `log_group_id` . 
  - `service_account_id` . 
- `name` (String). Name of the rule
- `rule_id` (String). ID of the bus that the rule belongs to
- `workflow` (*Read-Only*) (List Of Object). WorkflowTarget
  - `batch_settings` . 
  - `service_account_id` . 
  - `workflow_id` . 
- `yds` (*Read-Only*) (List Of Object). YdsTarget
  - `database` . 
  - `service_account_id` . 
  - `stream_name` . 
- `ymq` (*Read-Only*) (List Of Object). YmqTarget
  - `queue_arn` . 
  - `service_account_id` .