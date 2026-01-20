```mermaid
flowchart BT
    ai.editor --> ai.admin
    ai.viewer --> ai.editor
    ai.auditor --> ai.viewer
    ai.translate.user --> ai.editor
```