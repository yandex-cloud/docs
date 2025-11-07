```mermaid
flowchart BT
    serverless.eventrouter.editor --> serverless.eventrouter.admin
    serverless.eventrouter.viewer --> serverless.eventrouter.editor
    serverless.eventrouter.supplier --> serverless.eventrouter.editor
    serverless.eventrouter.auditor --> serverless.eventrouter.viewer
```