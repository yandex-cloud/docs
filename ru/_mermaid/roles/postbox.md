```mermaid
flowchart BT
    postbox.editor --> postbox.admin
    postbox.viewer --> postbox.editor
    postbox.sender --> postbox.editor
    postbox.auditor --> postbox.viewer
```