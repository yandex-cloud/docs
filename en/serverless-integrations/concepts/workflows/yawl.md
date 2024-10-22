# YaWL specification

## Workflow {#workflow}

For the workflow JSON schema, visit our [GitHub repo](https://raw.githubusercontent.com/yandex-cloud/json-schema-store/refs/heads/master/serverless/workflows/yawl.json).

Field name | Type | Required | Description
--- | --- | --- | ---
`yawl` | `string` | Yes | Specification language version. Possible values: `1.0`.
`start` | `string` | Yes | ID of the [step](#step) to start off the workflow execution.
`defaultRetryPolicy` | [RetryPolicy](#RetryPolicy) | No | Retry policy applied by default to all steps if a steps throws an error during execution.
`steps` | `map<string, Step>` | Yes | Description of workflow steps. Object where key is the step ID selected by the user, and value is the object describing the step parameters.

## Step object {#Step}

Field name | Type | Required | Description
--- | --- | --- | ---
`title` | `string` | No | Step name.
`description` | `string` | No | Step description.
`<step_type>` | string([FunctionCall](#FunctionCall)\|<br/>[ContainerCall](#ContainerCall)\|<br/>[HTTPCall](#HTTPCall)\|<br/>[GRPCCall](#GRPCCall)\|<br/>[YDBDocument](#YDBDocument)\|<br/>[YDS](#YDS)\|<br/>[YMQ](#YMQ)\|<br/>[FoundationModelsCall](#FoundationModelsCall)\|<br/>[ObjectStorage](#ObjectStorage)\|<br/>[Switch](#Switch)\|<br/>[Foreach](#Foreach)\|<br/>[Parallel](#Parallel)\|<br/>[Success](#Success)\|<br/>[Fail](#Fail)\|<br/>[NoOp](#NoOp)) | Yes | Step specification. Possible parameters depend on the selected `<step_type>`.

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
`errorList` | `[]WorkflowError` | Yes | `[]` | List of errors for which the step will be retried. For more information, see [{#T}](execution.md#errors).
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
`endpoint` | `string` | Yes | No | Yes | Server address.
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

Interacting with document tables in the [{{ ydb-full-name }}](../../../ydb/) database. The `get`, `put`, and `update` fields are mutually exclusive: you can use only one of them.

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`database` | `string` | Yes | No | No | Database ID.
`tableName` | `string` | Yes | No | No | Table name.
`get` | [YdbDocumentGet](#YdbDocumentGet) | No | No | No | Configuring the `get` action to select entries from the table.
`put` | [YdbDocumentPut](#YdbDocumentPut) | No | No | No | Configuring the `put` action to add entries to the table.
`update` | [YdbDocumentUpdate](#YdbDocumentUpdate) | No | No | No | Configuring the `update` action to update entries in the table.

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
`json` | `string` | No | `""` | Yes | Context for the model, as a JSON string. For more information, see the `messages` field description in the [{{ foundation-models-name }} documentation](../../../foundation-models/operations/yandexgpt/create-prompt.md#request).
`messages` | [][FoundationModelsCallGenerateMessage](#FoundationModelsCallGenerateMessage) | No | `""` | No | Context for the model, as a list of input messages.

#### [FoundationModelsCallGenerateMessage](#FoundationModelsCallGenerateMessage) object

Field name | Type | Required | Default value | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`role` | `string` | Yes | No | Yes | Message sender ID. For more information, see [TextGeneration.completion](../../../foundation-models/text-generation/api-ref/TextGeneration/completion.md).
`text` | `string` | Yes | No | Yes | Message text. For more information, see [TextGeneration.completion](../../../foundation-models/text-generation/api-ref/TextGeneration/completion.md).

### ObjectStorage {#ObjectStorage}

Interacting with the {{ objstorage-full-name }} objects. The `put` and `get` fields are mutually exclusive: you can perform only one action on an object.

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

## Control steps {#management-steps}

### Switch {#Switch}

Selecting the further execution path. Only one path can be selected: the one for which the condition first returns `true`. If all conditions evaluate to `false` and no value set for the `default` field, the run will be terminated with an error.

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
`output` | `string` | No | Step outputs | Yes | A jq expression to filter the step outputs added into the workflow state.
`branches` | `map<string,` [Branch](#Branch)`>` | Yes | No | No | Object containing description of execution branches. Key: branch ID; value: description of steps in the branch.
`next` | `string` | No | No | No | ID of the next step.

#### Branch object {#Branch}

Field name | Type | Required | Description
--- | --- | --- | ---
`start` | `string` | Yes | ID of the step to start off the branch execution.
`steps` | `map<string, Step>` | Yes | Description of steps in the execution branch. Object where key is the step ID, and value is the object describing the step parameters. The structure is similar to the `steps` field in the [high-level specification](#workflow).

### Success {#Success}

Successfully completes the workflow run. If placed inside [Foreach](#Foreach) or [Parallel](#Parallel), terminates the whole run, not just its current branch.

### Fail {#Fail}

Terminates the workflow run with an error. If placed inside [Foreach](#Foreach) or [Parallel](#Parallel), terminates the whole run, not just its current branch.

Field name | Type | Required | [Templating](templating.md) is supported | Description
--- | --- | --- | --- | ---
`error` | `string` | Yes | Yes | Error message.

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
Other inputs | `code: STEP_NO_CHOICE_MATCHED, message: no condition is true, and there is no default` error

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
