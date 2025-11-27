```mermaid
flowchart BT
    managed-trino.auditor --> managed-trino.viewer
    managed-trino.viewer --> managed-trino.user
    managed-trino.user --> managed-trino.editor
    managed-trino.editor --> managed-trino.admin
    managed-trino.integrationProvider["`managed-trino.
    integrationProvider`"]
```