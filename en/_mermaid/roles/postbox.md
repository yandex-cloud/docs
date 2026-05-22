```mermaid
%%{
  init: {
    "flowchart": { "defaultRenderer": "elk" }
  }
}%%
flowchart BT
    postbox.editor --> postbox.admin
    postbox.viewer --> postbox.editor
    postbox.sender --> postbox.editor
    postbox.auditor --> postbox.viewer
    postbox.messages.reader --> postbox.admin
    postbox.statistics.reader --> postbox.admin
```