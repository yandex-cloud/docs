```mermaid
flowchart BT
    backup.viewer --> backup.editor
    backup.user --> backup.editor
    backup.editor --> backup.admin
```