```mermaid
flowchart BT
    managed-ytsaurus.auditor --> managed-ytsaurus.viewer
    managed-ytsaurus.viewer --> managed-ytsaurus.user
    managed-ytsaurus.user --> managed-ytsaurus.editor
    managed-ytsaurus.editor --> managed-ytsaurus.admin
```