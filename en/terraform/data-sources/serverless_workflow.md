---
subcategory: Serverless Workflows
---

# yandex_serverless_workflow (DataSource)




## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). Creation timestamp for the Workflow.
- `description` (String). Description of the Workflow.
- `execution_url` (*Read-Only*) (String). Execution URL of the Workflow.
- `express` (Bool). Express execution mode.
- `folder_id` (String). ID of the folder that the Workflow belongs to.
- `id` (String). ID of the Workflow.
- `is_public` (Bool). Ability of the Workflow to be executed without authentication.
- `labels` (Map Of String). Workflow labels as `key:value` pairs.
- `log_options` [Block]. Options for logging from the Workflow.
  - `disabled` (Bool). Is logging from Workflow disabled.
  - `folder_id` (String). ID of the folder which default logging group should be used for Workflows.
  - `log_group_id` (String). ID of the logging group which should be used for Workflows logs.
  - `min_level` (String). Minimum logs level.
 See [LogLevel.Level] for details.
- `name` (**Required**)(String). Name of the Workflow. The name is unique within the folder.
- `network_id` (String). ID of the VPC network Workflow will be executed in, in order to access private resources.
- `schedule` [Block]. Workflow schedule settings.
  - `cron_expression` (**Required**)(String). Cron expression for the Workflow schedule.
  - `timezone` (**Required**)(String). Timezone for the Workflow schedule.
- `service_account_id` (String). ID of the Service Account which will be used for resource access in Workflow execution.
- `specification` [Block]. Specification of the Workflow
  - `spec_yaml` (String). Workflow specification in YAML format.
- `status` (*Read-Only*) (String). Status of the Workflow.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
- `workflow_id` (String). ID of the Workflow.


