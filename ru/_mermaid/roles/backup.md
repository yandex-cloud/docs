```mermaid
%%{
  init: {
    "flowchart": { "defaultRenderer": "elk" },
    "elk": { "nodePlacementStrategy": "SIMPLE" }
  }
}%%
flowchart BT
    backup.auditor --> backup.viewer
    backup.auditor --> backup.user
    backup.viewer --> backup.editor
    backup.user --> backup.editor
    backup.editor --> backup.admin
```
