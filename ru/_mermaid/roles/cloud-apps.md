```mermaid
%%{
  init: {
    "flowchart": { "defaultRenderer": "elk" }
  }
}%%
flowchart BT
    cloudapps.editor --> cloudapps.admin
    cloudapps.viewer --> cloudapps.editor
    cloudapps.auditor --> cloudapps.viewer
```