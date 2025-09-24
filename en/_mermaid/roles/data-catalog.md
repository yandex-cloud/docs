```mermaid
flowchart BT
    data-catalog.user --> data-catalog.dataConsumer
    data-catalog.viewer --> data-catalog.dataConsumer
    data-catalog.dataConsumer --> data-catalog.dataSteward
    data-catalog.auditor --> data-catalog.viewer
    data-catalog.viewer --> data-catalog.editor
    data-catalog.editor --> data-catalog.admin    
```