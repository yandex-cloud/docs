```mermaid
flowchart BT
    ai.editor --> ai.admin
    ai.viewer --> ai.editor
    ai.auditor --> ai.viewer
    ai.vision.user --> ai.editor
```