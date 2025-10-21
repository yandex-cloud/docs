```mermaid
flowchart BT
    serverless-containers.editor --> serverless-containers.admin
    serverless-containers.containerInvoker --> serverless-containers.editor
    serverless-containers.viewer --> serverless-containers.editor
    serverless-containers.auditor --> serverless-containers.viewer
```