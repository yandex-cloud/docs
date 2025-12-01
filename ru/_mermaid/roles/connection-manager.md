```mermaid
flowchart BT
    connection-manager.auditor["`connection-manager.
    auditor`"] --> connection-manager.viewer
    connection-manager.viewer --> connection-manager.editor
    connection-manager.editor --> connection-manager.admin
    connection-manager.user --> connection-manager.editor
```