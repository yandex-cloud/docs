```mermaid
%%{
  init: {
    "flowchart": { "defaultRenderer": "elk" },
    "elk": { "nodePlacementStrategy": "SIMPLE" }
  }
}%%
flowchart BT
    serverless.workflows.editor --> serverless.workflows.admin
    serverless.workflows.executor --> serverless.workflows.editor
    serverless.workflows.viewer --> serverless.workflows.editor
    serverless.workflows.auditor --> serverless.workflows.viewer
```
