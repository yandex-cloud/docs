Specify a workflow ID to get a list of workflow executions:

```bash
yc serverless workflow execution list --workflow-id <workflow_ID>
```

Result:

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