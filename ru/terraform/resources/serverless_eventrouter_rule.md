---
subcategory: Serverless Event Router
---

# yandex_serverless_eventrouter_rule (Resource)



## Example usage

```terraform
//
// TBD
//
```

## Arguments & Attributes Reference

- `bus_id` (**Required**)(String). ID of the bus that the rule belongs to
- `cloud_id` (*Read-Only*) (String). ID of the cloud that the rule resides in
- `created_at` (*Read-Only*) (String). Creation timestamp
- `deletion_protection` (*Read-Only*) (Bool). Deletion protection
- `description` (String). Description of the rule
- `folder_id` (*Read-Only*) (String). ID of the folder that the rule resides in
- `id` (String). 
- `jq_filter` (String). JQ filter for matching events
- `labels` (Map Of String). Rule labels
- `name` (**Required**)(String). Name of the rule
- `container` [Block]. ContainerTarget
  - `container_id` (**Required**)(String). Container ID
  - `container_revision_id` (String). Container revision ID
  - `path` (String). Endpoint HTTP path to invoke
  - `service_account_id` (String). Service account which should be used to call a container
  - `batch_settings` [Block]. Batch settings
    - `cutoff` (**Required**)(String). Maximum batch size: rule will send a batch if its lifetime exceeds this value
    - `max_bytes` (Number). Maximum batch size: rule will send a batch if total size of events exceeds this value
    - `max_count` (Number). Maximum batch size: rule will send a batch if number of events exceeds this value
- `function` [Block]. FunctionTarget
  - `function_id` (**Required**)(String). Function ID
  - `function_tag` (String). Function tag
  - `service_account_id` (String). Service account which has call permission on the function
  - `batch_settings` [Block]. Batch settings
    - `cutoff` (**Required**)(String). Maximum batch size: rule will send a batch if its lifetime exceeds this value
    - `max_bytes` (Number). Maximum batch size: rule will send a batch if total size of events exceeds this value
    - `max_count` (Number). Maximum batch size: rule will send a batch if number of events exceeds this value
- `gateway_websocket_broadcast` [Block]. GatewayWebsocketBroadcastTarget
  - `gateway_id` (**Required**)(String). Gateway ID
  - `path` (**Required**)(String). Path
  - `service_account_id` (**Required**)(String). Service account which has permission for writing to websockets
  - `batch_settings` [Block]. Batch settings
    - `cutoff` (**Required**)(String). Maximum batch size: rule will send a batch if its lifetime exceeds this value
    - `max_bytes` (Number). Maximum batch size: rule will send a batch if total size of events exceeds this value
    - `max_count` (Number). Maximum batch size: rule will send a batch if number of events exceeds this value
- `logging` [Block]. LoggingTarget. Includes either log_group_id or folder_id
  - `folder_id` (String). Folder ID
  - `log_group_id` (String). Log group ID
  - `service_account_id` (**Required**)(String). Service account which has permission for writing logs
- `workflow` [Block]. WorkflowTarget
  - `service_account_id` (**Required**)(String). Service account which should be used to start workflow
  - `workflow_id` (**Required**)(String). Workflow ID
  - `batch_settings` [Block]. Batch settings
    - `cutoff` (**Required**)(String). Maximum batch size: rule will send a batch if its lifetime exceeds this value
    - `max_bytes` (Number). Maximum batch size: rule will send a batch if total size of events exceeds this value
    - `max_count` (Number). Maximum batch size: rule will send a batch if number of events exceeds this value
- `yds` [Block]. YdsTarget
  - `database` (**Required**)(String). Stream database
  - `service_account_id` (**Required**)(String). Service account, which has write permission on the stream
  - `stream_name` (**Required**)(String). Full stream name, like /ru-central1/aoegtvhtp8ob********/cc8004q4lbo6********/test
- `ymq` [Block]. YmqTarget
  - `queue_arn` (**Required**)(String). Queue ARN. Example: yrn:yc:ymq:ru-central1:aoe***:test
  - `service_account_id` (**Required**)(String). Service account which has write access to the queue

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_serverless_eventrouter_rule.<resource Name> <resource Id>
terraform import yandex_serverless_eventrouter_rule.evr_rule ...
```
