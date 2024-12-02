---
editable: false
---

# yc serverless eventrouter rule update

Update the specified rule

#### Command Usage

Syntax: 

`yc serverless eventrouter rule update <RULE-NAME>|<RULE-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Rule id.|
|`--name`|<b>`string`</b><br/>Rule name.|
|`--new-name`|<b>`string`</b><br/>New rule name.|
|`--description`|<b>`string`</b><br/>Rule description.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'.|
|`--yds-target`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Yds target.<br/><br/>Possible property names:<br/><ul> <li><code>transformer</code>:     JQ string inrerpolation expression for changing event format.</li> <li><code>retry-attempts</code>:     Maximum number of retries (extra calls) before an action fails.</li> <li><code>maximum-age</code>:     Maximum number of retries (extra calls) before an action fails.</li> <li><code>dlq-arn</code>:     Dead letter queue id of the target, e.g. yrn:yc:ymq:ru-central1:aoe***:dlq.</li> <li><code>dlq-service-account-id</code>:     Service account which has write permission on the dead letter queue.</li> <li><code>database</code>:     Stream database. Example: /ru-central1/aoegtvhtp8ob********/cc8004q4lbo6********</li> <li><code>stream-name</code>:     Stream name, absolute or relative.</li> <li><code>service-account-id</code>:     Service account which has write permission on the stream.</li> </ul>|
|`--ymq-target`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Ymq target.<br/><br/>Possible property names:<br/><ul> <li><code>transformer</code>:     JQ string inrerpolation expression for changing event format.</li> <li><code>retry-attempts</code>:     Maximum number of retries (extra calls) before an action fails.</li> <li><code>maximum-age</code>:     Maximum number of retries (extra calls) before an action fails.</li> <li><code>dlq-arn</code>:     Dead letter queue id of the target, e.g. yrn:yc:ymq:ru-central1:aoe***:dlq.</li> <li><code>dlq-service-account-id</code>:     Service account which has write permission on the dead letter queue.</li> <li><code>queue-arn</code>:     Queue ARN. Example: yrn:yc:ymq:ru-central1:aoe***:test</li> <li><code>service-account-id</code>:     Service account which has write permission on the queue.</li> </ul>|
|`--function-target`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Function target.<br/><br/>Possible property names:<br/><ul> <li><code>transformer</code>:     JQ string inrerpolation expression for changing event format.</li> <li><code>retry-attempts</code>:     Maximum number of retries (extra calls) before an action fails.</li> <li><code>maximum-age</code>:     Maximum number of retries (extra calls) before an action fails.</li> <li><code>dlq-arn</code>:     Dead letter queue id of the target, e.g. yrn:yc:ymq:ru-central1:aoe***:dlq.</li> <li><code>dlq-service-account-id</code>:     Service account which has write permission on the dead letter queue.</li> <li><code>max-count</code>:     Maximum batch size: rule will send a batch if number of events exceeds this value.</li> <li><code>max-bytes</code>:     Maximum batch size: rule will send a batch if total size of events exceeds this value.</li> <li><code>cutoff</code>:     Rule will send a batch if its lifetime exceeds this value.</li> <li><code>function-id</code>:     Function id.</li> <li><code>function-tag</code>:     Function tag.</li> <li><code>service-account-id</code>:     Service account which has call permission on the function, optional.</li> </ul>|
|`--container-target`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Container target.<br/><br/>Possible property names:<br/><ul> <li><code>transformer</code>:     JQ string inrerpolation expression for changing event format.</li> <li><code>retry-attempts</code>:     Maximum number of retries (extra calls) before an action fails.</li> <li><code>maximum-age</code>:     Maximum number of retries (extra calls) before an action fails.</li> <li><code>dlq-arn</code>:     Dead letter queue id of the target, e.g. yrn:yc:ymq:ru-central1:aoe***:dlq.</li> <li><code>dlq-service-account-id</code>:     Service account which has write permission on the dead letter queue.</li> <li><code>max-count</code>:     Maximum batch size: rule will send a batch if number of events exceeds this value.</li> <li><code>max-bytes</code>:     Maximum batch size: rule will send a batch if total size of events exceeds this value.</li> <li><code>cutoff</code>:     Rule will send a batch if its lifetime exceeds this value.</li> <li><code>container-id</code>:     Container id.</li> <li><code>container-revision-id</code>:     Container revision id.</li> <li><code>path</code>:     Container path.</li> <li><code>service-account-id</code>:     Service account which has call permission on the function, optional.</li> </ul>|
|`--gateway-websocket-broadcast-target`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Gateway websocket broadcast target.<br/><br/>Possible property names:<br/><ul> <li><code>transformer</code>:     JQ string inrerpolation expression for changing event format.</li> <li><code>retry-attempts</code>:     Maximum number of retries (extra calls) before an action fails.</li> <li><code>maximum-age</code>:     Maximum number of retries (extra calls) before an action fails.</li> <li><code>dlq-arn</code>:     Dead letter queue id of the target, e.g. yrn:yc:ymq:ru-central1:aoe***:dlq.</li> <li><code>dlq-service-account-id</code>:     Service account which has write permission on the dead letter queue.</li> <li><code>max-count</code>:     Maximum batch size: rule will send a batch if number of events exceeds this value.</li> <li><code>max-bytes</code>:     Maximum batch size: rule will send a batch if total size of events exceeds this value.</li> <li><code>cutoff</code>:     Rule will send a batch if its lifetime exceeds this value.</li> <li><code>gateway-id</code>:     Gateway id.</li> <li><code>path</code>:     Broadcast path.</li> <li><code>service-account-id</code>:     Service account which has permission for writing to websockets.</li> </ul>|
|`--logging-target`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Logging target.<br/><br/>Possible property names:<br/><ul> <li><code>transformer</code>:     JQ string inrerpolation expression for changing event format.</li> <li><code>retry-attempts</code>:     Maximum number of retries (extra calls) before an action fails.</li> <li><code>maximum-age</code>:     Maximum number of retries (extra calls) before an action fails.</li> <li><code>dlq-arn</code>:     Dead letter queue id of the target, e.g. yrn:yc:ymq:ru-central1:aoe***:dlq.</li> <li><code>dlq-service-account-id</code>:     Service account which has write permission on the dead letter queue.</li> <li><code>log-group-id</code>:     Logging group id to write to, optional. If not specified, default log group is assumed.</li> <li><code>service-account-id</code>:     Service account which has write permission on the log gorup.</li> </ul>|
|`--workflow-target`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Workflow target.<br/><br/>Possible property names:<br/><ul> <li><code>transformer</code>:     JQ string inrerpolation expression for changing event format.</li> <li><code>retry-attempts</code>:     Maximum number of retries (extra calls) before an action fails.</li> <li><code>maximum-age</code>:     Maximum number of retries (extra calls) before an action fails.</li> <li><code>dlq-arn</code>:     Dead letter queue id of the target, e.g. yrn:yc:ymq:ru-central1:aoe***:dlq.</li> <li><code>dlq-service-account-id</code>:     Service account which has write permission on the dead letter queue.</li> <li><code>max-count</code>:     Maximum batch size: rule will send a batch if number of events exceeds this value.</li> <li><code>max-bytes</code>:     Maximum batch size: rule will send a batch if total size of events exceeds this value.</li> <li><code>cutoff</code>:     Rule will send a batch if its lifetime exceeds this value.</li> <li><code>workflow-id</code>:     Workflow id.</li> <li><code>service-account-id</code>:     Service account which has permission to start workflow.</li> </ul>|
|`--deletion-protection`|Prevents accidental rule removal.|
|`--no-deletion-protection`|Remove rule deletion protection.|
|`-y`,`--yes`|Automatic yes to prompts.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
