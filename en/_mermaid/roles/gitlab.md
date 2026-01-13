```mermaid
flowchart BT
    gitlab.auditor --> gitlab.viewer
    gitlab.viewer --> gitlab.editor
    gitlab.editor --> gitlab.admin
```