Получите список запусков рабочего процесса, указав идентификатор рабочего процесса:

```bash
yc serverless workflow execution list --workflow-id <идентификатор_рабочего_процесса>
```

Результат:

```text
executions:
  - id: dfq...e78
    workflow_id: dfqud9cbc4k5********
    status: FINISHED
    started_at: "2025-03-10T15:54:44.304781814Z"
    duration: 1.070697344s
  ...
  - id: dfq...4d5
    workflow_id: dfqud9cbc4k5********
    status: FINISHED
    started_at: "2025-03-10T15:05:19.982768956Z"
    duration: 0.971907165s
```