```mermaid
flowchart BT
    lockbox.editor --> lockbox.admin
    lockbox.payloadViewer ---> lockbox.admin
    lockbox.viewer --> lockbox.editor
    lockbox.auditor --> lockbox.viewer
```