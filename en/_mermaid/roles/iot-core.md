```mermaid
flowchart BT
    iot.registries.writer --> iot.editor
    iot.viewer --> iot.editor
    iot.devices.writer --> iot.editor
    iot.auditor --> iot.viewer
```