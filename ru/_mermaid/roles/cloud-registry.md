```mermaid
flowchart BT
    cloud-registry.editor --> cloud-registry.admin
    cloud-registry.artifacts.puller --> cloud-registry.editor
    cloud-registry.artifacts.pusher --> cloud-registry.editor
    cloud-registry.viewer --> cloud-registry.editor
    cloud-registry.auditor --> cloud-registry.viewer
```