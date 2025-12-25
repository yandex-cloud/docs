```mermaid
flowchart BT
    schema-registry.auditor --> schema-registry.viewer
    schema-registry.viewer --> schema-registry.editor
    schema-registry.editor --> schema-registry.admin
```