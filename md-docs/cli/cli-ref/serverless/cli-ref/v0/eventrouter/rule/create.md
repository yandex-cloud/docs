[Документация Yandex Cloud](../../../../../../../index.md) > [Интерфейс командной строки](../../../../../../index.md) > [Справочник (англ.)](../../../../../index.md) > [serverless](../../../index.md) > [v0](../../index.md) > [eventrouter](../index.md) > [rule](index.md) > create

# yc serverless v0 eventrouter rule create

Create a rule

#### Command Usage

Syntax:

`yc serverless v0 eventrouter rule create <RULE-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--bus-id` | `string`

Rule bus id. ||
|| `--name` | `string`

Rule name. ||
|| `--description` | `string`

Rule description. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--deletion-protection` | Prevents accidental rule removal. ||
|| `--filter` | `string`

JQ filter for matching events. ||
|| `--yds-target` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Yds target.

Possible property names:

- `transformer`: JQ string inrerpolation expression for changing event format.

- `retry-attempts`: Maximum number of retries (extra calls) before an action fails.

- `maximum-age`: Maximum number of retries (extra calls) before an action fails.

- `dlq-arn`: Dead letter queue id of the target, e.g. yrn:yc:ymq:ru-central1:aoe***:dlq.

- `dlq-service-account-id`: Service account which has write permission on the dead letter queue.

- `database`: Stream database. Example: /ru-central1/aoegtvhtp8ob********/cc8004q4lbo6********

- `stream-name`: Stream name, absolute or relative.

- `service-account-id`: Service account which has write permission on the stream. ||
|| `--ymq-target` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Ymq target.

Possible property names:

- `transformer`: JQ string inrerpolation expression for changing event format.

- `retry-attempts`: Maximum number of retries (extra calls) before an action fails.

- `maximum-age`: Maximum number of retries (extra calls) before an action fails.

- `dlq-arn`: Dead letter queue id of the target, e.g. yrn:yc:ymq:ru-central1:aoe***:dlq.

- `dlq-service-account-id`: Service account which has write permission on the dead letter queue.

- `queue-arn`: Queue ARN. Example: yrn:yc:ymq:ru-central1:aoe***:test

- `service-account-id`: Service account which has write permission on the queue. ||
|| `--function-target` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Function target.

Possible property names:

- `transformer`: JQ string inrerpolation expression for changing event format.

- `retry-attempts`: Maximum number of retries (extra calls) before an action fails.

- `maximum-age`: Maximum number of retries (extra calls) before an action fails.

- `dlq-arn`: Dead letter queue id of the target, e.g. yrn:yc:ymq:ru-central1:aoe***:dlq.

- `dlq-service-account-id`: Service account which has write permission on the dead letter queue.

- `max-count`: Maximum batch size: rule will send a batch if number of events exceeds this value.

- `max-bytes`: Maximum batch size: rule will send a batch if total size of events exceeds this value.

- `cutoff`: Rule will send a batch if its lifetime exceeds this value.

- `function-id`: Function id.

- `function-tag`: Function tag.

- `service-account-id`: Service account which has call permission on the function, optional. ||
|| `--container-target` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Container target.

Possible property names:

- `transformer`: JQ string inrerpolation expression for changing event format.

- `retry-attempts`: Maximum number of retries (extra calls) before an action fails.

- `maximum-age`: Maximum number of retries (extra calls) before an action fails.

- `dlq-arn`: Dead letter queue id of the target, e.g. yrn:yc:ymq:ru-central1:aoe***:dlq.

- `dlq-service-account-id`: Service account which has write permission on the dead letter queue.

- `max-count`: Maximum batch size: rule will send a batch if number of events exceeds this value.

- `max-bytes`: Maximum batch size: rule will send a batch if total size of events exceeds this value.

- `cutoff`: Rule will send a batch if its lifetime exceeds this value.

- `container-id`: Container id.

- `container-revision-id`: Container revision id.

- `path`: Container path.

- `service-account-id`: Service account which has call permission on the function, optional. ||
|| `--gateway-websocket-broadcast-target` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Gateway websocket broadcast target.

Possible property names:

- `transformer`: JQ string inrerpolation expression for changing event format.

- `retry-attempts`: Maximum number of retries (extra calls) before an action fails.

- `maximum-age`: Maximum number of retries (extra calls) before an action fails.

- `dlq-arn`: Dead letter queue id of the target, e.g. yrn:yc:ymq:ru-central1:aoe***:dlq.

- `dlq-service-account-id`: Service account which has write permission on the dead letter queue.

- `max-count`: Maximum batch size: rule will send a batch if number of events exceeds this value.

- `max-bytes`: Maximum batch size: rule will send a batch if total size of events exceeds this value.

- `cutoff`: Rule will send a batch if its lifetime exceeds this value.

- `gateway-id`: Gateway id.

- `path`: Broadcast path.

- `service-account-id`: Service account which has permission for writing to websockets. ||
|| `--logging-target` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Logging target.

Possible property names:

- `transformer`: JQ string inrerpolation expression for changing event format.

- `retry-attempts`: Maximum number of retries (extra calls) before an action fails.

- `maximum-age`: Maximum number of retries (extra calls) before an action fails.

- `dlq-arn`: Dead letter queue id of the target, e.g. yrn:yc:ymq:ru-central1:aoe***:dlq.

- `dlq-service-account-id`: Service account which has write permission on the dead letter queue.

- `log-group-id`: Logging group id to write to, optional. If not specified, default log group is assumed.

- `service-account-id`: Service account which has write permission on the log gorup. ||
|| `--workflow-target` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Workflow target.

Possible property names:

- `transformer`: JQ string inrerpolation expression for changing event format.

- `retry-attempts`: Maximum number of retries (extra calls) before an action fails.

- `maximum-age`: Maximum number of retries (extra calls) before an action fails.

- `dlq-arn`: Dead letter queue id of the target, e.g. yrn:yc:ymq:ru-central1:aoe***:dlq.

- `dlq-service-account-id`: Service account which has write permission on the dead letter queue.

- `max-count`: Maximum batch size: rule will send a batch if number of events exceeds this value.

- `max-bytes`: Maximum batch size: rule will send a batch if total size of events exceeds this value.

- `cutoff`: Rule will send a batch if its lifetime exceeds this value.

- `workflow-id`: Workflow id.

- `service-account-id`: Service account which has permission to start workflow. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#