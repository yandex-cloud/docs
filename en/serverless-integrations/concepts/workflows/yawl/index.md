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

# Overview

## Workflow {#workflow}

For the workflow JSON schema, visit our [GitHub repo](https://raw.githubusercontent.com/yandex-cloud/json-schema-store/refs/heads/master/serverless/workflows/yawl.json).

Field name | Type | Required | Description
--- | --- | --- | ---
`yawl` | `string` | Yes | Specification language version. The possible value is `1.0`.
`start` | `string` | Yes | ID of the [step](#step) to start off the workflow execution.
`defaultRetryPolicy` | [RetryPolicy](#retrypolicy) | No | Retry policy applied by default to any step throwing an error during execution.
`steps` | `map<string, Step>` | Yes | Description of workflow steps. Object where key is the step ID selected by the user, and value is the object describing the step parameters.

## Step object {#step}

Field name | Type | Required | Description
--- | --- | --- | ---
`title` | `string` | No | Step name.
`description` | `string` | No | Step description.
`<step_type>` | string([FunctionCall](integration/functioncall.md)\|<br/>[ContainerCall](integration/containercall.md)\|<br/>[HTTPCall](integration/httpcall.md)\|<br/>[GRPCCall](integration/grpccall.md)\|<br/>[YDBDocument](integration/ydbdocument.md)\|<br/>[YDS](integration/yds.md)\|<br/>[YMQ](integration/ymq.md)\|<br/>[FoundationModelsCall](integration/foundationmodelscall.md)\|<br/>[ObjectStorage](integration/objectstorage.md)\|<br/>[Tracker](integration/tracker.md)\|<br/>[Postbox](integration/postbox.md)\|<br/>[Switch](management/switch.md)\|<br/>[Foreach](management/foreach.md)\|<br/>[Parallel](management/parallel.md)\|<br/>[Success](management/success.md)\|<br/>[Fail](management/fail.md)\|<br/>[NoOp](management/noop.md)\|<br/>[Wait](management/wait.md)) | Yes | Step specification. Possible parameters depend on selected `<step_type>`.

## Integration steps {#integration-steps}

* [HTTPCall](integration/httpcall.md)
* [GRPCCall](integration/grpccall.md)
* [YMQ](integration/ymq.md)
* [YDS](integration/yds.md)
* [YDBDocument](integration/ydbdocument.md)
* [FunctionCall](integration/functioncall.md)
* [ContainerCall](integration/containercall.md)
* [FoundationModelsCall](integration/foundationmodelscall.md)
* [ObjectStorage](integration/objectstorage.md)
* [Tracker](integration/tracker.md)
* [Postbox](integration/postbox.md)

### Common fields {#common}

The fields described herein are available for all integration steps.

Field name | Type | Required | Default value | Description
--- | --- | --- | --- | ---
`input` | `string` | No | [Overall state of the workflow](../workflow.md#state) | A jq expression to filter the workflow state fed into the step.
`output` | `string` | No | Step outputs | A jq expression to filter the step outputs added into the workflow state.
`next` | `string` | No | No | ID of the next step.
`retryPolicy` | [RetryPolicy](#retrypolicy) | No | `defaultRetryPolicy`, if set on the [workflow](#workflow) level | Retry policy applied if a step throws an error during execution.
`timeout` | `Duration` | No | 15 minutes | Maximum step execution time.

### RetryPolicy object {#retrypolicy}

Field name | Type | Required | Default value | Threshold value | Description
--- | --- | --- | --- | --- | ---
`errorList` | `WorkflowError[]` | Yes | `[]` | — | List of errors for which the step will be retried. For more information, see [{#T}](../execution.md#errors).
`errorListMode` | `INCLUDE/EXCLUDE` | No | `INCLUDE` | — | Error selection mode: `INCLUDE` to retry on errors listed in `error_list`; `EXCLUDE` to retry on any error other than those listed in `error_list`.
`initialDelay` | `Duration` | No | `1s` | `1s` | Initial value for a delay between retries.
`backoffRate` | `double` | No | `1.0` | `1.0` | Multiplier for time between each next retry.
`retryCount` | `int` | No | `0` | `100` | Maximum number of retries.
`maxDelay` | `Duration` | No | `1s` | `1h` | Maximum delay between retries.

## Control steps {#management-steps}

* [Switch](management/switch.md)
* [Foreach](management/foreach.md)
* [Parallel](management/parallel.md)
* [Success](management/success.md)
* [Fail](management/fail.md)
* [NoOp](management/noop.md)
* [Wait](management/wait.md)

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
