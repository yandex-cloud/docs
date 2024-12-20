---
title: YaWL specification in {{ sw-full-name }}
description: This article describes the YaWL specification in {{ sw-name }}.
keywords:
  - workflows
  - workflow
  - WF
  - workflow
  - YaWL specification
---

# YaWL specification

## Workflow {#workflow}

For the workflow JSON schema, visit our [GitHub repo](https://raw.githubusercontent.com/yandex-cloud/json-schema-store/refs/heads/master/serverless/workflows/yawl.json).

Field name | Type | Required | Description
--- | --- | --- | ---
`yawl` | `string` | Yes | Specification language version. Possible values: `1.0`.
`start` | `string` | Yes | ID of the [step](#step) to start off the workflow execution.
`defaultRetryPolicy` | [RetryPolicy](#RetryPolicy) | No | Retry policy applied by default to any step throwing an error during execution.
`steps` | `map<string, Step>` | Yes | Description of workflow steps. Object where key is the step ID selected by the user, and value is the object describing the step parameters.

## Step object {#Step}

Field name | Type | Required | Description
--- | --- | --- | ---
`title` | `string` | No | Step name.
`description` | `string` | No | Step description.
`<step_type>` | string([FunctionCall](#FunctionCall)\|<br/>[ContainerCall](#ContainerCall)\|<br/>[HTTPCall](#HTTPCall)\|<br/>[GRPCCall](#GRPCCall)\|<br/>[YDBDocument](#YDBDocument)\|<br/>[YDS](#YDS)\|<br/>[YMQ](#YMQ)\|<br/>[FoundationModelsCall](#FoundationModelsCall)\|<br/>[ObjectStorage](#ObjectStorage)\|<br/>[Tracker](#Tracker)\|<br/>[Postbox](#Postbox)\|<br/>[Switch](#Switch)\|<br/>[Foreach](#Foreach)\|<br/>[Parallel](#Parallel)\|<br/>[Success](#Success)\|<br/>[Fail](#Fail)\|<br/>[NoOp](#NoOp)) | Yes | Step specification. Possible parameters depend on selected `<step_type>`.

## Integration steps {#integration-steps}

### Common fields {#common}

The fields described herein are available for all integration steps.

Field name | Type | Required | Default value | Description
--- | --- | --- | --- | ---
`input` | `string` | No | [Overall state of the workflow](workflow.md#state) | A jq expression to filter the workflow state fed into the step.
`output` | `string` | No | Step outputs | A jq expression to filter the step outputs added into the workflow state.
`next` | `string` | No | No | ID of the next step.
`retryPolicy` | [RetryPolicy](#retry-policy) | No | `defaultRetryPolicy`, if set on the [workflow](#workflow) level | Retry policy applied if a step throws an error during execution.
`timeout` | `Duration` | No | 15 minutes | Maximum step execution time.

#### RetryPolicy object {#RetryPolicy}

Field name | Type | Required | Default value | Description
--- | --- | --- | --- | ---
`errorList` | `WorkflowError[]` | Yes | `[]` | List of errors for which the step will be retried. For more information, see [{#T}](execution.md#errors).
`errorListMode` | `INCLUDE/EXCLUDE` | No | `INCLUDE` | Error selection mode: `INCLUDE` to retry on errors listed in `error_list`; `EXCLUDE` to retry on any error other than those listed in `error_list`.
`initialDelay` | `Duration` | No | `1s` | Initial value for a delay between retries.
`backoffRate` | `double` | No | `1.0` | Multiplier for time between each next retry.
`retryCount` | `int` | No | `0` | Maximum number of retries.
`maxDelay` | `Duration` | No | `1s` | Maximum delay between retries.

### HTTPCall {#HTTPCall}

HTTP call to a specified endpoint.

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`url` | `string` | Yes | No | Yes | Request URL.
`method` | `enum` | No | `GET` | No | Request method.
`body` | `string` | No | `""` | Yes | Request body.
`headers` | `map<string, string>` | No | `{}` | Yes: in header values | Request headers.
`query` | `map<string, string>` | No | `{}` | Yes: in query parameter values | Request query parameters.

### GRPCCall {#GRPCCall}

Only for services with [gRPC reflection](https://grpc.io/docs/guides/reflection/) support.

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`endpoint` | `string` | Yes | No | Yes | Server address
`method` | `string` | Yes | No | Yes | gRPC service and method.
`useServiceAccount` | `bool` | No | `false` | No | If `true`, the IAM token of the service account specified in the workflow settings will be added to request headers.
`body` | `string` | No | `""` | Yes | Request body.
`headers` | `map<string, string>` | No | `{}` | Yes: in header values | Request headers.

### YMQ {#YMQ}

Sending messages to the [{{ message-queue-full-name }}](../../../message-queue/) queue.

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`queueArn` | `string` | Yes | No | No | ARN of the queue.
`put` | [YmqPut](#YmqPut) | Yes | No | No | Configuring the `put` action to add messages to the queue.

#### YmqPut object {#YmqPut}

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`body` | `string` | No | `""` | Yes | Message body.

### YDS {#YDS}

Sending messages to the [{{ yds-full-name }}](../../../data-streams/) topic.

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`database` | `string` | Yes | No | No | Database ID.
`topic` | `string` | Yes | No | No | Topic ID.
`put` | `object` | Yes | [YdsPut](#YdsPut) | No | Configuring the `put` action to send messages to the data stream.

#### YdsPut object {#YdsPut}

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`body` | `string` | No | `""` | Yes | Message body.
`partitionKey` | `string` | No | `""` | Yes |  [Shard key](../../../data-streams/concepts/glossary.md#partition-key).

### YDBDocument {#YDBDocument}

Interacting with document tables in the [{{ ydb-full-name }}](../../../ydb/) database. The `get`, `put`, `update`, and `scan` fields are mutually exclusive: you can use only one of them.

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`database` | `string` | Yes | No | No | Database ID.
`tableName` | `string` | Yes | No | No | Table name.
`get` | [YdbDocumentGet](#YdbDocumentGet) | No | No | No | Configuring the `get` action to select an entry from the table.
`put` | [YdbDocumentPut](#YdbDocumentPut) | No | No | No | Configuring the `put` action to add an entry to the table.
`update` | [YdbDocumentUpdate](#YdbDocumentUpdate) | No | No | No | Configuring the `update` action to update an entry in the table.
`scan` | [YdbDocumentScan](#YdbDocumentScan) | No | No | No | Configuring the `scan` action to get a list of table entries.

#### YdbDocumentGet {#YdbDocumentGet}

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`key` | `string` | Yes | No | Yes | Primary key value for a database item.

#### YdbDocumentPut {#YdbDocumentPut}

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`item` | `string` | Yes | No | Yes | JSON-serialized data item to insert into a table.

#### YdbDocumentUpdate {#YdbDocumentUpdate}

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`key` | `string` | Yes | No | Yes | Primary key value for a database item.
`expression` | `string` | Yes | No | Yes | Expression to describe the updates to the attributes of a database item. For more information, see [UpdateExpression](../../../ydb/docapi/api-ref/actions/updateItem.md).
`expressionAttributeValues` | `string` | No | `""` | Yes | Values for attributes used in the expression. For more information, see [ExpressionAttributeValues](../../../ydb/docapi/api-ref/actions/updateItem.md).

#### YdbDocumentScan {#YdbDocumentScan}

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`limit` | `string` | No | No | Yes | Maximum number of items in the list
`exclusive_start_key` | `string` | No | No | Yes | Primary key value for a database item to start the search from.

### FunctionCall {#FunctionCall}

Invoking the [{{ sf-full-name }}](../../../functions/) function.

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`functionId` | `string` | Yes | No | No | Function ID.

### ContainerCall {#ContainerCall}

Invoking the [{{ serverless-containers-full-name }}](../../../serverless-containers/) container.

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`containerId` | `string` | Yes | No | No | Container ID.
`path` | `string` | No | `""` | Yes | Request path.
`method` | `enum` | No | `GET` | Yes | HTTP method of the request.
`body` | `string` | No | `""` | Yes | Request body.
`headers` | `map<string, string>` | No | `{}` | Yes: in header values | Request headers.
`query` | `map<string, string>` | No | `{}` | Yes: in query parameter values | Request query parameters.

### FoundationModelsCall {#FoundationModelsCall}

Integration with [{{ foundation-models-full-name }}](../../../foundation-models/). Currently, the only supported integration is the one with [{{ yagpt-full-name }}](../../../foundation-models/concepts/yandexgpt/index.md) for text generation.

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`modelUrl` | `string` | Yes | No | No | ID of the model to call.
`generate` | [FoundationModelsCallGenerate](#FoundationModelsCallGenerate) | Yes | No | No | Configuring the `generate` action to generate a text.

#### FoundationModelsCallGenerate object {#FoundationModelsCallGenerate}

The `json` and `messages` are mutually exclusive: you can either specify a JSON string or explicitly list the messages.

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`temperature` | `double` | No | `0` | No | With a higher temperature, you get a more creative and randomized response from the model. This parameter accepts values between 0 and 1, inclusive. 
`maxTokens` | `int64` | Yes | No | No | Maximum number of tokens to generate. Allows limiting the model's response if needed.
`json` | `string` | No | `""` | Yes | Context for the model, as a JSON string. For more information, see the `messages` field description in the [{{ foundation-models-name }}](../../../foundation-models/operations/yandexgpt/create-prompt.md#request) documentation.
`messages` | [FoundationModelsCallGenerateMessage](#FoundationModelsCallGenerateMessage)[] | No | `""` | No | Context for the model, as a list of input messages.

#### [FoundationModelsCallGenerateMessage](#FoundationModelsCallGenerateMessage) object

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`role` | `string` | Yes | No | Yes | Message sender ID. For more information, see [TextGeneration.completion](../../../foundation-models/text-generation/api-ref/TextGeneration/completion.md).
`text` | `string` | Yes | No | Yes | Message text. For more information, see [TextGeneration.completion](../../../foundation-models/text-generation/api-ref/TextGeneration/completion.md).

### ObjectStorage {#ObjectStorage}

Interacting with the {{ objstorage-full-name }} objects. The `put` and `get` fields are mutually exclusive: you can perform only one of these actions on an object.

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`bucket` | `string` | Yes | No | No | Bucket name.
`object` | `string` | Yes | No | Yes | Object name.
`put` | [ObjectStoragePut](#ObjectStoragePut) | No | No | No | Configuring the `put` action to add the object to the bucket.
`get` | `{}` | No | No | No | Configuring the `get` action to get the object from the bucket.

#### ObjectStoragePut object {#ObjectStoragePut}

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`content` | `string` | Yes | No | Yes | Object contents.

### Tracker {#Tracker}

Accessing the {{ tracker-full-name }} API
* The `oauth_token` and `service_account` fields are mutually exclusive.
* The `get_issue`, `create_issue`, `update_issue`, `list_issues`, `link_issues`, `update_issue_status`, `create_comment`, `update_comment`, and `list_comments` fields are mutually exclusive.

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`endpoint` | `string` | No | `api.tracker.yandex.net` | Yes | Host for calling the {{ tracker-full-name }} API.
`oauth_token` | `string` | No | No | Yes | [OAuth token](../../../iam/concepts/authorization/oauth-token.md) to be used for authorization when accessing the {{ tracker-short-name }} API.
`service_account` | `boolean` | No | No | No | You can use only the `true` value. If set, the [service account](../../../iam/concepts/users/service-accounts.md) specified in the [workflow](./workflow.md) settings will be used for authorization when accessing the {{ tracker-short-name }} API.
`organization` | [Organization](#tracker-organization) | Yes | No | No | Organization ID.
`get_issue` | [TrackerGetIssue](#trackergetissue) | No | No | No | Description of the action to get an issue.
`create_issue` | [TrackerCreateIssue](#trackercreateissue) | No | No | No | Description of the action to create an issue.
`update_issue` | [TrackerUpdateIssue](#trackerupdateissue) | No | No | No | Description of the action to update an issue.
`list_issues` | [TrackerListIssues](#trackerlistissues) | No | No | No | Description of the action to search for an issue.
`link_issues` | [TrackerLinkIssues](#trackerlinkissues) | No | No | No | Description of the action to add a link between issues.
`update_issue_status` | [TrackerUpdateIssueStatus](#trackerupdateissuestatus) | No | No | No | Description of the action to update an issue status.
`create_comment` | [TrackerCreateComment](#trackercreatecomment) | No | No | No | Description of the action to create a comment.
`update_comment` | [TrackerUpdateComment](#trackerupdatecomment) | No | No | No | Description of the action to update a comment.
`list_comments` | [TrackerListComments](#trackerlistcomments) | No | No | No | Description of the action to display comments on an issue.

#### Organization {#tracker-organization}

The `yandex_organization_id` and `cloud_organization_id` fields are mutually exclusive.

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`yandex_organization_id` | `string` | No | No | Yes | Organization ID in {{ ya-360 }}.
`cloud_organization_id` | `string` | No | No | Yes | [Organization](../../../organization/quickstart.md) ID in {{ org-full-name }}.

#### TrackerGetIssue {#trackergetissue}

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`key` | `string` | Yes | No | Yes | Issue key.

#### TrackerCreateIssue {#trackercreateissue}

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`queue` | `string` | Yes | No | Yes | Queue to create the issue in.
`title` | `string` | Yes | No | Yes | Issue title.
`parent` | `string` | No | No | Yes | Parent issue key.
`description` | `string` | No | No | Yes | Issue description.
`sprints` | `string` | No | No | Yes | One of more sprints. You can specify the value as a string or JSON array.
`type` | `string` | No | No | Yes | Issue type.
`priority` | `string` | No | No | Yes | Issue priority.
`followers` | `string` | No | No | Yes | One or more followers. You can specify the value as a string or JSON array.
`assignee` | `string` | No | No | Yes | Issue assignee.
`author` | `string` | No | No | Yes | Issue reporter.
`additional_properties` | `map[string]string` | No | No | Yes | Additional issue fields.

#### TrackerUpdateIssue {#trackerupdateissue}

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`key` | `string` | Yes | No | Yes | Issue key.
`title` | `string` | No | No | Yes | Issue title.
`parent` | `string` | No | No | Yes | Parent issue key.
`description` | `string` | No | No | Yes | Issue description.
`sprints` | [TrackerUpdateIssue.Action](#trackerupdateissue-action) | No | No | Yes | Linked sprints.
`type` | `string` | No | No | Yes | Issue type.
`priority` | `string` | No | No | Yes | Issue priority.
`followers` | [TrackerUpdateIssue.Action](#trackerupdateissue-action) | No | No | Yes | Followers in the issue.
`additional_properties` | [TrackerUpdateIssue.AdditionalProperties](#trackerupdateissue-additionalproperties) | No | No | Yes | Additional issue fields.

#### TrackerUpdateIssue.Action {#trackerupdateissue-action}

The `set_value`, `add_values_list`, `remove_values_list`, and `replace_values_map` fields are mutually exclusive.

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`set_value` | `string` | No | No | Yes | Replaces the issue field value. You can specify the value as a string or JSON array.
`add_values_list` | `string` | No | No | Yes | Adds one or more values to the issue field. You can specify the value as a string or JSON array.
`remove_values_list` | `string` | No | No | Yes | Deletes one or more values from the issue field. You can specify the value as a string or JSON array.
`replace_values_map` | [InterpolatableMap](#tracker-interpolatablemap) | No | No | No | Describes a list of field values to be replaced and their new values.

#### TrackerUpdateIssue.AdditionalProperties {#trackerupdateissue-additionalproperties}

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`pairs` | `map[string]`[TrackerUpdateIssue.Action](#trackerupdateissue-action) | No | No | Yes | Dictionary of pairs: the name of the additional field and the action to perform on it.

#### InterpolatableMap {#tracker-interpolatablemap}

The `json` and `plain_value` fields are mutually exclusive.

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`json` | `string` | No | No | Yes | Dictionary containing a JSON array of pairs: current and new values of fields.
`plain_value` | [MapValue](#tracker-mapvalue) | No | No | No | Dictionary containing an array of pairs: current and new values of fields as [MapValue](#tracker-mapvalue) objects.

#### MapValue {#tracker-mapvalue}

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`pairs` | `map[string]string` | Yes | No | Yes | Dictionary containing an array of pairs: current and new values of fields.

#### TrackerListIssues {#trackerlistissues}

The `queue`, `keys`, `filter`, and `query` fields are mutually exclusive.

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`page_size` | `string` | No | No | Yes | Maximum number of issues to be included in a response.
`page_number` | `string` | No | No | Yes | Page number in the issue list output.
`queue` | `string` | No | No | Yes | Queue to find issues in.
`keys` | `string` | No | No | Yes | Issue keys that need to be found. You can specify the value as a string or JSON array.
`filter` | [TrackerLinkIssues.SearchOptionsFilter](#trackerlistissues-searchoptionsfilter) | No | No | Yes | Issue search filter by field values.
`query` | `string` | No | No | Yes | Filter in the request language.

#### TrackerLinkIssues.SearchOptionsFilter {#trackerlistissues-searchoptionsfilter}

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`issue_properties` | `map[string]string` | Yes | No | Yes | Fields to search by and the required values.
`order` | `string` | No | No | Yes | The direction and field for sorting issues.

#### TrackerLinkIssues {#trackerlinkissues}

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`key` | `string` | Yes | No | Yes | Issue key.
`link_key` | `string` | Yes | No | Yes | Key of the issue you need to link to the issue specified in the `key` field.
`relationship` | `string` | Yes | No | Yes | Type of links between issues.

#### TrackerUpdateIssueStatus {#trackerupdateissuestatus}

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`key` | `string` | Yes | No | Yes | Key of the issue whose status you need to change.
`transition` | `string` | Yes | No | Yes | Transition ID.
`additional_properties` | [MapValue](#tracker-mapvalue) | No | No | Yes | Additional fields required for a transition.

#### TrackerCreateComment {#trackercreatecomment}

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`key` | `string` | Yes | No | Yes | Key of the issue to add a comment to.
`text` | `string` | Yes | No | Yes | Text of the comment.
`mentions` | `string` | No | No | Yes | Mentions by users. You can specify the value as a string or JSON array.

#### TrackerUpdateComment {#trackerupdatecomment}

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`id` | `string` | Yes | No | Yes | ID of the comment being updated.
`issue_key` | `string` | Yes | No | Yes | Key of the issue the comment relates to.
`text` | `string` | Yes | No | Yes | New comment text.

#### TrackerListComments {#trackerlistcomments}

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`key` | `string` | Yes | No | Yes | Issue key.
`last_comment_id` | `string` | No | No | Yes | Comment's `id` parameter value after which the requested page will begin.
`page_size` | `string` | No | No | Yes | Maximum number of comments per response.

### Postbox {#Postbox}

Sending emails with {{ postbox-full-name }}. The `simple` and `raw` fields are mutually exclusive.

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`fromAddress` | `string` | Yes | No | No | {{ postbox-name }} [address](../../../postbox/concepts/glossary.md#adress) to send emails from.<br/><br/>[Service account](../../../iam/concepts/users/service-accounts.md) specified in the [workflow](./workflow.md) settings and the address specified in this field must reside in the same [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).
`destination` | [Destination](#postbox-destination) | Yes | No | No | Object describing addresses of recipients.
`simple` | [SimpleMessage](#postbox-simplemessage) | No | No | No | Email that will be sent.
`raw` | [RawMessage](#postbox-rawmessage) | No | No | No | Email that will be sent.

#### Destination {#postbox-destination}

After templating, the field values must have this format: a@example.com, b@example.com` or `[a@example.com, b@example.com]`.

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`toAddresses` | `string` | Yes | No | Yes | Addresses of email recipients.
`ccAdresses` | `string` | No | No | Yes | Addresses of email copy recipients.

#### RawMessage {#postbox-rawmessage}

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`data` | `string` | Yes | No | Yes | Raw email type. For more information, see the [{{ postbox-name }} documentation](../../../postbox/aws-compatible-api/api-ref/send-email.md).

#### SimpleMessage {#postbox-simplemessage}

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`subject` | [MessageData](#postbox-messagedata) | Yes | No | No | Email subject.
`body` | [Body](#postbox-body) | Yes | No | No | Email text.

#### Body {#postbox-body}

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`text` | [MessageData](#postbox-messagedata) | Yes | No | No | Object in charge of displaying the email in mail clients without HTML support.
`html` | [MessageData](#postbox-messagedata) | Yes | No | No | Object in charge of displaying the email in mail clients with HTML support.

#### MessageData {#postbox-messagedata}

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`data` | `string` | Yes | No | Yes | Text.
`charset` | `UTF_8`\|<br/>`ISO_8859_1`\|<br/>`Shift_JIS` | Yes | No | No | Encoding:

## Control steps {#management-steps}

### Switch {#Switch}

Selecting the further execution path. Only one path can be selected: the one for which the condition first returns `true`. If all conditions have returned `false`, and no value is set in the `default` field, the run will be terminated with an error.

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`input` | `string` | No | [Overall state of the workflow](workflow.md#state) | Yes | A jq expression to filter the workflow state fed into the step.
`choices` | [Choice](#Choice)[] | Yes | No | No | List of possible further execution paths.
`default` | `string` | No | No | No | ID of the step to execute if none of the conditions specified in `choices` return `true`.

#### Choice object {#Choice}

Field name | Type | Required | Description
--- | --- | --- | ---
`condition` | `string` | Yes | Condition in the form of a jq expression that returns either `true` or `false` string.
`next` | `string` | Yes | ID of the step to execute if the condition returns `true`.

### Foreach {#Foreach}

Executes the sequence of steps specified in `do` on each input data item. Outputs are an array of execution results of the steps specified in `do`. In the `next` field in `do`, only steps listed in `do` can be specified. Read more about the [workflow state during the Foreach step](workflow.md#state-for-Foreach).

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`input` | `string` | Yes | No | Yes | A jq expression that forms an array of objects. If the result is not an array of objects, the run will be terminated with an error.
`output` | `string` | Yes | No | Yes | A jq expression that forms an object to contain the `foreach` output. If the result is not an object, the run will be terminated with an error.
`do` | [ForeachDo](#ForeachDo) | Yes | No | No | Sequence of steps to apply to each input data item.
`next` | `string` | No | No | No | ID of the next step.

#### ForeachDo object {#ForeachDo}

Field name | Type | Required | Description
--- | --- | --- | ---
`start` | `string` | Yes | ID of the step to start the execution from.
`steps` | `map<string, Step>` | Yes | Description of the steps. Object where key is the step ID, and value is the object describing the step parameters. The structure is similar to the `steps` field in the [high-level specification](#workflow).

### Parallel {#Parallel}

Executes multiple branches (sequences of steps) concurrently. Execution result is an object where key is the execution branch name, and value is the execution branch outputs. Read more about the [workflow state during the Parallel step](workflow.md#state-for-Parallel).

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`input` | `string` | No | [Overall state of the workflow](workflow.md#state) | Yes | A jq expression to filter the workflow state fed into the step.
`output` | `string` | No | Step output data | Yes | A jq expression to filter the step outputs added into the workflow state.
`branches` | `map<string,` [Branch](#Branch)`>` | Yes | No | No | Object containing description of execution branches. Key: branch ID; value: description of steps in the branch.
`next` | `string` | No | No | No | ID of the next step.

#### Branch object {#Branch}

Field name | Type | Required | Description
--- | --- | --- | ---
`start` | `string` | Yes | ID of the step to start off the branch execution.
`steps` | `map<string, Step>` | Yes | Description of steps in the execution branch. Object where key is the step ID, and value is the object describing the step parameters. The structure is similar to the `steps` field in the [high-level specification](#workflow).

### Success {#Success}

Successfully completes the workflow. If placed inside [Foreach](#Foreach) or [Parallel](#Parallel), terminates the whole run, not just its current branch.

### Fail {#Fail}

Terminates the workflow with an error. If placed inside [Foreach](#Foreach) or [Parallel](#Parallel), it will terminate the whole workflow, not just its current branch.

Field name | Type | Required | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | ---
`errorMessage` | `string` | Yes | Yes | Error message.

### NoOp {#NoOp}

This step does nothing. You may need it, e.g., to successfully complete a pipeline if the condition from the `default` field is met in [Switch](#Switch), or as a placeholder for one of the steps when prototyping the workflow.

Field name | Type | Required | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | ---
`output` | `string` | No | Yes | A jq expression to filter the step's output data added into the [workflow state](workflow.md#state).
`next` | `string` | No | No | ID of the next step.

## Specification example {#spec-example}

For the workflow covered by the YaWL specification below, execution is contingent upon input data (`input`).

Payload | Result
--- | ---
`{"final_action": "success"}` | `Success`
`{"final_action": "fail"}` | `fail now!` error
Other inputs | Error `code: STEP_NO_CHOICE_MATCHED, message: no condition is true, and there is no default`

{% cut "YaWL specification" %}

```yaml
yawl: "0.1"
start: parallel_step
steps:
  parallel_step:
    parallel:
      next: join_post_and_users
      branches:
        fetch_posts_branch:
          start: fetch_posts
          steps:
            fetch_posts:
              httpCall:
                url: https://jsonplaceholder.typicode.com/posts
                method: GET
                next: filter_posts
                output: '\({"posts": .})'
            filter_posts:
              functionCall:
                functionId: b09kpe9j2c5l********
                retryPolicy:
                  errorList:
                    - HTTP_CALL_502
                input: |-
                  \({
                    "posts": .posts,
                    "action": "filter"
                  })
        fetch_users_branch:
          start: fetch_users
          steps:
            fetch_users:
              httpCall:
                url: https://jsonplaceholder.typicode.com/users
                method: GET
                retryPolicy:
                  errorList:
                    - HTTP_CALL_500
                    - HTTP_CALL_502
                    - HTTP_CALL_429
                  backoffRate: 2.0
                  initialDelay: 2s
                  retryCount: 5
                output: '\({"users": .})'
  join_post_and_users:
    functionCall:
      next: crop_long_posts
      functionId: b09kpe9j2c5l5********
      input: |-
        \({
          "posts": .fetch_posts_branch.posts,
          "users": .fetch_users_branch.users,
          "action": "join"
        })
  crop_long_posts:
    foreach:
      next: grpc_call
      input: \(.user_posts)
      do:
        start: filter_long_posts
        steps:
          filter_long_posts:
            switch:
              choices:
                - condition: |-
                    .body | length > 160
                  next: call_crop_long_posts
              default:
                next: do_nothing
          call_crop_long_posts:
            containerCall:
              containerId: flh16b3vmu3n********
              body: |-
                \({
                  "user_post": .,
                  "action": "crop"
                })
          do_nothing:
            noOp:
              next: ymq_write
          ymq_write:
            ymq:
              put:
                body: |-
                  \(.)
              queueArn: "yrn:yc:ymq:{{ region-id }}:aoehdt6d6hbk********:test-queue"
              output: |-
                \({
                  "queue_res": .
                })
      output: |-
        \({
          "user_posts": .
        })
  grpc_call:
    grpcCall:
      useServiceAccount: true
      endpoint: 'serverless-functions.api.cloud.yandex.net:443'
      method: yandex.cloud.serverless.functions.v1.FunctionService/List
      body: |-
        \({
          "folder_id": "aoehdt6d6hbk********"
        })
      next: ydb_call
  ydb_call:
    ydbDocument:
      database: "/{{ region-id }}/aoedgvjds14c********/cc8dg7eqfuod********"
      update:
        key: |-
          \({
            "x": 123
          })
        expression: |-
          SET name = :name
        expressionAttributeValues: |-
          \({
            ":name": "myname1"
          })
      tableName: "doc-table"
      next: yagpt_call
  yagpt_call:
    foundationModelsCall:
      modelUrl: gpt://aoehdt6d6hbk********/yandexgpt/latest
      generate:
        maxTokens: 100
        messages:
          messages:
            - role: system
              text: "Define the language of this text"
            - role: user
              text: \(.posts.[0].body)
      next: yds_step
  yds_step:
    yds:
      topic: test-topic
      database: /{{ region-id }}/aoedgvjds14c********/cc8dg7eqfuod********
      put:
        body: "Hello world!"
        partitionKey: \(. | tostring | length)
      next: storage_step
  storage_step:
    objectStorage:
      bucket: werelaxe-public-bucket
      object: file
      put:
        content: \(.)
      next: final_parallel
  final_parallel:
    parallel:
      branches:
        wait_branch:
          start: wait_call
          steps:
            wait_call:
              functionCall:
                functionId: b09kpe9j2c5l********
                input: |-
                  \({
                    "action": "wait",
                    "delay": 10
                  })
        terminate_branch:
          start: terminate_switch
          steps:
            terminate_switch:
              switch:
                choices:
                  - condition: .final_action == "success"
                    next: success_step
                  - condition: .final_action == "fail"
                    next: fail_step
            success_step:
              success: {}
            fail_step:
              fail:
                errorMessage: "fail now!"
      output: \(.terminate_branch.fetch_posts_branch)
```

{% endcut %}
