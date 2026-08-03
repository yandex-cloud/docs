```mermaid
%%{
  init: {
    "flowchart": { "defaultRenderer": "elk" },
    "elk": { "nodePlacementStrategy": "NETWORK_SIMPLEX" }
  }
}%%
flowchart BT
    cloud-registry.auditor --> cloud-registry.viewer
    cloud-registry.viewer --> cloud-registry.editor
    cloud-registry.viewer --> cloud-registry.artifacts.scanner
    cloud-registry.artifacts.pusher --> cloud-registry.editor
    cloud-registry.artifacts.scanner --> cloud-registry.editor
    cloud-registry.artifacts.puller --> cloud-registry.artifacts.pusher
    cloud-registry.editor --> cloud-registry.admin
```
