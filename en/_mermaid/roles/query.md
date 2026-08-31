```mermaid
%%{
  init: {
    "flowchart": { "defaultRenderer": "elk" },
    "elk": { "nodePlacementStrategy": "SIMPLE" }
  }
}%%
flowchart BT
    yq.editor --> yq.admin
    yq.invoker --> yq.editor
    yq.viewer --> yq.editor
    yq.auditor --> yq.viewer
```
