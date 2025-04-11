---
title: Спецификация YaWL в {{ sw-full-name }}
description: В статье описана спецификация YaWL в {{ sw-name }}.
keywords:
  - workflows
  - workflow
  - воркфлоу
  - рабочий процесс
  - спецификация YaWL
---

# Обзор

## Рабочий процесс {#workflow}

JSON-схему рабочего процесса см. в [репозитории на GitHub](https://raw.githubusercontent.com/yandex-cloud/json-schema-store/refs/heads/master/serverless/workflows/yawl.json).

Имя поля | Тип | Обязательное | Описание
--- | --- | --- | ---
`yawl` | `string` | Да | Версия языка спецификации. Возможные значения: `1.0`.
`start` | `string` | Да | Идентификатор [шага](#step), с которого начнется выполнение рабочего процесса.
`defaultRetryPolicy` | [RetryPolicy](#retrypolicy) | Нет | Политика повторных попыток, которая по умолчанию применяется для всех шагов, если во время выполнения шага возникла ошибка.
`steps` | `map<string, Step>` | Да | Описание шагов рабочего процесса. Объект, где ключ — выбранный пользователем идентификатор шага, а значение — объект, который описывает параметры шага.

## Объект Step {#step}

Имя поля | Тип | Обязательное | Описание
--- | --- | --- | ---
`title` | `string` | Нет | Название шага.
`description` | `string` | Нет | Описание шага.
`<step_type>` | string([FunctionCall](integration/functioncall.md)\|<br/>[ContainerCall](integration/containercall.md)\|<br/>[HTTPCall](integration/httpcall.md)\|<br/>[GRPCCall](integration/grpccall.md)\|<br/>[YDBDocument](integration/ydbdocument.md)\|<br/>[YDS](integration/yds.md)\|<br/>[YMQ](integration/ymq.md)\|<br/>[FoundationModelsCall](integration/foundationmodelscall.md)\|<br/>[ObjectStorage](integration/objectstorage.md)\|<br/>[Disk](integration/disk.md)\|<br/>[Tracker](integration/tracker.md)\|<br/>[Postbox](integration/postbox.md)<br/>[Workflow](integration/workflow.md)\|<br/>[Switch](management/switch.md)\|<br/>[Foreach](management/foreach.md)\|<br/>[Parallel](management/parallel.md)\|<br/>[Success](management/success.md)\|<br/>[Fail](management/fail.md)\|<br/>[NoOp](management/noop.md)\|<br/>[Wait](management/wait.md)\|<br/>[While](management/while.md)) | Да | Спецификация шага. Набор возможных параметров зависит от выбранного `<step_type>`.

## Интеграционные шаги {#integration-steps}

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
* [Workflow](integration/workflow.md)
* [Disk](integration/disk.md)

### Общие поля {#common}

Поля, описанные в этом разделе, доступны для всех интеграционных шагов.

Имя поля | Тип | Обязательное | Значение по умолчанию | Описание
--- | --- | --- | --- | ---
`input` | `string` | Нет | [Полное состояние рабочего процесса](../workflow.md#state) | jq-выражение, фильтрующее состояние рабочего процесса, которое передается в шаг.
`output` | `string` | Нет | Выходные данные шага | jq-выражение, фильтрующее выходные данные шага, которые добавляются в состояние рабочего процесса.
`next` | `string` | Нет | Нет | Идентификатор следующего шага.
`retryPolicy` | [RetryPolicy](#retrypolicy) | Нет | `defaultRetryPolicy`, если задана на уровне [рабочего процесса](#workflow) | Политика повторных попыток, которая применяется, если во время выполнения шага возникла ошибка.
`timeout` | `Duration` | Нет | 15 минут | Максимальное время выполнения шага.
`catch` | [CatchRule[]](#catchrule) | Нет | `[]` | Правила перехода по ошибкам, возникшим во время выполнения шага. Правила применяются последовательно после применения политики повторных попыток (`retryPolicy`).

### Объект RetryPolicy {#retrypolicy}

Имя поля | Тип | Обязательное | Значение по умолчанию | Предельное значение | Описание
--- | --- | --- | --- | --- | ---
`errorList` | `WorkflowError[]` | Да | `[]` | — | Список ошибок, для которых будут сделаны повторные попытки выполнения шага. Подробнее см. [{#T}](../execution.md#errors).
`errorListMode` | `INCLUDE/EXCLUDE` | Нет | `INCLUDE` | — | Режим выбора ошибок. `INCLUDE` — делать повторные попытки для ошибок, указанных в `error_list`, `EXCLUDE` — делать повторные попытки для всех ошибок, кроме указанных в `error_list`.
`initialDelay` | `Duration` | Нет | `1s` | `1s` | Начальное значение задержки между попытками.
`backoffRate` | `double` | Нет | `1.0` | `1.0` | Число, на которое умножается время между каждой последующей попыткой.
`retryCount` | `int` | Нет | `0` | `100` | Максимальное количество повторных попыток.
`maxDelay` | `Duration` | Нет | `1s` | `1h` | Максимальная задержка между повторными попытками.

### Объект CatchRule {#catchrule}

Имя поля | Тип | Обязательное | Значение по умолчанию | Предельное значение | Описание
--- | --- | --- | --- |---| ---
`errorList` | `WorkflowError[]` | Да | `[]` | — | Список ошибок, для которых применяется правило перехода. Подробнее см. [{#T}](../execution.md#errors).
`errorListMode` | `INCLUDE/EXCLUDE` | Нет | `INCLUDE` | — | Режим выбора ошибок. `INCLUDE` — правило перехода применяется для ошибок, указанных в `error_list`, `EXCLUDE` — правило перехода применяется для всех ошибок, кроме указанных в `error_list`.
`output` | `string` | Да | Нет | — | jq-выражение, фильтрующее выходные данные шага, которые добавляются в состояние рабочего процесса. Входные данные для фильтрации — объект типа [ErrorInfo](#errorinfo). Если во время выполнения шага произошла ошибка, для которой задано правило перехода (`catch`), jq-выражение, указанное в поле `output` всего шага, не применяется.
`next` | `string` | Да | Нет | — | Идентификатор следующего шага.

### Объект ErrorInfo {#errorinfo}

Имя поля | Тип | Описание
--- | --- | ---
`error` | `WorkflowError` | Тип ошибки.
`message` | `string` | Текстовое сообщение ошибки.

## Управляющие шаги {#management-steps}

* [Switch](management/switch.md)
* [Foreach](management/foreach.md)
* [Parallel](management/parallel.md)
* [Success](management/success.md)
* [Fail](management/fail.md)
* [NoOp](management/noop.md)
* [Wait](management/wait.md)
* [While](management/while.md)

## Пример спецификации {#spec-example}

Рабочий процесс, YaWL-спецификация для которого приведена ниже, выполняется по-разному в зависимости от входных данных (`input`).

Входные данные | Результат выполнения
--- | ---
`{"final_action": "success"}` | `Success`
`{"final_action": "fail"}` | Ошибка `fail now!`
Другие входные данные | Ошибка `code: STEP_NO_CHOICE_MATCHED, message: no condition is true, and there is no default`

{% cut "Спецификация YaWL" %}

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
