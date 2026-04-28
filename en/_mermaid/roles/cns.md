```mermaid
flowchart BT
    notifications.editor --> notifications.admin
    notifications.viewer --> notifications.editor
    notifications.publisher --> notifications.editor
    notifications.auditor --> notifications.viewer
```